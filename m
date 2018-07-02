From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v4.9] PM / OPP: Update voltage in case freq == old_freq
Date: Mon,  2 Jul 2018 14:19:47 +0530
Message-ID: <3717ee50c1f1f48cffcb1a2e41c04e28881776d1.1530521347.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>, "4 . 6+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>

Original commit c5c2a97b3ac7 ("PM / OPP: Update voltage in case freq ==
old_freq").

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

Fixes: 6a0712f6f199 ("PM / OPP: Add dev_pm_opp_set_rate()")
Cc: 4.6+ <stable@vger.kernel.org> # v4.6+
Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Sending it for stable kernels from 4.6 until 4.9.

 drivers/base/power/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 4c7c6da7a989..0580cbe5bd1c 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -642,7 +642,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	rcu_read_unlock();
 
 	/* Scaling up? Scale voltage before frequency */
-	if (freq > old_freq) {
+	if (freq >= old_freq) {
 		ret = _set_opp_voltage(dev, reg, u_volt, u_volt_min,
 				       u_volt_max);
 		if (ret)
-- 
2.18.0.rc1.242.g61856ae69a2c
