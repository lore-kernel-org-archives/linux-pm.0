From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] tools/power turbostat: Fixed turbo ratio stats for Intel
 Xeon x200 family
Date: Tue, 9 Feb 2016 20:46:22 +0100
Message-ID: <CAJZ5v0hyAeK9L+NcETZQXJKfmr+TX59bZ+759RbXz_we3wgzpg@mail.gmail.com>
References: <1455028910-15049-1-git-send-email-hubert.chrzaniuk@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33715 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbcBITqX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 14:46:23 -0500
Received: by mail-lf0-f48.google.com with SMTP id m1so123652986lfg.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Feb 2016 11:46:23 -0800 (PST)
In-Reply-To: <1455028910-15049-1-git-send-email-hubert.chrzaniuk@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
Cc: "Anaczkowski, Lukasz" <lukasz.anaczkowski@intel.com>, Len Brown <len.brown@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi,

On Tue, Feb 9, 2016 at 3:41 PM, Hubert Chrzaniuk
<hubert.chrzaniuk@intel.com> wrote:
> Algorithm for calculating turbo ratio limits for Intel Xeon x200 family
> has some minor bugs. This patch fixes the routine.

This is a bit laconic.  Please at least write what the bugs are here.

Plus the patch adds some KNL-specific checks that aren't directly
related to the fixes, so it looks like there should be two patches
rather?

Thanks,
Rafael


> Signed-off-by: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 0dac7e0..3a59aec 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -1330,12 +1330,13 @@ dump_knl_turbo_ratio_limits(void)
>
>         get_msr(base_cpu, MSR_NHM_TURBO_RATIO_LIMIT, &msr);
>
> -       fprintf(stderr, "cpu%d: MSR_NHM_TURBO_RATIO_LIMIT: 0x%08llx\n",
> +       fprintf(stderr, "cpu%d: MSR_TURBO_RATIO_LIMIT: 0x%08llx\n",
>                 base_cpu, msr);
>
>         /**
>          * Turbo encoding in KNL is as follows:
> -        * [7:0] -- Base value of number of active cores of bucket 1.
> +        * [0] -- Reserved
> +        * [7:1] -- Base value of number of active cores of bucket 1.
>          * [15:8] -- Base value of freq ratio of bucket 1.
>          * [20:16] -- +ve delta of number of active cores of bucket 2.
>          * i.e. active cores of bucket 2 =
> @@ -1354,8 +1355,8 @@ dump_knl_turbo_ratio_limits(void)
>          * [60:56]-- +ve delta of number of active cores of bucket 7.
>          * [63:61]-- -ve delta of freq ratio of bucket 7.
>          */
> -       cores = msr & 0xFF;
> -       ratio = (msr >> 8) && 0xFF;
> +       cores = (msr & 0xFF) >> 1;
> +       ratio = (msr >> 8) & 0xFF;
>         if (ratio > 0)
>                 fprintf(stderr,
>                         "%d * %.0f = %.0f MHz max turbo %d active cores\n",
> @@ -1363,8 +1364,8 @@ dump_knl_turbo_ratio_limits(void)
>
>         for (i = 16; i < 64; i = i + 8) {
>                 delta_cores = (msr >> i) & 0x1F;
> -               delta_ratio = (msr >> (i + 5)) && 0x7;
> -               if (!delta_cores || !delta_ratio)
> +               delta_ratio = (msr >> (i + 5)) & 0x7;
> +               if (!delta_cores)
>                         return;
>                 cores = cores + delta_cores;
>                 ratio = ratio - delta_ratio;
> @@ -1889,6 +1890,7 @@ int has_nhm_turbo_ratio_limit(unsigned int family, unsigned int model)
>         /* Nehalem compatible, but do not include turbo-ratio limit support */
>         case 0x2E:      /* Nehalem-EX Xeon - Beckton */
>         case 0x2F:      /* Westmere-EX Xeon - Eagleton */
> +       case 0x57:      /* PHI - Knights Landing (different MSR definition) */
>                 return 0;
>         default:
>                 return 1;
> @@ -2599,7 +2601,7 @@ double slm_bclk(void)
>
>  double discover_bclk(unsigned int family, unsigned int model)
>  {
> -       if (has_snb_msrs(family, model))
> +       if (has_snb_msrs(family, model) || is_knl(family, model))
>                 return 100.00;
>         else if (is_slm(family, model))
>                 return slm_bclk();
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
