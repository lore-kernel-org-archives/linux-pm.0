From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [6/11] issue 6: Poor and non-deterministic performance on heterogeneous systems
Date: Tue,  7 Jan 2014 16:19:42 +0000
Message-ID: <1389111587-5923-7-git-send-email-morten.rasmussen@arm.com>
References: <1389111587-5923-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:45411 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbaAGQTw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2014 11:19:52 -0500
In-Reply-To: <1389111587-5923-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, markgross@thegnar.org, vincent.guittot@linaro.org, catalin.marinas@arm.com, morten.rasmussen@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The current mainline scheduler doesn't give optimum performance on
heterogeneous systems for workload with few tasks (#tasks <=3D #cpu).
Using cpu_power (in its current form) to inform the scheduler about the
relative compute capacity of the cpus is not sufficient.

1. cpu_power is not used on wake-up which means that new tasks may end
up anywhere. Periodic load-balance generally bails out if there is only
one task running on a cpu, so the task isn't moved later. Hence, the
execution time of the task may be anywhere between the execution it
would have had running exclusively on the fastest cpu and running
exclusively on the slowest cpu.

Running a single cpu intensive task on an otherwise idle system while
measuring its execution time will show this problem. On ARM TC2
(big.LITTLE) we get the following numbers:

cpu_power       1024    606/1441
=09=09default=09slow/fast
execution time:
(100 runs)
Max             4.33    4.33
Min             2.09    2.91
Distribution:
Runs within
5% of Min       14      11
5% of Max       86      89

Only a few runs randomly ended up on a fast cpu irrespective of the
cpu_power settings. The distribution can easily change depending on
other tasks, reordering the cpus, or changing the topology.

The problem can also be observed for smartphone workloads like
webbrowsing where page rendering times vary significantly as the threads
are randomly scheduled on fast and slow cpus.

2. Using cpu_power to represent the relative performance of the cpus,
leads to undesirable task balance in common scenarios. group_power =3D
sum(cpu_power) for a group of cpus and is used in the periodic
load-balance, idle balance, and nohz idle balance to determine the
number of tasks that should be in each group. However, depending on the
number of cpus in the groups, that causes one group to be overloaded
while another has idle cpus if the number of tasks is equal to the
number of cpus (or slightly larger).

Running a simple parallel workload (OpenMP) will reveal this as it uses
one worker thread per cpu by default. On ARM TC2 we get the following
behaviour:

cpu_power       1024    606/1441 (slow/fast)
execution time:
(20 runs)
avg             8.63    9.87            14.34% (slowdown)
stdev           0.01    0.01

The kernelshark trace reveals that the 606/1441 configuration puts three
tasks on the two fast cpus and two tasks of the three slow cpus leaving
one of them idle. The 1024 case has one task per cpu.

Overall cpu_power in its current form does not solve any of the
performance issues on heterogeneous systems. It even makes them worse
for some common workload scenarios.


