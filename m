From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/6 v2] PM / Domains: Make failing
	pm_genpd_prepare() clean up properly
Date: Sun, 10 Jul 2011 11:06:37 +0200
Message-ID: <201107101106.37747.rjw__16377.0488150933$1310289296$gmane$org@sisk.pl>
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

If pm_generic_prepare() in pm_genpd_prepare() returns error code,
the PM domains counter of "prepared" devices should be decremented
and its suspend_power_off flag should be reset if this counter drops
down to zero.  Otherwise, the PM domain runtime PM code will not
handle the domain correctly (it will permanently think that system
suspend is in progress).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/base/power/domain.c
===================================================================
--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -367,6 +367,7 @@ static void pm_genpd_sync_poweroff(struc
 static int pm_genpd_prepare(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
+	int ret;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -400,7 +401,16 @@ static int pm_genpd_prepare(struct devic
 
 	mutex_unlock(&genpd->lock);
 
-	return pm_generic_prepare(dev);
+	ret = pm_generic_prepare(dev);
+	if (ret) {
+		mutex_lock(&genpd->lock);
+
+		if (--genpd->prepared_count == 0)
+			genpd->suspend_power_off = false;
+
+		mutex_unlock(&genpd->lock);
+	}
+	return ret;
 }
 
 /**
