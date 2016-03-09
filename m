From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/7][Resend] cpufreq: Rework the scheduler hooks for
 triggering updates
Date: Wed, 9 Mar 2016 14:41:29 +0100
Message-ID: <20160309134129.GM6344@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <2409306.qzzMXcm4dm@vostro.rjw.lan>
 <4088601.C2vItRYpQn@vostro.rjw.lan>
 <7541372.ciUW4go8Ux@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:33199 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536AbcCINli (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2016 08:41:38 -0500
Content-Disposition: inline
In-Reply-To: <7541372.ciUW4go8Ux@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Tue, Mar 08, 2016 at 03:25:16AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit fe7034338ba0 (cpufreq: Add mechanism for registering
> utilization update callbacks) added cpufreq_update_util() to be
> called by the scheduler (from the CFS part) on utilization updates.
> The goal was to allow CFS to pass utilization information to cpufreq
> and to trigger it to evaluate the frequency/voltage configuration
> (P-state) of every CPU on a regular basis.
> 
> However, the last two arguments of that function are never used by
> the current code, so CFS might simply call cpufreq_trigger_update()
> instead of it (like the RT and DL sched classes).
> 
> For this reason, drop the last two arguments of cpufreq_update_util(),
> rename it to cpufreq_trigger_update() and modify CFS to call it.
> 
> Moreover, since the utilization is not involved in that now, rename
> data types, functions and variables related to cpufreq_trigger_update()
> to reflect that (eg. struct update_util_data becomes struct
> freq_update_hook and so on).

> -void cpufreq_update_util(u64 time, unsigned long util, unsigned long max)
> +void cpufreq_trigger_update(u64 time)

So I'm not convinced about this. Yes the utility of this function is
twofold. One to allow in-situ frequency adjustments where possible, but
two, also very much to allow using the statistics already gathered.

Sure, 4.5 will not have any such users, but who cares.

And I'm really not too worried about 'random' people suddenly using it
to base work on. Either people are already participating in these
discussions and will thus be aware of whatever concerns there might be,
or we'll tell them when they post their code.

And when they don't participate and don't post their code, I really
don't care about them anyway :-)
