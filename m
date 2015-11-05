From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v2 3/9] thermal: rockchip: trivial: fix typo in commit
Date: Thu,  5 Nov 2015 13:17:59 +0800
Message-ID: <1446700685-18017-4-git-send-email-wxt@rock-chips.com>
References: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <trivial@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2:
- As Eduardo comments on patch v1, split in smaller changes.

Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 075d18e..bdf7063 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -236,15 +236,19 @@ static int rk_tsadcv2_code_to_temp(u32 code, int *temp)
 }
 
 /**
- * rk_tsadcv2_initialize - initialize TASDC Controller
- * (1) Set TSADCV2_AUTO_PERIOD, configure the interleave between
- * every two accessing of TSADC in normal operation.
- * (2) Set TSADCV2_AUTO_PERIOD_HT, configure the interleave between
- * every two accessing of TSADC after the temperature is higher
- * than COM_SHUT or COM_INT.
- * (3) Set TSADCV2_HIGH_INT_DEBOUNCE and TSADC_HIGHT_TSHUT_DEBOUNCE,
- * if the temperature is higher than COMP_INT or COMP_SHUT for
- * "debounce" times, TSADC controller will generate interrupt or TSHUT.
+ * rk_tsadcv2_initialize - initialize TASDC Controller.
+ *
+ * (1) Set TSADC_V2_AUTO_PERIOD:
+ *     Configure the interleave between every two accessing of
+ *     TSADC in normal operation.
+ *
+ * (2) Set TSADCV2_AUTO_PERIOD_HT:
+ *     Configure the interleave between every two accessing of
+ *     TSADC after the temperature is higher than COM_SHUT or COM_INT.
+ *
+ * (3) Set TSADCV2_HIGH_INT_DEBOUNCE and TSADC_HIGHT_TSHUT_DEBOUNCE:
+ *     If the temperature is higher than COMP_INT or COMP_SHUT for
+ *     "debounce" times, TSADC controller will generate interrupt or TSHUT.
  */
 static void rk_tsadcv2_initialize(void __iomem *regs,
 				  enum tshut_polarity tshut_polarity)
-- 
1.9.1
