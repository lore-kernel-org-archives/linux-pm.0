From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Thu, 3 Mar 2016 17:28:55 +0000
Message-ID: <56D87457.1050600@arm.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <1842158.0Xhak3Uaac@vostro.rjw.lan>
 <CAKfTPtANvYp5ar8UkKyN9R25Ntrfp+bEEFw5M0=MA8q7zscSMw@mail.gmail.com>
 <CAJZ5v0jvStPbhKSJUHTwySkEXa0rKp3zE7YLWeCmGHeQt8xcrw@mail.gmail.com>
 <CAJZ5v0gC_S+a43FvgpB25WnpAANkDQk7agwSx4gRJvdmnPFkeQ@mail.gmail.com>
 <CAKfTPtDRvM9PAwQQ2KjUjPjnMmKkdi6sCoX4YisKaunDBqLf-A@mail.gmail.com>
 <20160303153817.GO6344@twins.programming.kicks-ass.net>
 <20160303162829.GB6375@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38796 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923AbcCCR3A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Mar 2016 12:29:00 -0500
In-Reply-To: <20160303162829.GB6375@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>

On 03/03/16 16:28, Peter Zijlstra wrote:
> On Thu, Mar 03, 2016 at 04:38:17PM +0100, Peter Zijlstra wrote:
>> On Thu, Mar 03, 2016 at 03:01:15PM +0100, Vincent Guittot wrote:
>>>> In case a more formal derivation of this formula is needed, it is
>>>> based on the following 3 assumptions:
>>>>
>>>> (1) Performance is a linear function of frequency.
>>>> (2) Required performance is a linear function of the utilization ratio
>>>> x = util/max as provided by the scheduler (0 <= x <= 1).
>>>
>>> Just to mention that the utilization that you are using, varies with
>>> the frequency which add another variable in your equation
>>
>> Right, x86 hasn't implemented arch_scale_freq_capacity(), so the
>> utilization values we use are all over the map. If we lower freq, the
>> util will go up, which would result in us bumping the freq again, etc..
> 
> Something like the completely untested below should maybe work.
> 
> Rafael?
> 

[...]

> +void arch_scale_freq_tick(void)
> +{
> +	u64 aperf, mperf;
> +	u64 acnt, mcnt;
> +
> +	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
> +		return;
> +
> +	aperf = rdmsrl(MSR_IA32_APERF);
> +	mperf = rdmsrl(MSR_IA32_APERF);
> +
> +	acnt = aperf - this_cpu_read(arch_prev_aperf);
> +	mcnt = mperf - this_cpu_read(arch_prev_mperf);
> +
> +	this_cpu_write(arch_prev_aperf, aperf);
> +	this_cpu_write(arch_prev_mperf, mperf);
> +
> +	this_cpu_write(arch_cpu_freq, div64_u64(acnt * SCHED_CAPACITY_SCALE, mcnt));

Wasn't there the problem that this ratio goes to zero if the cpu is idle
in the old power estimation approach on x86?

[...]
