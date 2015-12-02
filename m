From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 05/12] clk: samsung: exynos5800: fix cpu clock configuration
 data
Date: Wed,  2 Dec 2015 22:19:20 +0100
Message-ID: <1449091167-20758-6-git-send-email-ben@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kevin Hilman <khilman@linaro.org>, Mike Turquette <mturquette@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, Ben Gamari <ben@smart-cactus.org>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, b.zolnierkie@samsung.com, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Fix cpu clock configuration data for Exynos5800 (it uses
higher PCLK_DBG divider values than Exynos5420 and supports
additional frequencies).

Based on Hardkernel's kernel for ODROID-XU3 board.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
---
 drivers/clk/samsung/clk-exynos5420.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 2288052..aa44bb7 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1274,10 +1274,34 @@ static const struct exynos_cpuclk_cfg_data exynos5420_eglclk_d[] __initconst = {
 	{  0 },
 };
 
+static const struct exynos_cpuclk_cfg_data exynos5800_eglclk_d[] __initconst = {
+	{ 2000000, E5420_EGL_DIV0(3, 7, 7, 4), },
+	{ 1900000, E5420_EGL_DIV0(3, 7, 7, 4), },
+	{ 1800000, E5420_EGL_DIV0(3, 7, 7, 4), },
+	{ 1700000, E5420_EGL_DIV0(3, 7, 7, 3), },
+	{ 1600000, E5420_EGL_DIV0(3, 7, 7, 3), },
+	{ 1500000, E5420_EGL_DIV0(3, 7, 7, 3), },
+	{ 1400000, E5420_EGL_DIV0(3, 7, 7, 3), },
+	{ 1300000, E5420_EGL_DIV0(3, 7, 7, 2), },
+	{ 1200000, E5420_EGL_DIV0(3, 7, 7, 2), },
+	{ 1100000, E5420_EGL_DIV0(3, 7, 7, 2), },
+	{ 1000000, E5420_EGL_DIV0(3, 7, 6, 2), },
+	{  900000, E5420_EGL_DIV0(3, 7, 6, 2), },
+	{  800000, E5420_EGL_DIV0(3, 7, 5, 2), },
+	{  700000, E5420_EGL_DIV0(3, 7, 5, 2), },
+	{  600000, E5420_EGL_DIV0(3, 7, 4, 2), },
+	{  500000, E5420_EGL_DIV0(3, 7, 3, 2), },
+	{  400000, E5420_EGL_DIV0(3, 7, 3, 2), },
+	{  300000, E5420_EGL_DIV0(3, 7, 3, 2), },
+	{  200000, E5420_EGL_DIV0(3, 7, 3, 2), },
+	{  0 },
+};
+
 #define E5420_KFC_DIV(kpll, pclk, aclk)					\
 		((((kpll) << 24) | ((pclk) << 20) | ((aclk) << 4)))
 
 static const struct exynos_cpuclk_cfg_data exynos5420_kfcclk_d[] __initconst = {
+	{ 1400000, E5420_KFC_DIV(3, 5, 3), }, /* for Exynos5800 */
 	{ 1300000, E5420_KFC_DIV(3, 5, 2), },
 	{ 1200000, E5420_KFC_DIV(3, 5, 2), },
 	{ 1100000, E5420_KFC_DIV(3, 5, 2), },
@@ -1357,9 +1381,15 @@ static void __init exynos5x_clk_init(struct device_node *np,
 				ARRAY_SIZE(exynos5800_gate_clks));
 	}
 
-	exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
-		mout_cpu_p[0], mout_cpu_p[1], 0x200,
-		exynos5420_eglclk_d, ARRAY_SIZE(exynos5420_eglclk_d), 0);
+	if (soc == EXYNOS5420) {
+		exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
+			mout_cpu_p[0], mout_cpu_p[1], 0x200,
+			exynos5420_eglclk_d, ARRAY_SIZE(exynos5420_eglclk_d), 0);
+	} else {
+		exynos_register_cpu_clock(ctx, CLK_ARM_CLK, "armclk",
+			mout_cpu_p[0], mout_cpu_p[1], 0x200,
+			exynos5800_eglclk_d, ARRAY_SIZE(exynos5800_eglclk_d), 0);
+	}
 	exynos_register_cpu_clock(ctx, CLK_KFC_CLK, "kfcclk",
 		mout_kfc_p[0], mout_kfc_p[1], 0x28200,
 		exynos5420_kfcclk_d, ARRAY_SIZE(exynos5420_kfcclk_d), 0);
-- 
2.6.2
