From: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/9] bus: brcmstb_gisb: Introduce wrapper functions for MMIO accesses
Date: Tue, 25 Nov 2014 16:49:50 -0800
Message-ID: <1416962994-27095-6-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, marc.ceeeee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

These will be used to abstract out chip-to-chip differences.

Signed-off-by: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/bus/brcmstb_gisb.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 5da935a..8ff403d 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -54,6 +54,16 @@ struct brcmstb_gisb_arb_device {
 
 static LIST_HEAD(brcmstb_gisb_arb_device_list);
 
+static u32 gisb_read(struct brcmstb_gisb_arb_device *gdev, int reg)
+{
+	return ioread32(gdev->base + reg);
+}
+
+static void gisb_write(struct brcmstb_gisb_arb_device *gdev, u32 val, int reg)
+{
+	iowrite32(val, gdev->base + reg);
+}
+
 static ssize_t gisb_arb_get_timeout(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -63,7 +73,7 @@ static ssize_t gisb_arb_get_timeout(struct device *dev,
 	u32 timeout;
 
 	mutex_lock(&gdev->lock);
-	timeout = ioread32(gdev->base + ARB_TIMER);
+	timeout = gisb_read(gdev, ARB_TIMER);
 	mutex_unlock(&gdev->lock);
 
 	return sprintf(buf, "%d", timeout);
@@ -85,7 +95,7 @@ static ssize_t gisb_arb_set_timeout(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&gdev->lock);
-	iowrite32(val, gdev->base + ARB_TIMER);
+	gisb_write(gdev, val, ARB_TIMER);
 	mutex_unlock(&gdev->lock);
 
 	return count;
@@ -112,18 +122,18 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb_gisb_arb_device *gdev,
 	const char *m_name;
 	char m_fmt[11];
 
-	cap_status = ioread32(gdev->base + ARB_ERR_CAP_STATUS);
+	cap_status = gisb_read(gdev, ARB_ERR_CAP_STATUS);
 
 	/* Invalid captured address, bail out */
 	if (!(cap_status & ARB_ERR_CAP_STATUS_VALID))
 		return 1;
 
 	/* Read the address and master */
-	arb_addr = ioread32(gdev->base + ARB_ERR_CAP_ADDR) & 0xffffffff;
+	arb_addr = gisb_read(gdev, ARB_ERR_CAP_ADDR) & 0xffffffff;
 #if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
-	arb_addr |= (u64)ioread32(gdev->base + ARB_ERR_CAP_HI_ADDR) << 32;
+	arb_addr |= (u64)gisb_read(gdev, ARB_ERR_CAP_HI_ADDR) << 32;
 #endif
-	master = ioread32(gdev->base + ARB_ERR_CAP_MASTER);
+	master = gisb_read(gdev, ARB_ERR_CAP_MASTER);
 
 	m_name = brcmstb_gisb_master_to_str(gdev, master);
 	if (!m_name) {
@@ -138,7 +148,7 @@ static int brcmstb_gisb_arb_decode_addr(struct brcmstb_gisb_arb_device *gdev,
 		m_name);
 
 	/* clear the GISB error */
-	iowrite32(ARB_ERR_CAP_CLEAR, gdev->base + ARB_ERR_CAP_CLR);
+	gisb_write(gdev, ARB_ERR_CAP_CLEAR, ARB_ERR_CAP_CLR);
 
 	return 0;
 }
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
