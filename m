From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 7 v2] PM / Domains: Queue up power off work only
	if it is not pending
Date: Sun, 10 Jul 2011 14:29:26 +0200
Message-ID: <201107101429.26416.rjw__18627.2733765238$1310300972$gmane$org@sisk.pl>
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

In theory it is possible that pm_genpd_poweroff() for two different
subdomains of the same parent domain will attempt to queue up the
execution of pm_genpd_poweroff() for the parent twice in a row.  This
would lead to unpleasant consequences, so prevent it from happening
by checking if genpd->power_off_work is pending before attempting to
queue it up.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

One more patch to the "PM / Domains: Generic PM domains improvements" series,
the changelog should explain everything. :-)

Thanks,
Rafael

---
 drivers/base/power/domain.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/base/power/domain.c
===================================================================
--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -213,6 +213,19 @@ static bool genpd_abort_poweroff(struct
 }
 
 /**
+ * genpd_queue_power_off_work - Queue up the execution of pm_genpd_poweroff().
+ * @genpd: PM domait to power off.
+ *
+ * Queue up the execution of pm_genpd_poweroff() unless it's already been done
+ * before.
+ */
+static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
+{
+	if (!work_pending(&genpd->power_off_work))
+		queue_work(pm_wq, &genpd->power_off_work);
+}
+
+/**
  * pm_genpd_poweroff - Remove power from a given PM domain.
  * @genpd: PM domain to power down.
  *
@@ -304,7 +317,7 @@ static int pm_genpd_poweroff(struct gene
 	if (parent) {
 		genpd_sd_counter_dec(parent);
 		if (parent->sd_count == 0)
-			queue_work(pm_wq, &parent->power_off_work);
+			genpd_queue_power_off_work(parent);
 
 		genpd_release_lock(parent);
 	}
