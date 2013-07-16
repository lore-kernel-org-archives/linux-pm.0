From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 3/4] thermal: ti-soc-thermal: use thermal DT infrastructure
Date: Tue, 16 Jul 2013 09:29:44 -0400
Message-ID: <51E54AC8.2040400@ti.com>
References: <1373378414-28086-1-git-send-email-eduardo.valentin@ti.com>    <1373378414-28086-4-git-send-email-eduardo.valentin@ti.com>    <loom.20130715T124843-388@post.gmane.org> <51E3EC2C.2030803@ti.com>   <1373893198.4172.28.camel@weser.hi.pengutronix.de>   <51E3F864.1060000@ti.com> <51E3FAE7.3090609@ti.com>  <1373897120.4172.57.camel@weser.hi.pengutronix.de> <51E403D7.30506@ti.com> <1373968492.4267.9.camel@weser.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2MJIBJHUPHOWGXWHTUAFH"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50020 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932450Ab3GPN37 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2013 09:29:59 -0400
In-Reply-To: <1373968492.4267.9.camel@weser.hi.pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org

------enig2MJIBJHUPHOWGXWHTUAFH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Lucas,

On 16-07-2013 05:54, Lucas Stach wrote:
> Hi Eduardo,
>=20
> Am Montag, den 15.07.2013, 10:14 -0400 schrieb Eduardo Valentin:
>> On 15-07-2013 10:05, Lucas Stach wrote:
>>> Am Montag, den 15.07.2013, 09:36 -0400 schrieb Eduardo Valentin:
>>> [...]
>>>>
>>>>
>>>> as simple as the following:
>>>> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufre=
q-cpu0.c
>>>> index 3ab8294..486881c 100644
>>>> --- a/drivers/cpufreq/cpufreq-cpu0.c
>>>> +++ b/drivers/cpufreq/cpufreq-cpu0.c
>>>> @@ -20,6 +20,9 @@
>>>>  #include <linux/platform_device.h>
>>>>  #include <linux/regulator/consumer.h>
>>>>  #include <linux/slab.h>
>>>> +#include <linux/thermal.h>
>>>> +#include <linux/cpu_cooling.h>
>>>> +#include <linux/cpumask.h>
>>>>
>>>>  static unsigned int transition_latency;
>>>>  static unsigned int voltage_tolerance; /* in percentage */
>>>> @@ -28,6 +31,7 @@ static struct device *cpu_dev;
>>>>  static struct clk *cpu_clk;
>>>>  static struct regulator *cpu_reg;
>>>>  static struct cpufreq_frequency_table *freq_table;
>>>> +static struct thermal_cooling_device *cdev;
>>>>
>>>>  static int cpu0_verify_speed(struct cpufreq_policy *policy)
>>>>  {
>>>> @@ -256,6 +260,9 @@ static int cpu0_cpufreq_probe(struct platform_de=
vice
>>>> *pdev)
>>>>                 goto out_free_table;
>>>>         }
>>>>
>>>> +       if (!of_property_read_bool(np, "needs-cooling"))
>>>> +               cdev =3D cpufreq_cooling_register(cpu_present_mask);=

