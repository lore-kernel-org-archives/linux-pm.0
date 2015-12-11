From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 20/20] ARM: dts: Add support of bus frequency for
 exynos4412-trats/odroidu3
Date: Fri, 11 Dec 2015 17:35:58 +0900
Message-ID: <566A8AEE.1020601@samsung.com>
References: <1449810479-14763-1-git-send-email-cw00.choi@samsung.com>
 <1449810479-14763-21-git-send-email-cw00.choi@samsung.com>
 <566A7952.700@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:34800 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbbLKIgL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2015 03:36:11 -0500
In-reply-to: <566A7952.700@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

On 2015=EB=85=84 12=EC=9B=94 11=EC=9D=BC 16:20, Krzysztof Kozlowski wro=
te:
> On 11.12.2015 14:07, Chanwoo Choi wrote:
>> THis patch adds the bus device tree nodes for both MIF (Memory) and =
INT
>> (Internal) block to enable the bus frequency.
>>
>> The DMC bus is parent device in MIF block using VDD_MIF and the LEFT=
BUS
>> bus is parent device in INT block using VDD_INT.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> [linux.amoon: Tested on Odroid U3]
>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 47 ++++++++++++++=
++++++++++
>>  arch/arm/boot/dts/exynos4412-trats2.dts         | 48 ++++++++++++++=
+++++++++++
>>  2 files changed, 95 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/=
arm/boot/dts/exynos4412-odroid-common.dtsi
>> index 7bd65026761e..b6818aec7cf9 100644
>> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>> @@ -501,3 +501,50 @@
>>  &watchdog {
>>  	status =3D "okay";
>>  };
>> +
>> +&bus_acp {
>> +	devfreq =3D <&bus_dmc>;
>> +	status =3D "okay";
>> +};
>=20
> I meant put them in proper place, respecting alphabetical order. The =
'b'
> comes before 'w'.
>=20
> As for the new nodes (bus_XXX) your previous sorting (first parent, t=
hen
> passive) was also okay - it had sense. This is up to you. Just put
> everything not at the end of file.

OK. I'll reorder them. Thanks for review.

[snip]

Best Regards,
Chanwoo Choi
