From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 7/7] cpufreq: schedutil: New governor based on scheduler utilization data
Date: Wed, 16 Mar 2016 22:48:51 +0100
Message-ID: <1619379.bIbaK6P2Xv@vostro.rjw.lan>
References: <1711281.bPmSjlBT7c@vostro.rjw.lan> <11678919.CQLTrQTYxG@vostro.rjw.lan> <20160316175341.GG6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44428 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965383AbcCPVqs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 17:46:48 -0400
In-Reply-To: <20160316175341.GG6344@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Wednesday, March 16, 2016 06:53:41 PM Peter Zijlstra wrote:
> On Wed, Mar 16, 2016 at 03:59:18PM +0100, Rafael J. Wysocki wrote:
> > +static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
> > +				unsigned int next_freq)
> > +{
> > +	struct cpufreq_policy *policy = sg_policy->policy;
> > +
> > +	if (next_freq > policy->max)
> > +		next_freq = policy->max;
> > +	else if (next_freq < policy->min)
> > +		next_freq = policy->min;
> 
> I'm still very much undecided on these policy min/max thresholds. I
> don't particularly like them.

These are for consistency mostly.

It actually occurs to me that __cpufreq_driver_target() does that already
anyway, so they can be moved into the "fast switch" branch.  Which means
that the code needs to be rearranged a bit here.

