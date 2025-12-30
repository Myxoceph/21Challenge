/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day_07                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: abakirca <ahmetbakircan@gmail.com>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*                                                     #+#    #+#             */
/*   Created: 2025/12/30 23:47:28 by abakirca         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

module challenge::day_07
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

	public fun complete_habit(list: &mut HabitList, index: u64)
	{
		let length = vector::length(&list.habits);
		if (index < length)
		{
			let habit_ref = vector::borrow_mut(&mut list.habits, index);
			habit_ref.completed = true;
		}
		else
		{
			// Handle error: index out of bounds
			// For now, we will do nothing.
		}
	}

	public fun make_habit(name_bytes: vector<u8>): Habit
	{
		let name: String = utf8(name_bytes);
		new_habit(name)
	}

	#[test]
	public fun test_add_habits()
	{
		let mut habit_list: HabitList = empty_list();
		let habit1: Habit = make_habit(b"Writing Tests");
		let habit2: Habit = make_habit(b"Learning Move");

		add_habit(&mut habit_list, move habit1);
		add_habit(&mut habit_list, move habit2);

		assert_eq!(vector::length(&habit_list.habits), 2);
	}

	#[test]
	public fun test_complete_habit()
	{
		let mut habit_list: HabitList = empty_list();
		let habit: Habit = make_habit(b"Doing some coding");

		add_habit(&mut habit_list, move habit);
		complete_habit(&mut habit_list, 0);

		let completed_habit = vector::borrow(&habit_list.habits, 0);

		assert_eq!(completed_habit.completed, true);
	}

}	
