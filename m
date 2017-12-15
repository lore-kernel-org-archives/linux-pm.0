From: Miquel RAYNAL <miquel.raynal@free-electrons.com>
Subject: Re: [PATCH v3 03/11] thermal: armada: Simplify the check of the
 validity bit
Date: Fri, 15 Dec 2017 11:56:33 +0100
Message-ID: <20171215115633.4e5490eb@xps13>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
        <20171214103011.24713-4-miquel.raynal@free-electrons.com>
        <20171215083316.4xswddwbcijxhuxn@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57914 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752866AbdLOK4p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Dec 2017 05:56:45 -0500
In-Reply-To: <20171215083316.4xswddwbcijxhuxn@tarshish>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>

Hello Baruch,

On Fri, 15 Dec 2017 10:33:16 +0200
Baruch Siach <baruch@tkos.co.il> wrote:

> Hi Miquel,
> 
> On Thu, Dec 14, 2017 at 11:30:03AM +0100, Miquel Raynal wrote:
> > All Armada SoCs use one bit to declare if the sensor values are
> > valid. This bit moves across the versions of the IP.
> > 
> > The method until then was to do both a shift and compare with an
> > useless flag of "0x1". It is clearer and quicker to directly save
> > the value that must be ANDed instead of the bit position and do a
> > single bitwise AND operation.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> > ---
> >  drivers/thermal/armada_thermal.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/thermal/armada_thermal.c
> > b/drivers/thermal/armada_thermal.c index 6c4af2622d4f..26698f2d3ca7
> > 100644 --- a/drivers/thermal/armada_thermal.c
> > +++ b/drivers/thermal/armada_thermal.c
> > @@ -24,8 +24,6 @@
> >  #include <linux/of_device.h>
> >  #include <linux/thermal.h>
> >  
> > -#define THERMAL_VALID_MASK		0x1
> > -
> >  /* Thermal Manager Control and Status Register */
> >  #define PMU_TDC0_SW_RST_MASK		(0x1 << 1)
> >  #define PMU_TM_DISABLE_OFFS		0
> > @@ -67,7 +65,7 @@ struct armada_thermal_data {
> >  	/* Register shift and mask to access the sensor
> > temperature */ unsigned int temp_shift;
> >  	unsigned int temp_mask;
> > -	unsigned int is_valid_shift;
> > +	unsigned int is_valid_bit;  
> 
> Type should be u32 now, I think.

Indeed, I'll change it in next version.

> 
> >  };
> >  
> >  static void armadaxp_init_sensor(struct platform_device *pdev,
> > @@ -151,7 +149,7 @@ static bool armada_is_valid(struct
> > armada_thermal_priv *priv) {
> >  	unsigned long reg = readl_relaxed(priv->sensor);  
> 
> u32 here also, I think. But that's unrelated to this patch.

I completely agree, actually this is done in the next patch, moving all
"unsigned long reg" to "u32 reg" while renaming the registers
pointers, hope this is fine?

> 
> > -	return (reg >> priv->data->is_valid_shift) &
> > THERMAL_VALID_MASK;
> > +	return reg & priv->data->is_valid_bit;
> >  }
> >  
> >  static int armada_get_temp(struct thermal_zone_device *thermal,
> > @@ -199,7 +197,7 @@ static const struct armada_thermal_data
> > armadaxp_data = { static const struct armada_thermal_data
> > armada370_data = { .is_valid = armada_is_valid,
> >  	.init_sensor = armada370_init_sensor,
> > -	.is_valid_shift = 9,
> > +	.is_valid_bit = BIT(9),
> >  	.temp_shift = 10,
> >  	.temp_mask = 0x1ff,
> >  	.coef_b = 3153000000UL,
> > @@ -210,7 +208,7 @@ static const struct armada_thermal_data
> > armada370_data = { static const struct armada_thermal_data
> > armada375_data = { .is_valid = armada_is_valid,
> >  	.init_sensor = armada375_init_sensor,
> > -	.is_valid_shift = 10,
> > +	.is_valid_bit = BIT(10),
> >  	.temp_shift = 0,
> >  	.temp_mask = 0x1ff,
> >  	.coef_b = 3171900000UL,
> > @@ -221,7 +219,7 @@ static const struct armada_thermal_data
> > armada375_data = { static const struct armada_thermal_data
> > armada380_data = { .is_valid = armada_is_valid,
> >  	.init_sensor = armada380_init_sensor,
> > -	.is_valid_shift = 10,
> > +	.is_valid_bit = BIT(10),
> >  	.temp_shift = 0,
> >  	.temp_mask = 0x3ff,
> >  	.coef_b = 1172499100UL,  
> 
> baruch
> 


Best regards,
Miquèl
