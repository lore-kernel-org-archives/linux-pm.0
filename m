From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v4 07/10] power: bq24257: Add input DPM voltage threshold
 setting support
Date: Wed, 16 Sep 2015 14:40:47 -0500
Message-ID: <20150916194044.GD27772@beast>
References: <1442339914-25843-1-git-send-email-dannenberg@ti.com>
 <1442339914-25843-8-git-send-email-dannenberg@ti.com>
 <55F906CC.8090609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59255 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbbIPTlO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 15:41:14 -0400
Content-Disposition: inline
In-Reply-To: <55F906CC.8090609@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Sep 16, 2015 at 03:06:04PM +0900, Krzysztof Kozlowski wrote:
> On 16.09.2015 02:58, Andreas Dannenberg wrote:
> > A new optional device property called "ti,in-dpm-voltage" is introduced
> > to allow configuring the input voltage threshold for the devices'
> > dynamic power path management (DPM) feature. In short, it can be used to
> > prevent the input voltage from dropping below a certain value as current
> > is drawn to charge the battery or supply the system.
> > 
> > Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> > ---
> >  drivers/power/bq24257_charger.c | 44 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
> > index 47af858..84a8945 100644
> > --- a/drivers/power/bq24257_charger.c
> > +++ b/drivers/power/bq24257_charger.c
> > @@ -76,6 +76,7 @@ struct bq24257_init_data {
> >  	u8 iterm;	/* termination current */
> >  	u8 in_ilimit;	/* input current limit */
> >  	u8 vovp;	/* over voltage protection voltage */
> > +	u8 vindpm;	/* VDMP input threshold voltage */
> >  };
> >  
> >  struct bq24257_state {
> > @@ -206,6 +207,13 @@ static const u32 bq24257_vovp_map[] = {
> >  
> >  #define BQ24257_VOVP_MAP_SIZE		ARRAY_SIZE(bq24257_vovp_map)
> >  
> > +static const u32 bq24257_vindpm_map[] = {
> > +	4200000, 4280000, 4360000, 4440000, 4520000, 4600000, 4680000,
> > +	4760000
> > +};
> > +
> > +#define BQ24257_VINDPM_MAP_SIZE		ARRAY_SIZE(bq24257_vindpm_map)
> > +
> >  static int bq24257_field_read(struct bq24257_device *bq,
> >  			      enum bq24257_fields field_id)
> >  {
> > @@ -432,6 +440,17 @@ enum bq24257_vovp {
> >  	VOVP_10500
> >  };
> >  
> > +enum bq24257_vindpm {
> > +	VINDPM_4200,
> > +	VINDPM_4280,
> > +	VINDPM_4360,
> > +	VINDPM_4440,
> > +	VINDPM_4520,
> > +	VINDPM_4600,
> > +	VINDPM_4680,
> > +	VINDPM_4760
> > +};
> 
> Same as patch 6/10... but now see the use case - to choose default value
> not by index of array but from this enum.
> 
> I see the idea behind so skip that comment from 6/10.

OK.

> > +
> >  enum bq24257_port_type {
> >  	PORT_TYPE_DCP,		/* Dedicated Charging Port */
> >  	PORT_TYPE_CDP,		/* Charging Downstream Port */
> > @@ -615,6 +634,7 @@ static int bq24257_hw_init(struct bq24257_device *bq)
> >  		{F_VBAT, bq->init_data.vbat},
> >  		{F_ITERM, bq->init_data.iterm},
> >  		{F_VOVP, bq->init_data.vovp},
> > +		{F_VINDPM, bq->init_data.vindpm},
> >  	};
> >  
> >  	/*
> > @@ -648,6 +668,7 @@ static int bq24257_hw_init(struct bq24257_device *bq)
> >  		/* program fixed input current limit */
> >  		ret = bq24257_field_write(bq, F_IILIMIT,
> >  					  bq->init_data.in_ilimit);
> > +
> 
> Not part of this patch. It confuses the reviewer of patch. If you need
> cleanups, make them separate.

Artifact. This should not be there.

> >  		if (ret < 0)
> >  			return ret;
> >  	} else if (!state.power_good)
> > @@ -695,10 +716,23 @@ static ssize_t bq24257_show_ovp_voltage(struct device *dev,
> >  			 bq24257_vovp_map[bq->init_data.vovp]);
> >  }
> >  
> > +static ssize_t bq24257_show_in_dpm_voltage(struct device *dev,
> > +					   struct device_attribute *attr,
> > +					   char *buf)
> > +{
> > +	struct power_supply *psy = dev_get_drvdata(dev);
> > +	struct bq24257_device *bq = power_supply_get_drvdata(psy);
> > +
> > +	return scnprintf(buf, PAGE_SIZE, "%d\n",
> > +			 bq24257_vindpm_map[bq->init_data.vindpm]);
> 
> Same as patch 6/10.

OK.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc

> 
> Best regards,
> Krzysztof
> 
> > +}
> > +
> >  static DEVICE_ATTR(ovp_voltage, S_IRUGO, bq24257_show_ovp_voltage, NULL);
> > +static DEVICE_ATTR(in_dpm_voltage, S_IRUGO, bq24257_show_in_dpm_voltage, NULL);
> >  
> >  static struct attribute *bq24257_charger_attr[] = {
> >  	&dev_attr_ovp_voltage.attr,
> > +	&dev_attr_in_dpm_voltage.attr,
> >  	NULL,
> >  };
> >  
> > @@ -801,6 +835,16 @@ static int bq24257_fw_probe(struct bq24257_device *bq)
> >  						      bq24257_vovp_map,
> >  						      BQ24257_VOVP_MAP_SIZE);
> >  
> > +	ret = device_property_read_u32(bq->dev, "ti,in-dpm-voltage",
> > +				       &property);
> > +	if (ret < 0)
> > +		bq->init_data.vindpm = VINDPM_4360;
> > +	else
> > +		bq->init_data.vindpm =
> > +				bq24257_find_idx(property,
> > +						 bq24257_vindpm_map,
> > +						 BQ24257_VINDPM_MAP_SIZE);
> > +
> >  	return 0;
> >  }
> >  
> > 
> 
