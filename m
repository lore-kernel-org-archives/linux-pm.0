From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 3/3] ARM: da850: fix da850_set_pll0rate()
Date: Mon,  5 Dec 2016 11:09:09 +0100
Message-ID: <1480932549-30811-4-git-send-email-bgolaszewski@baylibre.com>
References: <1480932549-30811-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480932549-30811-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-pm@vger.kernel.org

This function is confusing - its second argument is an index to the
freq table, not the requested clock rate in Hz, but it's used as the
set_rate callback for the pll0 clock. It leads to an oops when the
caller doesn't know the internals and passes the rate in Hz as
argument instead of the cpufreq index since this argument isn't bounds
checked either.

Fix it by iterating over the array of supported frequencies and
selecting a one that matches or returning -EINVAL for unsupported
rates.

Also: update the davinci cpufreq driver. It's the only user of this
clock and currently it passes the cpufreq table index to
clk_set_rate(), which is confusing. Make it pass the requested clock
rate in Hz.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-davinci/da850.c     | 20 ++++++++++++++++----
 drivers/cpufreq/davinci-cpufreq.c |  2 +-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 006ec56..9837541 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1179,14 +1179,26 @@ static int da850_set_armrate(struct clk *clk, unsigned long index)
 	return clk_set_rate(pllclk, index);
 }
 
-static int da850_set_pll0rate(struct clk *clk, unsigned long index)
+static int da850_set_pll0rate(struct clk *clk, unsigned long rate)
 {
-	unsigned int prediv, mult, postdiv;
-	struct da850_opp *opp;
 	struct pll_data *pll = clk->pll_data;
+	struct cpufreq_frequency_table *freq;
+	unsigned int prediv, mult, postdiv;
+	struct da850_opp *opp = NULL;
 	int ret;
 
-	opp = (struct da850_opp *) cpufreq_info.freq_table[index].driver_data;
+	for (freq = da850_freq_table;
+	     freq->frequency != CPUFREQ_TABLE_END; freq++) {
+		/* rate is in Hz, freq->frequency is in KHz */
+		if (freq->frequency == rate / 1000) {
+			opp = (struct da850_opp *)freq->driver_data;
+			break;
+		}
+	}
+
+	if (opp == NULL)
+		return -EINVAL;
+
 	prediv = opp->prediv;
 	mult = opp->mult;
 	postdiv = opp->postdiv;
diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index b95a872..d54a27c 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -55,7 +55,7 @@ static int davinci_target(struct cpufreq_policy *policy, unsigned int idx)
 			return ret;
 	}
 
-	ret = clk_set_rate(armclk, idx);
+	ret = clk_set_rate(armclk, new_freq * 1000);
 	if (ret)
 		return ret;
 
-- 
2.9.3
