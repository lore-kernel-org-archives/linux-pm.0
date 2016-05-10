From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 01/11] of: Add bindings of hw throttle for Tegra soctherm
Date: Tue, 10 May 2016 17:32:17 +0800
Message-ID: <5731AAA1.9030202@nvidia.com>
References: <1462776844-2152-1-git-send-email-wni@nvidia.com> <1462776844-2152-2-git-send-email-wni@nvidia.com> <20160509201538.GA21382@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160509201538.GA21382@rob-hp-laptop>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 2016=E5=B9=B405=E6=9C=8810=E6=97=A5 04:15, Rob Herring wrote:
> On Mon, May 09, 2016 at 02:53:54PM +0800, Wei Ni wrote:
>> Add HW throttle configuration sub-node for soctherm, which
>> is used to describe the throttle event, and worked as a
>> cooling device. The "hot" type trip in thermal zone can
>> be bound to this cooling device, and trigger the throttle
>> function.
>>
>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  .../bindings/thermal/nvidia,tegra124-soctherm.txt  | 121 ++++++++++=
++++++++++-
>>  1 file changed, 119 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra1=
24-soctherm.txt b/Documentation/devicetree/bindings/thermal/nvidia,tegr=
a124-soctherm.txt
>> index edebfa0a985e..f691f63da567 100644
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
>> @@ -25,17 +31,45 @@ Required properties :
>>  - #thermal-sensor-cells : Should be 1. See ./thermal.txt for a desc=
ription
>>      of this property. See <dt-bindings/thermal/tegra124-soctherm.h>=
 for a
>>      list of valid values when referring to thermal sensors.
>> +- nvidia,throttle-cfgs: A sub-node which is a container of configur=
ation for
>> +    each hardware throttle events. These events can be set as cooli=
ng devices.
>> +  * throttle events: Sub-nodes must be named as "nvidia,light" or "=
nvidia,heavy".
>> +      Properties:
>> +      - nvidia,priority: Each throttles has its own throttle settin=
gs, so the
>> +        SW need to set priorities for various throttle, the HW arbi=
ter can select
>> +        the final throttle settings.
>> +        Bigger value indicates higher priority, In general, higher =
priority
>> +        translates to lower target frequency. SW needs to ensure th=
at critical
>> +        thermal alarms are given higher priority, and ensure that t=
here is
>> +        no race if priority of two vectors is set to the same value=
=2E
>> +        The range of this value is 1~100.
>> +      - nvidia,cpu-throt-percent: This property is for Tegra124 and=
 Tegra210.
>> +        It is the throttling depth of pulse skippers, it's the perc=
entage
>> +        throttling.
>> +      - nvidia,cpu-throt-level: This property is only for Tegra132,=
 it is the
>> +        level of pulse skippers, which used to throttle clock frequ=
encies. It
>> +        indicates cpu clock throttling depth, and the depth can be =
programmed.
>> +        Must set as following values:
>> +        TEGRA_SOCTHERM_THROT_LEVEL_LOW, TEGRA_SOCTHERM_THROT_LEVEL_=
MED
>> +        TEGRA_SOCTHERM_THROT_LEVEL_HIGH, TEGRA_SOCTHERM_THROT_LEVEL=
_NONE
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
>> @@ -44,6 +78,76 @@ Example :
>>  		reset-names =3D "soctherm";
>> =20
>>  		#thermal-sensor-cells =3D <1>;
>> +
>> +		throttle-cfgs {
>> +			/*
>> +			 * When the "heavy" cooling device triggered,
>> +			 * the HW will skip cpu clock's pulse in 85% depth
>> +			 */
>> +			throttle_heavy: nvidia,heavy {
>=20
> Still need to drop vendor prefix in the node names here and elsewhere=
=2E

Sorry, it's my mistake, will fix it.

>=20
>> +				nvidia,priority =3D <100>;
>> +				nvidia,cpu-throt-percent =3D <85>;
>> +
>> +				#cooling-cells =3D <1>;
>> +			};
>> +
>> +			/*
>> +			 * When the "light" cooling device triggered,
>> +			 * the HW will skip cpu clock's pulse in 50% depth
>> +			 */
>> +			throttle_light: nvidia,light {
>> +				nvidia,priority =3D <80>;
>> +				nvidia,cpu-throt-percent =3D <50>;
>> +
>> +				#cooling-cells =3D <1>;
>> +			};
>> +
>> +			/*
>> +			 * If these two devices are triggered in same time, the HW throt=
tle
>> +			 * arbiter will select the highest priority as the final throttl=
e
>> +			 * settings to skip cpu pulse.
>> +			 */
>> +		};
>> +	};
>> +
>> +Example: referring to Tegra132's "reg", "reg-names" and "throttle-c=
fgs" :
>> +
>> +	soctherm@700e2000 {
>> +		compatible =3D "nvidia,tegra132-soctherm";
>> +		reg =3D <0x0 0x700e2000 0x0 0x600  /* SOC_THERM reg_base */
>> +			0x0 0x70040000 0x0 0x200>; /* CCROC reg_base */;
>> +		reg-names =3D "soctherm-reg", "ccroc-reg";
>> +
>> +		throttle-cfgs {
>> +			/*
>> +			 * When the "heavy" cooling device triggered,
>> +			 * the HW will skip cpu clock's pulse in HIGH level
>> +			 */
>> +			throttle_heavy: nvidia,heavy {
>> +				nvidia,priority =3D <100>;
>> +				nvidia,cpu-throt-level =3D <TEGRA_SOCTHERM_THROT_LEVEL_HIGH>;
>> +
>> +				#cooling-cells =3D <1>;
>> +			};
>> +
>> +			/*
>> +			 * When the "light" cooling device triggered,
>> +			 * the HW will skip cpu clock's pulse in MED level
>> +			 */
>> +			throttle_light: nvidia,light {
>> +				nvidia,priority =3D <80>;
>> +				nvidia,cpu-throt-level =3D <TEGRA_SOCTHERM_THROT_LEVEL_MED>;
>> +
>> +				#cooling-cells =3D <1>;
>> +			};
>> +
>> +			/*
>> +			 * If these two devices are triggered in same time, the HW throt=
tle
>> +			 * arbiter will select the highest priority as the final throttl=
e
>> +			 * settings to skip cpu pulse.
>> +			 */
>> +
>> +		};
>>  	};
>> =20
>>  Example: referring to thermal sensors :
>> @@ -62,6 +166,19 @@ Example: referring to thermal sensors :
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
