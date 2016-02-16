From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Initialize regulator pointer to an error value
Date: Tue, 16 Feb 2016 06:30:59 +0530
Message-ID: <20160216010059.GH6334@vireshk-i7>
References: <1455544758-7718-1-git-send-email-jonathanh@nvidia.com>
 <743509d913cbc0e725bea52281be03b009e02bb5.1455553501.git.viresh.kumar@linaro.org>
 <17646703.2nZXD4icYj@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34377 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbcBPBBJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 20:01:09 -0500
Received: by mail-pa0-f47.google.com with SMTP id fy10so53984492pac.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2016 17:01:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <17646703.2nZXD4icYj@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>

Cc'ing Mark as well.

On 15-02-16, 21:38, Arnd Bergmann wrote:
> There is usually something else wrong if you have to check for both.
> Why exactly do you need to check for both IS_ERR and NULL?

And here is the reasoning behind it:
- It is normally said that 'NULL' is a valid clk. The same is
  applicable to regulators as well, right? At least, that is what
  below says:

  commit 4a511de96d69 ("cpufreq: cpufreq-cpu0: NULL is a valid
  regulator")

- And so I left the regulator pointer to NULL in OPP core.
- But then I realized that its not safe to call many regulator core
  APIs with NULL regulator, as those caused the crashes reported by
  multiple people now.
- clk APIs guarantee that they return early when NULL clk is passed to
  them.
- Do we need to do the same for regulator core as well ?

- And so I initialized the pointer to an error value now, as
  initializing it to NULL (possibly a valid regulator, in theory)
  isn't the right thing to do.

> > diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
> > index d7cd4e265766..146b6197d598 100644
> > --- a/drivers/base/power/opp/core.c
> > +++ b/drivers/base/power/opp/core.c
> > @@ -257,7 +257,7 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
> >  	}
> >  
> >  	reg = dev_opp->regulator;
> > -	if (IS_ERR_OR_NULL(reg)) {
> > +	if (IS_ERR(reg)) {
> >  		/* Regulator may not be required for device */
> >  		if (reg)
> >  			dev_err(dev, "%s: Invalid regulator (%ld)\n", __func__,
> > @@ -798,6 +798,9 @@ static struct device_opp *_add_device_opp(struct device *dev)
> >  		of_node_put(np);
> >  	}
> >  
> > +	/* Set regulator to a non-NULL error value */
> > +	dev_opp->regulator = ERR_PTR(-EFAULT);
> > +
> >  	/* Find clk for the device */
> >  	dev_opp->clk = clk_get(dev, NULL);
> >  	if (IS_ERR(dev_opp->clk)) {
> 
> -EFAULT has a very specific meaning (accessing an invalid pointer from
> user space), I don't think you want that one.

Sorry, wasn't aware of those requirements. What Rafael suggested is
the right thing to do then.

-- 
viresh
