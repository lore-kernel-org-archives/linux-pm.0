From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH 1/2] of: thermal: Fix inconsitency between cooling-*-state and cooling-*-level
Date: Tue,  8 Sep 2015 12:20:48 +0100
Message-ID: <1441711249-11434-1-git-send-email-punit.agrawal@arm.com>
References: <1441711013-11220-1-git-send-email-punit.agrawal@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:51937 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753254AbbIHLTz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 07:19:55 -0400
In-Reply-To: <1441711013-11220-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

The device trees in the kernel as well as the binding description in
Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt use the
cooling-{min,max}-level property.

Fix the inconsistency with the binding description in
Documentation/devicetree/bindings/thermal/thermal.txt by changing
cooling-*-state properties to cooling-*-level.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index 8a49362..8320186 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -55,16 +55,16 @@ of heat dissipation). For example a fan's cooling states correspond to
 the different fan speeds possible. Cooling states are referred to by
 single unsigned integers, where larger numbers mean greater heat
 dissipation. The precise set of cooling states associated with a device
-(as referred to be the cooling-min-state and cooling-max-state
+(as referred to by the cooling-min-level and cooling-max-level
 properties) should be defined in a particular device's binding.
 For more examples of cooling devices, refer to the example sections below.
 
 Required properties:
-- cooling-min-state:	An integer indicating the smallest
+- cooling-min-level:	An integer indicating the smallest
   Type: unsigned	cooling state accepted. Typically 0.
   Size: one cell
 
-- cooling-max-state:	An integer indicating the largest
+- cooling-max-level:	An integer indicating the largest
   Type: unsigned	cooling state accepted.
   Size: one cell
 
@@ -225,8 +225,8 @@ cpus {
 			396000  950000
 			198000  850000
 		>;
-		cooling-min-state = <0>;
-		cooling-max-state = <3>;
+		cooling-min-level = <0>;
+		cooling-max-level = <3>;
 		#cooling-cells = <2>; /* min followed by max */
 	};
 	...
@@ -240,8 +240,8 @@ cpus {
 	 */
 	fan0: fan@0x48 {
 		...
-		cooling-min-state = <0>;
-		cooling-max-state = <9>;
+		cooling-min-level = <0>;
+		cooling-max-level = <9>;
 		#cooling-cells = <2>; /* min followed by max */
 	};
 };
-- 
2.5.0

