From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 3/4] dmaengine: pl330: Store pointer to slave device
Date: Mon, 09 Jan 2017 15:03:17 +0100
Message-ID: <1483970598-6191-4-git-send-email-m.szyprowski@samsung.com>
References: <1483970598-6191-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170109140326eucas1p29d3e54da58845589e2adf70db854d996@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1483970598-6191-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Krzysztof Kozlowski <krzk@kernel.org>, Inki Dae <inki.dae@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Store the pointer to slave device, which requested our channel. It will be
later used to implement runtime PM of PL330 DMA controller. Although
DMA channels might be requested many times, each DMA peripheral channel is
physically dedicated only for specific hardware, so there should be only
one slave device for each channel.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/dma/pl330.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 3c80e71271a2..9c72f535739c 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -450,6 +450,7 @@ struct dma_pl330_chan {
 
 	/* for runtime pm tracking */
 	bool active;
+	struct device *slave;
 };
 
 struct pl330_dmac {
@@ -2113,6 +2114,14 @@ static struct dma_chan *of_dma_pl330_xlate(struct of_phandle_args *dma_spec,
 	if (chan_id >= pl330->num_peripherals)
 		return NULL;
 
+	if (!pl330->peripherals[chan_id].slave)
+		pl330->peripherals[chan_id].slave = slave;
+	else if (pl330->peripherals[chan_id].slave != slave) {
+		dev_err(pl330->ddma.dev,
+			"Can't use same channel with multiple slave devices!\n");
+		return NULL;
+	}
+
 	return dma_get_slave_channel(&pl330->peripherals[chan_id].chan);
 }
 
-- 
1.9.1