>>>> +
>>>>         of_node_put(np);
>>>>         of_node_put(parent);
>>>>         return 0;
>>>> @@ -269,6 +276,7 @@ out_put_node:
>>>>
>>>>  static int cpu0_cpufreq_remove(struct platform_device *pdev)
>>>>  {
>>>> +       cpufreq_cooling_unregister(cdev);
>>>>         cpufreq_unregister_driver(&cpu0_cpufreq_driver);
>>>>         opp_free_cpufreq_table(cpu_dev, &freq_table);
>>>>
>>>>> For instance, assuming that all systems will need a cpufreq cooling=

>>>>> device is a flaw, because that is not the case. Thus, it makes sens=
e to
>>>>> have a property, say at the cpu node, to determine that it needs
>>>>> cooling. However, that won't be saying how it would cool off.
>>>>
>>>>
>>>> Then you would define your cpu0 node as:
>>>>
>>>> 		cpu@0 {
>>>> 			/* OMAP443x variants OPP50-OPPNT */
>>>> 			operating-points =3D <
>>>> 				/* kHz    uV */
>>>> 				300000  1025000
>>>> 				600000  1200000
>>>> 				800000  1313000
>>>> 				1008000 1375000
>>>> 			>;
>>>> 			clock-latency =3D <300000>; /* From legacy driver */
>>>> 			needs-cooling; /* make sure we have cpufreq-cooling */
>>>> 		};
>>>>
>>>> Because in that system we actually need to take care of the cpu ther=
mal.
>>>>
>>> I don't see what not registering the cooling device is buying us (asi=
de
>>> from a small resource saving). The cpu is one potential source of hea=
t
>>> in a system, so we may want to reference it in a thermal zone, so to =
me
>>> it makes sense to always register the cooling device.
>>
>> The 'aside from a small resource saving' that bugs me :-). And
>> conceptually, to me it won't be correct to load stuff you don't need,
>> specially the 'always' loading part of it.
>>
> Hm, while thinking about this I agree. We should try to come up with
> some property that can be used across different devices. My feeling is
> that "needs-cooling" is a bit of a misnomer, as not the CPU/GPU/whateve=
r
> node needs cooling, but the thermal zone. The devices themselves are
> just sources of heat in that thermal zone, so a name like
> "enable-thermal-cooling" or something might be more appropriate.


They are heat sources, agreed, but they also need cooling. Again, they
can generate heat, one  can throttle their dissipated power, but they
are not cooling devices. Cooling devices are virtual concepts, in this
case, that modulates the power dissipated by these heat generating
devices. "enable-thermal-cooling" looks like some switch/knob one would
see in a cooling device.



>=20
>>>
>>>>
>>>>>
>>>>>
>>>>>>
>>>>>>> I could try to push something following the same idea as the one =
I am
>>>>>>> trying to sell with this series for sensor devices. For instance,=
 in a
>>>>>>> sensor node I am attaching a phandle to describe how thermal fw m=
ust
>>>>>>> behave. Then the sensor driver it is supposed to load the thermal=
 data
>>>>>>> into the thermal fw. Same could apply for instance for cpufreq co=
oling
>>>>>>> device. at the cpu node we could have a 'cooling_device' node at =
the cpu
>>>>>>> node, while loading cpufreq-cpu0.
>>>>>>
>>>>>> I think a separate cooling_device node may be only necessary if we=
 stuff
>>>>>> additional info in there. If it's just a plain cooling device I th=
ink it
>>>>>> is reasonable for the cpufreq driver to just register a cooling de=
vice
>>>>>> if the thermal framework is there.
>>>>>
>>>>> no, I think this is not what we want, because, as I said, not all c=
pus
>>>>> will need cooling. Just because the thermal framework is there does=
 not
