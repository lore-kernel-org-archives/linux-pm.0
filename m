From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
Date: Wed, 18 May 2016 23:11:51 +0200
Message-ID: <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35358 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbcERVLx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 17:11:53 -0400
In-Reply-To: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>

On Wed, May 18, 2016 at 2:53 PM, Shilpasri G Bhat
<shilpa.bhat@linux.vnet.ibm.com> wrote:
> This patch adds driver callback for fast_switch and below observations
> on schedutil governor are done with this patch.
>
> In POWER8 there is a regression observed with schedutil compared to
> ondemand. With schedutil the frequency is not ramping down and is
> mostly stuck at max frequency during idle . This is because of the
> watchdog timer, an RT task which is fired every 4 seconds which
> results in requesting max frequency.

Well, yes, that would be problematic.

I guess the Steve Muckle's cross-CPU utilization updates series might
help (you can find it in the linux-pm patchwork).

> In a completely idle system, when there are no processes running apart
> from few short running housekeeping tasks (like watchdog) the system is
> stuck at max frequency due to 'cpufreq_trigger_update()'
>
> static inline void cpufreq_trigger_update(u64 time)
> {
>         cpufreq_update_util(time, ULONG_MAX, 0);
> }
>
> If there is no noise apart from the watchdog timer the cpu is held at
> max frequency for no good reason. On a 16 core system I can see an
> increase in 20% idle power with schedutil compared to ondemand
> governor.
>
> Below is the trace with 'sched:sched_switch' and 'power:cpu_frequency'
> events. Here the watchdog timer that runs for a very small period is
> requesting Pmax and this gets triggered regularly.
>
> <idle>-0  19059.992912: sched_switch: prev_comm=swapper/16  prev_state=R
>                                 ==> next_comm=watchdog/16
> watchdog/16-107 19059.992914: cpu_frequency: state=4322000 cpu_id=16
> watchdog/16-107 19059.992915: sched_switch: prev_comm=watchdog/16 prev_state=S
>                                 ==> next_comm=swapper/16
>
> However adding a cpufreq hook in pick_next_task_idle() to decrease the
> frequency helped to reduce the problem.
>
> static inline void cpufreq_trigger_idle(u64 time)
> {
>        cpufreq_update_util(time, 0, 1);
> }
>
> This might not be the right fix for the problem, however this thread
> is reporting the other short-comings of cpufreq_trigger_update().
