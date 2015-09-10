From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] clk: tegra: dfll: Properly protect OPP list
Date: Thu, 10 Sep 2015 15:55:21 +0200
Message-ID: <1441893321-4563-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The OPP list needs to be protected against concurrent accesses. Using
simple RCU read locks does the trick and gets rid of the following
lockdep warning:

	[    9.095873] ===============================
	[    9.100050] [ INFO: suspicious RCU usage. ]
	[    9.104313] 4.2.0-next-20150908 #1 Not tainted
	[    9.111187] -------------------------------
	[    9.115428] drivers/base/power/opp.c:460 Missing rcu_read_lock() or dev_opp_list_lock protection!
	[    9.128519]
	[    9.128519] other info that might help us debug this:
	[    9.128519]
	[    9.136651]
	[    9.136651] rcu_scheduler_active = 1, debug_locks = 0
	[    9.143222] 4 locks held by kworker/u8:0/6:
	[    9.147409]  #0:  ("%s""deferwq"){++++.+}, at: [<c0040d8c>] process_one_work+0x118/0x4bc
	[    9.155610]  #1:  (deferred_probe_work){+.+.+.}, at: [<c0040d8c>] process_one_work+0x118/0x4bc
	[    9.164335]  #2:  (&dev->mutex){......}, at: [<c03b8194>] __device_attach+0x20/0x118
	[    9.172134]  #3:  (prepare_lock){+.+...}, at: [<c054bc08>] clk_prepare_lock+0x10/0xf8
	[    9.180365]
	[    9.180365] stack backtrace:
	[    9.184764] CPU: 2 PID: 6 Comm: kworker/u8:0 Not tainted 4.2.0-next-20150908 #1
	[    9.194536] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
	[    9.200809] Workqueue: deferwq deferred_probe_work_func
	[    9.206115] [<c001802c>] (unwind_backtrace) from [<c00135a4>] (show_stack+0x10/0x14)
	[    9.213918] [<c00135a4>] (show_stack) from [<c02a8418>] (dump_stack+0x94/0xd4)
	[    9.221142] [<c02a8418>] (dump_stack) from [<c03c6f6c>] (dev_pm_opp_find_freq_ceil+0x108/0x114)
	[    9.229903] [<c03c6f6c>] (dev_pm_opp_find_freq_ceil) from [<c0551a3c>] (dfll_calculate_rate_request+0xb8/0x170)
	[    9.240041] [<c0551a3c>] (dfll_calculate_rate_request) from [<c0551b10>] (dfll_clk_round_rate+0x1c/0x2c)
	[    9.249560] [<c0551b10>] (dfll_clk_round_rate) from [<c054de2c>] (clk_calc_new_rates+0x1b8/0x228)
	[    9.258473] [<c054de2c>] (clk_calc_new_rates) from [<c054e44c>] (clk_core_set_rate_nolock+0x44/0xac)
	[    9.267647] [<c054e44c>] (clk_core_set_rate_nolock) from [<c054e4d8>] (clk_set_rate+0x24/0x34)
	[    9.276306] [<c054e4d8>] (clk_set_rate) from [<c0512460>] (tegra124_cpufreq_probe+0x120/0x230)
	[    9.284944] [<c0512460>] (tegra124_cpufreq_probe) from [<c03b9cbc>] (platform_drv_probe+0x44/0xac)
	[    9.293948] [<c03b9cbc>] (platform_drv_probe) from [<c03b84c8>] (driver_probe_device+0x218/0x304)
	[    9.302816] [<c03b84c8>] (driver_probe_device) from [<c03b69b0>] (bus_for_each_drv+0x60/0x94)
	[    9.311397] [<c03b69b0>] (bus_for_each_drv) from [<c03b8228>] (__device_attach+0xb4/0x118)
	[    9.313229] ata1: SATA link down (SStatus 0 SControl 300)
	[    9.325137] [<c03b8228>] (__device_attach) from [<c03b77c8>] (bus_probe_device+0x88/0x90)
	[    9.333360] [<c03b77c8>] (bus_probe_device) from [<c03b7be8>] (deferred_probe_work_func+0x58/0x8c)
	[    9.342338] [<c03b7be8>] (deferred_probe_work_func) from [<c0040dfc>] (process_one_work+0x188/0x4bc)
	[    9.351526] [<c0040dfc>] (process_one_work) from [<c004117c>] (worker_thread+0x4c/0x4f4)
	[    9.359690] [<c004117c>] (worker_thread) from [<c0047230>] (kthread+0xe4/0xf8)
	[    9.366970] [<c0047230>] (kthread) from [<c000f7d0>] (ret_from_fork+0x14/0x24)

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/clk/tegra/clk-dfll.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/tegra/clk-dfll.c b/drivers/clk/tegra/clk-dfll.c
index aa026bcf5b00..8e25bd52da8c 100644
--- a/drivers/clk/tegra/clk-dfll.c
+++ b/drivers/clk/tegra/clk-dfll.c
@@ -632,11 +632,15 @@ static int find_lut_index_for_rate(struct tegra_dfll *td, unsigned long rate)
 	struct dev_pm_opp *opp;
 	int i, uv;
 
+	rcu_read_lock();
+
 	opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
 	if (IS_ERR(opp))
 		return PTR_ERR(opp);
 	uv = dev_pm_opp_get_voltage(opp);
 
+	rcu_read_unlock();
+
 	for (i = 0; i < td->i2c_lut_size; i++) {
 		if (regulator_list_voltage(td->vdd_reg, td->i2c_lut[i]) == uv)
 			return i;
@@ -1450,6 +1454,8 @@ static int dfll_build_i2c_lut(struct tegra_dfll *td)
 	td->i2c_lut[0] = lut;
 
 	for (j = 1, rate = 0; ; rate++) {
+		rcu_read_lock();
+
 		opp = dev_pm_opp_find_freq_ceil(td->soc->dev, &rate);
 		if (IS_ERR(opp))
 			break;
@@ -1458,6 +1464,8 @@ static int dfll_build_i2c_lut(struct tegra_dfll *td)
 		if (v_opp <= td->soc->min_millivolts * 1000)
 			td->dvco_rate_min = dev_pm_opp_get_freq(opp);
 
+		rcu_read_unlock();
+
 		for (;;) {
 			v += max(1, (v_max - v) / (MAX_DFLL_VOLTAGES - j));
 			if (v >= v_opp)
-- 
2.5.0

