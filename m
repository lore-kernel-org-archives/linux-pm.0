From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 2/5] clock: samsung: add support for runtime pm
Date: Mon, 19 Sep 2016 12:55:22 +0200
Message-ID: <1474282525-30441-3-git-send-email-m.szyprowski@samsung.com>
References: <1474282525-30441-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20160919105549eucas1p1a2df94dc0ff48c7623949adbc5453bca@eucas1p1.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1474282525-30441-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds struct device pointer to samsung_clk_provider and forwarding it
to clk_register_* functions, so drivers can register clocks, which use runtime
pm feature. It also adds CLK_RUNTIME_PM flag to all clocks for which such
device have been provided.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clk/samsung/clk-pll.c |  4 ++--
 drivers/clk/samsung/clk.c     | 36 ++++++++++++++++++++++++------------
 drivers/clk/samsung/clk.h     |  1 +
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 48139bd510f1..fa929ddf3551 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -1174,7 +1174,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	}
 
 	init.name = pll_clk->name;
-	init.flags = pll_clk->flags;
+	init.flags = pll_clk->flags | (ctx->dev ? CLK_RUNTIME_PM : 0);
 	init.parent_names = &pll_clk->parent_name;
 	init.num_parents = 1;
 
@@ -1285,7 +1285,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	pll->lock_reg = base + pll_clk->lock_offset;
 	pll->con_reg = base + pll_clk->con_offset;
 
-	clk = clk_register(NULL, &pll->hw);
+	clk = clk_register(ctx->dev, &pll->hw);
 	if (IS_ERR(clk)) {
 		pr_err("%s: failed to register pll clock %s : %ld\n",
 			__func__, pll_clk->name, PTR_ERR(clk));
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index b7d87d6db9dc..762019893383 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -143,8 +143,11 @@ void __init samsung_clk_register_fixed_rate(struct samsung_clk_provider *ctx,
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk = clk_register_fixed_rate(NULL, list->name,
-			list->parent_name, list->flags, list->fixed_rate);
+		unsigned int pm_flags = ctx->dev ? CLK_RUNTIME_PM : 0;
+
+		clk = clk_register_fixed_rate(ctx->dev, list->name,
+			list->parent_name, list->flags | pm_flags,
+			list->fixed_rate);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
 				list->name);
@@ -172,8 +175,11 @@ void __init samsung_clk_register_fixed_factor(struct samsung_clk_provider *ctx,
 	unsigned int idx;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk = clk_register_fixed_factor(NULL, list->name,
-			list->parent_name, list->flags, list->mult, list->div);
+		unsigned int pm_flags = ctx->dev ? CLK_RUNTIME_PM : 0;
+
+		clk = clk_register_fixed_factor(ctx->dev, list->name,
+			list->parent_name, list->flags | pm_flags, list->mult,
+			list->div);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
 				list->name);
@@ -193,8 +199,10 @@ void __init samsung_clk_register_mux(struct samsung_clk_provider *ctx,
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk = clk_register_mux(NULL, list->name, list->parent_names,
-			list->num_parents, list->flags,
+		unsigned int pm_flags = ctx->dev ? CLK_RUNTIME_PM : 0;
+
+		clk = clk_register_mux(ctx->dev, list->name, list->parent_names,
+			list->num_parents, list->flags | pm_flags,
 			ctx->reg_base + list->offset,
 			list->shift, list->width, list->mux_flags, &ctx->lock);
 		if (IS_ERR(clk)) {
@@ -225,15 +233,17 @@ void __init samsung_clk_register_div(struct samsung_clk_provider *ctx,
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
+		unsigned int pm_flags = ctx->dev ? CLK_RUNTIME_PM : 0;
+
 		if (list->table)
-			clk = clk_register_divider_table(NULL, list->name,
-				list->parent_name, list->flags,
+			clk = clk_register_divider_table(ctx->dev, list->name,
+				list->parent_name, list->flags | pm_flags,
 				ctx->reg_base + list->offset,
 				list->shift, list->width, list->div_flags,
 				list->table, &ctx->lock);
 		else
-			clk = clk_register_divider(NULL, list->name,
-				list->parent_name, list->flags,
+			clk = clk_register_divider(ctx->dev, list->name,
+				list->parent_name, list->flags | pm_flags,
 				ctx->reg_base + list->offset, list->shift,
 				list->width, list->div_flags, &ctx->lock);
 		if (IS_ERR(clk)) {
@@ -264,8 +274,10 @@ void __init samsung_clk_register_gate(struct samsung_clk_provider *ctx,
 	unsigned int idx, ret;
 
 	for (idx = 0; idx < nr_clk; idx++, list++) {
-		clk = clk_register_gate(NULL, list->name, list->parent_name,
-				list->flags, ctx->reg_base + list->offset,
+		unsigned int pm_flags = ctx->dev ? CLK_RUNTIME_PM : 0;
+
+		clk = clk_register_gate(ctx->dev, list->name, list->parent_name,
+				list->flags | pm_flags, ctx->reg_base + list->offset,
 				list->bit_idx, list->gate_flags, &ctx->lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index da3bdebabf1e..9263d8a27c6b 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -26,6 +26,7 @@ struct clk;
  */
 struct samsung_clk_provider {
 	void __iomem *reg_base;
+	struct device *dev;
 	struct clk_onecell_data clk_data;
 	spinlock_t lock;
 };
-- 
1.9.1
