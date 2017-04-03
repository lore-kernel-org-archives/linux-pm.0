From: David Lechner <david@lechnology.com>
Subject: [PATCH 1/3] dt-bindings: power: supply: New bindings for LEGO
 MINDSTORMS EV3 battery
Date: Mon,  3 Apr 2017 15:23:47 -0500
Message-ID: <1491251029-23256-2-git-send-email-david@lechnology.com>
References: <1491251029-23256-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1491251029-23256-1-git-send-email-david@lechnology.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: linux-pm@vger.kernel.org

This add a new device tree binding for LEGO MINDSTORMS EV3 battery. The EV3
has some built-in capability for monitoring the attached battery.

Signed-off-by: David Lechner <david@lechnology.com>
---
 .../bindings/power/supply/lego_ev3_battery.txt      | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt b/Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt
new file mode 100644
index 0000000..5485633
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt
@@ -0,0 +1,21 @@
+LEGO MINDSTORMS EV3 Battery
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+LEGO MINDSTORMS EV3 has some built-in capability for monitoring the battery.
+It uses 6 AA batteries or a special Li-ion rechargeable battery pack that is
+detected by a key switch in the battery compartment.
+
+Required properties:
+ - compatible: Must be "lego,ev3-battery"
+ - io-channels: phandles to analog inputs for reading voltage and current
+ - io-channel-names: Must be "voltage", "current"
+ - rechargeable-gpios: phandle to the rechargeable battery indication gpio
+
+Example:
+
+	battery {
+		compatible = "lego,ev3-battery";
+		io-channels = <&adc 4>, <&adc 3>;
+		io-channel-names = "voltage", "current";
+		rechargeable-gpios = <&gpio 136 GPIO_ACTIVE_LOW>;
+	};
-- 
2.7.4
