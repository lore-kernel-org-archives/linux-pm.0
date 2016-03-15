From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V7 09/12] thermal: tegra: add thermtrip function
Date: Tue, 15 Mar 2016 17:12:12 +0800
Message-ID: <56E7D1EC.5090907@nvidia.com>
References: <1457665872-30046-1-git-send-email-wni@nvidia.com> <20160314191637.GC1872@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160314191637.GC1872-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 03:16, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
>=20
> On Fri, Mar 11, 2016 at 11:11:12AM +0800, Wei Ni wrote:
>> Add support for hardware critical thermal limits to the
>> SOC_THERM driver. It use the Linux thermal framework to
>> create critical trip temp, and set it to SOC_THERM hardware.
>> If these limits are breached, the chip will reset, and if
>> appropriately configured, will turn off the PMIC.
>>
>> This support is critical for safe usage of the chip.
>>
>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/thermal/tegra/soctherm.c          | 166 +++++++++++++++++++=
++++++++++-
>>  drivers/thermal/tegra/soctherm.h          |   7 ++
>>  drivers/thermal/tegra/tegra124-soctherm.c |  24 +++++
>>  drivers/thermal/tegra/tegra210-soctherm.c |  24 +++++
>>  4 files changed, 216 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegr=
a/soctherm.c
>> index 02ac6d2e5a20..dbaab160baba 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -73,9 +73,14 @@
>>  #define REG_SET_MASK(r, m, v)	(((r) & ~(m)) | \
>>  				 (((v) & (m >> (ffs(m) - 1))) << (ffs(m) - 1)))
>> =20
>> +static const int min_low_temp =3D -127000;
>> +static const int max_high_temp =3D 127000;
>> +
>>  struct tegra_thermctl_zone {
>>  	void __iomem *reg;
>> -	u32 mask;
>> +	struct device *dev;
>> +	struct thermal_zone_device *tz;
>=20
>=20
> Why not using tz->dev for the *dev above?

The tz is thermal_zone_device, this structure doesn't have *dev.
It only have the member "struct device device;", but this device is cre=
ated for
the thermal class, not this tegra_soctherm device.

>=20
>> +	const struct tegra_tsensor_group *sg;
>>  };
>> =20
>>  struct tegra_soctherm {
>> @@ -145,22 +150,158 @@ static int tegra_thermctl_get_temp(void *data=
, int *out_temp)
>>  	u32 val;
>> =20
>>  	val =3D readl(zone->reg);
>> -	val =3D REG_GET_MASK(val, zone->mask);
>> +	val =3D REG_GET_MASK(val, zone->sg->sensor_temp_mask);
>>  	*out_temp =3D translate_temp(val);
>> =20
>>  	return 0;
>>  }
>> =20
>> +static int
>> +thermtrip_program(struct device *dev, const struct tegra_tsensor_gr=
oup *sg,
>> +		  int trip_temp);
>> +
>> +static int tegra_thermctl_set_trip_temp(void *data, int trip, int t=
emp)
>> +{
>> +	struct tegra_thermctl_zone *zone =3D data;
>> +	struct thermal_zone_device *tz =3D zone->tz;
>> +	const struct tegra_tsensor_group *sg =3D zone->sg;
>> +	struct device *dev =3D zone->dev;
>> +	enum thermal_trip_type type;
>> +	int ret;
>> +
>> +	if (!tz)
>> +		return -EINVAL;
>=20
>=20
> Is the above check needed? If you saw a case in which your function i=
s
> called without tz, would it be the case we have a but in the probe (o=
r
> even worse, in thermal-core)?

This tz isn't from thermal-core, it's from the "void *data".
This *data is the private structure "struct tegra_thermctl_zone *zone =3D=
 data;".
It is registered in devm_thermal_zone_of_sensor_register(*dev, sensor_i=
d, *data,
*ops). And when it register successful, I will set zone->tz =3D z, in h=
ere, the
zone is the private data.
Let's consider a special case, once the thermal_zone_of_sensor_register
successful and didn't run to "zone->tz =3D z" yet, then the thermal_cor=
e implement
=2Eset_trip(), then it may cause problems in here, although it's diffic=
ult to hit
this case. So I think we need to do this check.

>=20
>> +
>> +	ret =3D tz->ops->get_trip_type(tz, trip, &type);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (type !=3D THERMAL_TRIP_CRITICAL)
>> +		return 0;
>> +
>> +	return thermtrip_program(dev, sg, temp);
>> +}
>> +
>>  static const struct thermal_zone_of_device_ops tegra_of_thermal_ops=
 =3D {
>>  	.get_temp =3D tegra_thermctl_get_temp,
>> +	.set_trip_temp =3D tegra_thermctl_set_trip_temp,
>>  };
>> =20
>> +/**
>> + * enforce_temp_range() - check and enforce temperature range [min,=
 max]
>> + * @trip_temp: the trip temperature to check
>> + *
>> + * Checks and enforces the permitted temperature range that SOC_THE=
RM
>> + * HW can support This is
>> + * done while taking care of precision.
>> + *
>> + * Return: The precision adjusted capped temperature in millicelsiu=
s.
>> + */
>> +static int enforce_temp_range(struct device *dev, int trip_temp)
>> +{
>> +	int temp;
>> +
>> +	temp =3D clamp_val(trip_temp, min_low_temp, max_high_temp);
>> +	if (temp !=3D trip_temp)
>> +		dev_info(dev, "soctherm: trip temperature %d forced to %d\n",
>> +			 trip_temp, temp);
>> +	return temp;
>> +}
>> +
>> +/**
>> + * thermtrip_program() - Configures the hardware to shut down the
>> + * system if a given sensor group reaches a given temperature
>> + * @dev: ptr to the struct device for the SOC_THERM IP block
>> + * @sg: pointer to the sensor group to set the thermtrip temperatur=
e for
>> + * @trip_temp: the temperature in millicelsius to trigger the therm=
al trip at
>> + *
>> + * Sets the thermal trip threshold of the given sensor group to be =
the
>> + * @trip_temp.  If this threshold is crossed, the hardware will shu=
t
>> + * down.
>> + *
>> + * Note that, although @trip_temp is specified in millicelsius, the
>> + * hardware is programmed in degrees Celsius.
>> + *
>> + * Return: 0 upon success, or %-EINVAL upon failure.
>> + */
>> +static int thermtrip_program(struct device *dev,
>> +			     const struct tegra_tsensor_group *sg,
>> +			     int trip_temp)
>> +{
>> +	struct tegra_soctherm *ts =3D dev_get_drvdata(dev);
>> +	int temp;
>> +	u32 r;
>> +
>> +	if (!dev || !sg)
>> +		return -EINVAL;
>> +
>> +	if (!sg->thermtrip_threshold_mask)
>> +		return -EINVAL;
>> +
>> +	temp =3D enforce_temp_range(dev, trip_temp) / ts->soc->thresh_grai=
n;
>> +
>> +	r =3D readl(ts->regs + THERMCTL_THERMTRIP_CTL);
>> +	r =3D REG_SET_MASK(r, sg->thermtrip_threshold_mask, temp);
>> +	r =3D REG_SET_MASK(r, sg->thermtrip_enable_mask, 1);
>> +	r =3D REG_SET_MASK(r, sg->thermtrip_any_en_mask, 0);
>> +	writel(r, ts->regs + THERMCTL_THERMTRIP_CTL);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * tegra_soctherm_set_hwtrips() - set HW trip point from DT data
>> + * @dev: struct device * of the SOC_THERM instance
>> + *
>> + * Configure the SOC_THERM HW trip points, setting "THERMTRIP"
>> + * trip points , using "critical" type trip_temp from thermal
>> + * zone.
>> + * After they have been configured, THERMTRIP will take action
>> + * when the configured SoC thermal sensor group reaches a
>> + * certain temperature.
>> + *
>> + * Return: 0 upon success, or a negative error code on failure.
>> + * "Success" does not mean that trips was enabled; it could also
>> + * mean that no node was found in DT.
>> + * THERMTRIP has been enabled successfully when a message similar t=
o
>> + * this one appears on the serial console:
>> + * "thermtrip: will shut down when sensor group XXX reaches YYYYYY =
mC"
>> + */
>> +static int tegra_soctherm_set_hwtrips(struct device *dev,
>> +				      const struct tegra_tsensor_group *sg,
>> +				      struct thermal_zone_device *tz)
>> +{
>> +	int temperature;
>> +	int ret;
>> +
>> +	ret =3D tz->ops->get_crit_temp(tz, &temperature);
>> +	if (ret) {
>> +		dev_warn(dev, "thermtrip: %s: missing critical temperature\n",
>> +			sg->name);
>> +		return ret;
>> +	}
>> +
>> +	ret =3D thermtrip_program(dev, sg, temperature);
>> +	if (ret) {
>> +		dev_err(dev, "thermtrip: %s: error during enable\n",
>> +			sg->name);
>> +		return ret;
>> +	}
>> +
>> +	dev_info(dev,
>> +		 "thermtrip: will shut down when %s reaches %d mC\n",
>> +		 sg->name, temperature);
>> +
>> +	return 0;
>> +}
>> +
>>  #ifdef CONFIG_DEBUG_FS
>>  static int regs_show(struct seq_file *s, void *data)
>>  {
>>  	struct platform_device *pdev =3D s->private;
>>  	struct tegra_soctherm *ts =3D platform_get_drvdata(pdev);
>>  	const struct tegra_tsensor *tsensors =3D ts->soc->tsensors;
>> +	const struct tegra_tsensor_group **ttgs =3D ts->soc->ttgs;
>>  	u32 r, state;
>>  	int i;
>> =20
>> @@ -233,6 +374,17 @@ static int regs_show(struct seq_file *s, void *=
data)
>>  	state =3D REG_GET_MASK(r, SENSOR_TEMP2_MEM_TEMP_MASK);
>>  	seq_printf(s, " MEM(%d)\n", translate_temp(state));
>> =20
>> +	r =3D readl(ts->regs + THERMCTL_THERMTRIP_CTL);
>> +	state =3D REG_GET_MASK(r, ttgs[0]->thermtrip_any_en_mask);
>> +	seq_printf(s, "Thermtrip Any En(%d)\n", state);
>> +	for (i =3D 0; i < ts->soc->num_ttgs; i++) {
>> +		state =3D REG_GET_MASK(r, ttgs[i]->thermtrip_enable_mask);
>> +		seq_printf(s, "     %s En(%d) ", ttgs[i]->name, state);
>> +		state =3D REG_GET_MASK(r, ttgs[i]->thermtrip_threshold_mask);
>> +		state *=3D ts->soc->thresh_grain;
>> +		seq_printf(s, "Thresh(%d)\n", state);
>> +	}
>> +
>>  	return 0;
>>  }
>> =20
>> @@ -388,8 +540,6 @@ static int tegra_soctherm_probe(struct platform_=
device *pdev)
>>  	writel(pdiv, tegra->regs + SENSOR_PDIV);
>>  	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);
>> =20
>> -	/* Initialize thermctl sensors */
>> -
>>  	for (i =3D 0; i < soc->num_ttgs; ++i) {
>>  		struct tegra_thermctl_zone *zone =3D
>>  			devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);
>> @@ -399,7 +549,8 @@ static int tegra_soctherm_probe(struct platform_=
device *pdev)
>>  		}
>> =20
>>  		zone->reg =3D tegra->regs + soc->ttgs[i]->sensor_temp_offset;
>> -		zone->mask =3D soc->ttgs[i]->sensor_temp_mask;
>> +		zone->dev =3D &pdev->dev;
>> +		zone->sg =3D soc->ttgs[i];
>> =20
>>  		z =3D devm_thermal_zone_of_sensor_register(&pdev->dev,
>>  							 soc->ttgs[i]->id, zone,
>> @@ -410,6 +561,11 @@ static int tegra_soctherm_probe(struct platform=
_device *pdev)
>>  				err);
>>  			goto disable_clocks;
>>  		}
>> +
>> +		zone->tz =3D z;
>> +
>> +		/* Configure hw trip points */
>> +		tegra_soctherm_set_hwtrips(&pdev->dev, soc->ttgs[i], z);
>>  	}
>> =20
> <cut>
>=20
>> 1.9.1
>>
>=20
> * Unknown Key
> * 0x7DA4E256
>=20
