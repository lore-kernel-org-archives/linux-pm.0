From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] ARM: dts: exynos: Devfreq for v4.7
Date: Tue, 10 May 2016 16:18:20 +0200
Message-ID: <4199175.Sym2be3WAj@wuerfel>
References: <1462367136-28627-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:61115 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbcEJOS6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 May 2016 10:18:58 -0400
In-Reply-To: <1462367136-28627-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@kernel.org>, arm@kernel.org, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, myungjoo.ham@samsung.com, cw00.choi@samsung.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net

On Wednesday 04 May 2016 15:05:36 Krzysztof Kozlowski wrote:
> Topic branch for Device Tree changes adding new generic devfreq driver, for
> v4.7:
> 1. Add bus nodes for Exynos3250, Exynos4x12, Exynos4210 and Exynos542x.
> 2. Split out common PPMU (Performance Monitoring Unit) nodes into separate
>    DTSI. The PPMU provides performance data for devfreq.
> 3. Add NoCP (Network on Chip Probe) node for Exynos542x. On this SoC, like PPMU
>    on older designs, provides performance data for devfreq.
> 4. Enable DFVS (Dynamic Voltage and Frequency Scaling) on boards:
>    - Exynos3250 Rinato,
>    - Exynos4412 Odroid-X/X2/U3 and Trats2,
>    - Exynos5422 Odroid XU3/XU3-Lite/XU4.
> 
> 

Merged into next/late now, so we can track the clk dependency more easily.

Thanks,

	Arnd
