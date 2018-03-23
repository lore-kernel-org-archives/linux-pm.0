From: <sean.wang@mediatek.com>
Subject: [PATCH v1 01/16] dt-bindings: power: reset: mediatek: add bindings for power device
Date: Fri, 23 Mar 2018 17:14:58 +0800
Message-ID: <c5527464207b02d40f1c2682feb97ebf5dd443be.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, lee.jones@linaro.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, eddie.huang@mediatek.com
Cc: devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add device-tree binding for the power device responsible for shutdown a
remote SoC, which is a tiny circuit block present on MediaTek PMIC based
RTC.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../bindings/power/reset/mt6397-rtc-poweroff.txt   | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt

diff --git a/Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt b/Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
new file mode 100644
index 0000000..75a9d7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
@@ -0,0 +1,24 @@
+Device-Tree bindings for Power Device on MediaTek PMIC RTC
+
+The power device is responsible for externally power off or on the remote
+MediaTek SoC through the a tiny circuit block BBPU inside PMIC RTC.
+
+Required parent node:
+- rtc
+	For MediaTek PMIC RTC bindings, see:
+	Documentation/devicetree/bindings/mfd/mt6397.txt
+
+Required properties:
+- compatible: Should be one of follows
+	"mediatek,mt6323-rtc-poweroff": for MT6323 PMIC
+	"mediatek,mt6397-rtc-poweroff": for MT6397 PMIC
+
+Example:
+
+	rtc {
+		compatible = "mediatek,mt6323-rtc";
+
+		power-off {
+			compatible = "mediatek,mt6323-rtc-poweroff";
+		};
+	};
-- 
2.7.4
