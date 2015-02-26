From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 7/7] thermal: export thermal_zone_parameters to sysfs
Date: Thu, 26 Feb 2015 18:10:07 -0400
Message-ID: <20150226221004.GA5564@developer.amazonguestwifi.org>
References: <1424977233-15965-1-git-send-email-javi.merino@arm.com>
 <1424977233-15965-8-git-send-email-javi.merino@arm.com>
 <20150226212958.GB29288@developer.amazonguestwifi.org>
 <20150226220423.GA5451@developer.amazonguestwifi.org>
 <20150227171904.GA10658@e104805>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:42663 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbbB0TuN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Feb 2015 14:50:13 -0500
Content-Disposition: inline
In-Reply-To: <20150227171904.GA10658@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, "tixy@linaro.org" <tixy@linaro.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2015 at 05:19:05PM +0000, Javi Merino wrote:
> On Thu, Feb 26, 2015 at 10:04:24PM +0000, Eduardo Valentin wrote:
> > On Thu, Feb 26, 2015 at 05:30:00PM -0400, Eduardo Valentin wrote:
> > > On Thu, Feb 26, 2015 at 07:00:33PM +0000, Javi Merino wrote:
> > > > It's useful for tuning to be able to edit thermal_zone_parameters f=
rom
> > > > userspace.  Export them to the thermal_zone sysfs so that they can =
be
> > > > easily changed.
> > > >=20
> > > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > > Cc: Eduardo Valentin <edubezval@gmail.com>
> > > > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > > > ---
> > > >  Documentation/thermal/sysfs-api.txt |  52 +++++++++++++++++
> > > >  drivers/thermal/thermal_core.c      | 110 ++++++++++++++++++++++++=
++++++++++++
> > > >  2 files changed, 162 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/th=
ermal/sysfs-api.txt
> > > > index fc7dfe10778b..7d44d7f1a71b 100644
> > > > --- a/Documentation/thermal/sysfs-api.txt
> > > > +++ b/Documentation/thermal/sysfs-api.txt
> > > > @@ -184,6 +184,12 @@ Thermal zone device sys I/F, created once it's=
 registered:
> > > >      |---trip_point_[0-*]_type:	Trip point type
> > > >      |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
> > > >      |---emul_temp:		Emulated temperature set node
> > > > +    |---sustainable_power:      Sustainable dissipatable power
> > > > +    |---k_po:                   Proportional term during temperatu=
re overshoot
> > > > +    |---k_pu:                   Proportional term during temperatu=
re undershoot
> > > > +    |---k_i:                    PID's integral term in the power a=
llocator gov
> > > > +    |---k_d:                    PID's derivative term in the power=
 allocator
> > > > +    |---integral_cutoff:        Offset above which errors are accu=
mulated
> > >=20
> > > Can this be under a specific directory?
> > >=20
> > > I thought of something like
> > > /sys/class/thermal/thermal_zoneX/governor_params/<gov spec files>
> > >=20
> > > The above node can be handled by the governor code.
>=20
> I thought about doing that, but creating a sysfs directory was a lot
> of boilerplate code that I thought didn't bring us anything.  That's
> why I avoided it.

OK. I see.

