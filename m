From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v6 6/8] PM / devfreq: tegra: Set drvdata before enabling the irq
Date: Tue, 17 Mar 2015 10:36:16 +0100
Message-ID: <1426584991-11110-7-git-send-email-tomeu.vizoso@collabora.com>
References: <1426584991-11110-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426584991-11110-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tegra@vger.kernel.org
Cc: Mikko Perttunen <mikko.perttunen@kapsi.fi>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

To avoid a race in which the interrupt will be handled before the
drvdata has been set up.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/devfreq/tegra-devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 1de3f8b..23be954 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -697,6 +697,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	platform_set_drvdata(pdev, tegra);
+
 	err = devm_request_threaded_irq(&pdev->dev, irq, actmon_isr,
 					actmon_thread_isr, IRQF_SHARED,
 					"tegra-devfreq", tegra);
@@ -705,8 +707,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	platform_set_drvdata(pdev, tegra);
-
 	tegra_devfreq_profile.initial_freq = clk_get_rate(tegra->emc_clock);
 	tegra->devfreq = devm_devfreq_add_device(&pdev->dev,
 						 &tegra_devfreq_profile,
-- 
2.1.0
