From: jean.pihet@newoldbits.com
Subject: [PATCH 03/15] PM QoS: code re-organization
Date: Thu, 11 Aug 2011 17:06:40 +0200
Message-ID: <1313075212-8366-4-git-send-email-j-pihet__44683.4307550036$1313075756$gmane$org@ti.com>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Move around the PM QoS misc devices management code
for better readability.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 kernel/power/qos.c |   45 +++++++++++++++++++++++----------------------
 1 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 61275f2..fa9a090 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -190,28 +190,6 @@ static void update_target(struct pm_qos_object *o, struct plist_node *node,
 					     NULL);
 }
 
-static int register_pm_qos_misc(struct pm_qos_object *qos)
-{
-	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
-	qos->pm_qos_power_miscdev.name = qos->name;
-	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
-
-	return misc_register(&qos->pm_qos_power_miscdev);
-}
-
-static int find_pm_qos_object_by_minor(int minor)
-{
-	int pm_qos_class;
-
-	for (pm_qos_class = 0;
-		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
-		if (minor ==
-			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
-			return pm_qos_class;
-	}
-	return -1;
-}
-
 /**
  * pm_qos_request - returns current system wide qos expectation
  * @pm_qos_class: identification of which qos value is requested
@@ -364,6 +342,29 @@ int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *notifier)
 }
 EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
 
+/* User space interface to PM QoS classes via misc devices */
+static int register_pm_qos_misc(struct pm_qos_object *qos)
+{
+	qos->pm_qos_power_miscdev.minor = MISC_DYNAMIC_MINOR;
+	qos->pm_qos_power_miscdev.name = qos->name;
+	qos->pm_qos_power_miscdev.fops = &pm_qos_power_fops;
+
+	return misc_register(&qos->pm_qos_power_miscdev);
+}
+
+static int find_pm_qos_object_by_minor(int minor)
+{
+	int pm_qos_class;
+
+	for (pm_qos_class = 0;
+		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
+		if (minor ==
+			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
+			return pm_qos_class;
+	}
+	return -1;
+}
+
 static int pm_qos_power_open(struct inode *inode, struct file *filp)
 {
 	long pm_qos_class;
-- 
1.7.2.5
