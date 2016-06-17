From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: regression caused by 08f511fd41c3 ("cpufreq: Reduce
 cpufreq_update_util() overhead a bit")
Date: Fri, 17 Jun 2016 17:32:25 +0200
Message-ID: <CAJZ5v0h+hoA0QBQKdnnxWErNGZ0Fd-sYjjH_oTdH6No9Uz2B2A@mail.gmail.com>
References: <20160617163023.5bb374f8@xhacker> <20160617164054.6339c5d4@xhacker>
 <CAJZ5v0hd9HKUHzEnnBnp4-DmcHXgy1GgMK-st=Bs36rxzYR5xw@mail.gmail.com>
 <20160617131651.GU3923@linux.vnet.ibm.com> <20160617140353.GQ30154@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36059 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbcFQPc2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 11:32:28 -0400
In-Reply-To: <20160617140353.GQ30154@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Jisheng Zhang <jszhang@marvell.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Jun 17, 2016 at 4:03 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Jun 17, 2016 at 06:16:51AM -0700, Paul E. McKenney wrote:
>> > Paul, Peter, any ideas about what may be going on here?
>>
>> Looks to me like this commit moved some code from synchronize_rcu() to
>> synchronize_sched().  Assuming that this is a CONFIG_PREEMPT=y system,
>> might there have been a decrease in the wakeups from the rcu_preempt
>> kthread?
>
> The 'funny' thing is though; those synchronize thingies are only reached
> when we change cpufreq policy, so things like:
>
>   for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor ; do echo performance > $i ; done

Or if you change min or max for a policy and the driver is intel_pstate.

> Something which is hardly possible when idle. Weird.

Well, exactly.

Jisheng, do you use intel_pstate or acpi-cpufreq as the scaling driver?
