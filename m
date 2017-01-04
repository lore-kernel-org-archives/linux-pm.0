From: Jia Hongtao <hongtao.jia@nxp.com>
Subject: [PATCH 2/3] powerpc/mpc85xx: Update TMU device tree node for T1040/T1042
Date: Wed, 4 Jan 2017 16:57:50 +0800
Message-ID: <1483520271-3838-3-git-send-email-hongtao.jia@nxp.com>
References: <1483520271-3838-1-git-send-email-hongtao.jia@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam01on0044.outbound.protection.outlook.com ([104.47.34.44]:23084
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966492AbdADJK4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Jan 2017 04:10:56 -0500
In-Reply-To: <1483520271-3838-1-git-send-email-hongtao.jia@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: oss@buserror.net, rui.zhang@intel.com, edubezval@gmail.com, yuantian.tang@nxp.com, robh+dt@kernel.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, hongtao.jia@nxp.com

From: Hongtao Jia <hongtao.jia@nxp.com>

Update #thermal-sensor-cells from 0 to 1 according to the new binding. The
sensor specifier added is the monitoring site ID, and represents the "n" in
TRITSRn and TRATSRn.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 44e399b..145c7f4 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -526,7 +526,7 @@
 
 				       0x00030000 0x00000012
 				       0x00030001 0x0000001d>;
-		#thermal-sensor-cells = <0>;
+		#thermal-sensor-cells = <1>;
 	};
 
 	thermal-zones {
@@ -534,7 +534,7 @@
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 
-			thermal-sensors = <&tmu>;
+			thermal-sensors = <&tmu 2>;
 
 			trips {
 				cpu_alert: cpu-alert {
-- 
2.1.0.27.g96db324

