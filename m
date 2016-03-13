From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/2] tools/power turbostat: bugfix: TDP MSRs print bits fixing
Date: Sun, 13 Mar 2016 03:38:53 -0400
Message-ID: <CAJvTdK=XtuQuR2=ECfcF30p__0pyHhg_AKJqFs_3A8cJ0iix0g@mail.gmail.com>
References: <cover.1450011064.git.yu.c.chen@intel.com>
	<a941ab01b962ac057bd67d3bb397fe41ac548b79.1450011064.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:34578 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbcCMHiz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 13 Mar 2016 03:38:55 -0400
In-Reply-To: <a941ab01b962ac057bd67d3bb397fe41ac548b79.1450011064.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Applied -- thanks!

-Len


On Sun, Dec 13, 2015 at 8:09 AM, Chen Yu <yu.c.chen@intel.com> wrote:
> MSR_CONFIG_TDP_NOMINAL:
> should print all 8 bits of base_ratio (bit 0:7) 0xFF
>
> MSR_CONFIG_TDP_LEVEL_1:
> should print all 15 bits of PKG_MIN_PWR_LVL1 (bit 48:62) 0x7FFF
> should print all 15 bits of PKG_MAX_PWR_LVL1 (bit 32:46) 0x7FFF
> should print all 8 bits of LVL1_RATIO (bit 16:23) 0xFF
> should print all 15 bits of PKG_TDP_LVL1 (bit 0:14) 0x7FFF
>
> And the same modification to MSR_CONFIG_TDP_LEVEL_2.
>
> MSR_TURBO_ACTIVATION_RATIO:
> should print all 8 bits of MAX_NON_TURBO_RATIO (bit 0:7) 0xFF
>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 0dac7e0..9854929 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -1409,25 +1409,25 @@ dump_config_tdp(void)
>
>         get_msr(base_cpu, MSR_CONFIG_TDP_NOMINAL, &msr);
>         fprintf(stderr, "cpu%d: MSR_CONFIG_TDP_NOMINAL: 0x%08llx", base_cpu, msr);
> -       fprintf(stderr, " (base_ratio=%d)\n", (unsigned int)msr & 0xEF);
> +       fprintf(stderr, " (base_ratio=%d)\n", (unsigned int)msr & 0xFF);
>
>         get_msr(base_cpu, MSR_CONFIG_TDP_LEVEL_1, &msr);
>         fprintf(stderr, "cpu%d: MSR_CONFIG_TDP_LEVEL_1: 0x%08llx (", base_cpu, msr);
>         if (msr) {
> -               fprintf(stderr, "PKG_MIN_PWR_LVL1=%d ", (unsigned int)(msr >> 48) & 0xEFFF);
> -               fprintf(stderr, "PKG_MAX_PWR_LVL1=%d ", (unsigned int)(msr >> 32) & 0xEFFF);
> -               fprintf(stderr, "LVL1_RATIO=%d ", (unsigned int)(msr >> 16) & 0xEF);
> -               fprintf(stderr, "PKG_TDP_LVL1=%d", (unsigned int)(msr) & 0xEFFF);
> +               fprintf(stderr, "PKG_MIN_PWR_LVL1=%d ", (unsigned int)(msr >> 48) & 0x7FFF);
> +               fprintf(stderr, "PKG_MAX_PWR_LVL1=%d ", (unsigned int)(msr >> 32) & 0x7FFF);
> +               fprintf(stderr, "LVL1_RATIO=%d ", (unsigned int)(msr >> 16) & 0xFF);
> +               fprintf(stderr, "PKG_TDP_LVL1=%d", (unsigned int)(msr) & 0x7FFF);
>         }
>         fprintf(stderr, ")\n");
>
>         get_msr(base_cpu, MSR_CONFIG_TDP_LEVEL_2, &msr);
>         fprintf(stderr, "cpu%d: MSR_CONFIG_TDP_LEVEL_2: 0x%08llx (", base_cpu, msr);
>         if (msr) {
> -               fprintf(stderr, "PKG_MIN_PWR_LVL2=%d ", (unsigned int)(msr >> 48) & 0xEFFF);
> -               fprintf(stderr, "PKG_MAX_PWR_LVL2=%d ", (unsigned int)(msr >> 32) & 0xEFFF);
> -               fprintf(stderr, "LVL2_RATIO=%d ", (unsigned int)(msr >> 16) & 0xEF);
> -               fprintf(stderr, "PKG_TDP_LVL2=%d", (unsigned int)(msr) & 0xEFFF);
> +               fprintf(stderr, "PKG_MIN_PWR_LVL2=%d ", (unsigned int)(msr >> 48) & 0x7FFF);
> +               fprintf(stderr, "PKG_MAX_PWR_LVL2=%d ", (unsigned int)(msr >> 32) & 0x7FFF);
> +               fprintf(stderr, "LVL2_RATIO=%d ", (unsigned int)(msr >> 16) & 0xFF);
> +               fprintf(stderr, "PKG_TDP_LVL2=%d", (unsigned int)(msr) & 0x7FFF);
>         }
>         fprintf(stderr, ")\n");
>
> @@ -1440,7 +1440,7 @@ dump_config_tdp(void)
>
>         get_msr(base_cpu, MSR_TURBO_ACTIVATION_RATIO, &msr);
>         fprintf(stderr, "cpu%d: MSR_TURBO_ACTIVATION_RATIO: 0x%08llx (", base_cpu, msr);
> -       fprintf(stderr, "MAX_NON_TURBO_RATIO=%d", (unsigned int)(msr) & 0x7F);
> +       fprintf(stderr, "MAX_NON_TURBO_RATIO=%d", (unsigned int)(msr) & 0xFF);
>         fprintf(stderr, " lock=%d", (unsigned int)(msr >> 31) & 1);
>         fprintf(stderr, ")\n");
>  }
> --
> 1.8.4.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Len Brown, Intel Open Source Technology Center
