From: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] thermal: use device node to get thermal zone
Date: Wed, 8 Jan 2014 08:31:41 -0400
Message-ID: <52CD452D.3080508@ti.com>
References: <1389172011-32107-1-git-send-email-wni@nvidia.com> <4D68720C2E767A4AA6A8796D42C8EB59E09ED1@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6w8gpPrqBLgFkCN8cwrWXdJHIqOWlxURL"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB59E09ED1-yHIBzpp8AekElmVAvsQTrbfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "R, Durgadoss" <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "eduardo.valentin-l0cyMroinI0@public.gmane.org" <eduardo.valentin-l0cyMroinI0@public.gmane.org>, "Zhang, Rui" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--6w8gpPrqBLgFkCN8cwrWXdJHIqOWlxURL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08-01-2014 07:10, R, Durgadoss wrote:
> Hi Wei,
>=20
>> -----Original Message-----
>> From: linux-pm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-pm-
>> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Wei Ni
>> Sent: Wednesday, January 08, 2014 2:37 PM
>> To: eduardo.valentin-l0cyMroinI0@public.gmane.org; Zhang, Rui; mark.rutland-5wv7dgnIgG8@public.gmane.org
>> Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org; swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org; linux-
>> pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wei Ni
>> Subject: [PATCH] thermal: use device node to get thermal zone
>>
>> If use name to get the thermal zone, sometimes it can't
>> get the unique thermal zone, because the thermal fw support
>> same name for different thermal zone.
>> So we can change to use device node to get thermal zone.

Please check the documentation for .*by_name function. There is an error
code for the case of multiple instances. In fact, it is designed to be
used by users who know that in the system there is going to exist only
one zone with that name.

I don't think it is correct to simply remove the existing API and
enforce DT usage. What if the system does not use DT?

>=20
> Eduardo introduced this API because we wanted to get the
> tzd pointer by using the name. So, for your case, can you
> introduce a new API *get_by_node instead of changing this
> API ?

Agreed, if you need a search by DT node, then you need to provide the
use cases and propose a new one.

