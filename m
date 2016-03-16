From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 7/7] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Wed, 16 Mar 2016 18:53:41 +0100
Message-ID: <20160316175341.GG6344@twins.programming.kicks-ass.net>
References: <1711281.bPmSjlBT7c@vostro.rjw.lan>
 <11678919.CQLTrQTYxG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:37308 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcCPRyH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 13:54:07 -0400
Content-Disposition: inline
In-Reply-To: <11678919.CQLTrQTYxG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On Wed, Mar 16, 2016 at 03:59:18PM +0100, Rafael J. Wysocki wrote:
> +static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
> +				unsigned int next_freq)
> +{
> +	struct cpufreq_policy *policy = sg_policy->policy;
> +
> +	if (next_freq > policy->max)
> +		next_freq = policy->max;
> +	else if (next_freq < policy->min)
> +		next_freq = policy->min;

I'm still very much undecided on these policy min/max thresholds. I
don't particularly like them.
