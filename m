From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] PM / domains: Align column headers and data in pm_genpd_summary output
Date: Tue, 11 Aug 2015 08:29:48 -0700
Message-ID: <7h4mk5sv0z.fsf@deeprootsystems.com>
References: <1439297449-29344-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35157 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965102AbbHKP3v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 11:29:51 -0400
Received: by pacgr6 with SMTP id gr6so53089257pac.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 08:29:50 -0700 (PDT)
In-Reply-To: <1439297449-29344-1-git-send-email-geert+renesas@glider.be>
	(Geert Uytterhoeven's message of "Tue, 11 Aug 2015 14:50:49 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maciej Matraszek <m.matraszek@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> "domain": header is indented by 4, data by 0 spaces => 0 spaces
> "/device": header is indented by 11, data by 4 spaces => 4 spaces
> "slaves": header is indented by 47, data by 49 spaces => 48 spaces
>
> Ruler:
>     1234567890123456789012345678901234567890123456789012345678901234567890
>
> Before:
>
> 	domain                      status         slaves
> 	       /device                                      runtime status
>     ----------------------------------------------------------------------
>     a3sp                            on               a2us
> 	/devices/platform/e60b0000.i2c                      suspended
>
> After:
>
>     domain                          status          slaves
> 	/device                                             runtime status
>     ----------------------------------------------------------------------
>     a3sp                            on              a2us
> 	/devices/platform/e60b0000.i2c                      suspended
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Kevin Hilman <khilman@linaro.org>

> ---
>  drivers/base/power/domain.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index c9bc913a938c31e0..a0a99d55022f5387 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2082,7 +2082,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
>  
>  	if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
>  		goto exit;
> -	seq_printf(s, "%-30s  %-15s  ", genpd->name, status_lookup[genpd->status]);
> +	seq_printf(s, "%-30s  %-15s ", genpd->name, status_lookup[genpd->status]);
>  
>  	/*
>  	 * Modifications on the list require holding locks on both
> @@ -2117,8 +2117,8 @@ static int pm_genpd_summary_show(struct seq_file *s, void *data)
>  	struct generic_pm_domain *genpd;
>  	int ret = 0;
>  
> -	seq_puts(s, "    domain                      status         slaves\n");
> -	seq_puts(s, "           /device                                      runtime status\n");
> +	seq_puts(s, "domain                          status          slaves\n");
> +	seq_puts(s, "    /device                                             runtime status\n");
>  	seq_puts(s, "----------------------------------------------------------------------\n");
>  
>  	ret = mutex_lock_interruptible(&gpd_list_lock);
