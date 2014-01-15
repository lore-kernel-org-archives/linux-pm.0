From: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] thermal: introduce thermal_zone_get_zone_by_node
 helper function
Date: Wed, 15 Jan 2014 10:09:00 -0400
Message-ID: <52D6967C.9010305@ti.com>
References: <1389263879-10483-1-git-send-email-wni@nvidia.com> <1389263879-10483-2-git-send-email-wni@nvidia.com> <52D40EC6.6050509@ti.com> <52D512F1.1090008@nvidia.com> <52D5582F.5000807@ti.com> <52D6766D.6080100@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dEVk26m9C9IGfJWFv3iDjGxjxV4QOCvsI"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52D6766D.6080100-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>, "rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--dEVk26m9C9IGfJWFv3iDjGxjxV4QOCvsI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 15-01-2014 07:52, Wei Ni wrote:
> On 01/14/2014 11:30 PM, Eduardo Valentin wrote:
>> * PGP Signed by an unknown key
>>
>> Hello Wei,
>>
>> On 14-01-2014 06:35, Wei Ni wrote:
>>> On 01/14/2014 12:05 AM, Eduardo Valentin wrote:
>>>>> Old Signed by an unknown key
>>>>
>>>> On 09-01-2014 06:37, Wei Ni wrote:
>>>>> The thermal framework start to support device tree, this
>>>>> patch adds a helper function to get a reference of a
>>>>> thermal zone, based on the zone's device node.
>>>>
>>>> I would prefer if you could provide a better justification why we ne=
ed
>>>> this API. Think of the scope of this API: would it be used only by t=
he
>>>> of-thermal code? only by the drivers/thermal code? or any driver?
>>>
>>
>>
>>> I have talked it in the previous patch "Re: [PATCH] thermal: use devi=
ce
>>> node to get thermal zone".
>>
>> Thanks for putting me in the same page
>>
>>
>>> So let me copy to here again:
>>>
>>> On the tegra board, it will use two or more sensors to estimate the s=
kin
>>> temperature by reading temps from these sensors and calculate them.
>>
>> OK. Have you read the Example (c) in the thermal binding document
>> (Documentation/devicetree/bindings/thermal)?
>>
>>> For example, we have two sensors: sensor1 and sensor2. We can registe=
r
>>> them to thermal framework by using DT, something like:
>>> thermal-zones {
>>>                 sensor1: lm90-local {
>>>                       ...
>>>                         thermal-sensors =3D <&lm90 0>;
>>>                 };
>>>
>>>                 sensor2: lm90-remote {
>>>                       ...
>>>                         thermal-sensors =3D <&lm90 1>;
>>>                 };
>>> }
>>
>> where is the descriptor for lm90?
>=20
> There has descriptior for lm90, I didn't post it.
>=20
>>
>> This is actually not how it is supposed to be described.
>>
>>>
>>> Then I will add a device node for my skin temperature driver, somethi=
ng
>>> like:
>>> skin_temp {
>>>       ...
>>>       #thermal-sensor-cells =3D <0>;
>>>
>>>       sub-devs {
>>>               dev@0 {
>>>                       dev =3D <&sensor1>;
>>>               };
>>>
>>>               dev@1 {
>>>                       dev =3D <&sensor2>;
>>>               };
>>>       };
>>> };
>>
>> What is the above? A virtual device?
>=20
> Yes, it is the node for the skin temperature estimator driver.
>=20
>>
>> I believe the above is not really part of the thermal bindings.
>>
>>> So I can parse the DT in the skin temperature driver to get the nodes=
 of
>>> the sensor1 and sensor2, and can use .*get_by_node to get thermal zon=
e
>>> device, then use .get_temp() and other callbacks to get temperature a=
nd
>>> other information.
>>>
>>
>> The above is a different binding and different API then of what has be=
en
>> discussed last year for thermal bindings. I am copying here the existi=
ng
>> example:
>>
>> #include <dt-bindings/thermal/thermal.h>
>>
>> &i2c1 {
>>         ...
>>         /*
>>          * A simple IC with a single temperature sensor.
>>          */
>>         adc: sensor@0x49 {
>>                 ...
>>                 #thermal-sensor-cells =3D <0>;
>>         };
>> };
>>
>> ocp {
>>         ...
>>         /*
>>          * A simple IC with a single bandgap temperature sensor.
>>          */
>>         bandgap0: bandgap@0x0000ED00 {
>>                 ...
>>                 #thermal-sensor-cells =3D <0>;
>>         };
>> };
>>
>> thermal-zones {
>>         cpu-thermal: cpu-thermal {
>>                 polling-delay-passive =3D <250>; /* milliseconds */
>>                 polling-delay =3D <1000>; /* milliseconds */
>>
>>                 thermal-sensors =3D <&bandgap0>,  /* cpu */
>>                                   <&adc>;       /* pcb north */
>>
>>                 /* hotspot =3D 100 * bandgap - 120 * adc + 484 */
>>                 coefficients =3D          <100    -120    484>;
>>
>>                 trips {
>>                         ...
>>                 };
>>
>>                 cooling-maps {
>>                         ...
>>                 };
>>         };
>> };
>>
>>
>>
>> The idea is to have a producer-> consumer description, in which the
>> thermal zone is the consumer and the sensors are the producers (for
>> temperature at least).
>>
>> What is the relation between the sensors you have?
>>
>> Why the above structure cannot cover for your case? Here is what you
>> would do to describe your case:
>=20
> Yes, I noticed that you have this sample in the documents, but it seems=

