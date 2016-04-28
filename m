From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH v2 4/9] of: Add bindings of hw throttle for soctherm
Date: Thu, 28 Apr 2016 14:48:41 +0800
Message-ID: <5721B249.3010101@nvidia.com>
References: <1461727554-15065-1-git-send-email-wni@nvidia.com> <1461727554-15065-5-git-send-email-wni@nvidia.com> <20160427233054.GA26451@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nat-hk.nvidia.com ([203.18.50.4]:23354 "EHLO
	hkmmgate102.nvidia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751266AbcD1GrP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2016 02:47:15 -0400
In-Reply-To: <20160427233054.GA26451@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org



On 2016=E5=B9=B404=E6=9C=8828=E6=97=A5 07:30, Eduardo Valentin wrote:
> From: Eduardo Valentin <edubezval@gmail.com>
> To: Wei Ni <wni@nvidia.com>
> Cc: thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com=
,
> 	MLongnecker@nvidia.com, swarren@wwwdotorg.org,
> 	mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org,
> 	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
> 	linux-kernel@vger.kernel.org
> Bcc:=20
> Subject: Re: [PATCH v2 4/9] of: Add bindings of hw throttle for socth=
erm
> Reply-To:=20
> In-Reply-To: <1461727554-15065-5-git-send-email-wni@nvidia.com>
>=20
> The patch title must say something about the fact that this is specif=
ic
> to nvidia thermal driver.

Yes, it's my mistake, will fix it in next series.

>=20
> On Wed, Apr 27, 2016 at 11:25:49AM +0800, Wei Ni wrote:
>> Add HW throttle configuration sub-node for soctherm, which
>> is used to describe the throttle event, and worked as a
>> cooling device. The "hot" type trip in thermal zone can
>> be bound to this cooling device, and trigger the throttle
>> function.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 89 +++++++++++=
++++++++++-
>>  1 file changed, 87 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra1=
24-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegr=
a124-soctherm.txt
>> index edebfa0a985e..dc337d139f49 100644
>> --- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soct=
herm.txt
>> +++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soct=
herm.txt
>> @@ -10,8 +10,14 @@ Required properties :
>>  - compatible : For Tegra124, must contain "nvidia,tegra124-soctherm=
".
>>    For Tegra132, must contain "nvidia,tegra132-soctherm".
>>    For Tegra210, must contain "nvidia,tegra210-soctherm".
>> -- reg : Should contain 1 entry:
>> +- reg : Should contain at least 2 entries for each entry in reg-nam=
es:
>>    - SOCTHERM register set
>> +  - Tegra CAR register set: Required for Tegra124 and Tegra210.
>> +  - CCROC register set: Required for Tegra132.
>> +- reg-names :  Should contain at least 2 entries:
>> +  - soctherm-reg
>> +  - car-reg
>> +  - ccroc-reg
>>  - interrupts : Defines the interrupt used by SOCTHERM
>>  - clocks : Must contain an entry for each entry in clock-names.
>>    See ../clocks/clock-bindings.txt for details.
>> @@ -25,17 +31,44 @@ Required properties :
>>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a desc=
ription
>>      of this property. See <dt-bindings/thermal/tegra124-soctherm.h>=
 for a
>>      list of valid values when referring to thermal sensors.
>> +- throttle-cfgs: A sub-node which is a container of configuration f=
or each
>> +    hardware throttle events. These events can be set as cooling de=
vices.
>> +  * throttle events: Sub-nodes must be named as "light" or "heavy".
>> +      Properties:
>> +      - priority: Each throttles has its own throttle settings, so =
the SW need
>> +        to set priorities for various throttle, the HW arbiter can =
select the
>> +        final throttle settings.
>> +        Bigger value indicates higher priority, In general, higher =
priority
>> +        translates to lower target frequency. SW needs to ensure th=
at critical
>> +        thermal alarms are given higher priority, and ensure that t=
here is
>> +        no race if priority of two vectors is set to the same value=
=2E
>> +      - cpu-throt-depth:  This property is for Tegra124 and Tegra21=
0. It is
>> +        the throttling depth of pulse skippers, it's the percentage
>> +        throttling.
>> +      - cpu-throt-level: This property is only for Tegra132, it is =
the level
>> +        of pulse skippers, which used to throttle clock frequencies=
=2E It
>> +        indicates cpu clock throttling depth, and the depth can be =
programmed.
>> +        Must set as following values:
>> +        TEGRA_SOCTHERM_THROT_LEVEL_LOW, TEGRA_SOCTHERM_THROT_LEVEL_=
MED
>> +        TEGRA_SOCTHERM_THROT_LEVEL_HIGH, TEGRA_SOCTHERM_THROT_LEVEL=
_NONE
>=20
> These properties are not generic properties. My understanding is that
> you must have vendor prefix in such case. Same applies to the new nod=
es.

Ok, will do it.

>=20
>> +      - #cooling-cells: Should be 1. This cooling device only suppo=
rt on/off state.
>> +        See ./thermal.txt for a description of this property.
>> =20
>>  Note:
>>  - the "critical" type trip points will be set to SOC_THERM hardware=
 as the
>>  shut down temperature. Once the temperature of this thermal zone is=
 higher
>>  than it, the system will be shutdown or reset by hardware.
>> +- the "hot" type trip points will be set to SOC_THERM hardware as t=
he throttle
>> +temperature. Once the the temperature of this thermal zone is highe=
r
>> +than it, it will trigger the HW throttle event.
>> =20
>>  Example :
>> =20
>>  	soctherm@700e2000 {
>>  		compatible =3D "nvidia,tegra124-soctherm";
>> -		reg =3D <0x0 0x700e2000 0x0 0x1000>;
>> +		reg =3D <0x0 0x700e2000 0x0 0x600  /* SOC_THERM reg_base */
>> +			0x0 0x60006000 0x0 0x400 /* CAR reg_base */
>> +		reg-names =3D "soctherm-reg", "car-reg";
>>  		interrupts =3D <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>>  		clocks =3D <&tegra_car TEGRA124_CLK_TSENSOR>,
>>  			<&tegra_car TEGRA124_CLK_SOC_THERM>;
>> @@ -44,6 +77,45 @@ Example :
>>  		reset-names =3D "soctherm";
>> =20
>>  		#thermal-sensor-cells =3D <1>;
>> +
>> +		throttle-cfgs {
>> +			throttle_heavy: heavy {
>> +				priority =3D <100>;
>> +				cpu-throt-depth =3D <85>;
>> +
>> +				#cooling-cells =3D <1>;
>> +			};
>> +			throttle_light: light {
>> +				priority =3D <80>;
>> +				cpu-throt-depth =3D <50>;
>> +
>> +				#cooling-cells =3D <1>;
>> +			};
>> +		};
>=20
> This is a sensor, which at the same time, has sub nodes that can be
> cooling devices. Is my understanding correct of what you are trying t=
o
> do?

Yes, we set this sub nodes as cooling devices.
Let me explain it.
The Tegra's soctherm has the HW throttle function, it will be triggered=
 when the
temperatures reach to the "hot" type trip. These throttle events can be
configured to different levels "heavy" and "light" on different sensors=
=2E So it
something like cooling devices which can be bound with thermal zones, a=
nd in
this way, we can use the linux of-thermal framework to handle it. If no=
t, we
have to add more codes to parse these configuration and set them for th=
ose
sensors. I had used this method to handle the shutdown function in Tegr=
a's
soctherm driver in my previous series, however Rob didn't like it, he p=
referred
to use linux framework to handle it.
So I think it's better to set these throttle-cfgs as cooling devices, s=
o they
can be bound to the cpu/gpu thermal zones easily.

>=20
>=20
>> +	};
>> +
>> +Example: referring to Tegra132's "reg", "reg-names" and "throttle-c=
fgs" :
>> +
>> +	soctherm@0,700e2000 {
>> +		compatible =3D "nvidia,tegra132-soctherm";
>> +		reg =3D <0x0 0x700e2000 0x0 0x600  /* SOC_THERM reg_base */
>> +			0x0 0x70040000 0x0 0x200>; /* CCROC reg_base */;
>> +		reg-names =3D "soctherm-reg", "ccroc-reg";
>> +
>> +		throttle-cfgs {
>> +			throttle_heavy: heavy {
>> +				priority =3D <100>;
>> +				cpu-throt-level =3D <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
>> +
>> +				#cooling-cells =3D <1>;
>> +			};
>> +			throttle_light: light {
>> +				priority =3D <80>;
>> +				cpu-throt-level =3D <TEGRA_SOCTHERM_THROT_LEVEL_MED>;
>> +
>> +				#cooling-cells =3D <1>;
>=20
> Could you please describe a little here what to expect of the above
> setup?

Ok, let me describe it.
When the "heavy" cooling device triggered, the hardware will skip cpu c=
lock's
pulse in HIGH level, and if the "light" triggered, the hardware will sk=
ip cpu
clock's pulse in MED level.
If these two devices are triggered in same time, the HW throttle arbite=
r will
select the highest priority as the final throttle settings to skip cpu =
pulse.

>=20
>=20
>> +			};
>> +		};
>>  	};
>> =20
>>  Example: referring to thermal sensors :
>> @@ -62,6 +134,19 @@ Example: referring to thermal sensors :
>>  					hysteresis =3D <1000>;
>>  					type =3D "critical";
>>  				};
>> +
>> +				cpu_throttle_trip: throttle-trip {
>> +					temperature =3D <100000>;
>> +					hysteresis =3D <1000>;
>> +					type =3D "hot";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +				map0 {
>> +					trip =3D <&cpu_throttle_trip>;
>> +					cooling-device =3D <&throttle_heavy 1 1>;
>> +				};
>>  			};
>>                  };
>>  	};
>> --=20
>> 1.9.1
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
