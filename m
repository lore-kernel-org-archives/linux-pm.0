From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v6 1/4] dt-bindings: power: reset: add document for reboot-mode driver
Date: Tue, 22 Mar 2016 19:36:32 +0800
Message-ID: <1458646592-540-1-git-send-email-andy.yan@rock-chips.com>
References: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular2.263xmail.com ([211.157.152.3]:33695 "EHLO
	regular2.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758964AbcCVLhX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2016 07:37:23 -0400
Received: from regular1.263xmail.com (unknown [192.168.165.234])
	by regular2.263xmail.com (Postfix) with ESMTP id ABCE31E2F2
	for <linux-pm@vger.kernel.org>; Tue, 22 Mar 2016 19:37:16 +0800 (CST)
In-Reply-To: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, sre@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de
Cc: galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, olof@lixom.net, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, jun.nie@linaro.org, pawel.moll@arm.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, matthias.bgg@gmail.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, f.fainelli@gmail.com, linux@arm.linux.org.uk, mbrugger@suse.com, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, linux-kernel@vger.kernel.org, wxt@rock-chips.com, dwmw2@infradead.org, mark.rutland@arm.com, Andy Yan <andy.yan@rock-chips.com>

add device tree bindings document for reboot-mode driver

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>

binding

---

Changes in v6:
- fix a typo with "property"
- describe property "mask" more clear

Changes in v5:
- delete a unnecessary blank line in syscon-reboot-mode.txt
- rename mode-fastoboot to mode-bootloader in syscon-reboot-mode.txt
- rename macro BOOT_LOADER to BOOT_BL_DOWNLOAD, which gives a more clear mean

Changes in v4:
- remove mode-maskrom
- rename mode-fastboot to mode-bootloader to keep compatible with the exiting Android device

Changes in v3:
- descirbe all reboot mode as properity instead of subnode

Changes in v2: None
Changes in v1: None

 .../bindings/power/reset/reboot-mode.txt           | 24 +++++++++++++++
 .../bindings/power/reset/syscon-reboot-mode.txt    | 35 ++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt

diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
new file mode 100644
index 0000000..3457949
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
@@ -0,0 +1,24 @@
+Generic reboot mode core map driver
+
+This driver get reboot mode arguments and call the write
+interface to stores the magic value in special register
+or ram . Then the bootloader can read it and take different
+action according the argument stored.
+
+All mode properties are vendor specific, it is a indication to tell
+the bootloder what to do when the system reboot, and should be named
+as mode-xxx = <magic> (xxx is mode name).
+
+- mode-normal: Normal reboot mode, system reboot with command "reboot".
+- mode-recovery: Android Recovery mode, it is a mode to format the device or update a new image.
+- mode-bootloader: Android fastboot mode, it's a mode to re-flash partitions on the Android based device.
+- mode-loader: A bootloader mode, it's a mode used to download image on Rockchip platform,
+	       usually used in development.
+
+Example:
+	reboot-mode {
+		mode-normal = <BOOT_NORMAL>;
+		mode-recovery = <BOOT_RECOVERY>;
+		mode-bootloader = <BOOT_FASTBOOT>;
+		mode-loader = <BOOT_BL_DOWNLOAD>;
+	}
diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
new file mode 100644
index 0000000..eb28469
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
@@ -0,0 +1,35 @@
+SYSCON reboot mode driver
+
+This driver get reboot mode magic value form reboot-mode driver
+and stores it in a SYSCON mapped register. Then the bootloader
+can read it and take different action according to the magic
+value stored.
+
+This DT node should be represented as a sub-node of a "syscon", "simple-mfd"
+node.
+
+Required properties:
+- compatible: should be "syscon-reboot-mode"
+- offset: offset in the register map for the storage register (in bytes)
+
+Optional property:
+- mask: bits mask of the bits in the register to store the reboot mode magic value,
+  default set to 0xffffffff if missing.
+
+The rest of the properties should follow the generic reboot-mode discription
+found in reboot-mode.txt
+
+Example:
+	pmu: pmu@20004000 {
+		compatible = "rockchip,rk3066-pmu", "syscon", "simple-mfd";
+		reg = <0x20004000 0x100>;
+
+		reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x40>;
+			mode-normal = <BOOT_NORMAL>;
+			mode-recovery = <BOOT_RECOVERY>;
+			mode-bootloader = <BOOT_FASTBOOT>;
+			mode-loader = <BOOT_BL_DOWNLOAD>;
+		};
+	};
-- 
1.9.1


