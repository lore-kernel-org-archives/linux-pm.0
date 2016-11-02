From: kernel@martin.sperl.org
Subject: [PATCH V8 1/6] dt: bindings: add thermal device driver for bcm2835
Date: Wed,  2 Nov 2016 10:18:21 +0000
Message-ID: <1478081906-12009-2-git-send-email-kernel@martin.sperl.org>
References: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Martin Sperl <kernel@martin.sperl.org>
List-Id: linux-pm@vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

Add dt-binding documentation for bcm2835 SOC thermal sensor.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Acked-by: Eric Anholt <eric@anholt.net>
Acked-by: Rob Herring <robh@kernel.org>

Changelog:
 V1 -> V2: renamed file to follow naming conventions
 V2 -> V3: removed 0x in node name
---
 .../bindings/thermal/brcm,bcm2835-thermal.txt           | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
new file mode 100644
index 0000000..474531d
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,bcm2835-thermal.txt
@@ -0,0 +1,17 @@
+Binding for Thermal Sensor driver for BCM2835 SoCs.
+
+Required parameters:
+-------------------
+
+compatible: 	should be one of: "brcm,bcm2835-thermal",
+		"brcm,bcm2836-thermal" or "brcm,bcm2837-thermal"
+reg:		Address range of the thermal registers.
+clocks: 	Phandle of the clock used by the thermal sensor.
+
+Example:
+
+thermal: thermal@7e212000 {
+	compatible = "brcm,bcm2835-thermal";
+	reg = <0x7e212000 0x8>;
+	clocks = <&clocks BCM2835_CLOCK_TSENS>;
+};
-- 
2.1.4
