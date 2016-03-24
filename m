From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v5 00/21] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
Date: Fri, 25 Mar 2016 08:38:13 +0900
Message-ID: <56F47A65.6060401@samsung.com>
References: <1458793530-31897-1-git-send-email-cw00.choi@samsung.com>
 <56F3FBA7.9070702@fivetechno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45881 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbcCXXiS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 19:38:18 -0400
In-reply-to: <56F3FBA7.9070702@fivetechno.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Reichl <m.reichl@fivetechno.de>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, tjakobi@math.uni-bielefeld.de, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi Markus,

On 2016=EB=85=84 03=EC=9B=94 24=EC=9D=BC 23:37, Markus Reichl wrote:
> Hi Chanwoo,
>=20
> Am 24.03.2016 um 05:25 schrieb Chanwoo Choi:
>> Dear all,
>>
>> This patchset uses the DEVFREQ_TRANSITION_NOTIFIER notifier to conne=
cth
>> devfreq device using ondemand governor and devfreq device using pass=
ive
>> governor. Also I fix the some issue reported by 'Tobias Jakobi' and =
add the
>> detailed issue information. But, this patchset don't modify the anyt=
hing of
>> Device Tree patches (patch12 ~ patch21) which already got the review=
ed-by
>> from Exynos Soc Maintainer.
>>
>> I tested it on exynos3250-rinato and exynos4412-odroidu3 board.
>=20
> On exynos4412-odroidu3 board:
>=20
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>


Thanks for your test.

Best Regards,
Chanwoo Choi

[snip]
