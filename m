From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/7] Suspend: Use common prefix in messages
Date: Wed, 28 Nov 2007 01:30:24 +0100
Message-ID: <200711280130.25369.rjw@sisk.pl>
References: <200711280113.36941.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711280113.36941.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make suspend messages start with one common prefix "PM: ".

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -227,7 +227,7 @@ static int suspend_enter(suspend_state_t
 	BUG_ON(!irqs_disabled());
 
 	if ((error = device_power_down(PMSG_SUSPEND))) {
-		printk(KERN_ERR "Some devices failed to power down\n");
+		printk(KERN_ERR "PM: Some devices failed to power down\n");
 		goto Done;
 	}
 
@@ -261,7 +261,7 @@ int suspend_devices_and_enter(suspend_st
 	suspend_console();
 	error = device_suspend(PMSG_SUSPEND);
 	if (error) {
-		printk(KERN_ERR "Some devices failed to suspend\n");
+		printk(KERN_ERR "PM: Some devices failed to suspend\n");
 		goto Resume_console;
 	}
 
@@ -344,7 +344,7 @@ static int enter_state(suspend_state_t s
 	if (!mutex_trylock(&pm_mutex))
 		return -EBUSY;
 
-	printk("Syncing filesystems ... ");
+	printk(KERN_INFO "PM: Syncing filesystems ... ");
 	sys_sync();
 	printk("done.\n");
 
