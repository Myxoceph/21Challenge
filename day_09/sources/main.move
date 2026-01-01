/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day_09                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: abakirca <ahmetbakircan@gmail.com>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*                                                     #+#    #+#             */
/*   Created: 2026/01/01 19:12:45 by abakirca         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

module challenge::day_09
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

	#[test]
	public fun test_task_open()
	{
		let task = new_task(utf8(b"Defeat Femto"), 1000);

		assert_eq!(task.title, utf8(b"Defeat Femto"));
		assert_eq!(task.reward, 1000);
		assert_eq!(is_open(&task), true);
	}

	#[test]
	public fun test_task_completed()
	{
		let completed_task = Task
		{
			title: utf8(b"Rescue Casca"),
			reward: 500,
			status: TaskStatus::Completed,
		};

		assert_eq!(completed_task.title, utf8(b"Rescue Casca"));
		assert_eq!(completed_task.reward, 500);
		assert_eq!(is_open(&completed_task), false);
	}
}
