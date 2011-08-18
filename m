From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH v6 1/4] PM / OPP: Add OPP availability change
	notifier.
Date: Thu, 18 Aug 2011 19:27:39 +0900
Message-ID: <1313663262-15308-2-git-send-email-myungjoo.ham@samsung.com>
References: <1313663262-15308-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1313663262-15308-1-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

The patch enables to register notifier_block for an OPP-device in order
to get notified for any changes in the availability of OPPs of the
device. For example, if a new OPP is inserted or enable/disable status
of an OPP is changed, the notifier is executed.

This enables the usage of opp_add, opp_enable, and opp_disable to
directly take effect with any connected entities such as CPUFREQ or
DEVFREQ.

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

---
Added at devfreq patch set v6 replacing devfreq_update calls at OPP.
---
 drivers/base/power/opp.c |   28 ++++++++++++++++++++++++++++
 include/linux/opp.h      |   12 ++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index b23de18..39e16c3 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -73,6 +73,7 @@ struct opp {
  *		RCU usage: nodes are not modified in the list of device_opp,
  *		however addition is possible and is secured by dev_opp_list_lock
  * @dev:	device pointer
+ * @head:	notifier head to notify the OPP availability changes.
  * @opp_list:	list of opps
  *
  * This is an internal data structure maintaining the link to opps attached to
@@ -83,6 +84,8 @@ struct device_opp {
 	struct list_head node;
 
 	struct device *dev;
+	struct srcu_notifier_head head;
+
 	struct list_head opp_list;
 };
 
@@ -404,6 +407,7 @@ int opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 		}
 
 		dev_opp->dev = dev;
+		srcu_init_notifier_head(&dev_opp->head);
 		INIT_LIST_HEAD(&dev_opp->opp_list);
 
 		/* Secure the device list modification */
@@ -428,6 +432,11 @@ int opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	list_add_rcu(&new_opp->node, head);
 	mutex_unlock(&dev_opp_list_lock);
 
+	/*
+	 * Notify the changes in the availability of the operable
+	 * frequency/voltage list.
+	 */
+	srcu_notifier_call_chain(&dev_opp->head, OPP_EVENT_ADD, new_opp);
 	return 0;
 }
 
@@ -504,6 +513,11 @@ static int opp_set_availability(struct device *dev, unsigned long freq,
 	mutex_unlock(&dev_opp_list_lock);
 	synchronize_rcu();
 
+	/* Notify the change of the OPP availability */
+	srcu_notifier_call_chain(&dev_opp->head, availability_req ?
+				 OPP_EVENT_ENABLE : OPP_EVENT_DISABLE,
+				 new_opp);
+
 	/* clean up old opp */
 	new_opp = opp;
 	goto out;
@@ -512,6 +526,7 @@ unlock:
 	mutex_unlock(&dev_opp_list_lock);
 out:
 	kfree(new_opp);
+
 	return r;
 }
 
@@ -643,3 +658,16 @@ void opp_free_cpufreq_table(struct device *dev,
 	*table = NULL;
 }
 #endif		/* CONFIG_CPU_FREQ */
+
+/** opp_get_notifier() - find notifier_head of the device with opp
+ * @dev:	device pointer used to lookup device OPPs.
+ */
+struct srcu_notifier_head *opp_get_notifier(struct device *dev)
+{
+	struct device_opp *dev_opp = find_device_opp(dev);
+
+	if (IS_ERR(dev_opp))
+		return ERR_PTR(PTR_ERR(dev_opp)); /* matching type */
+
+	return &dev_opp->head;
+}
diff --git a/include/linux/opp.h b/include/linux/opp.h
index 7020e97..53d4538 100644
--- a/include/linux/opp.h
+++ b/include/linux/opp.h
@@ -16,9 +16,14 @@
 
 #include <linux/err.h>
 #include <linux/cpufreq.h>
+#include <linux/notifier.h>
 
 struct opp;
 
+enum opp_event {
+	OPP_EVENT_ADD, OPP_EVENT_ENABLE, OPP_EVENT_DISABLE, OPP_EVENT_MAX
+};
+
 #if defined(CONFIG_PM_OPP)
 
 unsigned long opp_get_voltage(struct opp *opp);
@@ -40,6 +45,8 @@ int opp_enable(struct device *dev, unsigned long freq);
 
 int opp_disable(struct device *dev, unsigned long freq);
 
+struct srcu_notifier_head *opp_get_notifier(struct device *dev);
+
 #else
 static inline unsigned long opp_get_voltage(struct opp *opp)
 {
@@ -89,6 +96,11 @@ static inline int opp_disable(struct device *dev, unsigned long freq)
 {
 	return 0;
 }
+
+struct srcu_notifier_head *opp_get_notifier(struct device *dev)
+{
+	return ERR_PTR(-EINVAL);
+}
 #endif		/* CONFIG_PM */
 
 #if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)
-- 
1.7.4.1
