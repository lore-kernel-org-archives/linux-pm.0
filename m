From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM / Wakeup: Fix initialization of
	wakeup-related device sysfs files
Date: Thu, 21 Apr 2011 23:57:42 +0200
Message-ID: <201104212357.43052.rjw__39478.6188881428$1303423137$gmane$org@sisk.pl>
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
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Tino Keitel <tino.keitel@tikei.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

It turns out that some PCI devices are only found to be
wakeup-capable during registration, in which case, when
device_set_wakeup_capable() is called, device_is_registered() already
returns 'true' for the given device, but dpm_sysfs_add() hasn't been
called for it yet.  This leads to situations in which the device's
power.can_wakeup flag is not set as requested because of failing
wakeup_sysfs_add() and its wakeup-related sysfs files are not
created, although they should be present.  This is a post-2.6.38
regression introduced by commit cb8f51bdadb7969139c2e39c2defd4cde98c1
(PM: Do not create wakeup sysfs files for devices that cannot wake
up).

To work around this problem initialize the device's power.entry
field to an empty list head and make device_set_wakeup_capable()
check if it is still empty before attempting to add the devices
wakeup-related sysfs files with wakeup_sysfs_add().  Namely, if
power.entry is still empty at this point, device_pm_add() hasn't been
called yet for the device and its wakeup-related files will be
created later, so device_set_wakeup_capable() doesn't have to create
them.

Reported-by: Tino Keitel <tino.keitel@tikei.de>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c   |    1 +
 drivers/base/power/wakeup.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -63,6 +63,7 @@ void device_pm_init(struct device *dev)
 	dev->power.wakeup = NULL;
 	spin_lock_init(&dev->power.lock);
 	pm_runtime_init(dev);
+	INIT_LIST_HEAD(&dev->power.entry);
 }
 
 /**
Index: linux-2.6/drivers/base/power/wakeup.c
===================================================================
--- linux-2.6.orig/drivers/base/power/wakeup.c
+++ linux-2.6/drivers/base/power/wakeup.c
@@ -258,7 +258,7 @@ void device_set_wakeup_capable(struct de
 	if (!!dev->power.can_wakeup == !!capable)
 		return;
 
-	if (device_is_registered(dev)) {
+	if (device_is_registered(dev) && !list_empty(&dev->power.entry)) {
 		if (capable) {
 			if (wakeup_sysfs_add(dev))
 				return;
