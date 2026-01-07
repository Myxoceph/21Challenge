/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day_13                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: abakirca <ahmetbakircan@gmail.com>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*                                                     #+#    #+#             */
/*   Created: 2026/01/07 23:33:49 by abakirca         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

module challenge::day_13
{
	use std::vector;
	use std::string::String;
	use std::option::{Self, Option};

	// Copy from day_12: All structs and functions
	public enum TaskStatus has copy, drop {
		Open,
		Completed,
	}

	public struct Task has copy, drop {
		title: String,
		reward: u64,
		status: TaskStatus,
	}

	public struct TaskBoard has drop {
		owner: address,
		tasks: vector<Task>,
	}

	public fun new_task(title: String, reward: u64): Task {
		Task {
			title,
			reward,
			status: TaskStatus::Open,
		}
	}

	public fun new_board(owner: address): TaskBoard {
		TaskBoard {
			owner,
			tasks: vector::empty(),
		}
	}

	public fun add_task(board: &mut TaskBoard, task: Task) {
		vector::push_back(&mut board.tasks, task);
	}

	public fun find_task_by_title(board: &TaskBoard, title: &String): Option<u64> {
		let len = vector::length(&board.tasks);
		let mut i = 0;
		while (i < len) {
			let task = vector::borrow(&board.tasks, i);
			if (*&task.title == *title) {
				return option::some(i)
			};
			i = i + 1;
		};
		option::none()
	}

	public fun total_reward(board: &TaskBoard): u64
	{
		let len = vector::length(&board.tasks);
		let mut i = 0;
		let mut total = 0;
		while (i < len)
		{
			let task = vector::borrow(&board.tasks, i);
			total = total + task.reward;
			i = i + 1;
		};
		total
	}

	public fun completed_count(board: &TaskBoard): u64
	{
		let len = vector::length(&board.tasks);
		let mut i = 0;
		let mut count = 0;
		while (i < len) 
		{
			let task = vector::borrow(&board.tasks, i);
			if (task.status == TaskStatus::Completed)
				count = count + 1;
			i = i + 1;
		};
		count
	}
}
