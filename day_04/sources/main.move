/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day_04                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: abakirca <ahmetbakircan@gmail.com>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*                                                     #+#    #+#             */
/*   Created: 2025/12/27 22:55:18 by abakirca         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

module challenge::day_04
{
	use std::string::{String, utf8};

	#[test_only]
	use std::unit_test::assert_eq;

	public struct Habit has copy, drop
	{
		name: String,
		completed: bool,
	}

	public fun new_habit(name: String): Habit
	{
		Habit
		{
			name,
			completed: false,
		}
	}

	public struct HabitList has drop
	{
		habits: vector<Habit>,
	}

	public fun empty_list(): HabitList
	{
		HabitList
		{
			habits: vector::empty<Habit>(),
		}
	}

	public fun add_habit(list: &mut HabitList, habit: Habit)
	{
		vector::push_back(&mut list.habits, habit);
	}

	public fun remove_habit_last(list: &mut HabitList)
	{
		vector::pop_back(&mut list.habits);
	}

	#[test]
	public fun test_habit_list()
	{
		let mut habit_list: HabitList = empty_list();
		let habit1: Habit = new_habit(utf8(b"Learning Move"));
		let habit2: Habit = new_habit(utf8(b"Writing tests"));

		add_habit(&mut habit_list, move habit1);
		add_habit(&mut habit_list, move habit2);

		// let habit3 = habit1; Can't use habit1 here because it has been moved

		assert_eq!(vector::length(&habit_list.habits), 2);
		assert_eq!(vector::borrow(&habit_list.habits, 0).name, utf8(b"Learning Move"));
		assert_eq!(vector::borrow(&habit_list.habits, 1).name, utf8(b"Writing tests"));

		remove_habit_last(&mut habit_list);

		assert_eq!(vector::length(&habit_list.habits), 1);
	}
}
