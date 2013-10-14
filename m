From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 0/5] thermal: exynos: Fixes for v3.12
Date: Mon, 14 Oct 2013 07:46:35 +0200
Message-ID: <20131014074635.77fd9f6e@amdc308.digital.local>
References: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
 <1381300194-13134-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58771 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab3JNFqn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2013 01:46:43 -0400
In-reply-to: <1381300194-13134-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, kgene.kim@samsung.com
Cc: Lukasz Majewski <l.majewski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, devicetree@vger.kernel.org, Amit Daniel Kachhap <amit.daniel@samsung.com>, linux-samsung-soc@vger.kernel.org

Hi Zhang, Eduardo,

> This patch series is divided into two parts:
> 1. Device tree node definition and enabelement for TMU at Exynos4412
> (Trats2) 2. Exynos thermal subsystem regressions for v3.12-rc4.
> Several commits were necessary to properly fix regression for TMU
> test MUX address setting after reset.
> 
> Test HW:
> - Exynos4412 - TRATS2 board (Linux v3.12-rc4)
> SHA1: 8b5ede69d24db939f52b47effff2f6fe1e83e08b
> 
> 
> Lukasz Majewski (5):
>   thermal: exynos: Remove check for thermal device pointer at
>     exynos_report_trigger()
>   thermal: exynos: Provide separate TMU data for Exynos4412
>   thermal: exynos: Provide initial setting for TMU's test MUX address
>     at Exynos4412
>   ARM: dts: exynos4x12: Device tree node definition for TMU on
>     Exynos4x12
>   ARM: dts: exynos4412-trats2: Enable TMU support at Trats2
> 

Zhang, Eduardo - any comments?

Would it be possible to add them to v3.12 since they do fix critical
error and regression on Exynos4412.


>  arch/arm/boot/dts/exynos4412-trats2.dts         |    5 ++++
>  arch/arm/boot/dts/exynos4x12.dtsi               |   10 ++++++++
>  drivers/thermal/samsung/exynos_thermal_common.c |    2 --
>  drivers/thermal/samsung/exynos_tmu.c            |   12 ++++++---
>  drivers/thermal/samsung/exynos_tmu.h            |    7 +++++-
>  drivers/thermal/samsung/exynos_tmu_data.c       |   30
> ++++++++++++++++++-----
> drivers/thermal/samsung/exynos_tmu_data.h       |   13 +++++++++- 7
> files changed, 65 insertions(+), 14 deletions(-)
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
