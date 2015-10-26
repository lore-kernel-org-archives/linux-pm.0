From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 3/4] cpufreq: imx6q: Fix regulator/clock error handling
Date: Mon, 26 Oct 2015 08:38:35 +0100
Message-ID: <20151026073835.GW14476@pengutronix.de>
References: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
 <1445503652-777-4-git-send-email-s.hauer@pengutronix.de>
 <20151022133315.GE3897@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50157 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbbJZHii (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2015 03:38:38 -0400
Content-Disposition: inline
In-Reply-To: <20151022133315.GE3897@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>

On Thu, Oct 22, 2015 at 07:03:15PM +0530, Viresh Kumar wrote:
> On 22-10-15, 10:47, Sascha Hauer wrote:
> > +	arm_reg = regulator_get(cpu_dev, "arm");
> > +	if (IS_ERR(arm_reg))
> > +		return PTR_ERR(arm_reg);
> > +
> > +	pu_reg = regulator_get_optional(cpu_dev, "pu");
> 
> Yes, current code doesn't care about if this failed, but if that's the
> intention please add a comment for it now.

This is fixed right in the next patch.

> 
> > +	soc_reg = regulator_get(cpu_dev, "soc");
> > +	if (IS_ERR(soc_reg))
> > +		return PTR_ERR(soc_reg);
> > +
> > +	return 0;
> > +}
> > +
> > +
> > +static void imx6q_cpufreq_put_resources(void)
> > +{
> > +	if (!IS_ERR_OR_NULL(arm_reg))
> > +		regulator_put(arm_reg);
> > +	arm_reg = NULL;
> 
> Can you please clarify (maybe again) why this is required to be set to
> NULL again?

Ok.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
