From: Jia Hongtao <hongtao.jia@nxp.com>
Subject: [PATCH 1/7] dt-bindings: Update QorIQ TMU thermal bindings
Date: Fri, 3 Jun 2016 14:57:33 +0800
Message-ID: <1464937059-19349-1-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: edubezval@gmail.com, rui.zhang@intel.com, robh+dt@kernel.org, galak@codeaurora.org, scott.wood@nxp.com, shawnguo@kernel.org
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hongtao.jia@nxp.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

For different types of SoC the sensor id and endianness may vary.
"#thermal-sensor-cells" is used to provide sensor id information.
"little-endian" property is to tell the endianness of TMU.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
 .../devicetree/bindings/thermal/qoriq-thermal.txt     | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
index 66223d5..8eeef80 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
@@ -1,22 +1,28 @@
 * Thermal Monitoring Unit (TMU) on Freescale QorIQ SoCs
 
 Required properties:
-- compatible : Must include "fsl,qoriq-tmu". The version of the device is
+- compatible: Must include "fsl,qoriq-tmu". The version of the device is
 	determined by the TMU IP Block Revision Register (IPBRR0) at
 	offset 0x0BF8.
-	Table of correspondences between IPBRR0 values and example  chips:
+	Table of correspondences between IPBRR0 values and example chips:
 		Value           Device
 		----------      -----
 		0x01900102      T1040
-- reg : Address range of TMU registers.
-- interrupts : Contains the interrupt for TMU.
-- fsl,tmu-range : The values to be programmed into TTRnCR, as specified by
+- reg: Address range of TMU registers.
+- interrupts: Contains the interrupt for TMU.
+- fsl,tmu-range: The values to be programmed into TTRnCR, as specified by
 	the SoC reference manual. The first cell is TTR0CR, the second is
 	TTR1CR, etc.
-- fsl,tmu-calibration : A list of cell pairs containing temperature
+- fsl,tmu-calibration: A list of cell pairs containing temperature
 	calibration data, as specified by the SoC reference manual.
 	The first cell of each pair is the value to be written to TTCFGR,
 	and the second is the value to be written to TSCFGR.
+- #thermal-sensor-cells: Must be 1. The sensor specifier is the monitoring
+	site ID, and represents the "n" in TRITSRn and TRATSRn.
+
+Optional property:
+- little-endian: If present, the TMU registers are little endian.  If absent,
+	the default is big endian.
 
 Example:
 
@@ -60,4 +66,5 @@ tmu@f0000 {
 
 			       0x00030000 0x00000012
 			       0x00030001 0x0000001d>;
+	#thermal-sensor-cells = <1>;
 };
-- 
2.1.0.27.g96db324
