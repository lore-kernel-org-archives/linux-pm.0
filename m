From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v6 5/8] PM / devfreq: tegra: remove operating-points
Date: Tue, 17 Mar 2015 10:36:15 +0100
Message-ID: <1426584991-11110-6-git-send-email-tomeu.vizoso@collabora.com>
References: <1426584991-11110-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426584991-11110-1-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mikko Perttunen <mikko.perttunen-/1wQRMveznE@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

As the DT bindings don't have an operating-points property any more,
build the OPP table from the frequencies supported by the EMC clock.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---
 drivers/devfreq/tegra-devfreq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 5a6164c..1de3f8b 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -618,6 +618,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	struct tegra_devfreq_device *dev;
 	struct resource *res;
 	unsigned int i;
+	unsigned long rate;
 	int irq;
 	int err;
 
@@ -649,12 +650,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->emc_clock);
 	}
 
-	err = of_init_opp_table(&pdev->dev);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to init operating point table\n");
-		return err;
-	}
-
 	clk_set_rate(tegra->emc_clock, ULONG_MAX);
 
 	tegra->rate_change_nb.notifier_call = tegra_actmon_rate_notify_cb;
@@ -691,6 +686,11 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		tegra_actmon_configure_device(tegra, dev);
 	}
 
+	for (rate = 0; rate <= tegra->max_freq * KHZ; rate++) {
+		rate = clk_round_rate(tegra->emc_clock, rate);
+		dev_pm_opp_add(&pdev->dev, rate, 0);
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
 		dev_err(&pdev->dev, "Failed to get IRQ\n");
-- 
2.1.0
