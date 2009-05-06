From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 18/19] TuxOnIce: Provide a means of determining
	the freezer state.
Date: Thu,  7 May 2009 00:39:14 +1000
Message-ID: <1241620755-22133-19-git-send-email-nigel__30433.2765321762$1241621546$gmane$org@tuxonice.net>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

Provide a means for processes to determine whether the freezer is
currently on, so that they can act differently without necessarily being
frozen.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 include/linux/freezer.h |   16 ++++++++++++++++
 include/linux/fs.h      |    3 +++
 kernel/power/process.c  |   12 ++++++++++++
 3 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 4f50655..c775cd1 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -121,6 +121,21 @@ static inline void set_freezable(void)
 	current->flags &= ~PF_NOFREEZE;
 }
 
+#ifdef CONFIG_PM_SLEEP
+extern int freezer_state;
+#define FREEZER_OFF 0
+#define FREEZER_FILESYSTEMS_FROZEN 1
+#define FREEZER_USERSPACE_FROZEN 2
+#define FREEZER_FULLY_ON 3
+
+static inline int freezer_is_on(void)
+{
+	return freezer_state == FREEZER_FULLY_ON;
+}
+#else
+static inline int freezer_is_on(void) { return 0; }
+#endif
+
 extern void thaw_kernel_threads(void);
 
 /*
@@ -174,6 +189,7 @@ static inline int freeze_processes(void) { BUG(); return 0; }
 static inline void thaw_processes(void) {}
 
 static inline int try_to_freeze(void) { return 0; }
+static inline int freezer_is_on(void) { return 0; }
 static inline void thaw_kernel_threads(void) { }
 
 static inline void freezer_do_not_count(void) {}
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 344b1ca..a11406d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1950,6 +1950,9 @@ extern int thaw_bdev(struct block_device *bdev, struct super_block *sb);
 extern int fsync_bdev(struct block_device *);
 extern int fsync_super(struct super_block *);
 extern int fsync_no_super(struct block_device *);
+#define FS_FREEZER_FUSE 1
+#define FS_FREEZER_NORMAL 2
+#define FS_FREEZER_ALL (FS_FREEZER_FUSE | FS_FREEZER_NORMAL)
 #else
 static inline void bd_forget(struct inode *inode) {}
 static inline int sync_blockdev(struct block_device *bdev) { return 0; }
diff --git a/kernel/power/process.c b/kernel/power/process.c
index d464ef7..b2c7fe1 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -14,6 +14,8 @@
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
 
+int freezer_state;
+
 /* 
  * Timeout for stopping processes
  */
@@ -145,8 +147,17 @@ static void thaw_tasks(bool nosig_only)
 
 void thaw_processes(void)
 {
+	int old_state = freezer_state;
+
+	if (old_state == FREEZER_OFF)
+		return;
+
 	printk("Restarting tasks ... ");
 	thaw_tasks(true);
+	freezer_state = FREEZER_OFF;
+
+	if (old_state == FREEZER_FULLY_ON)
+		thaw_tasks(true);
 	thaw_tasks(false);
 	schedule();
 	printk("done.\n");
@@ -154,5 +165,6 @@ void thaw_processes(void)
 
 void thaw_kernel_threads(void)
 {
+	freezer_state = FREEZER_USERSPACE_FROZEN;
 	thaw_tasks(true);
 }
-- 
1.5.6.3
