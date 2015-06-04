From: Joe Perches <joe@perches.com>
Subject: [PATCH 5/6] power: user: Standardize "Syncing filesystems ..." message
Date: Thu,  4 Jun 2015 11:36:48 -0700
Message-ID: <06fdc51c7d2ab639729107a137b947704fd7d161.1433442778.git.joe@perches.com>
References: <cover.1433442778.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1433442778.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Instead of a two individual printks that would generally be
emitted on a single line, emit 2 lines to make the start
and end of the synchronization more easily timeable.

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/power/user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 526e891..e22f6ad 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -221,9 +221,9 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		if (data->frozen)
 			break;
 
-		printk("Syncing filesystems ... ");
+		printk("Syncing filesystems ...\n");
 		sys_sync();
-		printk("done.\n");
+		printk("Syncing filesystems: done\n");
 
 		error = freeze_processes();
 		if (error)
-- 
2.1.2
