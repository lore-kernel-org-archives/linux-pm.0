From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH v13 07/12] usb: ehci: use bus->sysdev for DMA configuration
Date: Sat, 11 Feb 2017 09:27:18 +0800
Message-ID: <1486776443-2280-8-git-send-email-peter.chen@nxp.com>
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
Cc: mark.rutland@arm.com, Peter Chen <peter.chen@nxp.com>, heiko@sntech.de, stephen.boyd@linaro.org, frank.li@nxp.com, gary.bisson@boundarydevices.com, Sriram Dash <sriram.dash@nxp.com>, festevam@gmail.com, stillcompiling@gmail.com, arnd@arndb.de, vaibhav.hiremath@linaro.org, krzk@kernel.org, mka@chromium.org, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, linux-arm-kernel@lists.infradead.org, hverkuil@xs4all.nl, oscar@naiandei.net, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de, jun.li@nxp.com
List-Id: linux-pm@vger.kernel.org

Set the dma for ehci from sysdev. The sysdev is pointing to device that
is known to the system firmware or hardware.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-mem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
index 4de4301..9b7e639 100644
--- a/drivers/usb/host/ehci-mem.c
+++ b/drivers/usb/host/ehci-mem.c
@@ -138,7 +138,7 @@ static void ehci_mem_cleanup (struct ehci_hcd *ehci)
 	ehci->sitd_pool = NULL;
 
 	if (ehci->periodic)
-		dma_free_coherent (ehci_to_hcd(ehci)->self.controller,
+		dma_free_coherent(ehci_to_hcd(ehci)->self.sysdev,
 			ehci->periodic_size * sizeof (u32),
 			ehci->periodic, ehci->periodic_dma);
 	ehci->periodic = NULL;
@@ -155,7 +155,7 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 
 	/* QTDs for control/bulk/intr transfers */
 	ehci->qtd_pool = dma_pool_create ("ehci_qtd",
-			ehci_to_hcd(ehci)->self.controller,
+			ehci_to_hcd(ehci)->self.sysdev,
 			sizeof (struct ehci_qtd),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
@@ -165,7 +165,7 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 
 	/* QHs for control/bulk/intr transfers */
 	ehci->qh_pool = dma_pool_create ("ehci_qh",
-			ehci_to_hcd(ehci)->self.controller,
+			ehci_to_hcd(ehci)->self.sysdev,
 			sizeof(struct ehci_qh_hw),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
@@ -179,7 +179,7 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 
 	/* ITD for high speed ISO transfers */
 	ehci->itd_pool = dma_pool_create ("ehci_itd",
-			ehci_to_hcd(ehci)->self.controller,
+			ehci_to_hcd(ehci)->self.sysdev,
 			sizeof (struct ehci_itd),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
@@ -189,7 +189,7 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 
 	/* SITD for full/low speed split ISO transfers */
 	ehci->sitd_pool = dma_pool_create ("ehci_sitd",
-			ehci_to_hcd(ehci)->self.controller,
+			ehci_to_hcd(ehci)->self.sysdev,
 			sizeof (struct ehci_sitd),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
@@ -199,7 +199,7 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 
 	/* Hardware periodic table */
 	ehci->periodic = (__le32 *)
-		dma_alloc_coherent (ehci_to_hcd(ehci)->self.controller,
+		dma_alloc_coherent(ehci_to_hcd(ehci)->self.sysdev,
 			ehci->periodic_size * sizeof(__le32),
 			&ehci->periodic_dma, flags);
 	if (ehci->periodic == NULL) {
-- 
2.7.4
