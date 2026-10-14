Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B14E8DFA;
	Wed, 14 Oct 2026 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980505; cv=none; b=D8E0SUmjHBABfFY/uHkNnYSbMxnKyIw8AVrTPUQqkHQehMWpKqME2sRSO3+6HhII8y+A6ViU2mTAz0TEyGGVXJGU3mGgOrTpzk9xNaXhOPSWr4gjeg0bRSB+Cgh68Bdh7nve0I2tJGaKW+I+yrjv5gXh62fFSRDXuUdHw9Qxwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980505; c=relaxed/simple;
	bh=+nf9tC5AgR3nCPzlMLz18sah9CVJczbSKdwUqIomgjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mSjHgYiFX7oCEBg3igO3zPo8ZK5rwWW+5ZLh0xIMM26p7fc6mLacYEe0SeQqDAj8o6g/d339B+I52BrTCaSy66H8iRGDTJAA3R5gNGnx69rXKZeJ4vHepHTURJD3dWdXA/EeKKQKYovNUEDiOQC1UacHPALdao2wNYH9eQWz17c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ib5tfQUu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ib5tfQUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA14F1F000FF;
	Wed, 14 Oct 2026 12:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980503;
	bh=K9ltzN0EN/qEIVI2QfE6fpOOoyhmBSRRroPnopidjCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ib5tfQUuJGUDfirCQe67/7G1JCXQGmvBW6x4foa7dIFLvwTwXdyFri4fNl39Nc/b4
	 p/c06lMY2XiTNsc0DRQT48hCI85ayIOdLvgz0+E4YLZJW45WTw5qwyvktiCSltEpDv
	 AGlQUHDfcRrJAWvsRPjZYfva2ZXpkmbA7MQod82RGofHOHtGHfPCjmBhH5AC/snLre
	 0/cVRNnFAFwXVIuOw8TTsxt7PTcTzXXJTRkn1Gna8l/XVb1BmtABxvog2NNDq09gjq
	 e5+9kgIG9gUHsNafeIxADEcFaAiEDpkUfLBSTe2ifwxVmKWo1RKyKphZtsIzeP2O31
	 NhB51KiBLMfXw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:08 +0200
Subject: [PATCH RFC 08/16] clk: qcom: dvfs: Add debugfs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-8-3041b788e9f7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=4880;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=7+T0WxmERD2DwM1qKNZoVsFMnsSJrDLgVHeWi1BDRw4=;
 b=xo3HWaoDYwOxfeqt9PIvRLFF3a6Ez5sV9rUbU8Xg3++jKFvrow/Eul0AdCxNfbRsoh6I76kkK
 YbKJ7Lk3+dSByEOThv40/kcduaYC5Y/G4TeMRNFxOBTu5hGwxh7gUCf
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

