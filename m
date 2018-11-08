From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [driver-core PATCH v6 4/9] driver core: Move async_synchronize_full
 call
Date: Thu, 08 Nov 2018 10:07:01 -0800
Message-ID: <154170042103.12967.5841784115552956171.stgit@ahduyck-desk1.jf.intel.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linux-nvdimm@lists.01.org, tj@kernel.org, akpm@linux-foundation.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com, bvanassche@acm.org, alexander.h.duyck@linux.intel.com
List-Id: linux-pm@vger.kernel.org

Move the async_synchronize_full call out of __device_release_driver and
into driver_detach.

The idea behind this is that the async_synchronize_full call will only
guarantee that any existing async operations are flushed. This doesn't do
anything to guarantee that a hotplug event that may occur while we are
doing the release of the driver will not be asynchronously scheduled.

By moving this into the driver_detach path we can avoid potential deadlocks
as we aren't holding the device lock at this point and we should not have
the driver we want to flush loaded so the flush will take care of any
asynchronous events the driver we are detaching might have scheduled.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/dd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 76c40fe69463..e74cefeb5b69 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -975,9 +975,6 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 	drv = dev->driver;
 	if (drv) {
-		if (driver_allows_async_probing(drv))
-			async_synchronize_full();
-
 		while (device_links_busy(dev)) {
 			__device_driver_unlock(dev, parent);
 
@@ -1087,6 +1084,9 @@ void driver_detach(struct device_driver *drv)
 	struct device_private *dev_prv;
 	struct device *dev;
 
+	if (driver_allows_async_probing(drv))
+		async_synchronize_full();
+
 	for (;;) {
 		spin_lock(&drv->p->klist_devices.k_lock);
 		if (list_empty(&drv->p->klist_devices.k_list)) {
