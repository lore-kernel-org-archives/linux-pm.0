From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v5 3/9] ARM: EXYNOS: Move pmu specific headers under
 "linux/soc/samsung"
Date: Fri, 13 Nov 2015 19:06:26 +0900
Message-ID: <5645B622.2000808@samsung.com>
References: <1447406983-27835-1-git-send-email-pankaj.dubey@samsung.com>
 <1447406983-27835-4-git-send-email-pankaj.dubey@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:24415 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624AbbKMKGa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2015 05:06:30 -0500
In-reply-to: <1447406983-27835-4-git-send-email-pankaj.dubey@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pankaj Dubey <pankaj.dubey@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, thomas.ab@samsung.com, amitdanielk@gmail.com, olof@lixom.net, khilman@linaro.org, arnd@arndb.de

On 13.11.2015 18:29, Pankaj Dubey wrote:
> Moving Exynos PMU specific header file into "include/linux/soc/samsung"
> thus updated affected files under "mach-exynos" to use new location of
> these header files.
> 
> Signed-off-by: Amit Daniel Kachhap <amitdanielk@gmail.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c                                       | 2 +-
>  arch/arm/mach-exynos/mcpm-exynos.c                                  | 2 +-
>  arch/arm/mach-exynos/platsmp.c                                      | 2 +-
>  arch/arm/mach-exynos/pm.c                                           | 4 ++--
>  arch/arm/mach-exynos/pmu.c                                          | 6 +++---
>  arch/arm/mach-exynos/suspend.c                                      | 4 ++--
>  {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h    | 6 +++---
>  .../regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h       | 6 +++---
>  8 files changed, 16 insertions(+), 16 deletions(-)
>  rename {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h (81%)
>  rename arch/arm/mach-exynos/regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h (99%)
> 

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

