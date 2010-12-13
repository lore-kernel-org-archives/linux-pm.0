From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 4/4] PM: Permit registrarion of parentless
	devices during system suspend
Date: Mon, 13 Dec 2010 01:33:51 +0100
Message-ID: <201012130133.52072.rjw__39981.539551127$1292201047$gmane$org@sisk.pl>
References: <201012130128.31243.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012130128.31243.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The registration of a new parentless device during system suspend
will not lead to any complications affecting the PM core (the device
will be effectively seen after the subsequent resume has completed),
so remove the code used for detection of such events.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |   25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -49,12 +49,6 @@ LIST_HEAD(dpm_noirq_list);
 static DEFINE_MUTEX(dpm_list_mtx);
 static pm_message_t pm_transition;
 
-/*
- * Set once the preparation of devices for a PM transition has started, reset
- * before starting to resume devices.  Protected by dpm_list_mtx.
- */
-static bool transition_started;
-
 static int async_error;
 
 /**
@@ -97,19 +91,9 @@ void device_pm_add(struct device *dev)
 		 dev->bus ? dev->bus->name : "No Bus",
 		 kobject_name(&dev->kobj));
 	mutex_lock(&dpm_list_mtx);
-	if (dev->parent) {
-		if (dev->parent->power.in_suspend)
-			dev_warn(dev, "parent %s should not be sleeping\n",
-				 dev_name(dev->parent));
-	} else if (transition_started) {
-		/*
-		 * We refuse to register parentless devices while a PM
-		 * transition is in progress in order to avoid leaving them
-		 * unhandled down the road
-		 */
-		dev_WARN(dev, "Parentless device registered during a PM transaction\n");
-	}
-
+	if (dev->parent && dev->parent->power.in_suspend)
+		dev_warn(dev, "parent %s should not be sleeping\n",
+			dev_name(dev->parent));
 	list_add_tail(&dev->power.entry, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
 }
@@ -482,7 +466,6 @@ void dpm_resume_noirq(pm_message_t state
 	ktime_t starttime = ktime_get();
 
 	mutex_lock(&dpm_list_mtx);
-	transition_started = false;
 	while (!list_empty(&dpm_noirq_list)) {
 		struct device *dev = to_device(dpm_noirq_list.next);
 		int error;
@@ -683,7 +666,6 @@ static void dpm_complete(pm_message_t st
 
 	INIT_LIST_HEAD(&list);
 	mutex_lock(&dpm_list_mtx);
-	transition_started = false;
 	while (!list_empty(&dpm_prepared_list)) {
 		struct device *dev = to_device(dpm_prepared_list.prev);
 
@@ -1020,7 +1002,6 @@ static int dpm_prepare(pm_message_t stat
 	int error = 0;
 
 	mutex_lock(&dpm_list_mtx);
-	transition_started = true;
 	while (!list_empty(&dpm_list)) {
 		struct device *dev = to_device(dpm_list.next);
 
