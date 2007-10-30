From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] hibernate: fix lockdep report
Date: Tue, 30 Oct 2007 11:38:44 +0100
Message-ID: <1193740724.3912.10.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Lockdep reports a circular locking dependency in the hibernate code
because
 - during system boot hibernate code (from an initcall) locks pm_mutex
   and then a sysfs buffer mutex via name_to_dev_t
 - during regular operation hibernate code locks pm_mutex under a
   sysfs buffer mutex because it's called from sysfs methods.

The deadlock can never happen because during initcall invocation nothing
can write to sysfs yet. This removes the lockdep report by marking the
initcall locking as being in a different class.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
I can't seem to track the occurrence down to a commit, maybe something
within sysfs. I'm fairly sure I first saw it on a git kernel after the
2.6.24 merge period started but I haven't bisected it.

 kernel/power/disk.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- linux-2.6.orig/kernel/power/disk.c	2007-10-30 11:12:36.878080023 +0100
+++ linux-2.6/kernel/power/disk.c	2007-10-30 11:14:53.838071832 +0100
@@ -456,7 +456,17 @@ static int software_resume(void)
 	int error;
 	unsigned int flags;
 
-	mutex_lock(&pm_mutex);
+	/*
+	 * name_to_dev_t() below takes a sysfs buffer mutex when sysfs
+	 * is configured into the kernel. Since the regular hibernate
+	 * trigger path is via sysfs which takes a buffer mutex before
+	 * calling hibernate functions (which take pm_mutex) this can
+	 * cause lockdep to complain about a possible ABBA deadlock
+	 * which cannot happen since we're in the boot code here and
+	 * sysfs can't be invoked yet. Therefore, we use a subclass
+	 * here to avoid lockdep complaining.
+	 */
+	mutex_lock_nested(&pm_mutex, 1);
 	if (!swsusp_resume_device) {
 		if (!strlen(resume_file)) {
 			mutex_unlock(&pm_mutex);
