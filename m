From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [RFC Patch 2/4] mfd: AXP20x: Add power supply sub-driver
Date: Thu, 23 Oct 2014 11:29:17 +0200
Message-ID: <20141023092917.GK7893@lukather>
References: <20141020221959.2f312906@neptune.home>
 <20141020223320.2b4ecba9@neptune.home>
 <20141021202715.GC7893@lukather>
 <20141022083013.6b90be7e@pluto.restena.lu>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I4VOKWutKNZEOIPu"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBH4VUORAKGQE7RF56RQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141022083013.6b90be7e-I2t2yFIzmohO7ya8xxV06g@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olliver Schinagl <oliver+list-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--I4VOKWutKNZEOIPu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 22, 2014 at 08:30:13AM +0200, Bruno Pr=E9mont wrote:
> > > +
> > > +static int axp20x_power_poll(struct axp20x_power *devdata, int init)
> > > +{
> > > +	struct axp20x_dev *axp20x =3D devdata->axp20x;
> > > +	struct timespec ts;
> > > +	int ret, status1, status2, vbusmgt, adc_cfg, bpercent;
> > > +	uint8_t adc[19];
> > > +
> > > +	getnstimeofday(&ts);
> > > +	/* only query hardware if our data is stale */
> >=20
> > Is it called that often?
>=20
> Pretty often yes.
> When accessing /sys/class/power_supply/*/uevent it's one call per
> property, for the property specific sysfs files its one per file read.
>=20
> Notifying power_supply subsystem about changes also triggers one access
> per defined property.
>=20
> Initially I tried without caching data and it caused quite severe
> latencies (would have to redo the tests for proper quantifying).

Hmmm, it's odd, I would have expected that the framework would have
some kind of rate limiting.

> I looked at regmap's caching feature but it seems not possible to tell
> it to flush (part of) its cache.

I think regcache_drop_region is here just for that.

>=20
> > > +	spin_lock(&devdata->lock);
> > > +	if (!init && !(ts.tv_sec > devdata->next_check.tv_sec ||
> > > +	               ts.tv_nsec > devdata->next_check.tv_sec)) {
> > > +		spin_unlock(&devdata->lock);
> > > +		return 0;
> > > +	}
> > > +	spin_unlock(&devdata->lock);
> > > +
> > > +	ret =3D regmap_read(axp20x->regmap, AXP20X_PWR_INPUT_STATUS, &statu=
s1);
> > > +	if (ret)
> > > +		return ret;
> > > +	ret =3D regmap_read(axp20x->regmap, AXP20X_PWR_OP_MODE, &status2);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D regmap_read(axp20x->regmap, AXP20X_ADC_RATE, &adc_cfg);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (init =3D=3D 2) {
> > > +		int reg =3D AXP20X_ADC_EN1_VBUS_V | AXP20X_ADC_EN1_VBUS_C;
> > > +
> > > +		if (!(status1 & AXP20X_PWR_STATUS_AC_VBUS_SHORT))
> > > +			reg |=3D AXP20X_ADC_EN1_ACIN_V | AXP20X_ADC_EN1_ACIN_C;
> > > +		if (devdata->battery_name[0])
> > > +			reg |=3D AXP20X_ADC_EN1_BATT_V | AXP20X_ADC_EN1_BATT_C;
> > > +		if (devdata->battery_name[0] &&
> > > +		    !(adc_cfg & AXP20X_ADR_TS_UNRELATED))
> > > +			reg |=3D AXP20X_ADC_EN1_TEMP;
> > > +
> > > +		regmap_update_bits(axp20x->regmap, AXP20X_ADC_EN1,
> > > +			AXP20X_ADC_EN1_ACIN_V | AXP20X_ADC_EN1_ACIN_C |
> > > +			AXP20X_ADC_EN1_VBUS_V | AXP20X_ADC_EN1_VBUS_C |
> > > +			AXP20X_ADC_EN1_BATT_V | AXP20X_ADC_EN1_BATT_C |
> > > +			AXP20X_ADC_EN1_TEMP, reg);
> > > +	}
> > > +
> > > +	ret =3D regmap_read(axp20x->regmap, AXP20X_VBUS_IPSOUT_MGMT, &vbusm=
gt);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D regmap_bulk_read(axp20x->regmap, AXP20X_ACIN_V_ADC_H, adc, =
8);
> > > +	if (ret)
> > > +		return ret;
> > > +	if (devdata->battery_name[0] && !(adc_cfg & AXP20X_ADR_TS_UNRELATED=
)) {
> > > +		ret =3D regmap_bulk_read(axp20x->regmap, AXP20X_TS_IN_H, adc+8, 2);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +	if (devdata->battery_name[0]) {
> > > +		ret =3D regmap_bulk_read(axp20x->regmap, AXP20X_PWR_BATT_H, adc+10=
, 3);
> > > +		if (ret)
> > > +			return ret;
> > > +		ret =3D regmap_bulk_read(axp20x->regmap, AXP20X_BATT_V_H, adc+13, =
6);
> > > +		if (ret)
> > > +			return ret;
> > > +		ret =3D regmap_read(axp20x->regmap, AXP20X_FG_RES, &bpercent);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	switch (adc_cfg & AXP20X_ADR_RATE_MASK) {
> > > +	case AXP20X_ADR_RATE_200Hz:
> > > +		timespec_add_ns(&ts,  5000000); break;
> > > +	case AXP20X_ADR_RATE_100Hz:
> > > +		timespec_add_ns(&ts, 10000000); break;
> > > +	case AXP20X_ADR_RATE_50Hz:
> > > +		timespec_add_ns(&ts, 20000000); break;
> > > +	case AXP20X_ADR_RATE_25Hz:
> > > +	default:
> > > +		timespec_add_ns(&ts, 40000000);
> > > +	}
> > > +
> > > +	ret =3D devdata->status1 | (devdata->status2 << 8) |
> > > +	      ((devdata->batt_percent & 0x7f) << 16);
> > > +	if (init =3D=3D 2)
> > > +		timespec_add_ns(&ts, 200000000);
> > > +	spin_lock(&devdata->lock);
> > > +	devdata->vac        =3D ((adc[0] << 4) | (adc[1] & 0x0f)) * 1700;
> > > +	devdata->iac        =3D ((adc[2] << 4) | (adc[3] & 0x0f)) * 625;
> > > +	devdata->vvbus      =3D ((adc[4] << 4) | (adc[5] & 0x0f)) * 1700;
> > > +	devdata->ivbus      =3D ((adc[6] << 4) | (adc[7] & 0x0f)) * 375;
> > > +	devdata->next_check =3D ts;
> > > +	devdata->vbusmgt    =3D vbusmgt;
> > > +	devdata->status1    =3D status1;
> > > +	devdata->status2    =3D status2;
> > > +	if (devdata->battery_name[0] && !(adc_cfg & AXP20X_ADR_TS_UNRELATED=
))
> > > +		devdata->tbatt =3D ((adc[8] << 4) | (adc[9] & 0x0f)) * 800;
> > > +	if (devdata->battery_name[0]) {
> > > +		devdata->vbatt =3D ((adc[13] << 4) | (adc[14] & 0x0f)) * 1100;
> > > +		if (status1 & AXP20X_PWR_STATUS_BAT_CHARGING)
> > > +			devdata->ibatt =3D ((adc[15] << 4) | (adc[16] & 0x0f));
> > > +		else
> > > +			devdata->ibatt =3D ((adc[17] << 4) | (adc[18] & 0x0f));
> > > +		devdata->ibatt *=3D 500;
> > > +		devdata->pbatt =3D ((adc[10] << 16) | (adc[11] << 8) | adc[12]) *
> > > +				 55 / 100;
> > > +		devdata->batt_percent =3D bpercent & 0x7f;
> > > +	}
> > > +	spin_unlock(&devdata->lock);
> > > +
> > > +	if (init =3D=3D 2 || init =3D=3D 0)
> > > +		return 0;
> > > +
> > > +	if ((ret ^ status1) & (AXP20X_PWR_STATUS_VBUS_PRESENT |
> > > +			       AXP20X_PWR_STATUS_VBUS_AVAILABLE))
> > > +		power_supply_changed(&devdata->vbus);
> > > +	if (devdata->ac_name[0]) {
> > > +	} else if ((ret ^ status1) & (AXP20X_PWR_STATUS_AC_PRESENT |
> > > +				     AXP20X_PWR_STATUS_AC_AVAILABLE))
> > > +		power_supply_changed(&devdata->ac);
> > > +	if (!devdata->battery_name[0]) {
> > > +	} else if ((ret ^ status1) & AXP20X_PWR_STATUS_BAT_CHARGING) {
> > > +		power_supply_changed(&devdata->battery);
> > > +	} else if (((ret >> 8) ^ status2) & (AXP20X_PWR_OP_CHARGING |
> > > +		   AXP20X_PWR_OP_BATT_PRESENT | AXP20X_PWR_OP_BATT_ACTIVATED |
> > > +		   AXP20X_PWR_OP_BATT_CHG_CURRENT_LOW)) {
> > > +		power_supply_changed(&devdata->battery);
> > > +	} else if (((ret >> 16) & 0x7f) !=3D (bpercent & 0x7f)) {
> > > +		power_supply_changed(&devdata->battery);
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +static void axp20x_power_monitor(struct work_struct *work)
> > > +{
> > > +	struct axp20x_power *devdata =3D container_of(work,
> > > +					struct axp20x_power, work);
> > > +
> > > +	axp20x_power_poll(devdata, 1);
> > > +
> > > +	/* TODO: check status for consitency
> > > +	 *       adjust battery charging parameters as needed
> > > +	 */
> > > +}
> > > +
> > > +/* ********************************************** *
> > > + * ***  RTC / Backup battery charger          *** *
> > > + * ********************************************** */
> > > +
> > > +/* Fields of AXP20X_CHRG_BAK_CTRL */
> > > +#define AXP20X_BACKUP_ENABLE         (0x01 << 7)
> > > +#define AXP20X_BACKUP_VOLTAGE_MASK   (0x03 << 5)
> > > +#define AXP20X_BACKUP_VOLTAGE_3_1V   (0x00 << 5)
> > > +#define AXP20X_BACKUP_VOLTAGE_3_0V   (0x01 << 5)
> > > +#define AXP20X_BACKUP_VOLTAGE_3_6V   (0x02 << 5)
> > > +#define AXP20X_BACKUP_VOLTAGE_2_5V   (0x03 << 5)
> > > +#define AXP20X_BACKUP_CURRENT_MASK   0x03
> > > +#define AXP20X_BACKUP_CURRENT_50uA   0x00
> > > +#define AXP20X_BACKUP_CURRENT_100uA  0x01
> > > +#define AXP20X_BACKUP_CURRENT_200uA  0x02
> > > +#define AXP20X_BACKUP_CURRENT_400uA  0x03
> > > +
> > > +static int axp20x_backup_config(struct platform_device *pdev,
> > > +				struct axp20x_dev *axp20x)
> > > +{
> > > +	struct device_node *np;
> > > +	int ret =3D 0, reg, new_reg =3D 0;
> > > +	u32 lim[2];
> > > +
> > > +	ret =3D regmap_read(axp20x->regmap, AXP20X_CHRG_BAK_CTRL, &reg);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	np =3D of_node_get(axp20x->dev->of_node);
> > > +	if (!np)
> > > +		return -ENODEV;
> > > +
> > > +	ret =3D of_property_read_u32_array(np, "backup", lim, 2);
> > > +	if (ret !=3D 0)
> > > +		goto err;
> > > +
> > > +	switch (lim[0]) {
> > > +	case 2500000:
> > > +		new_reg |=3D AXP20X_BACKUP_VOLTAGE_2_5V;
> > > +		break;
> > > +	case 3000000:
> > > +		new_reg |=3D AXP20X_BACKUP_VOLTAGE_3_0V;
> > > +		break;
> > > +	case 3100000:
> > > +		new_reg |=3D AXP20X_BACKUP_VOLTAGE_3_1V;
> > > +		break;
> > > +	case 3600000:
> > > +		new_reg |=3D AXP20X_BACKUP_VOLTAGE_3_6V;
> > > +		break;
> > > +	default:
> > > +		dev_warn(&pdev->dev, "Invalid backup DT voltage limit %u\n", lim[0=
]);
> > > +		ret =3D -EINVAL;
> > > +		goto err;
> > > +	}
> > > +	switch (lim[1]) {
> > > +	case 50:
> > > +		new_reg |=3D AXP20X_BACKUP_CURRENT_50uA;
> > > +		break;
> > > +	case 100:
> > > +		new_reg |=3D AXP20X_BACKUP_CURRENT_100uA;
> > > +		break;
> > > +	case 200:
> > > +		new_reg |=3D AXP20X_BACKUP_CURRENT_200uA;
> > > +		break;
> > > +	case 400:
> > > +		new_reg |=3D AXP20X_BACKUP_CURRENT_400uA;
> > > +		break;
> > > +	default:
> > > +		dev_warn(&pdev->dev, "Invalid backup DT current limit %u\n", lim[1=
]);
> > > +		ret =3D -EINVAL;
> > > +		goto err;
> > > +	}
> > > +	new_reg |=3D AXP20X_BACKUP_ENABLE;
> > > +
> > > +	ret =3D regmap_update_bits(axp20x->regmap, AXP20X_CHRG_BAK_CTRL,
> > > +			AXP20X_BACKUP_ENABLE | AXP20X_BACKUP_VOLTAGE_MASK |
> > > +			AXP20X_BACKUP_CURRENT_MASK, new_reg);
> > > +	if (ret)
> > > +		dev_warn(&pdev->dev, "Failed to adjust backup battery settings: %d=
\n", ret);
> > > +
> > > +err:
> > > +	of_node_put(np);
> > > +	return ret;
> > > +}
> > > +
> > > +static int axp20x_backup_get_prop(struct power_supply *psy,
> > > +				  enum power_supply_property psp,
> > > +				  union power_supply_propval *val)
> > > +{
> > > +	struct axp20x_power *devdata =3D dev_get_drvdata(psy->dev->parent);
> > > +	int ret =3D 0, reg;
> > > +
> > > +	ret =3D regmap_read(devdata->axp20x->regmap, AXP20X_CHRG_BAK_CTRL, =
&reg);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	switch (psp)  {
> > > +	case POWER_SUPPLY_PROP_STATUS:
> > > +		if ((reg & AXP20X_BACKUP_ENABLE))
> > > +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> > > +		else
> > > +			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> > > +		switch ((reg & AXP20X_BACKUP_VOLTAGE_MASK)) {
> > > +		case AXP20X_BACKUP_VOLTAGE_2_5V:
> > > +			val->intval =3D 2500000; break;
> > > +		case AXP20X_BACKUP_VOLTAGE_3_0V:
> > > +			val->intval =3D 3000000; break;
> > > +		case AXP20X_BACKUP_VOLTAGE_3_1V:
> > > +			val->intval =3D 3100000; break;
> > > +		case AXP20X_BACKUP_VOLTAGE_3_6V:
> > > +			val->intval =3D 3600000; break;
> > > +		default:
> > > +			val->intval =3D 0;
> > > +		}
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> > > +		switch ((reg & AXP20X_BACKUP_CURRENT_MASK)) {
> > > +		case AXP20X_BACKUP_CURRENT_50uA:
> > > +			val->intval =3D 50; break;
> > > +		case AXP20X_BACKUP_CURRENT_100uA:
> > > +			val->intval =3D 100; break;
> > > +		case AXP20X_BACKUP_CURRENT_200uA:
> > > +			val->intval =3D 200; break;
> > > +		case AXP20X_BACKUP_CURRENT_400uA:
> > > +			val->intval =3D 400; break;
> > > +		default:
> > > +			val->intval =3D 0;
> > > +		}
> > > +		break;
> > > +
> > > +	default:
> > > +		ret =3D -EINVAL;
> > > +		break;
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int axp20x_backup_set_prop(struct power_supply *psy,
> > > +				  enum power_supply_property psp,
> > > +				  const union power_supply_propval *val)
> > > +{
> > > +	struct axp20x_power *devdata =3D dev_get_drvdata(psy->dev->parent);
> > > +	int ret;
> > > +
> > > +	switch (psp) {
> > > +	case POWER_SUPPLY_PROP_STATUS:
> > > +		if (val->intval =3D=3D POWER_SUPPLY_STATUS_CHARGING)
> > > +			ret =3D regmap_update_bits(devdata->axp20x->regmap,
> > > +						 AXP20X_CHRG_BAK_CTRL,
> > > +						 AXP20X_BACKUP_ENABLE,
> > > +						 AXP20X_BACKUP_ENABLE);
> > > +		else if (val->intval =3D=3D POWER_SUPPLY_STATUS_NOT_CHARGING)
> > > +			ret =3D regmap_update_bits(devdata->axp20x->regmap,
> > > +						 AXP20X_CHRG_BAK_CTRL,
> > > +						 AXP20X_BACKUP_ENABLE, 0);
> > > +		else
> > > +			ret =3D -EINVAL;
> > > +		break;
> > > +
> > > +	default:
> > > +		ret =3D -EINVAL;
> > > +	}
> > > +	return ret;
> > > +}
> > > +
> > > +static int axp20x_backup_prop_writeable(struct power_supply *psy,
> > > +					enum power_supply_property psp)
> > > +{
> > > +	return psp =3D=3D POWER_SUPPLY_PROP_STATUS;
> > > +}
> > > +
> > > +static enum power_supply_property axp20x_backup_props[] =3D {
> > > +	POWER_SUPPLY_PROP_STATUS,
> > > +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> > > +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> > > +};
> > > +
> > > +/* ********************************************** *
> > > + * ***  ACIN power supply                     *** *
> > > + * ********************************************** */
> > > +
> > > +static int axp20x_ac_get_prop(struct power_supply *psy,
> > > +			      enum power_supply_property psp,
> > > +			      union power_supply_propval *val)
> > > +{
> > > +	struct axp20x_power *devdata =3D dev_get_drvdata(psy->dev->parent);
> > > +	int ret;
> > > +
> > > +	ret =3D axp20x_power_poll(devdata, 0);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	spin_lock(&devdata->lock);
> > > +	switch (psp)  {
> > > +	case POWER_SUPPLY_PROP_PRESENT:
> > > +		val->intval =3D !!(devdata->status1 & AXP20X_PWR_STATUS_AC_PRESENT=
);
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_ONLINE:
> > > +		val->intval =3D !!(devdata->status1 & AXP20X_PWR_STATUS_AC_AVAILAB=
LE);
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > > +		val->intval =3D devdata->vac;
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> > > +		val->intval =3D devdata->iac;
> > > +		break;
> > > +
> > > +	default:
> > > +		ret =3D -EINVAL;
> > > +	}
> > > +	spin_unlock(&devdata->lock);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static enum power_supply_property axp20x_ac_props[] =3D {
> > > +	POWER_SUPPLY_PROP_PRESENT,
> > > +	POWER_SUPPLY_PROP_ONLINE,
> > > +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > > +	POWER_SUPPLY_PROP_CURRENT_NOW,
> > > +};
> > > +
> > > +/* ********************************************** *
> > > + * ***  VBUS power supply                     *** *
> > > + * ********************************************** */
> > > +
> > > +static int axp20x_vbus_get_prop(struct power_supply *psy,
> > > +				enum power_supply_property psp,
> > > +				union power_supply_propval *val)
> > > +{
> > > +	struct axp20x_power *devdata =3D dev_get_drvdata(psy->dev->parent);
> > > +	int ret;
> > > +
> > > +	ret =3D axp20x_power_poll(devdata, 0);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	spin_lock(&devdata->lock);
> > > +	switch (psp)  {
> > > +	case POWER_SUPPLY_PROP_PRESENT:
> > > +		val->intval =3D !!(devdata->status1 & AXP20X_PWR_STATUS_VBUS_PRESE=
NT);
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_ONLINE:
> > > +		val->intval =3D !!(devdata->status1 & AXP20X_PWR_STATUS_VBUS_AVAIL=
ABLE);
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > > +		val->intval =3D devdata->vvbus;
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> > > +		val->intval =3D devdata->ivbus;
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> > > +		switch (devdata->vbusmgt & AXP20X_VBUS_CLIMIT_MASK) {
> > > +		case AXP20X_VBUC_CLIMIT_100mA:
> > > +			val->intval =3D 100000; break;
> > > +		case AXP20X_VBUC_CLIMIT_500mA:
> > > +			val->intval =3D 500000; break;
> > > +		case AXP20X_VBUC_CLIMIT_900mA:
> > > +			val->intval =3D 900000; break;
> > > +		case AXP20X_VBUC_CLIMIT_NONE:
> > > +		default:
> > > +			val->intval =3D -1;
> > > +		}
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> > > +		val->intval =3D AXP20X_VBUS_VHOLD_mV(devdata->vbusmgt);
> > > +		break;
> > > +
> > > +	default:
> > > +		ret =3D -EINVAL;
> > > +	}
> > > +	spin_unlock(&devdata->lock);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int axp20x_vbus_set_prop(struct power_supply *psy,
> > > +				enum power_supply_property psp,
> > > +				const union power_supply_propval *val)
> > > +{
> > > +	struct axp20x_power *devdata =3D dev_get_drvdata(psy->dev->parent);
> > > +	int ret, reg;
> > > +
> > > +	switch (psp) {
> > > +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> > > +		if (val->intval =3D=3D 100000)
> > > +			reg =3D AXP20X_VBUC_CLIMIT_100mA;
> > > +		else if (val->intval =3D=3D 500000)
> > > +			reg =3D AXP20X_VBUC_CLIMIT_500mA;
> > > +		else if (val->intval =3D=3D 900000)
> > > +			reg =3D AXP20X_VBUC_CLIMIT_900mA;
> > > +		else if (val->intval =3D=3D -1)
> > > +			reg =3D AXP20X_VBUC_CLIMIT_NONE;
> > > +		else {
> > > +			ret =3D -EINVAL;
> > > +			break;
> > > +		}
> > > +		regmap_update_bits(devdata->axp20x->regmap,
> > > +				   AXP20X_VBUS_IPSOUT_MGMT,
> > > +				   AXP20X_VBUS_CLIMIT_MASK, reg);
> > > +		spin_lock(&devdata->lock);
> > > +		devdata->vbusmgt =3D (devdata->vbusmgt & ~AXP20X_VBUS_CLIMIT_MASK)=
 |
> > > +				   (reg & AXP20X_VBUS_CLIMIT_MASK);
> > > +		spin_unlock(&devdata->lock);
> > > +		ret =3D 0;
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> > > +		if (val->intval < 4000000) {
> > > +			ret =3D -EINVAL;
> > > +			break;
> > > +		} else
> > > +			reg =3D val->intval / 100000;
> > > +		if ((reg & 7) !=3D reg) {
> > > +			ret =3D -EINVAL;
> > > +			break;
> > > +		} else
> > > +			reg =3D reg << 3;
> > > +		regmap_update_bits(devdata->axp20x->regmap,
> > > +				   AXP20X_VBUS_IPSOUT_MGMT,
> > > +				   AXP20X_VBUS_VHOLD_MASK, reg);
> > > +		spin_lock(&devdata->lock);
> > > +		devdata->vbusmgt =3D (devdata->vbusmgt & ~AXP20X_VBUS_VHOLD_MASK) |
> > > +				   (reg & AXP20X_VBUS_VHOLD_MASK);
> > > +		spin_unlock(&devdata->lock);
> > > +		ret =3D 0;
> > > +		break;
> > > +
> > > +	default:
> > > +		ret =3D -EINVAL;
> > > +	}
> > > +	return ret;
> > > +}
> > > +
> > > +static enum power_supply_property axp20x_vbus_props[] =3D {
> > > +	POWER_SUPPLY_PROP_PRESENT,
> > > +	POWER_SUPPLY_PROP_ONLINE,
> > > +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > > +	POWER_SUPPLY_PROP_CURRENT_NOW,
> > > +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> > > +	POWER_SUPPLY_PROP_CURRENT_MAX,
> > > +};
> > > +
> > > +static int axp20x_vbus_prop_writeable(struct power_supply *psy,
> > > +				      enum power_supply_property psp)
> > > +{
> > > +	return psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_MIN ||
> > > +	       psp =3D=3D POWER_SUPPLY_PROP_CURRENT_MAX;
> > > +}
> > > +
> > > +
> > > +/* ********************************************** *
> > > + * ***  main battery charger                  *** *
> > > + * ********************************************** */
> > > +
> > > +static void axp20x_battery_chg_reconfig(struct power_supply *psy);
> > > +
> > > +static int axp20x_battery_config(struct platform_device *pdev,
> > > +				 struct axp20x_power *devdata,
> > > +				 struct axp20x_dev *axp20x)
> > > +{
> > > +	struct device_node *np;
> > > +	int i, ret =3D 0, reg, new_reg =3D 0;
> > > +	u32 ocv[16], temp[3], rdc, capa;
> > > +
> > > +	ret =3D regmap_read(axp20x->regmap, AXP20X_PWR_OP_MODE, &reg);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	np =3D of_node_get(axp20x->dev->of_node);
> > > +	if (!np)
> > > +		return -ENODEV;
> > > +
> > > +	ret =3D of_property_read_u32_array(np, "battery.ocv", ocv, 16);
> > > +	for (i =3D 0; ret =3D=3D 0 && i < ARRAY_SIZE(ocv); i++)
> > > +		if (ocv[i] > 100) {
> > > +			dev_warn(&pdev->dev, "OCV[%d] %u > 100\n", i, ocv[i]);
> > > +			ret =3D -EINVAL;
> > > +			goto err;
> > > +		}
> > > +
> > > +	ret =3D of_property_read_u32_array(np, "battery.resistance", &rdc, =
1);
> > > +	if (ret !=3D 0)
> > > +		rdc =3D 100;
> > > +
> > > +	ret =3D of_property_read_u32_array(np, "battery.capacity", &capa, 1=
);
> > > +	if (ret !=3D 0)
> > > +		capa =3D 0;
> > > +
> > > +	ret =3D of_property_read_u32_array(np, "battery.temp_sensor", temp,=
 3);
> > > +	if (ret !=3D 0)
> > > +		memset(temp, 0, sizeof(temp));
> > > +	else if (temp[0] !=3D 20 && temp[0] !=3D 40 && temp[0] !=3D 60 &&
> > > +		 temp[0] !=3D 80) {
> > > +		dev_warn(&pdev->dev, "Invalid battery temperature sensor current s=
etting\n");
> > > +		ret =3D -EINVAL;
> > > +		memset(temp, 0, sizeof(temp));
> > > +	}
> > > +
> > > +	dev_info(&pdev->dev, "FDT settings: capacity=3D%d, resistance=3D%d,=
 temp_sensor=3D<%d %d %d>\n", capa, rdc, temp[0], temp[1], temp[2]);
> > > +	/* apply settings */
> > > +	devdata->batt_health =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> > > +	regmap_update_bits(axp20x->regmap, AXP20X_FG_RES, AXP20X_FG_ENABLE,=
 0x00);
> > > +	regmap_update_bits(axp20x->regmap, AXP20X_RDC_H, 0x80, 0x00);
> > > +	regmap_update_bits(axp20x->regmap, AXP20X_RDC_L, 0xff, (rdc * 10000=
 + 5371) / 10742);
> > > +	regmap_update_bits(axp20x->regmap, AXP20X_RDC_H, 0x1f, ((rdc * 1000=
0 + 5371) / 10742) >> 8);
> > > +	if (of_find_property(np, "battery.ocv", NULL))
> > > +		for (i =3D 0; i < ARRAY_SIZE(ocv); i++) {
> > > +			ret =3D regmap_update_bits(axp20x->regmap, AXP20X_OCV(i),
> > > +						 0xff, ocv[i]);
> > > +			if (ret)
> > > +				dev_warn(&pdev->dev,
> > > +					 "Failed to store OCV[%d] setting: %d\n",
> > > +					 i, ret);
> > > +		}
> > > +	regmap_update_bits(axp20x->regmap, AXP20X_FG_RES, AXP20X_FG_ENABLE,=
 AXP20X_FG_ENABLE);
> > > +
> > > +	if (capa =3D=3D 0 && !(reg & AXP20X_PWR_OP_BATT_PRESENT)) {
> > > +		/* No battery present or configured -> disable */
> > > +		regmap_update_bits(axp20x->regmap, AXP20X_CHRG_CTRL1, AXP20X_CHRG_=
CTRL1_ENABLE, 0x00);
> > > +		regmap_update_bits(axp20x->regmap, AXP20X_OFF_CTRL, AXP20X_OFF_CTR=
L_BATT_MON, 0x00);
> > > +		dev_info(&pdev->dev, "No battery, disabling charger\n");
> > > +		ret =3D -ENODEV;
> > > +		goto err;
> > > +	}
> > > +
> > > +	if (temp[0] =3D=3D 0) {
> > > +		regmap_update_bits(axp20x->regmap, AXP20X_ADC_RATE,
> > > +				   AXP20X_ADR_TS_WHEN_MASK |
> > > +				   AXP20X_ADR_TS_UNRELATED,
> > > +				   AXP20X_ADR_TS_UNRELATED |
> > > +				   AXP20X_ADR_TS_WHEN_OFF);
> > > +	} else {
> > > +		devdata->tbatt_min =3D temp[1];
> > > +		devdata->tbatt_max =3D temp[2];
> > > +		switch (temp[0]) {
> > > +		case 20:
> > > +			regmap_update_bits(axp20x->regmap, AXP20X_ADC_RATE,
> > > +					   AXP20X_ADR_TS_CURR_MASK |
> > > +					   AXP20X_ADR_TS_WHEN_MASK |
> > > +					   AXP20X_ADR_TS_UNRELATED,
> > > +					   AXP20X_ADR_TS_CURR_20uA |
> > > +					   AXP20X_ADR_TS_WHEN_ADC);
> > > +			break;
> > > +		case 40:
> > > +			regmap_update_bits(axp20x->regmap, AXP20X_ADC_RATE,
> > > +					   AXP20X_ADR_TS_CURR_MASK |
> > > +					   AXP20X_ADR_TS_WHEN_MASK |
> > > +					   AXP20X_ADR_TS_UNRELATED,
> > > +					   AXP20X_ADR_TS_CURR_40uA |
> > > +					   AXP20X_ADR_TS_WHEN_ADC);
> > > +			break;
> > > +		case 60:
> > > +			regmap_update_bits(axp20x->regmap, AXP20X_ADC_RATE,
> > > +					   AXP20X_ADR_TS_CURR_MASK |
> > > +					   AXP20X_ADR_TS_WHEN_MASK |
> > > +					   AXP20X_ADR_TS_UNRELATED,
> > > +					   AXP20X_ADR_TS_CURR_60uA |
> > > +					   AXP20X_ADR_TS_WHEN_ADC);
> > > +			break;
> > > +		case 80:
> > > +			regmap_update_bits(axp20x->regmap, AXP20X_ADC_RATE,
> > > +					   AXP20X_ADR_TS_CURR_MASK |
> > > +					   AXP20X_ADR_TS_WHEN_MASK |
> > > +					   AXP20X_ADR_TS_UNRELATED,
> > > +					   AXP20X_ADR_TS_CURR_80uA |
> > > +					   AXP20X_ADR_TS_WHEN_ADC);
> > > +			break;
> > > +		}
> > > +		new_reg =3D temp[1] / (0x10 * 800);
> > > +		regmap_update_bits(axp20x->regmap, AXP20X_V_HTF_CHRG, 0xff,
> > > +				   new_reg);
> > > +		regmap_update_bits(axp20x->regmap, AXP20X_V_HTF_DISCHRG, 0xff,
> > > +				   new_reg);
> > > +		new_reg =3D temp[2] / (0x10 * 800);
> > > +		regmap_update_bits(axp20x->regmap, AXP20X_V_LTF_CHRG, 0xff,
> > > +				   new_reg);
> > > +		regmap_update_bits(axp20x->regmap, AXP20X_V_LTF_DISCHRG, 0xff,
> > > +				   new_reg);
> > > +	}
> > > +	devdata->batt_capacity  =3D capa * 1000;
> > > +	devdata->batt_user_imax =3D (capa < 300 ? 300 : capa) * 1000;
> > > +	/* Prefer longer battery life over longer runtime. */
> > > +	regmap_update_bits(devdata->axp20x->regmap, AXP20X_CHRG_CTRL1,
> > > +			   AXP20X_CHRG_CTRL1_TGT_VOLT,
> > > +			   AXP20X_CHRG_CTRL1_TGT_4_15V);
> > > +
> > > +	/* TODO: configure CHGLED? */
> > > +
> > > +	/* Default to about 5% capacity, about 3.5V */
> > > +	regmap_update_bits(axp20x->regmap, AXP20X_APS_WARN_L1, 0xff,
> > > +			   (3500000 - 2867200) / 4 / 1400);
> > > +	regmap_update_bits(axp20x->regmap, AXP20X_APS_WARN_L2, 0xff,
> > > +			   (3304000 - 2867200) / 4 / 1400);
> > > +	/* RDC - disable capacity monitor, reconfigure, re-enable */
> > > +	regmap_update_bits(axp20x->regmap, AXP20X_FG_RES, 0x80, 0x80);
> > > +	regmap_update_bits(axp20x->regmap, AXP20X_RDC_H, 0x80, 0x00);
> > > +	regmap_update_bits(axp20x->regmap, AXP20X_RDC_H, 0x1f, ((rdc * 1000=
0 + 5371) / 10742) >> 8);
> > > +	regmap_update_bits(axp20x->regmap, AXP20X_RDC_L, 0xff, (rdc * 10000=
 + 5371) / 10742);
> > > +	regmap_update_bits(axp20x->regmap, AXP20X_FG_RES, 0x80, 0x00);
> > > +	regmap_update_bits(axp20x->regmap, AXP20X_OFF_CTRL, AXP20X_OFF_CTRL=
_BATT_MON, AXP20X_OFF_CTRL_BATT_MON);
> > > +	axp20x_battery_chg_reconfig(&devdata->battery);
> > > +	ret =3D 0;
> > > +
> > > +err:
> > > +	of_node_put(np);
> > > +	return ret;
> > > +}
> > > +
> > > +static int axp20x_battery_uv_to_temp(struct axp20x_power *devdata, i=
nt uv)
> > > +{
> > > +	/* TODO: convert =B5V to =B0C */
> > > +	return uv;
> > > +}
> > > +
> > > +static int axp20x_battery_get_prop(struct power_supply *psy,
> > > +				   enum power_supply_property psp,
> > > +				   union power_supply_propval *val)
> > > +{
> > > +	struct axp20x_power *devdata =3D dev_get_drvdata(psy->dev->parent);
> > > +	int ret, reg;
> > > +
> > > +	switch (psp) {
> > > +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> > > +		ret =3D regmap_read(devdata->axp20x->regmap, AXP20X_CHRG_CTRL1,
> > > +				  &reg);
> > > +		if (ret)
> > > +			return ret;
> > > +		val->intval =3D (reg & AXP20X_CHRG_CTRL1_TGT_CURR) * 100000 +
> > > +			      300000;
> > > +		return 0;
> > > +
> > > +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> > > +		ret =3D regmap_read(devdata->axp20x->regmap, AXP20X_CHRG_CTRL1,
> > > +				  &reg);
> > > +		if (ret)
> > > +			return ret;
> > > +		switch (reg & AXP20X_CHRG_CTRL1_TGT_VOLT) {
> > > +		case AXP20X_CHRG_CTRL1_TGT_4_1V:
> > > +			val->intval =3D 4100000;
> > > +			break;
> > > +		case AXP20X_CHRG_CTRL1_TGT_4_15V:
> > > +			val->intval =3D 4150000;
> > > +			break;
> > > +		case AXP20X_CHRG_CTRL1_TGT_4_2V:
> > > +			val->intval =3D 4200000;
> > > +			break;
> > > +		case AXP20X_CHRG_CTRL1_TGT_4_36V:
> > > +			val->intval =3D 4360000;
> > > +			break;
> > > +		default:
> > > +			ret =3D -EINVAL;
> > > +		}
> > > +		return 0;
> > > +
> > > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> > > +		ret =3D regmap_read(devdata->axp20x->regmap, AXP20X_APS_WARN_L2,
> > > +				  &reg);
> > > +		if (ret)
> > > +			return ret;
> > > +		val->intval =3D 2867200 + 1400 * reg * 4;
> > > +		return 0;
> > > +
> > > +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> > > +		val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
> > > +		return 0;
> > > +
> > > +	default:
> > > +		break;
> > > +	}
> > > +
> > > +	ret =3D axp20x_power_poll(devdata, 0);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	spin_lock(&devdata->lock);
> > > +	switch (psp)  {
> > > +	case POWER_SUPPLY_PROP_PRESENT:
> > > +	case POWER_SUPPLY_PROP_ONLINE:
> > > +		val->intval =3D !!(devdata->status2 & AXP20X_PWR_OP_BATT_PRESENT);
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_STATUS:
> > > +		if (devdata->status1 & AXP20X_PWR_STATUS_BAT_CHARGING)
> > > +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> > > +		else if (devdata->ibatt =3D=3D 0 && devdata->batt_percent =3D=3D 1=
00)
> > > +			val->intval =3D POWER_SUPPLY_STATUS_FULL;
> > > +		else if (devdata->ibatt =3D=3D 0)
> > > +			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> > > +		else
> > > +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> > > +		val->intval =3D devdata->ibatt;
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_HEALTH:
> > > +		val->intval =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> > > +		// POWER_SUPPLY_HEALTH_GOOD, POWER_SUPPLY_HEALTH_OVERHEAT, POWER_S=
UPPLY_HEALTH_DEAD, POWER_SUPPLY_HEALTH_OVERVOLTAGE, POWER_SUPPLY_HEALTH_UNS=
PEC_FAILURE, POWER_SUPPLY_HEALTH_COLD, POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXP=
IRE
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > > +		val->intval =3D devdata->vbatt;
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_POWER_NOW:
> > > +		val->intval =3D devdata->pbatt;
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> > > +		val->intval =3D devdata->batt_capacity;
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> > > +		/* TODO */
> > > +		val->intval =3D 12345;
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_CAPACITY:
> > > +		val->intval =3D devdata->batt_percent;
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_TEMP:
> > > +		val->intval =3D axp20x_battery_uv_to_temp(devdata,
> > > +							devdata->tbatt);
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> > > +		val->intval =3D axp20x_battery_uv_to_temp(devdata,
> > > +							devdata->tbatt_min);
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> > > +		val->intval =3D axp20x_battery_uv_to_temp(devdata,
> > > +							devdata->tbatt_max);
> > > +		break;
> > > +
> > > +	default:
> > > +		ret =3D -EINVAL;
> > > +	}
> > > +	spin_unlock(&devdata->lock);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int axp20x_battery_max_chg_current(struct axp20x_power *devda=
ta)
> > > +{
> > > +	if ((devdata->status1 & AXP20X_PWR_STATUS_AC_PRESENT) &&
> > > +	    (devdata->status1 & AXP20X_PWR_STATUS_AC_AVAILABLE)) {
> > > +		/* AC available - unrestricted power */
> > > +		return devdata->batt_capacity / 2;
> > > +	} else if ((devdata->status1 & AXP20X_PWR_STATUS_VBUS_PRESENT) &&
> > > +		   (devdata->status1 & AXP20X_PWR_STATUS_VBUS_AVAILABLE)) {
> > > +		/* VBUS available - limited power */
> > > +		switch (devdata->vbusmgt & AXP20X_VBUS_CLIMIT_MASK) {
> > > +		case AXP20X_VBUC_CLIMIT_100mA:
> > > +			return 0;
> > > +		case AXP20X_VBUC_CLIMIT_500mA:
> > > +			return 300000;
> > > +		case AXP20X_VBUC_CLIMIT_900mA:
> > > +			return 600000;
> > > +		case AXP20X_VBUC_CLIMIT_NONE:
> > > +			return devdata->batt_capacity / 2;
> > > +		default:
> > > +			return 0;
> > > +		}
> > > +	} else {
> > > +		/* on-battery */
> > > +		return 0;
> > > +	}
> > > +}
> > > +
> > > +static int axp20x_battery_set_prop(struct power_supply *psy,
> > > +				   enum power_supply_property psp,
> > > +				   const union power_supply_propval *val)
> > > +{
> > > +	struct axp20x_power *devdata =3D dev_get_drvdata(psy->dev->parent);
> > > +	int ret;
> > > +
> > > +	switch (psp) {
> > > +	case POWER_SUPPLY_PROP_STATUS:
> > > +		if (val->intval =3D=3D POWER_SUPPLY_STATUS_CHARGING) {
> > > +			ret =3D axp20x_battery_max_chg_current(devdata);
> > > +			if (ret =3D=3D 0) {
> > > +				ret =3D -EBUSY;
> > > +				break;
> > > +			}
> > > +			ret =3D regmap_update_bits(devdata->axp20x->regmap,
> > > +						 AXP20X_PWR_OP_MODE,
> > > +						 AXP20X_PWR_OP_CHARGING,
> > > +						 AXP20X_PWR_OP_CHARGING);
> > > +			if (ret =3D=3D 0)
> > > +				axp20x_battery_chg_reconfig(&devdata->battery);
> > > +		} else if (val->intval =3D=3D POWER_SUPPLY_STATUS_NOT_CHARGING) {
> > > +			ret =3D regmap_update_bits(devdata->axp20x->regmap,
> > > +						 AXP20X_PWR_OP_MODE,
> > > +						 AXP20X_PWR_OP_CHARGING, 0);
> > > +		} else
> > > +			ret =3D -EINVAL;
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> > > +		/* TODO: adjust AXP20X_APS_WARN_L1 and AXP20X_APS_WARN_L2 accordin=
gly */
> > > +		ret =3D -EINVAL;
> > > +		break;
> > > +
> > > +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> > > +		switch (val->intval) {
> > > +		case 4100000:
> > > +			ret =3D regmap_update_bits(devdata->axp20x->regmap,
> > > +						 AXP20X_CHRG_CTRL1,
> > > +						 AXP20X_CHRG_CTRL1_TGT_VOLT,
> > > +						 AXP20X_CHRG_CTRL1_TGT_4_1V);
> > > +			break;
> > > +		case 4150000:
> > > +			ret =3D regmap_update_bits(devdata->axp20x->regmap,
> > > +						 AXP20X_CHRG_CTRL1,
> > > +						 AXP20X_CHRG_CTRL1_TGT_VOLT,
> > > +						 AXP20X_CHRG_CTRL1_TGT_4_15V);
> > > +			break;
> > > +		case 4200000:
> > > +			ret =3D regmap_update_bits(devdata->axp20x->regmap,
> > > +						 AXP20X_CHRG_CTRL1,
> > > +						 AXP20X_CHRG_CTRL1_TGT_VOLT,
> > > +						 AXP20X_CHRG_CTRL1_TGT_4_2V);
> > > +			break;
> > > +		case 4360000:
> > > +			/* refuse this as it's too much for Li-ion! */
> > > +		default:
> > > +			ret =3D -EINVAL;
> > > +		}
> > > +		break;
> > > +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> > > +		if (((val->intval - 300000) / 100000) > 0x0f)
> > > +			ret =3D -EINVAL;
> > > +		else if (val->intval < 300000)
> > > +			ret =3D -EINVAL;
> > > +		else {
> > > +			devdata->batt_user_imax =3D val->intval;
> > > +			axp20x_battery_chg_reconfig(&devdata->battery);
> > > +			ret =3D 0;
> > > +		}
> > > +		break;
> > > +
> > > +	default:
> > > +		ret =3D -EINVAL;
> > > +	}
> > > +	return ret;
> > > +}
> > > +
> > > +static enum power_supply_property axp20x_battery_props[] =3D {
> > > +	POWER_SUPPLY_PROP_PRESENT,
> > > +	POWER_SUPPLY_PROP_ONLINE,
> > > +	POWER_SUPPLY_PROP_STATUS,
> > > +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> > > +	POWER_SUPPLY_PROP_CURRENT_NOW,
> > > +	POWER_SUPPLY_PROP_CURRENT_MAX,
> > > +	POWER_SUPPLY_PROP_HEALTH,
> > > +	POWER_SUPPLY_PROP_TECHNOLOGY,
> > > +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> > > +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> > > +	POWER_SUPPLY_PROP_POWER_NOW,
> > > +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> > > +	/* POWER_SUPPLY_PROP_CHARGE_NOW, */
> > > +	POWER_SUPPLY_PROP_CAPACITY,
> > > +	POWER_SUPPLY_PROP_TEMP,
> > > +	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
> > > +	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
> > > +};
> > > +
> > > +static int axp20x_battery_prop_writeable(struct power_supply *psy,
> > > +				      enum power_supply_property psp)
> > > +{
> > > +	return psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN ||
> > > +	       psp =3D=3D POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN ||
> > > +	       psp =3D=3D POWER_SUPPLY_PROP_CURRENT_MAX ||
> > > +	       psp =3D=3D POWER_SUPPLY_PROP_STATUS;
> > > +}
> > > +
> > > +static void axp20x_battery_chg_reconfig(struct power_supply *psy)
> > > +{
> > > +	struct axp20x_power *devdata =3D container_of(psy,
> > > +				       struct axp20x_power, battery);
> > > +	int charge_max, ret;
> > > +
> > > +	ret =3D axp20x_power_poll(devdata, 0);
> > > +	if (ret)
> > > +		return;
> > > +
> > > +	charge_max =3D axp20x_battery_max_chg_current(devdata);
> > > +
> > > +	if (charge_max =3D=3D 0) {
> > > +		ret =3D regmap_update_bits(devdata->axp20x->regmap,
> > > +					 AXP20X_PWR_OP_MODE,
> > > +					 AXP20X_PWR_OP_CHARGING, 0);
> > > +	} else {
> > > +		if (devdata->batt_user_imax < charge_max)
> > > +			charge_max =3D devdata->batt_user_imax;
> > > +		if (((charge_max - 300000) / 100000) > 0x0f)
> > > +			charge_max =3D 300000 + 0x0f * 100000;
> > > +		ret =3D regmap_update_bits(devdata->axp20x->regmap,
> > > +					 AXP20X_CHRG_CTRL1,
> > > +					 AXP20X_CHRG_CTRL1_TGT_CURR,
> > > +					(charge_max - 300000) / 100000);
> > > +		ret =3D regmap_update_bits(devdata->axp20x->regmap,
> > > +					 AXP20X_PWR_OP_MODE,
> > > +					 AXP20X_PWR_OP_CHARGING,
> > > +					 AXP20X_PWR_OP_CHARGING);
> > > +	}
> > > +}
> > > +
> > > +
> > > +
> > > +/* ********************************************** *
> > > + * ***  IRQ handlers                          *** *
> > > + * ********************************************** */
> > > +
> > > +static irqreturn_t axp20x_irq_ac_over_v(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_warn(&pdev->dev, "IRQ#%d AC over voltage\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static irqreturn_t axp20x_irq_ac_plugin(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_info(&pdev->dev, "IRQ#%d AC connected\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static irqreturn_t axp20x_irq_ac_removal(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_info(&pdev->dev, "IRQ#%d AC disconnected\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static irqreturn_t axp20x_irq_vbus_over_v(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_warn(&pdev->dev, "IRQ#%d VBUS over voltage\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static irqreturn_t axp20x_irq_vbus_plugin(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_info(&pdev->dev, "IRQ#%d VBUS connected\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static irqreturn_t axp20x_irq_vbus_removal(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_info(&pdev->dev, "IRQ#%d VBUS disconnected\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static irqreturn_t axp20x_irq_vbus_v_low(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_warn(&pdev->dev, "IRQ#%d VBUS low voltage\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static irqreturn_t axp20x_irq_batt_plugin(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_info(&pdev->dev, "IRQ#%d Battery connected\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +static irqreturn_t axp20x_irq_batt_removal(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_info(&pdev->dev, "IRQ#%d Battery disconnected\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +static irqreturn_t axp20x_irq_batt_activation(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_info(&pdev->dev, "IRQ#%d Battery activation started\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +static irqreturn_t axp20x_irq_batt_activated(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_info(&pdev->dev, "IRQ#%d Battery activation completed\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +static irqreturn_t axp20x_irq_batt_charging(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_info(&pdev->dev, "IRQ#%d Battery charging\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +static irqreturn_t axp20x_irq_batt_charged(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_info(&pdev->dev, "IRQ#%d Battery charged\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +static irqreturn_t axp20x_irq_batt_high_temp(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_warn(&pdev->dev, "IRQ#%d Battery temperature high\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +static irqreturn_t axp20x_irq_batt_low_temp(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_warn(&pdev->dev, "IRQ#%d Battery temperature low\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +static irqreturn_t axp20x_irq_batt_chg_curr_low(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_warn(&pdev->dev, "IRQ#%d External power too weak for target cha=
rging current!\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +static irqreturn_t axp20x_irq_power_low(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_warn(&pdev->dev, "IRQ#%d System power running out soon\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +static irqreturn_t axp20x_irq_power_low_crit(int irq, void *pwr)
> > > +{
> > > +	struct platform_device *pdev =3D pwr;
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	dev_crit(&pdev->dev, "IRQ#%d System power running out now!\n", irq);
> > > +	schedule_work(&devdata->work);
> > > +	return IRQ_HANDLED;
> > > +}
> > > +
> > > +/* ********************************************** *
> > > + * ***  Platform driver code                  *** *
> > > + * ********************************************** */
> > > +
> > > +static int axp20x_init_irq(struct platform_device *pdev,
> > > +	struct axp20x_dev *axp20x, const char *irq_name,
> > > +	const char *dev_name, irq_handler_t handler)
> > > +{
> > > +	int irq =3D platform_get_irq_byname(pdev, irq_name);
> > > +	int ret;
> > > +
> > > +	if (irq < 0) {
> > > +		dev_warn(&pdev->dev, "No IRQ for %s: %d\n", irq_name, irq);
> > > +		return irq;
> > > +	}
> > > +	irq =3D regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> > > +
> > > +	ret =3D devm_request_any_context_irq(&pdev->dev, irq, handler, 0,
> > > +					dev_name, pdev);
> > > +	if (ret < 0)
> > > +		dev_warn(&pdev->dev, "Failed to request %s IRQ#%d: %d\n", irq_name=
, irq, ret);
> > > +	return ret;
> > > +}
> > > +
> > > +static int axp20x_power_suspend(struct platform_device *pdev, pm_mes=
sage_t state)
> > > +{
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	cancel_work_sync(&devdata->work);
> > > +	return 0;
> > > +}
> > > +
> > > +static int axp20x_power_resume(struct platform_device *pdev)
> > > +{
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	axp20x_power_poll(devdata, 1);
> > > +	return 0;
> > > +}
> > > +
> > > +static void axp20x_power_shutdown(struct platform_device *pdev)
> > > +{
> > > +	struct axp20x_power *devdata =3D platform_get_drvdata(pdev);
> > > +
> > > +	cancel_work_sync(&devdata->work);
> > > +}
> > > +
> > > +static int axp20x_power_probe(struct platform_device *pdev)
> > > +{
> > > +	struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev->dev.parent);
> > > +	struct axp20x_power *devdata;
> > > +	struct power_supply *ac, *vbus, *backup, *battery;
> > > +	int ret;
> > > +
> > > +	devdata =3D devm_kzalloc(&pdev->dev, sizeof(struct axp20x_power),
> > > +				GFP_KERNEL);
> > > +	if (devdata =3D=3D NULL)
> > > +		return -ENOMEM;
> > > +
> > > +	spin_lock_init(&devdata->lock);
> > > +	devdata->axp20x =3D axp20x;
> > > +	platform_set_drvdata(pdev, devdata);
> > > +
> > > +	backup =3D &devdata->backup;
> > > +	snprintf(devdata->backup_name, sizeof(devdata->backup_name), "axp20=
x-backup");
> > > +	backup->name                  =3D devdata->backup_name;
> > > +	backup->type                  =3D POWER_SUPPLY_TYPE_BATTERY;
> > > +	backup->properties            =3D axp20x_backup_props;
> > > +	backup->num_properties        =3D ARRAY_SIZE(axp20x_backup_props);
> > > +	backup->property_is_writeable =3D axp20x_backup_prop_writeable;
> > > +	backup->get_property          =3D axp20x_backup_get_prop;
> > > +	backup->set_property          =3D axp20x_backup_set_prop;
> > > +
> > > +	ac =3D &devdata->ac;
> > > +	snprintf(devdata->ac_name, sizeof(devdata->ac_name), "axp20x-ac");
> > > +	ac->name           =3D devdata->ac_name;
> > > +	ac->type           =3D POWER_SUPPLY_TYPE_MAINS;
> > > +	ac->properties     =3D axp20x_ac_props;
> > > +	ac->num_properties =3D ARRAY_SIZE(axp20x_ac_props);
> > > +	ac->get_property   =3D axp20x_ac_get_prop;
> > > +
> > > +	vbus =3D &devdata->vbus;
> > > +	snprintf(devdata->vbus_name, sizeof(devdata->vbus_name), "axp20x-us=
b");
> > > +	vbus->name                  =3D devdata->vbus_name;
> > > +	vbus->type                  =3D POWER_SUPPLY_TYPE_USB;
> > > +	vbus->properties            =3D axp20x_vbus_props;
> > > +	vbus->num_properties        =3D ARRAY_SIZE(axp20x_vbus_props);
> > > +	vbus->property_is_writeable =3D axp20x_vbus_prop_writeable;
> > > +	vbus->get_property          =3D axp20x_vbus_get_prop;
> > > +	vbus->set_property          =3D axp20x_vbus_set_prop;
> > > +
> > > +	devdata->battery_supplies[0] =3D devdata->vbus_name;
> > > +	devdata->battery_supplies[1] =3D devdata->ac_name;
> > > +	battery =3D &devdata->battery;
> > > +	snprintf(devdata->battery_name, sizeof(devdata->battery_name), "axp=
20x-battery");
> > > +	battery->name                   =3D devdata->battery_name;
> > > +	battery->type                   =3D POWER_SUPPLY_TYPE_BATTERY;
> > > +	battery->properties             =3D axp20x_battery_props;
> > > +	battery->num_properties         =3D ARRAY_SIZE(axp20x_battery_props=
);
> > > +	battery->property_is_writeable  =3D axp20x_battery_prop_writeable;
> > > +	battery->get_property           =3D axp20x_battery_get_prop;
> > > +	battery->set_property           =3D axp20x_battery_set_prop;
> > > +	battery->supplied_from          =3D devdata->battery_supplies;
> > > +	battery->num_supplies           =3D 1;
> > > +	battery->external_power_changed =3D axp20x_battery_chg_reconfig;
> > > +
> > > +	/* configure hardware and check FDT params */
> > > +	regmap_update_bits(axp20x->regmap, AXP20X_ADC_RATE,
> > > +			   AXP20X_ADR_RATE_MASK, AXP20X_ADR_RATE_50Hz);
> > > +
> > > +	ret =3D axp20x_backup_config(pdev, axp20x);
> > > +	if (ret)
> > > +		devdata->backup_name[0] =3D '\0';
> > > +
> > > +	ret =3D axp20x_battery_config(pdev, devdata, axp20x);
> > > +	if (ret)
> > > +		devdata->battery_name[0] =3D '\0';
> > > +	else if (devdata->tbatt_min =3D=3D 0 && devdata->tbatt_max =3D=3D 0)
> > > +		battery->num_properties -=3D 3;
> > > +
> > > +	ret =3D axp20x_power_poll(devdata, 2);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (devdata->status1 & AXP20X_PWR_STATUS_AC_VBUS_SHORT)
> > > +		devdata->ac_name[0] =3D '\0';
> > > +	else
> > > +		battery->num_supplies =3D 2;
> > > +
> > > +	/* register present supplies */
> > > +	ret =3D power_supply_register(&pdev->dev, backup);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D power_supply_register(&pdev->dev, vbus);
> > > +	if (ret)
> > > +		goto err_unreg_backup;
> > > +	power_supply_changed(&devdata->vbus);
> > > +
> > > +	if (devdata->ac_name[0]) {
> > > +		ret =3D power_supply_register(&pdev->dev, ac);
> > > +		if (ret)
> > > +			goto err_unreg_vbus;
> > > +		power_supply_changed(&devdata->ac);
> > > +	}
> > > +
> > > +	if (devdata->battery_name[0]) {
> > > +		ret =3D power_supply_register(&pdev->dev, battery);
> > > +		if (ret)
> > > +			goto err_unreg_ac;
> > > +		power_supply_changed(&devdata->battery);
> > > +	}
> >=20
> > It looks like there's a lot more than just one driver here. Would it
> > make sense to split this into smaller drivers?
>=20
> There are 4 parts - AC, VBUS, backup/RTC battery and main battery.
>=20
> Splitting it into four parts would be possible though there are some
> interactions between them:
> - AC and VBUS/OTG need to trigger charge current reconfiguration for
>   battery charger (due to current supply limit on VBUS/OTG)
>=20
> In addition, some of supply information is presented in registers shared
> with the other supplies which would make caching management harder
> unless regmap caching could be controlled in a better way.

Yeah, regmap can be used for that, but whatever works best for you and
the maintainers.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--I4VOKWutKNZEOIPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUSMptAAoJEBx+YmzsjxAgwZMP/A0D7t3G8w56CK0WsxCVPGoL
apkf4ySS89F4dh8qmp45gWCyQ5req+FPf9x9gmpfzq4X0oLfPfDifOiKbyiA3Oxc
CVEx+UbH8iCYId7BLfPxkiwo9y9OJB1bsky7dOMAR1ify8tGhoLPEpRSRq+JayMd
kHAj4PivgawT8rdS8F51N0IJlfLdvXa2VMM3nKHrE0e8ekygqPjtm442WDlyXwyp
kSt2xr7QrZ4HdwmYRVyqRIYtZ1Z71iNzwaaFAKQFabuimcZ1OApfiUcz8DDm1klI
rYS6Azn+QUgWMwc0wX3EPF9RVD4zzs+O8rV5pe23Wmze3/4+Apt+M3neuRW3spvX
txfT+4khdJpwt89t2F6NTIHliBwh4JGG/QGv4F7vAH8AXKhte12cEk6D9+83d5KY
aeRNw4ByMNAQBoY5VBEz+sI7MtFjKvFD1oGjQlj3rHWDepcJ4WPyNqT69rzNQbYM
h4HdD3hv0x+9+EoeEjsRgkNq4DikpdYa6hehvAPC+Mn2+x4ba/lGHFbjzCkcTEsB
Rg+CLTUDiGmKxEooFOz3GC8dFi0sR4UgH61alp5htrqlNJY7yKrnoSEcH/Ks6m41
NXH+a7bX7KndMcLsTKmn6bqWkFxP+NhLi25Aew+W4oTUQahZgXfOUwpBcWZRjId7
LryJYlbXhwh6h78ff5m4
=90Oq
-----END PGP SIGNATURE-----

--I4VOKWutKNZEOIPu--
