From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 04/05] PM: Runtime PM v13 - CONFIG_PM_SLEEP=n
	support
Date: Fri, 07 Aug 2009 16:33:51 +0900
Message-ID: <20090807073351.22479.43870.sendpatchset@rx1.opensource.se>
References: <20090807073315.22479.89012.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090807073315.22479.89012.sendpatchset@rx1.opensource.se>
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
Cc: gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch contains a few fixes to allow Runtime PM
to be used even though suspend and hibernation are disabled
in the kconfig. Without this patch the Runtime PM code
compiles just fine with CONFIG_PM_SLEEP=n but the functions
pm_runtime_init() and pm_runtime_remove() never gets called
during runtime.

Not sure if CONFIG_PM_RUNTIME=y and CONFIG_PM_SLEEP=n really
is a valid combination, but I can easily imagine use cases
for Runtime PM without system suspend/hibernation support.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Can this patch be rolled into the main Runtime PM patch?

 Changes for v11->v13:
 - solved conflicts introduced by v11->v13 update

 drivers/base/core.c       |    3 +++
 drivers/base/power/main.c |    2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

--- 0001/drivers/base/core.c
+++ work/drivers/base/core.c	2009-08-07 13:56:54.000000000 +0900
@@ -23,6 +23,7 @@
 #include <linux/semaphore.h>
 #include <linux/mutex.h>
 #include <linux/async.h>
+#include <linux/pm_runtime.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -555,6 +556,7 @@ void device_initialize(struct device *de
 	INIT_LIST_HEAD(&dev->devres_head);
 	device_init_wakeup(dev, 0);
 	device_pm_init(dev);
+	pm_runtime_init(dev);
 	set_dev_node(dev, -1);
 }
 
@@ -1063,6 +1065,7 @@ void device_del(struct device *dev)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DEL_DEVICE, dev);
 	device_pm_remove(dev);
+	pm_runtime_remove(dev);
 	dpm_sysfs_remove(dev);
 	if (parent)
 		klist_del(&dev->p->knode_parent);
--- 0007/drivers/base/power/main.c
+++ work/drivers/base/power/main.c	2009-08-07 13:57:25.000000000 +0900
@@ -56,7 +56,6 @@ static bool transition_started;
 void device_pm_init(struct device *dev)
 {
 	dev->power.status = DPM_ON;
-	pm_runtime_init(dev);
 }
 
 /**
@@ -116,7 +115,6 @@ void device_pm_remove(struct device *dev
 	mutex_lock(&dpm_list_mtx);
 	list_del_init(&dev->power.entry);
 	mutex_unlock(&dpm_list_mtx);
-	pm_runtime_remove(dev);
 }
 
 /**
