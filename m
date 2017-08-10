From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] cpufreq: x86: Disable interrupts during MSRs reading
Date: Thu, 10 Aug 2017 01:05:15 -0400
Message-ID: <CAJvTdKkntuTGQ81iHTn8mjxE4B8eniOEFceECr86K6j_uwq2Tw@mail.gmail.com>
References: <1502226769-5670-1-git-send-email-dsmythies@telus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502226769-5670-1-git-send-email-dsmythies@telus.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <doug.smythies@gmail.com>
Cc: X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rafael@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

thanks, Doug!

Rafael,

Reviewed-by: Len Brown <len.brown@intel.com>


On Tue, Aug 8, 2017 at 5:12 PM, Doug Smythies <doug.smythies@gmail.com> wrote:
> According to Intel 64 and IA-32 Architectures SDM, Volume 3,
> Chapter 14.2, "Software needs to exercise care to avoid delays
> between the two RDMSRs (for example interrupts)".
>
> So, disable interrupts during reading MSRs IA32_APERF and IA32_MPERF.
>
> See also:
> commit 4ab60c3f32c721e46217e762bcd3e55a8f659c04
> cpufreq: intel_pstate: Disable interrupts during MSRs reading
>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>  arch/x86/kernel/cpu/aperfmperf.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> index 7cf7c70..0ee8332 100644
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -40,13 +40,16 @@ static void aperfmperf_snapshot_khz(void *dummy)
>         struct aperfmperf_sample *s = this_cpu_ptr(&samples);
>         ktime_t now = ktime_get();
>         s64 time_delta = ktime_ms_delta(now, s->time);
> +       unsigned long flags;
>
>         /* Don't bother re-computing within the cache threshold time. */
>         if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
>                 return;
>
> +       local_irq_save(flags);
>         rdmsrl(MSR_IA32_APERF, aperf);
>         rdmsrl(MSR_IA32_MPERF, mperf);
> +       local_irq_restore(flags);
>
>         aperf_delta = aperf - s->aperf;
>         mperf_delta = mperf - s->mperf;
> --
> 2.7.4
>



-- 
Len Brown, Intel Open Source Technology Center
