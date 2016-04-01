From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86: Calculate MHz using APERF/MPERF for cpuinfo and
 scaling_cur_freqy
Date: Fri, 1 Apr 2016 09:56:36 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1604010953210.3978@nanos>
References: <6e0c25e64e0fb65a42dfc63ad5f660302e07cd87.1459485198.git.len.brown@intel.com> <52f711be59539723358bea1aa3c368910a68b46d.1459485198.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52283 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbcDAH6N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 03:58:13 -0400
In-Reply-To: <52f711be59539723358bea1aa3c368910a68b46d.1459485198.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Fri, 1 Apr 2016, Len Brown wrote:
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
> +	struct aperfmperf_sample *s = &get_cpu_var(samples);

this_cpu_ptr is sufficient. That's a smp function call ...

> +
> +	/* Cache KHz for 100 ms */
> +	if (time_before(jiffies, s->jiffies + HZ/10))
> +		goto out;
> +
> +	rdmsrl(MSR_IA32_APERF, aperf);
> +	rdmsrl(MSR_IA32_MPERF, mperf);
> +
> +	aperf_delta = aperf - s->aperf;
> +	mperf_delta = mperf - s->mperf;
> +
> +	/*
> +	 * There is no architectural guarantee that MPERF
> +	 * increments faster than we can read it.
> +	 */
> +	if (mperf_delta == 0)
> +		goto out;
> +
> +	numerator = cpu_khz * aperf_delta;
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
> +
> +	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);

You can avoid the function call if you check s->jiffies here.

Thanks,

	tglx
