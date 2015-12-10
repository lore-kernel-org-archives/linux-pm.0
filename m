From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 14/19] ARM: dts: Add bus nodes using VDD_INT for
 Exynos4x12
Date: Thu, 10 Dec 2015 15:08:37 +0900
Message-ID: <566916E5.5060704@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-15-git-send-email-cw00.choi@samsung.com>
 <56691458.9000000@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36963 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbbLJGIk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 01:08:40 -0500
In-reply-to: <56691458.9000000@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 14:57, Krzysztof Kozlowski wro=
te:
> On 09.12.2015 13:08, Chanwoo Choi wrote:
>> This patch adds the bus noes using VDD_INT for Exynos4x12 SoC.
>> Exynos4x12 has the following AXI buses to translate data between
>> DRAM and sub-blocks.
>>
>> Following list specifies the detailed relation between DRAM and sub-=
blocks:
>> - ACLK100 clock for PERIL/PERIR/MFC(PCLK)
>> - ACLK160 clock for CAM/TV/LCD
>> : The minimum clock of ACLK160 should be over 160MHz.
>>   When drop the clock under 160MHz, show the broken image.
>> - ACLK133 clock for FSYS
>> - GDL clock for LEFTBUS
>> - GDR clock for RIGHTBUS
>> - SCLK_MFC clock for MFC
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos4x12.dtsi | 112 +++++++++++++++++++++++++++=
+++++++++++
>>  1 file changed, 112 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/e=
xynos4x12.dtsi
>> index 3bcf0939755e..8bc4aee156b5 100644
>> --- a/arch/arm/boot/dts/exynos4x12.dtsi
>> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
>> @@ -354,6 +354,118 @@
>>  			opp-microvolt =3D <950000>;
>>  		};
>>  	};
>> +
>> +	bus_leftbus: bus_leftbus {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DIV_GDL>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_leftbus_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_rightbus: bus_rightbus {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DIV_GDR>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_leftbus_opp_table>;
>> +		status =3D "disabled";
>> +	};
>=20
> These two nodes are symmetrical. The MFC below and other buses in oth=
er
> DTS share opps. How about changing the binding so multiple clocks cou=
ld
> be specified at once ("bus0", "bus1")? I think there is no need for a
> bus device for each clock.

The your commented method is possible.

But, I focus on implementing the generic bus frequency driver.

If specific bus device-tree node includes the one more clocks,
when adding the new Exynos SoC, the exynos-bus.c should be added
for new Exynos SoC. Because, each Exynos SoC has the different
set of bus device.

If we use my approach, we don't need to modify the exynos-bus.c
driver to support for the bus frequency of new Exynos SoC.

Best Regards,
Chanwoo Choi

>=20
> Best regards,
> Krzysztof
>=20
>> +
>> +	bus_display: bus_display {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_ACLK160>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_display_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_fsys: bus_fsys {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_ACLK133>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_fsys_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_peri: bus_peri {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_ACLK100>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_peri_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_mfc: bus_mfc {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_SCLK_MFC>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_leftbus_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_leftbus_opp_table: opp_table3 {
>> +		compatible =3D "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp00 {
>> +			opp-hz =3D /bits/ 64 <100000000>;
>> +			opp-microvolt =3D <900000>;
>> +		};
>> +		opp01 {
>> +			opp-hz =3D /bits/ 64 <134000000>;
>> +			opp-microvolt =3D <925000>;
>> +		};
>> +		opp02 {
>> +			opp-hz =3D /bits/ 64 <160000000>;
>> +			opp-microvolt =3D <950000>;
>> +		};
>> +		opp03 {
>> +			opp-hz =3D /bits/ 64 <200000000>;
>> +			opp-microvolt =3D <1000000>;
>> +		};
>> +	};
>> +
>> +	bus_display_opp_table: opp_table4 {
>> +		compatible =3D "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp00 {
>> +			opp-hz =3D /bits/ 64 <160000000>;
>> +			opp-microvolt =3D <950000>;
>> +		};
>> +		opp01 {
>> +			opp-hz =3D /bits/ 64 <200000000>;
>> +			opp-microvolt =3D <1000000>;
>> +		};
>> +	};
>> +
>> +	bus_fsys_opp_table: opp_table5 {
>> +		compatible =3D "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp00 {
>> +			opp-hz =3D /bits/ 64 <100000000>;
>> +			opp-microvolt =3D <900000>;
>> +		};
>> +		opp01 {
>> +			opp-hz =3D /bits/ 64 <134000000>;
>> +			opp-microvolt =3D <925000>;
>> +		};
>> +	};
>> +
>> +	bus_peri_opp_table: opp_table6 {
>> +		compatible =3D "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp00 {
>> +			opp-hz =3D /bits/ 64 <50000000>;
>> +			opp-microvolt =3D <900000>;
>> +		};
>> +		opp01 {
>> +			opp-hz =3D /bits/ 64 <100000000>;
>> +			opp-microvolt =3D <925000>;
>> +		};
>> +	};
>>  };
>> =20
>>  &combiner {
>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