>=20
> > > >  Thermal cooling device sys I/F, created once it's registered:
> > > >  /sys/class/thermal/cooling_device[0-*]:
> > > > @@ -307,6 +313,52 @@ emul_temp
> > > >  	  because userland can easily disable the thermal policy by simply
> > > >  	  flooding this sysfs node with low temperature values.
> > > > =20
> > > > +sustainable_power
> > > > +	An estimate of the sustained power that can be dissipated by
> > > > +	the thermal zone. Used by the power allocator governor. For
> > > > +	more information see Documentation/thermal/power_allocator.txt
> > > > +	Unit: milliwatts
> > > > +	RW, Optional
> > > > +
> > > > +k_po
> > > > +	The proportional term of the power allocator governor's PID
> > > > +	controller during temperature overshoot. Temperature overshoot
> > > > +	is when the current temperature is above the "desired
> > > > +	temperature" trip point. For more information see
> > > > +	Documentation/thermal/power_allocator.txt
> > > > +	RW, Optional
> > > > +
> > > > +k_pu
> > > > +	The proportional term of the power allocator governor's PID
> > > > +	controller during temperature undershoot. Temperature undershoot
> > > > +	is when the current temperature is below the "desired
> > > > +	temperature" trip point. For more information see
> > > > +	Documentation/thermal/power_allocator.txt
> > > > +	RW, Optional
> > > > +
> > > > +k_i
> > > > +	The integral term of the power allocator governor's PID
> > > > +	controller. This term allows the PID controller to compensate
> > > > +	for long term drift. For more information see
> > > > +	Documentation/thermal/power_allocator.txt
> > > > +	RW, Optional
> > > > +
> > > > +k_d
> > > > +	The derivative term of the power allocator governor's PID
> > > > +	controller. For more information see
> > > > +	Documentation/thermal/power_allocator.txt
> > > > +	RW, Optional
> > > > +
> > > > +integral_cutoff
> > > > +	Temperature offset from the desired temperature trip point
> > > > +	above which the integral term of the power allocator
> > > > +	governor's PID controller starts accumulating errors. For
> > > > +	example, if integral_cutoff is 0, then the integral term only
> > > > +	accumulates error when temperature is above the desired
> > > > +	temperature trip point. For more information see
> > > > +	Documentation/thermal/power_allocator.txt
> > > > +	RW, Optional
> > > > +
> > > >  *****************************
> > > >  * Cooling device attributes *
> > > >  *****************************
> > > > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/therm=
al_core.c
> > > > index df9ba3bf55dc..228e93f8a146 100644
> > > > --- a/drivers/thermal/thermal_core.c
> > > > +++ b/drivers/thermal/thermal_core.c
> > > > @@ -873,6 +873,111 @@ emul_temp_store(struct device *dev, struct de=
vice_attribute *attr,
> > > >  static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
> > > >  #endif/*CONFIG_THERMAL_EMULATION*/
> > > > =20
> > > > +#ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
> >=20
> >=20
> > What bugged me in the first place was the fact that we are doing this
> > #ifdef here. But in fact, it is not really necessary, as the parameters
> > are stored in tzp, and they will be there regardless of the config
> > status.
>=20
> My reasoning behind the ifdefs was because it seems we are putting a
> number of files in sysfs that are not interesting if this was not
> compiled in.  It's true that technically the ifdefs are not needed.
> I'll remove them.

OK. Good.

>=20
> > > > +
> > > > +static ssize_t
> > > > +sustainable_power_show(struct device *dev, struct device_attribute=
 *devattr,
> > > > +		       char *buf)
> > > > +{
> > > > +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> > > > +
> > > > +	if (tz->tzp)
> > > > +		return sprintf(buf, "%u\n", tz->tzp->sustainable_power);
> > > > +	else
> > > > +		return -EIO;
> > > > +}
> > > > +
> > > > +static ssize_t
> > > > +sustainable_power_store(struct device *dev, struct device_attribut=
e *devattr,
> > > > +			const char *buf, size_t count)
> > > > +{
> > > > +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> > > > +	u32 sustainable_power;
> > > > +
> > > > +	if (!tz->tzp)
> > > > +		return -EIO;
> > > > +
> > > > +	if (kstrtou32(buf, 10, &sustainable_power))
> > > > +		return -EINVAL;
> > > > +
> > > > +	tz->tzp->sustainable_power =3D sustainable_power;
> > > > +
> > > > +	return count;
> > > > +}
> > > > +static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainab=
le_power_show,
> > > > +		sustainable_power_store);
> > > > +
> > > > +#define create_s32_tzp_attr(name)					\
> > > > +	static ssize_t							\
> > > > +	name##_show(struct device *dev, struct device_attribute *devattr,=
 \
