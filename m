From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 28/46] sched: Count number of shallower idle-states
 in struct sched_group_energy
Date: Thu, 13 Aug 2015 20:10:25 +0200
Message-ID: <20150813181025.GA19282@twins.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-29-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:59385 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbbHMSKa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 14:10:30 -0400
Content-Disposition: inline
In-Reply-To: <1436293469-25707-29-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:24:11PM +0100, Morten Rasmussen wrote:
> cpuidle associates all idle-states with each cpu while the energy model
> associates them with the sched_group covering the cpus coordinating
> entry to the idle-state. To look up the idle-state power consumption in
> the energy model it is therefore necessary to translate from cpuidle
> idle-state index to energy model index. For this purpose it is helpful
> to know how many idle-states that are listed in lower level sched_groups
> (in struct sched_group_energy).
> 
> Example: ARMv8 big.LITTLE JUNO (Cortex A57, A53) idle-states:
> Idle-state              cpuidle         Energy model table indices
>                         index           per-cpu sg      per-cluster sg
> WFI                     0               0               (0)
> Core power-down         1               1               0*
> Cluster power-down      2               (1)             1
> 
> For per-cpu sgs no translation is required. If cpuidle reports state
> index 0 or 1, the cpu is in WFI or core power-down, respectively. We can
> look the idle-power up directly in the sg energy model table.

OK..

> Idle-state
> cluster power-down, is represented in the per-cluster sg energy model
> table as index 1. Index 0* is reserved for cluster power consumption
> when the cpus all are in state 0 or 1, but cpuidle decided not to go for
> cluster power-down.

0* is not an integer.

> Given the index from cpuidle we can compute the
> correct index in the energy model tables for the sgs at each level if we
> know how many states are in the tables in the child sgs. The actual
> translation is implemented in a later patch.

And you've lost me... I've looked at that later patch (its the next one)
and I cannot say I'm less confused.
