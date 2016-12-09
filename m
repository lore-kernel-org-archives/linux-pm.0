From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 04/11] Documentation: DT: binding: axp20x_usb_power: add axp223 compatible
Date: Fri,  9 Dec 2016 12:04:12 +0100
Message-ID: <20161209110419.28981-5-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com
List-Id: linux-pm@vger.kernel.org

This adds the "x-powers,axp223-usb-power-supply" to the list of
compatibles for AXP20X VBUS power supply driver.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v2:
 - adding small explanation on AXP223 variation compared to the AXP221,

 Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
index f1d7bee..ba8d35f 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
@@ -3,6 +3,11 @@ AXP20x USB power supply
 Required Properties:
 -compatible: One of: "x-powers,axp202-usb-power-supply"
                      "x-powers,axp221-usb-power-supply"
+                     "x-powers,axp223-usb-power-supply"
+
+The AXP223 PMIC shares most of its behaviour with the AXP221 but has slight
+variations such as the former being able to set the VBUS power supply max
+current to 100mA, unlike the latter.
 
 This node is a subnode of the axp20x PMIC.
 
-- 
2.9.3
