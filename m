From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [PATCH 0/6] ARM: shmobile: Add Core-Standby for CPUIDLE
Date: Fri, 1 Aug 2014 18:48:07 +0900
Message-ID: <53DB6257.7090109@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
Cc: horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, rjw@rjwysocki.net
List-Id: linux-pm@vger.kernel.org

Hi Simon and Rafael

These patches add Core-Standby state for CPUIDLE support
to the r8a7790/r8a7791 SoCs. This patch series was tested on
both Lager and Koelsch board.

This patch series is based on renesas-devel-v3.16-rc7-20140731v2 tag

Keita Kobayashi (6):
  ARM: shmobile: APMU: Move the shmobile_smp_hook call
  ARM: shmobile: APMU: Add CPUIdle function
  cpuidle: shmobile: Add CPUIdle driver
  ARM: shmobile: Add initialization cpuidle
  ARM: shmobile: Add CPU notifier for CPUIdle boot vector
  ARM: shmobile: Enable CPUIdle configuration for shmobile_defconfig

 arch/arm/configs/shmobile_defconfig   |    2 +
 arch/arm/mach-shmobile/common.h       |    1 +
 arch/arm/mach-shmobile/cpuidle.c      |   46 +++++++++++++++++++++
 arch/arm/mach-shmobile/platsmp-apmu.c |   21 ++++++++--
 drivers/cpuidle/Kconfig.arm           |    6 +++
 drivers/cpuidle/Makefile              |    1 +
 drivers/cpuidle/cpuidle-shmobile.c    |   71 +++++++++++++++++++++++++++++++++
 7 files changed, 145 insertions(+), 3 deletions(-)
 create mode 100644 drivers/cpuidle/cpuidle-shmobile.c

-- 
1.7.9.5
