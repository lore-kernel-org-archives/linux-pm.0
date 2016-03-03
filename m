From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5/6] cpufreq: Support for fast frequency switching
Date: Thu, 3 Mar 2016 21:56:40 +0100
Message-ID: <CAJZ5v0gftV8fR9XQuFKPf-v6FzyFV5onRvyE64mc5kPXUVQqmA@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<26020775.9hJG2SHiH2@vostro.rjw.lan>
	<20160303111655.GL6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160303111655.GL6356@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 3, 2016 at 12:16 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Mar 02, 2016 at 03:12:33AM +0100, Rafael J. Wysocki wrote:
>> The most important change from the previous version is that the
>> ->fast_switch() callback takes an additional "relation" argument
>> and now the governor can use it to choose a selection method.
>
>> +unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
>> +                                   unsigned int target_freq,
>> +                                   unsigned int relation)
>
> Would it make sense to replace the {target_freq, relation} pair with
> something like the CPPC {min_freq, max_freq} pair?

Yes, it would in general, but since I use __cpufreq_driver_target() in
the "slow driver" case, that would need to be reworked too for
consistency.  So I'd prefer to do that later.

> Then you could use the closest frequency to max provided it is larger
> than min.
>
> This communicates more actual information in the same number of
> parameters and would thereby allow for a more flexible (better)
> frequency selection.

Agreed.
