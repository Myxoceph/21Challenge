/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day_10                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: abakirca <ahmetbakircan@gmail.com>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*                                                     #+#    #+#             */
/*   Created: 2026/01/02 19:48:54 by abakirca         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

module challenge::day_10
{
	use std::string::{String, utf8};

	#[test_only]
	use std::unit_test::assert_eq;

	public struct Task has copy, drop
	{
		title: String,
		reward: u64,
		status: TaskStatus,
	}

	public enum TaskStatus has copy, drop
	{
		Open,
		Completed,
	}

	public fun is_open(task: &Task): bool
	{
		if (task.status == TaskStatus::Open)
			true
		else
			false
	}

	public fun new_task(title: String, reward: u64): Task
	{
		Task
		{
			title,
			reward,
			status: TaskStatus::Open,
		}
	}

	public fun complete_task(task: &mut Task)
	{
		task.status = TaskStatus::Completed;
	}

	public fun get_reward(task: &Task): u64
	{
		task.reward
	}

	fun change_reward(task: &mut Task, new_reward: u64)
	{
		task.reward = new_reward;
	}

	public fun change_allow_reward(task: &mut Task, new_reward: u64)
	{
		change_reward(task, new_reward);
		complete_task(task);
	}

	#[test]
	public fun test_complete_task()
	{
		let mut task = new_task(utf8(b"Find the Holy Grail"), 300);
		assert_eq!(is_open(&task), true);
		change_allow_reward(&mut task, 500);
		assert_eq!(is_open(&task), false);
	}
}

module challenge::day_10_tests
{
	use challenge::day_10::{new_task, is_open, complete_task, change_reward, get_reward};
	use std::string::utf8;
	#[test_only]
	use std::unit_test::assert_eq;

	#[test]
	public fun test_complete_task()
	{
		let mut task = new_task(utf8(b"Find the Holy Grail"), 300);
		assert_eq!(is_open(&task), true);
		complete_task(&mut task);
		assert_eq!(is_open(&task), false);
	}

	#[test]
	public fun test_change_reward()
	{
		let mut task = new_task(utf8(b"Collect 100 Herbs"), 150);
		assert_eq!(get_reward(&task), 150);
		change_reward(&mut task, 200); // cannot do this because change_reward is not public
		assert_eq!(get_reward(&task), 200);
	}
}
