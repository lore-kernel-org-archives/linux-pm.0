From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v2 02/13] power: bq24257: Add basic support for
 bq24250/bq24251
Date: Thu, 10 Sep 2015 11:19:44 -0500
Message-ID: <20150910161944.GA16768@borg>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-3-git-send-email-dannenberg@ti.com>
 <20150910124210.GD21512@lpalcu-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34552 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626AbbIJQUT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Sep 2015 12:20:19 -0400
Content-Disposition: inline
In-Reply-To: <20150910124210.GD21512@lpalcu-desk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Sep 10, 2015 at 03:42:11PM +0300, Laurentiu Palcu wrote:
> On Tue, Sep 08, 2015 at 07:12:26PM -0500, Andreas Dannenberg wrote:
> [...]
> >  
> >  #include <linux/module.h>
> > @@ -41,6 +45,18 @@
> >  
> >  #define BQ24257_ILIM_SET_DELAY		1000	/* msec */
> >  
> > +enum bq2425x_chip {
> > +	BQ24250,
> > +	BQ24251,
> > +	BQ24257,
> > +};
> > +
> > +static const char *bq2425x_chip_name[] = {
> static const char *const bq2425x_chip_name[]
> 
> That's safer and it also makes checkpatch happy.

Ok changed.

> > +	"bq24250",
> > +	"bq24251",
> > +	"bq24257",
> > +};
> > +
> >  enum bq24257_fields {
> >  	F_WD_FAULT, F_WD_EN, F_STAT, F_FAULT,			    /* REG 1 */
> >  	F_RESET, F_IILIMIT, F_EN_STAT, F_EN_TERM, F_CE, F_HZ_MODE,  /* REG 2 */
> > @@ -71,6 +87,8 @@ struct bq24257_device {
> >  	struct device *dev;
> >  	struct power_supply *charger;
> >  
> > +	enum bq2425x_chip chip;
> > +
> >  	struct regmap *rmap;
> >  	struct regmap_field *rmap_fields[F_MAX_FIELDS];
> >  
> > @@ -250,6 +268,10 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
> >  		val->strval = BQ24257_MANUFACTURER;
> >  		break;
> >  
> > +	case POWER_SUPPLY_PROP_MODEL_NAME:
> > +		val->strval = bq2425x_chip_name[bq->chip];
> > +		break;
> > +
> >  	case POWER_SUPPLY_PROP_ONLINE:
> >  		val->intval = state.power_good;
> >  		break;
> > @@ -570,6 +592,7 @@ static int bq24257_hw_init(struct bq24257_device *bq)
> >  
> >  static enum power_supply_property bq24257_power_supply_props[] = {
> >  	POWER_SUPPLY_PROP_MANUFACTURER,
> > +	POWER_SUPPLY_PROP_MODEL_NAME,
> >  	POWER_SUPPLY_PROP_STATUS,
> >  	POWER_SUPPLY_PROP_ONLINE,
> >  	POWER_SUPPLY_PROP_HEALTH,
> > @@ -667,6 +690,7 @@ static int bq24257_probe(struct i2c_client *client,
> >  {
> >  	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
> >  	struct device *dev = &client->dev;
> > +	const struct acpi_device_id *acpi_id;
> >  	struct bq24257_device *bq;
> >  	int ret;
> >  	int i;
> > @@ -683,6 +707,18 @@ static int bq24257_probe(struct i2c_client *client,
> >  	bq->client = client;
> >  	bq->dev = dev;
> >  
> > +	if (ACPI_HANDLE(dev)) {
> > +		acpi_id = acpi_match_device(dev->driver->acpi_match_table,
> > +				&client->dev);
> > +		if (!acpi_id) {
> > +			dev_err(dev, "Failed to match ACPI device\n");
> > +			return -ENODEV;
> > +		}
> > +		bq->chip = (enum bq2425x_chip)acpi_id->driver_data;
> > +	} else {
> > +		bq->chip = (enum bq2425x_chip)id->driver_data;
> > +	}
> > +
> >  	mutex_init(&bq->lock);
> >  
> >  	bq->rmap = devm_regmap_init_i2c(client, &bq24257_regmap_config);
> > @@ -824,19 +860,27 @@ static const struct dev_pm_ops bq24257_pm = {
> >  };
> >  
> >  static const struct i2c_device_id bq24257_i2c_ids[] = {
> > -	{ "bq24257", 0 },
> > +	{ "bq24250", BQ24250 },
> > +	{ "bq24251", BQ24251 },
> > +	{ "bq24257", BQ24257 },
> >  	{},
> >  };
> >  MODULE_DEVICE_TABLE(i2c, bq24257_i2c_ids);
> >  
> >  static const struct of_device_id bq24257_of_match[] = {
> > -	{ .compatible = "ti,bq24257", },
> > +	{
> > +		.compatible = "ti,bq24250",
> > +		.compatible = "ti,bq24251",
> > +		.compatible = "ti,bq24257",
> > +	},
> Maybe you wanted:
> 	{ .compatible = "ti,bq24250", },
> 	{ .compatible = "ti,bq24251", },
> 	{ .compatible = "ti,bq24252", },

Yes that's what I wanted. Interestingly in my testing the device
configured in the device tree was identified correctly, but I suppose
this worked because of some other fallback mechanism (maybe using the
i2c_device_id?). Anyways it's fixed now.

> >  	{ },
> >  };
> 
> BTW, ACPI enumeration works fine. I tested the series on my setup
> (before starting to review the patches :D).

Thanks for going the extra mile and testing ACPI support, I really
appreciate it. I should get my MinnowBoard on Saturday (it'll make for a
fun weekend!) so I should be able to do such testing for this and other
TI drivers myself.

--
Andreas Dannenberg
Texas Instruments Inc

> 
> laurentiu
