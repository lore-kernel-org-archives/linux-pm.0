From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 16/16] ARM: shmobile: R-Mobile: Use CPG/MSTP Clock Domain
 attach/detach helpers
Date: Tue,  4 Aug 2015 14:28:17 +0200
Message-ID: <1438691297-29235-17-git-send-email-geert+renesas@glider.be>
References: <1438691297-29235-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438691297-29235-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The R-Mobile PM Domain driver manages both power domains and a clock
domain.

The clock domain part is very similar to the CPG/MSTP Clock Domain,
which is used on shmobile SoCs without device power domains, except for
the way how clocks suitable for power management are selected:
  - The former uses the first clock tied to the device through the NULL
    con_id, which is a relic from the legacy pm_clk_notifier-based
    method in drivers/sh/pm_runtime.c,
  - The latter looks for suitable clocks in DT, which is more
    future-proof.

All platforms using this driver are now supported in DT-based ARM
multi-platform builds only, hence switch to using the CPG/MSTP Clock
Domain helpers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
v4:
  - Add Reviewed-by,

v3:
  - Drop -legacy support, hence this patch depends on r8a7740/sh73a0
    legacy removal,
  - Use "CPG/MSTP Clock Domain" instead of "CPG Clock Domain",

v2:
  - New.
---
 arch/arm/mach-shmobile/pm-rmobile.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index a5b96b990aea8dfc..89068c8ec50f2c76 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -12,6 +12,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
+#include <linux/clk/shmobile.h>
 #include <linux/console.h>
 #include <linux/delay.h>
 #include <linux/of.h>
@@ -124,36 +125,6 @@ static bool rmobile_pd_active_wakeup(struct device *dev)
 	return true;
 }
 
-static int rmobile_pd_attach_dev(struct generic_pm_domain *domain,
-				 struct device *dev)
-{
-	int error;
-
-	error = pm_clk_create(dev);
-	if (error) {
-		dev_err(dev, "pm_clk_create failed %d\n", error);
-		return error;
-	}
-
-	error = pm_clk_add(dev, NULL);
-	if (error) {
-		dev_err(dev, "pm_clk_add failed %d\n", error);
-		goto fail;
-	}
-
-	return 0;
-
-fail:
-	pm_clk_destroy(dev);
-	return error;
-}
-
-static void rmobile_pd_detach_dev(struct generic_pm_domain *domain,
-				  struct device *dev)
-{
-	pm_clk_destroy(dev);
-}
-
 static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 {
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
@@ -164,8 +135,8 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
 	genpd->power_off		= rmobile_pd_power_down;
 	genpd->power_on			= rmobile_pd_power_up;
-	genpd->attach_dev		= rmobile_pd_attach_dev;
-	genpd->detach_dev		= rmobile_pd_detach_dev;
+	genpd->attach_dev		= cpg_mstp_attach_dev;
+	genpd->detach_dev		= cpg_mstp_detach_dev;
 	__rmobile_pd_power_up(rmobile_pd, false);
 }
 
-- 
1.9.1
