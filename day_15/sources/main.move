/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day_15                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: abakirca <ahmetbakircan@gmail.com>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*                                                     #+#    #+#             */
/*   Created: 2026/01/12 01:31:37 by abakirca         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

module challenge::day_15
{
	const MAX_PLOTS: u64 = 20;
	const E_PLOT_NOT_FOUND: u64 = 1;
	const E_PLOT_LIMIT_EXCEEDED: u64 = 2;
	const E_INVALID_PLOT_ID: u64 = 3;
	const E_PLOT_ALREADY_EXISTS: u64 = 4;

	public struct FarmCounters has copy, drop, store
	{
		planted: u64,
		harvested: u64,
		plots: vector<u8>,
	}

	public fun new_counters(): FarmCounters
	{
		FarmCounters
		{
			planted: 0,
			harvested: 0,
			plots: vector::empty(),
		}
	}

	public fun plant(counters: &mut FarmCounters, plotId: u8)
	{
		assert!(plotId < MAX_PLOTS as u8, E_INVALID_PLOT_ID);
		let len = vector::length(&counters.plots);
		assert!(len < MAX_PLOTS, E_PLOT_LIMIT_EXCEEDED);

		let mut i = 0;
		while (i < len)
		{
			let existing_plot = *vector::borrow(&counters.plots, i);
			assert!(existing_plot != plotId, E_PLOT_ALREADY_EXISTS);
			i = i + 1;
		};
		vector::push_back(&mut counters.plots, plotId);
		counters.planted = counters.planted + 1;
	}

	public fun harvest(counters: &mut FarmCounters, plotId: u8)
	{
		let len = vector::length(&counters.plots);
		let mut i = 0;
		let mut found = false;
		while (i < len)
		{
			let existing_plot = *vector::borrow(&counters.plots, i);
			if (existing_plot == plotId)
			{
				found = true;
				break
			};
			i = i + 1;
		};
		assert!(found, E_PLOT_NOT_FOUND);
		let last_index = len - 1;
		if (i != last_index)
		{
			let last_plot = *vector::borrow(&counters.plots, last_index);
			*vector::borrow_mut(&mut counters.plots, i) = last_plot;
		};
		vector::pop_back(&mut counters.plots);
		counters.harvested = counters.harvested + 1;
	}
}
