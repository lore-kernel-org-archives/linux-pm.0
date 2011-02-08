From: Tejun Heo <tj@kernel.org>
Subject: [PATCH wq#for-2.6.39] workqueue: add system_freezeable_wq
Date: Tue, 8 Feb 2011 10:41:55 +0100
Message-ID: <20110208094155.GB6558__41160.3996567011$1297158177$gmane$org@htj.dyndns.org>
References: <201102080029.57195.rjw@sisk.pl>
	<20110208044712.GA906@core.coreip.homeip.net>
	<201102081020.25646.rjw@sisk.pl>
	<20110208093212.GA6558@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110208093212.GA6558@htj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <len.brown@intel.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

>From de62c151df9b6568c67977920267392c432f340a Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 8 Feb 2011 10:39:03 +0100

Add system wide freezeable workqueue.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
---
Please feel free to pull from the following branch.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-2.6.39

Thanks.

 include/linux/workqueue.h |    4 ++++
 kernel/workqueue.c        |    4 +++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 1ac1158..de6a755 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -286,11 +286,15 @@ enum {
  * any specific CPU, not concurrency managed, and all queued works are
  * executed immediately as long as max_active limit is not reached and
  * resources are available.
+ *
+ * system_freezeable_wq is equivalent to system_wq except that it's
+ * freezeable.
  */
 extern struct workqueue_struct *system_wq;
 extern struct workqueue_struct *system_long_wq;
 extern struct workqueue_struct *system_nrt_wq;
 extern struct workqueue_struct *system_unbound_wq;
+extern struct workqueue_struct *system_freezeable_wq;
 
 extern struct workqueue_struct *
 __alloc_workqueue_key(const char *name, unsigned int flags, int max_active,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 11869fa..2b8de0c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3764,8 +3764,10 @@ static int __init init_workqueues(void)
 	system_nrt_wq = alloc_workqueue("events_nrt", WQ_NON_REENTRANT, 0);
 	system_unbound_wq = alloc_workqueue("events_unbound", WQ_UNBOUND,
 					    WQ_UNBOUND_MAX_ACTIVE);
+	system_freezeable_wq = alloc_workqueue("events_freezeable",
+					       WQ_FREEZEABLE, 0);
 	BUG_ON(!system_wq || !system_long_wq || !system_nrt_wq ||
-	       !system_unbound_wq);
+	       !system_unbound_wq || !system_freezeable_wq);
 	return 0;
 }
 early_initcall(init_workqueues);
-- 
1.7.1
