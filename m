From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 3/4] thermal: ti-soc-thermal: use thermal DT infrastructure
Date: Mon, 15 Jul 2013 09:36:39 -0400
Message-ID: <51E3FAE7.3090609@ti.com>
References: <1373378414-28086-1-git-send-email-eduardo.valentin@ti.com>  <1373378414-28086-4-git-send-email-eduardo.valentin@ti.com>  <loom.20130715T124843-388@post.gmane.org> <51E3EC2C.2030803@ti.com> <1373893198.4172.28.camel@weser.hi.pengutronix.de> <51E3F864.1060000@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2XGNCBBCAMHLDQNGBJJPM"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44853 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756262Ab3GONgs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 09:36:48 -0400
In-Reply-To: <51E3F864.1060000@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-pm@vger.kernel.org

------enig2XGNCBBCAMHLDQNGBJJPM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15-07-2013 09:25, Eduardo Valentin wrote:
> On 15-07-2013 08:59, Lucas Stach wrote:
>> Am Montag, den 15.07.2013, 08:33 -0400 schrieb Eduardo Valentin:
>>> On 15-07-2013 08:12, Lucas Stach wrote:
>>>> Hi Eduardo and others,
>>>>
>>>> Eduardo Valentin <eduardo.valentin <at> ti.com> writes:
>>>>
>>>>>
>>>>> This patch improves the ti-soc-thermal driver by adding the
>>>>> support to build the thermal zones based on DT nodes.
>>>>>
>>>>> The driver will have two options now to build the thermal
>>>>> zones. The first option is the zones originally coded
>>>>> in this driver. So, the driver behavior will be same
>>>>> if there is no DT node describing the zones. The second
>>>>> option, when it is found a DT node with thermal data,
>>>>> will used the common infrastructure to build the thermal
>>>>> zone and bind its cooling devices.
>>>>>
>>>>> In either case, this driver still adds to the system
>>>>> a cpufreq cooling device.
>>>>>
>>>>
>>>> I really like the idea to configure thermal zones using devicetree, =
it's a
>>>> step in the right direction. We might follow suit with the i.MX6 tem=
pmon
>>>> driver to use this infrastructure.
>>>>
>>>> What I strongly dislike is the notion of the sensor drivers instanti=
ating
>>>> the cooling devices and the resulting devicetree binding. This seems=
 really
>>>> backward to me.
>>>> I would rather see the drivers associated with the cooling devices (=
like
>>>> cpufreq and the respective gpu drivers) to instantiate the cooling d=
evices
>>>> and the thermal zone referring to them through phandles. I think it
>>>> shouldn't be too much work to go in that direction.
>>>> The current method might be enough to work with the current thermal =
platform
>>>> drivers, but if you want to go down the route to eventually use plai=
n i2c
>>>> devices (likely with an existing hwmon driver) you have to get away =
from the
>>>> sensor devices instantiating the cooling devices.
>>>
>>> I agree with you. While implementing the RFC, it looks awkward that t=
he
>>> ti-soc-thermal driver had to do the job to load the cpufreq-cooling
>>> device. Problem is that a cooling device is not really a real device,=

>>> and might get flamed while represented as a device tree node.
>>>
>> I don't think we even need to represent this into the device tree. We
>> already have the CPU nodes there and the cpu-freq driver is already
>> linked to those. It should be easy to have a global list of registered=

>> thermal devices in the thermal framework together with their associate=
d
>> devices, so one could look up cooling devices through the thermal
>> framework when we only have a phandle to the cpu node.
>=20
> Well, we do have a list of thermal cooling devices associated with its
> corresponding struct device. That is private data to the thermal
> framework. However, one needs to load the cooling device in order to it=
s
> data structure appear in this list. The framework can not be proactive
> here. Some other entity needs to see the need and inform the thermal
> framework of it.
>=20



as simple as the following:
diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu=
0.c
index 3ab8294..486881c 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -20,6 +20,9 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/cpu_cooling.h>
+#include <linux/cpumask.h>

 static unsigned int transition_latency;
 static unsigned int voltage_tolerance; /* in percentage */
@@ -28,6 +31,7 @@ static struct device *cpu_dev;
 static struct clk *cpu_clk;
 static struct regulator *cpu_reg;
 static struct cpufreq_frequency_table *freq_table;
+static struct thermal_cooling_device *cdev;

 static int cpu0_verify_speed(struct cpufreq_policy *policy)
 {
@@ -256,6 +260,9 @@ static int cpu0_cpufreq_probe(struct platform_device
*pdev)
                goto out_free_table;
        }

+       if (!of_property_read_bool(np, "needs-cooling"))
+               cdev =3D cpufreq_cooling_register(cpu_present_mask);
+
        of_node_put(np);
        of_node_put(parent);
        return 0;
