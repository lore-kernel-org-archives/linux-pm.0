From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/2] tools/power turbostat: Fixed turbo ratio stats for
 Intel Xeon x200 family
Date: Sat, 13 Feb 2016 01:21:01 -0500
Message-ID: <CAJvTdKnDRywmLpvRKpmFwW9L=5UddmLUZjS=MHXfcZgjVOgRug@mail.gmail.com>
References: <CAJZ5v0hyAeK9L+NcETZQXJKfmr+TX59bZ+759RbXz_we3wgzpg@mail.gmail.com>
	<1455118517-14180-1-git-send-email-hubert.chrzaniuk@intel.com>
	<1455118517-14180-2-git-send-email-hubert.chrzaniuk@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35304 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcBMGVD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 13 Feb 2016 01:21:03 -0500
Received: by mail-lf0-f67.google.com with SMTP id j99so5085966lfi.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2016 22:21:02 -0800 (PST)
In-Reply-To: <1455118517-14180-2-git-send-email-hubert.chrzaniuk@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
Cc: lukasz.anaczkowski@intel.com, "Brown, Len" <len.brown@intel.com>, dasaratharaman.chandramouli@intel.com, Linux PM list <linux-pm@vger.kernel.org>

Applied (replacing the previous version of this patch I had in my tree)

thanks,
-Len

On Wed, Feb 10, 2016 at 10:35 AM, Hubert Chrzaniuk
<hubert.chrzaniuk@intel.com> wrote:
> Following changes have been made:
> - changed MSR_NHM_TURBO_RATIO_LIMIT to MSR_TURBO_RATIO_LIMIT in debug print
>   for consistency with Developer Manual
> - updated definition of bitfields in MSR_TURBO_RATIO_LIMIT and appropriate
>   parsing code
> - added x200 to list of architectures that do not support Nahlem compatible
>   definition of MSR_TURBO_RATIO_LIMIT register (x200 has the register but
>   bits definition is custom)
> - fixed typo in code that parses MSR_TURBO_RATIO_LIMIT
>   (logical instead of bitwise operator)
> - changed loop break condition because two concurrent turbo buckets may
>   have zero delta ratio which would be still valid and no necessarily
>   last bucket
>
> Signed-off-by: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 0dac7e0..765c669 100644
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
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Len Brown, Intel Open Source Technology Center
