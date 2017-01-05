From: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] thermal: rockchip: fixes the conversion table
Date: Thu,  5 Jan 2017 12:37:55 +0800
Message-ID: <1483591075-17125-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ayaka-xPW3/0Ywev/iB9QmIjCX8w@public.gmane.org, randy.li-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

As Ayaka reported the thermal was abormal on rk3288 at booting time.
thermal thermal_zone1: critical temperature reached(125 C),shutting down
thermal thermal_zone2: critical temperature reached(125 C),shutting down
thermal thermal_zone1: critical temperature reached(125 C),shutting down
thermal thermal_zone2: critical temperature reached(125 C),shutting down
...
The root caused by reading the invald analogic value, the value is zero
will convert the 125 degree to trigger the critical temperature.
Fixes it with insteading of the incorrect reading now.

Fixes commit cadf29dc2a8bcaae83
("thermal: rockchip: optimize the conversion table")

Reported-by: ayaka <ayaka-xPW3/0Ywev/iB9QmIjCX8w@public.gmane.org>
Signed-off-by: Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/thermal/rockchip_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index cbbf0ce..4c77965 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -464,7 +464,7 @@ static int rk_tsadcv2_code_to_temp(const struct chip_tsadc_table *table,
 	switch (table->mode) {
 	case ADC_DECREMENT:
 		code &= table->data_mask;
-		if (code < table->id[high].code)
+		if (code <= table->id[high].code)
 			return -EAGAIN;		/* Incorrect reading */
 
 		while (low <= high) {
-- 
2.7.4
