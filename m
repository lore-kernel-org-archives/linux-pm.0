From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/9] Consolidate driver_probe_done() loops into
	one place
Date: Sat, 14 Feb 2009 01:59:06 +0100
Message-ID: <200902140159.08252.rjw@sisk.pl>
References: <200902140157.40869.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902140157.40869.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>

there's a few places that currently loop over driver_probe_done(), and
I'm about to add another one. This patch abstracts it into a helper
to reduce duplication.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/dd.c      |   17 +++++++++++++++++
 include/linux/device.h |    2 ++
 init/do_mounts.c       |   13 +++++++++----
 init/do_mounts_md.c    |    5 +++--
 4 files changed, 31 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/base/dd.c
===================================================================
--- linux-2.6.orig/drivers/base/dd.c
+++ linux-2.6/drivers/base/dd.c
@@ -18,9 +18,11 @@
  */
 
 #include <linux/device.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/wait.h>
+#include <linux/async.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -168,6 +170,21 @@ int driver_probe_done(void)
 }
 
 /**
+ * wait_for_device_probe
+ * Wait for device probing to be completed.
+ *
+ * Note: this function polls at 100 msec intervals.
+ */
+int wait_for_device_probe(void)
+{
+	/* wait for the known devices to complete their probing */
+	while (driver_probe_done() != 0)
+		msleep(100);
+	async_synchronize_full();
+	return 0;
+}
+
+/**
  * driver_probe_device - attempt to bind device & driver together
  * @drv: driver to bind a device to
  * @dev: device to try to bind to the driver
Index: linux-2.6/include/linux/device.h
===================================================================
--- linux-2.6.orig/include/linux/device.h
+++ linux-2.6/include/linux/device.h
@@ -147,6 +147,8 @@ extern void put_driver(struct device_dri
 extern struct device_driver *driver_find(const char *name,
 					 struct bus_type *bus);
 extern int driver_probe_done(void);
+extern int wait_for_device_probe(void);
+
 
 /* sysfs interface for exporting driver attributes */
 
Index: linux-2.6/init/do_mounts.c
===================================================================
--- linux-2.6.orig/init/do_mounts.c
+++ linux-2.6/init/do_mounts.c
@@ -370,10 +370,14 @@ void __init prepare_namespace(void)
 		ssleep(root_delay);
 	}
 
-	/* wait for the known devices to complete their probing */
-	while (driver_probe_done() != 0)
-		msleep(100);
-	async_synchronize_full();
+	/*
+	 * wait for the known devices to complete their probing
+	 *
+	 * Note: this is a potential source of long boot delays.
+	 * For example, it is not atypical to wait 5 seconds here
+	 * for the touchpad of a laptop to initialize.
+	 */
+	wait_for_device_probe();
 
 	md_run_setup();
 
@@ -399,6 +403,7 @@ void __init prepare_namespace(void)
 		while (driver_probe_done() != 0 ||
 			(ROOT_DEV = name_to_dev_t(saved_root_name)) == 0)
 			msleep(100);
+		async_synchronize_full();
 	}
 
 	is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
Index: linux-2.6/init/do_mounts_md.c
===================================================================
--- linux-2.6.orig/init/do_mounts_md.c
+++ linux-2.6/init/do_mounts_md.c
@@ -281,8 +281,9 @@ static void __init autodetect_raid(void)
 	 */
 	printk(KERN_INFO "md: Waiting for all devices to be available before autodetect\n");
 	printk(KERN_INFO "md: If you don't use raid, use raid=noautodetect\n");
-	while (driver_probe_done() < 0)
-		msleep(100);
+
+	wait_for_device_probe();
+
 	fd = sys_open("/dev/md0", 0, 0);
 	if (fd >= 0) {
 		sys_ioctl(fd, RAID_AUTORUN, raid_autopart);
