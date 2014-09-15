From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v3 2/4] amba: Add helper macros for (un)preparing AMBA clock
Date: Mon, 15 Sep 2014 12:13:51 +0200
Message-ID: <1410776033-22156-3-git-send-email-k.kozlowski@samsung.com>
References: <1410776033-22156-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:18594 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbaIOKOk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Sep 2014 06:14:40 -0400
In-reply-to: <1410776033-22156-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, linux-pm@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

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

