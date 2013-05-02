From: Colin Cross <ccross@android.com>
Subject: [PATCH v2 04/10] binder: use freezable blocking calls
Date: Wed,  1 May 2013 18:35:02 -0700
Message-ID: <1367458508-9133-5-git-send-email-ccross@android.com>
References: <1367458508-9133-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1367458508-9133-1-git-send-email-ccross@android.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: linux-pm@vger.kernel.org
Cc: devel@driverdev.osuosl.org, Sachin Kamat <sachin.kamat@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, arve@android.com, Al Viro <viro@zeniv.linux.org.uk>, Colin Cross <ccross@android.com>, Tejun Heo <tj@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-pm@vger.kernel.org

Avoid waking up every thread sleeping in a binder call during
suspend and resume by calling a freezable blocking call.  Previous
patches modified the freezer to avoid sending wakeups to threads
that are blocked in freezable blocking calls.

This call was selected to be converted to a freezable call because
it doesn't hold any locks or release any resources when interrupted
that might be needed by another freezing task or a kernel driver
during suspend, and is a common site where idle userspace tasks are
blocked.

Signed-off-by: Colin Cross <ccross@android.com>
---
 drivers/staging/android/binder.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/android/binder.c b/drivers/staging/android/binder.c
index 24456a0..af8fba4 100644
--- a/drivers/staging/android/binder.c
+++ b/drivers/staging/android/binder.c
@@ -20,6 +20,7 @@
 #include <asm/cacheflush.h>
 #include <linux/fdtable.h>
 #include <linux/file.h>
+#include <linux/freezer.h>
 #include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
@@ -2140,13 +2141,13 @@ retry:
 			if (!binder_has_proc_work(proc, thread))
 				ret = -EAGAIN;
 		} else
-			ret = wait_event_interruptible_exclusive(proc->wait, binder_has_proc_work(proc, thread));
+			ret = wait_event_freezable_exclusive(proc->wait, binder_has_proc_work(proc, thread));
 	} else {
 		if (non_block) {
 			if (!binder_has_thread_work(thread))
 				ret = -EAGAIN;
 		} else
-			ret = wait_event_interruptible(thread->wait, binder_has_thread_work(thread));
+			ret = wait_event_freezable(thread->wait, binder_has_thread_work(thread));
 	}
 
 	binder_lock(__func__);
-- 
1.8.2.1
