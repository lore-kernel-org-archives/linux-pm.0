From: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 8/9] bus: brcmstb_gisb: Honor the "big-endian" and "native-endian" DT properties
Date: Tue, 25 Nov 2014 16:49:53 -0800
Message-ID: <1416962994-27095-9-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marc.ceeeee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On chips strapped for BE, we'll need to use ioread32be/iowrite32be instead of
ioread32/iowrite32.

Signed-off-by: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/bus/brcmstb_gisb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 172908d..969b992 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -90,6 +90,7 @@ static const int gisb_offsets_bcm7445[] = {
 struct brcmstb_gisb_arb_device {
 	void __iomem	*base;
 	const int	*gisb_offsets;
+	bool		big_endian;
 	struct mutex	lock;
 	struct list_head next;
 	u32 valid_mask;
@@ -106,7 +107,10 @@ static u32 gisb_read(struct brcmstb_gisb_arb_device *gdev, int reg)
 	if (offset == -1)
 		return 1;
 
-	return ioread32(gdev->base + offset);
+	if (gdev->big_endian)
+		return ioread32be(gdev->base + offset);
+	else
+		return ioread32(gdev->base + offset);
 }
 
 static void gisb_write(struct brcmstb_gisb_arb_device *gdev, u32 val, int reg)
@@ -115,7 +119,11 @@ static void gisb_write(struct brcmstb_gisb_arb_device *gdev, u32 val, int reg)
 
 	if (offset == -1)
 		return;
-	iowrite32(val, gdev->base + reg);
+
+	if (gdev->big_endian)
+		iowrite32be(val, gdev->base + reg);
+	else
+		iowrite32(val, gdev->base + reg);
 }
 
 static ssize_t gisb_arb_get_timeout(struct device *dev,
@@ -300,6 +308,7 @@ static int brcmstb_gisb_arb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	gdev->gisb_offsets = of_id->data;
+	gdev->big_endian = of_device_is_big_endian(dn);
 
 	err = devm_request_irq(&pdev->dev, timeout_irq,
 				brcmstb_gisb_timeout_handler, 0, pdev->name,
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
