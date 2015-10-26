From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 4/4] cpufreq: imx6q: check regulator_get_optional return
 value
Date: Mon, 26 Oct 2015 09:17:46 +0100
Message-ID: <20151026081746.GX14476@pengutronix.de>
References: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
 <1445503652-777-5-git-send-email-s.hauer@pengutronix.de>
 <1445509395.3173.31.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50630 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbbJZIRt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2015 04:17:49 -0400
Content-Disposition: inline
In-Reply-To: <1445509395.3173.31.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>

On Thu, Oct 22, 2015 at 12:23:15PM +0200, Lucas Stach wrote:
> Am Donnerstag, den 22.10.2015, 10:47 +0200 schrieb Sascha Hauer:
> > While pu_reg is an optional regulator we still have to check
> > the return value for -EPROBE_DEFER to properly detect the
> > case when we have a pu regulator but it is not yet present.
> > 
> > While at it, set pu_reg to NULL for an erroneous regulator
> > so that we can check for the regulator with if (pu_reg)
> > instead of the slightly less readable IS_ERR().
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/cpufreq/imx6q-cpufreq.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> > index ce0c6bd..b643614 100644
> > --- a/drivers/cpufreq/imx6q-cpufreq.c
> > +++ b/drivers/cpufreq/imx6q-cpufreq.c
> > @@ -71,7 +71,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
> >  
> >  	/* scaling up?  scale voltage before frequency */
> >  	if (new_freq > old_freq) {
> > -		if (!IS_ERR(pu_reg)) {
> > +		if (pu_reg) {
> >  			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
> >  			if (ret) {
> >  				dev_err(cpu_dev, "failed to scale vddpu up: %d\n", ret);
> > @@ -148,7 +148,7 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
> >  			dev_warn(cpu_dev, "failed to scale vddsoc down: %d\n", ret);
> >  			ret = 0;
> >  		}
> > -		if (!IS_ERR(pu_reg)) {
> > +		if (pu_reg) {
> >  			ret = regulator_set_voltage_tol(pu_reg, imx6_soc_volt[index], 0);
> >  			if (ret) {
> >  				dev_warn(cpu_dev, "failed to scale vddpu down: %d\n", ret);
> > @@ -217,6 +217,11 @@ static int imx6q_cpufreq_get_resources(struct platform_device *pdev)
> >  		return PTR_ERR(arm_reg);
> >  
> >  	pu_reg = regulator_get_optional(cpu_dev, "pu");
> > +	if (IS_ERR(pu_reg)) {
> > +		if (PTR_ERR(pu_reg) == -EPROBE_DEFER)
> > +			return -EPROBE_DEFER;
> > +		pu_reg = NULL;
> > +	}
> 
> The PU regulator isn't really optional for MX6 Q/DL (where it is present
> in hardware) as the datasheet clearly specifies that it needs to be set
> to the same voltage as SOC. Could you change this to request this
> regulator as non-optional for those chip derivatives and skip the
> request otherwise?

i.MX6SL also has the pu-reg, so this would become

	if (of_machine_is_compatible("fsl,imx6q") ||
	    of_machine_is_compatible("fsl,imx6dl") ||
	    of_machine_is_compatible("fsl,imx6sl))

Not really nice. Also we already have a
of_machine_is_compatible("fsl,imx6ul") in the driver. It seems the
knowledge about (struct platform_device)->id_table is already lost
nowadays. I think this should be used here to distinguish between the
different devices.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
