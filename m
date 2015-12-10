From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 19/19] ARM: dts: Add support of bus frequency for
 exynos4412-trats/odroidu3
Date: Thu, 10 Dec 2015 16:23:14 +0900
Message-ID: <56692862.3040204@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-20-git-send-email-cw00.choi@samsung.com>
 <566924E6.6070203@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:45292 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbLJHXR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 02:23:17 -0500
In-reply-to: <566924E6.6070203@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 16:08, Krzysztof Kozlowski wro=
te:
> On 09.12.2015 13:08, Chanwoo Choi wrote:
>> THis patch adds the bus device tree nodes for both MIF (Memory) and =
INT
>> (Internal) block to enable the bus frequency.
>>
>> The DMC bus is parent device in MIF block using VDD_MIF and the LEFT=
BUS
>> bus is parent device in INT block using VDD_INT.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 47 ++++++++++++++=
+++++++++++
>>  arch/arm/boot/dts/exynos4412-trats2.dts         | 47 ++++++++++++++=
+++++++++++
>>  2 files changed, 94 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/=
arm/boot/dts/exynos4412-odroid-common.dtsi
>> index 171dea1e3e4a..12d08242a179 100644
>> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>> @@ -544,3 +544,50 @@
>>  		};
>>  	};
>>  };
>> +
>> +&bus_dmc {
>> +	devfreq-events =3D <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>> +	vdd-supply =3D <&buck1_reg>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_acp {
>> +	devfreq =3D <&bus_dmc>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_c2c {
>> +	devfreq =3D <&bus_dmc>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_leftbus {
>> +	devfreq-events =3D <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>> +	vdd-supply =3D <&buck3_reg>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_rightbus {
>> +	devfreq =3D <&bus_leftbus>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_display {
>> +	devfreq =3D <&bus_leftbus>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_fsys {
>> +	devfreq =3D <&bus_leftbus>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_peri {
>> +	devfreq =3D <&bus_leftbus>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_mfc {
>> +	devfreq =3D <&bus_leftbus>;
>> +	status =3D "okay";
>> +};
>> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot=
/dts/exynos4412-trats2.dts
>> index 40a474c4374b..aecd545803ad 100644
>> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
>> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
>> @@ -1286,3 +1286,50 @@
>>  	vtmu-supply =3D <&ldo10_reg>;
>>  	status =3D "okay";
>>  };
>> +
>> +&bus_dmc {
>> +	devfreq-events =3D <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>> +	vdd-supply =3D <&buck1_reg>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_acp {
>> +	devfreq =3D <&bus_dmc>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_c2c {
>> +	devfreq =3D <&bus_dmc>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_leftbus {
>> +	devfreq-events =3D <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>> +	vdd-supply =3D <&buck3_reg>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_rightbus {
>> +	devfreq =3D <&bus_leftbus>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_display {
>> +	devfreq =3D <&bus_leftbus>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_fsys {
>> +	devfreq =3D <&bus_leftbus>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_peri {
>> +	devfreq =3D <&bus_leftbus>;
>> +	status =3D "okay";
>> +};
>> +
>> +&bus_mfc {
>> +	devfreq =3D <&bus_leftbus>;
>> +	status =3D "okay";
>> +};
>=20
> The nodes in both files are mostly sorted alphabetically. Could you
> place them in such order as well?

Okay. I'll sort them alphabetically.

Best Regards,
Chanwoo Choi



