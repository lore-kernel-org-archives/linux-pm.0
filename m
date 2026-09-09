Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ECF58596B;
	Wed,  9 Sep 2026 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972126; cv=none; b=bgOhZ+IZFAqqssZSE/zbQ64znPqbKR/3D8BvHulmlp193wsk/KdYpjcKvccaulezDCW+usnYXHHN1eBWlj61SuaYK9plB7ENBlsW3VwSRQWYiw+I2PjoerdU3FAg6ZjmyPLVakSTJ4E1jCbEiIgP9KC2veA9/Zkh7GpjX+2X27A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972126; c=relaxed/simple;
	bh=Q6pDdgD77tRCU1gfJ0wVe+fYxWUkzGcUP5Av9NeMePE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OUCd8qNNGwCanvJAxzu0XLo1i+/lh9TyUgBu0FVPOR17gmEBxAHnRPVQ80hcqsPc4cK45L/6v2iFijziVYS7eg+hFI6hMLeF4fgorCjg7crjsfhInjmEzXNd2QHCnu+m+uzaRxEIv0D+ik8Lpq04ozLTsJj2+OvhkrC2QEbk04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9XxZjSA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9XxZjSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D111F00893;
	Wed,  9 Sep 2026 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788972124;
	bh=FMw2HWQZ9hsyHLkoSdNcliDW51DS08OBnzT9klJKoh4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=P9XxZjSAG7BO5GXu5sDY05MoKWqQwhylKChrrcysigqS/FwRisiRX/pVyr+icPk0J
	 7CJ77bLLiep/LK+yAPpV4JxlKhBZ9zlqXcoRPGqKnldEEyYHglyJnFnlEJau1liEoa
	 qLe/SB6+Rg4lOHNDwoKMF83aZpRtU1vxD0aNSiIZuOGFjmBynCfFVwL9CqWOpaR8lj
	 lL1jyzwcbT9BCZEksH+hLf77ZJJvDgQbD8c7b/t0tmLHWmNmVGVw6aM5FN2vVaTH4y
	 yaBvW207NqjFjivMOEFurLOsJ55Zpd9WFCuivAecQgCkn/z/Mk7xbm2H89Q4SOOaL6
	 reZBgwdUZYdSQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 09 Sep 2026 18:41:54 +0200
Subject: [PATCH 1/6] interconnect: qcom: Move bcm_div() to common code
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-topic-icc_rpm_smd_qol-v1-1-6dc5b5e97626@oss.qualcomm.com>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Adam Skladowski <a39.skl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788972117; l=3145;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=giFz0SPGWx5zhxrTw7l9Ho39cbePiTp1WQDdxwBTl3U=;
 b=JZfoPQxkrnMmL3h92ZJ11e16g7PQDiNYiq+KnVwG7j4ddIsO/BzwqdtXac97SZDzyolI3ZuJm
 wqrBifQY9bhDzEuSJpxXd9J8cWCtha7zcO2MAC27JclV1yx5L9UW7YO
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

This helper is useful for both SMD_RPM and RPMH code, extract it.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/interconnect/qcom/bcm-voter.c  | 21 +++++----------------
 drivers/interconnect/qcom/icc-common.h |  9 +++++++++
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index a2d437a05a11..cdb0c5ee5cbc 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
  */
 
-#include <asm/div64.h>
 #include <linux/interconnect-provider.h>
 #include <linux/list_sort.h>
 #include <linux/module.h>
@@ -14,6 +13,7 @@
 #include <soc/qcom/tcs.h>
 
 #include "bcm-voter.h"
+#include "icc-common.h"
 #include "icc-rpmh.h"
 
 static LIST_HEAD(bcm_voters);
@@ -47,17 +47,6 @@ static int cmp_vcd(void *priv, const struct list_head *a, const struct list_head
 	return bcm_a->aux_data.vcd - bcm_b->aux_data.vcd;
 }
 
-static u64 bcm_div(u64 num, u32 base)
-{
-	/* Ensure that small votes aren't lost. */
-	if (num && num < base)
-		return 1;
-
-	do_div(num, base);
-
-	return num;
-}
-
 /* BCMs with enable_mask use one-hot-encoding for on/off signaling */
 static void bcm_aggregate_mask(struct qcom_icc_bcm *bcm)
 {
@@ -99,20 +88,20 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
 		for (i = 0; i < bcm->num_nodes; i++) {
 			node = bcm->nodes[i];
-			temp = bcm_div(node->sum_avg[bucket] * bcm->aux_data.width,
+			temp = qcom_bw_div(node->sum_avg[bucket] * bcm->aux_data.width,
 				       node->buswidth * node->channels);
 			agg_avg[bucket] = max(agg_avg[bucket], temp);
 
-			temp = bcm_div(node->max_peak[bucket] * bcm->aux_data.width,
+			temp = qcom_bw_div(node->max_peak[bucket] * bcm->aux_data.width,
 				       node->buswidth);
 			agg_peak[bucket] = max(agg_peak[bucket], temp);
 		}
 
 		temp = agg_avg[bucket] * bcm->vote_scale;
-		bcm->vote_x[bucket] = bcm_div(temp, bcm->aux_data.unit);
+		bcm->vote_x[bucket] = qcom_bw_div(temp, bcm->aux_data.unit);
 
 		temp = agg_peak[bucket] * bcm->vote_scale;
-		bcm->vote_y[bucket] = bcm_div(temp, bcm->aux_data.unit);
+		bcm->vote_y[bucket] = qcom_bw_div(temp, bcm->aux_data.unit);
 	}
 
 	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
diff --git a/drivers/interconnect/qcom/icc-common.h b/drivers/interconnect/qcom/icc-common.h
index 21c39b163948..af4b5a6f30b7 100644
--- a/drivers/interconnect/qcom/icc-common.h
+++ b/drivers/interconnect/qcom/icc-common.h
@@ -7,6 +7,15 @@
 #define __DRIVERS_INTERCONNECT_QCOM_ICC_COMMON_H__
 
 #include <linux/interconnect-provider.h>
+#include <linux/math64.h>
+
+static inline u64 qcom_bw_div(u64 num, u32 base)
+{
+	if (num && num < base)
+		return 1;
+
+	return div_u64(num, base);
+}
 
 struct icc_node_data *qcom_icc_xlate_extended(const struct of_phandle_args *spec,
 					      void *data);

-- 
2.55.0

