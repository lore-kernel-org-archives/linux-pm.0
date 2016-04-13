From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 6/7] ARM: dts: Add bus nodes using VDD_INT for Exynos542x
 SoC
Date: Thu, 14 Apr 2016 08:16:47 +0900
Message-ID: <570ED35F.8030401@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-7-git-send-email-cw00.choi@samsung.com>
 <570CD3AF.8040206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55883 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773AbcDMXQv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2016 19:16:51 -0400
In-reply-to: <570CD3AF.8040206@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 2016=EB=85=84 04=EC=9B=94 12=EC=9D=BC 19:53, Krzysztof Kozlowski wro=
te:
> On 04/08/2016 07:00 AM, Chanwoo Choi wrote:
>> This patch adds the AMBA bus nodes using VDD_INT for Exynos542x SoC.
>> Exynos542x has the following AMBA buses to translate data between
>> DRAM and sub-blocks.
>>
>> Following list specifies the detailed correlation between sub-block =
and clock:
>> - CLK_DOUT_ACLK400_WCORE clock for WCORE's AXI
>> - CLK_DOUT_ACLK100_NOC for NoC (Network on Chip)'s AXI
>> - CLK_DOUT_PCLK200_FSYS for FSYS's APB
>> - CLK_DOUT_ACLK200_FSYS for FSYS's AXI
>> - CLK_DOUT_ACLK200_FSYS2 for FSYS2's AXI
>> - CLK_DOUT_ACLK333 for MFC's AXI
>> - CLK_DOUT_ACLK266 for GEN's AXI
>> - CLK_DOUT_ACLK66 for PERIC/PERIR's AXI
>> - CLK_DOUT_ACLK333_G2D for G2D's AXI
>> - CLK_DOUT_ACLK266_G2D for ACP's AXI
>> - CLK_DOUT_ACLK300_JPEG for JPEG's AXI
>> - CLK_DOUT_ACLK166 for JPEG's APB
>> - CLK_DOUT_ACLK300_DISP1 for FIMD's AXI
>> - CLK_DOUT_ACLK400_DISP1 for DISP1's AXI
>> - CLK_DOUT_ACLK300_GSCL for GSCL Scaler's AXI
>> - CLK_DOUT_ACLK400_MSCL for MSCL's AXI
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5420.dtsi | 371 +++++++++++++++++++++++++++=
+++++++++++
>>  1 file changed, 371 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/e=
xynos5420.dtsi
>> index d80f3b66f017..1340024fa882 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -1224,6 +1224,377 @@
>>  		power-domains =3D <&disp_pd>;
>>  		#iommu-cells =3D <0>;
>>  	};
>> +
>> +	bus_wcore: bus_wcore {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_ACLK400_WCORE>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_wcore_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_noc: bus_noc {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_ACLK100_NOC>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_noc_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_fsys_apb: bus_fsys_apb {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_PCLK200_FSYS>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_fsys_apb_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_fsys: bus_fsys {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_ACLK200_FSYS>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_fsys_apb_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_fsys2: bus_fsys2 {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_ACLK200_FSYS2>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_fsys2_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_mfc: bus_mfc {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_ACLK333>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_mfc_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_gen: bus_gen {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_ACLK266>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_gen_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_peri: bus_peri {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_ACLK66>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_peri_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_g2d: bus_g2d {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_ACLK333_G2D>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_g2d_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_g2d_acp: bus_g2d_acp {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_ACLK266_G2D>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_g2d_acp_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_jpeg: bus_jpeg {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_ACLK300_JPEG>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_jpeg_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_jpeg_apb: bus_jpeg_apb {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_ACLK166>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_jpeg_apb_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_disp1_fimd: bus_disp1_fimd {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_ACLK300_DISP1>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_disp1_fimd_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_disp1: bus_disp1 {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_ACLK400_DISP1>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_disp1_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_gscl_scaler: bus_gscl_scaler {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_ACLK300_GSCL>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_gscl_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_mscl: bus_mscl {
>> +		compatible =3D "samsung,exynos-bus";
>> +		clocks =3D <&clock CLK_DOUT_ACLK400_MSCL>;
>> +		clock-names =3D "bus";
>> +		operating-points-v2 =3D <&bus_mscl_opp_table>;
>> +		status =3D "disabled";
>> +	};
>> +
>> +	bus_wcore_opp_table: opp_table2 {
>> +		compatible =3D "operating-points-v2";
>> +
>> +		opp00 {
>> +			opp-hz =3D /bits/ 64 <84000000>;
>> +			opp-microvolt =3D <925000>;
>> +		};
>> +		opp01 {
>> +			opp-hz =3D /bits/ 64 <111000000>;
>> +			opp-microvolt =3D <950000>;
>> +		};
>> +		opp02 {
>> +			opp-hz =3D /bits/ 64 <222000000>;
>> +			opp-microvolt =3D <950000>;
>> +		};
>> +		opp03 {
>> +			opp-hz =3D /bits/ 64 <333000000>;
>> +			opp-microvolt =3D <950000>;
>> +		};
>> +		opp04 {
>> +			opp-hz =3D /bits/ 64 <400000000>;
>> +			opp-microvolt =3D <987500>;
>> +		};
>> +	};
>> +
>> +	bus_noc_opp_table: opp_table3 {
>> +		compatible =3D "operating-points-v2";
>> +
>> +		opp00 {
>> +			opp-hz =3D /bits/ 64 <66000000>;
>=20
> 67000000 so it won't be round down?

I'll change it. 66000000 -> 67000000.

>=20
> Beside that looks good. I am assuming the same apply strategy - I can
> take the DTS changes the bindings got accepted.
>=20
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Thanks for the review.

Best Regards,
Chanwoo Choi
