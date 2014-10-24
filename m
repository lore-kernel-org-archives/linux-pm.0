From: Imre Deak <imre.deak@intel.com>
Subject: [PATCH v3 2/2] PM / Sleep: fix recovery during resuming from hibernation
Date: Fri, 24 Oct 2014 20:29:10 +0300
Message-ID: <1414171750-6858-2-git-send-email-imre.deak@intel.com>
References: <1414171750-6858-1-git-send-email-imre.deak@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414171750-6858-1-git-send-email-imre.deak@intel.com>
In-Reply-To: <1414137549-30005-1-git-send-email-imre.deak@intel.com>
References: <1414137549-30005-1-git-send-email-imre.deak@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If a device's dev_pm_ops::freeze callback fails during the QUIESCE
phase we don't rollback things correctly calling the thaw and complete
callbacks. This could leave some devices in a suspended state in case of
an error during resuming from hibernation.

v2:
- call dpm_resume_end() unconditionally, it's guaranteed that error
  is non-zero
v3:
- split out this fix into a separate patch (Rafael)
- add code comment on why BUG_ON() is used (Rafael)

Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 kernel/power/hibernate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a9dfa79..1f35a34 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -502,8 +502,14 @@ int hibernation_restore(int platform_mode)
 	error = dpm_suspend_start(PMSG_QUIESCE);
 	if (!error) {
 		error = resume_target_kernel(platform_mode);
-		dpm_resume_end(PMSG_RECOVER);
+		/*
+		 * The above should either succeed and jump to the new kernel,
+		 * or return with an error. Otherwise things are just
+		 * undefined, so let's be paranoid.
+		 */
+		BUG_ON(!error);
 	}
+	dpm_resume_end(PMSG_RECOVER);
 	pm_restore_gfp_mask();
 	resume_console();
 	pm_restore_console();
-- 
1.8.4
