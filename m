From: Todd Poynor <toddpoynor@google.com>
Subject: [PATCH] fuse: Freeze client on suspend when request sent
	to userspace
Date: Wed, 24 Aug 2011 16:59:24 -0700
Message-ID: <1314230364-776-1-git-send-email-toddpoynor@google.com>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.sourceforge.net, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Suspend attempts can abort when the FUSE daemon is already frozen
and a client is waiting uninterruptibly for a response, causing
freezing of tasks to fail.

Use the freeze-friendly wait API, but disregard other signals.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
Have seen reports in which repeated suspend attempts were aborted
due to a task waiting uninterruptibly in this function, but
have only reproduced this artificially, by causing the daemon to
sleep.  Only modified the normal request path, not request aborts
and such, under the assumption that these should be rare and
should make progress upon resume.  Certain apps that read or
write a lot of data on the filesystem may apparently run into
this case rather frequently.

 fs/fuse/dev.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 168a80f..bded2e5 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -19,6 +19,7 @@
 #include <linux/pipe_fs_i.h>
 #include <linux/swap.h>
 #include <linux/splice.h>
+#include <linux/freezer.h>
 
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
@@ -383,7 +384,10 @@ __acquires(fc->lock)
 	 * Wait it out.
 	 */
 	spin_unlock(&fc->lock);
-	wait_event(req->waitq, req->state == FUSE_REQ_FINISHED);
+
+	while (req->state != FUSE_REQ_FINISHED)
+		wait_event_freezable(req->waitq,
+				     req->state == FUSE_REQ_FINISHED);
 	spin_lock(&fc->lock);
 
 	if (!req->aborted)
-- 
1.7.3.1
