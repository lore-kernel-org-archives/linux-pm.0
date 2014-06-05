From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 01/16] sched: Documentation for scheduler energy cost model
Date: Thu, 5 Jun 2014 10:49:35 +0200
Message-ID: <CAKfTPtB6fC76vtChMqAcrnrOaEsEM7pM411qW4VmGJh4TYgT8Q@mail.gmail.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com> <1400869003-27769-2-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34446 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaFEIt4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jun 2014 04:49:56 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so748693obc.7
        for <linux-pm@vger.kernel.org>; Thu, 05 Jun 2014 01:49:55 -0700 (PDT)
In-Reply-To: <1400869003-27769-2-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

Hi Morten,

On 23 May 2014 20:16, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> This documentation patch provide a brief overview of the experimental
> scheduler energy costing model and associated data structures.
>
> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> ---
>  Documentation/scheduler/sched-energy.txt |   66 ++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/scheduler/sched-energy.txt
>
> diff --git a/Documentation/scheduler/sched-energy.txt b/Documentation/scheduler/sched-energy.txt
> new file mode 100644
> index 0000000..c6896c0
> --- /dev/null
> +++ b/Documentation/scheduler/sched-energy.txt
> @@ -0,0 +1,66 @@
> +Energy cost model for energy-aware scheduling (EXPERIMENTAL)
> +
> +Introduction
> +=============
> +The basic energy model uses platform energy data stored in sched_energy data
> +structures attached to the sched_groups in the sched_domain hierarchy. The
> +energy cost model offers two function that can be used to guide scheduling
> +decisions:
> +
> +1.     energy_diff_util(cpu, util, wakeups)

Could you give us mor edetails of what util and wakeups are ?
util is a absolute value or a delta
Is wakeups a boolean or does wakeups define a number of tasks/cpus
that wake up ?

> +2.     energy_diff_task(cpu, task)
> +
> +Both return the energy cost delta caused by adding/removing utilization or a
> +task to/from a specific cpu.
> +
> +CONFIG_SCHED_ENERGY needs to be defined in Kconfig to enable the energy cost
> +model and associated data structures.
> +
> +The basic algorithm
> +====================
> +The basic idea is to determine the energy cost at each level in sched_domain
> +hierarchy based on utilization:
> +
> +       for_each_domain(cpu, sd) {
> +               sg = sched_group_of(cpu)
> +               energy_before = curr_util(sg) * busy_power(sg)
> +                               + 1-curr_util(sg) * idle_power(sg)
> +               energy_after = new_util(sg) * busy_power(sg)
> +                               + 1-new_util(sg) * idle_power(sg)
> +                               + new_util(sg) * task_wakeups
> +                                                       * wakeup_energy(sg)
> +               energy_diff += energy_before - energy_after
> +       }
> +
> +       return energy_diff

So this is the algorithm used in energy_diff_util and energy_diff_task ?

it's not straight foward for me to map the algorithm variable and the
function argument

> +
> +Platform energy data
> +=====================
> +struct sched_energy has the following members:
> +
> +cap_states:
> +       List of struct capacity_state representing the supported capacity states
> +       (P-states). struct capacity_state has two members: cap and power, which
> +       represents the compute capacity and the busy power of the state. The
> +       list must ordered by capacity low->high.
> +
> +nr_cap_states:
> +       Number of capacity states in cap_states.
> +
> +max_capacity:
> +       The highest capacity supported by any of the capacity states in
> +       cap_states.

can't you directly use cap_states[nr_cap_states].cap has the array is ordered ?

Vincent
> +
> +idle_power:
> +       Idle power consumption. Will be extended to support multiple C-states
> +       later.
> +
> +wakeup_energy:
> +       Energy cost of wakeup/power-down cycle for the sched_group which this is
> +       attached to. Will be extended to support different costs for different
> +       C-states later.
> +
> +There are no unit requirements for the energy cost data. Data can be normalized
> +with any reference, however, the normalization must be consistent across all
> +energy cost data. That is, one bogo-joule/watt must be same quantity for data,
> +but we don't care what it is.
> --
> 1.7.9.5
>
>
