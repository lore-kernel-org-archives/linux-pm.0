From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v4 2/2] thermal: add interface to support tune governor
 in run-time
Date: Mon, 20 Jan 2014 09:28:15 -0400
Message-ID: <52DD246F.4060903@ti.com>
References: <1390211732-5853-1-git-send-email-wni@nvidia.com> <1390211732-5853-3-git-send-email-wni@nvidia.com> <52DCF340.6050406@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="poXgM0Hc5vtRQ1usOlqeAaa31T5OfNjeE"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45250 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbaATN22 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 20 Jan 2014 08:28:28 -0500
In-Reply-To: <52DCF340.6050406@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

--poXgM0Hc5vtRQ1usOlqeAaa31T5OfNjeE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20-01-2014 05:58, Wei Ni wrote:
> On 01/20/2014 05:55 PM, Wei Ni wrote:
>> In the of-thermal driver, it register a thermal zone device
>> without governor, since the governers are not static, we

s/governer/governor/g

>> should be able to update to a new one in run-time, so I add
>> a new fucntion thermal_update_governor() to do it.

s/fucntion/function/g

>>
>> Change-Id: Ie4995d6404d6d4f16250958487f3e3b8f63fc4c6
>=20
> Oh, I need to remove change id.

Yup.

At first glance, I am not against having this API. The only request I
make is to merge this only if  we have at least one real use(r) of it.

>=20
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  Documentation/thermal/sysfs-api.txt |    4 ++++
>>  drivers/thermal/thermal_core.c      |   38 ++++++++++++++++++++++++++=
++-------
>>  include/linux/thermal.h             |    1 +
>>  3 files changed, 36 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/therm=
al/sysfs-api.txt
>> index 8459d45..bcd50b5 100644
>> --- a/Documentation/thermal/sysfs-api.txt
>> +++ b/Documentation/thermal/sysfs-api.txt
>> @@ -405,3 +405,7 @@ platform data is provided, this uses the step_wise=
 throttling policy.
>>  This function serves as an arbitrator to set the state of a cooling
>>  device. It sets the cooling device to the deepest cooling state if
>>  possible.
>> +
>> +5.5:thermal_update_governor:
>> +This function update the thermal zone's governor to a new one.
>> +Returns 0 if success, an erro code otherwise.
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_=
core.c
>> index a91684b..ef0fc40 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -130,6 +130,35 @@ exit:
>>  	return;
>>  }
>> =20
>> +/**
>> + * thermal_update_governor() - update the thermal zone device's gover=
nor
>> + * to a new one.
>> + * @tzd: pointer of thermal zone device, which need to update governo=
r.
>> + * @name: new governor name.
>> + *
>> + * Return: On success returns 0, an error code otherwise
>> + */
>> +int thermal_update_governor(struct thermal_zone_device *tzd,
>> +			    const char *name)
>> +{
>> +	struct thermal_governor *new_gov;
>> +	int ret =3D 0;
>> +
>> +	mutex_lock(&thermal_governor_lock);
>> +
>> +	new_gov =3D __find_governor(name);
>> +	if (!new_gov) {
>> +		ret =3D -EINVAL;
>> +		goto exit;
>> +	}
>> +
>> +	tzd->governor =3D new_gov;
>> +
>> +exit:
>> +	mutex_unlock(&thermal_governor_lock);
>> +	return ret;
>> +}
>> +
>>  static int get_idr(struct idr *idr, struct mutex *lock, int *id)
>>  {
>>  	int ret;
>> @@ -734,22 +763,17 @@ policy_store(struct device *dev, struct device_a=
ttribute *attr,
>>  {
>>  	int ret =3D -EINVAL;
>>  	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
>> -	struct thermal_governor *gov;
>>  	char name[THERMAL_NAME_LENGTH];
>> =20
>>  	snprintf(name, sizeof(name), "%s", buf);
>> =20
>> -	mutex_lock(&thermal_governor_lock);
>> -
>> -	gov =3D __find_governor(strim(name));
>> -	if (!gov)
>> +	ret =3D thermal_update_governor(tz, strim(name));
>> +	if (ret < 0)
>>  		goto exit;
>> =20
>> -	tz->governor =3D gov;
>>  	ret =3D count;
>> =20
>>  exit:
>> -	mutex_unlock(&thermal_governor_lock);
>>  	return ret;
>>  }
>> =20
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index f7e11c7..715b3cd 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -293,6 +293,7 @@ struct thermal_instance *get_thermal_instance(stru=
ct thermal_zone_device *,
>>  		struct thermal_cooling_device *, int);
>>  void thermal_cdev_update(struct thermal_cooling_device *);
>>  void thermal_notify_framework(struct thermal_zone_device *, int);
>> +int thermal_update_governor(struct thermal_zone_device *, const char =
*);
>> =20
>>  #ifdef CONFIG_NET
>>  extern int thermal_generate_netlink_event(struct thermal_zone_device =
*tz,
>>
>=20
>=20
> -----------------------------------------------------------------------=
------------
> This email message is for the sole use of the intended recipient(s) and=
 may contain
> confidential information.  Any unauthorized review, use, disclosure or =
distribution
> is prohibited.  If you are not the intended recipient, please contact t=
he sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------=
------------
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--poXgM0Hc5vtRQ1usOlqeAaa31T5OfNjeE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLdJHYACgkQCXcVR3XQvP1MrAD/QQ23jBs7aKilKQmkk9BOfpGg
sN/OHrt+uD7leqcDdEEBANk6MIisTiqSF7UsngS9cdnbpoD66eqqeICkpTie6BhF
=TafJ
-----END PGP SIGNATURE-----

--poXgM0Hc5vtRQ1usOlqeAaa31T5OfNjeE--
