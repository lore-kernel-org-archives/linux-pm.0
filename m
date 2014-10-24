From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: [PATCH v5 08/16] clk: tegra: Add the DFLL as a possible parent of the
 cclk_g clock
Date: Fri, 24 Oct 2014 17:39:15 +0300
Message-ID: <1414161563-16812-9-git-send-email-mikko.perttunen@kapsi.fi>
References: <1414161563-16812-1-git-send-email-mikko.perttunen@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1414161563-16812-1-git-send-email-mikko.perttunen@kapsi.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: swarren@wwwdotorg.org, thierry.reding@gmail.com, gnurou@gmail.com, pdeschrijver@nvidia.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: pgaikwad@nvidia.com, mturquette@linaro.org, vinceh@nvidia.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, tuomas.tynkkynen@iki.fi, Mikko Perttunen <mikko.perttunen@kapsi.fi>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, pwalmsley@nvidia.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>

The DFLL clocksource was missing from the list of possible parents for
the fast CPU cluster. Add it to the list.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Signed-off-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
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
2.1.0
