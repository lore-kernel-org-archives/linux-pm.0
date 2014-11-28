From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv3 1/1] thermal: cpu_cooling: check for the readiness of
 cpufreq layer
Date: Fri, 28 Nov 2014 17:10:24 +0000
Message-ID: <20141128171024.GW3836@n2100.arm.linux.org.uk>
References: <1417186410-24551-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39300 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbaK1RKj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 12:10:39 -0500
Content-Disposition: inline
In-Reply-To: <1417186410-24551-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, devicetree@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, linux-arm-kernel@lists.infradead.org

On Fri, Nov 28, 2014 at 10:53:30AM -0400, Eduardo Valentin wrote:
> diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
> index 3f5ad25..d4eaa1b 100644
> --- a/drivers/thermal/samsung/exynos_thermal_common.c
> +++ b/drivers/thermal/samsung/exynos_thermal_common.c
> @@ -371,9 +371,10 @@ int exynos_register_thermal(struct thermal_sensor_conf *sensor_conf)
>  		th_zone->cool_dev[th_zone->cool_dev_size] =
>  					cpufreq_cooling_register(&mask_val);
>  		if (IS_ERR(th_zone->cool_dev[th_zone->cool_dev_size])) {
> -			dev_err(sensor_conf->dev,
> -				"Failed to register cpufreq cooling device\n");
> -			ret = -EINVAL;
> +			ret = PTR_ERR(th_zone->cool_dev[th_zone->cool_dev_size]);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(sensor_conf->dev,
> +					"Failed to register cpufreq cooling device\n");

Something which bugs me quite a lot is when there is an error code (which
tells you why something didn't work) and you have an error message, and
the error message doesn't bother printing the error code.

You might as well just print "Failed\n" and leave it at that, or md5sum
the error message and print the sum instead. :)

Knowing why something failed allows you to read the source, and find
possible reasons for the failure (which could come down to one reason)
and allows faster resolution of the problem.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
