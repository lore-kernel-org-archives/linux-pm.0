From: Joe Perches <joe@perches.com>
Subject: [PATCH 3/6] power: suspend: Standardize "Syncing filesystems" messages
Date: Thu,  4 Jun 2015 11:36:46 -0700
Message-ID: <77dd1cad688af445e8e1d9eb184ee5b49a674e97.1433442778.git.joe@perches.com>
References: <cover.1433442778.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1433442778.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Always emit the "Syncing filesystems" on 2 separate lines so
that these messages can't be interleaved.

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/power/suspend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 53266b7..c3fec97 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -485,9 +485,9 @@ static int enter_state(suspend_state_t state)
 		freeze_begin();
 
 	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
-	printk(KERN_INFO "PM: Syncing filesystems ... ");
+	printk(KERN_INFO "PM: Syncing filesystems...\n");
 	sys_sync();
-	printk("done.\n");
+	printk(KERN_INFO "PM: Syncing filesystems: done\n");
 	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
 
 	pr_debug("PM: Preparing system for sleep (%s)\n", pm_states[state]);
-- 
2.1.2
