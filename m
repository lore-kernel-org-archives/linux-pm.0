From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCHv2] power_supply: Add support for Richtek rt9455 battery
 charger
Date: Mon, 4 May 2015 18:22:09 +0300
Message-ID: <20150504152209.GF10973@lpalcu-linux>
References: <1430338406-24012-1-git-send-email-anda-maria.nicolae@intel.com>
 <20150430091648.GD10973@lpalcu-linux>
 <11982715D62E664DBACA4351A418B0581437E182@IRSMSX107.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26579 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbbEDPWX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 May 2015 11:22:23 -0400
Content-Disposition: inline
In-Reply-To: <11982715D62E664DBACA4351A418B0581437E182@IRSMSX107.ger.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Nicolae, Anda-maria" <anda-maria.nicolae@intel.com>
Cc: "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Anda,

Can you please use a decent mail client to reply to emails? It was
really hard for me to figure out which were my comments and which were
yours... And I tested 3 different clients: mutt, evolution and
outlook(the web app).

More comments inline.

laurentiu

On Mon, May 04, 2015 at 05:12:07PM +0300, Nicolae, Anda-maria wrote:
> Hi Laurentiu,
> 
> Inline are the responses to your comments.
> 
> Thanks,
> Anda
> 
> ________________________________________
> From: Palcu, Laurentiu
> Sent: Thursday, April 30, 2015 12:16 PM
> To: Nicolae, Anda-maria
> Cc: sre@kernel.org; dbaryshkov@gmail.com; robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com; ijc+devicetree@hellion.org.uk; galak@codeaurora.org; dwmw2@infradead.org; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCHv2] power_supply: Add support for Richtek rt9455 battery charger
> 
> More comments inline.
> 
> laurentiu
> 
> On Wed, Apr 29, 2015 at 11:13:26PM +0300, Anda-Maria Nicolae wrote:
> > Based on the datasheet found here:
> > http://www.richtek.com/download_ds.jsp?p=RT9455
> >
> > Updates from the previous version:
> > - replaced license GPLv2 with GPL
> > - replaced vendor prefix rt with richtek
> > - replaced uppercase properties names from devicetree with lowercase separated by dash properties names
> > - replaced I/O read/write API with regmap_read/write and regmap_field_read/write
> > - used kernel multiline comment
> > - used DELAYED_WORK and scheduled the works in system_power_efficient_wq. It is high probability that the device is in suspend state while charging (i.e. the user leaves the device to charge during night) and it is needed that the scheduled works to be executed as planned.
> > - replaced struct power_supply_desc rt9455_charger_desc with static const struct power_supply_desc rt9455_charger_desc
> > - replaced if (IS_ERR_OR_NULL(info->charger)) with if (IS_ERR(info->charger))
> > - replaced {"RTK9455", 0} with { "RTK9455", 0 }
> > - removed .owner = THIS_MODULE
> The change log should go after '---'.  Otherwise it will end up in the
> commit message.
> 
> WIll do.
> 
> >
> > Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
> > ---
> >  .../devicetree/bindings/power/rt9455_charger.txt   |   43 +
> >  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
> >  drivers/power/Kconfig                              |    6 +
> >  drivers/power/Makefile                             |    1 +
> >  drivers/power/rt9455_charger.c                     | 1758 ++++++++++++++++++++
> >  5 files changed, 1809 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/rt9455_charger.txt
> >  create mode 100644 drivers/power/rt9455_charger.c
> (...)
> 
> >
> > diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> > index 4091fb0..39f208d 100644
> > --- a/drivers/power/Kconfig
> > +++ b/drivers/power/Kconfig
> > @@ -439,6 +439,12 @@ config BATTERY_RT5033
> >         The fuelgauge calculates and determines the battery state of charge
> >         according to battery open circuit voltage.
> >
> > +config CHARGER_RT9455
> > +     tristate "Richtek RT9455 battery charger driver"
> > +     depends on I2C && GPIOLIBa
> depends on REGMAP_I2C
> 
> > +     help
> > +     Say Y to enable support for the Richtek RT9455 battery charger.
> > +
> >  source "drivers/power/reset/Kconfig"
> >
> >  endif # POWER_SUPPLY
> (...)
> 
> > diff --git a/drivers/power/rt9455_charger.c b/drivers/power/rt9455_charger.c
> > new file mode 100644
> > index 0000000..e45b0f2
> > --- /dev/null
> > +++ b/drivers/power/rt9455_charger.c
> > @@ -0,0 +1,1758 @@
> > +/*
> > + * Driver for Richtek RT9455WSC battery charger.
> > + *
> > + * Copyright (C) 2015 Intel Corporation
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/delay.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/acpi.h>
> > +#include <linux/usb/phy.h>
> > +#include <linux/regmap.h>
> > +
> > +#define RT9455_MANUFACTURER                  "Richtek"
> > +#define RT9455_MODEL_NAME                    "RT9455"
> > +#define RT9455_DRIVER_NAME                   "rt9455-charger"
> > +
> > +#define RT9455_IRQ_NAME                              "interrupt"
> > +
> > +#define RT9455_PWR_RDY_DELAY                 1 /* 1 second */
> > +#define RT9455_MAX_CHARGING_TIME             21600 /* 6 hrs */
> > +#define RT9455_BATT_PRESENCE_DELAY           60 /* 60 seconds */
> > +
> > +#define RT9455_CHARGE_MODE                   0x00
> > +#define RT9455_BOOST_MODE                    0x01
> > +
> > +#define RT9455_FAULT                         0x03
> > +
> > +#define RT9455_IAICR_100MA                   0x00
> > +#define RT9455_IAICR_500MA                   0x01
> > +#define RT9455_IAICR_NO_LIMIT                        0x03
> > +
> > +#define RT9455_CHARGE_DISABLE                        0x00
> > +#define RT9455_CHARGE_ENABLE                 0x01
> > +
> > +#define RT9455_PWR_FAULT                     0x00
> > +#define RT9455_PWR_GOOD                              0x01
> > +
> > +#define RT9455_REG_CTRL1                     0x00 /* CTRL1 reg address */
> > +#define RT9455_REG_CTRL1_STAT_MASK           (BIT(5) | BIT(4))
> > +#define RT9455_REG_CTRL1_BOOST_MASK          BIT(3)
> > +#define RT9455_REG_CTRL1_PWR_RDY_MASK                BIT(2)
> > +#define RT9455_REG_CTRL1_OTG_PIN_POLARITY_MASK       BIT(1)
> Since you're using regmap fields, you can get rid of the masks above.
> The same applies for the masks below (except those for the IRQ
> registers which you seem to use).
> 
> I let them there for further use, in case enhancements will be done.
Since you decided to use regmap fields, I don't see why the person doing
enhancements (whatever they might be) would use masks. They should be
consistent (I hope) with the current driver implementation and use
regmap fields.

