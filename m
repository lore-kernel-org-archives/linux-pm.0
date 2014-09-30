From: Feng Kan <fkan@apm.com>
Subject: [PATCH RESEND V9 3/6] Documentation: arm64: add SCU dts binding documentation to linux kernel
Date: Tue, 30 Sep 2014 16:25:05 -0700
Message-ID: <1412119508-22864-4-git-send-email-fkan@apm.com>
References: <1412119508-22864-1-git-send-email-fkan@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412119508-22864-1-git-send-email-fkan@apm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@roeck-us.net, dbaryshkov@gmail.com, catalin.marinas@arm.com, dwmw2@infradead.org, arnd@arndb.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patches@apm.com, linux-pm@vger.kernel.org, will.deacon@arm.com
Cc: Feng Kan <fkan@apm.com>
List-Id: linux-pm@vger.kernel.org

This add documentation for the SCU system clock unit device tree binding
to the kernel.

Signed-off-by: Feng Kan <fkan@apm.com>
---
 Documentation/devicetree/bindings/arm/apm/scu.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/apm/scu.txt

diff --git a/Documentation/devicetree/bindings/arm/apm/scu.txt b/Documentation/devicetree/bindings/arm/apm/scu.txt
new file mode 100644
index 0000000..b45be06
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/apm/scu.txt
@@ -0,0 +1,17 @@
+APM X-GENE SoC series SCU Registers
+
+This system clock unit contain various register that control block resets,
+clock enable/disables, clock divisors and other deepsleep registers.
+
+Properties:
+ - compatible : should contain two values. First value must be:
+		   - "apm,xgene-scu"
+		second value must be always "syscon".
+
+ - reg : offset and length of the register set.
+
+Example :
+	scu: system-clk-controller@17000000 {
+		compatible = "apm,xgene-scu","syscon";
+		reg = <0x0 0x17000000 0x0 0x400>;
+	};
-- 
1.9.1
