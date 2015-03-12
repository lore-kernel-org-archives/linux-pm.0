From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: [PATCHv3 2/2] dt: power: Add docs for generic SYSCON poweroff driver.
Date: Wed, 11 Mar 2015 17:37:19 -0700
Message-ID: <1426120639-4248-3-git-send-email-moritz.fischer@ettus.com>
References: <1426120639-4248-1-git-send-email-moritz.fischer@ettus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426120639-4248-1-git-send-email-moritz.fischer@ettus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>
List-Id: linux-pm@vger.kernel.org

Add documentation for generic SYSCON poweroff driver.

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 .../bindings/power/reset/syscon-poweroff.txt       | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
new file mode 100644
index 0000000..1e2546f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt
@@ -0,0 +1,23 @@
+Generic SYSCON mapped register poweroff driver
+
+This is a generic poweroff driver using syscon to map the poweroff register.
+The poweroff is generally performed with a write to the poweroff register
+defined by the register map pointed by syscon reference plus the offset
+with the mask defined in the poweroff node.
+
+Required properties:
+- compatible: should contain "syscon-poweroff"
+- regmap: this is phandle to the register map node
+- offset: offset in the register map for the poweroff register (in bytes)
+- mask: the poweroff value written to the poweroff register (32 bit access)
+
+Default will be little endian mode, 32 bit access only.
+
+Examples:
+
+	poweroff {
+	   compatible = "syscon-poweroff";
+	   regmap = <&regmapnode>;
+	   offset = <0x0>;
+	   mask = <0x7a>;
+	};
-- 
1.9.3
