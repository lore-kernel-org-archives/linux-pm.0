From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [Patch v7 0/6] add cpuidle support for Exynos5420
Date: Tue, 01 Jul 2014 20:52:21 +0900
Message-ID: <03d501cf9522$eaf67200$c0e35600$@samsung.com>
References: <1402914383-20471-1-git-send-email-k.chander@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1402914383-20471-1-git-send-email-k.chander@samsung.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Chander Kashyap' <k.chander@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, nicolas.pitre@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, tomasz.figa@gmail.com
List-Id: linux-pm@vger.kernel.org

Chander Kashyap wrote:
> 
> Exynos5420 is a big-little Soc from Samsung. It has 4 A15 and 4 A7 cores.
> 
> This patchset adds cpuidle support for Exynos5420 SoC based on
> generic big.little cpuidle driver.
> 
> Tested on SMDK5420.
> Rebased on 3.16-rc1
> 
> Changelog is in respective patches.
> Chander Kashyap (5):
>   driver: cpuidle-big-little: add of_device_id structure
>   arm: exynos: add generic function to calculate cpu number
>   cpuidle: config: Add ARCH_EXYNOS entry to select cpuidle-big-little
>     driver
>   driver: cpuidle: cpuidle-big-little: init driver for Exynos5420
>   exynos: cpuidle: do not allow cpuidle registration for Exynos5420
>   mcpm: exynos: populate suspend and powered_up callbacks
> 
>  arch/arm/mach-exynos/exynos.c        |    4 +++-
>  arch/arm/mach-exynos/mcpm-exynos.c   |   36 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-exynos/regs-pmu.h      |    9 +++++++++
>  drivers/cpuidle/Kconfig.arm          |    2 +-
>  drivers/cpuidle/cpuidle-big_little.c |   12 +++++++++++-
>  5 files changed, 60 insertions(+), 3 deletions(-)
> 

+ Nicolas

Hi,

This series looks good to me and I asked Chander to test this series with
Nico's mcpm patches on smdk5420 and he said it works fine. So I will apply
this into samsung tree if Nicolas has no objection on 6/6.

BTW, one more, there are duplicated sign-off from Chander with different
e-mail address, I'm not sure it should be fine or not because I didn't see
same thing before.

Thanks,
Kukjin
