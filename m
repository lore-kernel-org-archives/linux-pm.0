From: WANG Chao <chao.wang@ucloud.cn>
Subject: Re: [PATCH] x86 / CPU: Always show current CPU frequency in
 /proc/cpuinfo
Date: Wed, 15 Nov 2017 17:33:47 +0800
Message-ID: <20171115093347.GA28750@WANG-Chaos-MacBook-Pro.local>
References: <20171109103814.70688-1-chao.wang@ucloud.cn>
 <2067351.8xeh6jAbVr@aspire.rjw.lan>
 <CA+55aFxYQKzGbZ3GUWcuta5kz=2jp52xbEhV96R5RfCaMbLaNg@mail.gmail.com>
 <50366815.86mgx8Isne@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m97139.mail.qiye.163.com ([220.181.97.139]:54023 "EHLO
        m97139.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756000AbdKOJeb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 04:34:31 -0500
Content-Disposition: inline
In-Reply-To: <50366815.86mgx8Isne@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On 11/15/17 at 02:13P, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit 890da9cf0983 (Revert "x86: do not use cpufreq_quick_get()
> for /proc/cpuinfo "cpu MHz"") the "cpu MHz" number in /proc/cpuinfo
> on x86 can be either the nominal CPU frequency (which is constant)
> or the frequency most recently requested by a scaling governor in
> cpufreq, depending on the cpufreq configuration.  That is somewhat
> inconsistent and is different from what it was before 4.13, so in
> order to restore the previous behavior, make it report the current
> CPU frequency like the scaling_cur_freq sysfs file in cpufreq.
> 
> To that end, modify the /proc/cpuinfo implementation on x86 to use
> aperfmperf_snapshot_khz() to snapshot the APERF and MPERF feedback
> registers, if available, and use their values to compute the CPU
> frequency to be reported as "cpu MHz".
> 
> However, do that carefully enough to avoid accumulating delays that
> lead to unacceptable access times for /proc/cpuinfo on systems with
> many CPUs.  Run aperfmperf_snapshot_khz() once on all CPUs
> asynchronously at the /proc/cpuinfo open time, add a single delay
> upfront (if necessary) at that point and simply compute the current
> frequency while running show_cpuinfo() for each individual CPU.

Hi, Rafael

I tested your patch. It's much faster.

But from what I got, calling aperfmperf_snapshot_khz() asynchronously
with 10ms sleep takes much longer than calling aperfmperf_snapshot_khz()
synchronously.

Here's my result on 64 CPUs:

 - async aperfmperf_snapshot_khz() w/ 10ms sleep:

# time cat /proc/cpuinfo > /dev/null
real    0m0.014s
user    0m0.000s
sys     0m0.002s

 - sync aperfmperf_snapshot_khz() w/o any sleep:

# time cat /proc/cpuinfo > /dev/null
real    0m0.002s
user    0m0.000s
sys     0m0.002s

Thanks,
WANG Chao

> 
> Also, to avoid slowing down /proc/cpuinfo accesses too much, reduce
> the default delay between consecutive APERF and MPERF reads to 10 ms,
> which should be sufficient to get large enough numbers for the
> frequency computation in all cases.
> 
> Fixes: 890da9cf0983 (Revert "x86: do not use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz"")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Resent with a changelog & tags.
> 
> I'm going to route it via the linux-pm tree.
> 
> ---
>  arch/x86/kernel/cpu/aperfmperf.c |   74 +++++++++++++++++++++++++++------------
>  arch/x86/kernel/cpu/cpu.h        |    3 +
>  arch/x86/kernel/cpu/proc.c       |    6 ++-
>  fs/proc/cpuinfo.c                |    6 +++
>  include/linux/cpufreq.h          |    1 
>  5 files changed, 67 insertions(+), 23 deletions(-)
> 
> Index: linux-pm/arch/x86/kernel/cpu/proc.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/cpu/proc.c
> +++ linux-pm/arch/x86/kernel/cpu/proc.c
> @@ -5,6 +5,8 @@
>  #include <linux/seq_file.h>
>  #include <linux/cpufreq.h>
>  
> +#include "cpu.h"
> +
>  /*
>   *	Get CPU information for use by the procfs.
>   */
> @@ -78,9 +80,11 @@ static int show_cpuinfo(struct seq_file
>  		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
>  
>  	if (cpu_has(c, X86_FEATURE_TSC)) {
> -		unsigned int freq = cpufreq_quick_get(cpu);
> +		unsigned int freq = aperfmperf_get_khz(cpu);
>  
>  		if (!freq)
> +			freq = cpufreq_quick_get(cpu);
> +		if (!freq)
>  			freq = cpu_khz;
>  		seq_printf(m, "cpu MHz\t\t: %u.%03u\n",
>  			   freq / 1000, (freq % 1000));
> Index: linux-pm/arch/x86/kernel/cpu/aperfmperf.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/cpu/aperfmperf.c
> +++ linux-pm/arch/x86/kernel/cpu/aperfmperf.c
> @@ -14,6 +14,8 @@
>  #include <linux/percpu.h>
>  #include <linux/smp.h>
>  
> +#include "cpu.h"
> +
>  struct aperfmperf_sample {
>  	unsigned int	khz;
>  	ktime_t	time;
> @@ -24,7 +26,7 @@ struct aperfmperf_sample {
>  static DEFINE_PER_CPU(struct aperfmperf_sample, samples);
>  
>  #define APERFMPERF_CACHE_THRESHOLD_MS	10
> -#define APERFMPERF_REFRESH_DELAY_MS	20
> +#define APERFMPERF_REFRESH_DELAY_MS	10
>  #define APERFMPERF_STALE_THRESHOLD_MS	1000
>  
>  /*
> @@ -38,8 +40,6 @@ static void aperfmperf_snapshot_khz(void
>  	u64 aperf, aperf_delta;
>  	u64 mperf, mperf_delta;
>  	struct aperfmperf_sample *s = this_cpu_ptr(&samples);
> -	ktime_t now = ktime_get();
> -	s64 time_delta = ktime_ms_delta(now, s->time);
>  	unsigned long flags;
>  
>  	local_irq_save(flags);
> @@ -57,38 +57,68 @@ static void aperfmperf_snapshot_khz(void
>  	if (mperf_delta == 0)
>  		return;
>  
> -	s->time = now;
> +	s->time = ktime_get();
>  	s->aperf = aperf;
>  	s->mperf = mperf;
> -
> -	/* If the previous iteration was too long ago, discard it. */
> -	if (time_delta > APERFMPERF_STALE_THRESHOLD_MS)
> -		s->khz = 0;
> -	else
> -		s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);
> +	s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);
>  }
>  
> -unsigned int arch_freq_get_on_cpu(int cpu)
> +static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
>  {
> -	s64 time_delta;
> -	unsigned int khz;
> +	s64 time_delta = ktime_ms_delta(now, per_cpu(samples.time, cpu));
> +
> +	/* Don't bother re-computing within the cache threshold time. */
> +	if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
> +		return true;
> +
> +	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
> +
> +	/* Return false if the previous iteration was too long ago. */
> +	return time_delta <= APERFMPERF_STALE_THRESHOLD_MS;
> +}
>  
> +unsigned int aperfmperf_get_khz(int cpu)
> +{
>  	if (!cpu_khz)
>  		return 0;
>  
>  	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
>  		return 0;
>  
> -	/* Don't bother re-computing within the cache threshold time. */
> -	time_delta = ktime_ms_delta(ktime_get(), per_cpu(samples.time, cpu));
> -	khz = per_cpu(samples.khz, cpu);
> -	if (khz && time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
> -		return khz;
> +	aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
> +	return per_cpu(samples.khz, cpu);
> +}
>  
> -	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
> -	khz = per_cpu(samples.khz, cpu);
> -	if (khz)
> -		return khz;
> +void arch_freq_prepare_all(void)
> +{
> +	ktime_t now = ktime_get();
> +	bool wait = false;
> +	int cpu;
> +
> +	if (!cpu_khz)
> +		return;
> +
> +	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
> +		return;
> +
> +	for_each_online_cpu(cpu)
> +		if (!aperfmperf_snapshot_cpu(cpu, now, false))
> +			wait = true;
> +
> +	if (wait)
> +		msleep(APERFMPERF_REFRESH_DELAY_MS);
> +}
> +
> +unsigned int arch_freq_get_on_cpu(int cpu)
> +{
> +	if (!cpu_khz)
> +		return 0;
> +
> +	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
> +		return 0;
> +
> +	if (aperfmperf_snapshot_cpu(cpu, ktime_get(), true))
> +		return per_cpu(samples.khz, cpu);
>  
>  	msleep(APERFMPERF_REFRESH_DELAY_MS);
>  	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
> Index: linux-pm/arch/x86/kernel/cpu/cpu.h
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/cpu/cpu.h
> +++ linux-pm/arch/x86/kernel/cpu/cpu.h
> @@ -47,4 +47,7 @@ extern const struct cpu_dev *const __x86
>  
>  extern void get_cpu_cap(struct cpuinfo_x86 *c);
>  extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
> +
> +unsigned int aperfmperf_get_khz(int cpu);
> +
>  #endif /* ARCH_X86_CPU_H */
> Index: linux-pm/fs/proc/cpuinfo.c
> ===================================================================
> --- linux-pm.orig/fs/proc/cpuinfo.c
> +++ linux-pm/fs/proc/cpuinfo.c
> @@ -1,12 +1,18 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <linux/cpufreq.h>
>  #include <linux/fs.h>
>  #include <linux/init.h>
>  #include <linux/proc_fs.h>
>  #include <linux/seq_file.h>
>  
> +__weak void arch_freq_prepare_all(void)
> +{
> +}
> +
>  extern const struct seq_operations cpuinfo_op;
>  static int cpuinfo_open(struct inode *inode, struct file *file)
>  {
> +	arch_freq_prepare_all();
>  	return seq_open(file, &cpuinfo_op);
>  }
>  
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -917,6 +917,7 @@ static inline bool policy_has_boost_freq
>  }
>  #endif
>  
> +extern void arch_freq_prepare_all(void);
>  extern unsigned int arch_freq_get_on_cpu(int cpu);
>  
>  extern void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
> 
