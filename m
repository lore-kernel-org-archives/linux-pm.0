From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] PM / hibernate: Introduce snapshot test mode for hibernation
Date: Thu,  7 Jul 2016 14:40:58 +0800
Message-ID: <1467873658-31986-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33100 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbcGGGd5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 7 Jul 2016 02:33:57 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

This mode is to verify if the snapshot data written to
swap device can be successfully restored to memory. It
is useful to ease the debugging process on hibernation,
since this mode can not only bypass the BIOSen/bootloader,
but also the system re-initialization.

For example:
$ sudo echo snapshot > /sys/power/disk
$ sudo echo disk > /sys/power/state

/* manual resume.*/
$ sudo echo 8:3 > /sys/power/resume

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/power/hibernate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index fca9254..667d926 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -52,6 +52,7 @@ enum {
 #ifdef CONFIG_SUSPEND
 	HIBERNATION_SUSPEND,
 #endif
+	HIBERNATION_SNAPSHOT,
 	/* keep last */
 	__HIBERNATION_AFTER_LAST
 };
@@ -631,6 +632,9 @@ static void power_down(void)
 			                "Try swapon -a.\n");
 		return;
 #endif
+	case HIBERNATION_SNAPSHOT:
+		/* Do nothing. */
+		return;
 	}
 	kernel_halt();
 	/*
@@ -878,6 +882,7 @@ static const char * const hibernation_modes[] = {
 #ifdef CONFIG_SUSPEND
 	[HIBERNATION_SUSPEND]	= "suspend",
 #endif
+	[HIBERNATION_SNAPSHOT]	= "snapshot",
 };
 
 /*
@@ -924,6 +929,7 @@ static ssize_t disk_show(struct kobject *kobj, struct kobj_attribute *attr,
 #ifdef CONFIG_SUSPEND
 		case HIBERNATION_SUSPEND:
 #endif
+		case HIBERNATION_SNAPSHOT:
 			break;
 		case HIBERNATION_PLATFORM:
 			if (hibernation_ops)
@@ -970,6 +976,7 @@ static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
 #ifdef CONFIG_SUSPEND
 		case HIBERNATION_SUSPEND:
 #endif
+		case HIBERNATION_SNAPSHOT:
 			hibernation_mode = mode;
 			break;
 		case HIBERNATION_PLATFORM:
-- 
2.7.4

