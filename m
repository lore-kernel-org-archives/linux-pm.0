From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 7/7] thermal: export thermal_zone_parameters to sysfs
Date: Thu, 26 Feb 2015 17:30:00 -0400
Message-ID: <20150226212958.GB29288@developer.amazonguestwifi.org>
References: <1424977233-15965-1-git-send-email-javi.merino@arm.com>
 <1424977233-15965-8-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:44875 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbbBZXpc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 18:45:32 -0500
Content-Disposition: inline
In-Reply-To: <1424977233-15965-8-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, broonie@kernel.org, tixy@linaro.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2015 at 07:00:33PM +0000, Javi Merino wrote:
> It's useful for tuning to be able to edit thermal_zone_parameters from
> userspace.  Export them to the thermal_zone sysfs so that they can be
> easily changed.
>=20
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
>  Documentation/thermal/sysfs-api.txt |  52 +++++++++++++++++
>  drivers/thermal/thermal_core.c      | 110 ++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 162 insertions(+)
>=20
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/=
sysfs-api.txt
> index fc7dfe10778b..7d44d7f1a71b 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -184,6 +184,12 @@ Thermal zone device sys I/F, created once it's regis=
tered:
>      |---trip_point_[0-*]_type:	Trip point type
>      |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
>      |---emul_temp:		Emulated temperature set node
> +    |---sustainable_power:      Sustainable dissipatable power
> +    |---k_po:                   Proportional term during temperature ove=
rshoot
> +    |---k_pu:                   Proportional term during temperature und=
ershoot
> +    |---k_i:                    PID's integral term in the power allocat=
or gov
> +    |---k_d:                    PID's derivative term in the power alloc=
ator
> +    |---integral_cutoff:        Offset above which errors are accumulated

Can this be under a specific directory?

I thought of something like
/sys/class/thermal/thermal_zoneX/governor_params/<gov spec files>

The above node can be handled by the governor code.


