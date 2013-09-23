From: "Wendy Ng" <wendy.ng@broadcom.com>
Subject: [PATCH 0/3] thermal: bcm281xx: Add thermal driver
Date: Mon, 23 Sep 2013 10:51:35 -0700
Message-ID: <1379958698-7554-1-git-send-email-wendy.ng@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Stephen Warren <swarren@wwwdotorg.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Christian Daudt <bcm@fixthebug.org>, Markus Mayer <mmayer@broadcom.com>, Wendy Ng <wendy.ng@broadcom.com>
List-Id: linux-pm@vger.kernel.org

This patch series adds the support of the thermal driver for Broadcom
bcm281xx family of SoCs.

Wendy Ng (3):
  thermal: bcm281xx: Add thermal driver
  ARM: bcm281xx: Turn on Thermal and HWMON drivers.
  ARM: bcm281xx: Add thermal driver to device tree.

 .../bindings/thermal/bcm-kona-thermal.txt          |   18 +++
 arch/arm/boot/dts/bcm11351-brt.dts                 |    4 +-
 arch/arm/boot/dts/bcm11351.dtsi                    |    6 +
 arch/arm/boot/dts/bcm28155-ap.dts                  |    4 +
 arch/arm/configs/bcm_defconfig                     |    3 +-
 drivers/thermal/Kconfig                            |   10 ++
 drivers/thermal/Makefile                           |    1 +
 drivers/thermal/bcm_thermal.c                      |  170 ++++++++++++++++++++
 8 files changed, 214 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/bcm-kona-thermal.txt
 create mode 100644 drivers/thermal/bcm_thermal.c

-- 
1.7.9.5
