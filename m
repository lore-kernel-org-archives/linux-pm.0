From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 0/6] thermal: exynos: Fixes for v3.12
Date: Tue, 24 Sep 2013 11:29:59 +0200
Message-ID: <5975797.eclhCJt8Bu@amdc1227>
References: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On Tuesday 24 of September 2013 10:08:16 Lukasz Majewski wrote:
> This patch series is divided into two parts:
> 1. Device tree node definition and enabelement for TMU at Exynos4412 (Trats2)
> 2. Exynos thermal subsystem regressions for v3.12-rc1. Several commits were 
>    necessary to properly fix regression for TMU test MUX address setting after
>    reset.
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
>  drivers/thermal/samsung/exynos_tmu_data.c       |   26 +++++++++++++++++------
>  drivers/thermal/samsung/exynos_tmu_data.h       |   13 +++++++++++-
>  7 files changed, 58 insertions(+), 13 deletions(-)
> 

For the whole series:

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
