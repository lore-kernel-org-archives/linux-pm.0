From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [RFC/PATCH v2 0/5] Add cpuidle support for r8a7791
Date: Thu, 16 Apr 2015 19:35:35 +0900
Message-ID: <1429180540-5692-1-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: horms@verge.net.au, rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, magnus.damm@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>
List-Id: linux-pm@vger.kernel.org

Hello

These patches add cpuidle support for Renesas r8a7791 SoC.
The r8a7791 cpuidle supports WFI and the cpu power state(Core-Standby)
using Generic ARM CPU idle driver(cpuidle-arm).
Generic ARM CPU idle driver have been merged in linux-pm.git / pm+acpi-4.1-rc1 tag.

Based on : renesas.git / renesas-devel-20150413-v4.0 tag
Tested on : koelsch board

Changes from v1:
 - Change "select" to "depend on"
 - Document a new enable method of Renesas cpuidle

Keita Kobayashi (5):
  ARM: cpuidle: Add cpuidle support for R-Car Gen2 series
  ARM: shmobile: Add cpuidle_ops for R-Car cpuidle
  devicetree: bindings: Add new cpuidle enable method for Renesas R-car
    SoCs
  ARM: shmobile: dtsi: Add cpuidle parameters into each cpu for r8a7791
  ARM: shmobile: Enable Renesas R-Car cpuidle for shmobile_defconfig

 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/boot/dts/r8a7791.dtsi                 | 13 +++++++++++++
 arch/arm/configs/shmobile_defconfig            |  3 +++
 arch/arm/mach-shmobile/platsmp-apmu.c          | 14 +++++++++++---
 arch/arm/mach-shmobile/platsmp-apmu.h          |  1 +
 arch/arm/mach-shmobile/pm-rcar-gen2.c          | 17 +++++++++++++++++
 drivers/cpuidle/Kconfig.arm                    |  8 ++++++++
 7 files changed, 54 insertions(+), 3 deletions(-)

-- 
1.9.1

