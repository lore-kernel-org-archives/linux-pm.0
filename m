From: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/9] bus: brcmstb_gisb: Look up register offsets in a table
Date: Tue, 25 Nov 2014 16:49:51 -0800
Message-ID: <1416962994-27095-7-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marc.ceeeee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

There are at least 4 incompatible variations of this hardware block,
so let's use the ARB_* constants as a table index instead of hardcoding
specific register offsets.  Also, allow for the possibility of adding
old devices that are missing some of the registers.

Signed-off-by: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/bus/brcmstb_gisb.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 8ff403d..ef1e423 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -29,23 +29,37 @@
 #include <asm/signal.h>
 #endif
 
-#define ARB_TIMER			0x008
-#define ARB_ERR_CAP_CLR			0x7e4
 #define  ARB_ERR_CAP_CLEAR		(1 << 0)
-#define ARB_ERR_CAP_HI_ADDR		0x7e8
-#define ARB_ERR_CAP_ADDR		0x7ec
-#define ARB_ERR_CAP_DATA		0x7f0
-#define ARB_ERR_CAP_STATUS		0x7f4
 #define  ARB_ERR_CAP_STATUS_TIMEOUT	(1 << 12)
 #define  ARB_ERR_CAP_STATUS_TEA		(1 << 11)
 #define  ARB_ERR_CAP_STATUS_BS_SHIFT	(1 << 2)
 #define  ARB_ERR_CAP_STATUS_BS_MASK	0x3c
 #define  ARB_ERR_CAP_STATUS_WRITE	(1 << 1)
 #define  ARB_ERR_CAP_STATUS_VALID	(1 << 0)
-#define ARB_ERR_CAP_MASTER		0x7f8
+
+enum {
+	ARB_TIMER,
+	ARB_ERR_CAP_CLR,
+	ARB_ERR_CAP_HI_ADDR,
+	ARB_ERR_CAP_ADDR,
+	ARB_ERR_CAP_DATA,
+	ARB_ERR_CAP_STATUS,
+	ARB_ERR_CAP_MASTER,
+};
+
+static const int gisb_offsets_bcm7445[] = {
+	[ARB_TIMER]		= 0x008,
+	[ARB_ERR_CAP_CLR]	= 0x7e4,
+	[ARB_ERR_CAP_HI_ADDR]	= 0x7e8,
+	[ARB_ERR_CAP_ADDR]	= 0x7ec,
+	[ARB_ERR_CAP_DATA]	= 0x7f0,
+	[ARB_ERR_CAP_STATUS]	= 0x7f4,
+	[ARB_ERR_CAP_MASTER]	= 0x7f8,
+};
 
 struct brcmstb_gisb_arb_device {
 	void __iomem	*base;
+	const int	*gisb_offsets;
 	struct mutex	lock;
 	struct list_head next;
 	u32 valid_mask;
@@ -56,11 +70,21 @@ static LIST_HEAD(brcmstb_gisb_arb_device_list);
 
 static u32 gisb_read(struct brcmstb_gisb_arb_device *gdev, int reg)
 {
-	return ioread32(gdev->base + reg);
+	int offset = gdev->gisb_offsets[reg];
+
+	/* return 1 if the hardware doesn't have ARB_ERR_CAP_MASTER */
+	if (offset == -1)
+		return 1;
+
+	return ioread32(gdev->base + offset);
 }
 
 static void gisb_write(struct brcmstb_gisb_arb_device *gdev, u32 val, int reg)
 {
+	int offset = gdev->gisb_offsets[reg];
+
+	if (offset == -1)
+		return;
 	iowrite32(val, gdev->base + reg);
 }
 
@@ -230,6 +254,8 @@ static int brcmstb_gisb_arb_probe(struct platform_device *pdev)
 	if (IS_ERR(gdev->base))
 		return PTR_ERR(gdev->base);
 
+	gdev->gisb_offsets = gisb_offsets_bcm7445;
+
 	err = devm_request_irq(&pdev->dev, timeout_irq,
 				brcmstb_gisb_timeout_handler, 0, pdev->name,
 				gdev);
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