It's really useful to be able to analyze the current set of votes and
what holds them. Add debugfs to expose that information.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-dvfs.c | 63 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clk-dvfs.c b/drivers/clk/qcom/clk-dvfs.c
index e6490c4dab94..4af78eb0c78d 100644
--- a/drivers/clk/qcom/clk-dvfs.c
+++ b/drivers/clk/qcom/clk-dvfs.c
@@ -2,26 +2,32 @@
 
 #include <linux/device.h>
 #include <linux/device/bus.h>
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
 #include "clk-dvfs.h"
 #include "clk-regmap.h"
 
 struct qcom_clk_dvfs_vote {
 	struct list_head node;
+	const char *clock_name;
 	unsigned int level;
+	bool transition;
 };
 
 struct qcom_clk_dvfs_rail_voter {
 	struct device *dev;
 	struct device_link *link;
 	struct notifier_block nb;
+	const char *name;
 	/* Serializes the vote list and rail voter state. */
 	struct mutex lock;
 	struct list_head votes;
@@ -55,8 +61,12 @@ struct qcom_clk_dvfs {
 	size_t num_clocks;
 };
 
-static int qcom_clk_dvfs_find_level(const struct qcom_clk_dvfs_data *data,
-				unsigned long rate, unsigned int *level)
+static DEFINE_MUTEX(qcom_clk_dvfs_debugfs_lock);
+static struct dentry *qcom_clk_dvfs_debugfs_root;
+
+static int
+qcom_clk_dvfs_find_level(const struct qcom_clk_dvfs_data *data, unsigned long rate,
+			 unsigned int *level)
 {
 	for (size_t i = 0; i < data->num_rates; i++) {
 		/* PLL-derived rates are not Hz-precise. */
@@ -82,6 +92,36 @@ qcom_clk_dvfs_aggregate(struct qcom_clk_dvfs_rail_voter *rail_voter)
 	return max(level, rail_voter->safety_floor_level);
 }
 
+static int qcom_clk_dvfs_debugfs_show(struct seq_file *s, void *data)
+{
+	struct qcom_clk_dvfs *dvfs = dev_get_drvdata(s->private);
+
+	for (size_t i = 0; i < dvfs->num_rail_voters; i++) {
+		struct qcom_clk_dvfs_rail_voter *rail_voter = &dvfs->rail_voters[i];
+		struct qcom_clk_dvfs_vote *vote;
+
+		guard(mutex)(&rail_voter->lock);
+		seq_printf(s, "%s (aggregate=%u)\n", rail_voter->name,
+			   qcom_clk_dvfs_aggregate(rail_voter));
+		seq_printf(s, "  last_successful=%u safety_floor=%u must_contribute=%u\n",
+			   rail_voter->last_successful_vote_level,
+			   rail_voter->safety_floor_level, rail_voter->must_contribute);
+		list_for_each_entry(vote, &rail_voter->votes, node) {
+			int padding;
+
+			if (!vote->level)
+				continue;
+
+			padding = max(32 - (int)strlen(vote->clock_name), 0);
+			seq_printf(s, "  %s:%*s%s level=%u\n", vote->clock_name,
+				   padding, "",
+				   vote->transition ? "transition" : "prepared", vote->level);
+		}
+	}
+
+	return 0;
+}
+
 static int qcom_clk_dvfs_activate(struct qcom_clk_dvfs_rail_voter *rail_voter)
 {
 	int ret;
@@ -293,6 +333,8 @@ int qcom_clk_dvfs_resource_acquire(struct clk_hw *hw,
 	for (i = 0; i < dvfs_transition->num_votes; i++) {
 		unsigned int pd_index = clock->data->pd_indices[i];
 
+		dvfs_transition->votes[i].clock_name = clk_hw_get_name(hw);
+		dvfs_transition->votes[i].transition = true;
 		ret = qcom_clk_dvfs_add_vote(&clock->rail_voters[pd_index],
 						  &dvfs_transition->votes[i], level);
 		if (ret)
@@ -517,6 +559,7 @@ int qcom_clk_dvfs_register(struct device *dev,
 			ret = rail_voter->dev ? PTR_ERR(rail_voter->dev) : -ENODEV;
 			goto err_cleanup;
 		}
+		rail_voter->name = pd_to_genpd(rail_voter->dev->pm_domain)->name;
 
 		rail_voter->link = device_link_add(dev, rail_voter->dev,
 						     DL_FLAG_STATELESS);
@@ -555,6 +598,7 @@ int qcom_clk_dvfs_register(struct device *dev,
 
 			pd_index = data->pd_indices[j];
 			rail_voter = &dvfs->rail_voters[pd_index];
+			clock->votes[j].clock_name = clock->rclk->hw.init->name;
 			guard(mutex)(&rail_voter->lock);
 			list_add_tail(&clock->votes[j].node, &rail_voter->votes);
 		}
@@ -565,7 +609,20 @@ int qcom_clk_dvfs_register(struct device *dev,
 
 	dev_set_drvdata(dev, dvfs);
 
-	return devm_add_action_or_reset(dev, qcom_clk_dvfs_cleanup, dvfs);
+	ret = devm_add_action_or_reset(dev, qcom_clk_dvfs_cleanup, dvfs);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &qcom_clk_dvfs_debugfs_lock) {
+		if (!qcom_clk_dvfs_debugfs_root)
+			qcom_clk_dvfs_debugfs_root = debugfs_create_dir("qcom_clk_dvfs", NULL);
+
+		debugfs_create_devm_seqfile(dvfs->dev, dev_name(dvfs->dev),
+					    qcom_clk_dvfs_debugfs_root,
+					    qcom_clk_dvfs_debugfs_show);
+	}
+
+	return 0;
 
 err_cleanup:
 	qcom_clk_dvfs_cleanup(dvfs);

-- 
2.56.0

