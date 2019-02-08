From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v1 2/2] interconnect: qcom: Add tagging and wake/sleep support for sdm845
Date: Fri,  8 Feb 2019 19:21:52 +0200
Message-ID: <20190208172152.1807-3-georgi.djakov@linaro.org>
References: <20190208172152.1807-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208172152.1807-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: daidavid1@codeaurora.org, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, evgreen@chromium.org, dianders@chromium.org, seansw@qti.qualcomm.com, mturquette@baylibre.com, abailon@baylibre.com, thierry.reding@gmail.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, henryc.chen@mediatek.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

From: David Dai <daidavid1@codeaurora.org>

Add support for wake and sleep commands by using a tag to indicate
whether or not the aggregate and set requests are active only or
dual context for a particular path.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 101 +++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 26 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index fb526004c82e..13499f681160 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -65,6 +65,12 @@ struct bcm_db {
 #define SDM845_MAX_BCMS		30
 #define SDM845_MAX_BCM_PER_NODE	2
 #define SDM845_MAX_VCD		10
+#define SDM845_MAX_CTX		2
+#define SDM845_EE_STATE		2
+#define EE_STATE_WAKE		0
+#define EE_STATE_SLEEP		1
+#define AO_CTX			0
+#define DUAL_CTX		1
 
 /**
  * struct qcom_icc_node - Qualcomm specific interconnect nodes
@@ -86,8 +92,8 @@ struct qcom_icc_node {
 	u16 num_links;
 	u16 channels;
 	u16 buswidth;
-	u64 sum_avg;
-	u64 max_peak;
+	u64 sum_avg[SDM845_MAX_CTX];
+	u64 max_peak[SDM845_MAX_CTX];
 	struct qcom_icc_bcm *bcms[SDM845_MAX_BCM_PER_NODE];
 	size_t num_bcms;
 };
@@ -112,8 +118,8 @@ struct qcom_icc_bcm {
 	const char *name;
 	u32 type;
 	u32 addr;
-	u64 vote_x;
-	u64 vote_y;
+	u64 vote_x[SDM845_EE_STATE];
+	u64 vote_y[SDM845_EE_STATE];
 	bool dirty;
 	bool keepalive;
 	struct bcm_db aux_data;
@@ -555,7 +561,7 @@ inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
 		cmd->wait = true;
 }
 
-static void tcs_list_gen(struct list_head *bcm_list,
+static void tcs_list_gen(struct list_head *bcm_list, int ee_state,
 			 struct tcs_cmd tcs_list[SDM845_MAX_VCD],
 			 int n[SDM845_MAX_VCD])
 {
@@ -573,8 +579,8 @@ static void tcs_list_gen(struct list_head *bcm_list,
 			commit = true;
 			cur_vcd_size = 0;
 		}
-		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x, bcm->vote_y,
-			    bcm->addr, commit);
+		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x[ee_state],
+			    bcm->vote_y[ee_state], bcm->addr, commit);
 		idx++;
 		n[batch]++;
 		/*
@@ -595,32 +601,42 @@ static void tcs_list_gen(struct list_head *bcm_list,
 
 static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 {
-	size_t i;
-	u64 agg_avg = 0;
-	u64 agg_peak = 0;
+	size_t i, ctx;
+	u64 agg_avg[SDM845_MAX_CTX] = {0};
+	u64 agg_peak[SDM845_MAX_CTX] = {0};
 	u64 temp;
 
-	for (i = 0; i < bcm->num_nodes; i++) {
-		temp = bcm->nodes[i]->sum_avg * bcm->aux_data.width;
-		do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
-		agg_avg = max(agg_avg, temp);
+	for (ctx = 0; ctx < SDM845_MAX_CTX; ctx++) {
+		for (i = 0; i < bcm->num_nodes; i++) {
+			temp = bcm->nodes[i]->sum_avg[ctx] * bcm->aux_data.width;
+			do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
+			agg_avg[ctx] = max(agg_avg[ctx], temp);
 
-		temp = bcm->nodes[i]->max_peak * bcm->aux_data.width;
-		do_div(temp, bcm->nodes[i]->buswidth);
-		agg_peak = max(agg_peak, temp);
+			temp = bcm->nodes[i]->max_peak[ctx] * bcm->aux_data.width;
+			do_div(temp, bcm->nodes[i]->buswidth);
+			agg_peak[ctx] = max(agg_peak[ctx], temp);
+		}
 	}
 
-	temp = agg_avg * 1000ULL;
+	temp = agg_avg[AO_CTX] + agg_avg[DUAL_CTX] * 1000ULL;
+	do_div(temp, bcm->aux_data.unit);
+	bcm->vote_x[EE_STATE_WAKE] = temp;
+
+	temp = max(agg_peak[AO_CTX], agg_peak[DUAL_CTX]) * 1000ULL;
+	do_div(temp, bcm->aux_data.unit);
+	bcm->vote_y[EE_STATE_WAKE] = temp;
+
+	temp = agg_avg[DUAL_CTX] * 1000ULL;
 	do_div(temp, bcm->aux_data.unit);
-	bcm->vote_x = temp;
+	bcm->vote_x[EE_STATE_SLEEP] = temp;
 
-	temp = agg_peak * 1000ULL;
+	temp = agg_peak[DUAL_CTX] * 1000ULL;
 	do_div(temp, bcm->aux_data.unit);
-	bcm->vote_y = temp;
+	bcm->vote_y[EE_STATE_SLEEP] = temp;
 
 	if (bcm->keepalive && bcm->vote_x == 0 && bcm->vote_y == 0) {
-		bcm->vote_x = 1;
-		bcm->vote_y = 1;
+		bcm->vote_x[EE_STATE_WAKE] = 1;
+		bcm->vote_y[EE_STATE_WAKE] = 1;
 	}
 
 	bcm->dirty = false;
@@ -631,14 +647,16 @@ static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 {
 	size_t i;
 	struct qcom_icc_node *qn;
+	u32 ctx = 0;
 
 	qn = node->data;
+	ctx = (!!tag) ? AO_CTX : DUAL_CTX;
 
 	*agg_avg += avg_bw;
 	*agg_peak = max_t(u32, *agg_peak, peak_bw);
 
-	qn->sum_avg = *agg_avg;
-	qn->max_peak = *agg_peak;
+	qn->sum_avg[ctx] = *agg_avg;
+	qn->max_peak[ctx] = *agg_peak;
 
 	for (i = 0; i < qn->num_bcms; i++)
 		qn->bcms[i]->dirty = true;
@@ -675,7 +693,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	 * Construct the command list based on a pre ordered list of BCMs
 	 * based on VCD.
 	 */
-	tcs_list_gen(&commit_list, cmds, commit_idx);
+	tcs_list_gen(&commit_list, EE_STATE_WAKE, cmds, commit_idx);
 
 	if (!commit_idx[0])
 		return ret;
@@ -693,6 +711,37 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		return ret;
 	}
 