> the of-thermal only support one sensor in the thermal-sensors list, and=

> didn't handle the coefficients yet.
> And in my skin temperature estimator driver, it will have more complex
> logic to estimate the temperature, it will consider the history
> temperatures, and have coefficients for every history temp, it seems
> can't use your coefficients easily.

Is it possible to disclose what is the real equation you are using to
populate your virtual sensor?  In this way we can either discuss how to
implement it using the existing API or propose the correct improvements.

I am considering posting a series of statistical treatment for the
thermal framework.

>=20
>>
>> /*
>>  * You did not specify which type of sensors, so I am assuming
>>  * they are I2C sensors
>>  */
>> &i2c1 {
>>                  lm90: sensor@48 {
>>                         ...
>>                          #thermal-sensor-cells =3D <1>;
>>                  };
>> };
>>
>> thermal-zones {
>>         skin-hotspot: skin-hotspot {
>>                 polling-delay-passive =3D <2000>; /* put the right val=
 */
>>                 polling-delay =3D <1000>; /* put the right val */
>>
>>                 thermal-sensors =3D <&lm90 0>,    /* local */
>>                                   <&lm90 1>;    /* remote */
>>
>>                 /* hotspot ?
>>                  * What is the relation that describes your sensors?
>>                  * coefficients =3D  <A_0 A_1>; you have to fill the c=
oef.
>>                  */
>>
>>                 trips {
>>                         ...
>>                 };
>>
>>                 cooling-maps {
>>                         ...
>>                 };
>>         };
>> };
>>
>> So, the idea is so that you define your sensor nodes and the respectiv=
e
>> drivers, in the above example the i2c drivers, will probe them. When
>> creating thermal zones, you have to specify the list of sensors by
>> linking using phandles + sensor specifier, as documented in the therma=
l
>> binding text.
>>
>>>>
>>>> So far you have provided only one user, and that user can already wo=
rk
>>>> with existing APIs. As I mention, DT does not support name duplicati=
ons.
>>>
>>> If the system only have the DT, then there will not have name
>>> duplications. But some drivers will call the
>>> thermal_zone_device_register directly with any thermal zone type, and=
 at
>>> same time, other drivers may use of-thermal to register, and set the
>>> same name in the DT. Then if use the *.get_by_name, it can't get the
>>> uniqu one.
>>
>> The above example is odd to me. Why would a driver be registering zone=
s
>> from DT and from in kernel definition? The usual path is to have eithe=
r
>> one or the other. Even if you are migrating your system to DT based
>> booting, you may have a mix of devices that are probed via DT and othe=
rs
>> that are probed via board files, but one single driver probing both, I=

>> think this is unusual.
>>
>>>
>>>>
>>>> Unless you enlighten  me with better uses of this API, I would prefe=
r
>>>> not to have it.
>>>>
>>>>
>>>>>
>>>>> It will add a device_node *np member in the struct
>>>>> thermal_zone_device, and initialize it when create a thermal
>>>>> zone. This funciton perform a zone device node lookup and
>>>>> return a reference to a thermal zone device that matches
>>>>> the device node requested.
>>>>> In case the zone is not found or if the required parameters
>>>>> are invalid, it will return the corresponding error code (ERR_PTR).=

>>>>>
>>>>> Change-Id: I4d65f849e84425dddd387f70886a9c7c4c2002f2
>>>>
>>>> For your next patches, please done include gerrit change IDs. Linux
>>>> Kernel does not need to be linked to your inhouse development histor=
y
>>>> via gerrit IDs.
>>>
>>> It's so sorry, I forgot to remove it.
>>>
>>>>
>>>>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>>> ---
>>>>>  drivers/thermal/of-thermal.c   |    2 ++
>>>>>  drivers/thermal/thermal_core.c |   33 ++++++++++++++++++++++++++++=
+++++
>>>>>  include/linux/thermal.h        |    3 +++
>>>>>  3 files changed, 38 insertions(+)
>>>>>
>>>>> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-ther=
mal.c
>>>>> index 04b1be7..53f2d3a 100644
>>>>> --- a/drivers/thermal/of-thermal.c
>>>>> +++ b/drivers/thermal/of-thermal.c
>>>>> @@ -804,6 +804,8 @@ int __init of_parse_thermal_zones(void)
>>>>>                     of_thermal_free_zone(tz);
>>>>>                     /* attempting to build remaining zones still */=

