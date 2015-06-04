From: Joe Perches <joe@perches.com>
Subject: [PATCH 1/6] power: hibernate: Use separate messages for "Syncing filesystems"
Date: Thu,  4 Jun 2015 11:36:44 -0700
Message-ID: <1664a8ea72b34db4bef860004166875ab70898ee.1433442778.git.joe@perches.com>
References: <cover.1433442778.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1433442778.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add the ability to see how long it takes to sync the filesystems
via the printk time mechanism.

Start to standardize the printk "PM: doing something...done"
messages on two separate lines.

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/power/hibernate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2329daa..2466d78 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -663,9 +663,9 @@ int hibernate(void)
 	if (error)
 		goto Exit;
 
-	printk(KERN_INFO "PM: Syncing filesystems ... ");
+	printk(KERN_INFO "PM: Syncing filesystems ...\n");
 	sys_sync();
-	printk("done.\n");
+	printk(KERN_INFO "PM: Syncing filesystems: done\n");
 
 	error = freeze_processes();
 	if (error)
-- 
2.1.2
