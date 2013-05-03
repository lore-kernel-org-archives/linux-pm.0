From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH 4/6] Thermal: kirkwood: Remove redundant platform_set_drvdata()
Date: Sat, 4 May 2013 03:24:23 +0900
Message-ID: <CABMQnV+Vr4gzJh9NMU9xAz9B7X5R2R9j9q0hUnDPBCThbhzZXQ@mail.gmail.com>
References: <1367575034-18432-1-git-send-email-sachin.kamat@linaro.org> <1367575034-18432-4-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:43239 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762899Ab3ECSYz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 14:24:55 -0400
Received: by mail-la0-f51.google.com with SMTP id ep20so1776511lab.10
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2013 11:24:54 -0700 (PDT)
In-Reply-To: <1367575034-18432-4-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, eduardo.valentin@ti.com, rui.zhang@intel.com, patches@linaro.org

2013/5/3 Sachin Kamat <sachin.kamat@linaro.org>:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Acked-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

> ---
>  drivers/thermal/kirkwood_thermal.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
> index dfeceaf..b57a45d 100644
> --- a/drivers/thermal/kirkwood_thermal.c
> +++ b/drivers/thermal/kirkwood_thermal.c
> @@ -108,7 +108,6 @@ static int kirkwood_thermal_exit(struct platform_device *pdev)
>                 platform_get_drvdata(pdev);
>
>         thermal_zone_device_unregister(kirkwood_thermal);
> -       platform_set_drvdata(pdev, NULL);
>
>         return 0;
>  }
> --
> 1.7.9.5
>



-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
