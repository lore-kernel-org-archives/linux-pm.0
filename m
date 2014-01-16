From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v3 1/2] thermal: add available policies attribute
Date: Thu, 16 Jan 2014 09:47:23 -0400
Message-ID: <52D7E2EB.5090908@ti.com>
References: <1389864705-17790-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uLVRpJ1Oiao62QOMbGwG0vsvw3RQemL4I"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36471 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbaAPNrg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 16 Jan 2014 08:47:36 -0500
In-Reply-To: <1389864705-17790-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, mark.rutland@arm.com, durgadoss.r@intel.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, linux-pm@vger.kernel.org

--uLVRpJ1Oiao62QOMbGwG0vsvw3RQemL4I
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 16-01-2014 05:31, Wei Ni wrote:
> The Linux thermal framework support to change thermal governor
> policy in userspace, but it can't show what available policies
> supported.
>=20
> This patch adds available_policies attribute to the thermal
> framework, it can list the thermal governors which can be
> used for a particular zone. This attribute is read only.
>=20
> Change-Id: I63c25d0dba38ad8357265afceea59bbf336cde13

Remove gerrit IDs.

> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  Documentation/thermal/sysfs-api.txt |    6 ++++++
>  drivers/thermal/thermal_core.c      |   28 +++++++++++++++++++++++++++=
+
>  2 files changed, 34 insertions(+)
>=20
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/therma=
l/sysfs-api.txt
> index 87519cb..fe69bce 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -172,6 +172,7 @@ Thermal zone device sys I/F, created once it's regi=
stered:
>      |---temp:			Current temperature
>      |---mode:			Working mode of the thermal zone
>      |---policy:			Thermal governor used for this zone
> +    |---available_policies	Available thermal governors for this zone
>      |---trip_point_[0-*]_temp:	Trip point temperature
>      |---trip_point_[0-*]_type:	Trip point type
>      |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
> @@ -238,6 +239,10 @@ policy
>  	One of the various thermal governors used for a particular zone.
>  	RW, Required
> =20
> +available_policies
> +	Availabe thermal governors which can be used for a particular zone.

s/Availabe/Available/g

> +	RO, Required
> +
>  trip_point_[0-*]_temp
>  	The temperature above which trip point will be fired.
>  	Unit: millidegree Celsius
> @@ -330,6 +335,7 @@ method, the sys I/F structure will be built like th=
is:
>      |---temp:			37000
>      |---mode:			enabled
>      |---policy:			step_wise
> +    |---available_policies:	step_wise fair_share
>      |---trip_point_0_temp:	100000
>      |---trip_point_0_type:	critical
>      |---trip_point_1_temp:	80000
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> index 338a88b..fc9b2ae 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -761,6 +761,27 @@ policy_show(struct device *dev, struct device_attr=
ibute *devattr, char *buf)
>  	return sprintf(buf, "%s\n", tz->governor->name);
>  }
> =20
> +static ssize_t
> +available_policies_show(struct device *dev, struct device_attribute *d=
evattr,
> +			char *buf)
> +{
> +	struct thermal_governor *pos;
> +	ssize_t count =3D 0;
> +	ssize_t size;
> +
> +	mutex_lock(&thermal_governor_lock);
> +
> +	list_for_each_entry(pos, &thermal_governor_list, governor_list) {
> +		size =3D PAGE_SIZE - count;
> +		count +=3D scnprintf(buf + count, size, "%s ", pos->name);
> +	}
> +	count +=3D scnprintf(buf + count, size, "\n");
> +
> +	mutex_unlock(&thermal_governor_lock);
> +
> +	return count;
> +}
> +
>  #ifdef CONFIG_THERMAL_EMULATION
>  static ssize_t
>  emul_temp_store(struct device *dev, struct device_attribute *attr,
> @@ -794,6 +815,7 @@ static DEVICE_ATTR(temp, 0444, temp_show, NULL);
>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
>  static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_s=
tore);
>  static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_stor=
e);
> +static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_sho=
w, NULL);
> =20
>  /* sys I/F for cooling device */
>  #define to_cooling_device(_dev)	\
> @@ -1527,6 +1549,11 @@ struct thermal_zone_device *thermal_zone_device_=
register(const char *type,
>  	if (result)
>  		goto unregister;
> =20
> +	/* Create available_policies attribute */
> +	result =3D device_create_file(&tz->device, &dev_attr_available_polici=
es);
> +	if (result)
> +		goto unregister;
> +
>  	/* Update 'this' zone's governor information */
>  	mutex_lock(&thermal_governor_lock);
> =20
> @@ -1622,6 +1649,7 @@ void thermal_zone_device_unregister(struct therma=
l_zone_device *tz)
>  	if (tz->ops->get_mode)
>  		device_remove_file(&tz->device, &dev_attr_mode);
>  	device_remove_file(&tz->device, &dev_attr_policy);
> +	device_remove_file(&tz->device, &dev_attr_available_policies);
>  	remove_trip_attrs(tz);
>  	tz->governor =3D NULL;
> =20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--uLVRpJ1Oiao62QOMbGwG0vsvw3RQemL4I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLX4usACgkQCXcVR3XQvP2+fwD/elejCFAsWX5KypyjaZnzULMb
03Ue04jxA6DPCDx1XjABAIGmxZgqJfTA/Rw7nNQGQ+97E8hfaOTraMbBGsER4Z/y
=mZEl
-----END PGP SIGNATURE-----

--uLVRpJ1Oiao62QOMbGwG0vsvw3RQemL4I--
