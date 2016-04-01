From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86: Calculate MHz using APERF/MPERF for cpuinfo and
 scaling_cur_freq
Date: Fri, 1 Apr 2016 10:03:28 +0200
Message-ID: <20160401080328.GC3448@twins.programming.kicks-ass.net>
References: <6e0c25e64e0fb65a42dfc63ad5f660302e07cd87.1459485198.git.len.brown@intel.com>
 <52f711be59539723358bea1aa3c368910a68b46d.1459485198.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:40500 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775AbcDAIDb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 04:03:31 -0400
Content-Disposition: inline
In-Reply-To: <52f711be59539723358bea1aa3c368910a68b46d.1459485198.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Fri, Apr 01, 2016 at 12:37:00AM -0400, Len Brown wrote:
> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> new file mode 100644
> index 0000000..9380102
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -0,0 +1,76 @@
> +/*
> + * x86 APERF/MPERF KHz calculation
> + * Used by /proc/cpuinfo and /sys/.../cpufreq/scaling_cur_freq
> + *
> + * Copyright (C) 2015 Intel Corp.
> + * Author: Len Brown <len.brown@intel.com>
> + *
> + * This file is licensed under GPLv2.
> + */
> +
> +#include <linux/jiffies.h>
> +#include <linux/math64.h>
> +#include <linux/percpu.h>
> +#include <linux/smp.h>
> +
> +struct aperfmperf_sample {
> +	unsigned int khz;
> +	unsigned long jiffies;
> +	unsigned long long aperf;
> +	unsigned long long mperf;
> +};
> +
> +static DEFINE_PER_CPU(struct aperfmperf_sample, samples);
> +
> +/*
> + * aperfmperf_snapshot_khz()
> + * On the current CPU, snapshot APERF, MPERF, and jiffies
> + * unless we already did it within 100ms
> + * calculate kHz, save snapshot
> + */
> +static void aperfmperf_snapshot_khz(void *dummy)
> +{
> +	unsigned long long aperf, aperf_delta;
> +	unsigned long long mperf, mperf_delta;
> +	unsigned long long numerator;

	u64 is less typing ;-)

> +	struct aperfmperf_sample *s = &get_cpu_var(samples);
> +
> +	/* Cache KHz for 100 ms */
> +	if (time_before(jiffies, s->jiffies + HZ/10))
> +		goto out;

This puts in a lower bound, but afaict there is no upper bound. Both
users appear to be userspace controlled.

That is; if userspace doesn't request a freq reading we can go without
reading this for a very long time.

> +
> +	rdmsrl(MSR_IA32_APERF, aperf);
> +	rdmsrl(MSR_IA32_MPERF, mperf);
> +
> +	aperf_delta = aperf - s->aperf;
> +	mperf_delta = mperf - s->mperf;

That means these delta's can be arbitrarily large, in fact the MSRs can
have wrapped however many times.

> +
> +	/*
> +	 * There is no architectural guarantee that MPERF
> +	 * increments faster than we can read it.
> +	 */
> +	if (mperf_delta == 0)
> +		goto out;
> +
> +	numerator = cpu_khz * aperf_delta;

And since delta can be any 64bit value as per the msr range, this
multiplication can overflow.

> +	s->khz = div64_u64(numerator, mperf_delta);
> +	s->jiffies = jiffies;
> +	s->aperf = aperf;
> +	s->mperf = mperf;
> +
> +out:
> +	put_cpu_var(samples);
> +}
> +
> +unsigned int aperfmperf_khz_on_cpu(int cpu)
> +{
> +	if (!cpu_khz)
> +		return 0;
> +
> +	if (!boot_cpu_has(X86_FEATURE_APERFMPERF))
> +		return 0;

You could do the jiffy compare here; avoiding the IPI.

> +
> +	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
> +
> +	return per_cpu(samples.khz, cpu);
> +}
