From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v4 2/4] amba: Add helper macros for (un)preparing AMBA clock
Date: Tue, 16 Sep 2014 10:51:32 +0200
Message-ID: <1410857494-15936-3-git-send-email-k.kozlowski@samsung.com>
References: <1410857494-15936-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1410857494-15936-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Add amba_pclk_prepare() and amba_pclk_unprepare() macros for handling
the AMBA bus clock by device drivers.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 include/linux/amba/bus.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index fdd7e1b61f60..ad52027a9cbf 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -92,6 +92,12 @@ void amba_release_regions(struct amba_device *);
 #define amba_pclk_disable(d)	\
 	do { if (!IS_ERR((d)->pclk)) clk_disable((d)->pclk); } while (0)
 
+#define amba_pclk_prepare(d)	\
+	(IS_ERR((d)->pclk) ? 0 : clk_prepare((d)->pclk))
+
+#define amba_pclk_unprepare(d)	\
+	do { if (!IS_ERR((d)->pclk)) clk_unprepare((d)->pclk); } while (0)
+
 /* Some drivers don't use the struct amba_device */
 #define AMBA_CONFIG_BITS(a) (((a) >> 24) & 0xff)
 #define AMBA_REV_BITS(a) (((a) >> 20) & 0x0f)
-- 
1.9.1
