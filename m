From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 06/10] power: bq24257: Add over voltage protection
 setting support
Date: Wed, 16 Sep 2015 14:55:12 +0900
Message-ID: <55F90440.60302@samsung.com>
References: <1442339914-25843-1-git-send-email-dannenberg@ti.com>
 <1442339914-25843-7-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:9900 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbbIPFzQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 01:55:16 -0400
In-reply-to: <1442339914-25843-7-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 16.09.2015 02:58, Andreas Dannenberg wrote:
> A new optional device property called "ti,ovp-voltage" is introduced to
> allow configuring the input over voltage protection setting.
> 
> This commit also adds the basic sysfs support for custom properties
> which is being used to allow userspace to read the current ovp-voltage
> setting.
> 
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> ---
>  drivers/power/bq24257_charger.c | 67 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
> index d7488cf..47af858 100644
> --- a/drivers/power/bq24257_charger.c
> +++ b/drivers/power/bq24257_charger.c
> @@ -75,6 +75,7 @@ struct bq24257_init_data {
>  	u8 vbat;	/* regulation voltage  */
>  	u8 iterm;	/* termination current */
>  	u8 in_ilimit;	/* input current limit */
> +	u8 vovp;	/* over voltage protection voltage */
>  };
>  
>  struct bq24257_state {
> @@ -198,6 +199,13 @@ static const u32 bq24257_iilimit_map[] = {
>  
>  #define BQ24257_IILIMIT_MAP_SIZE	ARRAY_SIZE(bq24257_iilimit_map)
>  
> +static const u32 bq24257_vovp_map[] = {
> +	6000000, 6500000, 7000000, 8000000, 9000000, 9500000, 10000000,
> +	10500000
> +};
> +
> +#define BQ24257_VOVP_MAP_SIZE		ARRAY_SIZE(bq24257_vovp_map)
> +
>  static int bq24257_field_read(struct bq24257_device *bq,
>  			      enum bq24257_fields field_id)
>  {
> @@ -413,6 +421,17 @@ enum bq24257_in_ilimit {
>  	IILIMIT_NONE,
>  };
>  
> +enum bq24257_vovp {
> +	VOVP_6000,
> +	VOVP_6500,
> +	VOVP_7000,
> +	VOVP_8000,
> +	VOVP_9000,
> +	VOVP_9500,
> +	VOVP_10000,
> +	VOVP_10500
> +};

What is the purpose of this enum? It is duplicating values from the map
(so you can make a mistake in its order) but actually is not used. I
don't see benefit.

> +
>  enum bq24257_port_type {
>  	PORT_TYPE_DCP,		/* Dedicated Charging Port */
>  	PORT_TYPE_CDP,		/* Charging Downstream Port */
> @@ -594,7 +613,8 @@ static int bq24257_hw_init(struct bq24257_device *bq)
>  	} init_data[] = {
>  		{F_ICHG, bq->init_data.ichg},
>  		{F_VBAT, bq->init_data.vbat},
> -		{F_ITERM, bq->init_data.iterm}
> +		{F_ITERM, bq->init_data.iterm},
> +		{F_VOVP, bq->init_data.vovp},
>  	};
>  
>  	/*
> @@ -664,6 +684,28 @@ static const struct power_supply_desc bq24257_power_supply_desc = {
>  	.get_property = bq24257_power_supply_get_property,
>  };
>  
> +static ssize_t bq24257_show_ovp_voltage(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct power_supply *psy = dev_get_drvdata(dev);
> +	struct bq24257_device *bq = power_supply_get_drvdata(psy);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n",

"%u", you are printing u32.

> +			 bq24257_vovp_map[bq->init_data.vovp]);
> +}
> +
> +static DEVICE_ATTR(ovp_voltage, S_IRUGO, bq24257_show_ovp_voltage, NULL);
> +
> +static struct attribute *bq24257_charger_attr[] = {
> +	&dev_attr_ovp_voltage.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group bq24257_attr_group = {
> +	.attrs = bq24257_charger_attr,
> +};
> +
>  static int bq24257_power_supply_init(struct bq24257_device *bq)
>  {
>  	struct power_supply_config psy_cfg = { .drv_data = bq, };
> @@ -750,6 +792,15 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
>  						 BQ24257_IILIMIT_MAP_SIZE);
>  	}
>  
> +	ret = device_property_read_u32(bq->dev, "ti,ovp-voltage",
> +				       &property);
> +	if (ret < 0)
> +		bq->init_data.vovp = VOVP_6500;
> +	else
> +		bq->init_data.vovp = bq24257_find_idx(property,
> +						      bq24257_vovp_map,
> +						      BQ24257_VOVP_MAP_SIZE);
> +
>  	return 0;
>  }
>  
> @@ -889,10 +940,18 @@ static int bq24257_probe(struct i2c_client *client,
>  		return ret;
>  
>  	ret = bq24257_power_supply_init(bq);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(dev, "Failed to register power supply\n");
> +		return ret;
> +	}
>  
> -	return ret;
> +	ret = sysfs_create_group(&bq->charger->dev.kobj, &bq24257_attr_group);
> +	if (ret < 0) {
> +		dev_err(dev, "Can't create sysfs entries\n");

power_supply_unregister(bq->charger);
or convert in separate patch to devm-like method.

Best regards,
Krzysztof

> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  static int bq24257_remove(struct i2c_client *client)
> @@ -902,6 +961,8 @@ static int bq24257_remove(struct i2c_client *client)
>  	if (!bq->in_ilimit_autoset_disable)
>  		cancel_delayed_work_sync(&bq->iilimit_setup_work);
>  
> +	sysfs_remove_group(&bq->charger->dev.kobj, &bq24257_attr_group);
> +
>  	power_supply_unregister(bq->charger);
>  
>  	bq24257_field_write(bq, F_RESET, 1); /* reset to defaults */
> 

