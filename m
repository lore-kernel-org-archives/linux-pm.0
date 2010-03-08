From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] Driver core: don't initialize wakeup flags
Date: Mon, 8 Mar 2010 16:46:19 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003081645100.1297-100000__13497.1865489662$1268084934$gmane$org@iolanthe.rowland.org>
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
To: Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1351) removes an unnecessary and unwanted assignment
from device_initialize().  The wakeup flags are set to 0 along with
everything else when the device structure is allocated, so we don't
need to do it again.  Furthermore, the subsystem might already have
set these flags to their correct values; we don't want to override it.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/base/core.c
===================================================================
--- usb-2.6.orig/drivers/base/core.c
+++ usb-2.6/drivers/base/core.c
@@ -561,7 +561,6 @@ void device_initialize(struct device *de
 	mutex_init(&dev->mutex);
 	spin_lock_init(&dev->devres_lock);
 	INIT_LIST_HEAD(&dev->devres_head);
-	device_init_wakeup(dev, 0);
 	device_pm_init(dev);
 	set_dev_node(dev, -1);
 }
