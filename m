From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 3/4][RFC v2] PM / hibernate: introduce a flag to indicate resuming from hibernation
Date: Sun, 26 Jun 2016 00:18:52 +0800
Message-ID: <d4195120e18af7b097b64b0c45a55187617dc234.1466844557.git.yu.c.chen@intel.com>
References: <cover.1466844557.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14721 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbcFYQLn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 25 Jun 2016 12:11:43 -0400
In-Reply-To: <cover.1466844557.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, x86@kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, Pavel Machek <pavel@ucw.cz>, Brian Gerst <brgerst@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Varun Koyyalagunta <cpudebug@centtech.com>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

Sometime we need to do some operations before resuming from
hibernation, so introduce a flag to indicate this stage.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/suspend.h  | 7 +++++++
 kernel/power/hibernate.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8b6ec7e..422e87a 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -384,6 +384,12 @@ extern bool system_entering_hibernation(void);
 extern bool hibernation_available(void);
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
+extern bool in_resume_hibernate;
+
+static inline bool hibernation_in_resume(void)
+{
+	return in_resume_hibernate;
+}
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
 static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
@@ -395,6 +401,7 @@ static inline void hibernation_set_ops(const struct platform_hibernation_ops *op
 static inline int hibernate(void) { return -ENOSYS; }
 static inline bool system_entering_hibernation(void) { return false; }
 static inline bool hibernation_available(void) { return false; }
+static inline bool hibernation_in_resume(void) { return false; }
 #endif /* CONFIG_HIBERNATION */
 
 /* Hibernation and suspend events */
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index fca9254..41be909 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -43,6 +43,7 @@ static char resume_file[256] = CONFIG_PM_STD_PARTITION;
 dev_t swsusp_resume_device;
 sector_t swsusp_resume_block;
 __visible int in_suspend __nosavedata;
+bool in_resume_hibernate;
 
 enum {
 	HIBERNATION_INVALID,
@@ -433,6 +434,7 @@ static int resume_target_kernel(bool platform_mode)
 	if (error)
 		goto Cleanup;
 
+	in_resume_hibernate = true;
 	error = disable_nonboot_cpus();
 	if (error)
 		goto Enable_cpus;
@@ -474,6 +476,7 @@ static int resume_target_kernel(bool platform_mode)
 	local_irq_enable();
 
  Enable_cpus:
+	in_resume_hibernate = false;
 	enable_nonboot_cpus();
 
  Cleanup:
-- 
2.7.4

