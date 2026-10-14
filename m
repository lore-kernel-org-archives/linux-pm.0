Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E74E4C24;
	Wed, 14 Oct 2026 12:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980497; cv=none; b=Hpl2tlKM88DatlZLXC8yZbPB29gkZ00yuA16agub14nLw5QTW8/FrMkEHfN0wQYQqQvaU1mO/HMywQYKRUJsoWCtUIL4669uVba8GMH0mOCWX67Ry3OMo1CbDeYyYvdC7DmkcAhJXXDqp5FF02mq2vfYehxMzm1Fw6l7ThM5qoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980497; c=relaxed/simple;
	bh=BWDUyt2nNh19ZTJn18FuVs9ycNLKNTS/WpqEODiysS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFqMbQDxpCyn6UnvX5q0tLb/P7q4VIsy0SEG4KCOukPpxYjb6Ruvon5G6NbgZx9oQ06Iy/ce9oe3WjbvpyvB2ziCX1JaUDRgmjrRs4Baq7nSmEJmydfknTNRB/MnhAt3sswPg0s9/9c94VWt9kzoPoGmCw0kn/8ktayOK6PH2h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb55MbYL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb55MbYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200FF1F00893;
	Wed, 14 Oct 2026 12:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791980495;
	bh=VlBHJGt+4SwHGJmItx0LvHqSHx6Wo2TiUQj3n8Ix8/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Tb55MbYLPQB9ISToG6ur3b0Smw4sC1CfDP4wigArgv0zmEd+hWH4Qyp/FRA/aU/j7
	 qAVd+VhKV7/8kztAcqn38d1T7J1IUqrxb69LSU8rTw3iJRPXJL8FpAPzSu2QM2iZZO
	 Yaaxlh2po2K7RSyX80paJpYktRdzeNb4Ux8XSATZzgIZFRhpztGNRx/1Do4J4Fg8Cr
	 gAh9kkMwjvGfm6G7SYfVyhkDktK7t7/wn63tE8QESpKmB7XI7rS8r5Qn+4M0bWHHvl
	 SB9vVLpaG1V5wDUjmiXEP8h47b1PZR4PoAtKvIKlJp6r+uD42aojcJETaDbEjmRowI
	 XyVn5JcoN5GCA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 Oct 2026 14:19:07 +0200
Subject: [PATCH RFC 07/16] clk: qcom: Add clock-owned GenPD DVFS
 aggregation
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-topic-qc_clk_dvfs-v1-7-3041b788e9f7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791980431; l=31200;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=o+l6USZpgS02Uiezhnw49saT8JMWNDbVwG47lMc5cA8=;
 b=1qA6855sBX+y3v6uiktWMaLMkbcPpLImhCrva7JdqFZ4xTIfwEVyboAacG+WTb8Nt1CFo7gYe
 ctkNXITHEgOCaCAVnfc7+zWF5XiClPhBs3tKDee+hkX5YoLfk79+uJb
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Clocks on Qualcomm SoCs need a minimum power rail performance state to
operate at a given frequency. We currently leave this to clock
consumers, so a driver has to know which power domains supply both the
clock and its parents. This ties knowledge of the clock tree to
individual consumers and doesn't protect other users that prepare or
change the same clock without making those power requests.

We can't simply pass each clock's request to a shared GenPD device
either. The device has one performance-state vote, so each request
replaces the previous one. If two clocks need different levels on the
same rail, lowering one clock's request can leave the other clock
running without the level it needs.

Move these requirements into the clock provider and aggregate the votes
per power domain. Keep the highest level needed by prepared clocks and
in-progress rate or parent changes so that one clock can't withdraw
another clock's requirement. Use separate virtual GenPD devices for
these votes and controller register access so their power requirements
can be managed independently.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/clk/qcom/Makefile     |   1 +
 drivers/clk/qcom/clk-dvfs.c   | 574 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-dvfs.h   |  40 +++
 drivers/clk/qcom/clk-rcg2.c   |  93 ++++++-
 drivers/clk/qcom/clk-regmap.h |   6 +
 drivers/clk/qcom/common.c     |  26 +-
 drivers/clk/qcom/common.h     |   3 +
 7 files changed, 725 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 6affb5073f26..b1330047fd58 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_COMMON_CLK_QCOM) += clk-qcom.o
 
 clk-qcom-y += common.o
+clk-qcom-y += clk-dvfs.o
 clk-qcom-y += clk-regmap.o
 clk-qcom-y += clk-alpha-pll.o
 clk-qcom-y += clk-pll.o