>>>>>             }
>>>>> +
>>>>> +           zone->np =3D child;
>>>>>     }
>>>>>
>>>>>     return 0;
>>>>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/therm=
al_core.c
>>>>> index 338a88b..eeddb94 100644
>>>>> --- a/drivers/thermal/thermal_core.c
>>>>> +++ b/drivers/thermal/thermal_core.c
>>>>> @@ -1672,6 +1672,39 @@ exit:
>>>>>  }
>>>>>  EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
>>>>>
>>>>> +/**
>>>>> +* thermal_zone_get_zone_by_node() - search for a zone and returns =
its ref
>>>>> +* @node: device node of the thermal zone
>>>>> +*
>>>>> +* When thermal zone is found with the passed device node, returns =
a reference
>>>>> +* to it.
>>>>> +*
>>>>> +* Return: On success returns a reference to an unique thermal zone=
 with
>>>>> +* matching device node, an ERR_PTR otherwise (-EINVAL for invalid
>>>>> +* paramenters, -ENODEV for not found).
>>>>> +*/
>>>>> +struct thermal_zone_device *
>>>>> +thermal_zone_get_zone_by_node(struct device_node *node)
>>>>> +{
>>>>> +   struct thermal_zone_device *pos =3D NULL, *ref =3D ERR_PTR(-ENO=
DEV);
>>>>> +   bool found =3D false;
>>>>> +
>>>>> +   if (!node)
>>>>> +           return ERR_PTR(-EINVAL);
>>>>> +
>>>>> +   mutex_lock(&thermal_list_lock);
>>>>> +   list_for_each_entry(pos, &thermal_tz_list, node)
>>>>> +           if (node =3D=3D pos->np) {
>>>>> +                   ref =3D pos;
>>>>> +                   found =3D true;
>>>>> +                   break;
>>>>> +           }
>>>>> +   mutex_unlock(&thermal_list_lock);
>>>>> +
>>>>> +   return ref;
>>>>> +}
>>>>> +EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_node);
>>>>> +
>>>>>  #ifdef CONFIG_NET
>>>>>  static const struct genl_multicast_group thermal_event_mcgrps[] =3D=
 {
>>>>>     { .name =3D THERMAL_GENL_MCAST_GROUP_NAME, },
>>>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>>>> index f7e11c7..288d272 100644
>>>>> --- a/include/linux/thermal.h
>>>>> +++ b/include/linux/thermal.h
>>>>> @@ -162,6 +162,7 @@ struct thermal_zone_device {
>>>>>     int id;
>>>>>     char type[THERMAL_NAME_LENGTH];
>>>>>     struct device device;
>>>>> +   struct device_node *np;
>>>>>     struct thermal_attr *trip_temp_attrs;
>>>>>     struct thermal_attr *trip_type_attrs;
>>>>>     struct thermal_attr *trip_hyst_attrs;
>>>>> @@ -286,6 +287,8 @@ thermal_of_cooling_device_register(struct devic=
e_node *np, char *, void *,
>>>>>                                const struct thermal_cooling_device_=
ops *);
>>>>>  void thermal_cooling_device_unregister(struct thermal_cooling_devi=
ce *);
>>>>>  struct thermal_zone_device *thermal_zone_get_zone_by_name(const ch=
ar *name);
>>>>> +struct thermal_zone_device *
>>>>> +thermal_zone_get_zone_by_node(struct device_node *node);
>>>>>  int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned=
 long *temp);
>>>>>
>>>>>  int get_tz_trend(struct thermal_zone_device *, int);
>>>>>
>>>>
>>>>
>>>
>>>
>>>
>>
>>
>> --
>> You have got to be excited about what you are doing. (L. Lamport)
>>
>> Eduardo Valentin
>>
>>
>> * Unknown Key
>> * 0x75D0BCFD
>>
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--dEVk26m9C9IGfJWFv3iDjGxjxV4QOCvsI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLWlnwACgkQCXcVR3XQvP1JtwD+Mtcku+cCCvZF6xEMJ63N/jrS
/W7w4Xr9n/Z2lfsrmskBAO/5+/F4vgU60sRZ7tTCTtrYS4uv9CO6kgkPqdqjzCOk
=cYI/
-----END PGP SIGNATURE-----

--dEVk26m9C9IGfJWFv3iDjGxjxV4QOCvsI--
