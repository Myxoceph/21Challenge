/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day_03                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: abakirca <ahmetbakircan@gmail.com>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*                                                     #+#    #+#             */
/*   Created: 2025/12/26 19:04:16 by abakirca         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

module challenge::day_03
{
	#[test_only]
	use std::unit_test::assert_eq;

	public struct Habit has copy, drop
	{
		name: vector<u8>,
		completed: bool
	}

	public fun new_habit(name: vector<u8>): Habit
	{
		Habit
		{
			name,
			completed: false,
		}
	}

	#[test]
	public fun test_struct_with_abilities()
	{
		let habit_name: vector<u8> = b"Clean coding";
		let habit: Habit = new_habit(habit_name);
		let habit2 = habit;

		assert_eq!(habit.name, b"Clean coding");
		assert_eq!(habit.completed, false);
		assert_eq!(habit2.name, b"Clean coding");
		assert_eq!(habit2.completed, false);
	}

	// Cannot do the tests below because the struct does not have copy ability
	// It just gives error: use of moved value: `habit`
	// Also, since the test struct doesnt have drop ability,
	// compiler gives warning: value assigned to `habit` is never dropped

	/*
	#[test_only]
	public struct Habit_test_wo_abilities
	{
		name: vector<u8>,
		completed: bool
	}

	#[test_only]
	public fun new_habit_test_wo_abilities(name: vector<u8>): Habit_test_wo_abilities
	{
		Habit_test_wo_abilities
		{
			name,
			completed: false,
		}
	}

	#[test]
	public fun test_struct_without_abilities()
	{
		let habit_name: vector<u8> = b"Clean coding";
		let habit: Habit_test_wo_abilities = new_habit_test_wo_abilities(habit_name);
		let habit2 = habit;

		assert_eq!(habit.name, b"Clean coding");
		assert_eq!(habit.completed, false);
	}
	*/
}
