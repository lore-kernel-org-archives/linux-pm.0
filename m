From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: imx: fix regulator_get_optional error
 handling
Date: Wed, 21 Oct 2015 16:32:18 +0530
Message-ID: <20151021110218.GC7784@ubuntu>
References: <56238131.7010907@web.de>
 <20151020133102.GM14356@pengutronix.de>
 <20151020134404.GA954@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33991 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbbJULCY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2015 07:02:24 -0400
Received: by padhk11 with SMTP id hk11so52233952pad.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2015 04:02:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151020134404.GA954@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Heiner Kallweit <heiner.kallweit@web.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 20-10-15, 15:44, Sascha Hauer wrote:
> +static int imx6q_cpufreq_put_resources(struct platform_device *pdev)
> +{
> +	if (!IS_ERR_OR_NULL(arm_reg))
> +		regulator_put(arm_reg);

You can simply put them, regulator core takes care of this.

-- 
viresh
