From: Jia Hongtao <hongtao.jia@nxp.com>
Subject: [PATCH 3/3] powerpc/mpc85xx: Update TMU device tree node for T1023/T1024
Date: Wed, 4 Jan 2017 16:57:51 +0800
Message-ID: <1483520271-3838-4-git-send-email-hongtao.jia@nxp.com>
References: <1483520271-3838-1-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483520271-3838-1-git-send-email-hongtao.jia@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: oss@buserror.net, rui.zhang@intel.com, edubezval@gmail.com, yuantian.tang@nxp.com, robh+dt@kernel.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, hongtao.jia@nxp.com
List-Id: linux-pm@vger.kernel.org

From: Hongtao Jia <hongtao.jia@nxp.com>

Update #thermal-sensor-cells from 0 to 1 according to the new binding. The
sensor specifier added is the monitoring site ID, and represents the "n" in
TRITSRn and TRATSRn.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
index da2894c..4908af5 100644
--- a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
@@ -422,7 +422,7 @@
 				       0x00030001 0x0000000d
 				       0x00030002 0x00000019
 				       0x00030003 0x00000024>;
-		#thermal-sensor-cells = <0>;
+		#thermal-sensor-cells = <1>;
 	};
 
 	thermal-zones {
@@ -430,7 +430,7 @@
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 
-			thermal-sensors = <&tmu>;
+			thermal-sensors = <&tmu 0>;
 
 			trips {
 				cpu_alert: cpu-alert {
-- 
2.1.0.27.g96db324
