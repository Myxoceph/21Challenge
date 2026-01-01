/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day_08                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: abakirca <ahmetbakircan@gmail.com>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*                                                     #+#    #+#             */
/*   Created: 2026/01/01 19:03:55 by abakirca         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

module challenge::day_08
{
	use std::string::{String, utf8};

	#[test_only]
	use std::unit_test::assert_eq;

	public struct Task has copy, drop
	{
		title: String,
		reward: u64,
		done: bool,
	}

	public fun new_task(title: String, reward: u64): Task
	{
		Task
		{
			title,
			reward,
			done: false,
		}
	}

	#[test]
	public fun test_task()
	{
		let task = new_task(utf8(b"Defeat Femto"), 1000);
		assert_eq!(task.title, utf8(b"Defeat Femto"));
		assert_eq!(task.reward, 1000);
		assert_eq!(task.done, false);
	}
}
