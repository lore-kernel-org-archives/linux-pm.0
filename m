From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v8 1/3] dmaengine: Add new device_{set,
 release}_slave callbacks
Date: Thu, 09 Feb 2017 15:22:49 +0100
Message-ID: <1486650171-20598-2-git-send-email-m.szyprowski@samsung.com>
References: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170209142307eucas1p180323d005f524760913b8d04ac966423@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1486650171-20598-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Add two new callbacks to DMA engine device. They will used to provide
access to slave device (the device which requested given DMA channel)
for DMA engine driver. Access to slave device might be useful for example
for implementing advanced runtime power management.

DMA slave channels are exclusive, so only one slave device can be set
for a given DMA slave channel.

device_set_slave() will be called after the device_alloc_chan_resources()
and device_release_slave() before the device_free_chan_resources().

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/dma/dmaengine.c   | 27 ++++++++++++++++++++++++---
 include/linux/dmaengine.h | 10 ++++++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 24e0221fd66d..5b7089d8be4d 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -705,6 +705,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 {
 	struct dma_device *d, *_d;
 	struct dma_chan *chan = NULL;
+	int ret;
 
 	/* If device-tree is present get slave info from here */
 	if (dev->of_node)
@@ -715,8 +716,9 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 		chan = acpi_dma_request_slave_chan_by_name(dev, name);
 
 	if (chan) {
-		/* Valid channel found or requester need to be deferred */
-		if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
+		if (!IS_ERR(chan))
+			goto found;
+		if (PTR_ERR(chan) == -EPROBE_DEFER)
 			return chan;
 	}
 
@@ -738,7 +740,21 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 	}
 	mutex_unlock(&dma_list_mutex);
 
-	return chan ? chan : ERR_PTR(-EPROBE_DEFER);
+	if (!chan)
+		return ERR_PTR(-EPROBE_DEFER);
+	if (IS_ERR(chan))
+		return chan;
+found:
+	if (chan->device->device_set_slave) {
+		chan->slave = dev;
+		ret = chan->device->device_set_slave(chan, dev);
+		if (ret) {
+			chan->slave = NULL;
+			dma_release_channel(chan);
+			chan = ERR_PTR(ret);
+		}
+	}
+	return chan;
 }
 EXPORT_SYMBOL_GPL(dma_request_chan);
 
@@ -786,6 +802,11 @@ void dma_release_channel(struct dma_chan *chan)
 	mutex_lock(&dma_list_mutex);
 	WARN_ONCE(chan->client_count != 1,
 		  "chan reference count %d != 1\n", chan->client_count);
+	if (chan->slave) {
+		if (chan->device->device_release_slave)
+			chan->device->device_release_slave(chan);
+		chan->slave = NULL;
+	}
 	dma_chan_put(chan);
 	/* drop PRIVATE cap enabled by __dma_request_channel() */
 	if (--chan->device->privatecnt == 0)
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 533680860865..d22299e37e69 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -277,6 +277,9 @@ struct dma_chan {
 	struct dma_router *router;
 	void *route_data;
 
+	/* Only for SLAVE channels */
+	struct device *slave;
+
 	void *private;
 };
 
@@ -686,6 +689,10 @@ struct dma_filter {
  * @device_alloc_chan_resources: allocate resources and return the
  *	number of allocated descriptors
  * @device_free_chan_resources: release DMA channel's resources
+ * @device_set_slave: provide access to the slave device, which requested
+ *	given DMA channel, called after @device_alloc_chan_resources
+ * @device_release_slave: finishes access to the slave device, called
+ *	before @device_free_chan_resources
  * @device_prep_dma_memcpy: prepares a memcpy operation
  * @device_prep_dma_xor: prepares a xor operation
  * @device_prep_dma_xor_val: prepares a xor validation operation
@@ -746,6 +753,9 @@ struct dma_device {
 	int (*device_alloc_chan_resources)(struct dma_chan *chan);
 	void (*device_free_chan_resources)(struct dma_chan *chan);
 
+	int (*device_set_slave)(struct dma_chan *chan, struct device *slave);
+	void (*device_release_slave)(struct dma_chan *chan);
+
 	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy)(
 		struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
 		size_t len, unsigned long flags);
-- 
1.9.1
