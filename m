From: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Subject: [PATCH] Runtime PM: Adding explicit check to make sure
 dev->parent supports runtime PM before accessing its PM fields.
Date: Fri, 4 Dec 2009 09:07:34 +0530
Message-ID: <175E0F9A9EFCEA46A65F5552BB057298C5C4EDD5@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

The below patch makes sure that dev->parent supports runtime PM before accessing its PM fields. Though the code does this check at a later point in time, doing it earlier can optimize the code flow.

Regards,	
Nithish Mahalingam



>From 2e7fe2ea2737b8f70da20c8ec77235f8548d1331 Mon Sep 17 00:00:00 2001
From: Nithish Mahalingam <nithish.mahalingam@intel.com>
Date: Thu, 3 Dec 2009 13:27:02 +0530
Subject: [PATCH] Adding explicit check to make sure dev->parent supports runtime PM before accessing its PM fields.

This patch adds explicit checks to make sure dev->parent supports runtime PM
before accessing any of its runtime PM fields.

	modified:   drivers/base/power/runtime.c

Signed-off-by: Nithish Mahalingam <nithish.mahalingam@intel.com>
---
 drivers/base/power/runtime.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 846d89e..87ac2d6 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -209,7 +209,7 @@ int __pm_runtime_suspend(struct device *dev, bool from_wq)
 	} else {
 		dev->power.runtime_status = RPM_SUSPENDED;
 
-		if (dev->parent) {
+		if (dev->parent && !dev->parent->power.disable_depth) {
 			parent = dev->parent;
 			atomic_add_unless(&parent->power.child_count, -1, 0);
 		}
@@ -322,7 +322,7 @@ int __pm_runtime_resume(struct device *dev, bool from_wq)
 		goto repeat;
 	}
 
-	if (!parent && dev->parent) {
+	if (dev->parent && !dev->parent->power.disable_depth) {
 		/*
 		 * Increment the parent's resume counter and resume it if
 		 * necessary.
@@ -334,11 +334,10 @@ int __pm_runtime_resume(struct device *dev, bool from_wq)
 
 		spin_lock(&parent->power.lock);
 		/*
-		 * We can resume if the parent's run-time PM is disabled or it
-		 * is set to ignore children.
+		 * We can resume if the parent's run-time PM is set to
+		 * ignore children.
 		 */
-		if (!parent->power.disable_depth
-		    && !parent->power.ignore_children) {
+		if (!parent->power.ignore_children) {
 			__pm_runtime_resume(parent, false);
 			if (parent->power.runtime_status != RPM_ACTIVE)
 				retval = -EBUSY;
@@ -749,7 +748,9 @@ EXPORT_SYMBOL_GPL(__pm_runtime_put);
  */
 int __pm_runtime_set_status(struct device *dev, unsigned int status)
 {
-	struct device *parent = dev->parent;
+	struct device *parent = dev->parent ?
+		(dev->parent->power.disable_depth ? NULL : dev->parent) :
+		NULL;
 	unsigned long flags;
 	bool notify_parent = false;
 	int error = 0;
@@ -784,8 +785,7 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
 		 * not active, has run-time PM enabled and the
 		 * 'power.ignore_children' flag unset.
 		 */
-		if (!parent->power.disable_depth
-		    && !parent->power.ignore_children
+		if (!parent->power.ignore_children
 		    && parent->power.runtime_status != RPM_ACTIVE) {
 			error = -EBUSY;
 		} else {
-- 
1.6.5.2
