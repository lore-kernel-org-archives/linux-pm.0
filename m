From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: [PATCH] PM / OPP: Update voltage in case freq == old_freq
Date: Thu, 14 Jun 2018 15:56:08 +0200
Message-ID: <20180614135609.20574-1-waldemar.rymarkiewicz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This commit fixes a rare but possible case when the clk rate is updated
without update of the regulator voltage.

At boot up, CPUfreq checks if the system is running at the right freq. This
is a sanity check in case a bootloader set clk rate that is outside of freq
table present with cpufreq core. In such cases system can be unstable so
better to change it to a freq that is preset in freq-table.

The CPUfreq takes next freq that is >= policy->cur and this is our
target_freq that needs to be set now.

dev_pm_opp_set_rate(dev, target_freq) checks the target_freq and the
old_freq (a current rate). If these are equal it returns early. If not,
it searches for OPP (old_opp) that fits best to old_freq (not listed in
the table) and updates old_freq (!).

Here, we can end up with old_freq = old_opp.rate = target_freq, which
is not handled in _generic_set_opp_regulator(). It's supposed to update
voltage only when freq > old_freq  || freq > old_freq.

if (freq > old_freq) {
		ret = _set_opp_voltage(dev, reg, new_supply);
[...]
if (freq < old_freq) {
		ret = _set_opp_voltage(dev, reg, new_supply);
		if (ret)

It results in, no voltage update while clk rate is updated.

Example:
freq-table = {
	1000MHz   1.15V
	 666MHZ   1.10V
	 333MHz   1.05V
}
boot-up-freq        = 800MHz   # not listed in freq-table
freq = target_freq  = 1GHz
old_freq            = 800Mhz
old_opp = _find_freq_ceil(opp_table, &old_freq);  #(old_freq is modified!)
old_freq            = 1GHz

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ab2f3fe..31ff03d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -598,7 +598,7 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 	}
 
 	/* Scaling up? Scale voltage before frequency */
-	if (freq > old_freq) {
+	if (freq >= old_freq) {
 		ret = _set_opp_voltage(dev, reg, new_supply);
 		if (ret)
 			goto restore_voltage;
-- 
2.10.1
