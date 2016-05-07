From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/fair: Invoke cpufreq hooks for CONFIG_SMP unset
Date: Sat, 7 May 2016 08:13:10 +0200
Message-ID: <20160507061310.GA15728@worktop.ger.corp.intel.com>
References: <6282396.VVEdgVYxO3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:56123 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbcEGGNW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 7 May 2016 02:13:22 -0400
Content-Disposition: inline
In-Reply-To: <6282396.VVEdgVYxO3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@kernel.org>

On Fri, May 06, 2016 at 02:58:43PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 34e2c555f3e1 (cpufreq: Add mechanism for registering utilization
> update callbacks) overlooked the fact that update_load_avg(), where
> CFS invokes cpufreq utilization update hooks, becomes an empty stub for
> CONFIG_SMP unset.  In consequence, if CONFIG_SMP is not set, cpufreq
> governors are never invoked from CFS and they do not have a chance to
> evaluate CPU performace levels and update them often enough.  Needless
> to say, things don't work as expected then.
> 
> Fix the problem by making the !CONFIG_SMP stub of update_load_avg()
> invoke cpufreq update hooks too.
> 
> Fixes: 34e2c555f3e1 (cpufreq: Add mechanism for registering utilization update callbacks)
> Reported-by: Steve Muckle <steve.muckle@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rafael; feel free to push this through the pm tree.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
