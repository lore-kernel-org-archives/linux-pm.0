From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 00/19] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
Date: Thu, 10 Dec 2015 11:16:16 +0900
Message-ID: <5668E070.7020503@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
 <5668CE09.3030503@samsung.com> <5668D3D5.3030509@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:36992 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbbLJCTS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 21:19:18 -0500
In-reply-to: <5668D3D5.3030509@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

On 2015=EB=85=84 12=EC=9B=94 10=EC=9D=BC 10:22, Krzysztof Kozlowski wro=
te:
> On 10.12.2015 09:57, Krzysztof Kozlowski wrote:
>> On 09.12.2015 13:07, Chanwoo Choi wrote:
>>
>> (...)
>>
>>>  .../devicetree/bindings/devfreq/exynos-bus.txt     |  383 +++++++
>>
>> How about adding this file to the MAINTAINERS to devfreq exynos entr=
y?

OK. I'll add new entry for 'devfreq exynos' as following:
=20
+SAMSUNG BUS DEVICE FREQUENCY SUPPORT
+M:     Chanwoo Choi <cw00.choi@samsung.com>
+L:     linux-pm@vger.kernel.org
+L:     linux-samsung-soc@vger.kernel.org
+T:     git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.g=
it
+S:     Supported
+F:     drivers/devfreq/exynos/exynos-bus.c
+F:     Documentation/devicetree/bindings/devfreq/exynos-bus.txt

>> Unfortunately, in current linux-next, I can find the entry for devfr=
eq
>=20
> D'oh! I meant:                        ^ I cannot find the entry for..=
=2E
>=20
> BR,
> Krzysztof
>=20
>> exynos. However I saw patches adding such entries... aren't they mer=
ged
>> to linux-next?

Yes, it is not merged to linux-next because any git repository
don't apply this patchset. To merge the devfreq patchset to linux-next,
devfreq maintainer should send the request mail to Stephen Rothwell.

[snip]

Best Regards,
Chanwoo Choi
