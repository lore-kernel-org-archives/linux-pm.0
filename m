From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM: Remove WARN_ON from device_pm_add
Date: Sat, 9 Aug 2008 01:05:13 +0200
Message-ID: <200808090105.14770.rjw__14346.2071930573$1218237138$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

PM: Remove WARN_ON from device_pm_add

Fix message in device_pm_add() saying that the device will not be
added to dpm_list, although in fact the device is going to be added
to the list regardless of the ordering violation.

Remove the WARN_ON(true) triggered in that situation, because it is
hit by USB very often and spams the users' logs.

This patch fixes bug #11263

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -74,11 +74,9 @@ void device_pm_add(struct device *dev)
 		 kobject_name(&dev->kobj));
 	mutex_lock(&dpm_list_mtx);
 	if (dev->parent) {
-		if (dev->parent->power.status >= DPM_SUSPENDING) {
-			dev_warn(dev, "parent %s is sleeping, will not add\n",
+		if (dev->parent->power.status >= DPM_SUSPENDING)
+			dev_warn(dev, "parent %s should not be sleeping\n",
 				dev->parent->bus_id);
-			WARN_ON(true);
-		}
 	} else if (transition_started) {
 		/*
 		 * We refuse to register parentless devices while a PM
