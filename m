From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [driver-core PATCH v4 5/6] driver core: Attach devices on CPU local
 to device node
Date: Mon, 15 Oct 2018 08:09:32 -0700
Message-ID: <20181015150932.29520.2252.stgit@localhost.localdomain>
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015150305.29520.86363.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org, tj@kernel.org, akpm@linux-foundation.org, alexander.h.duyck@linux.intel.com
List-Id: linux-pm@vger.kernel.org

This change makes it so that we call the asynchronous probe routines on a
CPU local to the device node. By doing this we should be able to improve
our initialization time significantly as we can avoid having to access the
device from a remote node which may introduce higher latency.

For example, in the case of initializing memory for NVDIMM this can have a
singifcant impact as initialing 3TB on remote node can take up to 39
seconds while initialing it on a local node only takes 23 seconds. It is
situations like this where we will see the biggest improvement.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/dd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index c33f893ec9d8..65cfdd2b00ed 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -827,7 +827,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			 */
 			dev_dbg(dev, "scheduling asynchronous probe\n");
 			get_device(dev);
-			async_schedule(__device_attach_async_helper, dev);
+			async_schedule_dev(__device_attach_async_helper, dev);
 		} else {
 			pm_request_idle(dev);
 		}
@@ -984,7 +984,7 @@ static int __driver_attach(struct device *dev, void *data)
 		if (!dev->driver) {
 			get_device(dev);
 			dev_set_drvdata(dev, drv);
-			async_schedule(__driver_attach_async_helper, dev);
+			async_schedule_dev(__driver_attach_async_helper, dev);
 		}
 		device_unlock(dev);
 		return 0;
