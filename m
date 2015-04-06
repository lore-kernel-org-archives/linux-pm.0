From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [RFC/PATCH 0/4] Add cpuidle support for r8a7791
Date: Mon, 6 Apr 2015 12:50:40 +0900
Message-ID: <1428292244-2160-1-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: horms@verge.net.au, rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>
List-Id: linux-pm@vger.kernel.org

Hello

These patches add cpuidle support for Renesas r8a7791 SoC.
The r8a7791 cpuidle supports WFI and the cpu power state(Core-Standby)
using Generic ARM CPU idle driver(cpuidle-arm).

Based on : next-20150402
Tested on : koelsch board

Keita Kobayashi (4):
  ARM: cpuidle: Add cpuidle support for R-Car Gen2 series
  ARM: shmobile: Add cpuidle_ops for R-Car cpuidle
  ARM: shmobile: dtsi: Add cpuidle parameters into each cpu for r8a7791
  ARM: shmobile: Enable Renesas R-Car cpuidle for shmobile_defconfig

 arch/arm/boot/dts/r8a7791.dtsi        | 13 +++++++++++++
 arch/arm/configs/shmobile_defconfig   |  2 ++
 arch/arm/mach-shmobile/platsmp-apmu.c | 11 +++++++++--
 arch/arm/mach-shmobile/platsmp-apmu.h |  1 +
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 17 +++++++++++++++++
 drivers/cpuidle/Kconfig.arm           |  8 ++++++++
 6 files changed, 50 insertions(+), 2 deletions(-)

-- 
1.9.1