+	INIT_LIST_HEAD(&commit_list);
+
+	for (i = 0; i < qp->num_bcms; i++) {
+		/* Only generate WAKE and SLEEP commands if a resource's
+		 * requirements change as the execution environment transitions
+		 * between different power states.
+		 */
+		if (qp->bcms[i]->vote_x[EE_STATE_WAKE] !=
+		    qp->bcms[i]->vote_x[EE_STATE_SLEEP] ||
+		    qp->bcms[i]->vote_y[EE_STATE_WAKE] !=
+		    qp->bcms[i]->vote_y[EE_STATE_SLEEP]) {
+			list_add_tail(&qp->bcms[i]->list, &commit_list);
+		}
+	}
+
+	tcs_list_gen(&commit_list, EE_STATE_WAKE, cmds, commit_idx);
+
+	ret = rpmh_write_batch(qp->dev, RPMH_WAKE_ONLY_STATE, cmds, commit_idx);
+	if (ret) {
+		dev_err(qp->dev, "Error sending WAKE RPMH requests: %d\n", ret);
+		return ret;
+	}
+
+	tcs_list_gen(&commit_list, EE_STATE_SLEEP, cmds, commit_idx);
+
+	ret = rpmh_write_batch(qp->dev, RPMH_SLEEP_STATE, cmds, commit_idx);
+	if (ret) {
+		dev_err(qp->dev, "Error sending SLEEP RPMH requests: %d\n", ret);
+		return ret;
+	}
+
 	return ret;
 }
 
