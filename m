From: Pavel Machek <pavel@ucw.cz>
Subject: s2ram: warn when interrupts should be disabled but are not
Date: Sat, 12 Apr 2008 11:53:11 +0200
Message-ID: <20080412095311.GA1729@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761324AbYDLJwj@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org


sysdevs should be suspended/resumed with IRQs disabled; if something
reenables them by mistake, we want to know early.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit fc3bccaf69e6c05464e7154369639bd5c96ccdc1
tree bf960093ddb840242a00b4ec456ec79472b1c2ad
parent 308e9d5309f378209e931f63f729806ec0a4d9f1
author Pavel <pavel@amd.ucw.cz> Sat, 12 Apr 2008 11:52:05 +0200
committer Pavel <pavel@amd.ucw.cz> Sat, 12 Apr 2008 11:52:05 +0200

 drivers/ata/ahci.c |    2 +-
 drivers/base/sys.c |    3 +++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/base/sys.c b/drivers/base/sys.c
index 8e13fd9..e214467 100644
--- a/drivers/base/sys.c
+++ b/drivers/base/sys.c
@@ -22,6 +22,7 @@ #include <linux/string.h>
 #include <linux/pm.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
+#include <linux/hardirq.h>
 
 #include "base.h"
 
@@ -367,6 +368,7 @@ int sysdev_suspend(pm_message_t state)
 			/* Call auxillary drivers first */
 			list_for_each_entry(drv, &cls->drivers, entry) {
 				if (drv->suspend) {
+					WARN_ON(!irqs_disabled());
 					ret = drv->suspend(sysdev, state);
 					if (ret)
 						goto aux_driver;
@@ -442,6 +444,7 @@ int sysdev_resume(void)
 		list_for_each_entry(sysdev, &cls->kset.list, kobj.entry) {
 			pr_debug(" %s\n", kobject_name(&sysdev->kobj));
 
+			WARN_ON(!irqs_disabled());
 			__sysdev_resume(sysdev);
 		}
 	}

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
