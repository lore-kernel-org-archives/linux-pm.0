From: Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH v5 5/6] usb: chipidea: let chipidea core device of_node
 equal's glue layer device of_node
Date: Wed, 10 Aug 2016 09:00:15 +0000
Message-ID: <AM4PR04MB2130F9E9E9E304D47C44AC46891D0@AM4PR04MB2130.eurprd04.prod.outlook.com>
References: <1470646331-23227-1-git-send-email-peter.chen@nxp.com>
 <1470646331-23227-6-git-send-email-peter.chen@nxp.com>
 <147078813636.20133.1120685098868481913@sboyd-linaro>
 <20160810031146.GE1879@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160810031146.GE1879@shlinux2>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Chen <hzpeterchen@gmail.com>, Stephen Boyd <stephen.boyd@linaro.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Peter Chen <peter.chen@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "k.kozlowski@samsung.com" <k.kozlowski@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "stillcompiling@gmail.com" <stillcompiling@gmail.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "mka@chromium.org" <mka@chromium.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, Peter Chen <peter.chen@freescale.com>, "dwmw3@infradead.org" <dwmw3@infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>, "arnd@arndb.de" <arnd@arndb.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, troy.
List-Id: linux-pm@vger.kernel.org

Hi, Peter

> -----Original Message-----
> From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-
> owner@vger.kernel.org] On Behalf Of Peter Chen
> Sent: Wednesday, August 10, 2016 11:12 AM
> To: Stephen Boyd <stephen.boyd@linaro.org>
> Cc: Peter Chen <peter.chen@nxp.com>; gregkh@linuxfoundation.org;
> stern@rowland.harvard.edu; ulf.hansson@linaro.org; broonie@kernel.org;
> sre@kernel.org; robh+dt@kernel.org; shawnguo@kernel.org;
> dbaryshkov@gmail.com; dwmw3@infradead.org; k.kozlowski@samsung.com; linux-
> arm-kernel@lists.infradead.org; p.zabel@pengutronix.de;
> devicetree@vger.kernel.org; pawel.moll@arm.com; mark.rutland@arm.com;
> linux-usb@vger.kernel.org; arnd@arndb.de; s.hauer@pengutronix.de;
> mail@maciej.szmigiero.name; troy.kisky@boundarydevices.com;
> festevam@gmail.com; oscar@naiandei.net; linux-pm@vger.kernel.org;
> stillcompiling@gmail.com; linux-kernel@vger.kernel.org; mka@chromium.org;
> Peter Chen <peter.chen@freescale.com>
> Subject: Re: [PATCH v5 5/6] usb: chipidea: let chipidea core device
> of_node equal's glue layer device of_node
> 
> On Tue, Aug 09, 2016 at 05:15:36PM -0700, Stephen Boyd wrote:
> > Quoting Peter Chen (2016-08-08 01:52:10)
> > > From: Peter Chen <peter.chen@freescale.com>
> > >
> > > At device tree, we have no device node for chipidea core, the glue
> > > layer's node is the parent node for host and udc device. But in
> > > related driver, the parent device is chipidea core. So, in order to
> > > let the common driver get parent's node, we let the core's device
> > > node equals glue layer device node.
> > >
> > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > > Tested-by Joshua Clayton <stillcompiling@gmail.com>
> > > ---
> > >  drivers/usb/chipidea/core.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/usb/chipidea/core.c
> > > b/drivers/usb/chipidea/core.c index 69426e6..b189dc7 100644
> > > --- a/drivers/usb/chipidea/core.c
> > > +++ b/drivers/usb/chipidea/core.c
> > > @@ -954,6 +954,15 @@ static int ci_hdrc_probe(struct platform_device
> *pdev)
> > >                 dev_err(dev, "unable to init phy: %d\n", ret);
> > >                 return ret;
> > >         }
> > > +       /*
> > > +        * At device tree, we have no device node for chipidea core,
> > > +        * the glue layer's node is the parent node for host and udc
> > > +        * device. But in related driver, the parent device is
> chipidea
> > > +        * core. So, in order to let the common driver get parent's
> node,
> > > +        * we let the core's device node equals glue layer's node.
> > > +        */
> > > +       if (dev->parent && dev->parent->of_node)
> > > +               dev->of_node = dev->parent->of_node;
> >
> > Can this be done earlier? Perhaps after hw_device_init() in this probe
> > routine? That would allow me to remove the awkward parent searching in
> > my ULPI DT awareness patch.
> 
> The reason why I locate it there is to avoid "goto label" for error path
> during PHY's get and initialization operation.
> 
> Ok, to simplify your work, I will change it at next version.

As iommu need this to be done even more earlier, will you consider to
put it before adding the core's platform device?

Li Jun 
> 
> --
> 
> Best Regards,
> Peter Chen
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
