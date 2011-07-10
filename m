From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/6 v2] PM / Domains: Do not restore all devices
	on power off error
Date: Sun, 10 Jul 2011 11:08:46 +0200
Message-ID: <201107101108.46688.rjw__9495.93026093698$1310289368$gmane$org@sisk.pl>
References: <201107062248.35586.rjw@sisk.pl> <201107101059.30322.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107101059.30322.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Since every device in a PM domain has its own need_restore
flag, which is set by __pm_genpd_save_device(), there's no need to
walk the domain's device list and restore all devices on an error
from one of the drivers' .runtime_suspend() callbacks.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/base/power/domain.c
===================================================================
--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -269,8 +269,10 @@ static int pm_genpd_poweroff(struct gene
 
 	list_for_each_entry_reverse(dle, &genpd->dev_list, node) {
 		ret = __pm_genpd_save_device(dle, genpd);
-		if (ret)
-			goto err_dev;
+		if (ret) {
+			genpd_set_active(genpd);
+			goto out;
+		}
 
 		if (genpd_abort_poweroff(genpd))
 			goto out;
@@ -311,13 +313,6 @@ static int pm_genpd_poweroff(struct gene
 	genpd->poweroff_task = NULL;
 	wake_up_all(&genpd->status_wait_queue);
 	return ret;
-
- err_dev:
-	list_for_each_entry_continue(dle, &genpd->dev_list, node)
-		__pm_genpd_restore_device(dle, genpd);
-
-	genpd_set_active(genpd);
-	goto out;
 }
 
 /**
