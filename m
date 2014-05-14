From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Wed, 14 May 2014 15:30:52 -0700
Message-ID: <1400106655-22465-3-git-send-email-soren.brinkmann@xilinx.com>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>
Cc: Michal Simek <michal.simek@xilinx.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-pm@vger.kernel.org

Introduce a new API function to round a rate to the closest possible
rate the HW clock can generate.
In contrast to 'clk_round_rate()' which works similar, but always returns
a frequency <= its input rate.

The code comes from Uwe and was copied from this LKML thread:
https://lkml.org/lkml/2013/3/21/115

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

 drivers/clk/clk.c   | 26 ++++++++++++++++++++++++--
 include/linux/clk.h | 14 ++++++++++++--
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index dff0373f53c1..b715f5a9826c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1011,8 +1011,9 @@ unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
  * @rate: the rate which is to be rounded
  *
  * Takes in a rate as input and rounds it to a rate that the clk can actually
- * use which is then returned.  If clk doesn't support round_rate operation
- * then the parent rate is returned.
+ * use and does not exceed the requested frequency, which is then returned.
+ * If clk doesn't support round_rate operation then the parent rate
+ * is returned.
  */
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
@@ -1027,6 +1028,27 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 EXPORT_SYMBOL_GPL(clk_round_rate);
 
 /**
+ * clk_round_rate_nearest - round the given rate for a clk
+ * @clk: the clk for which we are rounding a rate
+ * @rate: the rate which is to be rounded
+ *
+ * Takes in a rate as input and rounds it to the closest rate that the clk
+ * can actually use which is then returned. If clk doesn't support
+ * round_rate operation then the parent rate is returned.
+ */
+long clk_round_rate_nearest(struct clk *clk, unsigned long rate)
+{
+	long lower_limit = clk_round_rate(clk, rate);
+	long upper_limit = clk_round_rate(clk, rate + (rate - lower_limit));
+
+	if (rate - lower_limit < upper_limit - rate)
+		return lower_limit;
+	else
+		return upper_limit;
+}
+EXPORT_SYMBOL_GPL(clk_round_rate_nearest);
+
+/**
  * __clk_notify - call clk notifier chain
  * @clk: struct clk * that is changing rate
  * @msg: clk notifier type (see include/linux/clk.h)
diff --git a/include/linux/clk.h b/include/linux/clk.h
index fb5e097d8f72..2f83bf030ac6 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -255,15 +255,25 @@ void devm_clk_put(struct device *dev, struct clk *clk);
 
 
 /**
- * clk_round_rate - adjust a rate to the exact rate a clock can provide
+ * clk_round_rate - round a rate to the exact rate a clock can provide not
+ *		    exceeding @rate
  * @clk: clock source
  * @rate: desired clock rate in Hz
  *
- * Returns rounded clock rate in Hz, or negative errno.
+ * Returns rounded clock rate in Hz, or parent rate
  */
 long clk_round_rate(struct clk *clk, unsigned long rate);
 
 /**
+ * clk_round_rate_nearest - round a rate to the exact rate a clock can provide
+ * @clk: the clk for which we are rounding a rate
+ * @rate: the rate which is to be rounded
+ *
+ * Returns rounded clock rate in Hz, or parent rate
+ */
+long clk_round_rate_nearest(struct clk *clk, unsigned long rate);
+
+/**
  * clk_set_rate - set the clock rate for a clock source
  * @clk: clock source
  * @rate: desired clock rate in Hz
-- 
1.9.3.1.ga73a6ad