>>>>> mean your cpu needs cooling. As you can see, the thermal framework =
is
>>>>> not only for cpu cooling. It can be used for any other thermal need=
=2E
>>>>> Besides one needs to cover for the case where you are building for
>>>>> multiple platform support. Assuming system needs based on Kconfig s=
etup
>>>>> is not very likely to scale in this case.
>>>>>
>>>>>>
>>>>>> I would really like the information about a thermal zone to hang o=
ff one
>>>>>> dt node rather than being scattered over several nodes. This way i=
t may
>>>>>
>>>>> Again, thermal framework is not about only cpu(freq) cooling. Therm=
al
>>>>> zone info can (and will) be hanged off in one dt node. But please d=
on't
>>>>> mix concepts. Just because a cooling device is part of a thermal zo=
ne,
>>>>> it does not mean it is only used there and that it can be defined t=
here.
>>>>> One can use a cooling device in different thermal zones.
>>>>>
>>>>>> be easy to reference a cooling device in different thermal zones w=
ith
>>>>>> different weight, etc. As long as we define a thermal zone to alwa=
ys be
>>>>>> defined by a single sensor the right place seems to be the propose=
d
>>>>>> subnode to the sensor. If we want a zone to have more than one sen=
sor,
>>>>>> we might even want a separate dt node for the thermal zone, refere=
ncing
>>>>>> both sensors and cooling devices through phandles.
>>>>>
>>>>> I still don't get why and how defining a thermal zone inside a sens=
or
>>>>> phandle can prevent us defining a cooling device in different devic=
e
>>>>> phandle.
>>>>
>>>>
>>>> Then you can keep everything about your thermal zone in one single
>>>> phandle, as follows, but remember, this is is the info about the the=
rmal
>>>> zone, not about a cooling device. For instance, that is the zone bui=
lt
>>>> on top of a bandgap sensor:
>>>> 	bandgap {
>>>> 		reg =3D <0x4a002260 0x4 0x4a00232C 0x4>;
>>>> 		compatible =3D "ti,omap4430-bandgap";
>>>> 		thermal_zone {
>>>> 			type =3D "CPU";
>>>> 			mask =3D <0x03>; /* trips writability */
>>>> 			passive_delay =3D <250>; /* milliseconds */
>>>> 			polling_delay =3D <1000>; /* milliseconds */
>>>> 			governor =3D "step_wise";
>>>> 			trips {
>>>> 				alert@100000{
>>>> 					temperature =3D <100000>;
>>>> 					hysteresis =3D <0>;
>>>> 					type =3D <1>;
>>>> 				};
>>>> 				crit@125000{
>>>> 					temperature =3D <125000>;
>>>> 					hysteresis =3D <0>;
>>>> 					type =3D <3>;
>>>> 				};
>>>> 			};
>>>> 			bind_params {
>>>> 				action@0{
>>>> 					cooling_device =3D "thermal-cpufreq";
>>>> 					weight =3D <100>; /* percentage */
>>>> 					mask =3D <0x01>;
>>>> 				};
>>>> 			};
>>>> 		};
>>>> 	};
>>>>
>>>>
>>>> And you see that, in this case, the bandgap sensor driver does not n=
eed
>>>> to worry about loading the cpufreq cooling device anymore. Who is
>>>> responsible of doing that is the cpufreq driver, with the above
>>>> proposal, when it makes sense and when there is a need.
>>>
>>> Yes, this makes perfect sense to me. What I would like is to have the=

>>> links more specific in the devicetree, so to me this stringmatching
>>> thing doesn't look too appealing, as it makes it harder to follow the=

>>> links just looking at the DT. That's why I would prefer them to be
>>> phandles, so I could do something like:
>>>
>>> bind_params {
>>> 	action@0 {
>>> 		cooling_device =3D <&cpu@0>;
>>> 		weight =3D <40>; /* percentage */
>>> 		mask =3D <0x01>;
>>> 	};
>>> 	action@1 {
>>> 		cooling_device =3D <&gpu3d>;
>>> 		weigth =3D <60>;
>>> 		mask =3D <0x01>;
>>> };
>>>
>>
>> I see, but the matching won't work at device tree anyway. But I
>> understand your point. However, those would need to be 'cooling device=
'
>> phandles, not 'cpu' phandles or 'gpu3d' phandles, in order to this mak=
e
>> really sense.
>>
> I tend to disagree here. The devices themselves are the source of heat
> and need to be instructed to cool down, not some virtual cooling device=

> on top of them. Also we should try to avoid to push implementation
> specific things into the devicetree. Cooling devices are just some
> arbitrary abstraction made up by the thermal framework, cpu and gpu
> nodes are real hardware and thus the thing that should be in the DT.

Well, that's exactly my point. We are again making the same points. We
should not have phandles for things like cooling devices, as they are
virtual devices.

However, one disagreement here, when you construct something like:

 		cooling_device =3D <&gpu3d>;

To me, reading that, means gpu3d is a cooling device, which in fact is
not. That is why I said, in order for the above really make sense, gpu3d
would need to be a cooling device phandle, which to me is wrong to put
inside device tree. Thus, I believe using the string matching in the C
code is still a better way to go, because creating phandles for cooling
devices is a bit of a stretching.

>=20
> Regards,
> Lucas
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2MJIBJHUPHOWGXWHTUAFH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHlSsgACgkQCXcVR3XQvP2ghQEA2GXCM1Wlx21p83O/T2otlFXT
kM9Rp0/O/D15n0wrFqMA/2twEEo6NEyyHBtQXqYYWVYgbRXvx8jxo79gqWXpDMpi
=i8tv
-----END PGP SIGNATURE-----

------enig2MJIBJHUPHOWGXWHTUAFH--
