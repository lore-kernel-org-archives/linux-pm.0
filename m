From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v5 02/15] clk: mux: Split out register accessors for reuse
Date: Tue, 19 Dec 2017 21:24:47 +0530
Message-ID: <1513698900-10638-3-git-send-email-sricharan@codeaurora.org>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1513698900-10638-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

We want to reuse the logic in clk-mux.c for other clock drivers
that don't use readl as register accessors. Fortunately, there
really isn't much to the mux code besides the table indirection
and quirk flags if you assume any bit shifting and masking has
been done already. Pull that logic out into reusable functions
that operate on an optional table and some flags so that other
drivers can use the same logic.

[Sricharan: Rebased for mainline]
Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/clk/clk-mux.c        | 75 +++++++++++++++++++++++++++-----------------
 include/linux/clk-provider.h |  9 ++++--
 2 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
index 39cabe1..22ebf99 100644
--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -26,35 +26,24 @@
  * parent - parent is adjustable through clk_set_parent
  */
 
-static u8 clk_mux_get_parent(struct clk_hw *hw)
+unsigned int clk_mux_get_parent(struct clk_hw *hw, unsigned int val,
+				unsigned int *table, unsigned long flags)
 {
-	struct clk_mux *mux = to_clk_mux(hw);
 	int num_parents = clk_hw_get_num_parents(hw);
-	u32 val;
-
-	/*
-	 * FIXME need a mux-specific flag to determine if val is bitwise or numeric
-	 * e.g. sys_clkin_ck's clksel field is 3 bits wide, but ranges from 0x1
-	 * to 0x7 (index starts at one)
-	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
-	 * val = 0x4 really means "bit 2, index starts at bit 0"
-	 */
-	val = clk_readl(mux->reg) >> mux->shift;
-	val &= mux->mask;
 
-	if (mux->table) {
+	if (table) {
 		int i;
 
 		for (i = 0; i < num_parents; i++)
-			if (mux->table[i] == val)
+			if (table[i] == val)
 				return i;
 		return -EINVAL;
 	}
 
-	if (val && (mux->flags & CLK_MUX_INDEX_BIT))
+	if (val && (flags & CLK_MUX_INDEX_BIT))
 		val = ffs(val) - 1;
 
-	if (val && (mux->flags & CLK_MUX_INDEX_ONE))
+	if (val && (flags & CLK_MUX_INDEX_ONE))
 		val--;
 
 	if (val >= num_parents)
@@ -62,23 +51,53 @@ static u8 clk_mux_get_parent(struct clk_hw *hw)
 
 	return val;
 }
+EXPORT_SYMBOL_GPL(clk_mux_get_parent);
 
-static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
+static u8 _clk_mux_get_parent(struct clk_hw *hw)
 {
 	struct clk_mux *mux = to_clk_mux(hw);
 	u32 val;
-	unsigned long flags = 0;
 
-	if (mux->table) {
-		index = mux->table[index];
+	/*
+	 * FIXME need a mux-specific flag to determine if val is bitwise or
+	 * numeric e.g. sys_clkin_ck's clksel field is 3 bits wide,
+	 * but ranges from 0x1 to 0x7 (index starts at one)
+	 * OTOH, pmd_trace_clk_mux_ck uses a separate bit for each clock, so
+	 * val = 0x4 really means "bit 2, index starts at bit 0"
+	 */
+	val = clk_readl(mux->reg) >> mux->shift;
+	val &= mux->mask;
+
+	return clk_mux_get_parent(hw, val, mux->table, mux->flags);
+}
+
+unsigned int clk_mux_reindex(u8 index, unsigned int *table,
+			     unsigned long flags)
+{
+	unsigned int val = index;
+
+	if (table) {
+		val = table[val];
 	} else {
-		if (mux->flags & CLK_MUX_INDEX_BIT)
-			index = 1 << index;
+		if (flags & CLK_MUX_INDEX_BIT)
+			val = 1 << index;
 
-		if (mux->flags & CLK_MUX_INDEX_ONE)
-			index++;
+		if (flags & CLK_MUX_INDEX_ONE)
+			val++;
 	}
 
+	return val;
+}
+EXPORT_SYMBOL_GPL(clk_mux_reindex);
+
+static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_mux *mux = to_clk_mux(hw);
+	u32 val;
+	unsigned long flags = 0;
+
+	index = clk_mux_reindex(index, mux->table, mux->flags);
+
 	if (mux->lock)
 		spin_lock_irqsave(mux->lock, flags);
 	else
@@ -102,14 +121,14 @@ static int clk_mux_set_parent(struct clk_hw *hw, u8 index)
 }
 
 const struct clk_ops clk_mux_ops = {
-	.get_parent = clk_mux_get_parent,
+	.get_parent = _clk_mux_get_parent,
 	.set_parent = clk_mux_set_parent,
 	.determine_rate = __clk_mux_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_mux_ops);
 
 const struct clk_ops clk_mux_ro_ops = {
-	.get_parent = clk_mux_get_parent,
+	.get_parent = _clk_mux_get_parent,
 };
 EXPORT_SYMBOL_GPL(clk_mux_ro_ops);
 
@@ -117,7 +136,7 @@ struct clk_hw *clk_hw_register_mux_table(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags,
 		void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock)
+		u8 clk_mux_flags, unsigned int *table, spinlock_t *lock)
 {
 	struct clk_mux *mux;
 	struct clk_hw *hw;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7c925e6..9578411 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -468,7 +468,7 @@ struct clk_hw *clk_hw_register_divider_table(struct device *dev,
 struct clk_mux {
 	struct clk_hw	hw;
 	void __iomem	*reg;
-	u32		*table;
+	unsigned int	*table;
 	u32		mask;
 	u8		shift;
 	u8		flags;
@@ -486,6 +486,11 @@ struct clk_mux {
 extern const struct clk_ops clk_mux_ops;
 extern const struct clk_ops clk_mux_ro_ops;
 
+unsigned int clk_mux_get_parent(struct clk_hw *hw, unsigned int val,
+				unsigned int *table, unsigned long flags);
+unsigned int clk_mux_reindex(u8 index, unsigned int *table,
+			     unsigned long flags);
+
 struct clk *clk_register_mux(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags,
@@ -506,7 +511,7 @@ struct clk_hw *clk_hw_register_mux_table(struct device *dev, const char *name,
 		const char * const *parent_names, u8 num_parents,
 		unsigned long flags,
 		void __iomem *reg, u8 shift, u32 mask,
-		u8 clk_mux_flags, u32 *table, spinlock_t *lock);
+		u8 clk_mux_flags, unsigned int *table, spinlock_t *lock);
 
 void clk_unregister_mux(struct clk *clk);
 void clk_hw_unregister_mux(struct clk_hw *hw);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
