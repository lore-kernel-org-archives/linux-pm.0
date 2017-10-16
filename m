From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 01/10] clk: renesas: mstp: Keep wakeup sources active during system suspend
Date: Mon, 16 Oct 2017 15:55:07 +0200
Message-ID: <1508162116-5043-2-git-send-email-geert+renesas@glider.be>
References: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

If a device is part of the CPG/MSTP Clock Domain and to be used as a
wakeup source, it must be kept active during system suspend.

Currently this is handled in device-specific drivers by explicitly
increasing the use count of the module clock when the device is
configured as a wakeup source.  However, the proper way to prevent the
device from being stopped is to inform this requirement to the genpd
core.

Hence provide an .active_wakeup() callback that always returns true.
Note that this will only affect devices configured as wakeup sources.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/clk-mstp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index 500a9e4e03c48957..912e4745d8011fe8 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -329,6 +329,11 @@ void cpg_mstp_detach_dev(struct generic_pm_domain *unused, struct device *dev)
 		pm_clk_destroy(dev);
 }
 
+static bool cpg_mstp_active_wakeup(struct device *dev)
+{
+	return true;
+}
+
 void __init cpg_mstp_add_clk_domain(struct device_node *np)
 {
 	struct generic_pm_domain *pd;
@@ -345,6 +350,7 @@ void __init cpg_mstp_add_clk_domain(struct device_node *np)
 
 	pd->name = np->name;
 	pd->flags = GENPD_FLAG_PM_CLK;
+	pd->dev_ops.active_wakeup = cpg_mstp_active_wakeup;
 	pd->attach_dev = cpg_mstp_attach_dev;
 	pd->detach_dev = cpg_mstp_detach_dev;
 	pm_genpd_init(pd, &pm_domain_always_on_gov, false);
-- 
2.7.4

