From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: [PATCH 4/6] PM / Domains: Move the Subdomain check into
 _genpd_power_off
Date: Wed, 6 Mar 2019 13:25:22 +0000
Message-ID: <1551878302-8146-5-git-send-email-aisheng.dong@nxp.com>
References: <1551878302-8146-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551878302-8146-1-git-send-email-aisheng.dong@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Move the Subdomain check into _genpd_power_off, then the caller does
not have to check it each time. This also ensures a double check
of &genpd->sd_count before really power off domain in case it's
increased asynchronously by subdomains. This is the same behavior
as the original genpd_power_off() does.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/base/power/domain.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 591f37f..61cd500 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -452,6 +452,9 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 	if (!genpd->power_off)
 		return 0;
 
+	if (atomic_read(&genpd->sd_count) > 0)
+		return -EBUSY;
+
 	if (!timed)
 		return genpd->power_off(genpd);
 
@@ -547,9 +550,6 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	if (!genpd->gov)
 		genpd->state_idx = 0;
 
-	if (atomic_read(&genpd->sd_count) > 0)
-		return -EBUSY;
-
 	/*
 	 * If sd_count > 0 at this point, one of the subdomains hasn't
 	 * managed to call genpd_power_on() for the master yet after
@@ -962,8 +962,7 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 	if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
 		return;
 
-	if (genpd->suspended_count != genpd->device_count
-	    || atomic_read(&genpd->sd_count) > 0)
+	if (genpd->suspended_count != genpd->device_count)
 		return;
 
 	/* Choose the deepest state when suspending */
-- 
2.7.4
