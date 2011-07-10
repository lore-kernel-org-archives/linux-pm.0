From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/6 v2] PM / Domains: Improve handling of wakeup
	devices during system suspend
Date: Sun, 10 Jul 2011 11:09:35 +0200
Message-ID: <201107101109.36176.rjw__32475.3169472844$1310289480$gmane$org@sisk.pl>
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

Kevin points out that if there's a device that can wake up the system
from sleep states, but it doesn't generate wakeup signals by itself
(they are generated on its behalf by other parts of the system) and
it currently is not enabled to wake up the system (that is,
device_may_wakeup() returns "false" for it), we may need to change
its wakeup settings during system suspend (for example, the device
might have been configured to signal remote wakeup from the system's
working state, as needed by runtime PM).  Therefore the generic PM
domains code should invoke the system suspend callbacks provided by
the device's driver, which it doesn't do if the PM domain is powered
off during the system suspend's "prepare" stage.  This is a valid
point.  Moreover, this code also should make sure that system wakeup
devices that are enabled to wake up the system from sleep states and
have to remain active for this purpose are not suspended while the
system is in a sleep state.

To avoid the above issues, make the generic PM domains' .prepare()
routine, pm_genpd_prepare(), force runtime resume of devices whose
system wakeup settings may need to be changed during system suspend
or that should remain active while the system is in a sleep state to
be able to wake it up from that state.

Reported-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

Index: linux-2.6/drivers/base/power/domain.c
===================================================================
--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -482,6 +482,33 @@ static void pm_genpd_sync_poweroff(struc
 }
 
 /**
+ * resume_needed - Check whether to resume a device before system suspend.
+ * @dev: Device to check.
+ * @genpd: PM domain the device belongs to.
+ *
+ * There are two cases in which a device that can wake up the system from sleep
+ * states should be resumed by pm_genpd_prepare(): (1) if the device is enabled
+ * to wake up the system and it has to remain active for this purpose while the
+ * system is in the sleep state and (2) if the device is not enabled to wake up
+ * the system from sleep states and it generally doesn't generate wakeup signals
+ * by itself (those signals are generated on its behalf by other parts of the
+ * system).  In the latter case it may be necessary to reconfigure the device's
+ * wakeup settings during system suspend, because it may have been set up to
+ * signal remote wakeup from the system's working state as needed by runtime PM.
+ * Return 'true' in either of the above cases.
+ */
+static bool resume_needed(struct device *dev, struct generic_pm_domain *genpd)
+{
+	bool active_wakeup;
+
+	if (!device_can_wakeup(dev))
+		return false;
+
+	active_wakeup = genpd->active_wakeup && genpd->active_wakeup(dev);
+	return device_may_wakeup(dev) ? active_wakeup : !active_wakeup;
+}
+
+/**
  * pm_genpd_prepare - Start power transition of a device in a PM domain.
  * @dev: Device to start the transition of.
  *
@@ -515,6 +542,9 @@ static int pm_genpd_prepare(struct devic
 		return -EBUSY;
 	}
 
+	if (resume_needed(dev, genpd))
+		pm_runtime_resume(dev);
+
 	genpd_acquire_lock(genpd);
 
 	if (genpd->prepared_count++ == 0)
