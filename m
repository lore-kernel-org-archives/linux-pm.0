From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v2 3/5] DT/arm,gic-v3-its: add reset-on-suspend property
Date: Thu, 25 Jan 2018 23:38:33 -0800
Message-ID: <20180126073835.16575-4-dbasehore@chromium.org>
References: <20180126073835.16575-1-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180126073835.16575-1-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, briannorris@chromium.org, marc.zyngier@arm.com, Derek Basehore <dbasehore@chromium.org>
List-Id: linux-pm@vger.kernel.org

This adds documentation for the new reset-on-suspend property. This
property enables saving and restoring the ITS for when it loses state
in system suspend.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
index 0a57f2f4167d..a470147d4f14 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -78,6 +78,9 @@ These nodes must have the following properties:
 Optional:
 - socionext,synquacer-pre-its: (u32, u32) tuple describing the untranslated
   address and size of the pre-ITS window.
+- reset-on-suspend: Boolean property. Indicates that the ITS state is
+  reset on suspend. The state is then saved on suspend and restored on
+  resume.
 
 The main GIC node must contain the appropriate #address-cells,
 #size-cells and ranges properties for the reg property of all ITS
-- 
2.16.0.rc1.238.g530d649a79-goog
