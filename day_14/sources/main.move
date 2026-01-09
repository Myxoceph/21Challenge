/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day_14                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: abakirca <ahmetbakircan@gmail.com>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*                                                     #+#    #+#             */
/*   Created: 2026/01/09 23:31:53 by abakirca         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */


/// DAY 14: Tests for Bounty Board
/// 
/// Today you will:
/// 1. Write comprehensive tests
/// 2. Test all the functions you've created
/// 3. Practice test organization
///
/// Note: You can copy code from day_13/sources/solution.move if needed

module challenge::day_14 {
    use std::vector;
    use std::string::String;
    use std::option::{Self, Option};

    #[test_only]
    use std::unit_test::assert_eq;
    use std::string;

    // Copy from day_13: All structs and functions
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

    public fun complete_task(task: &mut Task) {
        task.status = TaskStatus::Completed;
    }

    public fun total_reward(board: &TaskBoard): u64 {
        let len = vector::length(&board.tasks);
        let mut total = 0;
        let mut i = 0;
        while (i < len) {
            let task = vector::borrow(&board.tasks, i);
            total = total + task.reward;
            i = i + 1;
        };
        total
    }

    public fun completed_count(board: &TaskBoard): u64 {
        let len = vector::length(&board.tasks);
        let mut count = 0;
        let mut i = 0;
        while (i < len) {
            let task = vector::borrow(&board.tasks, i);
            if (task.status == TaskStatus::Completed) {
                count = count + 1;
            };
            i = i + 1;
        };
        count
    }

	#[test]
	public fun test_create_board_and_add_task()
	{
		let owner = @0x1;
		let mut board = new_board(owner);
		let task1 = new_task(string::utf8("Slay the dragon"), 100);
		add_task(&mut board, task1);

		assert_eq!(vector::length(&board.tasks), 1);
		let added_task = vector::borrow(&board.tasks, 0);
		assert_eq!(added_task.title, string::utf8("Slay the dragon"));
		assert_eq!(added_task.reward, 100);
		assert_eq!(added_task.status, TaskStatus::Open);
	}

	#[test]
	public fun test_complete_task()
	{
		let owner = @0x1;
		let mut board = new_board(owner);
		let task1 = new_task(string::utf8("Collect 10 herbs"), 50);
		let task2 = new_task(string::utf8("Defeat the goblin king"), 150);
		add_task(&mut board, task1);
		add_task(&mut board, task2);

		let mut task_to_complete = vector::borrow_mut(&mut board.tasks, 1);
		complete_task(task_to_complete);

		assert_eq!(completed_count(&board), 1);
	}

	#[test]
	public fun test_total_reward()
	{
		let owner = @0x1;
		let mut board = new_board(owner);
		let task1 = new_task(string::utf8("Find the lost sword"), 200);
		let task2 = new_task(string::utf8("Rescue the villager"), 150);
		let task3 = new_task(string::utf8("Explore the cave"), 100);
		add_task(&mut board, task1);
		add_task(&mut board, task2);
		add_task(&mut board, task3);
		assert_eq!(total_reward(&board), 450);
	}
}
