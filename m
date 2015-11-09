From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v4 03/10] thermal: rockchip: trivial: fix typo in commit
Date: Mon,  9 Nov 2015 12:48:55 +0800
Message-ID: <1447044542-30859-4-git-send-email-wxt@rock-chips.com>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1447044542-30859-1-git-send-email-wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

Changes in v4: None
Changes in v3: None
Changes in v2:
- As Eduardo comments on patch v1, split in smaller changes.

Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index e72a69d..907a317 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -237,15 +237,19 @@ static int rk_tsadcv2_code_to_temp(u32 code, int *temp)
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
