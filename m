From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v4 3/5] DT/arm,gic-v3-its: add reset-on-suspend property
Date: Fri,  2 Feb 2018 17:24:48 -0800
Message-ID: <20180203012450.18378-4-dbasehore@chromium.org>
References: <20180203012450.18378-1-dbasehore@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34642 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbeBCBY7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Feb 2018 20:24:59 -0500
Received: by mail-pl0-f68.google.com with SMTP id q17so5261647pll.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Feb 2018 17:24:59 -0800 (PST)
In-Reply-To: <20180203012450.18378-1-dbasehore@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, tglx@linutronix.de, briannorris@chromium.org, marc.zyngier@arm.com, Derek Basehore <dbasehore@chromium.org>

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
