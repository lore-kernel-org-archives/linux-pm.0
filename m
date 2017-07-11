From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v2] power: supply: ltc2941-battery-gauge: Add LTC2944
 support
Date: Wed, 12 Jul 2017 01:11:56 +0200
Message-ID: <20170711231156.mavruc6xsiv4gvla@lenoch>
References: <20170711160732.16170-1-dragos.bogdan@analog.com>
 <20170711205911.w6pp2kdaeo5iv2yo@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:48672 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754028AbdGKXL7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 19:11:59 -0400
Content-Disposition: inline
In-Reply-To: <20170711205911.w6pp2kdaeo5iv2yo@lenoch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dragos Bogdan <dragos.bogdan@analog.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mike Looijmans <mike.looijmans@topic.nl>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 11, 2017 at 10:59:11PM +0200, Ladislav Michl wrote:
> On Tue, Jul 11, 2017 at 07:07:32PM +0300, Dragos Bogdan wrote:
> > The only difference between the already supported LTC2943 and LTC2944 is the operating range (3.6V - 20V compared to 3.6V - 60V).
> 
> Please wrap commit message correctly.
> 
> > Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> > ---
> > Changes in v2:
> > - Fix the voltage and current conversion.
> 
> That's better :-) However it conflicts with LTC2942 patch. I can fix

Well, still not good enough. You overlooked different temperature
computing formula. For a bug, see bellow.

> this and extend LTC2942 patch serie to add LTC2944. Okay to proceed
> or do you want to take care about this yourself? Also it is nice to

I'll provide patchset myself, it is mostly done now. I'd appreciate
if you could test it on your device.

