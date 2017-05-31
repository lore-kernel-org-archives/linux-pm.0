From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 7/7] thermal: max77620: fix pinmux conflict on reprobe
Date: Wed, 31 May 2017 10:23:26 +0200
Message-ID: <20170531082326.GA6735@localhost>
References: <20170530162554.26159-1-johan@kernel.org>
 <20170530162554.26159-8-johan@kernel.org>
 <20170530185707.GF7419@u40b0340c692b58f6553c.ant.amazon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170530185707.GF7419@u40b0340c692b58f6553c.ant.amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduval@amazon.com>
Cc: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Peter Chen <peter.chen@freescale.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sricharan R <sricharan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On Tue, May 30, 2017 at 11:57:07AM -0700, Eduardo Valentin wrote:
> On Tue, May 30, 2017 at 06:25:54PM +0200, Johan Hovold wrote:
> > Use the new helper for reusing a device-tree node of another device
> > instead of managing the node references explicitly.
> > 
> > This also makes sure that the new of_node_reuse flag is set if the
> > device is ever reprobed, something which specifically now avoids driver
> > core from attempting to claim any pinmux resources already claimed by
> > the parent device.
> > 
> > Fixes: ec4664b3fd6d ("thermal: max77620: Add thermal driver for reporting junction temp")
> > Cc: Laxman Dewangan <ldewangan@nvidia.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/thermal/max77620_thermal.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/thermal/max77620_thermal.c b/drivers/thermal/max77620_thermal.c
> > index 71d35f3c9215..159bbcee8821 100644
> > --- a/drivers/thermal/max77620_thermal.c
> > +++ b/drivers/thermal/max77620_thermal.c
> > @@ -112,12 +112,10 @@ static int max77620_thermal_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	/*
> > -	 * Drop any current reference to a device-tree node and get a
> > -	 * reference to the parent's node which will be balanced on reprobe or
> > -	 * on platform-device release.
> > +	 * The reference taken to the parent's node which will be balanced on
> > +	 * reprobe or on platform-device release.
> >  	 */
> > -	of_node_put(pdev->dev.of_node);
> > -	pdev->dev.of_node = of_node_get(pdev->dev.parent->of_node);
> > +	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
> 
> Should this one be squashed with patch 6/7?

I separated the two fixes this way as 6/7 does not depend on the rest of
the series and could be backported to stable, while this one fixes
something that has never worked (e.g. deferred probe of the thermal
child when the parent has a pinctrl configuration) and therefore is not
stable material.

Thanks,
Johan
