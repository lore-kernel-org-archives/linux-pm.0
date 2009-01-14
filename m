From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] resume: wait for device probing to finish
Date: Thu, 15 Jan 2009 00:39:58 +0100
Message-ID: <200901150039.58972.rjw__4131.39626984975$1231976764$gmane$org@sisk.pl>
References: <200901142303.46166.rjw@sisk.pl>
	<20090114152444.64e1ddfb.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090114152444.64e1ddfb.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: pavel@suse.cz, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 15 January 2009, Andrew Morton wrote:
> On Wed, 14 Jan 2009 23:03:45 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > +		wait_for_device_probe();
> 
> I don't have this function?

Ah, the other patch is also necessary, appended.  Sorry.

[Note to self: don't send patches when you are tired.  No, really.  Don't.]

---
From: Arjan van de Ven <arjan@linux.intel.com>
Subject: [PATCH] consolidate driver_probe_done() loops into one place

there's a few places that currently loop over driver_probe_done(), and
I'm about to add another one. This patch abstracts it into a helper
to reduce duplication.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/dd.c      |   16 ++++++++++++++++
 include/linux/device.h |    2 ++
 init/do_mounts.c       |   13 +++++++++----
 init/do_mounts_md.c    |    5 +++--
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 315bed8..b911fab 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/wait.h>
+#include <linux/async.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -168,6 +169,21 @@ int driver_probe_done(void)
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
diff --git a/include/linux/device.h b/include/linux/device.h
index 45e5b19..47f343c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -147,6 +147,8 @@ extern void put_driver(struct device_driver *drv);
 extern struct device_driver *driver_find(const char *name,
 					 struct bus_type *bus);
 extern int driver_probe_done(void);
+extern int wait_for_device_probe(void);
+
 
 /* sysfs interface for exporting driver attributes */
 
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 708105e..2c80113 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
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
diff --git a/init/do_mounts_md.c b/init/do_mounts_md.c
index ff95e31..9bdddbc 100644
--- a/init/do_mounts_md.c
+++ b/init/do_mounts_md.c
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
-- 
