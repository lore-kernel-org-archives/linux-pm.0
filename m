From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH v5 4/8] mips: lemote 2f: Use cpufreq_for_each_entry macro
 for iteration
Date: Fri, 25 Apr 2014 23:16:25 +0300
Message-ID: <535AC299.5020202@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: John Crispin <blogic@openwrt.org>, Simon Horman <horms+renesas@verge.net.au>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The cpufreq core now supports the cpufreq_for_each_entry macro helper
for iteration over the cpufreq_frequency_table, so use it.

It should have no functional changes.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 arch/mips/loongson/lemote-2f/clock.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/mips/loongson/lemote-2f/clock.c b/arch/mips/loongson/lemote-2f/clock.c
index e1f427f..1eed38e 100644
--- a/arch/mips/loongson/lemote-2f/clock.c
+++ b/arch/mips/loongson/lemote-2f/clock.c
@@ -91,9 +91,9 @@ EXPORT_SYMBOL(clk_put);
 
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
+	struct cpufreq_frequency_table *pos;
 	int ret = 0;
 	int regval;
-	int i;
 
 	if (likely(clk->ops && clk->ops->set_rate)) {
 		unsigned long flags;
@@ -106,22 +106,16 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	if (unlikely(clk->flags & CLK_RATE_PROPAGATES))
 		propagate_rate(clk);
 
-	for (i = 0; loongson2_clockmod_table[i].frequency != CPUFREQ_TABLE_END;
-	     i++) {
-		if (loongson2_clockmod_table[i].frequency ==
-		    CPUFREQ_ENTRY_INVALID)
-			continue;
-		if (rate == loongson2_clockmod_table[i].frequency)
+	cpufreq_for_each_valid_entry(pos, loongson2_clockmod_table)
+		if (rate == pos->frequency)
 			break;
-	}
-	if (rate != loongson2_clockmod_table[i].frequency)
+	if (rate != pos->frequency)
 		return -ENOTSUPP;
 
 	clk->rate = rate;
 
 	regval = LOONGSON_CHIPCFG0;
-	regval = (regval & ~0x7) |
-		(loongson2_clockmod_table[i].driver_data - 1);
+	regval = (regval & ~0x7) | (pos->driver_data - 1);
 	LOONGSON_CHIPCFG0 = regval;
 
 	return ret;
-- 
1.9.0
