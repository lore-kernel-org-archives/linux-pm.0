From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V7 09/12] thermal: tegra: add thermtrip function
Date: Wed, 16 Mar 2016 13:53:53 +0800
Message-ID: <56E8F4F1.1060603@nvidia.com>
References: <1457665872-30046-1-git-send-email-wni@nvidia.com> <20160314191637.GC1872@localhost.localdomain> <56E7D1EC.5090907@nvidia.com> <20160315194929.GB26619@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160315194929.GB26619-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8816=E6=97=A5 03:49, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
>=20
> On Tue, Mar 15, 2016 at 05:12:12PM +0800, Wei Ni wrote:
>>
>>
>> On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 03:16, Eduardo Valentin wrote=
:
>>>> Old Signed by an unknown key
>>>
>>> On Fri, Mar 11, 2016 at 11:11:12AM +0800, Wei Ni wrote:
>>>> Add support for hardware critical thermal limits to the
>>>> SOC_THERM driver. It use the Linux thermal framework to
>>>> create critical trip temp, and set it to SOC_THERM hardware.
>>>> If these limits are breached, the chip will reset, and if
>>>> appropriately configured, will turn off the PMIC.
>>>>
>>>> This support is critical for safe usage of the chip.
>>>>
>>>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>> ---
>>>>  drivers/thermal/tegra/soctherm.c          | 166 +++++++++++++++++=
++++++++++++-
>>>>  drivers/thermal/tegra/soctherm.h          |   7 ++
>>>>  drivers/thermal/tegra/tegra124-soctherm.c |  24 +++++
>>>>  drivers/thermal/tegra/tegra210-soctherm.c |  24 +++++
>>>>  4 files changed, 216 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/te=
gra/soctherm.c
>>>> index 02ac6d2e5a20..dbaab160baba 100644
>>>> --- a/drivers/thermal/tegra/soctherm.c
>>>> +++ b/drivers/thermal/tegra/soctherm.c
>>>> @@ -73,9 +73,14 @@
>>>>  #define REG_SET_MASK(r, m, v)	(((r) & ~(m)) | \
>>>>  				 (((v) & (m >> (ffs(m) - 1))) << (ffs(m) - 1)))
>>>> =20
>>>> +static const int min_low_temp =3D -127000;
>>>> +static const int max_high_temp =3D 127000;
>>>> +
>>>>  struct tegra_thermctl_zone {
>>>>  	void __iomem *reg;
>>>> -	u32 mask;
>>>> +	struct device *dev;
>>>> +	struct thermal_zone_device *tz;
>>>
>>>
>>> Why not using tz->dev for the *dev above?
>>
>> The tz is thermal_zone_device, this structure doesn't have *dev.
>> It only have the member "struct device device;", but this device is =
created for
>> the thermal class, not this tegra_soctherm device.
>>
>>>
>>>> +	const struct tegra_tsensor_group *sg;
>>>>  };
>>>> =20
>>>>  struct tegra_soctherm {
>>>> @@ -145,22 +150,158 @@ static int tegra_thermctl_get_temp(void *da=
ta, int *out_temp)
>>>>  	u32 val;
>>>> =20
>>>>  	val =3D readl(zone->reg);
>>>> -	val =3D REG_GET_MASK(val, zone->mask);
>>>> +	val =3D REG_GET_MASK(val, zone->sg->sensor_temp_mask);
>>>>  	*out_temp =3D translate_temp(val);
>>>> =20
>>>>  	return 0;
>>>>  }
>>>> =20
>>>> +static int
>>>> +thermtrip_program(struct device *dev, const struct tegra_tsensor_=
group *sg,
>>>> +		  int trip_temp);
>>>> +
>>>> +static int tegra_thermctl_set_trip_temp(void *data, int trip, int=
 temp)
>>>> +{
>>>> +	struct tegra_thermctl_zone *zone =3D data;
>>>> +	struct thermal_zone_device *tz =3D zone->tz;
>>>> +	const struct tegra_tsensor_group *sg =3D zone->sg;
>>>> +	struct device *dev =3D zone->dev;
>>>> +	enum thermal_trip_type type;
>>>> +	int ret;
>>>> +
>>>> +	if (!tz)
>>>> +		return -EINVAL;
>>>
>>>
>>> Is the above check needed? If you saw a case in which your function=
 is
>>> called without tz, would it be the case we have a but in the probe =
(or
>>> even worse, in thermal-core)?
>>
>> This tz isn't from thermal-core, it's from the "void *data".
>> This *data is the private structure "struct tegra_thermctl_zone *zon=
e =3D data;".
>> It is registered in devm_thermal_zone_of_sensor_register(*dev, senso=
r_id, *data,
>> *ops). And when it register successful, I will set zone->tz =3D z, i=
n here, the
>> zone is the private data.
>> Let's consider a special case, once the thermal_zone_of_sensor_regis=
ter
>> successful and didn't run to "zone->tz =3D z" yet, then the thermal_=
core implement
>> .set_trip(), then it may cause problems in here, although it's diffi=
cult to hit
>> this case. So I think we need to do this check.
>=20
>=20
> Can you be more specific? I don't recall a case that core would call =
any
> driver callbacks before setting up the data structures properly.

Sorry for the confusion, I mean this data structure is the private data=
 pointer,
it doesn't handled by thermal_core. Let me explain more:
In this tegra soctherm driver, I run following steps in probe routine:
step1:
z =3D devm_thermal_zone_of_sensor_register(*dev, sensor_id, zone, ops);
register thermal zone device, in here, the parameter "zone" is the priv=
ate data
pointer "structure tegra_thermctl_zone".
step 2:
After register, it return the "z", and I set it to the private data:
zone->tz =3D z;

In the .set_trip() callback, it will pass back this private data pointe=
r.
So if the callback was called between step1 and step2, at that time the=
 zone->tz
didn't be set yet, it will cause problems, although I didn't hit this c=
ase.

This check doesn't relate with core driver, it is used to check my priv=
ate data
pointer.

Wei.

>=20
>>>
>=20
> * Unknown Key
> * 0x7DA4E256
>=20
