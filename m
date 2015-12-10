From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 02/19] PM / devfreq: exynos: Add documentation for
 generic exynos bus frequency driver
Date: Thu, 10 Dec 2015 10:33:01 +0900
Message-ID: <5668D64D.5040005@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-3-git-send-email-cw00.choi@samsung.com>
 <5668C9BE.7050900@samsung.com> <5668CC37.1090300@samsung.com>
 <5668D49C.80809@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:52145 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbbLJBdE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 20:33:04 -0500
In-reply-to: <5668D49C.80809@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 10:25, Krzysztof Kozlowski wro=
te:
> On 10.12.2015 09:49, Chanwoo Choi wrote:
>> Hi,
>>
> (...)
>=20
>>>
>>>> +
>>>> +	bus_dmc: bus_dmc {
>>>> +		compatible =3D "samsung,exynos-bus";
>>>> +		clocks =3D <&cmu_dmc CLK_DIV_DMC>;
>>>> +		clock-names =3D "bus";
>>>> +		operating-points-v2 =3D <&bus_dmc_opp_table>;
>>>> +		status =3D "disabled";
>>>> +	};
>>>> +
>>>> +	bus_dmc_opp_table: opp_table0 {
>>>> +		compatible =3D "operating-points-v2";
>>>> +		opp-shared;
>>>> +
>>>> +		opp00 {
>>>
>>> Maybe use convention with frequency, like:
>>> 	opp@50000000
>>> This also used in opp.txt examples.
>>
>> In the Documentations/devicetree/bindings/opp/opp.txt,
>> the example uses the 'opp@0x'. I check the opp.txt of Linux 4.4-rc4.
>=20
> Yes, it was changed by Viresh in "PM / OPP: Rename OPP nodes as
> opp@<opp-hz>". You can find the most actual bindings in linux-next.

OK. I'll.

Best Regards,
Chanwoo Choi

