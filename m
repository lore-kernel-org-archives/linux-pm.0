From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v4 5/5] DT/arm,gic-v3: add collections-reset-on-suspend property
Date: Fri,  2 Feb 2018 17:24:50 -0800
Message-ID: <20180203012450.18378-6-dbasehore@chromium.org>
References: <20180203012450.18378-1-dbasehore@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40081 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbeBCBZC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Feb 2018 20:25:02 -0500
Received: by mail-pf0-f196.google.com with SMTP id a14so4503023pfi.7
        for <linux-pm@vger.kernel.org>; Fri, 02 Feb 2018 17:25:02 -0800 (PST)
In-Reply-To: <20180203012450.18378-1-dbasehore@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, briannorris@chromium.org, marc.zyngier@arm.com, Derek Basehore <dbasehore@chromium.org>

This boolean property for the GIC-V3-ITS enables resending the MAP
COLLECTIONS commands when resuming for when the state is reset on
suspend.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
index a470147d4f14..adb958e046d2 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -81,6 +81,10 @@ Optional:
 - reset-on-suspend: Boolean property. Indicates that the ITS state is
   reset on suspend. The state is then saved on suspend and restored on
   resume.
+- collections-reset-on-suspend : Boolean property. If the collections for the
+  ITS are stored internally instead of externally, the state will be lost if the
+  GIC loses power. Setting this enables the kernel to reset the collections
+  state on resume for this ITS node.
 
 The main GIC node must contain the appropriate #address-cells,
 #size-cells and ranges properties for the reg property of all ITS
-- 
2.16.0.rc1.238.g530d649a79-goog
