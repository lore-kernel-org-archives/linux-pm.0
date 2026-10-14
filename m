Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5354B1468;
	Wed, 14 Oct 2026 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980450; cv=none; b=UtbmKdMJ0ujrL90TR3uV0mLo1U38jdImPMjacuT29ICUhjJU37yLyoWVjhrCxbVe9TwwPlMnX0U5i8Vlnv6VsZ9xNnntJCuFdZMA5YkZ5qP70gRWXW5ECaCw3nwXuTzfRk0+OGO9jP95R66JeRaP4fVTAXbxk+0AKTCEWWuof1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980450; c=relaxed/simple;
	bh=y7pYa4fpea4TGtDoNdbrLICC89GEh8Yfl2YkbjAlsH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RhwPiwtx8zs1k7oKYZb5DDzXj1/iqTOmdar9TZHByiWQG9pjeSLGI/huF8H4Havl3/ScUXzchK6RGmFQeoj/VEFmkicZQNcYLE8nF0WlrBdRIOjYOSSxYqX2FymYnYLo9a4MVEo5r16oeiHe7NsRQr3iu5IlOkKJNONb5+gOCM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNk2XMVQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNk2XMVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92F41F00898;
	Wed, 14 Oct 2026 12:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980448;
	bh=XCNH81hf+RhxgqzrDh+YsOvmxMtFk/zTJiWmyHTTNdU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iNk2XMVQES7A19xiN3HJ1409PnNF6KPwkNifvSVDKPZdo8E8s6NahiMe5gvrPmrLZ
	 Xnnh0zK+QsPxiZFeEBySNtBuIig2hUepl8ZSx6269W59oS0LoNotYxnvYV7z9nnLVJ
	 AhBBfVRGVDIIxD1/yRp6qrns0WWM2Y1qvtNtT2gwiQXdoA23bTomzHMLFNGSEQn/4k
	 NoVZ/AuPNBpitZKt1ueQijhEk+/6LF8IPAgmlpXsiVmS+RUKe+LyeBcelLKVvB9mSo
	 L6VW3LIPte1q5y5eFsoaGqH3yGrYF1e6SsoBl6VbdLiX2KLUrgUVj4xX2nBhSnFq7Y
	 0lSxRlYSwvaSQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:01 +0200
Subject: [PATCH RFC 01/16] clk: Propagate rate programming failures
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-1-3041b788e9f7@oss.qualcomm.com>
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
In-Reply-To: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mike Tipton <mike.tipton@oss.qualcomm.com>, 
 Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=12559;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=8Tlhzs468jclPseFI72HZZyXao4fQMLAFf6Z+iMY+tc=;
 b=rncLHgEQx203mVevIaIHoMfugVE3lNEIEUsb9KuuKIH65coMMDUWU4SIXLpsBGlDupB/cfsO7
 ABASiMCX2teAilWIqBo1UCLBd9wiDbL9zsRafGyj92DQAvrK+cUDQr7
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The clock rate-change walk ignores runtime PM, temporary prepare and
enable, and provider programming failures. clk_set_rate() can therefore
report success after a provider rejected the operation, while later
clocks in the affected tree continue to be programmed. Consumers can
then proceed with a configuration that was never successfully applied.

A failed parent switch must not leave the software topology pointing at
the rejected source or release the old parent's references. Likewise,
rate notifiers must not announce success before the whole walk succeeds,
or lose their ABORT notification when a PRE notifier vetoes the change.

