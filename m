From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v9 2/5] clk: samsung: Add support for runtime PM
Date: Mon, 21 Aug 2017 10:05:00 +0200
Message-ID: <1503302703-13801-3-git-send-email-m.szyprowski@samsung.com>
References: <1503302703-13801-1-git-send-email-m.szyprowski@samsung.com>
        <CGME20170821080539eucas1p282557b6f1885f1714b08096ab3724c25@eucas1p2.samsung.com>
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <1503302703-13801-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds struct device pointer to samsung_clk_provider and forwarding it
to clk_register_* functions, so drivers can register clocks, which use runtime
pm feature.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/samsung/clk-pll.c |  2 +-
 drivers/clk/samsung/clk.c     | 12 ++++++------
 drivers/clk/samsung/clk.h     |  1 +
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 037c61484098..41ebb94d2855 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -1388,7 +1388,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	pll->lock_reg = base + pll_clk->lock_offset;
 	pll->con_reg = base + pll_clk->con_offset;
 
-	ret = clk_hw_register(NULL, &pll->hw);
+	ret = clk_hw_register(ctx->dev, &pll->hw);
 	if (ret) {
 		pr_err("%s: failed to register pll clock %s : %d\n",
 			__func__, pll_clk->name, ret);
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 7ce0fa86c5ff..aef97b091b50 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -134,7 +134,7 @@ void __init samsung_clk_register_fixed_rate(struct samsung_clk_provider *ctx,
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk_hw = clk_hw_register_fixed_rate(NULL, list->name,
+		clk_hw = clk_hw_register_fixed_rate(ctx->dev, list->name,
 			list->parent_name, list->flags, list->fixed_rate);
 		if (IS_ERR(clk_hw)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
@@ -163,7 +163,7 @@ void __init samsung_clk_register_fixed_factor(struct samsung_clk_provider *ctx,
 	unsigned int idx;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk_hw = clk_hw_register_fixed_factor(NULL, list->name,
+		clk_hw = clk_hw_register_fixed_factor(ctx->dev, list->name,
 			list->parent_name, list->flags, list->mult, list->div);
 		if (IS_ERR(clk_hw)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
@@ -184,7 +184,7 @@ void __init samsung_clk_register_mux(struct samsung_clk_provider *ctx,
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk_hw = clk_hw_register_mux(NULL, list->name,
+		clk_hw = clk_hw_register_mux(ctx->dev, list->name,
 			list->parent_names, list->num_parents, list->flags,
 			ctx->reg_base + list->offset,
 			list->shift, list->width, list->mux_flags, &ctx->lock);
@@ -217,13 +217,13 @@ void __init samsung_clk_register_div(struct samsung_clk_provider *ctx,
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
 		if (list->table)
-			clk_hw = clk_hw_register_divider_table(NULL,
+			clk_hw = clk_hw_register_divider_table(ctx->dev,
 				list->name, list->parent_name, list->flags,
 				ctx->reg_base + list->offset,
 				list->shift, list->width, list->div_flags,
 				list->table, &ctx->lock);
 		else
-			clk_hw = clk_hw_register_divider(NULL, list->name,
+			clk_hw = clk_hw_register_divider(ctx->dev, list->name,
 				list->parent_name, list->flags,
 				ctx->reg_base + list->offset, list->shift,
 				list->width, list->div_flags, &ctx->lock);
@@ -255,7 +255,7 @@ void __init samsung_clk_register_gate(struct samsung_clk_provider *ctx,
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk_hw = clk_hw_register_gate(NULL, list->name, list->parent_name,
+		clk_hw = clk_hw_register_gate(ctx->dev, list->name, list->parent_name,
 				list->flags, ctx->reg_base + list->offset,
 				list->bit_idx, list->gate_flags, &ctx->lock);
 		if (IS_ERR(clk_hw)) {
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index b8ca0dd3a38b..f0acae4f5d1b 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -24,6 +24,7 @@
  */
 struct samsung_clk_provider {
 	void __iomem *reg_base;
+	struct device *dev;
 	spinlock_t lock;
 	/* clk_data must be the last entry due to variable lenght 'hws' array */
 	struct clk_hw_onecell_data clk_data;
-- 
1.9.1

