From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v5 1/6] dt-bindings: arm64: add compatible for LX2160A
Date: Sun, 14 Oct 2018 22:37:58 +0530
Message-ID: <1539536883-1928-2-git-send-email-vabhav.sharma@nxp.com>
References: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539536883-1928-1-git-send-email-vabhav.sharma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sudeep.holla@arm.com, oss@buserror.net, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de, kstewart@linuxfoundation.org, yamada.masahiro@socionext.com, leoyang.li@nxp.com, shawnguo@kernel.org
Cc: linux@armlinux.org.uk, adrian.hunter@intel.com, ulf.hansson@linaro.org, V.Sethi@nxp.com, udit.kumar@nxp.com, pankaj.bansal@nxp.com, Vabhav Sharma <vabhav.sharma@nxp.com>
List-Id: linux-pm@vger.kernel.org

Add compatible for LX2160A SoC,QDS and RDB board
Add lx2160a compatible for clockgen and dcfg

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.txt           | 14 +++++++++++++-
 Documentation/devicetree/bindings/clock/qoriq-clock.txt |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 8a1baa2..71adce2 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -130,7 +130,7 @@ core start address and release the secondary core from holdoff and startup.
   - compatible: Should contain a chip-specific compatible string,
 	Chip-specific strings are of the form "fsl,<chip>-dcfg",
 	The following <chip>s are known to be supported:
-	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
+	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a, lx2160a.
 
   - reg : should contain base address and length of DCFG memory-mapped registers
 
@@ -222,3 +222,15 @@ Required root node properties:
 LS2088A ARMv8 based RDB Board
 Required root node properties:
     - compatible = "fsl,ls2088a-rdb", "fsl,ls2088a";
+
+LX2160A SoC
+Required root node properties:
+    - compatible = "fsl,lx2160a";
+
+LX2160A ARMv8 based QDS Board
+Required root node properties:
+    - compatible = "fsl,lx2160a-qds", "fsl,lx2160a";
+
+LX2160A ARMv8 based RDB Board
+Required root node properties:
+    - compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
index 97f46ad..3fb9995 100644
--- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
+++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
@@ -37,6 +37,7 @@ Required properties:
 	* "fsl,ls1046a-clockgen"
 	* "fsl,ls1088a-clockgen"
 	* "fsl,ls2080a-clockgen"
+	* "fsl,lx2160a-clockgen"
 	Chassis-version clock strings include:
 	* "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
 	* "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
-- 
2.7.4
