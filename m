From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v6 9/9] drivers: soc: Add support for Exynos PMU driver
Date: Tue, 17 Nov 2015 15:16:57 +0900
Message-ID: <564AC659.5090409@samsung.com>
References: <1447740351-14246-1-git-send-email-pankaj.dubey@samsung.com>
 <1447740351-14246-10-git-send-email-pankaj.dubey@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:40117 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbbKQGRF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 01:17:05 -0500
In-reply-to: <1447740351-14246-10-git-send-email-pankaj.dubey@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pankaj Dubey <pankaj.dubey@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, thomas.ab@samsung.com, amitdanielk@gmail.com, olof@lixom.net, khilman@linaro.org, arnd@arndb.de

On 17.11.2015 15:05, Pankaj Dubey wrote:
> This patch moves Exynos PMU driver implementation from "arm/mach-exynos"
> to "drivers/soc/samsung". This driver is mainly used for setting misc
> bits of register from PMU IP of Exynos SoC which will be required to
> configure before Suspend/Resume. Currently all these settings are done
> in "arch/arm/mach-exynos/pmu.c" but moving ahead for ARM64 based SoC
> support, there is a need of this PMU driver in driver/* folder.
> 
> This driver uses existing DT binding information and there should
> be no functionality change in the supported platforms.
> 
> Signed-off-by: Amit Daniel Kachhap <amitdanielk@gmail.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig                                   | 1 +
>  arch/arm/mach-exynos/Makefile                                  | 4 +---
>  drivers/soc/samsung/Kconfig                                    | 4 ++++
>  drivers/soc/samsung/Makefile                                   | 2 ++
>  arch/arm/mach-exynos/pmu.c => drivers/soc/samsung/exynos-pmu.c | 0
>  {arch/arm/mach-exynos => drivers/soc/samsung}/exynos-pmu.h     | 0
>  {arch/arm/mach-exynos => drivers/soc/samsung}/exynos3250-pmu.c | 0
>  {arch/arm/mach-exynos => drivers/soc/samsung}/exynos4-pmu.c    | 0
>  {arch/arm/mach-exynos => drivers/soc/samsung}/exynos5250-pmu.c | 0
>  {arch/arm/mach-exynos => drivers/soc/samsung}/exynos5420-pmu.c | 0
>  10 files changed, 8 insertions(+), 3 deletions(-)
>  rename arch/arm/mach-exynos/pmu.c => drivers/soc/samsung/exynos-pmu.c (100%)
>  rename {arch/arm/mach-exynos => drivers/soc/samsung}/exynos-pmu.h (100%)
>  rename {arch/arm/mach-exynos => drivers/soc/samsung}/exynos3250-pmu.c (100%)
>  rename {arch/arm/mach-exynos => drivers/soc/samsung}/exynos4-pmu.c (100%)
>  rename {arch/arm/mach-exynos => drivers/soc/samsung}/exynos5250-pmu.c (100%)
>  rename {arch/arm/mach-exynos => drivers/soc/samsung}/exynos5420-pmu.c (100%)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

