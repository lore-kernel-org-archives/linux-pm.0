From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v2 2/2] thermal: add interface to support tune governor
 in run-time
Date: Fri, 17 Jan 2014 12:01:05 -0400
Message-ID: <52D953C1.9050908@ti.com>
References: <1389611863-7812-1-git-send-email-wni@nvidia.com>  <1389611863-7812-3-git-send-email-wni@nvidia.com> <1389946970.5918.46.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gvdpTOUgVW5pCBgT4m05c4XvRv9iGSWvp"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34320 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657AbaAQQBq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Jan 2014 11:01:46 -0500
In-Reply-To: <1389946970.5918.46.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Wei Ni <wni@nvidia.com>, eduardo.valentin@ti.com, mark.rutland@arm.com, durgadoss.r@intel.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org

--gvdpTOUgVW5pCBgT4m05c4XvRv9iGSWvp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 17-01-2014 04:22, Zhang Rui wrote:
> On Mon, 2014-01-13 at 19:17 +0800, Wei Ni wrote:
>> In the of-thermal driver, it register a thermal zone device
>> without governor, since the governers are not static, we
>> should be able to update to a new one in run-time, so I add
>> a new fucntion thermal_update_governor() to do it.
>>
>> In the future, the governor will be more complex, it may want
>> to tune governor-specific parameters/configuration for
>> different thermal zone at different run-time, so I add
>> start/stop for the governor and add governor_data as governor's
>> parameters, so that the thermal platform driver can change
>> the governor with start/stop, and tune the governor parameters
>> in run-time.
>=20
> are you going to introduce a new governor with .start/.stop implemented=

> or are you going to introduce .start/.stop callbacks for the current
> governors?

This is what I have been questioning.

>=20
> I'd like to see if there is any real request for this.

ditto. I am for introducing these APIs when the real user of them
appears, say the new governor or the changes in the existing ones.

>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  Documentation/thermal/sysfs-api.txt |    5 +++
>>  drivers/thermal/thermal_core.c      |   80 ++++++++++++++++++++++++++=
+++++----
>>  include/linux/thermal.h             |   12 ++++++
>>  3 files changed, 88 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/therm=
al/sysfs-api.txt
>> index 6a70b55c..7efd8e6 100644
>> --- a/Documentation/thermal/sysfs-api.txt
>> +++ b/Documentation/thermal/sysfs-api.txt
>> @@ -405,3 +405,8 @@ platform data is provided, this uses the step_wise=
 throttling policy.
