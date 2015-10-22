From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] cpufreq: imx6q: Fix wrong device in devm_kzalloc
Date: Thu, 22 Oct 2015 18:59:01 +0530
Message-ID: <20151022132901.GD3897@ubuntu>
References: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
 <1445503652-777-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33800 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756642AbbJVN3G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2015 09:29:06 -0400
Received: by padhk11 with SMTP id hk11so87175708pad.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2015 06:29:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1445503652-777-3-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>

On 22-10-15, 10:47, Sascha Hauer wrote:
> devm_kzalloc must be called with the device that is actually probed,
> not with cpu_dev which resources are not freed when probe fails.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index fabd144..7557d1e 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -260,7 +260,8 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Make imx6_soc_volt array's size same as arm opp number */
> -	imx6_soc_volt = devm_kzalloc(cpu_dev, sizeof(*imx6_soc_volt) * num, GFP_KERNEL);
> +	imx6_soc_volt = devm_kzalloc(&pdev->dev,
> +			sizeof(*imx6_soc_volt) * num, GFP_KERNEL);

Please rewrite it as:

	imx6_soc_volt = devm_kzalloc(&pdev->dev,
			             sizeof(*imx6_soc_volt) * num, GFP_KERNEL);

checkpatch --strict will warn against this.

-- 
viresh
