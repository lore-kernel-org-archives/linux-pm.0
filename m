From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] PM / Runtime: Use alloc_workqueue() for
	creating PM workqueue
Date: Wed, 15 Sep 2010 21:56:30 +0200
Message-ID: <201009152156.30749.rjw__41891.3216483363$1284580794$gmane$org@sisk.pl>
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
To: Tejun Heo <tj@kernel.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM / Runtime: Use alloc_workqueue() for creating PM workqueue

Although we need the PM workqueue to be freezable, we don't need it
to be singlethread.  Also, the number of concurrent work items
running on a single CPU need not be constrained.  For these reasons
use alloc_workqueue() directly, with suitable arguments, instead of
create_freezeable_workqueue(), to create the runtime PM workqueue.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

Tejun,

I'm not sure about that WQ_RESCUER thing.  Can you please tell me what
exactly it is for?

Thanks,
Rafael

---
 kernel/power/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -308,7 +308,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
 
 static int __init pm_start_workqueue(void)
 {
-	pm_wq = create_freezeable_workqueue("pm");
+	pm_wq = alloc_workqueue("pm", WQ_FREEZEABLE | WQ_RESCUER, 0);
 
 	return pm_wq ? 0 : -ENOMEM;
 }
