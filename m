From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [driver-core PATCH v6 7/9] driver core: Attach devices on CPU local
 to device node
Date: Thu, 08 Nov 2018 10:07:16 -0800
Message-ID: <154170043632.12967.5339750954964165831.stgit@ahduyck-desk1.jf.intel.com>
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

Call the asynchronous probe routines on a CPU local to the device node. By
doing this we should be able to improve our initialization time
significantly as we can avoid having to access the device from a remote
node which may introduce higher latency.

For example, in the case of initializing memory for NVDIMM this can have a
significant impact as initialing 3TB on remote node can take up to 39
seconds while initialing it on a local node only takes 23 seconds. It is
situations like this where we will see the biggest improvement.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/dd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f4e84d639c69..1660eeb1fc9d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -834,7 +834,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			dev_dbg(dev, "scheduling asynchronous probe\n");
 			get_device(dev);
 			dev->async_probe = true;
-			async_schedule(__device_attach_async_helper, dev);
+			async_schedule_dev(__device_attach_async_helper, dev);
 		} else {
 			pm_request_idle(dev);
 		}
@@ -1008,7 +1008,7 @@ static int __driver_attach(struct device *dev, void *data)
 		if (!dev->driver) {
 			get_device(dev);
 			dev_set_drv_async(dev, drv);
-			async_schedule(__driver_attach_async_helper, dev);
+			async_schedule_dev(__driver_attach_async_helper, dev);
 		}
 		device_unlock(dev);
 		return 0;
