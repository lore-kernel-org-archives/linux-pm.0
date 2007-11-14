From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] Freezer: Make freezing failures less
	verbose by default
Date: Thu, 15 Nov 2007 00:38:06 +0100
Message-ID: <200711150038.07538.rjw__1096.05000257051$1195082562$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Arkadiusz Miskiewicz <arekm@maven.pl>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Currently freezing failures are extremely verbose which sometimes is
unnecessary and prevents the user from seeing which task could not be frozen.

Make them less verbose by default (ie. if CONFIG_PM_VERBOSE is unset).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/process.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6/kernel/power/process.c
===================================================================
--- linux-2.6.orig/kernel/power/process.c
+++ linux-2.6/kernel/power/process.c
@@ -163,6 +163,15 @@ static void cancel_freezing(struct task_
 	}
 }
 
+#ifdef CONFIG_PM_VERBOSE
+static inline void freezer_show_state(void)
+{
+	show_state();
+}
+#else /* !CONFIG_PM_VERBOSE */
+static inline void freezer_show_state(void) {}
+#endif /* !CONFIG_PM_VERBOSE */
+
 static int try_to_freeze_tasks(int freeze_user_space)
 {
 	struct task_struct *g, *p;
@@ -214,7 +223,7 @@ static int try_to_freeze_tasks(int freez
 		printk(KERN_ERR "Freezing of tasks failed after %d.%02d seconds "
 				"(%d tasks refusing to freeze):\n",
 				elapsed_csecs / 100, elapsed_csecs % 100, todo);
-		show_state();
+		freezer_show_state();
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			task_lock(p);
