From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 4/4] thermal: show the sub thermal zones in sysfs
Date: Wed, 16 Mar 2016 15:06:23 -0700
Message-ID: <20160316220621.GA4360@localhost.localdomain>
References: <1448464186-26289-1-git-send-email-javi.merino@arm.com>
 <1448464186-26289-5-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35396 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965067AbcCPWGZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 18:06:25 -0400
Content-Disposition: inline
In-Reply-To: <1448464186-26289-5-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rui.zang@intel.com, Zhang Rui <rui.zhang@intel.com>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A couple of size checks:

On Wed, Nov 25, 2015 at 03:09:46PM +0000, Javi Merino wrote:
> When a thermal zone is created that has sub thermal zones via
> devicetree or via thermal_zone_add_subtz() expose that relationship in
> sysfs.
>=20
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
>  Documentation/thermal/sysfs-api.txt |  33 ++++++++++
>  drivers/thermal/thermal_core.c      | 125 ++++++++++++++++++++++++++++++=
++++++
>  include/linux/thermal.h             |   3 +
>  3 files changed, 161 insertions(+)
>=20
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/=
sysfs-api.txt
> index dda24a0bdeec..5636a531f0b1 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -219,11 +219,16 @@ Thermal zone device sys I/F, created once it's regi=
stered:
>      |---temp:			Current temperature
>      |---mode:			Working mode of the thermal zone
>      |---policy:			Thermal governor used for this zone
> +    |---aggregation_function:	Function to use when aggregating the
> +				temperature of this zone's slave thermal zones
>      |---available_policies:	Available thermal governors for this zone
>      |---trip_point_[0-*]_temp:	Trip point temperature
>      |---trip_point_[0-*]_type:	Trip point type
>      |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
>      |---emul_temp:		Emulated temperature set node
> +    |---subtz[0-*]:		Slave thermal zones of this thermal zone
> +    |---subtz[0-*]_weight:	Weight of the slave thermal zone on
> +				this thermal zone
>      |---sustainable_power:      Sustainable dissipatable power
>      |---k_po:                   Proportional term during temperature ove=
rshoot
>      |---k_pu:                   Proportional term during temperature und=
ershoot
> @@ -296,6 +301,19 @@ policy
>  	One of the various thermal governors used for a particular zone.
>  	RW, Required
> =20
> +aggregation_function
> +	The aggregation function used to calculate the temperature of
> +	this thermal zone when it has sub thermal zones.  It can
> +	either be "max" or "weighted_average".  If it's "max", the
> +	temperature of this thermal zone is the maximum of the
> +	temperatures of the sub thermal zones.  If
> +	aggregation_function is "weighted_average", the temperature of
> +	this thermal zone is the weighted average of the temperatures
> +	of the sub thermal zones.  The weights are specified in
> +	subtz[0-*]_weights.  The aggregation_function sysfs entry
> +	doesn't exist for thermal zones without sub thermal zones.
> +	RW, Optional
> +
>  available_policies
>  	Available thermal governors which can be used for a particular zone.
>  	RO, Required
> @@ -359,6 +377,21 @@ emul_temp
>  	  because userland can easily disable the thermal policy by simply
>  	  flooding this sysfs node with low temperature values.
> =20
> +subtz[0-*]
> +	sysfs link to the slave thermal zone device.
> +	RO, Optional
> +
> +subtz[0-*]_weight
> +	The influence of subtz[0-*] in this thermal zone.  This
> +	parameter is only used when using "weighted_average" as the
> +	aggregation_function.  When calculating the temperature of
> +	this thermal zone, the temperature of each of the thermal
> +	zone's slaves is multiplied by its weight.  The result is
> +	divided by the sum of all weights.  If all weights are 0,
> +	the temperature of this thermal zone is the average of the
> +	temperatures of the sub thermal zones.
> +	RW, Optional
> +
>  sustainable_power
>  	An estimate of the sustained power that can be dissipated by
>  	the thermal zone. Used by the power allocator governor. For
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 98bdb63b3b95..2bb1af0a9349 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -63,14 +63,23 @@ static struct thermal_governor *def_governor;
> =20
>  /**
>   * struct thermal_zone_link - a link between "master" and "slave" therma=
l zones
> + * @id:		link number in the master thermal zone
> + * @name:	filename in the master thermal zone's sysfs directory
>   * @weight:	weight of the @slave thermal zone in the master
>   *		calculation.  Used when the master thermal zone's
>   *		aggregation function is THERMAL_AGG_WEIGHTED_AVG
> + * @weight_attr_name:	filename of the weight attribute in the master's t=
hermal
> + *			zone sysfs directory
> + * @weight_attr:	device attribute for the weight entry in sysfs
>   * @slave:	pointer to the slave thermal zone
>   * @node:	list node in the master thermal zone's slave_tzs list.
>   */
>  struct thermal_zone_link {
> +	int id;
> +	char name[THERMAL_NAME_LENGTH];
>  	int weight;
> +	char weight_attr_name[THERMAL_NAME_LENGTH];
> +	struct device_attribute weight_attr;
>  	struct thermal_zone_device *slave;
>  	struct list_head node;
>  };
> @@ -990,6 +999,45 @@ emul_temp_store(struct device *dev, struct device_at=
tribute *attr,
>  static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
> =20
>  static ssize_t
> +agg_func_show(struct device *dev, struct device_attribute *devattr, char=
 *buf)
> +{
> +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> +
> +	if (tz->slave_agg_function =3D=3D THERMAL_AGG_MAX)
> +		return sprintf(buf, "max\n");
> +	else if (tz->slave_agg_function =3D=3D THERMAL_AGG_WEIGHTED_AVG)
> +		return sprintf(buf, "weighted_average\n");
> +	else
> +		return sprintf(buf, "(invalid)\n");

Do we need to check for buf size (snprintf)?


> +}
> +
> +static ssize_t
> +agg_func_store(struct device *dev, struct device_attribute *attr,
> +	       const char *buf, size_t count)
> +{
> +	int ret =3D 0;
> +	struct thermal_zone_device *tz =3D to_thermal_zone(dev);
> +	char func_name[THERMAL_NAME_LENGTH];
> +
> +	snprintf(func_name, sizeof(func_name), "%s", buf);
> +
> +	mutex_lock(&tz->lock);
> +
> +	if (sysfs_streq(func_name, "max"))
> +		tz->slave_agg_function =3D THERMAL_AGG_MAX;
> +	else if (sysfs_streq(func_name, "weighted_average"))
> +		tz->slave_agg_function =3D THERMAL_AGG_WEIGHTED_AVG;
> +	else
> +		ret =3D -EINVAL;
> +
> +	mutex_unlock(&tz->lock);
> +
> +	return ret ? ret : count;
> +}
> +static DEVICE_ATTR(aggregation_function, S_IRUGO | S_IWUSR, agg_func_sho=
w,
> +		   agg_func_store);
> +
> +static ssize_t
>  sustainable_power_show(struct device *dev, struct device_attribute *deva=
ttr,
>  		       char *buf)
>  {
> @@ -1305,6 +1353,35 @@ thermal_cooling_device_weight_store(struct device =
*dev,
> =20
>  	return count;
>  }
> +
> +static ssize_t
> +thermal_subtz_weight_show(struct device *dev, struct device_attribute *a=
ttr,
> +			  char *buf)
> +{
> +	struct thermal_zone_link *link;
> +
> +	link =3D container_of(attr, struct thermal_zone_link, weight_attr);
> +
> +	return sprintf(buf, "%d\n", link->weight);
> +}
> +
> +static ssize_t
> +thermal_subtz_weight_store(struct device *dev, struct device_attribute *=
attr,
> +			   const char *buf, size_t count)
> +{
> +	struct thermal_zone_link *link;
> +	int ret, weight;
> +
> +	ret =3D kstrtoint(buf, 0, &weight);
> +	if (ret)
> +		return ret;
> +
> +	link =3D container_of(attr, struct thermal_zone_link, weight_attr);
> +	link->weight =3D weight;
> +
> +	return count;
> +}
> +
>  /* Device management */
> =20
>  /**
> @@ -2135,6 +2212,47 @@ int thermal_zone_add_subtz(struct thermal_zone_dev=
ice *tz,
>  	link->weight =3D weight;
>  	list_add_tail(&link->node, &tz->slave_tzs);
> =20
> +	if (list_is_singular(&tz->slave_tzs)) {
> +		ret =3D device_create_file(&tz->device,
> +					 &dev_attr_aggregation_function);
> +		if (ret)
> +			pr_warn("Failed to create aggregation_function sysfs file: %d\n",
> +				ret);
> +			/*
> +			 * Fall through: we failed to create the sysfs file, but
> +			 * it's not fatal
> +			 */
> +	}
> +
> +	ret =3D get_idr(&tz->link_idr, NULL, &link->id);
> +	if (ret) {
> +		/*
> +		 * Even if we can't create the symlink in sysfs,
> +		 * we've linked the thermal zones, so return success
> +		 */
> +		ret =3D 0;
> +		goto unlock;
> +	}
> +
> +	snprintf(link->name, ARRAY_SIZE(link->name), "subtz%d", link->id);
> +	ret =3D sysfs_create_link(&tz->device.kobj, &subtz->device.kobj,
> +				link->name);
> +	if (ret)
> +		pr_warn("Failed to create symlink to sub thermal zone: %d\n",
> +			ret);
> +
> +	snprintf(link->weight_attr_name, THERMAL_NAME_LENGTH, "subtz%d_weight",
> +		 link->id);

please use sizeof(link->weight_att_name) instead of THERMAL_NAME_LENGTH.

> +	sysfs_attr_init(&link->weight_attr.attr);
> +	link->weight_attr.attr.name =3D link->weight_attr_name;
> +	link->weight_attr.attr.mode =3D S_IWUSR | S_IRUGO;
> +	link->weight_attr.show =3D thermal_subtz_weight_show;
> +	link->weight_attr.store =3D thermal_subtz_weight_store;
> +	ret =3D device_create_file(&tz->device, &link->weight_attr);
> +	if (ret)
> +		pr_warn("Failed to create sub thermal zone weight: %d\n",
> +			ret);
> +
>  	ret =3D 0;
> =20
>  unlock:
> @@ -2166,6 +2284,10 @@ int thermal_zone_del_subtz(struct thermal_zone_dev=
ice *tz,
> =20
>  	list_for_each_entry(link, &tz->slave_tzs, node) {
>  		if (link->slave =3D=3D subtz) {
> +			device_remove_file(&tz->device, &link->weight_attr);
> +			sysfs_remove_link(&tz->device.kobj, link->name);
> +			release_idr(&tz->link_idr, NULL, link->id);
> +
>  			list_del(&link->node);
>  			kfree(link);
> =20
> @@ -2174,6 +2296,9 @@ int thermal_zone_del_subtz(struct thermal_zone_devi=
ce *tz,
>  		}
>  	}
> =20
> +	if (list_empty(&tz->slave_tzs))
> +		device_remove_file(&tz->device, &dev_attr_aggregation_function);
> +
>  	mutex_unlock(&tz->lock);
> =20
>  	return ret;
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index dc3d2ab77ab6..f14884353230 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -192,6 +192,8 @@ struct thermal_attr {
>   * @thermal_instances:	list of &struct thermal_instance of this thermal =
zone
>   * @idr:	&struct idr to generate unique id for this zone's cooling
>   *		devices
> + * @link_idr:	&struct idr to generate unique ids for this zone's links to
> + *		other thermal zones
>   * @lock:	lock to protect thermal_instances list
>   * @node:	node in thermal_tz_list (in thermal_core.c)
>   * @poll_queue:	delayed work for polling
> @@ -221,6 +223,7 @@ struct thermal_zone_device {
>  	void *governor_data;
>  	struct list_head thermal_instances;
>  	struct idr idr;
> +	struct idr link_idr;
>  	struct mutex lock;
>  	struct list_head node;
>  	struct delayed_work poll_queue;
> --=20
> 1.9.1
>=20

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW6djYAAoJEMLUO4d9pOJWRUIH/13hn2sQ8TSWe4jBDuLts1kW
weQQJALdH1ga1Fmpmyrb9in29DJbipvbE2ENLUgQYLFtrqn9w/A66gjTDFfujwAR
IEXt5U942glcQIue/PO7CHHIED5AIcXUyzn5AN3CGRkMbxCaQUGxwPRKaZgglT9D
/FCfSg9tWvu3zfOBcGmouyjK/4eahqhZXyu0hyZTzvvP9hFSV07wpE8c9GTNHFW5
NpQcEbQe3fQxAt/NR7stkvL08jUjQ1dmsLZtPEiMeVzSoAZAel2eirPR5Hrkj88A
WXLaTdm1csKZbfgCGctlbcACK/bWbDGbbsVChCwISekp5ptRr8SF/DrEqO7iWjw=
=Oeq4
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
