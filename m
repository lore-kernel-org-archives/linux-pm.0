From: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v12 7/9] usb: ehci: use bus->sysdev for DMA configuration
Date: Mon, 6 Feb 2017 17:13:39 +0800
Message-ID: <1486372421-29073-8-git-send-email-peter.chen@nxp.com>
References: <1486372421-29073-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486372421-29073-1-git-send-email-peter.chen-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, Sriram Dash <sriram.dash-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Set the dma for ehci from sysdev. The sysdev is pointing to device that
is known to the system firmware or hardware.

Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Sriram Dash <sriram.dash-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
---
 drivers/usb/host/ehci-mem.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
index 4de4301..f54478d 100644
--- a/drivers/usb/host/ehci-mem.c
+++ b/drivers/usb/host/ehci-mem.c
@@ -46,21 +46,21 @@ static inline void ehci_qtd_init(struct ehci_hcd *ehci, struct ehci_qtd *qtd,
 	INIT_LIST_HEAD (&qtd->qtd_list);
 }
 
-static struct ehci_qtd *ehci_qtd_alloc (struct ehci_hcd *ehci, gfp_t flags)
+static struct ehci_qtd *ehci_qtd_alloc(struct ehci_hcd *ehci, gfp_t flags)
 {
 	struct ehci_qtd		*qtd;
 	dma_addr_t		dma;
 
-	qtd = dma_pool_alloc (ehci->qtd_pool, flags, &dma);
+	qtd = dma_pool_alloc(ehci->qtd_pool, flags, &dma);
 	if (qtd != NULL) {
 		ehci_qtd_init(ehci, qtd, dma);
 	}
 	return qtd;
 }
 
-static inline void ehci_qtd_free (struct ehci_hcd *ehci, struct ehci_qtd *qtd)
+static inline void ehci_qtd_free(struct ehci_hcd *ehci, struct ehci_qtd *qtd)
 {
-	dma_pool_free (ehci->qtd_pool, qtd, qtd->qtd_dma);
+	dma_pool_free(ehci->qtd_pool, qtd, qtd->qtd_dma);
 }
 
 
@@ -72,12 +72,12 @@ static void qh_destroy(struct ehci_hcd *ehci, struct ehci_qh *qh)
 		BUG ();
 	}
 	if (qh->dummy)
-		ehci_qtd_free (ehci, qh->dummy);
+		ehci_qtd_free(ehci, qh->dummy);
 	dma_pool_free(ehci->qh_pool, qh->hw, qh->qh_dma);
 	kfree(qh);
 }
 
-static struct ehci_qh *ehci_qh_alloc (struct ehci_hcd *ehci, gfp_t flags)
+static struct ehci_qh *ehci_qh_alloc(struct ehci_hcd *ehci, gfp_t flags)
 {
 	struct ehci_qh		*qh;
 	dma_addr_t		dma;
@@ -96,7 +96,7 @@ static struct ehci_qh *ehci_qh_alloc (struct ehci_hcd *ehci, gfp_t flags)
 	INIT_LIST_HEAD(&qh->unlink_node);
 
 	/* dummy td enables safe urb queuing */
-	qh->dummy = ehci_qtd_alloc (ehci, flags);
+	qh->dummy = ehci_qtd_alloc(ehci, flags);
 	if (qh->dummy == NULL) {
 		ehci_dbg (ehci, "no dummy td\n");
 		goto fail1;
@@ -117,7 +117,7 @@ static struct ehci_qh *ehci_qh_alloc (struct ehci_hcd *ehci, gfp_t flags)
  * This is the initialisation and cleanup code.
  */
 
-static void ehci_mem_cleanup (struct ehci_hcd *ehci)
+static void ehci_mem_cleanup(struct ehci_hcd *ehci)
 {
 	if (ehci->async)
 		qh_destroy(ehci, ehci->async);
@@ -138,7 +138,7 @@ static void ehci_mem_cleanup (struct ehci_hcd *ehci)
 	ehci->sitd_pool = NULL;
 
 	if (ehci->periodic)
-		dma_free_coherent (ehci_to_hcd(ehci)->self.controller,
+		dma_free_coherent(ehci_to_hcd(ehci)->self.sysdev,
 			ehci->periodic_size * sizeof (u32),
 			ehci->periodic, ehci->periodic_dma);
 	ehci->periodic = NULL;
@@ -154,8 +154,8 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 	int i;
 
 	/* QTDs for control/bulk/intr transfers */
-	ehci->qtd_pool = dma_pool_create ("ehci_qtd",
-			ehci_to_hcd(ehci)->self.controller,
+	ehci->qtd_pool = dma_pool_create("ehci_qtd",
+			ehci_to_hcd(ehci)->self.sysdev,
 			sizeof (struct ehci_qtd),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
@@ -164,22 +164,22 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 	}
 
 	/* QHs for control/bulk/intr transfers */
-	ehci->qh_pool = dma_pool_create ("ehci_qh",
-			ehci_to_hcd(ehci)->self.controller,
+	ehci->qh_pool = dma_pool_create("ehci_qh",
+			ehci_to_hcd(ehci)->self.sysdev,
 			sizeof(struct ehci_qh_hw),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
 	if (!ehci->qh_pool) {
 		goto fail;
 	}
-	ehci->async = ehci_qh_alloc (ehci, flags);
+	ehci->async = ehci_qh_alloc(ehci, flags);
 	if (!ehci->async) {
 		goto fail;
 	}
 
 	/* ITD for high speed ISO transfers */
-	ehci->itd_pool = dma_pool_create ("ehci_itd",
-			ehci_to_hcd(ehci)->self.controller,
+	ehci->itd_pool = dma_pool_create("ehci_itd",
+			ehci_to_hcd(ehci)->self.sysdev,
 			sizeof (struct ehci_itd),
 			32 /* byte alignment (for hw parts) */,
 			4096 /* can't cross 4K */);
@@ -188,8 +188,8 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
 	}
 
 	/* SITD for full/low speed split ISO transfers */
-	ehci->sitd_pool = dma_pool_create ("ehci_sitd",
-			ehci_to_hcd(ehci)->self.controller,
+	ehci->sitd_pool = dma_pool_create("ehci_sitd",
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
