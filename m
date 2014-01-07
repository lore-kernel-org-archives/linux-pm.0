From: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv9 02/20] thermal: introduce device tree parser
Date: Tue, 7 Jan 2014 07:17:11 -0400
Message-ID: <52CBE237.7010309@ti.com>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com> <1384285582-16933-3-git-send-email-eduardo.valentin@ti.com> <52C299A8.4010108@nvidia.com> <52CB6AE2.2090002@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QQO10CeJLtFoWTrX57DohvvG5ThkF2wl3"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52CB6AE2.2090002-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org" <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--QQO10CeJLtFoWTrX57DohvvG5ThkF2wl3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06-01-2014 22:48, Wei Ni wrote:
> Hi, Eduardo
> Will you consider my comments :)

By now Wei, it is better if you start a new thread, by sending a patch
on top of it, as this thread has been already merged by Rui.

>=20
> Thanks.
> Wei.
>=20
> On 12/31/2013 06:17 PM, Wei Ni wrote:
>> On 11/13/2013 03:46 AM, Eduardo Valentin wrote:
>>> This patch introduces a device tree bindings for
>>> describing the hardware thermal behavior and limits.
>>> Also a parser to read and interpret the data and feed
>>> it in the thermal framework is presented.
>>>
>>> This patch introduces a thermal data parser for device
>>> tree. The parsed data is used to build thermal zones
>>> and thermal binding parameters. The output data
>>> can then be used to deploy thermal policies.
>>>
>>> This patch adds also documentation regarding this
>>> API and how to define tree nodes to use
>>> this infrastructure.
>>>
>>> Note that, in order to be able to have control
>>> on the sensor registration on the DT thermal zone,
>>> it was required to allow changing the thermal zone
>>> .get_temp callback. For this reason, this patch
>>> also removes the 'const' modifier from the .ops
>>> field of thermal zone devices.
>>>
>>> ...
>>> +
>>> +static int of_thermal_get_trend(struct thermal_zone_device *tz, int =
trip,
>>> +				enum thermal_trend *trend)
>>> +{
>>> +	struct __thermal_zone *data =3D tz->devdata;
>>> +	long dev_trend;
>>> +	int r;
>>> +
>>> +	if (!data->get_trend)
>>> +		return -EINVAL;
>>> +
>>> +	r =3D data->get_trend(data->sensor_data, &dev_trend);
>> I think the ->get_trend should be defined as:
>> .get_trend(*dev, int, *long)
>> so that the "trip" can be passed into it, otherwise the "trip" can't b=
e
>> used.
>> And the dev_trend should be returned as THERMAL_TREND_XXX directly.
>> because the THERM_TREND_xx is more than three states.
>>
>> The code may be something like:
>> r =3D data->get_trend(data->sensor_data, trip, &dev_trend);
>> if (r)
>>     return r;
>> *trend =3D dev_trend;
>> return 0;
>>> +	if (r)
>>> +		return r;
>>> +
>>> +	/* TODO: These intervals might have some thresholds, but in core co=
de */
>>> +	if (dev_trend > 0)
>>> +		*trend =3D THERMAL_TREND_RAISING;
>>> +	else if (dev_trend < 0)
>>> +		*trend =3D THERMAL_TREND_DROPPING;
>>> +	else
>>> +		*trend =3D THERMAL_TREND_STABLE;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> .....
>>> +
>>> +/***   sensor API   ***/
>>> +
>>> +static struct thermal_zone_device *
>>> +thermal_zone_of_add_sensor(struct device_node *zone,
>>> +			   struct device_node *sensor, void *data,
>>> +			   int (*get_temp)(void *, long *),
>>> +			   int (*get_trend)(void *, long *))
>>> +{
>>> +	struct thermal_zone_device *tzd;
>>> +	struct __thermal_zone *tz;
>>> +
>>> +	tzd =3D thermal_zone_get_zone_by_name(zone->name);
>> I think we could get the thermal zone by node,
>> something like:
>> thermal_zone_get_zone_by_node(zone);
>> so that it can get unique zone.
>>
>> I think we can add a member "struct device_node *np" in the
>> thermal_zone_device,
>> and set it after you call thermal_zone_device_register successfully.
>> Then add following codes:
>> thermal_zone_get_zone_by_node(struct device_node *node)
>> {
>>         struct thermal_zone_device *pos =3D NULL, *ref =3D ERR_PTR(-EN=
ODEV);
>>         bool found =3D false;
>>
>>         if (!node)
>>                 return ERR_PTR(-EINVAL);
>>
>>         mutex_lock(&thermal_list_lock);
>>         list_for_each_entry(pos, &thermal_tz_list, node)
>>                 if (node =3D=3D pos->np) {
>>                         ref =3D pos;
>>                         found =3D true;
>>                         break;
>>                 }
>>         mutex_unlock(&thermal_list_lock);
>>
>>         return ref;
>> }
>>
>> Thanks.
>> Wei.
>>> +	if (IS_ERR(tzd))
>>> +		return ERR_PTR(-EPROBE_DEFER);
>>> +
>>> +	tz =3D tzd->devdata;
>>> +
>>> +	mutex_lock(&tzd->lock);
>>> +	tz->get_temp =3D get_temp;
>>> +	tz->get_trend =3D get_trend;
>>> +	tz->sensor_data =3D data;
>>> +
>>> +	tzd->ops->get_temp =3D of_thermal_get_temp;
>>> +	tzd->ops->get_trend =3D of_thermal_get_trend;
>>> +	mutex_unlock(&tzd->lock);
>>> +
>>> +	return tzd;
>>> +}
>>> +
>>>
>>
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--QQO10CeJLtFoWTrX57DohvvG5ThkF2wl3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF0EAREIAAYFAlLL4joACgkQCXcVR3XQvP2U8QD1E6TvbJV0u44za9EITemByjlk
TeAUjHFGUWZ8kNLg/wD+Igl+Otf8hhNsp1VFlUEPDwFQ1Y5RMdVoDJzRhuJ1pzE=
=LbSD
-----END PGP SIGNATURE-----

--QQO10CeJLtFoWTrX57DohvvG5ThkF2wl3--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
