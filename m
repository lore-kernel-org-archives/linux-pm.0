From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 13/19] ARM: dts: Add bus nodes using VDD_MIF for
 Exynos4x12
Date: Thu, 10 Dec 2015 13:21:19 +0900
Message-ID: <5668FDBF.1010304@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-14-git-send-email-cw00.choi@samsung.com>
 <5668EEC0.80403@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:46145 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbbLJEVV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 23:21:21 -0500
In-reply-to: <5668EEC0.80403@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 12:17, Krzysztof Kozlowski wro=
te:
> On 09.12.2015 13:08, Chanwoo Choi wrote:
>> This patch adds the bus noes using VDD_MIF for Exynos4x12 SoC.
>=20
> s/noes/nodes/

OK.

>=20
>> Exynos4x12 has the following AXI buses to translate data
>> between DRAM and DMC/ACP/C2C.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos4x12.dtsi | 72 ++++++++++++++++++++++++++++=
+++++++++++
>>  1 file changed, 72 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/e=
xynos4x12.dtsi
>> index b77dac61ffb5..3bcf0939755e 100644
>> --- a/arch/arm/boot/dts/exynos4x12.dtsi
>> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
>> @@ -282,6 +282,78 @@
>>  		clocks =3D <&clock CLK_SMMU_LITE1>, <&clock CLK_FIMC_LITE1>;
>>  		#iommu-cells =3D <0>;
>>  	};
>> +
>> +	bus_dmc: bus_dmc {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DIV_DMC>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_dmc_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_acp: bus_acp {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DIV_ACP>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_acp_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_c2c: bus_c2c {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DIV_C2C>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_dmc_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_dmc_opp_table: opp_table1 {
>> +		compatible =3D "operating-points-v2";
>> +		opp-shared;
>> +
>> +		opp00 {
>> +			opp-hz =3D /bits/ 64 <100000000>;
>> +			opp-microvolt =3D <900000>;
>> +		};
>> +		opp01 {
>> +			opp-hz =3D /bits/ 64 <134000000>;
>> +			opp-microvolt =3D <900000>;
>> +		};
>> +		opp02 {
>> +			opp-hz =3D /bits/ 64 <160000000>;
>> +			opp-microvolt =3D <900000>;
>> +		};
>> +		opp03 {
>> +			opp-hz =3D /bits/ 64 <200000000>;
>> +			opp-microvolt =3D <950000>;
>=20
> The exyno4_bus.c (from mainline) uses 267 MHz here. Why choosing 200 =
MHz?

There is no special reason.
I'll change it (200MHz -> 267MHz).

Best Regards,
Chanwoo Choi

