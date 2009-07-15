From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 5/8] introduce device async resume
Date: Wed, 15 Jul 2009 15:38:39 +0800
Message-ID: <1247643519.26272.80.camel__11288.1506364376$1247643814$gmane$org@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>
Cc: Pavel Machek <pavel@suse.cz>, "Van De Ven,
	Arjan" <arjan.van.de.ven@intel.com>
List-Id: linux-pm@vger.kernel.org


introduce device async resume.

If boot option "dev_async_action" is added,
devices can be resumed asynhronously.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/base/power/main.c |    4 +++-
 include/linux/async_dev.h |    4 +++-
 drivers/base/async_dev.c        |    1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -445,7 +445,8 @@ static void dpm_resume(pm_message_t stat
 			dev->power.status = DPM_RESUMING;
 			mutex_unlock(&dpm_list_mtx);
 
-			error = device_resume(dev, state);
+			error = dev_async_schedule(dev, device_resume, &state,
+							DEV_ASYNC_RESUME);
 
 			mutex_lock(&dpm_list_mtx);
 			if (error)
@@ -460,6 +461,7 @@ static void dpm_resume(pm_message_t stat
 	}
 	list_splice(&list, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
+	dev_async_synchronization();
 }
 
 /**
Index: linux-2.6/include/linux/async_dev.h
===================================================================
--- linux-2.6.orig/include/linux/async_dev.h
+++ linux-2.6/include/linux/async_dev.h
@@ -29,7 +29,9 @@ struct dev_async_struct {
 };
 
 #define DEV_ASYNC_SUSPEND	1
-#define DEV_ASYNC_ACTIONS_ALL	DEV_ASYNC_SUSPEND
+#define DEV_ASYNC_RESUME	2
+#define DEV_ASYNC_ACTIONS_ALL	(DEV_ASYNC_SUSPEND |	\
+				DEV_ASYNC_RESUME)
 
 extern int dev_async_schedule(struct device *, void *,
 			void *, int);
Index: linux-2.6/drivers/base/async_dev.c
===================================================================
--- linux-2.6.orig/drivers/base/async_dev.c
+++ linux-2.6/drivers/base/async_dev.c
@@ -36,6 +36,7 @@ static int dev_action(struct device *dev
 
 	switch (type) {
 	case DEV_ASYNC_SUSPEND:
+	case DEV_ASYNC_RESUME:
 		error = ((dev_async_suspend)func)(dev, *((pm_message_t *)data));
 		break;
 	default:
