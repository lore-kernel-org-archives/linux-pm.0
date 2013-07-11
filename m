From: shuox.liu@intel.com
Subject: [PATCH] PM: avoid 'autosleep' in shutdown progress
Date: Thu, 11 Jul 2013 16:03:45 +0800
Message-ID: <1373529825-20741-1-git-send-email-shuox.liu@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56966 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755611Ab3GKIEU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Jul 2013 04:04:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl, yanmin_zhang@linux.intel.com, linux-pm@vger.kernel.org

From: Liu ShuoX <shuox.liu@intel.com>

In shutdown progress, system is possible to do power transition
(such as suspend-to-ram) in parallel. It is unreasonable. So,
fixes it by adding a system_state checking and queue try_to_suspend
again when system status is not running.

Signed-off-by: Liu ShuoX <shuox.liu@intel.com>
---
 kernel/power/autosleep.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kernel/power/autosleep.c b/kernel/power/autosleep.c
index c6422ff..9012ecf 100644
--- a/kernel/power/autosleep.c
+++ b/kernel/power/autosleep.c
@@ -32,7 +32,8 @@ static void try_to_suspend(struct work_struct *work)
 
 	mutex_lock(&autosleep_lock);
 
-	if (!pm_save_wakeup_count(initial_count)) {
+	if (!pm_save_wakeup_count(initial_count) ||
+		system_state != SYSTEM_RUNNING) {
 		mutex_unlock(&autosleep_lock);
 		goto out;
 	}
-- 
1.7.1

