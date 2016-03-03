From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/6] cpufreq: Support for fast frequency switching
Date: Thu, 3 Mar 2016 12:18:58 +0100
Message-ID: <20160303111858.GM6356@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <26020775.9hJG2SHiH2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <26020775.9hJG2SHiH2@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 02, 2016 at 03:12:33AM +0100, Rafael J. Wysocki wrote:
> +void cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> +				unsigned int target_freq, unsigned int relation)
> +{
> +	unsigned int freq;
> +
> +	if (target_freq == policy->cur)
> +		return;

But what if relation is different from last time? ;-)
