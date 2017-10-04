From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Move error message to debug level
Date: Wed, 4 Oct 2017 12:19:00 +0530
Message-ID: <20171004064900.GA28593@vireshk-i7>
References: <1506706789-7717-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:45357 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdJDGtD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2017 02:49:03 -0400
Received: by mail-pg0-f45.google.com with SMTP id b192so2948341pga.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Oct 2017 23:49:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1506706789-7717-1-git-send-email-fabio.estevam@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, festevam@gmail.com, shawnguo@kernel.org, anson.huang@nxp.com

On 29-09-17, 14:39, Fabio Estevam wrote:
> On some i.MX6 platforms which do not have speed grading
> check, opp table will not be created in platform code,
> so cpufreq driver prints the following error message:
> 
> cpu cpu0: dev_pm_opp_get_opp_count: OPP table not found (-19)
> 
> However, this is not really an error in this case because the
> imx6q-cpufreq driver first calls dev_pm_opp_get_opp_count()
> and if it fails, it means that platform code does not provide
> OPP and then dev_pm_opp_of_add_table() will be called.
> 
> In order to avoid such confusing error message, move it to
> debug level.
> 
> It is up to the caller of dev_pm_opp_get_opp_count() to check its
> return value and decide if it will print an error or not.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Previous discussion on this topic:
> https://patchwork.kernel.org/patch/9295059/
> 
>  drivers/base/power/opp/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> index a6de325..0459b12 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -296,7 +296,7 @@ int dev_pm_opp_get_opp_count(struct device *dev)
>  	opp_table = _find_opp_table(dev);
>  	if (IS_ERR(opp_table)) {
>  		count = PTR_ERR(opp_table);
> -		dev_err(dev, "%s: OPP table not found (%d)\n",
> +		dev_dbg(dev, "%s: OPP table not found (%d)\n",
>  			__func__, count);
>  		return count;
>  	}

Applied. Thanks.

-- 
viresh
