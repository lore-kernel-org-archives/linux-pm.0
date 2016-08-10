From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v5 5/6] usb: chipidea: let chipidea core device of_node
 equal's glue layer device of_node
Date: Wed, 10 Aug 2016 11:11:46 +0800
Message-ID: <20160810031146.GE1879@shlinux2>
References: <1470646331-23227-1-git-send-email-peter.chen@nxp.com>
 <1470646331-23227-6-git-send-email-peter.chen@nxp.com>
 <147078813636.20133.1120685098868481913@sboyd-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36079 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbcHJDVI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2016 23:21:08 -0400
Content-Disposition: inline
In-Reply-To: <147078813636.20133.1120685098868481913@sboyd-linaro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, Peter Chen <peter.chen@freescale.com>

On Tue, Aug 09, 2016 at 05:15:36PM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-08-08 01:52:10)
> > From: Peter Chen <peter.chen@freescale.com>
> > 
> > At device tree, we have no device node for chipidea core,
> > the glue layer's node is the parent node for host and udc
> > device. But in related driver, the parent device is chipidea
> > core. So, in order to let the common driver get parent's node,
> > we let the core's device node equals glue layer device node.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > Tested-by Joshua Clayton <stillcompiling@gmail.com>
> > ---
> >  drivers/usb/chipidea/core.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> > index 69426e6..b189dc7 100644
> > --- a/drivers/usb/chipidea/core.c
> > +++ b/drivers/usb/chipidea/core.c
> > @@ -954,6 +954,15 @@ static int ci_hdrc_probe(struct platform_device *pdev)
> >                 dev_err(dev, "unable to init phy: %d\n", ret);
> >                 return ret;
> >         }
> > +       /*
> > +        * At device tree, we have no device node for chipidea core,
> > +        * the glue layer's node is the parent node for host and udc
> > +        * device. But in related driver, the parent device is chipidea
> > +        * core. So, in order to let the common driver get parent's node,
> > +        * we let the core's device node equals glue layer's node.
> > +        */
> > +       if (dev->parent && dev->parent->of_node)
> > +               dev->of_node = dev->parent->of_node;
> 
> Can this be done earlier? Perhaps after hw_device_init() in this probe
> routine? That would allow me to remove the awkward parent searching in
> my ULPI DT awareness patch.

The reason why I locate it there is to avoid "goto label" for error
path during PHY's get and initialization operation.

Ok, to simplify your work, I will change it at next version.

-- 

Best Regards,
Peter Chen
