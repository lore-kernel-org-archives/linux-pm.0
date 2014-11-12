From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v11 2/6] amba: Add helpers for (un)preparing AMBA clock
Date: Wed, 12 Nov 2014 15:32:24 +0100
Message-ID: <1415802748-30530-3-git-send-email-k.kozlowski@samsung.com>
References: <1415802748-30530-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415802748-30530-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Add amba_pclk_prepare() and amba_pclk_unprepare() inline functions for
handling the AMBA bus clock by device drivers.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/amba/bus.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index d024bd9c9d9b..2afc618b15ce 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -98,6 +98,16 @@ void amba_release_regions(struct amba_device *);
 #define amba_pclk_disable(d)	\
 	do { if (!IS_ERR((d)->pclk)) clk_disable((d)->pclk); } while (0)
 
+static inline int amba_pclk_prepare(struct amba_device *dev)
+{
+	return clk_prepare(dev->pclk);
+}
+
+static inline void amba_pclk_unprepare(struct amba_device *dev)
+{
+	clk_unprepare(dev->pclk);
+}
+
 /* Some drivers don't use the struct amba_device */
 #define AMBA_CONFIG_BITS(a) (((a) >> 24) & 0xff)
 #define AMBA_REV_BITS(a) (((a) >> 20) & 0x0f)
-- 
1.9.1
