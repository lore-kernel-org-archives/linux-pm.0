From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v8 5/5] amba: Remove unused amba_pclk_enable/disable macros
Date: Mon, 20 Oct 2014 11:04:48 +0200
Message-ID: <1413795888-18559-6-git-send-email-k.kozlowski@samsung.com>
References: <1413795888-18559-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <1413795888-18559-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Remove the amba_pclk_enable and amba_pclk_disable macros because they
are not used by the drivers.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/amba/bus.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index c4bae79851fb..566adf0e0412 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -92,12 +92,6 @@ struct amba_device *amba_find_device(const char *, struct device *, unsigned int
 int amba_request_regions(struct amba_device *, const char *);
 void amba_release_regions(struct amba_device *);
 
-#define amba_pclk_enable(d)	\
-	(IS_ERR((d)->pclk) ? 0 : clk_enable((d)->pclk))
-
-#define amba_pclk_disable(d)	\
-	do { if (!IS_ERR((d)->pclk)) clk_disable((d)->pclk); } while (0)
-
 static inline int amba_pclk_prepare(struct amba_device *dev)
 {
 	return clk_prepare(dev->pclk);
-- 
1.9.1

