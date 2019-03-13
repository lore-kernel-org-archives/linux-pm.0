From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH] clk: mvebu: armada-37xx-periph: Fix initialization for cpu clocks
Date: Wed, 13 Mar 2019 17:35:58 +0100
Message-ID: <20190313163558.6705-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Christian Neubert <christian.neubert.86@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@bootlin.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The clock parenting was not setup properly when DVFS was enabled. It was
expected that the same clock source was used with and without DVFS which
was not the case.

This patch fixes this issue, allowing to make the cpufreq support work
when the CPU clocks source are not the default ones.

Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
Cc: <stable@vger.kernel.org>
Reported-by: Christian Neubert <christian.neubert.86@gmail.com>
Reported-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 1f1cff428d78..26ed3c18a239 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -671,6 +671,17 @@ static int armada_3700_add_composite_clk(const struct clk_periph_data *data,
 		map = syscon_regmap_lookup_by_compatible(
 				"marvell,armada-3700-nb-pm");
 		pmcpu_clk->nb_pm_base = map;
+
+		/*
+		 * Use the same parent when DVFS is enabled that the
+		 * default parent received at boot time. When this
+		 * function is called, DVFS is not enabled yet, so we
+		 * get the default parent and we can set the parent
+		 * for DVFS.
+		 */
+		if (clk_pm_cpu_set_parent(muxrate_hw,
+					  clk_pm_cpu_get_parent(muxrate_hw)))
+			dev_warn(dev, "Failed to setup default parent clock for DVFS\n");
 	}
 
 	*hw = clk_hw_register_composite(dev, data->name, data->parent_names,
-- 
2.20.1