Propagate errors and stop the walk at the first failure. Keep topology,
temporary references, and terminal notifications consistent with the
outcome.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/clk/clk.c      | 163 +++++++++++++++++++++++++++++++++++++------------
 drivers/clk/clk_test.c |  16 ++++-
 2 files changed, 138 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 4d2cc86bfbeb..95669775f8cd 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -84,6 +84,7 @@ struct clk_parent_map {
  *                     clk_core->rate every time the clock is reparented, and
  *                     when we're doing the orphan -> !orphan transition.
  * @new_rate:          New rate to be set during a rate change operation.
+ * @old_rate:          Rate before the current rate change operation.
  * @new_parent:        Pointer to new parent during parent change. This is also
  *                     used when a clk's rate is changed.
  * @new_child:         Pointer to new child during reparenting. This is also
@@ -130,6 +131,7 @@ struct clk_core {
 	unsigned long		rate;
 	unsigned long		req_rate;
 	unsigned long		new_rate;
+	unsigned long		old_rate;
 	struct clk_core		*new_parent;
 	struct clk_core		*new_child;
 	unsigned long		flags;
@@ -2163,11 +2165,14 @@ static void clk_reparent(struct clk_core *core, struct clk_core *new_parent)
 	core->parent = new_parent;
 }
 
-static struct clk_core *__clk_set_parent_before(struct clk_core *core,
-					   struct clk_core *parent)
+static int __clk_set_parent_before(struct clk_core *core,
+				   struct clk_core *parent,
+				   struct clk_core **old_parent)
 {
 	unsigned long flags;
-	struct clk_core *old_parent = core->parent;
+	int ret;
+
+	*old_parent = core->parent;
 
 	/*
 	 * 1. enable parents for CLK_OPS_PARENT_ENABLE clock
@@ -2191,14 +2196,24 @@ static struct clk_core *__clk_set_parent_before(struct clk_core *core,
 
 	/* enable old_parent & parent if CLK_OPS_PARENT_ENABLE is set */
 	if (core->flags & CLK_OPS_PARENT_ENABLE) {
-		clk_core_prepare_enable(old_parent);
-		clk_core_prepare_enable(parent);
+		ret = clk_core_prepare_enable(*old_parent);
+		if (ret)
+			return ret;
+
+		ret = clk_core_prepare_enable(parent);
+		if (ret)
+			goto disable_old_parent;
 	}
 
 	/* migrate prepare count if > 0 */
 	if (core->prepare_count) {
-		clk_core_prepare_enable(parent);
-		clk_core_enable_lock(core);
+		ret = clk_core_prepare_enable(parent);
+		if (ret)
+			goto disable_ops_parents;
+
+		ret = clk_core_enable_lock(core);
+		if (ret)
+			goto disable_migration_parent;
 	}
 
 	/* update the clk tree topology */
@@ -2206,7 +2221,18 @@ static struct clk_core *__clk_set_parent_before(struct clk_core *core,
 	clk_reparent(core, parent);
 	clk_enable_unlock(flags);
 
-	return old_parent;
+	return 0;
+
+disable_migration_parent:
+	clk_core_disable_unprepare(parent);
+disable_ops_parents:
+	if (core->flags & CLK_OPS_PARENT_ENABLE)
+		clk_core_disable_unprepare(parent);
+disable_old_parent:
+	if (core->flags & CLK_OPS_PARENT_ENABLE)
+		clk_core_disable_unprepare(*old_parent);
+
+	return ret;
 }
 
 static void __clk_set_parent_after(struct clk_core *core,
@@ -2232,11 +2258,12 @@ static void __clk_set_parent_after(struct clk_core *core,
 static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
 			    u8 p_index)
 {
-	unsigned long flags;
 	int ret = 0;
 	struct clk_core *old_parent;
 
-	old_parent = __clk_set_parent_before(core, parent);
+	ret = __clk_set_parent_before(core, parent, &old_parent);
+	if (ret)
+		return ret;
 
 	trace_clk_set_parent(core, parent);
 
@@ -2247,10 +2274,10 @@ static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
 	trace_clk_set_parent_complete(core, parent);
 
 	if (ret) {
-		flags = clk_enable_lock();
+		unsigned long flags = clk_enable_lock();
+
 		clk_reparent(core, old_parent);
 		clk_enable_unlock(flags);
-
 		__clk_set_parent_after(core, old_parent, parent);
 
 		return ret;
@@ -2312,6 +2339,7 @@ static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
 	struct clk_core *child;
 
 	core->new_rate = new_rate;
+	core->old_rate = core->rate;
 	core->new_parent = new_parent;
 	core->new_parent_index = p_index;
 	/* include clk in new parent's PRE_RATE_CHANGE notifications */
@@ -2420,13 +2448,20 @@ static struct clk_core *clk_propagate_rate_change(struct clk_core *core,
 						  unsigned long event)
 {
 	struct clk_core *child, *tmp_clk, *fail_clk = NULL;
+	unsigned long old_rate = core->rate;
+	unsigned long new_rate = core->new_rate;
 	int ret = NOTIFY_DONE;
 
-	if (core->rate == core->new_rate)
+	if (event != PRE_RATE_CHANGE)
+		old_rate = core->old_rate;
+	if (event == POST_RATE_CHANGE)
+		new_rate = core->rate;
+
+	if (old_rate == new_rate)
 		return NULL;
 
 	if (core->notifier_count) {
-		ret = __clk_notify(core, event, core->rate, core->new_rate);
+		ret = __clk_notify(core, event, old_rate, new_rate);
 		if (ret & NOTIFY_STOP_MASK)
 			fail_clk = core;
 	}
@@ -2454,17 +2489,17 @@ static struct clk_core *clk_propagate_rate_change(struct clk_core *core,
  * walk down a subtree and set the new rates notifying the rate
  * change on the way
  */
-static void clk_change_rate(struct clk_core *core)
+static int clk_change_rate(struct clk_core *core)
 {
 	struct clk_core *child;
 	struct hlist_node *tmp;
-	unsigned long old_rate;
 	unsigned long best_parent_rate = 0;
 	bool skip_set_rate = false;
-	struct clk_core *old_parent;
+	bool rate_ungated = false;
+	bool parent_enabled = false;
+	struct clk_core *old_parent = NULL;
 	struct clk_core *parent = NULL;
-
-	old_rate = core->rate;
+	int ret = 0;
 
 	if (core->new_parent) {
 		parent = core->new_parent;
@@ -2474,53 +2509,83 @@ static void clk_change_rate(struct clk_core *core)
 		best_parent_rate = core->parent->rate;
 	}
 
-	if (clk_pm_runtime_get(core))
-		return;
+	ret = clk_pm_runtime_get(core);
+	if (ret)
+		return ret;
 
 	if (core->flags & CLK_SET_RATE_UNGATE) {
-		clk_core_prepare(core);
-		clk_core_enable_lock(core);
+		ret = clk_core_prepare(core);
+		if (ret)
+			goto runtime_put;
+
+		ret = clk_core_enable_lock(core);
+		if (ret) {
+			clk_core_unprepare(core);
+			goto runtime_put;
+		}
+		rate_ungated = true;
 	}
 
 	if (core->new_parent && core->new_parent != core->parent) {
-		old_parent = __clk_set_parent_before(core, core->new_parent);
+		ret = __clk_set_parent_before(core, core->new_parent,
+					      &old_parent);
+		if (ret)
+			goto cleanup;
 		trace_clk_set_parent(core, core->new_parent);
 
 		if (core->ops->set_rate_and_parent) {
 			skip_set_rate = true;
-			core->ops->set_rate_and_parent(core->hw, core->new_rate,
+			ret = core->ops->set_rate_and_parent(core->hw, core->new_rate,
 					best_parent_rate,
 					core->new_parent_index);
 		} else if (core->ops->set_parent) {
-			core->ops->set_parent(core->hw, core->new_parent_index);
+			ret = core->ops->set_parent(core->hw,
+						    core->new_parent_index);
 		}
 
 		trace_clk_set_parent_complete(core, core->new_parent);
-		__clk_set_parent_after(core, core->new_parent, old_parent);
+		if (ret) {
+			unsigned long flags = clk_enable_lock();
+
+			clk_reparent(core, old_parent);
+			clk_enable_unlock(flags);
+			__clk_set_parent_after(core, old_parent,
+					       core->new_parent);
+			goto cleanup;
+		}
+
+		__clk_set_parent_after(core, core->new_parent,
+				       old_parent);
 	}
 
-	if (core->flags & CLK_OPS_PARENT_ENABLE)
-		clk_core_prepare_enable(parent);
+	if (core->flags & CLK_OPS_PARENT_ENABLE) {
+		ret = clk_core_prepare_enable(parent);
+		if (ret)
+			goto cleanup;
+		parent_enabled = true;
+	}
 
 	trace_clk_set_rate(core, core->new_rate);
 
 	if (!skip_set_rate && core->ops->set_rate)
-		core->ops->set_rate(core->hw, core->new_rate, best_parent_rate);
+		ret = core->ops->set_rate(core->hw, core->new_rate,
+					  best_parent_rate);
 
 	trace_clk_set_rate_complete(core, core->new_rate);
 
 	core->rate = clk_recalc(core, best_parent_rate);
 
-	if (core->flags & CLK_SET_RATE_UNGATE) {
+cleanup:
+	if (rate_ungated) {
 		clk_core_disable_lock(core);
 		clk_core_unprepare(core);
 	}
 
-	if (core->flags & CLK_OPS_PARENT_ENABLE)
+	if (parent_enabled)
 		clk_core_disable_unprepare(parent);
 
-	if (core->notifier_count && old_rate != core->rate)
-		__clk_notify(core, POST_RATE_CHANGE, old_rate, core->rate);
+	if (ret)
+		goto runtime_put;
 
 	if (core->flags & CLK_RECALC_NEW_RATES)
 		(void)clk_calc_new_rates(core, core->new_rate);
@@ -2533,14 +2598,22 @@ static void clk_change_rate(struct clk_core *core)
 		/* Skip children who will be reparented to another clock */
 		if (child->new_parent && child->new_parent != core)
 			continue;
-		clk_change_rate(child);
+		ret = clk_change_rate(child);
+		if (ret)
+			goto runtime_put;
 	}
 
 	/* handle the new child who might not be in core->children yet */
-	if (core->new_child)
-		clk_change_rate(core->new_child);
+	if (core->new_child) {
+		ret = clk_change_rate(core->new_child);
+		if (ret)
+			goto runtime_put;
+	}
 
+runtime_put:
 	clk_pm_runtime_put(core);
+
+	return ret;
 }
 
 static unsigned long clk_core_req_round_rate_nolock(struct clk_core *core,
@@ -2613,7 +2686,14 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	}
 
 	/* change the rates */
-	clk_change_rate(top);
+	ret = clk_change_rate(top);
+	if (ret) {
+		__clk_recalc_rates(top, true, 0);
+		clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
+		goto err;
+	}
+
+	clk_propagate_rate_change(top, POST_RATE_CHANGE);
 
 	core->req_rate = req_rate;
 err:
@@ -3958,8 +4038,11 @@ static void clk_core_reparent_orphans_nolock(void)
 		 */
 		if (parent) {
 			/* update the clk tree topology */
-			__clk_set_parent_before(orphan, parent);
-			__clk_set_parent_after(orphan, parent, NULL);
+			struct clk_core *old_parent;
+
+			if (__clk_set_parent_before(orphan, parent, &old_parent))
+				continue;
+			__clk_set_parent_after(orphan, parent, old_parent);
 			__clk_recalc_accuracies(orphan);
 			__clk_recalc_rates(orphan, true, 0);
 
diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index 0505ed357b20..8860e9a6e43e 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -29,6 +29,7 @@ static const struct clk_ops empty_clk_ops = { };
 struct clk_dummy_context {
 	struct clk_hw hw;
 	unsigned long rate;
+	int set_rate_error;
 	struct clk_spread_spectrum sscs;
 };
 
@@ -82,7 +83,7 @@ static int clk_dummy_set_rate(struct clk_hw *hw,
 		container_of(hw, struct clk_dummy_context, hw);
 
 	ctx->rate = rate;
-	return 0;
+	return ctx->set_rate_error;
 }
 
 static int clk_dummy_set_spread_spectrum(struct clk_hw *hw,
@@ -236,6 +237,18 @@ static void clk_test_exit(struct kunit *test)
 	clk_hw_unregister(&ctx->hw);
 }
 
+static void clk_set_rate_error_test(struct kunit *test)
+{
+	struct clk_dummy_context *ctx = test->priv;
+	struct clk *clk = clk_hw_get_clk_kunit(test, &ctx->hw, NULL);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, clk);
+	ctx->set_rate_error = -EIO;
+
+	KUNIT_EXPECT_EQ(test, -EIO, clk_set_rate(clk, DUMMY_CLOCK_RATE_1));
+	KUNIT_EXPECT_EQ(test, DUMMY_CLOCK_RATE_1, clk_get_rate(clk));
+}
+
 /*
  * Test that the actual rate matches what is returned by clk_get_rate()
  */
@@ -338,6 +351,7 @@ static struct kunit_case clk_test_cases[] = {
 	KUNIT_CASE(clk_test_get_rate),
 	KUNIT_CASE(clk_test_set_get_rate),
 	KUNIT_CASE(clk_test_set_set_get_rate),
+	KUNIT_CASE(clk_set_rate_error_test),
 	KUNIT_CASE(clk_test_round_set_get_rate),
 	{}
 };

-- 
2.56.0

