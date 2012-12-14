From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/2] thermal: Add support for thermal sensor for Orion SoC
Date: Fri, 14 Dec 2012 12:50:40 +0100
Message-ID: <20121214115040.GB7717@lunn.ch>
References: <1355482986-885-1-git-send-email-andrew@lunn.ch>
 <1355482986-885-2-git-send-email-andrew@lunn.ch>
 <4D68720C2E767A4AA6A8796D42C8EB59249564@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:46209 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309Ab2LNLuv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 14 Dec 2012 06:50:51 -0500
Content-Disposition: inline
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB59249564@BGSMSX101.gar.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux ARM <linux-arm-kernel@lists.infradead.org>, "iwamatsu@nigauri.org" <iwamatsu@nigauri.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>

On Fri, Dec 14, 2012 at 11:30:41AM +0000, R, Durgadoss wrote:
> > -----Original Message-----
> > From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> > owner@vger.kernel.org] On Behalf Of Andrew Lunn
> > Sent: Friday, December 14, 2012 4:33 PM
> > To: linux ARM; iwamatsu@nigauri.org; linux-pm@vger.kernel.org
> > Cc: Jason Cooper; Sebastian Hesselbarth; Thomas Petazzoni;
> > jgunthorpe@obsidianresearch.com; Andrew Lunn
> > Subject: [PATCH 1/2] thermal: Add support for thermal sensor for Orion SoC
> > 
> > From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > 
> > Some Orion SoC has thermal sensor.
> > This patch adds support for 88F6282 and 88F6283.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  .../devicetree/bindings/thermal/orion-thermal.txt  |   16 +++
> >  drivers/thermal/Kconfig                            |    7 ++
> >  drivers/thermal/Makefile                           |    1 +
> >  drivers/thermal/orion_thermal.c                    |  133 ++++++++++++++++++++
> >  4 files changed, 157 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/orion-
> > thermal.txt
> >  create mode 100644 drivers/thermal/orion_thermal.c
> > 
> > diff --git a/Documentation/devicetree/bindings/thermal/orion-thermal.txt
> > b/Documentation/devicetree/bindings/thermal/orion-thermal.txt
> > new file mode 100644
> > index 0000000..5ce925d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/orion-thermal.txt
> > @@ -0,0 +1,16 @@
> > +* Orion Thermal
> > +
> > +This initial version is for Kirkwood 88F8262 & 88F6283 SoCs, however
> > +it is expected the driver will sometime in the future be expanded to
> > +also support Dove, using a different compatibility string.
> > +
> > +Required properties:
> > +- compatible : "marvell,kirkwood-thermal"
> > +- reg : Address range of the thermal registers
> > +
> > +Example:
> > +
> > +	thermal@10078 {
> > +		compatible = "marvell,kirkwood";
> > +		reg = <0x10078 0x4>;
> > +	};
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index e1cb6bd..3bba13f 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -55,3 +55,10 @@ config EXYNOS_THERMAL
> >  	help
> >  	  If you say yes here you get support for TMU (Thermal Managment
> >  	  Unit) on SAMSUNG EXYNOS series of SoC.
> > +
> > +config ORION_THERMAL
> > +	tristate "Temperature sensor on Marvel Orion SoCs"
> > +	depends on PLAT_ORION && THERMAL
> 
> On what tree is this patch set based on ?

Not a good one. arm-soc/for-next

I posted these patches to let other know i'm working in the driver and
to get further feedback. I've also started on adding support for Dove,
which is similar, but different.

It will get rebased onto -rc1 in a couple of weeks time and by then i
hope i will have Dove support.

> If it is, then you don't need '&& THERMAL' in Kconfig.
> > +	reg = (reg >> THERMAL_TEMP_OFFSET) & THERMAL_TEMP_MASK;
> > +	/* Calculate temperature. See Table 814 in 8262 hardware manual. */
> 
> Thanks for the comment.
> Can we move this comment one line above ? like below:
> 
> /* comment */
> reg = 
> *temp =

Sure.

> BTW, is this datasheet public ?

Humm, think so. Take a look at Documentation/arm/Marvell/REAMDE. I
will check and add a reference to this README file and the specific
datasheet.

> If so, could you please add the link to the datasheet at the top ?
> 
> > +	*temp = ((322UL - reg) * 10000UL * 1000UL) / 13625UL;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct thermal_zone_device_ops ops = {
> > +	.get_temp = orion_get_temp,
> > +};
> > +
> > +static int orion_thermal_probe(struct platform_device *pdev)
> > +{
> > +	struct thermal_zone_device *thermal = NULL;
> > +	struct orion_thermal_dev *thermal_dev;
> > +	struct resource *res;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Failed to get platform resource\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	thermal_dev = devm_kzalloc(&pdev->dev, sizeof(*thermal_dev),
> > +				   GFP_KERNEL);
> > +	if (!thermal_dev) {
> > +		dev_err(&pdev->dev, "kzalloc fail\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	thermal_dev->base_addr = devm_ioremap(&pdev->dev, res->start,
> > +					      resource_size(res));
> > +	if (!thermal_dev->base_addr) {
> > +		dev_err(&pdev->dev, "Failed to ioremap memory\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	thermal = thermal_zone_device_register("orion_thermal", 0, 0,
> > +				   thermal_dev, &ops, 0, 0);
> > +	if (IS_ERR(thermal)) {
> > +		dev_err(&pdev->dev,
> > +			"Failed to register thermal zone device\n");
> 
> Don't we have to free ioremap resource ? Or devm_ takes care of that ?
> please educate me :-)

devm_ should take care of that. If the probe function returns an
error, or the driver is unloaded, all resources allocated with devm_
get automagically freed.

    Andrew
