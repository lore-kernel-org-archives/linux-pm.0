From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH] thermal: Fix cdev registration with THERMAL_NO_LIMIT on 64bit
Date: Tue,  9 Dec 2014 12:22:01 +0000
Message-ID: <1418127721-1182-1-git-send-email-punit.agrawal@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:44514 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756643AbaLIMxB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Dec 2014 07:53:01 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>

The size of unsigned long varies between 32 and 64 bit systems while
the size of phandle arguments is always 32 bits per parameter.

On 64-bit systems, cooling devices registered via of-thermal apis fail
to bind when the min/max cooling state is specified as
THERMAL_NO_LIMIT (-1UL) as there is a mis-match between the value read
from the device tree (32bit) and the pre-processor define (64bit).

As we're unlikely to need cooling states larger than 32 bits, and for
consistency with the size of phandle arguments, explicitly limit
THERMAL_NO_LIMIT to 32 bits.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 include/dt-bindings/thermal/thermal.h | 2 +-
 include/linux/thermal.h               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/thermal/thermal.h b/include/dt-bindings/thermal/thermal.h
index 59822a9..b5e6b00 100644
--- a/include/dt-bindings/thermal/thermal.h
+++ b/include/dt-bindings/thermal/thermal.h
@@ -11,7 +11,7 @@
 #define _DT_BINDINGS_THERMAL_THERMAL_H
 
 /* On cooling devices upper and lower limits */
-#define THERMAL_NO_LIMIT		(-1UL)
+#define THERMAL_NO_LIMIT		(~0)
 
 #endif
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index ef90838..005586f 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -38,7 +38,7 @@
 #define THERMAL_CSTATE_INVALID -1UL
 
 /* No upper/lower limit requirement */
-#define THERMAL_NO_LIMIT	THERMAL_CSTATE_INVALID
+#define THERMAL_NO_LIMIT	((u32)~0)
 
 /* Unit conversion macros */
 #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
-- 
2.1.1

