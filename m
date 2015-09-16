From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH v4 09/10] power: bq24257: Add various device-specific
 sysfs properties
Date: Wed, 16 Sep 2015 14:54:53 -0500
Message-ID: <20150916195449.GF27772@beast>
References: <1442339914-25843-1-git-send-email-dannenberg@ti.com>
 <1442339914-25843-10-git-send-email-dannenberg@ti.com>
 <55F923DE.5010809@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59800 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbbIPTz2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 15:55:28 -0400
Content-Disposition: inline
In-Reply-To: <55F923DE.5010809@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Sep 16, 2015 at 05:10:06PM +0900, Krzysztof Kozlowski wrote:
> On 16.09.2015 02:58, Andreas Dannenberg wrote:
> > This patch adds support for enabling/disabling optional device specific
> > features through sysfs properties at runtime.
> > 
> > * High-impedance mode enable/disable
> > * Sysoff enable/disable
> > 
> > Refer to the respective device datasheets for more information:
> > 
> > http://www.ti.com/product/bq24250
> > http://www.ti.com/product/bq24251
> > http://www.ti.com/product/bq24257
> > 
> > Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> > ---
> >  drivers/power/bq24257_charger.c | 53 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> > 
> > diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
> > index 517a522..a0cb33c 100644
> > --- a/drivers/power/bq24257_charger.c
> > +++ b/drivers/power/bq24257_charger.c
> > @@ -794,12 +794,65 @@ static ssize_t bq24257_show_in_dpm_voltage(struct device *dev,
> >  			 bq24257_vindpm_map[bq->init_data.vindpm]);
> >  }
> >  
> > +static ssize_t bq24257_sysfs_show_enable(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 char *buf)
> > +{
> > +	struct power_supply *psy = dev_get_drvdata(dev);
> > +	struct bq24257_device *bq = power_supply_get_drvdata(psy);
> > +	int ret;
> > +
> > +	if (strcmp(attr->attr.name, "high_impedance_enable") == 0)
> > +		ret = bq24257_field_read(bq, F_HZ_MODE);
> > +	else if (strcmp(attr->attr.name, "sysoff_enable") == 0)
> > +		ret = bq24257_field_read(bq, F_SYSOFF);
> > +	else
> > +		return -EINVAL;
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
> > +}
> > +
> > +static ssize_t bq24257_sysfs_set_enable(struct device *dev,
> > +					struct device_attribute *attr,
> > +					const char *buf,
> > +					size_t count)
> > +{
> > +	struct power_supply *psy = dev_get_drvdata(dev);
> > +	struct bq24257_device *bq = power_supply_get_drvdata(psy);
> > +	long val;
> > +	int ret;
> > +
> > +	if (kstrtol(buf, 10, &val) < 0)
> > +		return -EINVAL;
> > +
> 
> There is no validation for input number. Although this is harmless but
> one may expect that writing value of 1, 2 or 3 would give the same
> result. But it would not. Value of 2 would be equal to 0, right?

You are right 2 would result in 0. Changing where the value gets passed
into bq24257_field_write() from "val" to "(bool)val" will make this more
forgiving.

> > +	if (strcmp(attr->attr.name, "high_impedance_enable") == 0)
> > +		ret = bq24257_field_write(bq, F_HZ_MODE, val);
> > +	else if (strcmp(attr->attr.name, "sysoff_enable") == 0)
> > +		ret = bq24257_field_write(bq, F_SYSOFF, val);
> > +	else
> > +		return -EINVAL;
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return count;
> > +}
> > +
> >  static DEVICE_ATTR(ovp_voltage, S_IRUGO, bq24257_show_ovp_voltage, NULL);
> >  static DEVICE_ATTR(in_dpm_voltage, S_IRUGO, bq24257_show_in_dpm_voltage, NULL);
> 
> This applies to previous patches actually: DEVICE_ATTR_RO?

Ok. Will simplify.

> 
> > +static DEVICE_ATTR(high_impedance_enable, S_IWUSR | S_IRUGO,
> > +		   bq24257_sysfs_show_enable, bq24257_sysfs_set_enable);
> > +static DEVICE_ATTR(sysoff_enable, S_IWUSR | S_IRUGO,
> > +		   bq24257_sysfs_show_enable, bq24257_sysfs_set_enable);
> 
> DEVICE_ATTR_RW?

Ditto.

Regards,

--
Andreas Dannenberg
Texas Instruments Inc
