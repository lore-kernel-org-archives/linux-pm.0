From: Yuxuan Shui <yshuiv7@gmail.com>
Subject: [PATCH] intel_powerclamp: Fix cstate counter detection.
Date: Mon, 18 Nov 2013 15:06:35 +0800
Message-ID: <1384758395-5074-1-git-send-email-yshuiv7@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:50704 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab3KRHGu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2013 02:06:50 -0500
Received: by mail-pb0-f51.google.com with SMTP id up15so1592387pbc.38
        for <linux-pm@vger.kernel.org>; Sun, 17 Nov 2013 23:06:49 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: arjan@linux.intel.com, jacob.jun.pan@linux.intel.com, Yuxuan Shui <yshuiv7@gmail.com>

Having all zero cstate count doesn't necesserily mean the cstate
counter is no functional.

Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
---
 drivers/thermal/intel_powerclamp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index b40b37c..e302769 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -206,6 +206,15 @@ static void find_target_mwait(void)
 
 }
 
+static bool has_pkg_state_counter(void)
+{
+	u64 tmp;
+	return !rdmsrl_safe(MSR_PKG_C2_RESIDENCY, &tmp) ||
+	       !rdmsrl_safe(MSR_PKG_C3_RESIDENCY, &tmp) ||
+	       !rdmsrl_safe(MSR_PKG_C6_RESIDENCY, &tmp) ||
+	       !rdmsrl_safe(MSR_PKG_C7_RESIDENCY, &tmp);
+}
+
 static u64 pkg_state_counter(void)
 {
 	u64 val;
@@ -500,7 +509,7 @@ static int start_power_clamp(void)
 	struct task_struct *thread;
 
 	/* check if pkg cstate counter is completely 0, abort in this case */
-	if (!pkg_state_counter()) {
+	if (!has_pkg_state_counter()) {
 		pr_err("pkg cstate counter not functional, abort\n");
 		return -EINVAL;
 	}
-- 
1.8.4.2

