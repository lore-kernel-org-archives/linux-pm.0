From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] tools/power turbostat: changed bclk discovery path
 for Intel Xeon x200 Architecture
Date: Sat, 13 Feb 2016 01:21:24 -0500
Message-ID: <CAJvTdKmOdxhfYzytGu4xw+qSU+28+SCCQ7gn_ULahGPLz2FYOw@mail.gmail.com>
References: <CAJZ5v0hyAeK9L+NcETZQXJKfmr+TX59bZ+759RbXz_we3wgzpg@mail.gmail.com>
	<1455118517-14180-1-git-send-email-hubert.chrzaniuk@intel.com>
	<1455118517-14180-3-git-send-email-hubert.chrzaniuk@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36511 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcBMGVZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 13 Feb 2016 01:21:25 -0500
Received: by mail-lf0-f68.google.com with SMTP id h198so5087222lfh.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2016 22:21:25 -0800 (PST)
In-Reply-To: <1455118517-14180-3-git-send-email-hubert.chrzaniuk@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
Cc: lukasz.anaczkowski@intel.com, "Brown, Len" <len.brown@intel.com>, dasaratharaman.chandramouli@intel.com, Linux PM list <linux-pm@vger.kernel.org>

Applied.

thanks,
-Len


On Wed, Feb 10, 2016 at 10:35 AM, Hubert Chrzaniuk
<hubert.chrzaniuk@intel.com> wrote:
> x200 does not enable any way to programmatically obtain bus clock
> speed. Bclk for the architecture has a fixed value of 100 MHz.
> At the same time x200 cannot be included in has_snb_msrs since
> it does not support C7 idle state.
>
> Signed-off-by: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 765c669..3a59aec 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -2601,7 +2601,7 @@ double slm_bclk(void)
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



-- 
Len Brown, Intel Open Source Technology Center
