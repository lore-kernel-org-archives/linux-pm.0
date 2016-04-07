From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 05/11] soc: renesas: rcar-sysc: Enable Clock Domain for r8a7795 I/O devices
Date: Thu,  7 Apr 2016 14:20:22 +0200
Message-ID: <1460031628-13336-6-git-send-email-geert+renesas@glider.be>
References: <1460031628-13336-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1460031628-13336-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

On R-Car H3, some power areas (e.g. A3VP) contain I/O devices, which are
also part of the CPG/MSSR Clock Domain.  Hook up the CPG/MSSR Clock
Domain attach/detach callbacks to enable power management using module
clocks.

This also allows to support the Clock Domain for devices in the
"always-on" power area.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Remove the explicit dependency on the CPG/MSSR driver by forwarding
    the attach/detach callbacks to the parent PM Domain.
    If deemed reusable, rcar_sysc_{at,de}tach_dev() can be moved to
    common genpd code later.

v3:
  - Hook up the CPG/MSSR Clock Domain attach/detach callbacks instead of
    using our own copies,

v2:
  - New.
---
 drivers/soc/renesas/rcar-sysc.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index bdab8ac6803300e7..6fad1311133a3ac7 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -224,6 +224,36 @@ static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
 	return rcar_sysc_power_up(&pd->ch);
 }
 
+#ifdef CONFIG_ARCH_R8A7795
+static int rcar_sysc_attach_dev(struct generic_pm_domain *genpd,
+				struct device *dev)
+{
+	struct gpd_link *link;
+	int error;
+
+	/* Forward call to parent */
+	list_for_each_entry(link, &genpd->slave_links, slave_node)
+		if (link->master && link->master->attach_dev) {
+			error = link->master->attach_dev(link->master, dev);
+			if (error)
+				return error;
+		}
+
+	return 0;
+}
+
+static void rcar_sysc_detach_dev(struct generic_pm_domain *genpd,
+				 struct device *dev)
+{
+	struct gpd_link *link;
+
+	/* Forward call to parent */
+	list_for_each_entry(link, &genpd->slave_links, slave_node)
+		if (link->master && link->master->detach_dev)
+			link->master->detach_dev(link->master, dev);
+}
+#endif /* CONFIG_ARCH_R8A7795 */
+
 static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 {
 	struct generic_pm_domain *genpd = &pd->genpd;
@@ -249,6 +279,15 @@ static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 		gov = &pm_domain_always_on_gov;
 	}
 
+#ifdef CONFIG_ARCH_R8A7795
+	if (!(pd->flags & (PD_CPU | PD_SCU))) {
+		/* Enable Clock Domain for I/O devices */
+		genpd->flags = GENPD_FLAG_PM_CLK;
+		genpd->attach_dev = rcar_sysc_attach_dev;
+		genpd->detach_dev = rcar_sysc_detach_dev;
+	}
+#endif
+
 	pm_genpd_init(genpd, gov, false);
 	genpd->dev_ops.active_wakeup = rcar_sysc_active_wakeup;
 	genpd->power_off = rcar_sysc_pd_power_off;
-- 
1.9.1
