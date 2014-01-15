From: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] thermal: add available policies attribut
Date: Wed, 15 Jan 2014 10:00:55 -0400
Message-ID: <52D69497.1030903@ti.com>
References: <1389611863-7812-1-git-send-email-wni@nvidia.com> <1389611863-7812-2-git-send-email-wni@nvidia.com> <52D40D36.9060702@ti.com> <52D67066.8010403@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Emwgp4cxH6x8tGd0WmMV3FADlGWa7WOal"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52D67066.8010403-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>, "rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--Emwgp4cxH6x8tGd0WmMV3FADlGWa7WOal
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 15-01-2014 07:26, Wei Ni wrote:
> On 01/13/2014 11:58 PM, Eduardo Valentin wrote:
>> * PGP Signed by an unknown key
>>
>> On 13-01-2014 07:17, Wei Ni wrote:
>>> The Linux thermal framework support to change governor policy
>>> in run time, but it can't show what available policies supported.
>>>
>>> This patch adds available_policies attribut to the thermal
>>
>> s/attribut/attribute/g
>=20
> oh, thanks, I will fix it.
>=20
>>
>>> framework, it can list the thermal governors which can be
>>> used for a particular zone. This attribut is read only.
>>>
>>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  Documentation/thermal/sysfs-api.txt |    6 ++++++
>>>  drivers/thermal/thermal_core.c      |   25 +++++++++++++++++++++++++=

>>>  2 files changed, 31 insertions(+)
>>>
>>> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/ther=
mal/sysfs-api.txt
>>> index 87519cb..6a70b55c 100644
>>> --- a/Documentation/thermal/sysfs-api.txt
>>> +++ b/Documentation/thermal/sysfs-api.txt
>>> @@ -172,6 +172,7 @@ Thermal zone device sys I/F, created once it's re=
gistered:
>>>      |---temp:			Current temperature
>>>      |---mode:			Working mode of the thermal zone
>>>      |---policy:			Thermal governor used for this zone
>>> +    |---available_policies	Available governors for this zone
>>
>> I would prefer:
>> "Available thermal governors for this zone"
>=20
> Ok.
>=20
>>
>>>      |---trip_point_[0-*]_temp:	Trip point temperature
>>>      |---trip_point_[0-*]_type:	Trip point type
>>>      |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
>>> @@ -238,6 +239,10 @@ policy
>>>  	One of the various thermal governors used for a particular zone.
>>>  	RW, Required
>>> =20
>>> +available_policies
>>> +	Availabe thermal governors which can be used for a particular zone.=

>>> +	RO, Required
>>> +
>>>  trip_point_[0-*]_temp
>>>  	The temperature above which trip point will be fired.
>>>  	Unit: millidegree Celsius
>>> @@ -330,6 +335,7 @@ method, the sys I/F structure will be built like =
this:
>>>      |---temp:			37000
>>>      |---mode:			enabled
>>>      |---policy:			step_wise
>>> +    |---available_policies:	step_wise fair_share
>>>      |---trip_point_0_temp:	100000
>>>      |---trip_point_0_type:	critical
>>>      |---trip_point_1_temp:	80000
>>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal=
_core.c
>>> index 338a88b..aab1df8 100644
>>> --- a/drivers/thermal/thermal_core.c
>>> +++ b/drivers/thermal/thermal_core.c
>>> @@ -761,6 +761,24 @@ policy_show(struct device *dev, struct device_at=
tribute *devattr, char *buf)
>>>  	return sprintf(buf, "%s\n", tz->governor->name);
>>>  }
>>> =20
>>> +static ssize_t
>>> +available_policies_show(struct device *dev, struct device_attribute =
*devattr,
>>> +			char *buf)
>>> +{
>>> +	struct thermal_governor *pos;
>>> +	ssize_t count =3D 0;
>>> +
>>> +	mutex_lock(&thermal_governor_lock);
>>> +
>>> +	list_for_each_entry(pos, &thermal_governor_list, governor_list)
>>> +		count +=3D sprintf(buf + count, "%s ", pos->name);
>>
>> I would prefer if you'd used scnprintf
>>
>>> +	count +=3D sprintf(buf + count, "\n");
>>
>> ditto.
>>
>>
>> It is unlikely, but What if count if greater than PAGE_SIZE?
>=20
> hmm, I checked the sysfs driver, in funciton sysfs_kf_seq_show(), it
> seems it can handle the count greater than PAGE_SIZE.
> Or we can return error here directly.
> What do you think about it?

Just to be aware that it will truncate your buffer:
	/*
	 * The code works fine with PAGE_SIZE return but it's likely to
	 * indicate truncated result or overflow in normal use cases.
	 */
	if (count >=3D (ssize_t)PAGE_SIZE) {
		print_symbol("fill_read_buffer: %s returned bad count\n",
			(unsigned long)ops->show);
		/* Try to struggle along */
		count =3D PAGE_SIZE - 1;
	}


So, you either truncate here or leave to sysfs_seq_show(). Leave at
least a comment in case you leave to sysfs layer.

>=20
>>
>>> +
>>> +	mutex_unlock(&thermal_governor_lock);
>>> +
>>> +	return count;
>>> +}
>>> +
>>>  #ifdef CONFIG_THERMAL_EMULATION
>>>  static ssize_t
>>>  emul_temp_store(struct device *dev, struct device_attribute *attr,
>>> @@ -794,6 +812,7 @@ static DEVICE_ATTR(temp, 0444, temp_show, NULL);
>>>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
>>>  static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive=
_store);
>>>  static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_st=
ore);
>>> +static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_s=
how, NULL);
>>> =20
>>>  /* sys I/F for cooling device */
>>>  #define to_cooling_device(_dev)	\
>>> @@ -1527,6 +1546,11 @@ struct thermal_zone_device *thermal_zone_devic=
e_register(const char *type,
>>>  	if (result)
>>>  		goto unregister;
>>> =20
>>> +	/* Create available_policies attribute */
>>> +	result =3D device_create_file(&tz->device, &dev_attr_available_poli=
cies);
>>> +	if (result)
>>> +		goto unregister;
>>> +
>>>  	/* Update 'this' zone's governor information */
>>>  	mutex_lock(&thermal_governor_lock);
>>> =20
>>> @@ -1622,6 +1646,7 @@ void thermal_zone_device_unregister(struct ther=
mal_zone_device *tz)
>>>  	if (tz->ops->get_mode)
>>>  		device_remove_file(&tz->device, &dev_attr_mode);
>>>  	device_remove_file(&tz->device, &dev_attr_policy);
>>> +	device_remove_file(&tz->device, &dev_attr_available_policies);
>>>  	remove_trip_attrs(tz);
>>>  	tz->governor =3D NULL;
>>> =20
>>>
>>
>>
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--Emwgp4cxH6x8tGd0WmMV3FADlGWa7WOal
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLWlJcACgkQCXcVR3XQvP27EAEA/BtrYIJeTh6od2NAZ4nMgT8G
qIat+4mDXACiGgGzUPkBAICVxhuBhLMLny3XF3nW6Au97zFvrIyjt/5Xa0DtVi9R
=rirf
-----END PGP SIGNATURE-----

--Emwgp4cxH6x8tGd0WmMV3FADlGWa7WOal--
