From: Imre Deak <imre.deak@intel.com>
Subject: [PATCH] PM / Sleep: fix recovery during s2ram/hibernation
Date: Fri, 24 Oct 2014 10:43:13 +0300
Message-ID: <1414136593-25329-1-git-send-email-imre.deak@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:42642 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbaJXHna (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Oct 2014 03:43:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Atm, if one of the dev_pm_ops::freeze callbacks fails during the QUIESCE
phase we don't rollback things correctly calling the thaw and complete
callbacks. This could leave some devices in a suspended state in case of
an error during resuming from hibernation.

Also if an asynchronous suspend_late or freeze_late callback fails
during the SUSPEND, FREEZE or QUIESCE phases we don't propagate the
corresponding error correctly, in effect ignoring the error and
continuing the suspend-to-ram/hibernation. During suspend-to-ram this
could leave some devices without a valid saved context, leading to a
failure to reinitialize them during resume. During hibernation this
could leave some devices active interfeering with the creation /
restoration of the hibernation image. Also this could leave the
corresponding devices without a valid saved context and failure to
reinitialize them during resume.

Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/base/power/main.c | 2 ++
 kernel/power/hibernate.c  | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 4497319..9717d5f 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1266,6 +1266,8 @@ int dpm_suspend_late(pm_message_t state)
 	}
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
+	if (!error)
+		error = async_error;
 	if (error) {
 		suspend_stats.failed_suspend_late++;
 		dpm_save_failed_step(SUSPEND_SUSPEND_LATE);
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a9dfa79..05768d5 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -502,8 +502,10 @@ int hibernation_restore(int platform_mode)
 	error = dpm_suspend_start(PMSG_QUIESCE);
 	if (!error) {
 		error = resume_target_kernel(platform_mode);
-		dpm_resume_end(PMSG_RECOVER);
+		BUG_ON(!error);
 	}
+	if (error)
+		dpm_resume_end(PMSG_RECOVER);
 	pm_restore_gfp_mask();
 	resume_console();
 	pm_restore_console();
-- 
1.9.1

