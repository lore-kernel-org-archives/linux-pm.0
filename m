From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 18/19] ARM: dts: Expand the voltage range of buck1/3
 regulator for exynos4412-odroidu3
Date: Thu, 10 Dec 2015 16:19:52 +0900
Message-ID: <56692798.7030903@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <1449634091-1842-19-git-send-email-cw00.choi@samsung.com>
 <566923A3.9050801@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:32957 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbbLJHTy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 02:19:54 -0500
In-reply-to: <566923A3.9050801@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 16:02, Krzysztof Kozlowski wro=
te:
> On 09.12.2015 13:08, Chanwoo Choi wrote:
>> This patch expands the voltage range of buck1/3 regulator due to as =
following:
>> - MIF (Memory Interface) bus frequency needs the 90000uV ~ 1050000uV=
 V.
>> - INT (Internal) bus frequency needs 90000uV ~ 1000000uV.
>=20
> 90000->900000 and duplicated "uV V". Maybe just:
> 900 - 1050 mV
> 900 - 1000 mV
> ?

OK. I'll modify the patch description.

>=20
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>=20
> For the contents of patch:
>=20
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best Regards,
Chanwoo CHoi

