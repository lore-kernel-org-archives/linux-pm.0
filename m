From: Leela Krishna Amudala <leela.krishna@linaro.org>
Subject: [PATCH 0/2] Add generic cpu power control functions for exynos
Date: Thu, 24 Apr 2014 15:01:57 +0530
Message-ID: <1398331919-28321-1-git-send-email-leela.krishna@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: daniel.lezcano@linaro.org, nicolas.pitre@linaro.org, kgene.kim@samsung.com, amit.kucheria@linaro.org
List-Id: linux-pm@vger.kernel.org

This patchset adds the generic cpu power control functions for
exynos based SoCs to power up/down and to know the status of the cpu.

Note: This series has been rebased on 3.15-rc1 and tested on 
Exynos based Origen(Cortex-A9) and Arndale-octa(Cortex A7,A15) boards.

Leela Krishna Amudala (2):
  ARM: EXYNOS: Add generic cpu power control functions for all exynos
    based SoCs
  ARM: EXYNOS: use generic exynos cpu power control functions

 arch/arm/mach-exynos/common.h   |    3 +++
 arch/arm/mach-exynos/platsmp.c  |    9 +++------
 arch/arm/mach-exynos/pm.c       |   36 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/regs-pmu.h |    6 ++++++
 4 files changed, 48 insertions(+), 6 deletions(-)

-- 
1.7.9.5
