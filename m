From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH 0/6] arm, arm64: frequency- and cpu-invariant accounting
 support for task scheduler
Date: Mon, 12 Jun 2017 14:00:52 +0100
Message-ID: <20170612130052.6ujugxmbxarvgsyf@e106622-lin>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33410 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751494AbdFLNA5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Jun 2017 09:00:57 -0400
Content-Disposition: inline
In-Reply-To: <20170608075513.12475-1-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Vincent Guittot <vincent.guittot@linaor.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>

Hi Dietmar,

On 08/06/17 08:55, Dietmar Eggemann wrote:
> For a more accurate (i.e. frequency- and cpu-invariant) load-tracking
> the task scheduler needs a frequency-scaling and on a heterogeneous
> system a cpu-scaling correction factor.
> 
> This patch-set implements a Frequency Invariance Engine (FIE)
> (topology_get_freq_scale()) in drivers/base/arch_topology.c to provide
> a frequency-scaling correction factor.
> 
> The Cpu Invariance Engine (CIE) (topology_get_cpu_scale()) providing a
> cpu-scaling correction factor was already introduced by the "Fix issues
> and factorize arm/arm64 capacity information code" patch-set [1].
> 
> This patch-set also enables the frequency- and cpu-invariant accounting
> support. Enabling here means to associate (wire) the task scheduler
> cname arch_scale_freq_capacity and arch_scale_cpu_capacity with the FIE
> and CIE function names from drivers/base/arch_topology.c. This replaces
> the task scheduler's default FIE and CIE in kernel/sched/sched.h.
> 
> Patch high level description:
> 
>  [   01/06] Rework cpufreq policy notifier for frequency-invariant
>             accounting support
>  [   02/06] Frequency Invariance Engine (FIE)
>  [03,04/06] Enable frequency- and cpu-invariant accounting support on
>             arm
>  [05,06/06] Enable frequency- and cpu-invariant accounting support on
>             arm64
> 
> The patch-set is based on top of linux-next/master (tag: next-20170607)
> and it is also available from:
> 
>  git://linux-arm.org/linux-de.git upstream/freq_and_cpu_inv
> 
> It has been tested on TC2 (arm) and JUNO (arm64) by running a ramp-up
> rt-app task pinned to a cpu with the ondemand cpufreq governor and
> checking the load-tracking signals of this task.
> 

The whole set looks OK to me, and I tested it as well.

Feel free to add my

Reviewed-and-tested-by: Juri Lelli <juri.lelli@arm.com>

to it.

Best,

- Juri
