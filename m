From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: [PATCH 3/6] PM / Domains: Remove the unnecessary ->power_off() check
 in genpd_power_off
Date: Wed, 6 Mar 2019 13:25:18 +0000
Message-ID: <1551878302-8146-4-git-send-email-aisheng.dong@nxp.com>
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

There's already a check in _genpd_power_off, so caller can directly call it
without checking.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/base/power/domain.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index f012576..591f37f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -501,6 +501,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	struct pm_domain_data *pdd;
 	struct gpd_link *link;
 	unsigned int not_suspended = 0;
+	int ret;
 
 	/*
 	 * Do not try to power off the domain in the following situations:
@@ -546,24 +547,20 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 	if (!genpd->gov)
 		genpd->state_idx = 0;
 
-	if (genpd->power_off) {
-		int ret;
-
-		if (atomic_read(&genpd->sd_count) > 0)
-			return -EBUSY;
+	if (atomic_read(&genpd->sd_count) > 0)
+		return -EBUSY;
 
-		/*
-		 * If sd_count > 0 at this point, one of the subdomains hasn't
-		 * managed to call genpd_power_on() for the master yet after
-		 * incrementing it.  In that case genpd_power_on() will wait
-		 * for us to drop the lock, so we can call .power_off() and let
-		 * the genpd_power_on() restore power for us (this shouldn't
-		 * happen very often).
-		 */
-		ret = _genpd_power_off(genpd, true);
-		if (ret)
-			return ret;
-	}
+	/*
+	 * If sd_count > 0 at this point, one of the subdomains hasn't
+	 * managed to call genpd_power_on() for the master yet after
+	 * incrementing it.  In that case genpd_power_on() will wait
+	 * for us to drop the lock, so we can call .power_off() and let
+	 * the genpd_power_on() restore power for us (this shouldn't
+	 * happen very often).
+	 */
+	ret = _genpd_power_off(genpd, true);
+	if (ret)
+		return ret;
 
 	genpd->status = GPD_STATE_POWER_OFF;
 	genpd_update_accounting(genpd);
-- 
2.7.4
