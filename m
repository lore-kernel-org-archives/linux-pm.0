From: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v7 3/8] clk: rockchip: rk3399: add ddrc clock support
Date: Mon, 22 Aug 2016 11:36:19 +0800
Message-ID: <1471836984-6316-4-git-send-email-hl@rock-chips.com>
References: <1471836984-6316-1-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1471836984-6316-1-git-send-email-hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, typ-TNX95d0MmH7DzftRWevZcw@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

add ddrc clock setting, so we can do ddr frequency
scaling on rk3399 platform in future.

Signed-off-by: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---
Changes in v7:
- change SCLK_DDRC name from clk_ddrc to sclk_ddrc

Changes in v6:
- None

Changes in v5:
- fit for the ddr type

Changes in v4:
- None

Changes in v3:
- None

Changes in v2:
- remove clk_ddrc_dpll_src from critical clock list

Changes in v1:
- remove ddrc source CLK_IGNORE_UNUSED flag
- move clk_ddrc and clk_ddrc_dpll_src to critical

 drivers/clk/rockchip/clk-rk3399.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index e445cd6..134bd18 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -120,6 +120,10 @@ PNAME(mux_armclkb_p)				= { "clk_core_b_lpll_src",
 						    "clk_core_b_bpll_src",
 						    "clk_core_b_dpll_src",
 						    "clk_core_b_gpll_src" };
+PNAME(mux_ddrclk_p)				= { "clk_ddrc_lpll_src",
+						    "clk_ddrc_bpll_src",
+						    "clk_ddrc_dpll_src",
+						    "clk_ddrc_gpll_src" };
 PNAME(mux_aclk_cci_p)				= { "cpll_aclk_cci_src",
 						    "gpll_aclk_cci_src",
 						    "npll_aclk_cci_src",
@@ -1379,6 +1383,18 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 	COMPOSITE_NOMUX(0, "clk_test", "clk_test_pre", CLK_IGNORE_UNUSED,
 			RK3368_CLKSEL_CON(58), 0, 5, DFLAGS,
 			RK3368_CLKGATE_CON(13), 11, GFLAGS),
+
+	/* ddrc */
+	GATE(0, "clk_ddrc_lpll_src", "lpll", 0, RK3399_CLKGATE_CON(3),
+	     0, GFLAGS),
+	GATE(0, "clk_ddrc_bpll_src", "bpll", 0, RK3399_CLKGATE_CON(3),
+	     1, GFLAGS),
+	GATE(0, "clk_ddrc_dpll_src", "dpll", 0, RK3399_CLKGATE_CON(3),
+	     2, GFLAGS),
+	GATE(0, "clk_ddrc_gpll_src", "gpll", 0, RK3399_CLKGATE_CON(3),
+	     3, GFLAGS),
+	COMPOSITE_DDRCLK(SCLK_DDRC, "sclk_ddrc", mux_ddrclk_p, 0,
+		       RK3399_CLKSEL_CON(6), 4, 2, 0, 0, ROCKCHIP_DDRCLK_SIP),
 };
 
 static struct rockchip_clk_branch rk3399_clk_pmu_branches[] __initdata = {
@@ -1493,6 +1509,9 @@ static const char *const rk3399_cru_critical_clocks[] __initconst = {
 	"gpll_aclk_perilp0_src",
 	"gpll_aclk_perihp_src",
 	"aclk_vio_noc",
+
+	/* ddrc */
+	"sclk_ddrc"
 };
 
 static const char *const rk3399_pmucru_critical_clocks[] __initconst = {
-- 
2.6.6