> =20
>  Thermal cooling device sys I/F, created once it's registered:
>  /sys/class/thermal/cooling_device[0-*]:
> @@ -307,6 +313,52 @@ emul_temp
>  	  because userland can easily disable the thermal policy by simply
>  	  flooding this sysfs node with low temperature values.
> =20
> +sustainable_power
> +	An estimate of the sustained power that can be dissipated by
> +	the thermal zone. Used by the power allocator governor. For
> +	more information see Documentation/thermal/power_allocator.txt
> +	Unit: milliwatts
> +	RW, Optional
> +
> +k_po
> +	The proportional term of the power allocator governor's PID
> +	controller during temperature overshoot. Temperature overshoot
> +	is when the current temperature is above the "desired
> +	temperature" trip point. For more information see
> +	Documentation/thermal/power_allocator.txt
> +	RW, Optional
> +
> +k_pu
> +	The proportional term of the power allocator governor's PID
> +	controller during temperature undershoot. Temperature undershoot
> +	is when the current temperature is below the "desired
> +	temperature" trip point. For more information see
> +	Documentation/thermal/power_allocator.txt
> +	RW, Optional
> +
> +k_i
> +	The integral term of the power allocator governor's PID
> +	controller. This term allows the PID controller to compensate
> +	for long term drift. For more information see
> +	Documentation/thermal/power_allocator.txt
> +	RW, Optional
> +
> +k_d
> +	The derivative term of the power allocator governor's PID
> +	controller. For more information see
> +	Documentation/thermal/power_allocator.txt
> +	RW, Optional
> +
> +integral_cutoff
> +	Temperature offset from the desired temperature trip point
> +	above which the integral term of the power allocator
> +	governor's PID controller starts accumulating errors. For
> +	example, if integral_cutoff is 0, then the integral term only
> +	accumulates error when temperature is above the desired
> +	temperature trip point. For more information see
> +	Documentation/thermal/power_allocator.txt
> +	RW, Optional
> +
>  *****************************
>  * Cooling device attributes *
>  *****************************
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index df9ba3bf55dc..228e93f8a146 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -873,6 +873,111 @@ emul_temp_store(struct device *dev, struct device_a=
ttribute *attr,
>  static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
>  #endif/*CONFIG_THERMAL_EMULATION*/
> =20
> +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
> +
> +static ssize_t
> +sustainable_power_show(struct device *dev, struct device_attribute *deva=
ttr,
> +		       char *buf)
> +{
> +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> +
> +	if (tz->tzp)
> +		return sprintf(buf, "%u\n", tz->tzp->sustainable_power);
> +	else
> +		return -EIO;
> +}
> +
> +static ssize_t
> +sustainable_power_store(struct device *dev, struct device_attribute *dev=
attr,
> +			const char *buf, size_t count)
> +{
> +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> +	u32 sustainable_power;
> +
> +	if (!tz->tzp)
> +		return -EIO;
> +
> +	if (kstrtou32(buf, 10, &sustainable_power))
> +		return -EINVAL;
> +
> +	tz->tzp->sustainable_power =3D sustainable_power;
> +
> +	return count;
> +}
> +static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_pow=
er_show,
> +		sustainable_power_store);
> +
> +#define create_s32_tzp_attr(name)					\
> +	static ssize_t							\
> +	name##_show(struct device *dev, struct device_attribute *devattr, \
> +		char *buf)						\
> +	{								\
> +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);		\
> +									\
> +	if (tz->tzp)							\
> +		return sprintf(buf, "%u\n", tz->tzp->name);		\
> +	else								\
> +		return -EIO;						\
> +	}								\
> +									\
> +	static ssize_t							\
> +	name##_store(struct device *dev, struct device_attribute *devattr, \
> +		const char *buf, size_t count)				\
> +	{								\
> +		struct thermal_zone_device *tz =3D to_thermal_zone(dev);	\
> +		s32 value;						\
> +									\
> +		if (!tz->tzp)						\
> +			return -EIO;					\
> +									\
> +		if (kstrtos32(buf, 10, &value))				\
> +			return -EINVAL;					\
> +									\
> +		tz->tzp->name =3D value;					\
> +									\
> +		return count;						\
> +	}								\
> +	static DEVICE_ATTR(name, S_IWUSR | S_IRUGO, name##_show, name##_store)
> +
> +create_s32_tzp_attr(k_po);
> +create_s32_tzp_attr(k_pu);
> +create_s32_tzp_attr(k_i);
> +create_s32_tzp_attr(k_d);
> +create_s32_tzp_attr(integral_cutoff);
> +#undef create_s32_tzp_attr
> +
> +static struct device_attribute *dev_tzp_attrs[] =3D {
> +	&dev_attr_sustainable_power,
> +	&dev_attr_k_po,
> +	&dev_attr_k_pu,
> +	&dev_attr_k_i,
> +	&dev_attr_k_d,
> +	&dev_attr_integral_cutoff,
> +};
> +
> +static int create_power_allocator_tzp_attrs(struct device *dev)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(dev_tzp_attrs); i++) {
> +		int ret;
> +		struct device_attribute *dev_attr =3D dev_tzp_attrs[i];
> +
> +		ret =3D device_create_file(dev, dev_attr);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +#else  /* !CONFIG_THERMAL_GOV_POWER_ALLOCATOR */
> +static int create_power_allocator_tzp_attrs(struct device *dev)
> +{
> +	return 0;
> +}
> +#endif
> +

It is better if this code is not part of thermal_core. The governor
specific code must be in the governor code. Durga has done a pretty good
job splitting governor code out of thermal_core.c. I don't think we want
to get them back.


>  /**
>   * power_actor_get_max_power() - get the maximum power that a cdev can c=
onsume
>   * @cdev:	pointer to &thermal_cooling_device
> @@ -1712,6 +1817,11 @@ struct thermal_zone_device *thermal_zone_device_re=
gister(const char *type,
>  	if (result)
>  		goto unregister;
> =20
> +	/* Add power_allocator specific thermal zone params */
> +	result =3D create_power_allocator_tzp_attrs(&tz->device);
> +	if (result)
> +		goto unregister;

Here you could create the governor_params and have a callback from
governor to populate it.

> +
>  	/* Update 'this' zone's governor information */
>  	mutex_lock(&thermal_governor_lock);
> =20
> --=20
> 1.9.1
>=20

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU75BLAAoJEMLUO4d9pOJWDDcH/1LQeg7B+Mqi2DLJzYUFfYdZ
Jo2+2Lgiddme7PlX1hHB/mMuG86JWWoX1Uj+W0nO7sygCAMHtgyENyqFJZodHmP2
pfFiaGGQfU4Kb3wE5/j8kKWnhZsYkNSUS/LZmldgNy/3YyuIkz1xzaBrdTZlFhP5
FAvnQ3EjKxCZ9dNgH6KeHm5bKudT1IikvDgVct8MsJCzjQrGECxcxl4pU54h83Ia
W5tF8FQHrAIcP9xsIUrH+wpGRtGpF0CIHHWveEqdaKtSSF8eJyZLxosNKEJb5FNX
oSkbgdgKWxSij4u+GhmvB+5tBC1UJiR+l/Q8U0+MpIcj2qebW34mIS0ElaHduO4=
=WOhd
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
