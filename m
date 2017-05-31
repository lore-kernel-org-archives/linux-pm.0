From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/2] power: reset: at91-sama5d2_shdwc: fix clobber list
Date: Wed, 31 May 2017 11:49:15 +0200
Message-ID: <20170531094915.3469-2-alexandre.belloni@free-electrons.com>
References: <20170531094915.3469-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170531094915.3469-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

Assembly in at91_lpddr_poweroff has r0 in the clobber list but uses r6.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 90b0b5a70ce5..55fce8b75245 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -132,7 +132,7 @@ static void at91_lpddr_poweroff(void)
 		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
 		  "r" (at91_shdwc->at91_shdwc_base),
 		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
-		: "r0");
+		: "r6");
 }
 
 static u32 at91_shdwc_debouncer_value(struct platform_device *pdev,
-- 
2.11.0
