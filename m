From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Subject: [PATCH 08/13] clk: tegra: Add the DFLL as a possible parent of the cclk_g clock
Date: Fri, 11 Jul 2014 00:42:44 +0300
Message-ID: <1405028569-14253-9-git-send-email-ttynkkynen@nvidia.com>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org, Tuomas Tynkkynen <ttynkkynen@nvidia.com>
List-Id: linux-pm@vger.kernel.org

The DFLL clocksource was missing from the list of possible parents for
the fast CPU cluster. Add it to the list.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
---
 drivers/clk/tegra/clk-tegra-super-gen4.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra-super-gen4.c b/drivers/clk/tegra/clk-tegra-super-gen4.c
index feb3201..f1f4410 100644
--- a/drivers/clk/tegra/clk-tegra-super-gen4.c
+++ b/drivers/clk/tegra/clk-tegra-super-gen4.c
@@ -44,7 +44,9 @@ static const char *sclk_parents[] = { "clk_m", "pll_c_out1", "pll_p_out4",
 
 static const char *cclk_g_parents[] = { "clk_m", "pll_c", "clk_32k", "pll_m",
 					"pll_p", "pll_p_out4", "unused",
-					"unused", "pll_x" };
+					"unused", "pll_x", "unused", "unused",
+					"unused", "unused", "unused", "unused",
+					"dfllCPU_out" };
 
 static const char *cclk_lp_parents[] = { "clk_m", "pll_c", "clk_32k", "pll_m",
 					 "pll_p", "pll_p_out4", "unused",
-- 
1.8.1.5