diff --git a/drivers/clk/qcom/clk-dvfs.c b/drivers/clk/qcom/clk-dvfs.c
new file mode 100644
index 000000000000..e6490c4dab94
--- /dev/null
+++ b/drivers/clk/qcom/clk-dvfs.c
@@ -0,0 +1,574 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/device.h>
+#include <linux/device/bus.h>
+#include <linux/err.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+#include "clk-dvfs.h"
+#include "clk-regmap.h"
+
+struct qcom_clk_dvfs_vote {
+	struct list_head node;
+	unsigned int level;
+};
+
+struct qcom_clk_dvfs_rail_voter {
+	struct device *dev;
+	struct device_link *link;
+	struct notifier_block nb;
+	/* Serializes the vote list and rail voter state. */
+	struct mutex lock;
+	struct list_head votes;
+	unsigned int last_successful_vote_level;
+	/*
+	 * Local conservative floor included in subsequent aggregation after a
+	 * failed request.
+	 */
+	unsigned int safety_floor_level;
+	bool active;
+	bool must_contribute;
+};
+
+struct qcom_clk_dvfs_clock {
+	struct qcom_clk_dvfs_rail_voter *rail_voters;
+	const struct qcom_clk_dvfs_data *data;
+	struct qcom_clk_dvfs_vote *votes;
+	struct clk_regmap *rclk;
+};
+
+struct qcom_clk_dvfs_transition {
+	struct qcom_clk_dvfs_vote *votes;
+	size_t num_votes;
+};
+
+struct qcom_clk_dvfs {
+	struct device *dev;
+	struct qcom_clk_dvfs_rail_voter *rail_voters;
+	struct qcom_clk_dvfs_clock *clocks;
+	size_t num_rail_voters;
+	size_t num_clocks;
+};
+
+static int qcom_clk_dvfs_find_level(const struct qcom_clk_dvfs_data *data,
+				unsigned long rate, unsigned int *level)
+{
+	for (size_t i = 0; i < data->num_rates; i++) {
+		/* PLL-derived rates are not Hz-precise. */
+		if (DIV_ROUND_CLOSEST(rate, 1000) <=
+		    DIV_ROUND_CLOSEST(data->rates[i].max_rate, 1000)) {
+			*level = data->rates[i].level;
+			return 0;
+		}
+	}
+
+	return -ERANGE;
+}
+
+static unsigned int
+qcom_clk_dvfs_aggregate(struct qcom_clk_dvfs_rail_voter *rail_voter)
+{
+	struct qcom_clk_dvfs_vote *vote;
+	unsigned int level = 0;
+
+	list_for_each_entry(vote, &rail_voter->votes, node)
+		level = max(level, vote->level);
+
+	return max(level, rail_voter->safety_floor_level);
+}
+
+static int qcom_clk_dvfs_activate(struct qcom_clk_dvfs_rail_voter *rail_voter)
+{
+	int ret;
+
+	if (!rail_voter->active) {
+		ret = pm_runtime_resume_and_get(rail_voter->dev);
+		if (ret)
+			return ret;
+		rail_voter->active = true;
+	}
+
+	WRITE_ONCE(rail_voter->must_contribute, true);
+
+	return 0;
+}
+
+static int qcom_clk_dvfs_apply(struct qcom_clk_dvfs_rail_voter *rail_voter,
+			       unsigned int level)
+{
+	int ret;
+
+	ret = qcom_clk_dvfs_activate(rail_voter);
+	if (ret)
+		return ret;
+	ret = dev_pm_genpd_set_performance_state(rail_voter->dev, level);
+	if (ret) {
+		rail_voter->safety_floor_level =
+			max(rail_voter->safety_floor_level,
+			    max(rail_voter->last_successful_vote_level, level));
+		return ret;
+	}
+
+	rail_voter->last_successful_vote_level = level;
+	rail_voter->safety_floor_level = 0;
+
+	return 0;
+}
+
+static int qcom_clk_dvfs_update(struct qcom_clk_dvfs_rail_voter *rail_voter)
+{
+	unsigned int level = qcom_clk_dvfs_aggregate(rail_voter);
+	int ret;
+
+	if (level)
+		return qcom_clk_dvfs_apply(rail_voter, level);
+
+	if (!rail_voter->active)
+		return 0;
+
+	ret = dev_pm_genpd_set_performance_state(rail_voter->dev, 0);
+	if (ret) {
+		rail_voter->safety_floor_level =
+			max(rail_voter->safety_floor_level,
+			    rail_voter->last_successful_vote_level);
+		return ret;
+	}
+
+	rail_voter->last_successful_vote_level = 0;
+	WRITE_ONCE(rail_voter->must_contribute, false);
+	rail_voter->active = false;
+	ret = pm_runtime_put_sync_suspend(rail_voter->dev);
+	if (ret < 0)
+		dev_warn(rail_voter->dev, "failed to suspend DVFS rail_voter: %d\n",
+			 ret);
+
+	return 0;
+}
+
+static int qcom_clk_dvfs_replace_vote(struct qcom_clk_dvfs_rail_voter *rail_voter,
+				 struct qcom_clk_dvfs_vote *vote,
+				 unsigned int level)
+{
+	unsigned int old_level = vote->level;
+	int ret;
+
+	guard(mutex)(&rail_voter->lock);
+	vote->level = level;
+	ret = qcom_clk_dvfs_update(rail_voter);
+	if (ret)
+		vote->level = old_level;
+
+	return ret;
+}
+
+static int qcom_clk_dvfs_add_vote(struct qcom_clk_dvfs_rail_voter *rail_voter,
+				   struct qcom_clk_dvfs_vote *vote,
+				   unsigned int level)
+{
+	int ret;
+
+	guard(mutex)(&rail_voter->lock);
+	vote->level = level;
+	list_add_tail(&vote->node, &rail_voter->votes);
+	ret = qcom_clk_dvfs_update(rail_voter);
+	if (ret) {
+		list_del_init(&vote->node);
+		vote->level = 0;
+	}
+
+	return ret;
+}
+
+static int qcom_clk_dvfs_remove_vote(struct qcom_clk_dvfs_rail_voter *rail_voter,
+				      struct qcom_clk_dvfs_vote *vote)
+{
+	unsigned int old_level = vote->level;
+	int ret;
+
+	guard(mutex)(&rail_voter->lock);
+	list_del_init(&vote->node);
+	vote->level = 0;
+	ret = qcom_clk_dvfs_update(rail_voter);
+	if (ret) {
+		/* The transaction record is freed; retain its error owner as a floor. */
+		rail_voter->safety_floor_level = max(rail_voter->safety_floor_level,
+						   old_level);
+		WRITE_ONCE(rail_voter->must_contribute, true);
+	}
+
+	return ret;
+}
+
+int qcom_clk_dvfs_prepare(struct clk_hw *hw)
+{
+	struct qcom_clk_dvfs_clock *clock = to_clk_regmap(hw)->dvfs;
+	unsigned long rate = clk_hw_get_rate(hw);
+	unsigned int level;
+	size_t i;
+	int ret;
+
+	if (!clock)
+		return 0;
+
+	ret = qcom_clk_dvfs_find_level(clock->data, rate, &level);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < clock->data->num_pd_indices; i++) {
+		unsigned int pd_index = clock->data->pd_indices[i];
+
+		ret = qcom_clk_dvfs_replace_vote(&clock->rail_voters[pd_index],
+						 &clock->votes[i], level);
+		if (ret)
+			goto unwind;
+	}
+
+	return 0;
+
+unwind:
+	while (i--) {
+		unsigned int pd_index = clock->data->pd_indices[i];
+
+		qcom_clk_dvfs_replace_vote(&clock->rail_voters[pd_index],
+					   &clock->votes[i], 0);
+	}
+
+	return ret;
+}
+
+void qcom_clk_dvfs_unprepare(struct clk_hw *hw)
+{
+	struct qcom_clk_dvfs_clock *clock = to_clk_regmap(hw)->dvfs;
+
+	if (!clock)
+		return;
+
+	for (size_t i = clock->data->num_pd_indices; i-- > 0;) {
+		unsigned int pd_index = clock->data->pd_indices[i];
+
+		if (qcom_clk_dvfs_replace_vote(&clock->rail_voters[pd_index],
+						  &clock->votes[i], 0))
+			dev_warn(clock->rail_voters[pd_index].dev,
+				 "failed to release %s DVFS requirement\n",
+				 clk_hw_get_name(hw));
+	}
+}
+
+int qcom_clk_dvfs_resource_acquire(struct clk_hw *hw,
+				 const struct clk_resource_transition *transition,
+				 void **cookie)
+{
+	struct qcom_clk_dvfs_clock *clock = to_clk_regmap(hw)->dvfs;
+	struct qcom_clk_dvfs_transition *dvfs_transition __free(kfree) = NULL;
+	struct qcom_clk_dvfs_vote *votes __free(kfree) = NULL;
+	unsigned int level;
+	size_t i;
+	int ret;
+
+	if (!clock) {
+		*cookie = NULL;
+		return 0;
+	}
+
+	dvfs_transition = kzalloc_obj(*dvfs_transition);
+	if (!dvfs_transition)
+		return -ENOMEM;
+
+	votes = kcalloc(clock->data->num_pd_indices, sizeof(*votes),
+			 GFP_KERNEL);
+	if (!votes)
+		return -ENOMEM;
+
+	dvfs_transition->votes = votes;
+	dvfs_transition->num_votes = clock->data->num_pd_indices;
+	ret = qcom_clk_dvfs_find_level(clock->data, transition->new_rate, &level);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < dvfs_transition->num_votes; i++) {
+		unsigned int pd_index = clock->data->pd_indices[i];
+
+		ret = qcom_clk_dvfs_add_vote(&clock->rail_voters[pd_index],
+						  &dvfs_transition->votes[i], level);
+		if (ret)
+			goto unwind;
+	}
+
+	dvfs_transition->votes = no_free_ptr(votes);
+	*cookie = no_free_ptr(dvfs_transition);
+
+	return 0;
+
+unwind:
+	while (i--) {
+		unsigned int pd_index = clock->data->pd_indices[i];
+
+		qcom_clk_dvfs_remove_vote(&clock->rail_voters[pd_index],
+					    &dvfs_transition->votes[i]);
+	}
+
+	return ret;
+}
+
+int qcom_clk_dvfs_resource_release(struct clk_hw *hw,
+				 const struct clk_resource_transition *transition,
+				 void *cookie,
+				 enum clk_resource_change_result result)
+{
+	struct qcom_clk_dvfs_transition *dvfs_transition = cookie;
+	struct qcom_clk_dvfs_clock *clock = to_clk_regmap(hw)->dvfs;
+	int first_error = 0;
+	unsigned int level;
+	int ret;
+
+	if (!clock)
+		return 0;
+	if (result == CLK_RESOURCE_COMPLETE) {
+		ret = qcom_clk_dvfs_find_level(clock->data, transition->actual_rate,
+					   &level);
+		if (ret)
+			first_error = ret;
+	}
+
+	for (size_t i = 0; i < dvfs_transition->num_votes; i++) {
+		unsigned int pd_index = clock->data->pd_indices[i];
+
+		if (!clock->votes[i].level)
+			continue;
+
+		if (result == CLK_RESOURCE_COMPLETE) {
+			ret = first_error;
+		} else if (result == CLK_RESOURCE_HW_CHANGED) {
+			level = max(clock->votes[i].level,
+				    dvfs_transition->votes[i].level);
+			ret = 0;
+		} else {
+			continue;
+		}
+
+		if (!ret) {
+			ret = qcom_clk_dvfs_replace_vote(&clock->rail_voters[pd_index],
+							 &clock->votes[i], level);
+		}
+		if (ret && !first_error)
+			first_error = ret;
+	}
+
+	for (size_t i = dvfs_transition->num_votes; i-- > 0;) {
+		unsigned int pd_index = clock->data->pd_indices[i];
+
+		ret = qcom_clk_dvfs_remove_vote(&clock->rail_voters[pd_index],
+						  &dvfs_transition->votes[i]);
+		if (ret && !first_error)
+			first_error = ret;
+	}
+
+	kfree(dvfs_transition->votes);
+	kfree(dvfs_transition);
+
+	return first_error;
+}
+
+static int qcom_clk_dvfs_notifier(struct notifier_block *nb,
+				  unsigned long event, void *data)
+{
+	struct qcom_clk_dvfs_rail_voter *rail_voter =
+		container_of(nb, struct qcom_clk_dvfs_rail_voter, nb);
+
+	if (event == GENPD_NOTIFY_PRE_OFF &&
+	    READ_ONCE(rail_voter->must_contribute))
+		return notifier_from_errno(-EBUSY);
+
+	return NOTIFY_OK;
+}
+
+static void qcom_clk_dvfs_cleanup(void *data)
+{
+	struct qcom_clk_dvfs *dvfs = data;
+
+	for (size_t i = 0; i < dvfs->num_clocks; i++)
+		dvfs->clocks[i].rclk->dvfs = NULL;
+
+	for (size_t i = dvfs->num_rail_voters; i-- > 0;) {
+		struct qcom_clk_dvfs_rail_voter *rail_voter = &dvfs->rail_voters[i];
+
+		if (rail_voter->active) {
+			dev_pm_genpd_set_performance_state(rail_voter->dev, 0);
+			WRITE_ONCE(rail_voter->must_contribute, false);
+			pm_runtime_put_sync_suspend(rail_voter->dev);
+		}
+		dev_pm_genpd_remove_notifier(rail_voter->dev);
+		device_link_del(rail_voter->link);
+		dev_pm_domain_detach(rail_voter->dev, true);
+		mutex_destroy(&rail_voter->lock);
+	}
+}
+
+static int
+qcom_clk_dvfs_validate_clock(size_t num_rail_voters,
+			     const struct qcom_clk_dvfs_data *data)
+{
+	if (!data->num_pd_indices || !data->pd_indices || !data->num_rates ||
+	    !data->rates)
+		return -EINVAL;
+
+	for (size_t i = 0; i < data->num_pd_indices; i++) {
+		if (data->pd_indices[i] >= num_rail_voters)
+			return -EINVAL;
+		for (size_t j = 0; j < i; j++)
+			if (data->pd_indices[j] == data->pd_indices[i])
+				return -EINVAL;
+	}
+
+	for (size_t i = 0; i < data->num_rates; i++) {
+		if (!data->rates[i].max_rate || !data->rates[i].level)
+			return -EINVAL;
+		if (i && data->rates[i - 1].max_rate >= data->rates[i].max_rate)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+struct device *qcom_clk_dvfs_get_rail_voter(struct device *dev,
+					     unsigned int pd_index)
+{
+	struct qcom_clk_dvfs *dvfs = dev_get_drvdata(dev);
+
+	if (!dvfs || pd_index >= dvfs->num_rail_voters)
+		return ERR_PTR(-EINVAL);
+
+	return dvfs->rail_voters[pd_index].dev;
+}
+
+int qcom_clk_dvfs_register(struct device *dev,
+			   size_t num_rail_voters,
+			   struct clk_regmap **clks,
+			   size_t num_clks)
+{
+	struct qcom_clk_dvfs *dvfs;
+	size_t num_dvfs_clocks = 0;
+	int ret;
+
+	if (!dev || !dev->of_node || !clks || !num_rail_voters)
+		return -EINVAL;
+
+	for (size_t i = 0; i < num_clks; i++) {
+		const struct clk_init_data *init;
+		bool has_dvfs_data;
+		bool has_dvfs_resource_ops;
+
+		if (!clks[i])
+			continue;
+
+		init = clks[i]->hw.init;
+		has_dvfs_data = !!clks[i]->dvfs_data;
+		has_dvfs_resource_ops = init && init->ops &&
+			init->ops->resource_acquire == qcom_clk_dvfs_resource_acquire &&
+			init->ops->resource_release == qcom_clk_dvfs_resource_release;
+		if (has_dvfs_data && !has_dvfs_resource_ops) {
+			dev_warn(dev, "%s has DVFS data without matching DVFS resource ops\n",
+				 init ? init->name : "an uninitialized clock");
+			return -EINVAL;
+		}
+		if (!has_dvfs_data)
+			continue;
+		if (qcom_clk_dvfs_validate_clock(num_rail_voters,
+						  clks[i]->dvfs_data))
+			return -EINVAL;
+		num_dvfs_clocks++;
+	}
+	if (!num_dvfs_clocks)
+		return -EINVAL;
+
+	dvfs = devm_kzalloc(dev, sizeof(*dvfs), GFP_KERNEL);
+	if (!dvfs)
+		return -ENOMEM;
+	dvfs->dev = dev;
+	dvfs->rail_voters = devm_kcalloc(dev, num_rail_voters,
+					  sizeof(*dvfs->rail_voters), GFP_KERNEL);
+	dvfs->clocks = devm_kcalloc(dev, num_dvfs_clocks, sizeof(*dvfs->clocks),
+				  GFP_KERNEL);
+	if (!dvfs->rail_voters || !dvfs->clocks)
+		return -ENOMEM;
+
+	for (size_t i = 0, j = 0; i < num_clks; i++) {
+		struct clk_regmap *rclk = clks[i];
+
+		if (!rclk || !rclk->dvfs_data)
+			continue;
+
+		dvfs->clocks[j].rclk = rclk;
+		j++;
+	}
+
+	for (size_t i = 0; i < num_rail_voters; i++) {
+		struct qcom_clk_dvfs_rail_voter *rail_voter = &dvfs->rail_voters[i];
+
+		mutex_init(&rail_voter->lock);
+		INIT_LIST_HEAD(&rail_voter->votes);
+		rail_voter->dev = genpd_dev_pm_attach_by_id_suffix(dev, i, "dvfs");
+		if (IS_ERR_OR_NULL(rail_voter->dev)) {
+			ret = rail_voter->dev ? PTR_ERR(rail_voter->dev) : -ENODEV;
+			goto err_cleanup;
+		}
+
+		rail_voter->link = device_link_add(dev, rail_voter->dev,
+						     DL_FLAG_STATELESS);
+		if (!rail_voter->link) {
+			ret = -EINVAL;
+			dev_pm_domain_detach(rail_voter->dev, true);
+			goto err_cleanup;
+		}
+
+		rail_voter->nb.notifier_call = qcom_clk_dvfs_notifier;
+		ret = dev_pm_genpd_add_notifier(rail_voter->dev, &rail_voter->nb);
+		if (ret) {
+			device_link_del(rail_voter->link);
+			dev_pm_domain_detach(rail_voter->dev, true);
+			goto err_cleanup;
+		}
+		dvfs->num_rail_voters++;
+	}
+
+	for (size_t i = 0; i < num_dvfs_clocks; i++) {
+		struct qcom_clk_dvfs_clock *clock = &dvfs->clocks[i];
+		const struct qcom_clk_dvfs_data *data = clock->rclk->dvfs_data;
+
+		clock->votes = devm_kcalloc(dev, data->num_pd_indices,
+					  sizeof(*clock->votes), GFP_KERNEL);
+		if (!clock->votes) {
+			ret = -ENOMEM;
+			goto err_cleanup;
+		}
+
+		clock->data = data;
+		clock->rail_voters = dvfs->rail_voters;
+		for (size_t j = 0; j < data->num_pd_indices; j++) {
+			struct qcom_clk_dvfs_rail_voter *rail_voter;
+			unsigned int pd_index;
+
+			pd_index = data->pd_indices[j];
+			rail_voter = &dvfs->rail_voters[pd_index];
+			guard(mutex)(&rail_voter->lock);
+			list_add_tail(&clock->votes[j].node, &rail_voter->votes);
+		}
+
+		clock->rclk->dvfs = clock;
+		dvfs->num_clocks++;
+	}
+
+	dev_set_drvdata(dev, dvfs);
+
+	return devm_add_action_or_reset(dev, qcom_clk_dvfs_cleanup, dvfs);
+
+err_cleanup:
+	qcom_clk_dvfs_cleanup(dvfs);
+
+	return ret;
+}
diff --git a/drivers/clk/qcom/clk-dvfs.h b/drivers/clk/qcom/clk-dvfs.h
new file mode 100644
index 000000000000..48c7487614c1
--- /dev/null
+++ b/drivers/clk/qcom/clk-dvfs.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __QCOM_CLK_DVFS_H__
+#define __QCOM_CLK_DVFS_H__
+
+#include <linux/clk-provider.h>
+#include <linux/types.h>
+
+struct device;
+struct clk_regmap;
+
+struct qcom_clk_dvfs_rate {
+	unsigned long max_rate;
+	unsigned int level;
+};
+
+struct qcom_clk_dvfs_data {
+	const unsigned int *pd_indices;
+	size_t num_pd_indices;
+	const struct qcom_clk_dvfs_rate *rates;
+	size_t num_rates;
+};
+
+int qcom_clk_dvfs_resource_acquire(struct clk_hw *hw,
+				 const struct clk_resource_transition *transition,
+				 void **cookie);
+int qcom_clk_dvfs_resource_release(struct clk_hw *hw,
+				 const struct clk_resource_transition *transition,
+				 void *cookie,
+				 enum clk_resource_change_result result);
+int qcom_clk_dvfs_prepare(struct clk_hw *hw);
+void qcom_clk_dvfs_unprepare(struct clk_hw *hw);
+
+int qcom_clk_dvfs_register(struct device *dev,
+			   size_t num_rail_voters,
+			   struct clk_regmap **clks,
+			   size_t num_clks);
+struct device *qcom_clk_dvfs_get_rail_voter(struct device *dev,
+					     unsigned int pd_index);
+
+#endif
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index c44c51d860e1..0b13cf4ee01f 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -21,6 +21,7 @@
 #include <asm/div64.h>
 
 #include "clk-rcg.h"
+#include "clk-dvfs.h"
 #include "common.h"
 
 #define CMD_REG			0x0
@@ -799,6 +800,10 @@ static int clk_rcg2_set_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
 }
 
 const struct clk_ops clk_rcg2_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.is_enabled = clk_rcg2_is_enabled,
 	.get_parent = clk_rcg2_get_parent,
 	.set_parent = clk_rcg2_set_parent,
@@ -812,6 +817,10 @@ const struct clk_ops clk_rcg2_ops = {
 EXPORT_SYMBOL_GPL(clk_rcg2_ops);
 
 const struct clk_ops clk_rcg2_gp_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.is_enabled = clk_rcg2_is_enabled,
 	.get_parent = clk_rcg2_get_parent,
 	.set_parent = clk_rcg2_set_parent,
@@ -824,6 +833,10 @@ const struct clk_ops clk_rcg2_gp_ops = {
 EXPORT_SYMBOL_GPL(clk_rcg2_gp_ops);
 
 const struct clk_ops clk_rcg2_floor_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.is_enabled = clk_rcg2_is_enabled,
 	.get_parent = clk_rcg2_get_parent,
 	.set_parent = clk_rcg2_set_parent,
@@ -837,6 +850,10 @@ const struct clk_ops clk_rcg2_floor_ops = {
 EXPORT_SYMBOL_GPL(clk_rcg2_floor_ops);
 
 const struct clk_ops clk_rcg2_fm_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.is_enabled = clk_rcg2_is_enabled,
 	.get_parent = clk_rcg2_get_parent,
 	.set_parent = clk_rcg2_set_parent,
@@ -850,6 +867,10 @@ const struct clk_ops clk_rcg2_fm_ops = {
 EXPORT_SYMBOL_GPL(clk_rcg2_fm_ops);
 
 const struct clk_ops clk_rcg2_mux_closest_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.determine_rate = __clk_mux_determine_rate_closest,
 	.get_parent = clk_rcg2_get_parent,
 	.set_parent = clk_rcg2_set_parent,
@@ -973,6 +994,10 @@ static int clk_edp_pixel_determine_rate(struct clk_hw *hw,
 }
 
 const struct clk_ops clk_edp_pixel_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.is_enabled = clk_rcg2_is_enabled,
 	.get_parent = clk_rcg2_get_parent,
 	.set_parent = clk_rcg2_set_parent,
@@ -1031,6 +1056,10 @@ static int clk_byte_set_rate_and_parent(struct clk_hw *hw,
 }
 
 const struct clk_ops clk_byte_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.is_enabled = clk_rcg2_is_enabled,
 	.get_parent = clk_rcg2_get_parent,
 	.set_parent = clk_rcg2_set_parent,
@@ -1101,6 +1130,10 @@ static int clk_byte2_set_rate_and_parent(struct clk_hw *hw,
 }
 
 const struct clk_ops clk_byte2_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.is_enabled = clk_rcg2_is_enabled,
 	.get_parent = clk_rcg2_get_parent,
 	.set_parent = clk_rcg2_set_parent,
@@ -1194,6 +1227,10 @@ static int clk_pixel_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
 }
 
 const struct clk_ops clk_pixel_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.is_enabled = clk_rcg2_is_enabled,
 	.get_parent = clk_rcg2_get_parent,
 	.set_parent = clk_rcg2_set_parent,
@@ -1309,6 +1346,10 @@ static int clk_gfx3d_set_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 const struct clk_ops clk_gfx3d_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.is_enabled = clk_rcg2_is_enabled,
 	.get_parent = clk_rcg2_get_parent,
 	.set_parent = clk_rcg2_set_parent,
@@ -1357,19 +1398,21 @@ static int
 clk_rcg2_shared_force_enable_clear(struct clk_hw *hw, const struct freq_tbl *f)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
-	int ret;
+	int ret, cleanup_ret;
 
 	ret = clk_rcg2_set_force_enable(hw);
 	if (ret)
-		return ret;
+		goto clear_force_enable;
 
 	ret = clk_rcg2_configure(rcg, f);
-	if (ret) {
-		clk_rcg2_clear_force_enable(hw);
-		return ret;
-	}
 
-	return clk_rcg2_clear_force_enable(hw);
+clear_force_enable:
+	cleanup_ret = clk_rcg2_clear_force_enable(hw);
+	if (cleanup_ret)
+		pr_warn("%s: failed to clear force-enable: %d\n",
+			clk_hw_get_name(hw), cleanup_ret);
+
+	return ret ?: cleanup_ret;
 }
 
 static int __clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1428,7 +1471,7 @@ static int clk_rcg2_shared_set_floor_rate_and_parent(struct clk_hw *hw,
 static int clk_rcg2_shared_enable(struct clk_hw *hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
-	int ret;
+	int ret, cleanup_ret;
 
 	/*
 	 * Set the update bit because required configuration has already
@@ -1436,18 +1479,22 @@ static int clk_rcg2_shared_enable(struct clk_hw *hw)
 	 */
 	ret = clk_rcg2_set_force_enable(hw);
 	if (ret)
-		return ret;
+		goto clear_force_enable;
 
 	/* Write back the stored configuration corresponding to current rate */
 	ret = regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, rcg->parked_cfg);
 	if (ret)
-		return ret;
+		goto clear_force_enable;
 
 	ret = update_config(rcg);
-	if (ret)
-		return ret;
 
-	return clk_rcg2_clear_force_enable(hw);
+clear_force_enable:
+	cleanup_ret = clk_rcg2_clear_force_enable(hw);
+	if (cleanup_ret)
+		pr_warn("%s: failed to clear force-enable: %d\n",
+			clk_hw_get_name(hw), cleanup_ret);
+
+	return ret ?: cleanup_ret;
 }
 
 static void clk_rcg2_shared_disable(struct clk_hw *hw)
@@ -1548,6 +1595,10 @@ static int clk_rcg2_shared_init(struct clk_hw *hw)
 }
 
 const struct clk_ops clk_rcg2_shared_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.init = clk_rcg2_shared_init,
 	.enable = clk_rcg2_shared_enable,
 	.disable = clk_rcg2_shared_disable,
@@ -1573,7 +1624,11 @@ static int clk_rcg2_shared_no_init_park(struct clk_hw *hw)
 }
 
 const struct clk_ops clk_rcg2_shared_floor_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
 	.init = clk_rcg2_shared_no_init_park,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.enable = clk_rcg2_shared_enable,
 	.disable = clk_rcg2_shared_disable,
 	.get_parent = clk_rcg2_shared_get_parent,
@@ -1590,6 +1645,10 @@ EXPORT_SYMBOL_GPL(clk_rcg2_shared_floor_ops);
  * unchanged at registration time.
  */
 const struct clk_ops clk_rcg2_shared_no_init_park_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.init = clk_rcg2_shared_no_init_park,
 	.enable = clk_rcg2_shared_enable,
 	.disable = clk_rcg2_shared_disable,
@@ -1734,6 +1793,10 @@ clk_rcg2_dfs_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 }
 
 static const struct clk_ops clk_rcg2_dfs_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.is_enabled = clk_rcg2_is_enabled,
 	.get_parent = clk_rcg2_get_parent,
 	.determine_rate = clk_rcg2_dfs_determine_rate,
