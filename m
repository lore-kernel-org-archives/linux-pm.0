From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH 2/2] ARM: Kirkwood: Add support thermal sensor for 88F6282 and 88F6283
Date: Sat,  8 Dec 2012 08:15:51 +0900
Message-ID: <1354922151-3250-2-git-send-email-iwamatsu@nigauri.org>
References: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50174 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031010Ab2LGXD0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Dec 2012 18:03:26 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so780221pad.19
        for <linux-pm@vger.kernel.org>; Fri, 07 Dec 2012 15:03:26 -0800 (PST)
In-Reply-To: <1354922151-3250-1-git-send-email-iwamatsu@nigauri.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, rui.zhang@intel.com, jason@lakedaemon.net, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

88F6282 and 88F6283 has thermal sensor.
This patch enables DT and kernel config.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/arm/boot/dts/kirkwood-6282.dtsi |    6 ++++++
 arch/arm/configs/kirkwood_defconfig  |    2 ++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index 9ae2004..4d9cd74 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -41,5 +41,11 @@
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
+
+		thermal@10078 {
+			compatible = "marvel,thermal-kirkwood";
+			reg = <0x10078 0x4>;
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 93f3794..3d8667f 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -118,6 +118,8 @@ CONFIG_SPI=y
 CONFIG_SPI_ORION=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_KIRKWOOD_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
 CONFIG_HID_DRAGONRISE=y
-- 
1.7.10.4

