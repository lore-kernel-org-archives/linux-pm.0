From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 0/6] thermal: exynos: Fixes for v3.12
Date: Thu, 03 Oct 2013 15:29:47 +0200
Message-ID: <20131003152947.7c39a16b@amdc308.digital.local>
References: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49761 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104Ab3JCN34 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 09:29:56 -0400
In-reply-to: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Dear All,

> This patch series is divided into two parts:
> 1. Device tree node definition and enabelement for TMU at Exynos4412
> (Trats2) 2. Exynos thermal subsystem regressions for v3.12-rc1.
> Several commits were necessary to properly fix regression for TMU
> test MUX address setting after reset.

Zhang or Eduardo - will you find time to review those changes?
They have already been reviewed by Amit.

Now we have -rc3 and there is no feedback for regression/critical
patches (posted for -rc1).

> 
> Test HW:
> - Exynos4412 - TRATS2 board (Linux v3.12-rc1)
> 
> Lukasz Majewski (6):
>   thermal: exynos: fix: Return from exynos_report_trigger() when
>     therm_dev is NULL
>   thermal: exynos: Provide separate TMU data for Exynos4412
>   thermal: exynos: Provide initial setting for TMU's test MUX address
>     at Exynos4412
>   thermal: exynos: Replace SOC_ARCH_EXYNOS with SOC_ARCH_EXYNOS5250
>   ARM: dts: exynos4x12: Device tree node definition for TMU on
>     Exynos4x12
>   ARM: dts: exynos4412-trats2: Enable TMU support at Trats2
> 
>  arch/arm/boot/dts/exynos4412-trats2.dts         |    5 +++++
>  arch/arm/boot/dts/exynos4x12.dtsi               |   10 +++++++++
>  drivers/thermal/samsung/exynos_thermal_common.c |    2 +-
>  drivers/thermal/samsung/exynos_tmu.c            |   12 +++++++----
>  drivers/thermal/samsung/exynos_tmu.h            |    3 ++-
>  drivers/thermal/samsung/exynos_tmu_data.c       |   26
> +++++++++++++++++------
> drivers/thermal/samsung/exynos_tmu_data.h       |   13 +++++++++++- 7
> files changed, 58 insertions(+), 13 deletions(-)
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
