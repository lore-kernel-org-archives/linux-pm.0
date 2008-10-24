From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Freezer: Don't count threads waiting for frozen
	filesystems.
Date: Sat, 25 Oct 2008 09:07:48 +1100
Message-ID: <1224886068.6478.21.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi.

While working on freezing fuse filesystems, I found that if a filesystem
is frozen when we try to freeze processes, freezing can fail because
threads are waiting in vfs_check_frozen for the filesystem to be thawed.
We should thus not count such threads.

The check will be safe if a filesystem is thawed while we're freezing
processes because filesystem thaws are only invoked from userspace. Any
waiting processes will be woken and frozen prior to us completing the
freezing of userspace (the caller invoking the filesystem thaw will be
freezing) or - in the worst case - together with kernel threads.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>

diff --git a/include/linux/fs.h b/include/linux/fs.h
index a6a625b..c9b055d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -8,6 +8,7 @@
 
 #include <linux/limits.h>
 #include <linux/ioctl.h>
+#include <linux/freezer.h>
 
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
@@ -1187,8 +1190,11 @@ enum {
 	SB_FREEZE_TRANS = 2,
 };
 
-#define vfs_check_frozen(sb, level) \
-	wait_event((sb)->s_wait_unfrozen, ((sb)->s_frozen < (level)))
+#define vfs_check_frozen(sb, level) do { \
+	freezer_do_not_count(); \
+	wait_event((sb)->s_wait_unfrozen, ((sb)->s_frozen < (level))); \
+	freezer_count(); \
+} while (0)
 
 #define get_fs_excl() atomic_inc(&current->fs_excl)
 #define put_fs_excl() atomic_dec(&current->fs_excl)
