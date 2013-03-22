From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 14/14] ARM: configs: Update mvebu, dove and kirkwood defconfigs for thermal
Date: Fri, 22 Mar 2013 19:25:14 -0300
Message-ID: <1363991114-4225-15-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:33512 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423375Ab3CVW0S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 18:26:18 -0400
In-Reply-To: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The driver for Dove, Kirkwood and Armada XP/370 SoC
has been integrated in a single driver called mvebu-thermal.
Update the defconfig for each platform to reflect this.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Please note that this change was done independentely from the
thermal driver patch in order to facilitate its merge by the
respective maintainers.

 arch/arm/configs/dove_defconfig     |    2 +-
 arch/arm/configs/kirkwood_defconfig |    2 +-
 arch/arm/configs/mvebu_defconfig    |    2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 4364eff..2136442 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -76,7 +76,7 @@ CONFIG_SPI=y
 CONFIG_SPI_ORION=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
-CONFIG_DOVE_THERMAL=y
+CONFIG_MVEBU_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 8f0065b..081d39f 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -120,7 +120,7 @@ CONFIG_SPI_ORION=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
-CONFIG_KIRKWOOD_THERMAL=y
+CONFIG_MVEBU_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
 CONFIG_HID_DRAGONRISE=y
diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 2ec8119..f2ac593 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -49,6 +49,8 @@ CONFIG_MTD_M25P80=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_THERMAL=y
+CONFIG_MVEBU_THERMAL=y
 CONFIG_USB_SUPPORT=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
1.7.8.6

