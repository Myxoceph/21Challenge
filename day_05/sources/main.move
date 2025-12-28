/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day_05                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: abakirca <ahmetbakircan@gmail.com>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*                                                     #+#    #+#             */
/*   Created: 2025/12/28 16:10:48 by abakirca         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

module challenge::day_05
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
			return
		/*
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⢀⡄⣠⢄⣴⣠⣶⣠⣾⣤⣀⣴⣠⢄⣠⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣰⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣄⣀⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣷⣿⣿⣿⣿⠏⣿⣿⣿⡿⢏⣽⢋⡟⣹⣿⣿⢿⢿⣿⣿⣿⣿⣿⣷⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⠙⣿⡟⣿⠘⣿⣩⣿⣠⣾⣿⣿⣿⣿⣿⣿⣶⣿⡧⠞⣿⣿⣿⣿⣿⣿⣶⠆⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣷⣼⣿⣾⣷⣿⣿⡿⣿⡏⢻⣏⠁⠻⣯⠙⢿⣿⣿⣿⣯⣉⣻⣿⣿⣿⣿⣿⣏⡀⠀⠀⠀⠀⠀
			⣀⣠⣀⡀⠀⠀⠀⠀⠀⠀⠀⣰⢿⣿⣿⣿⢿⣿⢿⡿⠉⣿⠀⢻⣇⠀⠙⢆⠀⢻⡄⠘⢿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⡷⠂⠀⠀⠀⠀
			⡽⣿⠹⡉⠓⢦⠀⠀⠀⠀⠀⠃⣾⢿⢿⡏⢸⡇⠸⡇⠀⠙⢆⣀⣽⡶⠶⠾⢷⣾⡧⠀⠈⠻⣿⣿⣟⣻⣿⣿⣿⣿⣿⣿⣷⡃⠀⠀⠀⠀
			⡖⣿⣇⢣⠀⠘⡄⠀⠀⠀⠀⠀⣯⡼⠈⢇⠈⠻⣤⣽⣦⡶⠟⢋⣁⣀⣀⣀⣠⠞⠀⠀⠀⠀⢿⣿⣯⢷⣾⣿⣿⣿⣿⣿⣿⡿⠃⠀⠀⠀
			⠤⠉⣿⡾⢦⣤⡇⠀⠀⠀⠀⠀⠸⣿⠒⠚⢿⠀⠈⠙⠿⣶⣿⣿⠿⠿⠿⠭⠛⠀⠀⠀⠀⠀⢸⣿⣿⣿⢿⣟⣿⣿⣿⣿⣿⡟⠁⠀⠀⠀SADLY, I CANNOT DO
			⣦⣼⢷⣾⠯⠭⣧⠀⠀⠀⠀⠀⠀⣿⡷⣾⠟⠑⠂⠀⠀⠀⠈⠉⠀⢠⣤⣴⣦⣤⣤⡀⠀⠀⢸⣿⡟⣡⣾⣿⣿⣿⣿⣿⣿⡋⠀⠀⠀⠀ANYTHING HERE...
			⠈⢻⡿⠁⣀⠤⠼⣆⠀⠀⠀⠀⠀⡎⢰⣷⣤⣀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣦⠤⠄⠀⠀⠙⠿⢸⡟⠻⣏⡻⣿⣿⣿⡏⠀⠀⠀⠀⠀I DON'T KNOW HOW TO
			⠀⣸⢻⡏⠀⣀⡤⠼⡄⠀⠀⠀⠀⡇⠈⢿⣿⡿⠟⠀⠀⠀⠀⠀⠀⠸⢿⣿⣿⠛⠓⠒⠀⠀⠀⠀⣺⡗⠚⠋⣡⣿⣿⣿⠆⠀⠀⠀⠀⠀HANDLE ERRORS.
			⠀⡏⢸⢳⣎⡴⠂⠉⢹⡄⠀⠀⠀⢣⠀⣤⠽⠦⠤⣀⠀⠀⠀⠀⠀⠀⠘⣿⣟⠀⠀⠀⠀⠀⠀⢠⡉⠁⣠⣾⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀
			⠀⣧⠋⣸⢻⣀⠔⠉⠁⠹⡄⠀⠀⢸⠀⢯⠶⠶⣦⣄⠙⠢⠀⠀⠀⠀⠀⠈⣿⠷⠀⠀⠀⠀⠀⡞⢓⡞⠉⣿⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀
			⣶⠃⢠⡇⠀⢷⠖⡽⠋⠉⠹⡄⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡾⠁⢰⡇⠀⢸⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀
			⣽⠀⢸⡇⠀⠈⢟⣇⣀⣠⠤⠽⡄⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⡾⣿⠁⠀⢈⡇⠀⠘⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⢸⠀⢸⡄⠀⠀⠘⣿⣯⠀⠀⠀⠙⣄⣧⣤⣤⣴⣦⣤⣴⣤⣤⣠⣤⣴⣶⣿⣿⣿⠟⠉⢠⠋⠀⠀⢼⡇⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⡇⣾⡇⠀⠀⠀⠸⡽⣷⣴⠒⠒⠛⣏⠙⠛⠿⣿⣿⣿⣿⣿⣿⣿⢿⣿⠟⠋⠀⠀⢀⣽⠃⠀⠀⠘⡇⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠸⣧⠇⠀⠀⠀⠀⠹⣿⣧⡠⠔⠒⠚⢧⠀⠀⠈⣿⣻⠛⣿⣿⡷⠛⠁⠀⠀⠀⢀⣼⡏⠀⠀⠀⠈⢿⠀⠀⠘⡆⠀⠀⠀⠀⠀⠀⠀⠀
			⠀⠀⠹⡄⠀⠀⠀⠀⠀⠹⡛⣦⡀⢀⣀⠬⢧⡀⠀⢸⣿⠖⠛⠁⠀⠀⠀⠀⠀⠀⠘⢻⠃⠀⠀⠀⠀⢸⡀⠀⠀⢣⣀⠤⠖⠒⠒⠒⠢⢤
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⣸⡗⠉⠀⠀⢀⣱⡄⠈⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⠀⠀⠀⠀⠀⣸⡧⠴⠚⠉⠀⣀⣀⡄⠀⠀⢀⡀
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢏⢛⣶⠖⢊⣉⣀⠽⠦⣽⣷⡀⠀⠀⠀⠀⠀⠀⢀⣿⠋⠀⣠⠴⠚⠉⠀⣀⣠⣴⣾⣿⣿⣿⣷⣷⣶⣿⣿
			⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣾⡿⠞⠉⠓⠲⣶⣿⣿⣿⢧⠀⠀⠀⠀⠀⠀⢀⡿⠖⠋⠁⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠁
			⠀⠀⠀⠀⠀⠀⢀⡤⢺⣿⣿⣟⣫⣴⣶⣤⣤⣀⣀⣙⣿⣿⣬⣤⣤⠤⣤⠴⠚⢉⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠀⣀⣠⣴⣾
			*/
		}
	}

	#[test]
	public fun test_habit_list()
	{
		let mut habit_list: HabitList = empty_list();
		let habit1: Habit = new_habit(utf8(b"Learning Move"));
		let habit2: Habit = new_habit(utf8(b"Writing tests"));

		add_habit(&mut habit_list, move habit1);
		add_habit(&mut habit_list, move habit2);

		complete_habit(&mut habit_list, 0);
		assert_eq!(vector::borrow(&habit_list.habits, 0).completed, true);
		assert_eq!(vector::borrow(&habit_list.habits, 1).completed, false);
	}
}
