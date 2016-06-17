From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: regression caused by 08f511fd41c3 ("cpufreq: Reduce
 cpufreq_update_util() overhead a bit")
Date: Fri, 17 Jun 2016 16:03:53 +0200
Message-ID: <20160617140353.GQ30154@twins.programming.kicks-ass.net>
References: <20160617163023.5bb374f8@xhacker>
 <20160617164054.6339c5d4@xhacker>
 <CAJZ5v0hd9HKUHzEnnBnp4-DmcHXgy1GgMK-st=Bs36rxzYR5xw@mail.gmail.com>
 <20160617131651.GU3923@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:40493 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405AbcFQOED (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 10:04:03 -0400
Content-Disposition: inline
In-Reply-To: <20160617131651.GU3923@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jisheng Zhang <jszhang@marvell.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Jun 17, 2016 at 06:16:51AM -0700, Paul E. McKenney wrote:
> > Paul, Peter, any ideas about what may be going on here?
> 
> Looks to me like this commit moved some code from synchronize_rcu() to
> synchronize_sched().  Assuming that this is a CONFIG_PREEMPT=y system,
> might there have been a decrease in the wakeups from the rcu_preempt
> kthread?

The 'funny' thing is though; those synchronize thingies are only reached
when we change cpufreq policy, so things like:

  for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor ; do echo performance > $i ; done

Something which is hardly possible when idle. Weird.
