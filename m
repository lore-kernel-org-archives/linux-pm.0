From: Jia Hongtao <hongtao.jia@nxp.com>
Subject: [PATCH V2 1/7] dt-bindings: Update QorIQ TMU thermal bindings
Date: Tue, 7 Jun 2016 11:27:34 +0800
Message-ID: <1465270054-31512-1-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, robh+dt@kernel.org, galak@codeaurora.org, scott.wood@nxp.com, shawnguo@kernel.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, hongtao.jia@nxp.com
List-Id: linux-pm@vger.kernel.org

For different types of SoC the sensor id and endianness may vary.
"#thermal-sensor-cells" is used to provide sensor id information.
"little-endian" property is to tell the endianness of TMU.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
Changes for V2:
* Remove formatting chnages.

 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
index 66223d5..20ca4ef 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
@@ -17,6 +17,12 @@ Required properties:
 	calibration data, as specified by the SoC reference manual.
 	The first cell of each pair is the value to be written to TTCFGR,
 	and the second is the value to be written to TSCFGR.
+- #thermal-sensor-cells : Must be 1. The sensor specifier is the monitoring
+	site ID, and represents the "n" in TRITSRn and TRATSRn.
+
+Optional property:
+- little-endian : If present, the TMU registers are little endian. If absent,
+	the default is big endian.

 Example:

@@ -60,4 +66,5 @@ tmu@f0000 {

 			       0x00030000 0x00000012
 			       0x00030001 0x0000001d>;
+	#thermal-sensor-cells = <1>;
 };
