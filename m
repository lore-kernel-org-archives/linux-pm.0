From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v12 6/6] amba: Use inlines instead of macros for
 amba_pclk_enable/disable
Date: Fri, 14 Nov 2014 09:50:33 +0100
Message-ID: <1415955033-29093-7-git-send-email-k.kozlowski@samsung.com>
References: <1415955033-29093-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1415955033-29093-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Replace the amba_pclk_enable and amba_pclk_disable macros with static
inline functions and remove checks for IS_ERR. The amba bus clock won't
be ERR because probe would fail before the use of these functions.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 include/linux/amba/bus.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 2afc618b15ce..0ab5f8e0dea2 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -92,11 +92,15 @@ struct amba_device *amba_find_device(const char *, struct device *, unsigned int
 int amba_request_regions(struct amba_device *, const char *);
 void amba_release_regions(struct amba_device *);
 
-#define amba_pclk_enable(d)	\
-	(IS_ERR((d)->pclk) ? 0 : clk_enable((d)->pclk))
+static inline int amba_pclk_enable(struct amba_device *dev)
+{
+	return clk_enable(dev->pclk);
+}
 
-#define amba_pclk_disable(d)	\
-	do { if (!IS_ERR((d)->pclk)) clk_disable((d)->pclk); } while (0)
+static inline void amba_pclk_disable(struct amba_device *dev)
+{
+	clk_disable(dev->pclk);
+}
 
 static inline int amba_pclk_prepare(struct amba_device *dev)
 {
-- 
1.9.1
