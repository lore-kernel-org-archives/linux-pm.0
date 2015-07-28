From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/4] cpufreq: Update boost flag while initializing freq table from OPPs
Date: Tue, 28 Jul 2015 16:50:01 +0530
Message-ID: <b2b36251301a17c2f37166de194d43dd448f3f72.1438081962.git.viresh.kumar@linaro.org>
References: <cover.1438081962.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438081962.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438081962.git.viresh.kumar@linaro.org>
References: <cover.1438081962.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com, nm@ti.com, sboyd@codeaurora.org, Tomasz Figa <tomasz.figa@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Javier Martinez Canillas <javier@dowhile0.org>, Thomas Abraham <thomas.ab@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

cpufreq table entries for OPPs with turbo modes enabled, should be
marked with CPUFREQ_BOOST_FREQ flag. This ensures that these states are
only used while operating in boost or turbo mode.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_opp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_opp.c b/drivers/cpufreq/cpufreq_opp.c
index 773bcde893c0..0f5e6d5f6da0 100644
--- a/drivers/cpufreq/cpufreq_opp.c
+++ b/drivers/cpufreq/cpufreq_opp.c
@@ -75,6 +75,10 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 		}
 		freq_table[i].driver_data = i;
 		freq_table[i].frequency = rate / 1000;
+
+		/* Is Boost/turbo opp ? */
+		if (dev_pm_opp_is_turbo(opp))
+			freq_table[i].flags = CPUFREQ_BOOST_FREQ;
 	}
 
 	freq_table[i].driver_data = i;
-- 
2.4.0