>>  This function serves as an arbitrator to set the state of a cooling
>>  device. It sets the cooling device to the deepest cooling state if
>>  possible.
>> +
>> +5.5:thermal_update_governor:
>> +This function update the thermal zone's governor to a new one and upd=
ate
>> +the governor data of the new governor for that thermal zone. Returns =
0 if
>> +success, an erro code otherwise.
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_=
core.c
>> index aab1df8..d922baf 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -93,10 +93,17 @@ int thermal_register_governor(struct thermal_gover=
nor *governor)
>>  			name =3D pos->tzp->governor_name;
>>  		else
>>  			name =3D DEFAULT_THERMAL_GOVERNOR;
>> -		if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH))
>> +		if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH)) {
>> +			if (governor->start) {
>> +				err =3D governor->start(pos);
>> +				if (err < 0)
>> +					goto exit;
>> +			}
>>  			pos->governor =3D governor;
>> +		}
>>  	}
>> =20
>> +exit:
>>  	mutex_unlock(&thermal_list_lock);
>>  	mutex_unlock(&thermal_governor_lock);
>> =20
>> @@ -119,8 +126,11 @@ void thermal_unregister_governor(struct thermal_g=
overnor *governor)
>> =20
>>  	list_for_each_entry(pos, &thermal_tz_list, node) {
>>  		if (!strnicmp(pos->governor->name, governor->name,
>> -						THERMAL_NAME_LENGTH))
>> +						THERMAL_NAME_LENGTH)) {
>> +			if (pos->governor->stop)
>> +				pos->governor->stop(pos);
>>  			pos->governor =3D NULL;
>> +		}
>>  	}
>> =20
>>  	mutex_unlock(&thermal_list_lock);
>> @@ -130,6 +140,51 @@ exit:
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
>> + * @gov_data: governor data for the new governor if needed.
>> + *
>> + * Return: On success returns 0, an error code otherwise
>> + */
>> +int thermal_update_governor(struct thermal_zone_device *tzd,
>> +			    const char *name, void *gov_data)
>> +{
>> +	struct thermal_governor *old_gov, *new_gov;
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
>> +	old_gov =3D tzd->governor;
>> +
>> +	if (old_gov && old_gov->stop)
>> +		old_gov->stop(tzd);
>> +
>> +	if (new_gov->start) {
>> +		ret =3D new_gov->start(tzd);
>> +		if (ret < 0) {
>> +			if (old_gov && old_gov->start)
>> +				old_gov->start(tzd);
>> +			goto exit;
>> +		}
>> +	}
>> +
>> +	tzd->governor =3D new_gov;
>> +	tzd->governor_data =3D gov_data;
>> +
>> +exit:
>> +	mutex_unlock(&thermal_governor_lock);
>> +	return ret;
>> +}
>> +
>>  static int get_idr(struct idr *idr, struct mutex *lock, int *id)
>>  {
>>  	int ret;
>> @@ -734,22 +789,17 @@ policy_store(struct device *dev, struct device_a=
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
>> +	ret =3D thermal_update_governor(tz, strim(name), NULL);
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
>> @@ -1559,6 +1609,12 @@ struct thermal_zone_device *thermal_zone_device=
_register(const char *type,
>>  	else
>>  		tz->governor =3D __find_governor(DEFAULT_THERMAL_GOVERNOR);
>> =20
>> +	if (tz->governor->start) {
>=20
> Note that tz->governor may be NULL at this time.
> although this seems like a bug to me.
>=20
>> +		result =3D tz->governor->start(tz);
>> +		if (result < 0)
>> +			tz->governor =3D NULL;
>> +	}
>> +
> why not invoke thermal_update_governor() directly here?
>=20
> thanks,
> rui
>>  	mutex_unlock(&thermal_governor_lock);
>> =20
>>  	if (!tz->tzp || !tz->tzp->no_hwmon) {
>> @@ -1585,6 +1641,9 @@ struct thermal_zone_device *thermal_zone_device_=
register(const char *type,
>>  		return tz;
>> =20
>>  unregister:
>> +	if (tz->governor && tz->governor->stop)
>> +		tz->governor->stop(tz);
>> +	tz->governor =3D NULL;
>>  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
>>  	device_unregister(&tz->device);
>>  	return ERR_PTR(result);
>> @@ -1648,6 +1707,9 @@ void thermal_zone_device_unregister(struct therm=
al_zone_device *tz)
>>  	device_remove_file(&tz->device, &dev_attr_policy);
>>  	device_remove_file(&tz->device, &dev_attr_available_policies);
>>  	remove_trip_attrs(tz);
>> +
>> +	if (tz->governor && tz->governor->stop)
>> +		tz->governor->stop(tz);
>>  	tz->governor =3D NULL;
>> =20
>=20
>>  	thermal_remove_hwmon_sysfs(tz);
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index f7e11c7..a473736 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -177,6 +177,7 @@ struct thermal_zone_device {
>>  	struct thermal_zone_device_ops *ops;
>>  	const struct thermal_zone_params *tzp;
>>  	struct thermal_governor *governor;
>> +	void *governor_data;
>>  	struct list_head thermal_instances;
>>  	struct idr idr;
>>  	struct mutex lock; /* protect thermal_instances list */
>> @@ -187,6 +188,15 @@ struct thermal_zone_device {
>>  /* Structure that holds thermal governor information */
>>  struct thermal_governor {
>>  	char name[THERMAL_NAME_LENGTH];
>> +
>> +	/*
>> +	 * The start and stop operations will be called when thermal zone is=

>> +	 * registered and when change governor via sysfs or driver in runnin=
g
>> +	 * time.
>> +	 */
>> +	int (*start)(struct thermal_zone_device *tz);
>> +	void (*stop)(struct thermal_zone_device *tz);
>> +
>>  	int (*throttle)(struct thermal_zone_device *tz, int trip);
>>  	struct list_head	governor_list;
>>  };
>> @@ -293,6 +303,8 @@ struct thermal_instance *get_thermal_instance(stru=
ct thermal_zone_device *,
>>  		struct thermal_cooling_device *, int);
>>  void thermal_cdev_update(struct thermal_cooling_device *);
>>  void thermal_notify_framework(struct thermal_zone_device *, int);
>> +int thermal_update_governor(struct thermal_zone_device *, const char =
*,
>> +			    void *);
>> =20
>>  #ifdef CONFIG_NET
>>  extern int thermal_generate_netlink_event(struct thermal_zone_device =
*tz,
>=20
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--gvdpTOUgVW5pCBgT4m05c4XvRv9iGSWvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLZU98ACgkQCXcVR3XQvP1/XwEA20XZ3SlkjrkW7fml4c+LWTBW
EVY4CgZFs8BWN3Jgk9sA/ifNQqAE7zevwAgumQsblCTh6wRgyn3/zezNRhu4Su5w
=kuTd
-----END PGP SIGNATURE-----

--gvdpTOUgVW5pCBgT4m05c4XvRv9iGSWvp--
