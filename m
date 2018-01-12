From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 5/8] DT/arm,gic-v3: add save-suspend-state property
Date: Fri, 12 Jan 2018 13:24:19 -0800
Message-ID: <20180112212422.148625-6-dbasehore@chromium.org>
References: <20180112212422.148625-1-dbasehore@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34357 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965353AbeALVYp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jan 2018 16:24:45 -0500
Received: by mail-pf0-f196.google.com with SMTP id e76so5302901pfk.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2018 13:24:45 -0800 (PST)
In-Reply-To: <20180112212422.148625-1-dbasehore@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, briannorris@chromium.org, marc.zyngier@arm.com, Derek Basehore <dbasehore@chromium.org>

This adds documentation for the new save-suspend-state property. This
property enables saving and restoring the GIC for when it loses state
in system suspend.

Change-Id: I9ad34baed04475c6ef1562bc0f72ad5d348f9904
Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 .../bindings/interrupt-controller/arm,gic-v3.txt   | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
index 0a57f2f4167d..820556a8ffd2 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -57,6 +57,10 @@ Optional
   occupied by the redistributors. Required if more than one such
   region is present.
 
+- save-suspend-state : Bool property. Setting this has the kernel save
+  and restore the GIC state for suspend and resume respectively. For
+  when the GIC loses power during suspend.
+
 Sub-nodes:
 
 PPI affinity can be expressed as a single "ppi-partitions" node,
@@ -107,6 +111,38 @@ Examples:
 		};
 	};
 
+	gic: interrupt-controller@fee00000 {
+		compatible = "arm,gic-v3";
+		#interrupt-cells = <4>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		interrupt-controller;
+		save-suspend-state;
+
+		reg = <0x0 0xfee00000 0 0x10000>, /* GICD */
+		      <0x0 0xfef00000 0 0xc0000>, /* GICR */
+		      <0x0 0xfff00000 0 0x10000>, /* GICC */
+		      <0x0 0xfff10000 0 0x10000>, /* GICH */
+		      <0x0 0xfff20000 0 0x10000>; /* GICV */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
+		its: interrupt-controller@fee20000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			reg = <0x0 0xfee20000 0x0 0x20000>;
+		};
+
+		ppi-partitions {
+			ppi_cluster0: interrupt-partition-0 {
+				affinity = <&cpu_l0 &cpu_l1 &cpu_l2 &cpu_l3>;
+			};
+
+			ppi_cluster1: interrupt-partition-1 {
+				affinity = <&cpu_b0 &cpu_b1>;
+			};
+		};
+	};
+
 	gic: interrupt-controller@2c010000 {
 		compatible = "arm,gic-v3";
 		#interrupt-cells = <4>;
-- 
2.16.0.rc1.238.g530d649a79-goog
