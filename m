From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [Update] [PATCH v6 3/3] PM: Introduce Intel PowerClamp Driver
Date: Wed, 16 Jan 2013 01:45:28 -0800
Message-ID: <1358329528-1286-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35733 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753171Ab3APRpp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Jan 2013 12:45:45 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

---
Need to include the proper nmi.h file such that
local_touch_nmi is always declared.


 drivers/thermal/intel_powerclamp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 314b6fc..81ebf87 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -50,8 +50,8 @@
 #include <linux/tick.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
-#include <linux/nmi.h>
 
+#include <asm/nmi.h>
 #include <asm/msr.h>
 #include <asm/mwait.h>
 #include <asm/cpu_device_id.h>
-- 
1.7.9.5