>=20
> Thanks,
> Durga
>=20
>>
>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/thermal/of-thermal.c   |    6 ++++--
>>  drivers/thermal/thermal_core.c |   37 ++++++++++++++++---------------=
------
>>  include/linux/thermal.h        |    4 +++-
>>  3 files changed, 23 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal=
=2Ec
>> index 04b1be7..97c12cf 100644
>> --- a/drivers/thermal/of-thermal.c
>> +++ b/drivers/thermal/of-thermal.c
>> @@ -330,7 +330,7 @@ thermal_zone_of_add_sensor(struct device_node *zon=
e,
>>  	struct thermal_zone_device *tzd;
>>  	struct __thermal_zone *tz;
>>
>> -	tzd =3D thermal_zone_get_zone_by_name(zone->name);
>> +	tzd =3D thermal_zone_get_zone_by_node(zone);

In DT, nodes have unique names. Are you seen a problem with the above cod=
e?

>>  	if (IS_ERR(tzd))
>>  		return ERR_PTR(-EPROBE_DEFER);
>>
>> @@ -804,6 +804,8 @@ int __init of_parse_thermal_zones(void)
>>  			of_thermal_free_zone(tz);
>>  			/* attempting to build remaining zones still */
>>  		}
>> +
>> +		zone->np =3D child;
>>  	}
>>
>>  	return 0;
>> @@ -837,7 +839,7 @@ void of_thermal_destroy_zones(void)
>>  	for_each_child_of_node(np, child) {
>>  		struct thermal_zone_device *zone;
>>
>> -		zone =3D thermal_zone_get_zone_by_name(child->name);
>> +		zone =3D thermal_zone_get_zone_by_node(child);
>>  		if (IS_ERR(zone))
>>  			continue;
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_=
core.c
>> index 338a88b..89e0637 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -1635,42 +1635,37 @@ void thermal_zone_device_unregister(struct
>> thermal_zone_device *tz)
>>  EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
>>
>>  /**
>> - * thermal_zone_get_zone_by_name() - search for a zone and returns it=
s ref
>> - * @name: thermal zone name to fetch the temperature
>> + * thermal_zone_get_zone_by_node() - search for a zone and returns it=
s ref
>> + * @node: device node of the thermal zone
>>   *
>> - * When only one zone is found with the passed name, returns a refere=
nce to it.
>> + * When thermal zone is found with the passed device node, returns a
>> reference
>> + * to it.
>>   *
>>   * Return: On success returns a reference to an unique thermal zone w=
ith
>> - * matching name equals to @name, an ERR_PTR otherwise (-EINVAL for i=
nvalid
>> - * paramenters, -ENODEV for not found and -EEXIST for multiple matche=
s).
>> + * matching device node, an ERR_PTR otherwise (-EINVAL for invalid
>> + * paramenters, -ENODEV for not found).
>>   */
>> -struct thermal_zone_device *thermal_zone_get_zone_by_name(const char
>> *name)
>> +struct thermal_zone_device *
>> +thermal_zone_get_zone_by_node(struct device_node *node)
>>  {

You are removing an API, are you checking that all existing users of
this API are changed accordingly? I don't think so.

>> -	struct thermal_zone_device *pos =3D NULL, *ref =3D ERR_PTR(-EINVAL);=

>> -	unsigned int found =3D 0;
>> +	struct thermal_zone_device *pos =3D NULL, *ref =3D ERR_PTR(-ENODEV);=

>> +	bool found =3D false;
>>
>> -	if (!name)
>> -		goto exit;
>> +	if (!node)
>> +		return ERR_PTR(-EINVAL);
>>
>>  	mutex_lock(&thermal_list_lock);
>>  	list_for_each_entry(pos, &thermal_tz_list, node)
>> -		if (!strnicmp(name, pos->type, THERMAL_NAME_LENGTH)) {
>> -			found++;
>> +		if (node =3D=3D pos->np) {
>>  			ref =3D pos;
>> +			found =3D true;
>> +			break;
>>  		}
>>  	mutex_unlock(&thermal_list_lock);
>>
>> -	/* nothing has been found, thus an error code for it */
>> -	if (found =3D=3D 0)
>> -		ref =3D ERR_PTR(-ENODEV);
>> -	else if (found > 1)
>> -	/* Success only when an unique zone is found */
>> -		ref =3D ERR_PTR(-EEXIST);
>> -
>> -exit:
>>  	return ref;
>>  }
>> -EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
>> +EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_node);
>>
>>  #ifdef CONFIG_NET
>>  static const struct genl_multicast_group thermal_event_mcgrps[] =3D {=

>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index f7e11c7..a94de8c 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -162,6 +162,7 @@ struct thermal_zone_device {
>>  	int id;
>>  	char type[THERMAL_NAME_LENGTH];
>>  	struct device device;
>> +	struct device_node *np;

Please describe better if you want to add this node in here. Better to
add it in a separated patch.

>>  	struct thermal_attr *trip_temp_attrs;
>>  	struct thermal_attr *trip_type_attrs;
>>  	struct thermal_attr *trip_hyst_attrs;
>> @@ -285,7 +286,8 @@ struct thermal_cooling_device *
>>  thermal_of_cooling_device_register(struct device_node *np, char *, vo=
id *,
>>  				   const struct thermal_cooling_device_ops *);
>>  void thermal_cooling_device_unregister(struct thermal_cooling_device =
*);
>> -struct thermal_zone_device *thermal_zone_get_zone_by_name(const char
>> *name);
>> +struct thermal_zone_device *
>> +thermal_zone_get_zone_by_node(struct device_node *node);
>>  int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned lo=
ng
>> *temp);
>>
>>  int get_tz_trend(struct thermal_zone_device *, int);
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in=

>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--6w8gpPrqBLgFkCN8cwrWXdJHIqOWlxURL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLNRS0ACgkQCXcVR3XQvP0vhAD9GhnTt2GEhqJDiLpBPZD0PpTR
dmj5+Kdidob+wT3QEfwA/0C1JLewojcIGib/1YtSLP4Pv1TaWWOi8uQjRPHYMoea
=sGyl
-----END PGP SIGNATURE-----

--6w8gpPrqBLgFkCN8cwrWXdJHIqOWlxURL--
