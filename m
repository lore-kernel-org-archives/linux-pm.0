From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [4/11] issue 4: Tracking idle states
Date: Fri, 20 Dec 2013 16:45:44 +0000
Message-ID: <1387557951-21750-5-git-send-email-morten.rasmussen@arm.com>
References: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:59450 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756009Ab3LTQpj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 11:45:39 -0500
In-Reply-To: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, markgross@thegnar.org, vincent.guittot@linaro.org, catalin.marinas@arm.com, morten.rasmussen@arm.com, linux-pm@vger.kernel.org

Similar to the issue of knowing the potential capacity of a cpu, the CFS
scheduler also needs to know the idle state of idle cpus. Currently, an
idle cpu is found using cpumask_first() when an extra cpu is needed (for
nohz_idle_balance in find_new_ilb() in sched/fair.c). The energy
trade-off whether to wake another cpu or put tasks on already busy cpus
depend on this information.

The cost of waking up a cpu in terms of latency and energy depends on
the idle state the cpu is in. Deeper idle states typically affects more
than a single cpu. Waking up a single cpu from such state is more
expensive as it also affects the idle states of of its related cpus.

Energy costs are not currently represented in the cpuidle framework, but
latency is. Taking ARM TC2 as an example [1], which has two idle states:
Per-core clock-gating (WFI), and cluster power-down (power down all
related cpus and caches). The target residencies and exit latencies
specified in the driver give an idea about the cost involved in
entering/exiting these states.

=09=09=09Target=09=09Exit
=09=09=09residency=09latency
Clock-gating (WFI)=091=09=091
Cluster power-down=092000/2500=09500/700=09=09(big/LITTLE)

Picking the cheapest idle cpu would also have the effect that wake-ups
are likely to happen on the same cpu and leave the remaining cpus in
idle for longer.

Potential solution: Make the scheduler idle state aware by either moving
idle handling into the scheduler or let the idle framework (cpuidle)
maintain a cpumask of the cheapest cpus to wake up which is accessible
to the scheduler.

[1] drivers/cpuidle/cpuidle-big_little.c

