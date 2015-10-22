From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/4] cpufreq: imx6q: Fix regulator/clock error handling
Date: Thu, 22 Oct 2015 19:03:15 +0530
Message-ID: <20151022133315.GE3897@ubuntu>
References: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
 <1445503652-777-4-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35464 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757680AbbJVNdT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2015 09:33:19 -0400
Received: by pasz6 with SMTP id z6so87111179pas.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2015 06:33:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1445503652-777-4-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>

On 22-10-15, 10:47, Sascha Hauer wrote:
> +	arm_reg = regulator_get(cpu_dev, "arm");
> +	if (IS_ERR(arm_reg))
> +		return PTR_ERR(arm_reg);
> +
> +	pu_reg = regulator_get_optional(cpu_dev, "pu");

Yes, current code doesn't care about if this failed, but if that's the
intention please add a comment for it now.

> +	soc_reg = regulator_get(cpu_dev, "soc");
> +	if (IS_ERR(soc_reg))
> +		return PTR_ERR(soc_reg);
> +
> +	return 0;
> +}
> +
> +
> +static void imx6q_cpufreq_put_resources(void)
> +{
> +	if (!IS_ERR_OR_NULL(arm_reg))
> +		regulator_put(arm_reg);
> +	arm_reg = NULL;

Can you please clarify (maybe again) why this is required to be set to
NULL again?

-- 
viresh
