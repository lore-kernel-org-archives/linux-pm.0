From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 0/5] cpuidle: exynos: add coupled cpuidle support for
 Exynos3250
Date: Wed, 18 Mar 2015 17:05:42 +0100
Message-ID: <2630890.UpA1dPndHV@amdc1032>
References: <1426684197-22281-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1426684197-22281-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Colin Cross <ccross@google.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 18, 2015 02:09:52 PM Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> The following patchset adds coupled cpuidle support for Exynos3250
> to an existing cpuidle-exynos driver.  As a result it enables AFTR
> mode to be used by default on Exynos3250 without the need to hot
> unplug CPU1 first.
> 
> The patchset depends on:
> - for-next branch (commit: 77105c882ba6) of linux-samsung.git
>   kernel tree
> - "[PATCH] ARM: EXYNOS: Fix failed second suspend on Exynos4"
>   (https://lkml.org/lkml/2015/2/3/481)
> - "[PATCH v3 0/4] ARM: EXYNOS: cpuidle: add AFTR mode support for
>   Exynos3250"
>   (https://lkml.org/lkml/2015/3/18/282)

This patchset also applies fine on top of v4 of the above patchset:
"[PATCH v4 0/4] ARM: EXYNOS: cpuidle: add AFTR mode support for Exynos3250"
(https://lkml.org/lkml/2015/3/18/505).

> Changes since v1:
> - rebased on top of for-next branch (commit: 77105c882ba6) of
>   linux-samsung.git kernel tree
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 
> Bartlomiej Zolnierkiewicz (5):
>   ARM: EXYNOS: fix exynos_boot_secondary() return value on timeout
>   ARM: EXYNOS: make exynos_core_restart() less verbose
>   ARM: EXYNOS: add exynos_set_boot_addr() helper
>   ARM: EXYNOS: add exynos_get_boot_addr() helper
>   cpuidle: exynos: add coupled cpuidle support for Exynos3250
> 
>  arch/arm/include/asm/firmware.h |  4 ++
>  arch/arm/mach-exynos/common.h   |  4 +-
>  arch/arm/mach-exynos/exynos.c   |  3 +-
>  arch/arm/mach-exynos/firmware.c | 18 +++++++++
>  arch/arm/mach-exynos/platsmp.c  | 86 ++++++++++++++++++++++++++++-------------
>  arch/arm/mach-exynos/pm.c       | 51 ++++++++++++++++++++----
>  6 files changed, 129 insertions(+), 37 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
