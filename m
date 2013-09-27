From: "Wendy Ng" <wendy.ng@broadcom.com>
Subject: [PATCH v2 0/3] thermal: bcm281xx: Add thermal driver
Date: Fri, 27 Sep 2013 15:37:31 -0700
Message-ID: <1380321454-16216-1-git-send-email-wendy.ng@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mms3.broadcom.com ([216.31.210.19]:2674 "EHLO mms3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753419Ab3I0Wjb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 27 Sep 2013 18:39:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>, Stephen Warren <swarren@wwwdotorg.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Christian Daudt <bcm@fixthebug.org>, Markus Mayer <mmayer@broadcom.com>, Wendy Ng <wendy.ng@broadcom.com>

This patch series adds the support of the thermal driver for Broadcom
bcm281xx family of SoCs.

The change for this version of the patch is to work with the
ARCH_BCM->ARCH_BCM_MOBILE renaming series as shown in the link below:
http://www.spinics.net/lists/arm-kernel/msg274963.html

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


