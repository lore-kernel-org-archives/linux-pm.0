From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 7/8] DT/arm,gic-v3: add resend-mapc-on-resume property
Date: Fri, 12 Jan 2018 13:24:21 -0800
Message-ID: <20180112212422.148625-8-dbasehore@chromium.org>
References: <20180112212422.148625-1-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180112212422.148625-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, briannorris@chromium.org, marc.zyngier@arm.com, Derek Basehore <dbasehore@chromium.org>
List-Id: linux-pm@vger.kernel.org

This boolean property for the GIC-V3-ITS enables resending the MAP
COLLECTIONS commands when restoring the GIC on resume.

Change-Id: I03ab8689dace109851a4d2be3abf5fbafb090d27
Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 .../devicetree/bindings/interrupt-controller/arm,gic-v3.txt        | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
index 820556a8ffd2..1f0d691df9b3 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -82,6 +82,12 @@ These nodes must have the following properties:
 Optional:
 - socionext,synquacer-pre-its: (u32, u32) tuple describing the untranslated
   address and size of the pre-ITS window.
+- resend-mapc-on-resume : Bool property. If the collections for the ITS
+  are stored in the ITS instead of external memory, the state will be
+  lost if the GIC loses power. Setting this enables the kernel to
+  reset the collections state on resume for this ITS node. The state
+  will only be reset if the save-suspend-state boolean is set for the
+  gic.
 
 The main GIC node must contain the appropriate #address-cells,
 #size-cells and ranges properties for the reg property of all ITS
@@ -129,6 +135,7 @@ Examples:
 		its: interrupt-controller@fee20000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
+			resend-mapc-on-resume;
 			reg = <0x0 0xfee20000 0x0 0x20000>;
 		};
 
-- 
2.16.0.rc1.238.g530d649a79-goog
