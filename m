From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix processing for turbo
 activation ratio
Date: Mon, 25 Apr 2016 15:48:38 +0200
Message-ID: <CAJZ5v0hnf32+012i9tDskFNrHzEeJgGp+e00rGHH17ooN5qSPw@mail.gmail.com>
References: <1461380039-13804-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35810 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbcDYNsk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Apr 2016 09:48:40 -0400
Received: by mail-lf0-f52.google.com with SMTP id c126so117333399lfb.2
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2016 06:48:39 -0700 (PDT)
In-Reply-To: <1461380039-13804-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Sat, Apr 23, 2016 at 4:53 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> When the config TDP level is not nominal (level = 0), the MSR values for
> reading level 1 and level 2 ratios contain power in low 14 bits and actual
> ratio bits are at bits [23:16]. The current processing for level 1 and
> level 2 is wrong as there is no shift done to get actual ratio.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Since this is a fix, do we need it in v4.6?

Do we want it in -stable too and in what -stable if so?


> ---
>  drivers/cpufreq/intel_pstate.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 1b2767d..03f94c2 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -813,6 +813,10 @@ static int core_get_max_pstate(void)
>                         if (err)
>                                 goto skip_tar;
>
> +                       /* For level 1 and 2, bits[23:16] contains ratio */
> +                       if (tdp_ctrl)
> +                               tdp_ratio >>= 16;
> +                       tdp_ratio &= 0xff; /* ratios are only 8 bits long */
>                         if (tdp_ratio - 1 == tar) {
>                                 max_pstate = tar;
>                                 pr_debug("max_pstate=TAC %x\n", max_pstate);
> --
