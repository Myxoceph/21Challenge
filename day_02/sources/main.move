/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day_02                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: abakirca <ahmetbakircan@gmail.com>         +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*                                                     #+#    #+#             */
/*   Created: 2025/12/25 19:01:55 by abakirca         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

module challenge::day_02
{
	#[test_only]
	use std::unit_test::assert_eq;

	#[test]
	fun test_sum()
	{
		let x: u64 = 31;
		let y: u64 = 69;
		let sumval: u64;

		sumval = sum(x, y);
		assert_eq!(sumval, 100);
	}

	public fun sum(x: u64, y: u64): u64
	{
		x + y
	}
}
