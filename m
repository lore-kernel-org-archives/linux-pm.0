From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 0/7] PM / devfreq: Add NoCP devfreq-event and support
 busfreq on exyno5422-odroidxu3
Date: Mon, 11 Apr 2016 13:15:37 +0900
Message-ID: <570B24E9.5020708@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36694 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbcDKEPy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2016 00:15:54 -0400
In-reply-to: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Dear all,

On 2016=EB=85=84 04=EC=9B=94 08=EC=9D=BC 14:00, Chanwoo Choi wrote:
> This patchset support the AMBA bus frequency scaling on Exynos5422-ba=
sed
> Odroid-XU3 board. But, this series only support the bus frequency sca=
ling
> for INT (Internal) block using VDD_INT power line.
>=20
> Also, to support the bus frequency scaling for Exynos542x SoC,
> Exynos542x SoC has the specific 'NoC (Network on Chip) Probe' device
> to measure the transfered data traffic on NoC (Network on Chip)
> instead of PPMU (Platform Performance Monitoring Unit). NoC Probe dev=
ice
> provide the utilization for INT block of Exynos542x SoC.
>=20
> The generic exynos-bus frequency driver uses the 'NoC Probe' devfreq-=
event
> device (drivers/devfreq/event/exynos-nocp.c) without any modification=
=2E
> Just add the phandle of 'NoC Probe' dt node to bus dt node.
>=20
> Depend on:
> This patchset depends on patch[1] which support the generic exynos-bu=
s
> frequency driver.
>=20
> [1] https://lkml.org/lkml/2016/4/8/14
> - [PATCH v8 00/20] PM / devferq: Add generic exynos bus frequency dri=
ver and new passive governor

The dependency of these patch-set is changed from patches[1] to patches=
[2].
Because patches[1] has the possible recursive locking issue. Patches[2]=
 fix this issue.

[2] http://www.spinics.net/lists/arm-kernel/msg495976.html
- [PATCH v9 00/20] PM / devferq: Add generic exynos bus frequency drive=
r and new passive governor

[snip]

Best Regards,
Chanwoo Choi
