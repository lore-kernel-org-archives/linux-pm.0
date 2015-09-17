From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: integrator: Fix module autoload for OF platform
 driver
Date: Thu, 17 Sep 2015 07:27:56 +0530
Message-ID: <20150917015756.GQ29943@linux>
References: <20150916202446.GA4303@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35916 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbbIQB6C (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 21:58:02 -0400
Received: by padhk3 with SMTP id hk3so5022747pad.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2015 18:58:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150916202446.GA4303@goodgumbo.baconseed.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 16-09-15, 22:24, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> ---
> 
> Hello,
> 
> This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
> that information so modules have the correct aliases built-in and
> autoloading works correctly.
> 
> A longer explanation by Javier Canillas can be found here:
> https://lkml.org/lkml/2015/7/30/519
> 
> Thanks,
> Luis
> 
>  drivers/cpufreq/integrator-cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/integrator-cpufreq.c b/drivers/cpufreq/integrator-cpufreq.c
> index 2faa421..79e3ff2 100644
> --- a/drivers/cpufreq/integrator-cpufreq.c
> +++ b/drivers/cpufreq/integrator-cpufreq.c
> @@ -221,6 +221,8 @@ static const struct of_device_id integrator_cpufreq_match[] = {
>  	{ },
>  };
>  
> +MODULE_DEVICE_TABLE(of, integrator_cpufreq_match);
> +
>  static struct platform_driver integrator_cpufreq_driver = {
>  	.driver = {
>  		.name = "integrator-cpufreq",

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