@@ -269,6 +276,7 @@ out_put_node:

 static int cpu0_cpufreq_remove(struct platform_device *pdev)
 {
+       cpufreq_cooling_unregister(cdev);
        cpufreq_unregister_driver(&cpu0_cpufreq_driver);
        opp_free_cpufreq_table(cpu_dev, &freq_table);

> For instance, assuming that all systems will need a cpufreq cooling
> device is a flaw, because that is not the case. Thus, it makes sense to=

> have a property, say at the cpu node, to determine that it needs
> cooling. However, that won't be saying how it would cool off.


Then you would define your cpu0 node as:

		cpu@0 {
			/* OMAP443x variants OPP50-OPPNT */
			operating-points =3D <
				/* kHz    uV */
				300000  1025000
				600000  1200000
				800000  1313000
				1008000 1375000
			>;
			clock-latency =3D <300000>; /* From legacy driver */
			needs-cooling; /* make sure we have cpufreq-cooling */
		};

Because in that system we actually need to take care of the cpu thermal.


>=20
>=20
>>
>>> I could try to push something following the same idea as the one I am=

>>> trying to sell with this series for sensor devices. For instance, in =
a
>>> sensor node I am attaching a phandle to describe how thermal fw must
>>> behave. Then the sensor driver it is supposed to load the thermal dat=
a
>>> into the thermal fw. Same could apply for instance for cpufreq coolin=
g
>>> device. at the cpu node we could have a 'cooling_device' node at the =
cpu
>>> node, while loading cpufreq-cpu0.
>>
>> I think a separate cooling_device node may be only necessary if we stu=
ff
>> additional info in there. If it's just a plain cooling device I think =
it
>> is reasonable for the cpufreq driver to just register a cooling device=

>> if the thermal framework is there.
>=20
> no, I think this is not what we want, because, as I said, not all cpus
> will need cooling. Just because the thermal framework is there does not=

> mean your cpu needs cooling. As you can see, the thermal framework is
> not only for cpu cooling. It can be used for any other thermal need.
> Besides one needs to cover for the case where you are building for
> multiple platform support. Assuming system needs based on Kconfig setup=

> is not very likely to scale in this case.
>=20
>>
>> I would really like the information about a thermal zone to hang off o=
ne
>> dt node rather than being scattered over several nodes. This way it ma=
y
>=20
> Again, thermal framework is not about only cpu(freq) cooling. Thermal
> zone info can (and will) be hanged off in one dt node. But please don't=

> mix concepts. Just because a cooling device is part of a thermal zone,
> it does not mean it is only used there and that it can be defined there=
=2E
> One can use a cooling device in different thermal zones.
>=20
>> be easy to reference a cooling device in different thermal zones with
>> different weight, etc. As long as we define a thermal zone to always b=
e
>> defined by a single sensor the right place seems to be the proposed
>> subnode to the sensor. If we want a zone to have more than one sensor,=

>> we might even want a separate dt node for the thermal zone, referencin=
g
>> both sensors and cooling devices through phandles.
>=20
> I still don't get why and how defining a thermal zone inside a sensor
> phandle can prevent us defining a cooling device in different device
> phandle.


Then you can keep everything about your thermal zone in one single
phandle, as follows, but remember, this is is the info about the thermal
zone, not about a cooling device. For instance, that is the zone built
on top of a bandgap sensor:
	bandgap {
		reg =3D <0x4a002260 0x4 0x4a00232C 0x4>;
		compatible =3D "ti,omap4430-bandgap";
		thermal_zone {
			type =3D "CPU";
			mask =3D <0x03>; /* trips writability */
			passive_delay =3D <250>; /* milliseconds */
			polling_delay =3D <1000>; /* milliseconds */
			governor =3D "step_wise";
			trips {
				alert@100000{
					temperature =3D <100000>;
					hysteresis =3D <0>;
					type =3D <1>;
				};
				crit@125000{
					temperature =3D <125000>;
					hysteresis =3D <0>;
					type =3D <3>;
				};
			};
			bind_params {
				action@0{
					cooling_device =3D "thermal-cpufreq";
					weight =3D <100>; /* percentage */
					mask =3D <0x01>;
				};
			};
		};
	};


And you see that, in this case, the bandgap sensor driver does not need
to worry about loading the cpufreq cooling device anymore. Who is
responsible of doing that is the cpufreq driver, with the above
proposal, when it makes sense and when there is a need.



>=20
>>
>> Regards,
>> Lucas
>>
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2XGNCBBCAMHLDQNGBJJPM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHj+ucACgkQCXcVR3XQvP3R/AEAqD/ZpNDkSPUDOe3Z8/FY1r0K
G2+sdTcvQ1IxK0CLnKEBAOfbGmBIcKuJaljhNA3SlT9CBoWz5jhcAZ6lR9qYUDPQ
=WAYR
-----END PGP SIGNATURE-----

------enig2XGNCBBCAMHLDQNGBJJPM--
