From: jean.pihet@newoldbits.com
Subject: [PATCH 1/2] PM: add a per-device wake-up latency
	constraints plist
Date: Tue, 21 Jun 2011 15:16:10 +0200
Message-ID: <1308662171-22337-2-git-send-email-j-pihet@ti.com>
References: <1308662171-22337-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1308662171-22337-1-git-send-email-j-pihet@ti.com>
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

Add the field wakeup_lat_plist_head in the struct dev_pm_info
and the initialization of the plist in device_pm_init.

This enables the implementation of per-device constraints in
PM QoS.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 drivers/base/power/main.c |    1 +
 include/linux/pm.h        |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index aa632020..6a096d1 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -64,6 +64,7 @@ void device_pm_init(struct device *dev)
 	spin_lock_init(&dev->power.lock);
 	pm_runtime_init(dev);
 	INIT_LIST_HEAD(&dev->power.entry);
+	plist_head_init(&dev->power.wakeup_lat_plist_head, &dev->power.lock);
 }
 
 /**
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 3160648..35fe682 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -22,6 +22,7 @@
 #define _LINUX_PM_H
 
 #include <linux/list.h>
+#include <linux/plist.h>
 #include <linux/workqueue.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
@@ -462,6 +463,7 @@ struct dev_pm_info {
 	unsigned long		accounting_timestamp;
 	void			*subsys_data;  /* Owned by the subsystem. */
 #endif
+	struct plist_head	wakeup_lat_plist_head;
 };
 
 extern void update_pm_runtime_accounting(struct device *dev);
-- 
1.7.4.1