> Cc driver author (done now).
> 
> 	ladis
> 
> >  .../devicetree/bindings/power/supply/ltc2941.txt   | 10 ++---
> >  drivers/power/supply/ltc2941-battery-gauge.c       | 46 +++++++++++++++++-----
> >  2 files changed, 41 insertions(+), 15 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/supply/ltc2941.txt b/Documentation/devicetree/bindings/power/supply/ltc2941.txt
> > index a9d7aa60558b..ed0f02846d10 100644
> > --- a/Documentation/devicetree/bindings/power/supply/ltc2941.txt
> > +++ b/Documentation/devicetree/bindings/power/supply/ltc2941.txt
> > @@ -1,9 +1,9 @@
> > -binding for LTC2941 and LTC2943 battery gauges
> > +binding for LTC2941, LTC2943 and LTC2944 battery gauges
> >  
> > -Both the LTC2941 and LTC2943 measure battery capacity.
> > -The LTC2943 is compatible with the LTC2941, it adds voltage and
> > -temperature monitoring, and uses a slightly different conversion
> > -formula for the charge counter.
> > +All the LTC2941, LTC2943 and LTC2944 measure battery capacity.
> > +The LTC2943 and LTC2944 are compatible with the LTC2941, they add voltage and
> > +temperature monitoring, and use a slightly different conversion formula for the
> > +charge counter.
> >  
> >  Required properties:
> >  - compatible: Should contain "lltc,ltc2941" or "lltc,ltc2943" which also
> > diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
> > index 7efb908f4451..4c979b1a022b 100644
> > --- a/drivers/power/supply/ltc2941-battery-gauge.c
> > +++ b/drivers/power/supply/ltc2941-battery-gauge.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * I2C client/driver for the Linear Technology LTC2941 and LTC2943
> > + * I2C client/driver for the Linear Technology LTC2941, LTC2943 and LTC2944
> >   * Battery Gas Gauge IC
> >   *
> >   * Copyright (C) 2014 Topic Embedded Systems
> > @@ -57,6 +57,12 @@ enum ltc294x_reg {
> >  #define LTC2941_NUM_REGS	0x08
> >  #define LTC2943_NUM_REGS	0x18
> >  
> > +enum ltc294x_id {
> > +	LTC2941_ID,
> > +	LTC2943_ID,
> > +	LTC2944_ID,
> > +};
> > +
> >  struct ltc294x_info {
> >  	struct i2c_client *client;	/* I2C Client pointer */
> >  	struct power_supply *supply;	/* Supply pointer */
> > @@ -66,6 +72,7 @@ struct ltc294x_info {
> >  	int charge;	/* Last charge register content */
> >  	int r_sense;	/* mOhm */
> >  	int Qlsb;	/* nAh */
> > +	enum ltc294x_id id;
> >  };
> >  
> >  static inline int convert_bin_to_uAh(
> > @@ -145,7 +152,7 @@ static int ltc294x_reset(const struct ltc294x_info *info, int prescaler_exp)
> >  
> >  	control = LTC294X_REG_CONTROL_PRESCALER_SET(prescaler_exp) |
> >  				LTC294X_REG_CONTROL_ALCC_CONFIG_DISABLED;
> > -	/* Put the 2943 into "monitor" mode, so it measures every 10 sec */
> > +	/* Put the 2943/4 into "monitor" mode, so it measures every 10 sec */
> >  	if (info->num_regs == LTC2943_NUM_REGS)
> >  		control |= LTC2943_REG_CONTROL_MODE_SCAN;
> >  
> > @@ -248,11 +255,16 @@ static int ltc294x_get_voltage(const struct ltc294x_info *info, int *val)
> >  	int ret;
> >  	u8 datar[2];
> >  	u32 value;
> > +	u32 full_scale;
> >  
> >  	ret = ltc294x_read_regs(info->client,
> >  		LTC294X_REG_VOLTAGE_MSB, &datar[0], 2);
> >  	value = (datar[0] << 8) | datar[1];
> > -	*val = ((value * 23600) / 0xFFFF) * 1000; /* in uV */
> > +	if (info->id == LTC2944_ID)
> > +		full_scale = 70800;
> > +	else
> > +		full_scale = 23600;
> > +	*val = ((value * full_scale) / 0xFFFF) * 1000; /* in uV */

Here result of 14bit ADC conversion is stored in 16bit register with
lowest two bits being zero. Multiplying that with 70800 will overflow
32bit unsigned integer.

> >  	return ret;
> >  }
> >  
> > @@ -261,15 +273,20 @@ static int ltc294x_get_current(const struct ltc294x_info *info, int *val)
> >  	int ret;
> >  	u8 datar[2];
> >  	s32 value;
> > +	u32 full_scale;
> >  
> >  	ret = ltc294x_read_regs(info->client,
> >  		LTC294X_REG_CURRENT_MSB, &datar[0], 2);
> >  	value = (datar[0] << 8) | datar[1];
> >  	value -= 0x7FFF;
> > +	if (info->id == LTC2944_ID)
> > +		full_scale = 64000;
> > +	else
> > +		full_scale = 60000;
> >  	/* Value is in range -32k..+32k, r_sense is usually 10..50 mOhm,
> >  	 * the formula below keeps everything in s32 range while preserving
> >  	 * enough digits */
> > -	*val = 1000 * ((60000 * value) / (info->r_sense * 0x7FFF)); /* in uA */
> > +	*val = 1000 * ((full_scale * value) / (info->r_sense * 0x7FFF)); /* in uA */
> >  	return ret;
> >  }
> >  
> > @@ -388,7 +405,11 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
> >  
> >  	np = of_node_get(client->dev.of_node);
> >  
> > -	info->num_regs = (unsigned long)of_device_get_match_data(&client->dev);
> > +	info->id = (enum ltc294x_id)of_device_get_match_data(&client->dev);
> > +	if (info->id == LTC2941_ID)
> > +		info->num_regs = LTC2941_NUM_REGS;
> > +	else
> > +		info->num_regs = LTC2943_NUM_REGS;
> >  	info->supply_desc.name = np->name;
> >  
> >  	/* r_sense can be negative, when sense+ is connected to the battery
> > @@ -492,8 +513,9 @@ static SIMPLE_DEV_PM_OPS(ltc294x_pm_ops, ltc294x_suspend, ltc294x_resume);
> >  
> >  
> >  static const struct i2c_device_id ltc294x_i2c_id[] = {
> > -	{"ltc2941", LTC2941_NUM_REGS},
> > -	{"ltc2943", LTC2943_NUM_REGS},
> > +	{"ltc2941", LTC2941_ID},
> > +	{"ltc2943", LTC2943_ID},
> > +	{"ltc2944", LTC2944_ID},
> >  	{ },
> >  };
> >  MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);
> > @@ -501,11 +523,15 @@ MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);
> >  static const struct of_device_id ltc294x_i2c_of_match[] = {
> >  	{
> >  		.compatible = "lltc,ltc2941",
> > -		.data = (void *)LTC2941_NUM_REGS
> > +		.data = (void *)LTC2941_ID
> >  	},
> >  	{
> >  		.compatible = "lltc,ltc2943",
> > -		.data = (void *)LTC2943_NUM_REGS
> > +		.data = (void *)LTC2943_ID
> > +	},
> > +	{
> > +		.compatible = "lltc,ltc2944",
> > +		.data = (void *)LTC2944_ID
> >  	},
> >  	{ },
> >  };
> > @@ -525,5 +551,5 @@ module_i2c_driver(ltc294x_driver);
> >  
> >  MODULE_AUTHOR("Auryn Verwegen, Topic Embedded Systems");
> >  MODULE_AUTHOR("Mike Looijmans, Topic Embedded Products");
> > -MODULE_DESCRIPTION("LTC2941/LTC2943 Battery Gas Gauge IC driver");
> > +MODULE_DESCRIPTION("LTC2941/LTC2943/LTC2944 Battery Gas Gauge IC driver");
> >  MODULE_LICENSE("GPL");
> > -- 
> > 2.11.0
