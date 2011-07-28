From: jean.pihet@newoldbits.com
Subject: [PATCH 02/13] PM: add a per-device wake-up latency
	constraints plist
Date: Thu, 28 Jul 2011 10:30:09 +0200
Message-ID: <1311841821-10252-3-git-send-email-j-pihet__4179.32599452815$1311841948$gmane$org@ti.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Linux PM mailing list <linux-pm@lis>
Cc: Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Add the field latency_constraints in the struct dev_pm_info
and the initialization of the plist in device_pm_init.

This enables the implementation of per-device constraints in
PM QoS.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 drivers/base/power/main.c |    1 +
 include/linux/pm.h        |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 06f09bf..dad2eb9 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -97,6 +97,7 @@ void device_pm_add(struct device *dev)
 			dev_name(dev->parent));
 	list_add_tail(&dev->power.entry, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
+	plist_head_init(&dev->power.latency_constraints, &dev->power.lock);
 }
 
 /**
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 411e4f4..23c85f1 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -22,6 +22,7 @@
 #define _LINUX_PM_H
 
 #include <linux/list.h>
+#include <linux/plist.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
@@ -463,6 +464,7 @@ struct dev_pm_info {
 	unsigned long		accounting_timestamp;
 	void			*subsys_data;  /* Owned by the subsystem. */
 #endif
+	struct plist_head	latency_constraints;
 };
 
 extern void update_pm_runtime_accounting(struct device *dev);
-- 
1.7.2.5
