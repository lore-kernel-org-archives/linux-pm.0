From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/4] x86: use common aperfmperf_khz_on_cpu() to calculate
 KHz using APERF/MPERF
Date: Tue, 20 Jun 2017 12:15:10 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706201207170.1869@nanos>
References: <1497668594-9266-1-git-send-email-lenb@kernel.org> <aba8474c690306eb708d4737d0b63c5ca448d019.1497665794.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aba8474c690306eb708d4737d0b63c5ca448d019.1497665794.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: rafael@kernel.org, x86@kernel.org, srinivas.pandruvada@linux.intel.com, peterz@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 16 Jun 2017, Len Brown wrote:
> +#include <linux/jiffies.h>
> +#include <linux/math64.h>
> +#include <linux/percpu.h>
> +#include <linux/smp.h>
> +
> +struct aperfmperf_sample {
> +	unsigned int khz;
> +	unsigned long jiffies;
> +	u64 aperf;
> +	u64 mperf;

Nit. Please write these in tabular fashion:

	unsigned	int khz;
	unsigned long	jiffies;
	u64		aperf;
	u64		mperf;

> +};
> +
> +static DEFINE_PER_CPU(struct aperfmperf_sample, samples);
> +
> +/*
> + * aperfmperf_snapshot_khz()
> + * On the current CPU, snapshot APERF, MPERF, and jiffies
> + * unless we already did it within 10ms
> + * calculate kHz, save snapshot
> + */
> +static void aperfmperf_snapshot_khz(void *dummy)
> +{
> +	u64 aperf, aperf_delta;
> +	u64 mperf, mperf_delta;
> +	struct aperfmperf_sample *s = &get_cpu_var(samples);

This is invoked via a smp function call, so you want

     this_cpu_ptr(samples)

here.

> +	/* Don't bother re-computing within 10 ms */
> +	if (time_before(jiffies, s->jiffies + HZ/100))
> +		goto out;

That way you can spare the gotos and simply return

> index a5ce0bbe..cfc6220 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -883,6 +883,19 @@ static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
>  }
>  #endif
>  
> +#ifdef CONFIG_X86
> +extern unsigned int aperfmperf_khz_on_cpu(unsigned int cpu);
> +static inline unsigned int arch_freq_get_on_cpu(int cpu)

Please don't add arch specific crap in general headers.

Also having cpu as int and unsigned int is not really consistent.

The simple way to avoid that is to have a weak function and have an arch
override for it. If that does not work because the cpufreq stuff must be
built as a module, then you still can avoid CONFIG_X86 and have something
like CONFIG_ARCH_HAS_FOO.

Thanks,

	tglx
