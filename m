From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 09/19] PM / devfreq: exynos: Update documentation for
 bus devices using passive governor
Date: Thu, 10 Dec 2015 10:36:48 +0900
Message-ID: <5668D730.6070404@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-10-git-send-email-cw00.choi@samsung.com>
 <5668D5DD.5090202@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <5668D5DD.5090202@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 10:31, Krzysztof Kozlowski wro=
te:
> On 09.12.2015 13:08, Chanwoo Choi wrote:
>> This patch updates the documentation for passive bus devices and add=
s the
>> detailed example of Exynos3250.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  .../devicetree/bindings/devfreq/exynos-bus.txt     | 244 ++++++++++=
++++++++++-
>>  1 file changed, 241 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.tx=
t b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> index 54a1f9c46c88..c4fdc70f8eac 100644
>> --- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> +++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>> @@ -13,18 +13,23 @@ SoC has the different sub-blocks. So, this diffe=
rence should be specified
>>  in devicetree file instead of each device driver. In result, this d=
river
>>  is able to support the bus frequency for all Exynos SoCs.
>> =20
>> -Required properties for bus device:
>> +Required properties for all bus devices:
>>  - compatible: Should be "samsung,exynos-bus".
>>  - clock-names : the name of clock used by the bus, "bus".
>>  - clocks : phandles for clock specified in "clock-names" property.
>>  - #clock-cells: should be 1.
>>  - operating-points-v2: the OPP table including frequency/voltage in=
formation
>>    to support DVFS (Dynamic Voltage/Frequency Scaling) feature.
>> +
>> +Required properties for only parent bus device:
>=20
> Maybe:
> "Required properties only for parent bus devices:"

OK. I'll modify it.

>=20
> In this binding documentation file the idea of "parent" is not
> explained. I now it is related to passive devfreq governor but lookin=
g
> at the binding itself it is a new idea, not covered here.

OK. I'll add the detailed description of 'parent' and
correlation between 'parent' and 'passive' device.

>=20
>>  - vdd-supply: the regulator to provide the buses with the voltage.
>>  - devfreq-events: the devfreq-event device to monitor the curret ut=
ilization
>>    of buses.
>> =20
>> -Optional properties for bus device:
>> +Required properties for only passive bus device:
>=20
> "Required properties only for passive bus devices:"

OK. I'll modify it.

>=20
>> +- devfreq: the parent bus device.
>> +
>> +Optional properties for only parent bus device:
>>  - exynos,saturation-ratio: the percentage value which is used to ca=
librate
>>                     the performance count againt total cycle count.
>> =20
>> @@ -33,7 +38,20 @@ Example1:
>>  	power line (regulator). The MIF (Memory Interface) AXI bus is used=
 to
>>  	transfer data between DRAM and CPU and uses the VDD_MIF regualtor.
>> =20
>> -	- power line(VDD_MIF) --> bus for DMC (Dynamic Memory Controller) =
block
>> +	- MIF (Memory Interface) block
>> +	: VDD_MIF |--- DMC (Dynamic Memory Controller)
>> +
>> +	- INT (Internal) block
>> +	: VDD_INT |--- LEFTBUS (parent device)
>> +		  |--- PERIL
>> +		  |--- MFC
>> +		  |--- G3D
>> +		  |--- RIGHTBUS
>> +		  |--- FSYS
>> +		  |--- LCD0
>> +		  |--- PERIR
>> +		  |--- ISP
>> +		  |--- CAM
>> =20
>>  	- MIF bus's frequency/voltage table
>>  	-----------------------
>> @@ -46,6 +64,24 @@ Example1:
>>  	|L5| 400000 |875000   |
>>  	-----------------------
>> =20
>> +	- INT bus's frequency/voltage table
>> +	----------------------------------------------------------
>> +	|Block|LEFTBUS|RIGHTBUS|MCUISP |ISP    |PERIL  ||VDD_INT |
>> +	| name|       |LCD0    |       |       |       ||        |
>> +	|     |       |FSYS    |       |       |       ||        |
>> +	|     |       |MFC     |       |       |       ||        |
>> +	----------------------------------------------------------
>> +	|Mode |*parent|passive |passive|passive|passive||        |
>> +	----------------------------------------------------------
>> +	|Lv   |Frequency                               ||Voltage |
>> +	----------------------------------------------------------
>> +	|L1   |50000  |50000   |50000  |50000  |50000  ||900000  |
>> +	|L2   |80000  |80000   |80000  |80000  |80000  ||900000  |
>> +	|L3   |100000 |100000  |100000 |100000 |100000 ||1000000 |
>> +	|L4   |134000 |134000  |200000 |200000 |       ||1000000 |
>> +	|L5   |200000 |200000  |400000 |300000 |       ||1000000 |
>> +	----------------------------------------------------------
>> +
>>  Example2 :
>>  	The bus of DMC (Dynamic Memory Controller) block in exynos3250.dts=
i
>>  	are listed below:
>> @@ -84,6 +120,167 @@ Example2 :
>>  		};
>>  	};
>> =20
>> +	bus_leftbus: bus_leftbus {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&cmu CLK_DIV_GDL>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_leftbus_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_rightbus: bus_rightbus {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&cmu CLK_DIV_GDR>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_leftbus_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_lcd0: bus_lcd0 {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&cmu CLK_DIV_ACLK_160>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_leftbus_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_fsys: bus_fsys {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&cmu CLK_DIV_ACLK_200>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_leftbus_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_mcuisp: bus_mcuisp {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&cmu CLK_DIV_ACLK_400_MCUISP>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_mcuisp_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_isp: bus_isp {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&cmu CLK_DIV_ACLK_266>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_isp_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_peril: bus_perir {
>=20
>=20
> Peril or perir?

peril is correct. I'll fix it.

Best Regards,
Chanwoo Choi
