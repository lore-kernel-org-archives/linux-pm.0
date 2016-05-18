From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [RFC PATCH] Increase in idle power with schedutil
Date: Wed, 18 May 2016 18:23:39 +0530
Message-ID: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([125.16.236.9]:55430 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbcERMyB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 08:54:01 -0400
Received: from localhost
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Wed, 18 May 2016 18:23:58 +0530
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

This patch adds driver callback for fast_switch and below observations
on schedutil governor are done with this patch.

In POWER8 there is a regression observed with schedutil compared to
ondemand. With schedutil the frequency is not ramping down and is
mostly stuck at max frequency during idle . This is because of the
watchdog timer, an RT task which is fired every 4 seconds which
results in requesting max frequency.

In a completely idle system, when there are no processes running apart
from few short running housekeeping tasks (like watchdog) the system is
stuck at max frequency due to 'cpufreq_trigger_update()'

static inline void cpufreq_trigger_update(u64 time)
{
        cpufreq_update_util(time, ULONG_MAX, 0);
}

If there is no noise apart from the watchdog timer the cpu is held at
max frequency for no good reason. On a 16 core system I can see an
increase in 20% idle power with schedutil compared to ondemand
governor.

Below is the trace with 'sched:sched_switch' and 'power:cpu_frequency'
events. Here the watchdog timer that runs for a very small period is
requesting Pmax and this gets triggered regularly.

<idle>-0  19059.992912: sched_switch: prev_comm=swapper/16  prev_state=R
				==> next_comm=watchdog/16 
watchdog/16-107 19059.992914: cpu_frequency: state=4322000 cpu_id=16
watchdog/16-107 19059.992915: sched_switch: prev_comm=watchdog/16 prev_state=S
	 			==> next_comm=swapper/16 

However adding a cpufreq hook in pick_next_task_idle() to decrease the
frequency helped to reduce the problem.

static inline void cpufreq_trigger_idle(u64 time)
{
       cpufreq_update_util(time, 0, 1);
}

This might not be the right fix for the problem, however this thread
is reporting the other short-comings of cpufreq_trigger_update().

Shilpasri G Bhat (1):
  cpufreq: powernv: Add fast_switch callback

 drivers/cpufreq/powernv-cpufreq.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
1.9.3

