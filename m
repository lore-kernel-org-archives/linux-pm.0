From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 7/7] ARM: dts: Add support of Bus frequency using VDD_INT
 for exynos5422-odroidxu3
Date: Thu, 14 Apr 2016 08:14:57 +0900
Message-ID: <570ED2F1.1080006@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
 <1460091646-28701-8-git-send-email-cw00.choi@samsung.com>
 <570CD4F7.6000700@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:56264 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbcDMXPC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2016 19:15:02 -0400
In-reply-to: <570CD4F7.6000700@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 2016=EB=85=84 04=EC=9B=94 12=EC=9D=BC 19:59, Krzysztof Kozlowski wro=
te:
> On 04/08/2016 07:00 AM, Chanwoo Choi wrote:
>> This patch adds the bus device tree nodes for INT (Internal) block
>> to enable the AMBA bus frequency scaling and add the NoC (Network on=
 Chip)
>> Probe Device Tree node to measure the bandwidht for AMBA AXI bus.
>>
>> The WCORE bus bus is parent device in INT block using VDD_INT.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 99 +++++++++++=
+++++++++++
>>  1 file changed, 99 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/ar=
ch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>> index 1bd507bfa750..2a74abe6fc5d 100644
>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>> @@ -361,6 +361,22 @@
>>  	cap-sd-highspeed;
>>  };
>> =20
>> +&nocp_mem0_0 {
>> +	status =3D "okay";
>> +};
>> +
>> +&nocp_mem0_1 {
>> +	status =3D "okay";
>> +};
>> +
>> +&nocp_mem0_2 {
>> +	status =3D "okay";
>> +};
>> +
>> +&nocp_mem0_3 {
>> +	status =3D "okay";
>> +};
>> +
>>  &pinctrl_0 {
>>  	hdmi_hpd_irq: hdmi-hpd-irq {
>>  		samsung,pins =3D "gpx3-7";
>> @@ -432,3 +448,86 @@
>>  	vdd33-supply =3D <&ldo9_reg>;
>>  	vdd10-supply =3D <&ldo11_reg>;
>>  };
>> +
>> +&bus_wcore {
>> +	devfreq-events =3D <&nocp_mem0_0>, <&nocp_mem0_1>,
>> +			<&nocp_mem0_2>, <&nocp_mem0_3>;
>> +	vdd-supply =3D <&buck3_reg>;
>> +	exynos,saturation-ratio =3D <100>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_noc {
>> +	devfreq =3D <&bus_wcore>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_fsys_apb {
>> +	devfreq =3D <&bus_wcore>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_fsys {
>> +	devfreq =3D <&bus_wcore>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_fsys2 {
>> +	devfreq =3D <&bus_wcore>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_mfc {
>> +	devfreq =3D <&bus_wcore>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_gen {
>> +	devfreq =3D <&bus_wcore>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_peri {
>> +	devfreq =3D <&bus_wcore>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_g2d {
>> +	devfreq =3D <&bus_wcore>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_g2d_acp {
>> +	devfreq =3D <&bus_wcore>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_jpeg {
>> +	devfreq =3D <&bus_wcore>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_jpeg_apb {
>> +	devfreq =3D <&bus_wcore>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_disp1_fimd {
>> +	devfreq =3D <&bus_wcore>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_disp1 {
>> +	devfreq =3D <&bus_wcore>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_gscl_scaler {
>> +	devfreq =3D <&bus_wcore>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_mscl {
>> +	devfreq =3D <&bus_wcore>;
>> +	status =3D "okay";
>> +};
>=20
> Could you put the bus nodes in alphabetical order, both between them =
and
> in relation to others (so before &clock_audss)? Let's keep the file o=
rdered.

OK. I'll reorder them.

Best Regards,
Chanwoo Choi
