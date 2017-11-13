From: WANG Chao <chao.wang@ucloud.cn>
Subject: Re: [PATCH] x86 / CPU: Avoid unnecessary IPIs in
 arch_freq_get_on_cpu()
Date: Mon, 13 Nov 2017 11:00:56 +0800
Message-ID: <20171113030056.GA43577@WANG-Chaos-MacBook-Pro.local>
References: <1830825.NTYOMyctnU@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m97139.mail.qiye.163.com ([220.181.97.139]:41744 "EHLO
        m97139.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbdKMDBq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Nov 2017 22:01:46 -0500
Content-Disposition: inline
In-Reply-To: <1830825.NTYOMyctnU@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>

On 11/13/17 at 02:15P, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Even though aperfmperf_snapshot_khz() caches the samples.khz value
> to return if called again in a sufficiently short time, its caller,
> arch_freq_get_on_cpu(), still uses smp_call_function_single() to run
> it which may allow user space to trigger an IPI storm by reading from
> the scaling_cur_freq cpufreq sysfs file in a tight loop.
> 
> To avoid that, move the decision on whether or not to return the
> cached samples.khz value to arch_freq_get_on_cpu().
> 
> Fixes: 4815d3c56d1e (cpufreq: x86: Make scaling_cur_freq behave more as expected)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks good to me.

Reviewed-by: WANG Chao <chao.wang@ucloud.cn>

> ---
> 
> This change was part of commit 941f5f0f6ef5 (x86: CPU: Fix up "cpu MHz" in
> /proc/cpuinfo), but it was not the reason for the revert and it remains
> applicable.
> 
> Thanks,
> Rafael
> 
> ---
>  arch/x86/kernel/cpu/Makefile     |    2 +-
>  arch/x86/kernel/cpu/aperfmperf.c |   11 +++++++----
>  arch/x86/kernel/cpu/proc.c       |    4 +++-
>  3 files changed, 11 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/arch/x86/kernel/cpu/aperfmperf.c
> ===================================================================
> --- linux-pm.orig/arch/x86/kernel/cpu/aperfmperf.c
> +++ linux-pm/arch/x86/kernel/cpu/aperfmperf.c
> @@ -42,10 +42,6 @@ static void aperfmperf_snapshot_khz(void
>  	s64 time_delta = ktime_ms_delta(now, s->time);
>  	unsigned long flags;
>  
> -	/* Don't bother re-computing within the cache threshold time. */
> -	if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
> -		return;
> -
>  	local_irq_save(flags);
>  	rdmsrl(MSR_IA32_APERF, aperf);
>  	rdmsrl(MSR_IA32_MPERF, mperf);
> @@ -74,6 +70,7 @@ static void aperfmperf_snapshot_khz(void
>  
>  unsigned int arch_freq_get_on_cpu(int cpu)
>  {
> +	s64 time_delta;
>  	unsigned int khz;
>  
>  	if (!cpu_khz)
> @@ -82,6 +79,12 @@ unsigned int arch_freq_get_on_cpu(int cp
>  	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
>  		return 0;
>  
> +	/* Don't bother re-computing within the cache threshold time. */
> +	time_delta = ktime_ms_delta(ktime_get(), per_cpu(samples.time, cpu));
> +	khz = per_cpu(samples.khz, cpu);
> +	if (khz && time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
> +		return khz;
> +
>  	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
>  	khz = per_cpu(samples.khz, cpu);
>  	if (khz)
> 
