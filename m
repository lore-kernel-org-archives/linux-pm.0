From: "Zhang, LongX" <longx.zhang@intel.com>
Subject: Subject: [PATCH] drivers-core: move device_pm_remove behind
 bus_remove_device
Date: Fri, 21 Sep 2012 01:58:51 +0000
Message-ID: <F7B8FD780A346D46A0042F5C63B06AE775B2B0@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: LongX Zhang <longx.zhang@intel.com>

device_pm_remove will call pm_runtime_remove which would disable
runtime PM of the device. After that pm_runtime_get* or
pm_runtime_put* will be ingored. So if we disable the runtime PM
before device really be removed, drivers' _remove callback may
access HW even pm_runtime_get* fails. That is bad.

Signed-off-by: LongX Zhang <longx.zhang@intel.com>
---
 drivers/base/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5e6e00b..81ea7f2 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1169,7 +1169,6 @@ void device_del(struct device *dev)
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DEL_DEVICE, dev);
-	device_pm_remove(dev);
 	dpm_sysfs_remove(dev);
 	if (parent)
 		klist_del(&dev->p->knode_parent);
@@ -1194,6 +1193,7 @@ void device_del(struct device *dev)
 	device_remove_file(dev, &uevent_attr);
 	device_remove_attrs(dev);
 	bus_remove_device(dev);
+	device_pm_remove(dev);
 	driver_deferred_probe_del(dev);
 
 	/*
-- 
1.7.10
