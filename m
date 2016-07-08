From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH 5/6] usb: chipidea: host: let the hcd know's parent
 device node
Date: Fri, 8 Jul 2016 09:54:47 +0800
Message-ID: <20160708015447.GB27779@shlinux2>
References: <1467882892-27589-1-git-send-email-peter.chen@nxp.com>
 <1467882892-27589-6-git-send-email-peter.chen@nxp.com>
 <146793221122.31330.7571458363004882365@sboyd-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34712 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbcGHCCT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2016 22:02:19 -0400
Content-Disposition: inline
In-Reply-To: <146793221122.31330.7571458363004882365@sboyd-linaro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, linux-pm@vger.kernel.org, Peter Chen <peter.chen@freescale.com>

On Thu, Jul 07, 2016 at 03:56:51PM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-07-07 02:14:51)
> > diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> > index 053bac9..55120ef 100644
> > --- a/drivers/usb/chipidea/host.c
> > +++ b/drivers/usb/chipidea/host.c
> > @@ -109,15 +109,25 @@ static int host_start(struct ci_hdrc *ci)
> >         struct ehci_hcd *ehci;
> >         struct ehci_ci_priv *priv;
> >         int ret;
> > +       struct device *dev = ci->dev;
> >  
> > -       if (usb_disabled())
> > +       if (usb_disabled() || !dev)
> 
> Does that ever happen?

I don't think so, will delete it.

> 
> >                 return -ENODEV;
> >  
> > -       hcd = usb_create_hcd(&ci_ehci_hc_driver, ci->dev, dev_name(ci->dev));
> > +       /*
> > +        * USB Core will try to get child node under roothub,
> > +        * but chipidea core has no of_node, and the child node
> > +        * for controller is located at glue layer's node which
> > +        * is chipidea core's parent.
> > +        */
> > +       if (dev->parent && dev->parent->of_node)
> > +               dev->of_node = dev->parent->of_node;
> 
> Why not do this during the ci device probe? How is host special for
> having an of_node for the child device.
> 

Good idea. I did this when I added USB device DT support, but did not
consider potential gadget/phy use cases.

-- 

Best Regards,
Peter Chen
