From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 04/19] ARM: dts: Add DMC bus frequency for
 exynos3250-rinato/monk
Date: Thu, 10 Dec 2015 09:56:33 +0900
Message-ID: <5668CDC1.7080108@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-5-git-send-email-cw00.choi@samsung.com>
 <5668CCF1.8080807@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:57214 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbbLJA4f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 19:56:35 -0500
In-reply-to: <5668CCF1.8080807@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 09:53, Krzysztof Kozlowski wro=
te:
> On 09.12.2015 13:07, Chanwoo Choi wrote:
>> This patch adds the DMC (Dynamic Memory Controller) bus frequency no=
de
>> which includes the devfreq-events and regulator properties. The bus
>> frequency support the DVFS (Dynamic Voltage Frequency Scaling) featu=
re
>> with ondemand governor.
>>
>> The devfreq-events (ppmu_dmc0*) can monitor the utilization of DMC b=
us
>> on runtime and the buck1_reg (VDD_MIF power line) supplies the power=
 to
>> the DMC block.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos3250-monk.dts   | 6 ++++++
>>  arch/arm/boot/dts/exynos3250-rinato.dts | 6 ++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/d=
ts/exynos3250-monk.dts
>> index 443a35085846..d982586a6533 100644
>> --- a/arch/arm/boot/dts/exynos3250-monk.dts
>> +++ b/arch/arm/boot/dts/exynos3250-monk.dts
>> @@ -498,6 +498,12 @@
>>  	};
>>  };
>> =20
>> +&bus_dmc {
>> +	devfreq-events =3D <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>> +	vdd-supply =3D <&buck1_reg>;
>> +	status =3D "okay";
>> +};
>> +
>>  &xusbxti {
>>  	clock-frequency =3D <24000000>;
>>  };
>> diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot=
/dts/exynos3250-rinato.dts
>> index 3e64d5dcdd60..61477943015b 100644
>> --- a/arch/arm/boot/dts/exynos3250-rinato.dts
>> +++ b/arch/arm/boot/dts/exynos3250-rinato.dts
>> @@ -675,6 +675,12 @@
>>  	};
>>  };
>> =20
>> +&bus_dmc {
>> +	devfreq-events =3D <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>> +	vdd-supply =3D <&buck1_reg>;
>> +	status =3D "okay";
>> +};
>=20
> I would prefer to put this in alphabetical order... which could be
> tricky because the nodes are not entirely sorted. Maybe after the "&a=
dc"
> node?

OK. I'll move it.

>=20
> Anyway the change looks good:
>=20
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Thanks for your review.

Regards,
Chanwoo Choi

