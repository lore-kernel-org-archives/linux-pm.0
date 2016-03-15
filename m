From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH V7 11/12] arm64: tegra: add soctherm node for Tegra210
Date: Tue, 15 Mar 2016 18:43:00 +0800
Message-ID: <56E7E734.5010307@nvidia.com>
References: <1457665894-30141-1-git-send-email-wni@nvidia.com> <20160314192500.GE1872@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4443 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933885AbcCOKmw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 06:42:52 -0400
In-Reply-To: <20160314192500.GE1872@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, thierry.reding@gmail.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 03:25, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
>=20
> On Fri, Mar 11, 2016 at 11:11:34AM +0800, Wei Ni wrote:
>> Adds soctherm node for Tegra210, and add cpu,
>> gpu, mem, pllx as thermal-zones. Set critical
>> trip temp for cpu and gpu thermal zone.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 60 +++++++++++++++++++++=
+++++++++++
>>  1 file changed, 60 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/b=
oot/dts/nvidia/tegra210.dtsi
>> index cd4f45ccd6a7..c7ef500a347e 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
>> @@ -3,6 +3,7 @@
>>  #include <dt-bindings/memory/tegra210-mc.h>
>>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/thermal/tegra124-soctherm.h>
>> =20
>>  / {
>>  	compatible =3D "nvidia,tegra210";
>> @@ -802,4 +803,63 @@
>>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>  		interrupt-parent =3D <&gic>;
>>  	};
>> +
>> +	soctherm: thermal-sensor@0,700e2000 {
>> +		compatible =3D "nvidia,tegra210-soctherm";
>> +		reg =3D <0x0 0x700e2000 0x0 0x1000>;
>> +		interrupts =3D <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks =3D <&tegra_car TEGRA210_CLK_TSENSOR>,
>> +			<&tegra_car TEGRA210_CLK_SOC_THERM>;
>> +		clock-names =3D "tsensor", "soctherm";
>> +		resets =3D <&tegra_car 78>;
>> +		reset-names =3D "soctherm";
>> +		#thermal-sensor-cells =3D <1>;
>> +	};
>> +
>> +	thermal-zones {
>> +		cpu {
>> +			polling-delay-passive =3D <1000>;
>> +			polling-delay =3D <0>;
>> +
>> +			thermal-sensors =3D
>> +				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
>> +
>> +			trips {
>> +				cpu_shutdown_trip: shutdown-trip {
>> +					temperature =3D <102500>;
>> +					hysteresis =3D <1000>;
>> +					type =3D "critical";
>> +				};
>> +			};
>> +		};
>> +		mem {
>> +			polling-delay-passive =3D <0>;
>> +			polling-delay =3D <0>;
>> +
>> +			thermal-sensors =3D
>> +				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
>=20
>=20
> Why no trips for mem? Why should we  care ?

The critical trip temperature will be set to HW for critical shutdown. =
Normally,
we just take care the CPU and GPU temperature. And in HW, the MEM use t=
he same
critical trip with GPU. For PLLX, we just keep the default critical tri=
p in HW.
So I didn't configure the MEM and PLLX. I can add critical trips for th=
em.

>=20
> Please have a look on the binding to check for mandatory properties a=
nd
> sub nodes.

Hmm, yes, the trips and cooling-maps are required properties. How about=
 to add a
dummy-cool-dev, so that it could be compatible with the binding.

Wei.

>=20
>> +		};
>> +		gpu {
>> +			polling-delay-passive =3D <1000>;
>> +			polling-delay =3D <0>;
>> +
>> +			thermal-sensors =3D
>> +				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
>> +
>> +			trips {
>> +				gpu_shutdown_trip: shutdown-trip {
>> +					temperature =3D <103000>;
>> +					hysteresis =3D <1000>;
>> +					type =3D "critical";
>> +				};
>> +			};
>> +		};
>> +		pllx {
>> +			polling-delay-passive =3D <0>;
>> +			polling-delay =3D <0>;
>> +
>> +			thermal-sensors =3D
>> +				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
>=20
> ditto
>=20
>> +		};
>> +	};
>>  };
>> --=20
>> 1.9.1
>>
>=20
> * Unknown Key
> * 0x7DA4E256
>=20
