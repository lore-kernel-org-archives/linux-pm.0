From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 03/10] soc: renesas: rcar-sysc: Keep wakeup sources active during system suspend
Date: Mon, 16 Oct 2017 15:55:09 +0200
Message-ID: <1508162116-5043-4-git-send-email-geert+renesas@glider.be>
References: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

If an R-Car SYSC slave device is part of the CPG/MSTP or CPG/MSSR Clock
Domain and to be used as a wakeup source, it must be kept active during
system suspend.

Currently this is handled in device-specific drivers by explicitly
increasing the use count of the module clock when the device is
configured as a wakeup source.  However, the proper way to prevent the
device from being stopped is to inform this requirement to the genpd
core.

Hence provide an .active_wakeup() callback that always returns true.
Note that this will only affect devices configured as wakeup sources.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/soc/renesas/rcar-sysc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index c8406e81640f6560..beb8b483a62abaca 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -194,6 +194,11 @@ static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
 
 static bool has_cpg_mstp;
 
+static bool rcar_sysc_pd_active_wakeup(struct device *dev)
+{
+	return true;
+}
+
 static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 {
 	struct generic_pm_domain *genpd = &pd->genpd;
@@ -225,6 +230,7 @@ static void __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 	if (!(pd->flags & (PD_CPU | PD_SCU))) {
 		/* Enable Clock Domain for I/O devices */
 		genpd->flags |= GENPD_FLAG_PM_CLK;
+		genpd->dev_ops.active_wakeup = rcar_sysc_pd_active_wakeup;
 		if (has_cpg_mstp) {
 			genpd->attach_dev = cpg_mstp_attach_dev;
 			genpd->detach_dev = cpg_mstp_detach_dev;
-- 
2.7.4