@@ -1855,6 +1918,10 @@ static int clk_rcg2_dp_determine_rate(struct clk_hw *hw,
 }
 
 const struct clk_ops clk_dp_ops = {
+	.resource_acquire = qcom_clk_dvfs_resource_acquire,
+	.resource_release = qcom_clk_dvfs_resource_release,
+	.prepare = qcom_clk_dvfs_prepare,
+	.unprepare = qcom_clk_dvfs_unprepare,
 	.is_enabled = clk_rcg2_is_enabled,
 	.get_parent = clk_rcg2_get_parent,
 	.set_parent = clk_rcg2_set_parent,
diff --git a/drivers/clk/qcom/clk-regmap.h b/drivers/clk/qcom/clk-regmap.h
index 14ec659a3a77..7ce38bbe12fd 100644
--- a/drivers/clk/qcom/clk-regmap.h
+++ b/drivers/clk/qcom/clk-regmap.h
@@ -7,6 +7,8 @@
 #include <linux/clk-provider.h>
 
 struct regmap;
+struct qcom_clk_dvfs_clock;
+struct qcom_clk_dvfs_data;
 
 /**
  * struct clk_regmap - regmap supporting clock
@@ -16,6 +18,8 @@ struct regmap;
  * @enable_mask: mask when using regmap enable/disable ops
  * @enable_is_inverted: flag to indicate set enable_mask bits to disable
  *                      when using clock_enable_regmap and friends APIs.
+ * @dvfs_data: immutable clock-owned DVFS requirements
+ * @dvfs: clock-owned DVFS runtime state
  */
 struct clk_regmap {
 	struct clk_hw hw;
@@ -23,6 +27,8 @@ struct clk_regmap {
 	unsigned int enable_reg;
 	unsigned int enable_mask;
 	bool enable_is_inverted;
+	const struct qcom_clk_dvfs_data *dvfs_data;
+	struct qcom_clk_dvfs_clock *dvfs;
 };
 
 static inline struct clk_regmap *to_clk_regmap(struct clk_hw *hw)
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 08fd62ac780d..01c00c2568b2 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -16,6 +16,7 @@
 #include "common.h"
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
+#include "clk-dvfs.h"
 #include "clk-rcg.h"
 #include "clk-regmap.h"
 #include "reset.h"
@@ -25,7 +26,6 @@ struct qcom_cc {
 	struct qcom_reset_controller reset;
 	struct clk_regmap **rclks;
 	size_t num_rclks;
-	struct dev_pm_domain_list *pd_list;
 };
 
 const
@@ -332,14 +332,31 @@ int qcom_cc_really_probe(struct device *dev,
 	struct clk_regmap **rclks = desc->clks;
 	size_t num_clk_hws = desc->num_clk_hws;
 	struct clk_hw **clk_hws = desc->clk_hws;
+	struct dev_pm_domain_list *pd_list;
+	const struct dev_pm_domain_attach_data pd_data = {
+		.pd_indices = desc->pd_indices,
+		.num_pd_indices = desc->num_pd_indices,
+		.pd_suffix = "access",
+	};
 
 	cc = devm_kzalloc(dev, sizeof(*cc), GFP_KERNEL);
 	if (!cc)
 		return -ENOMEM;
 
-	ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
-	if (ret < 0 && ret != -EEXIST)
-		return ret;
+	if (desc->num_dvfs_rail_voters) {
+		ret = qcom_clk_dvfs_register(dev, desc->num_dvfs_rail_voters, rclks,
+					     num_clks);
+		if (ret)
+			return ret;
+	}
+
+	if (!desc->num_dvfs_rail_voters || desc->num_pd_indices) {
+		ret = devm_pm_domain_attach_list(dev,
+				desc->num_pd_indices ? &pd_data : NULL,
+				&pd_list);
+		if (ret < 0 && ret != -EEXIST)
+			return ret;
+	}
 
 	if (desc->use_rpm) {
 		ret = devm_pm_runtime_enable(dev);
@@ -380,7 +397,6 @@ int qcom_cc_really_probe(struct device *dev,
 		scd->dev = dev;
 		scd->scs = desc->gdscs;
 		scd->num = desc->num_gdscs;
-		scd->pd_list = cc->pd_list;
 		ret = gdsc_register(scd, &reset->rcdev, regmap);
 		if (ret)
 			goto put_rpm;
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 6f2406f8839e..769b3f5c1486 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -49,6 +49,9 @@ struct qcom_cc_desc {
 	size_t num_icc_hws;
 	unsigned int icc_first_node_id;
 	bool use_rpm;
+	const unsigned int *pd_indices;
+	size_t num_pd_indices;
+	size_t num_dvfs_rail_voters;
 	const struct qcom_cc_driver_data *driver_data;
 };
 

-- 
2.56.0

