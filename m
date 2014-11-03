From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 4/9] ARM: shmobile: R-Mobile: Use
 generic_pm_domain.attach_dev() for pm_clk setup
Date: Mon,  3 Nov 2014 16:34:51 +0100
Message-ID: <1415028896-9005-5-git-send-email-geert+renesas@glider.be>
References: <1415028896-9005-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1415028896-9005-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Philipp Zabel <philipp.zabel@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Use the just introduced genpd attach/detach callbacks to register the
devices' module clocks, instead of doing it directly, to make it
DT-proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
v4:
  - Add Reviewed-by,
  - Add missing pm_clk_create()/pm_clk_destroy() calls,
  - Update for attach_dev() returning an error code again,
v3:
  - Update for callback signature changes,
v2:
  - New.

---
 arch/arm/mach-shmobile/pm-rmobile.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 717e6413d29cb998..068608d5f54a9a64 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -101,6 +101,34 @@ static bool rmobile_pd_active_wakeup(struct device *dev)
 	return true;
 }
 
+static int rmobile_pd_attach_dev(struct device *dev)
+{
+	int error;
+
+	error = pm_clk_create(dev);
+	if (error) {
+		dev_err(dev, "pm_clk_create failed %d\n", error);
+		return error;
+	}
+
+	error = pm_clk_add(dev, NULL);
+	if (error) {
+		dev_err(dev, "pm_clk_add failed %d\n", error);
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	pm_clk_destroy(dev);
+	return error;
+}
+
+static void rmobile_pd_detach_dev(struct device *dev)
+{
+	pm_clk_destroy(dev);
+}
+
 static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 {
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
@@ -112,6 +140,8 @@ static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 	genpd->dev_ops.active_wakeup	= rmobile_pd_active_wakeup;
 	genpd->power_off		= rmobile_pd_power_down;
 	genpd->power_on			= rmobile_pd_power_up;
+	genpd->attach_dev		= rmobile_pd_attach_dev;
+	genpd->detach_dev		= rmobile_pd_detach_dev;
 	__rmobile_pd_power_up(rmobile_pd, false);
 }
 
@@ -130,8 +160,6 @@ void rmobile_add_device_to_domain_td(const char *domain_name,
 	struct device *dev = &pdev->dev;
 
 	__pm_genpd_name_add_device(domain_name, dev, td);
-	if (pm_clk_no_clocks(dev))
-		pm_clk_add(dev, NULL);
 }
 
 void rmobile_add_devices_to_domains(struct pm_domain_device data[],
-- 
1.9.1
