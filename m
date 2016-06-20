From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v9 1/4] dt-bindings: power: reset: add document for reboot-mode driver
Date: Mon, 20 Jun 2016 14:36:42 +0800
Message-ID: <1466404602-3388-1-git-send-email-andy.yan@rock-chips.com>
References: <1466404490-3315-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466404490-3315-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de
Cc: k.kozlowski@samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, sre@kernel.org, matthias.bgg@gmail.com, linux-pm@vger.kernel.org, mbrugger@suse.com, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, richard@nod.at, Andy Yan <andy.yan@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Add device tree bindings document for reboot-mode driver.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes in v9: None
Changes in v8: None
Changes in v7:
- fix some spelling mistakes
- declare that the mode magic should be none-zero value

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

 .../bindings/power/reset/reboot-mode.txt           | 25 ++++++++++++++++
 .../bindings/power/reset/syscon-reboot-mode.txt    | 35 ++++++++++++++++++++++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt

diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
new file mode 100644
index 0000000..de34f27
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
@@ -0,0 +1,25 @@
+Generic reboot mode core map driver
+
+This driver get reboot mode arguments and call the write
+interface to store the magic value in special register
+or ram. Then the bootloader can read it and take different
+action according to the argument stored.
+
+All mode properties are vendor specific, it is a indication to tell
+the bootloader what to do when the system reboots, and should be named
+as mode-xxx = <magic> (xxx is mode name, magic should be a none-zero value).
+
+For example modes common on Android platform:
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
index 0000000..f7ce1d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
@@ -0,0 +1,35 @@
+SYSCON reboot mode driver
+
+This driver gets reboot mode magic value form reboot-mode driver
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
+The rest of the properties should follow the generic reboot-mode description
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
2.7.4
