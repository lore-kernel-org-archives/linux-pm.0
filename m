From: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC workqueue/driver-core PATCH 5/5] nvdimm: Schedule device
 registration on node local to the device
Date: Wed, 26 Sep 2018 14:52:01 -0700
Message-ID: <20180926215201.13512.55945.stgit@localhost.localdomain>
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20180926214433.13512.30289.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This patch is meant to force the device registration for nvdimm devices to
be closer to the actual device. This is achieved by using either the NUMA
node ID of the region, or of the parent. By doing this we can have
everything above the region based on the region, and everything below the
region based on the nvdimm bus.

By guaranteeing NUMA locality I see an improvement of as high as 25% for
per-node init of a system with 12TB of persistent memory.

Signed-off-by: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/nvdimm/bus.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 96154670bf07..f663d6ff524e 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -23,6 +23,7 @@
 #include <linux/ndctl.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/cpu.h>
 #include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/mm.h>
@@ -513,11 +514,15 @@ void __nd_device_register(struct device *dev)
 		set_dev_node(dev, to_nd_region(dev)->numa_node);
 
 	dev->bus = &nvdimm_bus_type;
-	if (dev->parent)
+	if (dev->parent) {
 		get_device(dev->parent);
+		if (dev_to_node(dev) == NUMA_NO_NODE)
+			set_dev_node(dev, dev_to_node(dev->parent));
+	}
 	get_device(dev);
-	async_schedule_domain(nd_async_device_register, dev,
-			&nd_async_domain);
+
+	async_schedule_dev_domain(nd_async_device_register, dev,
+				  &nd_async_domain);
 }
 
 void nd_device_register(struct device *dev)
