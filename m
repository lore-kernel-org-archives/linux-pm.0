From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v13 04/12] usb: chipidea: use bus->sysdev for DMA configuration
Date: Sat, 11 Feb 2017 09:27:15 +0800
Message-ID: <1486776443-2280-5-git-send-email-peter.chen@nxp.com>
References: <1486776443-2280-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1486776443-2280-1-git-send-email-peter.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, rjw@rjwysocki.net, dbaryshkov@gmail.com
Cc: mark.rutland@arm.com, heiko@sntech.de, stephen.boyd@linaro.org, frank.li@nxp.com, gary.bisson@boundarydevices.com, Sriram Dash <sriram.dash@nxp.com>, festevam@gmail.com, stillcompiling@gmail.com, arnd@arndb.de, vaibhav.hiremath@linaro.org, krzk@kernel.org, mka@chromium.org, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, Mathias Nyman <mathias.nyman@linux.intel.com>, linux-arm-kernel@lists.infradead.org, hverkuil@xs4all.nl, oscar@naiandei.net, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de, jun.li@nxp.com
List-Id: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Set the dma for chipidea from sysdev. This is inherited from its
parent node. Also, do not set dma mask for child as it is not required
now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Acked-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/chipidea/core.c |  3 ---
 drivers/usb/chipidea/host.c |  3 ++-
 drivers/usb/chipidea/udc.c  | 10 ++++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 79ad8e9..b4a78b2 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -783,9 +783,6 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	}
 
 	pdev->dev.parent = dev;
-	pdev->dev.dma_mask = dev->dma_mask;
-	pdev->dev.dma_parms = dev->dma_parms;
-	dma_set_coherent_mask(&pdev->dev, dev->coherent_dma_mask);
 
 	ret = platform_device_add_resources(pdev, res, nres);
 	if (ret)
diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
index 915f3e9..18cb8e4 100644
--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -123,7 +123,8 @@ static int host_start(struct ci_hdrc *ci)
 	if (usb_disabled())
 		return -ENODEV;
 
-	hcd = usb_create_hcd(&ci_ehci_hc_driver, ci->dev, dev_name(ci->dev));
+	hcd = __usb_create_hcd(&ci_ehci_hc_driver, ci->dev->parent,
+			       ci->dev, dev_name(ci->dev), NULL);
 	if (!hcd)
 		return -ENOMEM;
 
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index f88e915..1fb5235 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -423,7 +423,8 @@ static int _hardware_enqueue(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
 
 	hwreq->req.status = -EALREADY;
 
-	ret = usb_gadget_map_request(&ci->gadget, &hwreq->req, hwep->dir);
+	ret = usb_gadget_map_request_by_dev(ci->dev->parent,
+					    &hwreq->req, hwep->dir);
 	if (ret)
 		return ret;
 
@@ -603,7 +604,8 @@ static int _hardware_dequeue(struct ci_hw_ep *hwep, struct ci_hw_req *hwreq)
 		list_del_init(&node->td);
 	}
 
-	usb_gadget_unmap_request(&hwep->ci->gadget, &hwreq->req, hwep->dir);
+	usb_gadget_unmap_request_by_dev(hwep->ci->dev->parent,
+					&hwreq->req, hwep->dir);
 
 	hwreq->req.actual += actual;
 
@@ -1899,13 +1901,13 @@ static int udc_start(struct ci_hdrc *ci)
 	INIT_LIST_HEAD(&ci->gadget.ep_list);
 
 	/* alloc resources */
-	ci->qh_pool = dma_pool_create("ci_hw_qh", dev,
+	ci->qh_pool = dma_pool_create("ci_hw_qh", dev->parent,
 				       sizeof(struct ci_hw_qh),
 				       64, CI_HDRC_PAGE_SIZE);
 	if (ci->qh_pool == NULL)
 		return -ENOMEM;
 
-	ci->td_pool = dma_pool_create("ci_hw_td", dev,
+	ci->td_pool = dma_pool_create("ci_hw_td", dev->parent,
 				       sizeof(struct ci_hw_td),
 				       64, CI_HDRC_PAGE_SIZE);
 	if (ci->td_pool == NULL) {
-- 
2.7.4
