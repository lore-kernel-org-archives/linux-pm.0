From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 3/3] ARM: da850: fix da850_set_pll0rate()
Date: Fri,  2 Dec 2016 16:38:54 +0100
Message-ID: <1480693134-31324-4-git-send-email-bgolaszewski@baylibre.com>
References: <1480693134-31324-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38598 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751804AbcLBPjc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2016 10:39:32 -0500
Received: by mail-wm0-f41.google.com with SMTP id f82so19174385wmf.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Dec 2016 07:39:31 -0800 (PST)
In-Reply-To: <1480693134-31324-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

This function is broken - its second argument is an index to the freq
table, not the requested clock rate in Hz. It leads to an oops when
called from clk_set_rate() since this argument isn't bounds checked
either.

Fix it by iterating over the array of supported frequencies and
selecting a one that matches or returning -EINVAL for unsupported
rates.

Also: update the davinci cpufreq driver. It's the only user of this
clock and currently it passes the cpufreq table index to
clk_set_rate(), which is confusing. Make it pass the requested clock
rate in Hz.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da850.c     | 22 ++++++++++++++++++----
 drivers/cpufreq/davinci-cpufreq.c |  2 +-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index a55101c..92e3303 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1179,14 +1179,28 @@ static int da850_set_armrate(struct clk *clk, unsigned long index)
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
+		/* requested_rate is in Hz, freq->frequency is in KHz */
+		unsigned long freq_rate = freq->frequency * 1000;
+
+		if (freq_rate == rate) {
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

