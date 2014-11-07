From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 0/2] cpuidle: exynos: add coupled cpuidle support for Exynos4210
Date: Fri, 07 Nov 2014 19:00:49 +0100
Message-ID: <1415383252-20118-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Colin Cross <ccross@google.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

The following patchset adds coupled cpuidle support for Exynos4210
to an existing cpuidle-exynos driver.  As a result it enables AFTR
mode to be used by default on Exynos4210 without the need to hot
unplug CPU1 first.

This work is heavily based on earlier cpuidle-exynos4210 driver from
Daniel Lezcano:

http://www.spinics.net/lists/linux-samsung-soc/msg28134.html

Changes from Daniel's code include:
- porting code to current kernels
- fixing it to work on my setup (by using S5P_INFORM register
  instead of S5P_VA_SYSRAM one on Revison 1.1 and retrying poking
  CPU1 out of the BOOT ROM if necessary)
- fixing rare lockup caused by waiting for CPU1 to get stuck in
  the BOOT ROM (CPU hotplug code in arch/arm/mach-exynos/platsmp.c
  doesn't require this and works fine)
- moving Exynos specific code to arch/arm/mach-exynos/pm.c
- using cpu_boot_reg_base() helper instead of BOOT_VECTOR macro
- using exynos_cpu_*() helpers instead of accessing registers
  directly
- using arch_send_wakeup_ipi_mask() instead of dsb_sev()
  (this matches CPU hotplug code in arch/arm/mach-exynos/platsmp.c)
- integrating separate exynos4210-cpuidle driver into existing
  exynos-cpuidle one

patch #1 is a fix for Exynos platform PM code preparing it for
coupled cpuidle support

patch #2 adds coupled cpuidle AFTR mode for Exynos4210

The patchset depends on:
- 'next-20141031' branch of linux-next kernel tree (it also applies
  fine to for-next branch of linux-samsung.git tree from today)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (2):
  ARM: EXYNOS: apply S5P_CENTRAL_SEQ_OPTION fix only when necessary
  cpuidle: exynos: add coupled cpuidle support for Exynos4210

 arch/arm/mach-exynos/common.h                |   4 +
 arch/arm/mach-exynos/exynos.c                |   4 +
 arch/arm/mach-exynos/platsmp.c               |   2 +-
 arch/arm/mach-exynos/pm.c                    | 133 ++++++++++++++++++++++++++-
 arch/arm/mach-exynos/suspend.c               |   4 +
 drivers/cpuidle/Kconfig.arm                  |   1 +
 drivers/cpuidle/cpuidle-exynos.c             |  62 ++++++++++++-
 include/linux/platform_data/cpuidle-exynos.h |  20 ++++
 8 files changed, 220 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/platform_data/cpuidle-exynos.h

-- 
1.8.2.3
