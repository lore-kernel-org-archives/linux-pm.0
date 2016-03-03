From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Thu, 3 Mar 2016 17:42:05 +0100
Message-ID: <20160303164205.GC6375@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <1842158.0Xhak3Uaac@vostro.rjw.lan>
 <CAKfTPtANvYp5ar8UkKyN9R25Ntrfp+bEEFw5M0=MA8q7zscSMw@mail.gmail.com>
 <CAJZ5v0jvStPbhKSJUHTwySkEXa0rKp3zE7YLWeCmGHeQt8xcrw@mail.gmail.com>
 <CAJZ5v0gC_S+a43FvgpB25WnpAANkDQk7agwSx4gRJvdmnPFkeQ@mail.gmail.com>
 <CAKfTPtDRvM9PAwQQ2KjUjPjnMmKkdi6sCoX4YisKaunDBqLf-A@mail.gmail.com>
 <20160303153817.GO6344@twins.programming.kicks-ass.net>
 <20160303162829.GB6375@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160303162829.GB6375@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 03, 2016 at 05:28:29PM +0100, Peter Zijlstra wrote:
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

Actually reading MPERF increases the chances of this working.

> +
> +	acnt = aperf - this_cpu_read(arch_prev_aperf);
> +	mcnt = mperf - this_cpu_read(arch_prev_mperf);
> +
> +	this_cpu_write(arch_prev_aperf, aperf);
> +	this_cpu_write(arch_prev_mperf, mperf);
> +
> +	this_cpu_write(arch_cpu_freq, div64_u64(acnt * SCHED_CAPACITY_SCALE, mcnt));
> +}