> 
> > +
> > +#define RT9455_REG_CTRL2                     0x01 /* CTRL2 reg address */
> > +#define RT9455_REG_CTRL2_IAICR_MASK          (BIT(7) | BIT(6))
> > +#define RT9455_REG_CTRL2_TE_SHDN_EN_MASK     BIT(5)
> > +#define RT9455_REG_CTRL2_HIGHER_OCP_MASK     BIT(4)
> > +#define RT9455_REG_CTRL2_TE_MASK             BIT(3)
> > +#define RT9455_REG_CTRL2_IAICR_INT_MASK              BIT(2)
> > +#define RT9455_REG_CTRL2_HIZ_MASK            BIT(1)
> > +#define RT9455_REG_CTRL2_OPA_MODE_MASK               BIT(0)
> > +
> > +#define RT9455_REG_CTRL3                     0x02 /* CTRL3 reg address */
> > +#define RT9455_REG_CTRL3_VOREG_MASK          (BIT(7) | BIT(6) | BIT(5) | \
> > +                                              BIT(4) | BIT(3) | BIT(2))
> > +#define RT9455_REG_CTRL3_OTG_PL_MASK         BIT(1)
> > +#define RT9455_REG_CTRL3_OTG_EN_MASK         BIT(0)
> > +
> > +#define RT9455_REG_DEV_ID                    0x03 /* DEV_ID reg address */
> > +#define RT9455_REG_DEV_ID_VENDOR_ID_MASK     (BIT(7) | BIT(6) | BIT(5) | \
> > +                                              BIT(4))
> > +#define RT9455_REG_DEV_ID_CHIP_REV_MASK              (BIT(3) | BIT(2) | BIT(1) | \
> > +                                              BIT(0))
> > +
> > +#define RT9455_REG_CTRL4                     0x04 /* CTRL4 reg address */
> > +#define RT9455_REG_CTRL4_RST_MASK            BIT(7)
> > +
> > +#define RT9455_REG_CTRL5                     0x05 /* CTRL5 reg address */
> > +#define RT9455_REG_CTRL5_TMR_EN_MASK         BIT(7)
> > +#define RT9455_REG_CTRL5_MIVR_MASK           (BIT(5) | BIT(4))
> > +#define RT9455_REG_CTRL5_IPREC_MASK          (BIT(3) | BIT(2))
> > +#define RT9455_REG_CTRL5_IEOC_PERCENTAGE_MASK        (BIT(1) | BIT(0))
> > +
> > +#define RT9455_REG_CTRL6                     0x06 /* CTRL6 reg address */
> > +#define RT9455_REG_CTRL6_IAICR_SEL_MASK              BIT(7)
> > +#define RT9455_REG_CTRL6_ICHRG_MASK          (BIT(6) | BIT(5) | BIT(4))
> > +#define RT9455_REG_CTRL6_VPREC_MASK          (BIT(2) | BIT(1) | BIT(0))
> > +
> > +#define RT9455_REG_CTRL7                     0x07 /* CTRL7 reg address */
> > +#define RT9455_REG_CTRL7_BATD_EN_MASK                BIT(6)
> > +#define RT9455_REG_CTRL7_CHG_EN_MASK         BIT(4)
> > +#define RT9455_REG_CTRL7_VMREG_MASK          (BIT(3) | BIT(2) | BIT(1) | \
> > +                                              BIT(0))
> > +
> > +#define RT9455_REG_IRQ1                              0x08 /* IRQ1 reg address */
> > +#define RT9455_REG_IRQ1_TSDI_MASK            BIT(7)
> > +#define RT9455_REG_IRQ1_VINOVPI_MASK         BIT(6)
> > +#define RT9455_REG_IRQ1_BATAB_MASK           BIT(0)
> > +
> > +#define RT9455_REG_IRQ2                              0x09 /* IRQ2 reg address */
> > +#define RT9455_REG_IRQ2_CHRVPI_MASK          BIT(7)
> > +#define RT9455_REG_IRQ2_CHBATOVI_MASK                BIT(5)
> > +#define RT9455_REG_IRQ2_CHTERMI_MASK         BIT(4)
> > +#define RT9455_REG_IRQ2_CHRCHGI_MASK         BIT(3)
> > +#define RT9455_REG_IRQ2_CH32MI_MASK          BIT(2)
> > +#define RT9455_REG_IRQ2_CHTREGI_MASK         BIT(1)
> > +#define RT9455_REG_IRQ2_CHMIVRI_MASK         BIT(0)
> > +
> > +#define RT9455_REG_IRQ3                              0x0A /* IRQ3 reg address */
> > +#define RT9455_REG_IRQ3_BSTBUSOVI_MASK               BIT(7)
> > +#define RT9455_REG_IRQ3_BSTOLI_MASK          BIT(6)
> > +#define RT9455_REG_IRQ3_BSTLOWVI_MASK                BIT(5)
> > +#define RT9455_REG_IRQ3_BST32SI_MASK         BIT(3)
> > +
> > +#define RT9455_REG_MASK1                     0x0B /* MASK1 reg address */
> > +#define RT9455_REG_MASK1_TSDM_MASK           BIT(7)
> > +#define RT9455_REG_MASK1_VINOVPIM_MASK               BIT(6)
> > +#define RT9455_REG_MASK1_BATABM_MASK         BIT(0)
> > +
> > +#define RT9455_REG_MASK2                     0x0C /* MASK2 reg address */
> > +#define RT9455_REG_MASK2_CHRVPIM_MASK                BIT(7)
> > +#define RT9455_REG_MASK2_CHBATOVIM_MASK              BIT(5)
> > +#define RT9455_REG_MASK2_CHTERMIM_MASK               BIT(4)
> > +#define RT9455_REG_MASK2_CHRCHGIM_MASK               BIT(3)
> > +#define RT9455_REG_MASK2_CH32MIM_MASK                BIT(2)
> > +#define RT9455_REG_MASK2_CHTREGIM_MASK               BIT(1)
> > +#define RT9455_REG_MASK2_CHMIVRIM_MASK               BIT(0)
> > +
> > +#define RT9455_REG_MASK3                     0x0D /* MASK3 reg address */
> > +#define RT9455_REG_MASK3_BSTVINOVIM_MASK     BIT(7)
> > +#define RT9455_REG_MASK3_BSTOLIM_MASK                BIT(6)
> > +#define RT9455_REG_MASK3_BSTLOWVIM_MASK              BIT(5)
> > +#define RT9455_REG_MASK3_BST32SIM_MASK               BIT(3)
> > +
> > +enum rt9455_fields {
> > +     F_STAT, F_BOOST, F_PWR_RDY, F_OTG_PIN_POLARITY, /* CTRL1 reg fields */
> > +
> > +     F_IAICR, F_TE_SHDN_EN, F_HIGHER_OCP, F_TE, F_IAICR_INT, F_HIZ,
> > +     F_OPA_MODE, /* CTRL2 reg fields */
> > +
> > +     F_VOREG, F_OTG_PL, F_OTG_EN, /* CTRL3 reg fields */
> > +
> > +     F_VENDOR_ID, F_CHIP_REV, /* DEV_ID reg fields */
> > +
> > +     F_RST, /* CTRL4 reg fields */
> > +
> > +     F_TMR_EN, F_MIVR, F_IPREC, F_IEOC_PERCENTAGE, /* CTRL5 reg fields*/
> > +
> > +     F_IAICR_SEL, F_ICHRG, F_VPREC, /* CTRL6 reg fields */
> > +
> > +     F_BATD_EN, F_CHG_EN, F_VMREG, /* CTRL7 reg fields */
> > +
> > +     F_TSDI, F_VINOVPI, F_BATAB, /* IRQ1 reg fields */
> > +
> > +     F_CHRVPI, F_CHBATOVI, F_CHTERMI, F_CHRCHGI, F_CH32MI, F_CHTREGI,
> > +     F_CHMIVRI, /* IRQ2 reg fields */
> > +
> > +     F_BSTBUSOVI, F_BSTOLI, F_BSTLOWVI, F_BST32SI, /* IRQ3 reg fields */
> > +
> > +     F_TSDM, F_VINOVPIM, F_BATABM, /* MASK1 reg fields */
> > +
> > +     F_CHRVPIM, F_CHBATOVIM, F_CHTERMIM, F_CHRCHGIM, F_CH32MIM, F_CHTREGIM,
> > +     F_CHMIVRIM, /* MASK2 reg fields */
> > +
> > +     F_BSTVINOVIM, F_BSTOLIM, F_BSTLOWVIM, F_BST32SIM, /* MASK3 reg fields */
> > +
> > +     F_MAX_FIELDS
> > +};
> > +
> > +static const struct reg_field rt9455_reg_fields[] = {
> > +     [F_STAT]                = REG_FIELD(RT9455_REG_CTRL1, 4, 5),
> > +     [F_BOOST]               = REG_FIELD(RT9455_REG_CTRL1, 3, 3),
> > +     [F_PWR_RDY]             = REG_FIELD(RT9455_REG_CTRL1, 2, 2),
> > +     [F_OTG_PIN_POLARITY]    = REG_FIELD(RT9455_REG_CTRL1, 1, 1),
> > +
> > +     [F_IAICR]               = REG_FIELD(RT9455_REG_CTRL2, 6, 7),
> > +     [F_TE_SHDN_EN]          = REG_FIELD(RT9455_REG_CTRL2, 5, 5),
> > +     [F_HIGHER_OCP]          = REG_FIELD(RT9455_REG_CTRL2, 4, 4),
> > +     [F_TE]                  = REG_FIELD(RT9455_REG_CTRL2, 3, 3),
> > +     [F_IAICR_INT]           = REG_FIELD(RT9455_REG_CTRL2, 2, 2),
> > +     [F_HIZ]                 = REG_FIELD(RT9455_REG_CTRL2, 1, 1),
> > +     [F_OPA_MODE]            = REG_FIELD(RT9455_REG_CTRL2, 0, 0),
> > +
> > +     [F_VOREG]               = REG_FIELD(RT9455_REG_CTRL3, 2, 7),
> > +     [F_OTG_PL]              = REG_FIELD(RT9455_REG_CTRL3, 1, 1),
> > +     [F_OTG_EN]              = REG_FIELD(RT9455_REG_CTRL3, 0, 0),
> > +
> > +     [F_VENDOR_ID]           = REG_FIELD(RT9455_REG_DEV_ID, 4, 7),
> > +     [F_CHIP_REV]            = REG_FIELD(RT9455_REG_DEV_ID, 0, 3),
> > +
> > +     [F_RST]                 = REG_FIELD(RT9455_REG_CTRL4, 7, 7),
> > +
> > +     [F_TMR_EN]              = REG_FIELD(RT9455_REG_CTRL5, 7, 7),
> > +     [F_MIVR]                = REG_FIELD(RT9455_REG_CTRL5, 4, 5),
> > +     [F_IPREC]               = REG_FIELD(RT9455_REG_CTRL5, 2, 3),
> > +     [F_IEOC_PERCENTAGE]     = REG_FIELD(RT9455_REG_CTRL5, 0, 1),
> > +
> > +     [F_IAICR_SEL]           = REG_FIELD(RT9455_REG_CTRL6, 7, 7),
> > +     [F_ICHRG]               = REG_FIELD(RT9455_REG_CTRL6, 4, 6),
> > +     [F_VPREC]               = REG_FIELD(RT9455_REG_CTRL6, 0, 2),
> > +
> > +     [F_BATD_EN]             = REG_FIELD(RT9455_REG_CTRL7, 6, 6),
> > +     [F_CHG_EN]              = REG_FIELD(RT9455_REG_CTRL7, 4, 4),
> > +     [F_VMREG]               = REG_FIELD(RT9455_REG_CTRL7, 0, 3),
> > +
> > +     [F_TSDI]                = REG_FIELD(RT9455_REG_IRQ1, 7, 7),
> > +     [F_VINOVPI]             = REG_FIELD(RT9455_REG_IRQ1, 6, 6),
> > +     [F_BATAB]               = REG_FIELD(RT9455_REG_IRQ1, 0, 0),
> > +
> > +     [F_CHRVPI]              = REG_FIELD(RT9455_REG_IRQ2, 7, 7),
> > +     [F_CHBATOVI]            = REG_FIELD(RT9455_REG_IRQ2, 5, 5),
> > +     [F_CHTERMI]             = REG_FIELD(RT9455_REG_IRQ2, 4, 4),
> > +     [F_CHRCHGI]             = REG_FIELD(RT9455_REG_IRQ2, 3, 3),
> > +     [F_CH32MI]              = REG_FIELD(RT9455_REG_IRQ2, 2, 2),
> > +     [F_CHTREGI]             = REG_FIELD(RT9455_REG_IRQ2, 1, 1),
> > +     [F_CHMIVRI]             = REG_FIELD(RT9455_REG_IRQ2, 0, 0),
> > +
> > +     [F_BSTBUSOVI]           = REG_FIELD(RT9455_REG_IRQ3, 7, 7),
> > +     [F_BSTOLI]              = REG_FIELD(RT9455_REG_IRQ3, 6, 6),
> > +     [F_BSTLOWVI]            = REG_FIELD(RT9455_REG_IRQ3, 5, 5),
> > +     [F_BST32SI]             = REG_FIELD(RT9455_REG_IRQ3, 3, 3),
> I don't see any benefit in declaring fields for the IRQx registers, since
> you're not going to use them. AFAICS you're reading the entire IRQx
> registers and then use masks to retrieve the fields.
> 
> I let them there for symmetry and further use, in case enhancements
> will be done. I prefer using predefined masks instead of fields from
> struct reg_field when dealing with interrupt registers. The interrupt
> handler performs numerous checks and I believe the masks are faster
> than accessing fields from an array of reg_fields.
The same problem, the other way around. You decided to use masks for
reading the various IRQx bits, which is fine since some flags can be
cleared after reading the register the first time. However, the regmap
fields declaring IRQx flags will be never used, so they can be removed.

It makes sense, though, to leave the other fields (non-IRQ related) in
place for future use.

> 
> > +
> > +     [F_TSDM]                = REG_FIELD(RT9455_REG_MASK1, 7, 7),
> > +     [F_VINOVPIM]            = REG_FIELD(RT9455_REG_MASK1, 6, 6),
> > +     [F_BATABM]              = REG_FIELD(RT9455_REG_MASK1, 0, 0),
> > +
> > +     [F_CHRVPIM]             = REG_FIELD(RT9455_REG_MASK2, 7, 7),
> > +     [F_CHBATOVIM]           = REG_FIELD(RT9455_REG_MASK2, 5, 5),
> > +     [F_CHTERMIM]            = REG_FIELD(RT9455_REG_MASK2, 4, 4),
> > +     [F_CHRCHGIM]            = REG_FIELD(RT9455_REG_MASK2, 3, 3),
> > +     [F_CH32MIM]             = REG_FIELD(RT9455_REG_MASK2, 2, 2),
> > +     [F_CHTREGIM]            = REG_FIELD(RT9455_REG_MASK2, 1, 1),
> > +     [F_CHMIVRIM]            = REG_FIELD(RT9455_REG_MASK2, 0, 0),
> > +
> > +     [F_BSTVINOVIM]          = REG_FIELD(RT9455_REG_MASK3, 7, 7),
> > +     [F_BSTOLIM]             = REG_FIELD(RT9455_REG_MASK3, 6, 6),
> > +     [F_BSTLOWVIM]           = REG_FIELD(RT9455_REG_MASK3, 5, 5),
> > +     [F_BST32SIM]            = REG_FIELD(RT9455_REG_MASK3, 3, 3),
> > +};
> > +
> > +/*
> > + * Each array initialised below shows the possible real-world values for a
> > + * group of bits belonging to RT9455 registers. The arrays are sorted in
> > + * ascending order. The index of each real-world value represents the value
> > + * that is encoded in the group of bits belonging to RT9455 registers.
> > + */
> > +/* REG06[6:4] (ICHRG) in uAh */
> > +static const int rt9455_ichrg_values[] = {
> > +      500000,  650000,  800000,  950000, 1100000, 1250000, 1400000, 1550000
> > +};
> > +
> > +/* REG02[7:2] (VOREG) in uV */
> > +static const int rt9455_voreg_values[] = {
> > +     3500000, 3520000, 3540000, 3560000, 3580000, 3600000, 3620000, 3640000,
> > +     3660000, 3680000, 3700000, 3720000, 3740000, 3760000, 3780000, 3800000,
> > +     3820000, 3840000, 3860000, 3880000, 3900000, 3920000, 3940000, 3960000,
> > +     3980000, 4000000, 4020000, 4040000, 4060000, 4080000, 4100000, 4120000,
> > +     4140000, 4160000, 4180000, 4200000, 4220000, 4240000, 4260000, 4280000,
> > +     4300000, 4330000, 4350000, 4370000, 4390000, 4410000, 4430000, 4450000,
> > +     4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000,
> > +     4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000, 4450000
> > +};
> > +
> > +/* REG07[3:0] (VMREG) in uV */
> > +static const int rt9455_vmreg_values[] = {
> > +     4200000, 4220000, 4240000, 4260000, 4280000, 4300000, 4320000, 4340000,
> > +     4360000, 4380000, 4400000, 4430000, 4450000, 4450000, 4450000, 4450000
> > +};
> > +
> > +/* REG05[5:4] (IEOC_PERCENTAGE) */
> > +static const int rt9455_ieoc_percentage_values[] = {
> > +     10, 30, 20, 30
> > +};
> > +
> > +/* REG05[1:0] (MIVR) in uV */
> > +static const int rt9455_mivr_values[] = {
> > +     4000000, 4250000, 4500000, 5000000
> > +};
> > +
> > +/* REG05[1:0] (IAICR) in uA */
> > +static const int rt9455_iaicr_values[] = {
> > +     100000, 500000, 1000000, 2000000
> > +};
> > +
> > +struct rt9455_info {
> > +     struct i2c_client               *client;
> > +     struct regmap                   *regmap;
> > +     struct regmap_field             *regmap_fields[F_MAX_FIELDS];
> > +     struct power_supply             *charger;
> > +#if IS_ENABLED(CONFIG_USB_PHY)
> > +     struct usb_phy                  *usb_phy;
> > +     struct notifier_block           nb;
> > +#endif
> > +     struct gpio_desc                *gpiod_irq;
> > +     unsigned int                    gpio_irq;
> > +     struct delayed_work             pwr_rdy_work;
> > +     struct delayed_work             max_charging_time_work;
> > +     struct delayed_work             batt_presence_work;
> > +};
> > +
> > +static const struct regmap_config rt9455_regmap_config = {
> > +     .reg_bits = 8,
> > +     .val_bits = 8,
> > +     .max_register = RT9455_REG_MASK3,
> > +};
> Do you need all chip's registers to be volatile? Can we cache any of
> them so we don't make unnecessary read operations on the I2C bus?
> 
> I can cache reg 0x03 and reg 0x05. 
> 
> (...)
> > +
> > +static int rt9455_charger_get_status(struct rt9455_info *info,
> > +                                  union power_supply_propval *val)
> > +{
> > +     unsigned int v;
> > +     int ret;
> > +
> > +     ret = regmap_field_read(info->regmap_fields[F_STAT], &v);
> > +     if (ret) {
> > +             dev_err(&info->client->dev, "Failed to read STAT bits\n");
> > +             return ret;
> > +     }
> > +
> > +     switch (v) {
> > +     case 0:
> > +             val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> > +     break;
> > +     case 1:
> > +             val->intval = POWER_SUPPLY_STATUS_CHARGING;
> > +     break;
> > +     case 2:
> > +             val->intval = POWER_SUPPLY_STATUS_FULL;
> > +     break;
> > +     default:
> > +             val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
> > +     break;
> > +     }
> Please indent the breaks to conform to kernel coding style.
> 
> Will do.
> 
> Also, just an idea, maybe you should also return
> POWER_SUPPLY_STATUS_DISCHARGING when the power is not plugged in
> because, technically, if PWR_RDY=0 the battery will discharge...
> 
> There are cases in which power source can be plugged in (PWR_RDY bit
> is 1) and the battery is not being charged.
You already return POWER_SUPPLY_STATUS_NOT_CHARGING in this case.

> These are: the charge bit
> is cleared (set to 0), or the battery is already full (in this case,
> STAT bits value is 2).  Also, when the battery is not connected to the
> charger, STAT bits value is either 3 or 0. So if I return
> POWER_SUPPLY_STATUS_DISCHARGING, I also have to check whether the
> battery is connected or not. In addition to this, I also believe that
> POWER_SUPPLY_STATUS_DISCHARGING should be returned when the charger is
> neither in sleep mode, nor in high impedance mode (so there is
> additional check to do). In both modes, the charger tries to operate
> with minimum current from the battery, to prevent battery drain. So
> theoretically, the current drawn by the charger from the battery can
> be considered as negligible.  This is why I prefer to return
> POWER_SUPPLY_STATUS_NOT_CHARGING.
All you have to do is check PWR_RDY. If it's 0, then your battery will
be discharging. Is it not? You don't have to check the existence of the
battery because, technically, if you have no battery connected and the
charger is *not* plugged in, that means only one thing: your device is
not powered on.

> 
> (...)
> 
> > +
> > +static int rt9455_charger_get_voltage_max(struct rt9455_info *info,
> > +                                       union power_supply_propval *val)
> > +{
> > +     int idx = ARRAY_SIZE(rt9455_voreg_values) - 1;
> rt9455_vmreg_values?
> 
> > +
> > +     val->intval = rt9455_voreg_values[idx];
> ditto.
> 
> Since I set TE and TE_SHDN_EN, the charging terminates if the charge
> current is below termination current (IEOC) in constant voltage mode.
> From my experiments, charging is done when battery voltage is almost
> equal to VOREG. Therefore, the battery voltage never reaches VMREG in
> this configuration. This is why I use maximum VOREG value instead of
> VMREG. If I do not set TE or TE_SHDN_EN bit, the charger will not
> trigger any interrupt when charging is done.
Both rt9455_voreg_values and rt9455_vmreg_values have the same maximum
value. Your function will return the right thing, but it's confusing.
Please use rt9455_vmreg_values here.

> 
> > +
> > +     return 0;
> > +}
> (...)
> > +
> > +static int rt9455_charger_get_property(struct power_supply *psy,
> > +                                    enum power_supply_property psp,
> > +                                    union power_supply_propval *val)
> > +{
> > +     struct rt9455_info *info = power_supply_get_drvdata(psy);
> > +
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_STATUS:
> > +             return rt9455_charger_get_status(info, val);
> > +     case POWER_SUPPLY_PROP_HEALTH:
> > +             return rt9455_charger_get_health(info, val);
> > +     case POWER_SUPPLY_PROP_PRESENT:
> > +             return rt9455_charger_get_battery_presence(info, val);
> > +     case POWER_SUPPLY_PROP_ONLINE:
> > +             return rt9455_charger_get_online(info, val);
> > +     case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> > +             return rt9455_charger_get_current(info, val);
> > +     case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> > +             return rt9455_charger_get_current_max(info, val);
> > +     case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> > +             return rt9455_charger_get_voltage(info, val);
> > +     case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> > +             return rt9455_charger_get_voltage_max(info, val);
> > +     case POWER_SUPPLY_PROP_SCOPE:
> > +             val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
> > +             return 0;
> > +     case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
> > +             return rt9455_charger_get_term_current(info, val);
> > +     case POWER_SUPPLY_PROP_MODEL_NAME:
> > +             val->strval = RT9455_MODEL_NAME;
> > +             return 0;
> > +     case POWER_SUPPLY_PROP_MANUFACTURER:
> > +             val->strval = RT9455_MANUFACTURER;
> > +             return 0;
> > +     default:
> > +             return -ENODATA;
> > +     }
> > +}
> > +
> (...)
> > +
> > +static int rt9455_charger_set_voltage_max(struct rt9455_info *info,
> > +                                       const union power_supply_propval *val)
> > +{
> > +     return rt9455_set_field_val(info, F_VMREG,
> > +                                 rt9455_vmreg_values,
> > +                                 ARRAY_SIZE(rt9455_vmreg_values),
> > +                                 val->intval);
> > +}
> > +
> > +static int rt9455_charger_set_property(struct power_supply *psy,
> > +                                    enum power_supply_property psp,
> > +                                    const union power_supply_propval *val)
> > +{
> > +     struct rt9455_info *info = power_supply_get_drvdata(psy);
> > +
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> > +             return rt9455_charger_set_current(info, val);
> > +     case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> > +             return rt9455_charger_set_voltage(info, val);
> Personally, I'm against having these properties writable. A user might
> play with the charging voltage or current and then complain that the
> battery does not charge at all, or it takes ages to charge. I'd leave
> these to be set by manufacturer through DT/ACPI. But, it's just an
> opinion.
> 
> If the user really wants to damage his/her battery, he/she can charge
> the values from DT/ACPI. Also, numerous charger drivers expose these
> properties as writable.  I prefer leaving them as they are.
This is debatable. I agree that regular users don't, usually, change the
DT/ACPI tables or roam through sysfs to play with various parameters.

Perhaps more experienced people can comment on this.

> 
> > +     case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> > +             return rt9455_charger_set_voltage_max(info, val);
> You set the max voltage here, but rt9455_charger_get_voltage_max()
> returns the maximum allowed value. Shouldn't it return the value you
> just set here?
> 
> Max VOREG value equals max VMREG value (4.45V). I agree that it is
> confusing and I will use VOREG in both places.
You misunderstood me. You actually set a value here, other than 4.45V.
It would make more sense for rt9455_charger_get_voltage_max() to return
this value, not 4.45V.

> 
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> (...)
> 
> > +
> > +static int rt9455_usb_event_none(struct rt9455_info *info,
> > +                              u8 opa_mode, u8 iaicr)
> > +{
> > +     struct device *dev = &info->client->dev;
> > +     int ret;
> > +
> > +     if (opa_mode == RT9455_BOOST_MODE) {
> > +             /*
> > +              * If the charger is in boost mode, and it has received
> > +              * USB_EVENT_NONE, this means the consumer device powered by the
> > +              * charger is not connected anymore.
> > +              * In this case, the charger goes into charge mode.
> > +              */
> > +             dev_dbg(dev, "USB_EVENT_NONE received, therefore the charger goes into charge mode\n");
> Do you really need both the comment and the dev_dbg? The latter seems
> explanatory enough, even though I'd shorten it a little: "USB_EVENT_NONE
> received, enter charge mode". The same goes for the next 4 functions.
> 
> Yes. The comment explains the purpose of the function, while the
> dev_dbg can be activated to be shown in dmesg. Dev_dbg can be
> activated to check if the driver really enters in the respective
> function, in case a bug/issue occurs.
I didn't say dev_dbg is useless here. I just said that the comment is
redundant. Oh well, I can live with that...

> 
> > +             ret = regmap_field_write(info->regmap_fields[F_OPA_MODE],
> > +                                      RT9455_CHARGE_MODE);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to set charger in charge mode\n");
> > +                     return NOTIFY_DONE;
> > +             }
> > +     }
> > +
> > +     dev_dbg(dev, "USB_EVENT_NONE received, therefore IAICR is set to its minimum value\n");
> > +     if (iaicr != RT9455_IAICR_100MA) {
> > +             ret = regmap_field_write(info->regmap_fields[F_IAICR],
> > +                                      RT9455_IAICR_100MA);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to set IAICR value\n");
> > +                     return NOTIFY_DONE;
> > +             }
> > +     }
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +static int rt9455_usb_event_vbus(struct rt9455_info *info,
> > +                              u8 opa_mode, u8 iaicr)
> > +{
> > +     struct device *dev = &info->client->dev;
> > +     int ret;
> > +
> > +     if (opa_mode == RT9455_BOOST_MODE) {
> > +             /*
> > +              * If the charger is in boost mode, and it has received
> > +              * USB_EVENT_VBUS, this means the consumer device powered by the
> > +              * charger is not connected anymore.
> > +              * In this case, the charger goes into charge mode.
> > +              */
> > +             dev_dbg(dev, "USB_EVENT_VBUS received, therefore the charger goes into charge mode\n");
> > +             ret = regmap_field_write(info->regmap_fields[F_OPA_MODE],
> > +                                      RT9455_CHARGE_MODE);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to set charger in charge mode\n");
> > +                     return NOTIFY_DONE;
> > +             }
> > +     }
> > +
> > +     dev_dbg(dev, "USB_EVENT_VBUS received, therefore IAICR is set to 500 mA\n");
> > +     if (iaicr != RT9455_IAICR_500MA) {
> > +             ret = regmap_field_write(info->regmap_fields[F_IAICR],
> > +                                      RT9455_IAICR_500MA);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to set IAICR value\n");
> > +                     return NOTIFY_DONE;
> > +             }
> > +     }
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +static int rt9455_usb_event_id(struct rt9455_info *info,
> > +                            u8 opa_mode, u8 iaicr)
> > +{
> > +     struct device *dev = &info->client->dev;
> > +     int ret;
> > +
> > +     if (opa_mode == RT9455_CHARGE_MODE) {
> > +             /*
> > +              * If the charger is in charge mode, and it has received
> > +              * USB_EVENT_ID, this means the consumer device powered by the
> > +              * charger is not connected anymore.
> > +              * In this case, the charger goes into charge mode.
> s/goes into charge mode/goes into boost mode/
> 
> Will correct comment.
> 
> > +              */
> > +             dev_dbg(dev, "USB_EVENT_ID received, therefore the charger goes into boost mode\n");
> > +             ret = regmap_field_write(info->regmap_fields[F_OPA_MODE],
> > +                                      RT9455_BOOST_MODE);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to set charger in boost mode\n");
> > +                     return NOTIFY_DONE;
> > +             }
> > +     }
> > +
> > +     dev_dbg(dev, "USB_EVENT_ID received, therefore IAICR is set to its minimum value\n");
> > +     if (iaicr != RT9455_IAICR_100MA) {
> > +             ret = regmap_field_write(info->regmap_fields[F_IAICR],
> > +                                      RT9455_IAICR_100MA);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to set IAICR value\n");
> > +                     return NOTIFY_DONE;
> > +             }
> > +     }
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +static int rt9455_usb_event_charger(struct rt9455_info *info,
> > +                                 u8 opa_mode, u8 iaicr)
> > +{
> > +     struct device *dev = &info->client->dev;
> > +     int ret;
> > +
> > +     if (opa_mode == RT9455_BOOST_MODE) {
> > +             /*
> > +              * If the charger is in boost mode, and it has received
> > +              * USB_EVENT_CHARGER, this means the consumer device powered by
> > +              * the charger is not connected anymore.
> > +              * In this case, the charger goes into charge mode.
> > +              */
> > +             dev_dbg(dev, "USB_EVENT_CHARGER received, therefore the charger goes into charge mode\n");
> > +             ret = regmap_field_write(info->regmap_fields[F_OPA_MODE],
> > +                                      RT9455_CHARGE_MODE);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to set charger in charge mode\n");
> > +                     return NOTIFY_DONE;
> > +             }
> > +     }
> > +
> > +     dev_dbg(dev, "USB_EVENT_CHARGER received, therefore IAICR is set to no current limit\n");
> > +     if (iaicr != RT9455_IAICR_NO_LIMIT) {
> > +             ret = regmap_field_write(info->regmap_fields[F_IAICR],
> > +                                      RT9455_IAICR_NO_LIMIT);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to set IAICR value\n");
> > +                     return NOTIFY_DONE;
> > +             }
> > +     }
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> (...)
> > +
> > +static void rt9455_max_charging_time_work_callback(struct work_struct *work)
> > +{
> > +     struct rt9455_info *info = container_of(work, struct rt9455_info,
> > +                                             max_charging_time_work.work);
> > +     struct device *dev = &info->client->dev;
> > +     int ret;
> > +
> > +     dev_err(dev, "Battery has been charging for at least 6 hours and is not yet fully charged. Battery is dead, therefore charging is disabled.\n");
> If battery is not charged in 6 hours may not necessarily mean that it's
> dead... Perhaps a low charge current was set. So, why not shorten this
> to just: "Safety timer expired, disable charging."
> 
> I prefer leaving it as it is. Safety timer refers to something else;
> RT9455 charger has a built-in safety timer which disables charging
> when no I2C read/write is done within 32 mins. The user may believe
> that this built-in timer expired, Also, when the charger is connected
> to a power source, minimum value for input current is 500 mA while
> minimum value for output current is also 500 mA. I believe this should
> be enough to charge a good battery in 6 hrs.
Fair enough.

> 
> > +     ret = regmap_field_write(info->regmap_fields[F_CHG_EN],
> > +                              RT9455_CHARGE_DISABLE);
> > +     if (ret)
> > +             dev_err(dev, "Failed to disable charging\n");
> > +}
> > +
> > +static void rt9455_batt_presence_work_callback(struct work_struct *work)
> > +{
> > +     struct rt9455_info *info = container_of(work, struct rt9455_info,
> > +                                             batt_presence_work.work);
> > +     struct device *dev = &info->client->dev;
> > +     unsigned int irq1, mask1;
> > +     int ret;
> > +
> > +     ret = regmap_read(info->regmap, RT9455_REG_IRQ1, &irq1);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to read IRQ1 register\n");
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * If the battery is still absent, batt_presence_work is rescheduled.
> > +      * Otherwise, max_charging_time is scheduled.
> > +      */
> > +     if (irq1 & RT9455_REG_IRQ1_BATAB_MASK) {
> > +             queue_delayed_work(system_power_efficient_wq,
> > +                                &info->batt_presence_work,
> > +                                RT9455_BATT_PRESENCE_DELAY * HZ);
> > +     } else {
> > +             queue_delayed_work(system_power_efficient_wq,
> > +                                &info->max_charging_time_work,
> > +                                RT9455_MAX_CHARGING_TIME * HZ);
> > +
> > +             ret = regmap_read(info->regmap, RT9455_REG_MASK1, &mask1);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to read MASK1 register\n");
> > +                     return;
> > +             }
> > +
> > +             if ((mask1 & RT9455_REG_MASK1_BATABM_MASK) == 1) {
> > +                     ret = regmap_field_write(info->regmap_fields[F_BATABM],
> > +                                              0x00);
> > +                     if (ret)
> > +                             dev_err(dev, "Failed to unmask BATAB interrupt\n");
> > +             }
> > +     }
> > +}
> > +
> > +static const struct power_supply_desc rt9455_charger_desc = {
> > +     .name                   = RT9455_DRIVER_NAME,
> > +     .type                   = POWER_SUPPLY_TYPE_USB,
> > +     .properties             = rt9455_charger_properties,
> > +     .num_properties         = ARRAY_SIZE(rt9455_charger_properties),
> > +     .get_property           = rt9455_charger_get_property,
> > +     .set_property           = rt9455_charger_set_property,
> > +     .property_is_writeable  = rt9455_charger_property_is_writeable,
> > +};
> > +
> > +static int rt9455_probe(struct i2c_client *client,
> > +                     const struct i2c_device_id *id)
> > +{
> > +     struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> > +     struct device *dev = &client->dev;
> > +     struct rt9455_info *info;
> > +     struct power_supply_config rt9455_charger_config = {};
> > +     /* mandatory device-specific data values */
> > +     u32 ichrg, ieoc_percentage, voreg;
> > +     /* optional device-specific data values */
> > +     u32 mivr = -1, iaicr = -1;
> > +     int i, ret;
> > +
> > +     if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> > +             dev_err(dev, "No support for SMBUS_BYTE_DATA\n");
> > +             return -ENODEV;
> > +     }
> > +     info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> > +     if (!info)
> > +             return -ENOMEM;
> > +
> > +     info->client = client;
> > +     i2c_set_clientdata(client, info);
> > +
> > +     info->regmap = devm_regmap_init_i2c(client,
> > +                                         &rt9455_regmap_config);
> > +     if (IS_ERR(info->regmap)) {
> > +             dev_err(dev, "Failed to initialize register map\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     for (i = 0; i < F_MAX_FIELDS; i++) {
> > +             info->regmap_fields[i] =
> > +                     devm_regmap_field_alloc(dev, info->regmap,
> > +                                             rt9455_reg_fields[i]);
> > +             if (IS_ERR(info->regmap_fields[i])) {
> > +                     dev_err(dev,
> > +                             "Failed to allocate regmap field = %d\n", i);
> > +                     return PTR_ERR(info->regmap_fields[i]);
> > +             }
> > +     }
> > +
> > +     ret = rt9455_discover_charger(info, &ichrg, &ieoc_percentage,
> > +                                   &voreg, &mivr, &iaicr);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to discover charger\n");
> > +             return ret;
> > +     }
> > +
> > +#if IS_ENABLED(CONFIG_USB_PHY)
> > +     info->usb_phy = usb_get_phy(USB_PHY_TYPE_USB2);
> > +     if (IS_ERR_OR_NULL(info->usb_phy)) {
> > +             dev_err(dev, "Failed to get USB transceiver\n");
> > +     } else {
> > +             info->nb.notifier_call = rt9455_usb_event;
> > +             ret = usb_register_notifier(info->usb_phy, &info->nb);
> > +             if (ret) {
> > +                     dev_err(dev, "Failed to register USB notifier\n");
> > +                     usb_put_phy(info->usb_phy);
> > +             }
> > +     }
> > +#endif
> > +
> > +     INIT_DELAYED_WORK(&info->pwr_rdy_work, rt9455_pwr_rdy_work_callback);
> > +     INIT_DELAYED_WORK(&info->max_charging_time_work,
> > +                       rt9455_max_charging_time_work_callback);
> > +     INIT_DELAYED_WORK(&info->batt_presence_work,
> > +                       rt9455_batt_presence_work_callback);
> > +
> > +     rt9455_charger_config.of_node           = dev->of_node;
> > +     rt9455_charger_config.drv_data          = info;
> > +     rt9455_charger_config.supplied_to       = rt9455_charger_supplied_to;
> > +     rt9455_charger_config.num_supplicants   =
> > +                                     ARRAY_SIZE(rt9455_charger_supplied_to);
> > +     ret = devm_request_threaded_irq(dev, client->irq, NULL,
> > +                                     rt9455_irq_handler_thread,
> > +                                     IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > +                                     RT9455_DRIVER_NAME, info);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Failed to register IRQ handler\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = rt9455_hw_init(info, ichrg, ieoc_percentage, voreg, mivr, iaicr);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to set charger to its default values\n");
> > +             return ret;
> > +     }
> > +
> > +     info->charger = power_supply_register(dev, &rt9455_charger_desc,
> > +                                           &rt9455_charger_config);
> > +     if (IS_ERR(info->charger)) {
> > +             dev_err(dev, "Failed to register charger\n");
> > +             ret = PTR_ERR(info->charger);
> > +             goto put_usb_phy;
> > +     }
> > +
> > +     return 0;
> > +
> > +put_usb_phy:
> > +#if IS_ENABLED(CONFIG_USB_PHY)
> > +     if (!IS_ERR_OR_NULL(info->usb_phy))  {
> > +             usb_unregister_notifier(info->usb_phy, &info->nb);
> > +             usb_put_phy(info->usb_phy);
> > +     }
> > +#endif
> > +     return ret;
> > +}
> > +
> > +static int rt9455_remove(struct i2c_client *client)
> > +{
> > +     int ret;
> > +     struct rt9455_info *info = i2c_get_clientdata(client);
> > +
> > +     ret = rt9455_register_reset(info);
> > +     if (ret)
> > +             dev_err(&info->client->dev, "Failed to set charger to its default values\n");
> > +
> > +#if IS_ENABLED(CONFIG_USB_PHY)
> > +     if (!IS_ERR_OR_NULL(info->usb_phy)) {
> > +             usb_unregister_notifier(info->usb_phy, &info->nb);
> > +             usb_put_phy(info->usb_phy);
> > +     }
> > +#endif
> > +
> > +     cancel_delayed_work_sync(&info->pwr_rdy_work);
> > +     cancel_delayed_work_sync(&info->max_charging_time_work);
> > +     cancel_delayed_work_sync(&info->batt_presence_work);
> > +
> > +     power_supply_unregister(info->charger);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct i2c_device_id rt9455_i2c_id_table[] = {
> > +     { RT9455_DRIVER_NAME, 0 },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(i2c, rt9455_i2c_id_table);
> > +
> > +static const struct of_device_id rt9455_of_match[] = {
> > +     { .compatible = "richtek,rt9455", },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, rt9455_of_match);
> > +
> > +static const struct acpi_device_id rt9455_i2c_acpi_match[] = {
> > +     { "RT945500", 0 },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, rt9455_i2c_acpi_match);
> > +
> > +static struct i2c_driver rt9455_driver = {
> > +     .probe          = rt9455_probe,
> > +     .remove         = rt9455_remove,
> > +     .id_table       = rt9455_i2c_id_table,
> > +     .driver = {
> > +             .name           = RT9455_DRIVER_NAME,
> > +             .of_match_table = of_match_ptr(rt9455_of_match),
> > +             .acpi_match_table = ACPI_PTR(rt9455_i2c_acpi_match),
> > +     },
> > +};
> > +module_i2c_driver(rt9455_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Anda-Maria Nicolae <anda-maria.nicolae@intel.com>");
> > +MODULE_ALIAS("i2c:rt9455-charger");
> > +MODULE_DESCRIPTION("Richtek RT9455 Charger Driver");
> > --
> > 1.7.9.5
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