> > > > +		char *buf)						\
> > > > +	{								\
> > > > +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);		\
> > > > +									\
> > > > +	if (tz->tzp)							\
> > > > +		return sprintf(buf, "%u\n", tz->tzp->name);		\
> > > > +	else								\
> > > > +		return -EIO;						\
> > > > +	}								\
> > > > +									\
> > > > +	static ssize_t							\
> > > > +	name##_store(struct device *dev, struct device_attribute *devattr=
, \
> > > > +		const char *buf, size_t count)				\
> > > > +	{								\
> > > > +		struct thermal_zone_device *tz =3D to_thermal_zone(dev);	\
> > > > +		s32 value;						\
> > > > +									\
> > > > +		if (!tz->tzp)						\
> > > > +			return -EIO;					\
> > > > +									\
> > > > +		if (kstrtos32(buf, 10, &value))				\
> > > > +			return -EINVAL;					\
> > > > +									\
> > > > +		tz->tzp->name =3D value;					\
> > > > +									\
> > > > +		return count;						\
> > > > +	}								\
> > > > +	static DEVICE_ATTR(name, S_IWUSR | S_IRUGO, name##_show, name##_s=
tore)
> > > > +
> > > > +create_s32_tzp_attr(k_po);
> > > > +create_s32_tzp_attr(k_pu);
> > > > +create_s32_tzp_attr(k_i);
> > > > +create_s32_tzp_attr(k_d);
> > > > +create_s32_tzp_attr(integral_cutoff);
> > > > +#undef create_s32_tzp_attr
> > > > +
> > > > +static struct device_attribute *dev_tzp_attrs[] =3D {
> > > > +	&dev_attr_sustainable_power,
> > > > +	&dev_attr_k_po,
> > > > +	&dev_attr_k_pu,
> > > > +	&dev_attr_k_i,
> > > > +	&dev_attr_k_d,
> > > > +	&dev_attr_integral_cutoff,
> > > > +};
> > > > +
> > > > +static int create_power_allocator_tzp_attrs(struct device *dev)
> >=20
> > I would rename this to thermal_create_zone_params_attrs and remove the
> > ifdefiry.
>=20
> Ok, I will remove them.
>=20
> >           If you are not exposing the complete info under tzp, then make
> > a comment about it.
>=20
> There's nothing else worth populating.  The governor_name is not
> interesting, you have the thermal zone policy for that.  Similar for
> no_hwmon.  For tbps, weight and trip_mask are already exposed in the
> instance.  The binding_limits is currently not available in sysfs, but
> if we were to populate it, I would expose the ones that end up in the
> instance, as we do with trips and weights.
>=20
> Is it worth putting this in a comment in the code?


Well, I was more interested in governor specific / internal data,
accessible only in the governor file (e.g.: power_allocator.c). Do you
think we need to expose something that is accessible only from the
governor code or do you think the current info under tzp is enough?


If the former is the case, then we need restructure with callbacks. If
not, meaning, if all you need is in tzp, then we can keep the code in
thermal core.

>=20
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i =3D 0; i < ARRAY_SIZE(dev_tzp_attrs); i++) {
> > > > +		int ret;
> > > > +		struct device_attribute *dev_attr =3D dev_tzp_attrs[i];
> > > > +
> > > > +		ret =3D device_create_file(dev, dev_attr);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +#else  /* !CONFIG_THERMAL_GOV_POWER_ALLOCATOR */
> > > > +static int create_power_allocator_tzp_attrs(struct device *dev)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > > +#endif
> > > > +
> > >=20
> > > It is better if this code is not part of thermal_core. The governor
> > > specific code must be in the governor code. Durga has done a pretty g=
ood
> > > job splitting governor code out of thermal_core.c. I don't think we w=
ant
> > > to get them back.
> >=20
> > Unless you really want to expose something that is only inside the
> > governor data struture, you can ignore the above comment.
>=20
> Ok
>=20
> > > >  /**
> > > >   * power_actor_get_max_power() - get the maximum power that a cdev=
 can consume
> > > >   * @cdev:	pointer to &thermal_cooling_device
> > > > @@ -1712,6 +1817,11 @@ struct thermal_zone_device *thermal_zone_dev=
ice_register(const char *type,
> > > >  	if (result)
> > > >  		goto unregister;
> > > > =20
> > > > +	/* Add power_allocator specific thermal zone params */
> > > > +	result =3D create_power_allocator_tzp_attrs(&tz->device);
> > > > +	if (result)
> > > > +		goto unregister;
> > >=20
> > > Here you could create the governor_params and have a callback from
> > > governor to populate it.
> >=20
> > ditto.
> >=20
> > Of course, assuming all we are doing is exposing what is in
> > thermal_zone_params, which is generic enough to be in thermal_core.c.
>=20
> That's right.

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU75m0AAoJEMLUO4d9pOJWIN4H/Azdy9oTL8BvhgUfm/9qXfAc
InFycnvz6Evr8qi5Qt7l88dk29Ajz3kN6TiGeBJ6i2bcARUlb3FvRc3Jh4cPPFO5
IR2wT8V73Sj5PntWYHWisdpyi+uNm5QKjgsOqN+pPT5L5lYVH78WFJ62E575m6Ig
gq2EsU/PoHPGPJeWeBlv0h7Tlsp5b1zOxYaQcLfo6oc1wKrRgdsapT/Cpt/powbD
h76ll6RqLiad3MJjrYQZBMImjUZKq5mcS41yg1p1stFXwTDSCc0k3K64w1jV3rMA
IcKcNdb4x2CbDc2qwew/X3vWdowFoi2vMIvQWLjrQHn3G+Gb9gajhr11uM9kMkA=
=LAyV
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
