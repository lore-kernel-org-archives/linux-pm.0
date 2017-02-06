From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v12 5/9] usb: ehci: fsl: use bus->sysdev for DMA configuration
Date: Mon, 6 Feb 2017 17:13:37 +0800
Message-ID: <1486372421-29073-6-git-send-email-peter.chen@nxp.com>
References: <1486372421-29073-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1486372421-29073-1-git-send-email-peter.chen@nxp.com>
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
Cc: mark.rutland@arm.com, heiko@sntech.de, stephen.boyd@linaro.org, gary.bisson@boundarydevices.com, Sriram Dash <sriram.dash@nxp.com>, festevam@gmail.com, stillcompiling@gmail.com, arnd@arndb.de, vaibhav.hiremath@linaro.org, krzk@kernel.org, mka@chromium.org, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, Mathias Nyman <mathias.nyman@linux.intel.com>, linux-arm-kernel@lists.infradead.org, hverkuil@xs4all.nl, oscar@naiandei.net, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

For the dual role ehci fsl driver, sysdev will handle the dma
config.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/ehci-fsl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 3733aab..4a08b70 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -96,8 +96,8 @@ static int fsl_ehci_drv_probe(struct platform_device *pdev)
 	}
 	irq = res->start;
 
-	hcd = usb_create_hcd(&fsl_ehci_hc_driver, &pdev->dev,
-				dev_name(&pdev->dev));
+	hcd = __usb_create_hcd(&fsl_ehci_hc_driver, pdev->dev.parent,
+			       &pdev->dev, dev_name(&pdev->dev), NULL);
 	if (!hcd) {
 		retval = -ENOMEM;
 		goto err1;
-- 
2.7.4
