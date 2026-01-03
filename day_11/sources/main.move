/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day_11                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: abakirca <ahmetbakircan@gmail.com>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*                                                     #+#    #+#             */
/*   Created: 2026/01/03 23:51:56 by abakirca         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

module challenge::day_11
{
    use std::string::String;

    public enum TaskStatus has copy, drop
	{
        Open,
        Completed,
    }

    public struct Task has copy, drop
	{
        title: String,
        reward: u64,
        status: TaskStatus,
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

	public struct TaskBoard has drop
	{
		owner: address,
		tasks: vector<Task>,
	}

	public fun new_board(owner: address): TaskBoard
	{
		TaskBoard
		{
			owner,
			tasks: vector::empty<Task>(),
		}
	}

	public fun add_task(board: &mut TaskBoard, task: Task)
	{
		vector::push_back(&mut board.tasks, task);
	}
}
