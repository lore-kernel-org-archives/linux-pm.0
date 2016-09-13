From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [Resend][PATCH 1/3] cpufreq / sched: SCHED_CPUFREQ_IOWAIT flag
 to indicate iowait condition
Date: Tue, 13 Sep 2016 09:34:39 +0200
Message-ID: <20160913073439.GD5008@twins.programming.kicks-ass.net>
References: <21371892.ALJNnHKoBY@vostro.rjw.lan>
 <3396916.fdtXW4Ee0Q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:44662 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbcIMHev (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 03:34:51 -0400
Content-Disposition: inline
In-Reply-To: <3396916.fdtXW4Ee0Q@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steve Muckle <smuckle@linaro.org>, Doug Smythies <doug.smythies@gmail.com>

On Fri, Sep 09, 2016 at 11:59:33PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Testing indicates that it is possible to improve performace
> significantly without increasing energy consumption too much by
> teaching cpufreq governors to bump up the CPU performance level if
> the in_iowait flag is set for the task in enqueue_task_fair().
> 
> For this purpose, define a new cpufreq_update_util() flag
> SCHED_CPUFREQ_IOWAIT and modify enqueue_task_fair() to pass that
> flag to cpufreq_update_util() in the in_iowait case.  That generally
> requires cpufreq_update_util() to be called directly from there,
> because update_load_avg() may not be invoked in that case.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Looks-good-to: Steve Muckle <smuckle@linaro.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
