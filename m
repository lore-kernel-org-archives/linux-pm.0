Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FE4584976;
	Wed,  9 Sep 2026 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972136; cv=none; b=Gr95q149cxzEkVkAkQh/lar4wMT6DBqMiq5k3VgJNFuXOpoUqOHaxQGA/2IzonntTqnwdKoXet0pdI8iIJ1yWCjvjtL9LP6n/c8OK0vBY6TqRvhj3rFJM7Z2z+I5cI4StNdguRocU3WHSGjoC1qfNsysNlC80I/J535YVE1/Mj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972136; c=relaxed/simple;
	bh=/0zV8N7lQohFEH4TlzqI2MqZumggig0DqWnbPCuoOgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jf8S7nnoSPLHAeKL9Go48xL/t7EDD/ebeaGfq9EXXoWzV8ZfGJNqp4M0bcXkQIYW0bAB/p7N0O43I0uZ11BjOSbBChw1CXpB0dLe47wpZ3DS7ytjM56pTnMAR07c6m+cKGTC8pv7e7qm88gmiH7WwFe475qRxGtQPDafPSg90Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTR2jEAN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTR2jEAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CCE1F000FF;
	Wed,  9 Sep 2026 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788972135;
	bh=X9Pd/JkpLhUpbD72eUNsvv3WYWheEMYgKw1lsSWodok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FTR2jEANivVddM6pKhnITyWhdU+KEWz2qpEkmTIuFobQyLOIs87D7M/3bURTT98C1
	 ayPBDbSe3Y8CqjiwwRWnAOqcIcopMmPs+71PYkm9JSDUG4Tg4wAf3+nk1d/M578fqN
	 uX5sTL0iv3YL9aYqi8G5+CC7aTuxw0VJ+n9E1xFP1YCw3rEFGiTvxybZcxZlIsQ0op
	 9kMgzr4RuO0bzc2lcjMGciDDL5Gl1fNK49hQN1exucjhNY2/kJUesXLbVtlVIImIZk
	 71pJx0AUbLU6Hq5/xdP9rND6zS94q/d/JbaX6wZy8+UK6em3GhzO7s3r0xjc4H+PxC
	 /RfFh6R5BAlug==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 09 Sep 2026 18:41:57 +0200
Subject: [PATCH 4/6] interconnect: qcom: icc-rpm: Program SMD RPM auxiliary
 QoS ports
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-topic-icc_rpm_smd_qol-v1-4-6dc5b5e97626@oss.qualcomm.com>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Adam Skladowski <a39.skl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788972117; l=5986;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=PJtITCcTYAwrwu9dCo2vAeW7z8YzVv9vbyU6MwKXoqI=;
 b=qL2bBMdMTJj7GCyB8UgtqfK8v8n9cU0BPJur0DYn3/3arJt2SxpyWq/ICENui+eD6YNY1Z9Ux
 RdbNdXplZwbCyeJG4vRATQ6IGMvFB0Lx2M9FfYE0QhbS/2c54STE+9S
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Some SMD RPM interconnect nodes own two QoS ports. Currently, the code
only takes care of one, leaving some endpoints partially unconfigured.

Keep qos_port as the primary port and describe the optional second port
with aux_qos_port.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/interconnect/qcom/icc-rpm.c | 82 ++++++++++++++++++++++++++++++++-----
 drivers/interconnect/qcom/icc-rpm.h |  2 +
 2 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 5d8a41aede8b..12387de98318 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -58,15 +58,32 @@ static int qcom_icc_set_qnoc_qos(struct icc_node *src)
 	struct qcom_icc_qos *qos = &qn->qos;
 	int rc;
 
+	rc = regmap_update_bits(qp->regmap,
+				qp->qos_offset + QNOC_QOS_MCTL_LOWn_ADDR(qos->qos_port),
+				QNOC_QOS_MCTL_DFLT_PRIO_MASK,
+				qos->areq_prio << QNOC_QOS_MCTL_DFLT_PRIO_SHIFT);
+	if (rc)
+		return rc;
+
 	rc = regmap_update_bits(qp->regmap,
 			qp->qos_offset + QNOC_QOS_MCTL_LOWn_ADDR(qos->qos_port),
-			QNOC_QOS_MCTL_DFLT_PRIO_MASK,
-			qos->areq_prio << QNOC_QOS_MCTL_DFLT_PRIO_SHIFT);
+			QNOC_QOS_MCTL_URGFWD_EN_MASK,
+			!!qos->urg_fwd_en << QNOC_QOS_MCTL_URGFWD_EN_SHIFT);
+	if (rc)
+		return rc;
+
+	if (!qos->aux_qos_port)
+		return 0;
+
+	rc = regmap_update_bits(qp->regmap,
+				qp->qos_offset + QNOC_QOS_MCTL_LOWn_ADDR(qos->aux_qos_port),
+				QNOC_QOS_MCTL_DFLT_PRIO_MASK,
+				qos->areq_prio << QNOC_QOS_MCTL_DFLT_PRIO_SHIFT);
 	if (rc)
 		return rc;
 
 	return regmap_update_bits(qp->regmap,
-			qp->qos_offset + QNOC_QOS_MCTL_LOWn_ADDR(qos->qos_port),
+			qp->qos_offset + QNOC_QOS_MCTL_LOWn_ADDR(qos->aux_qos_port),
 			QNOC_QOS_MCTL_URGFWD_EN_MASK,
 			!!qos->urg_fwd_en << QNOC_QOS_MCTL_URGFWD_EN_SHIFT);
 }
@@ -75,8 +92,9 @@ static int qcom_icc_bimc_set_qos_health(struct qcom_icc_provider *qp,
 					struct qcom_icc_qos *qos,
 					int regnum)
 {
-	u32 val;
 	u32 mask;
+	u32 val;
+	int ret;
 
 	val = qos->prio_level;
 	mask = M_BKE_HEALTH_CFG_PRIOLVL_MASK;
@@ -90,8 +108,17 @@ static int qcom_icc_bimc_set_qos_health(struct qcom_icc_provider *qp,
 		mask |= M_BKE_HEALTH_CFG_LIMITCMDS_MASK;
 	}
 
+	ret = regmap_update_bits(qp->regmap,
+				 qp->qos_offset + M_BKE_HEALTH_CFG_ADDR(regnum, qos->qos_port),
+				 mask, val);
+	if (ret)
+		return ret;
+
+	if (!qos->aux_qos_port)
+		return 0;
+
 	return regmap_update_bits(qp->regmap,
-				  qp->qos_offset + M_BKE_HEALTH_CFG_ADDR(regnum, qos->qos_port),
+				  qp->qos_offset + M_BKE_HEALTH_CFG_ADDR(regnum, qos->aux_qos_port),
 				  mask, val);
 }
 
@@ -102,7 +129,7 @@ static int qcom_icc_set_bimc_qos(struct icc_node *src)
 	struct icc_provider *provider;
 	u32 mode = NOC_QOS_MODE_BYPASS;
 	u32 val = 0;
-	int i, rc = 0;
+	int i, rc;
 
 	qn = src->data;
 	provider = src->provider;
@@ -116,8 +143,7 @@ static int qcom_icc_set_bimc_qos(struct icc_node *src)
 	 */
 	if (mode != NOC_QOS_MODE_BYPASS) {
 		for (i = 3; i >= 0; i--) {
-			rc = qcom_icc_bimc_set_qos_health(qp,
-							  &qn->qos, i);
+			rc = qcom_icc_bimc_set_qos_health(qp, &qn->qos, i);
 			if (rc)
 				return rc;
 		}
@@ -126,8 +152,17 @@ static int qcom_icc_set_bimc_qos(struct icc_node *src)
 		val = 1;
 	}
 
+	rc = regmap_update_bits(qp->regmap,
+				qp->qos_offset + M_BKE_EN_ADDR(qn->qos.qos_port),
+				M_BKE_EN_EN_BMASK, val);
+	if (rc)
+		return rc;
+
+	if (!qn->qos.aux_qos_port)
+		return 0;
+
 	return regmap_update_bits(qp->regmap,
-				  qp->qos_offset + M_BKE_EN_ADDR(qn->qos.qos_port),
+				  qp->qos_offset + M_BKE_EN_ADDR(qn->qos.aux_qos_port),
 				  M_BKE_EN_EN_BMASK, val);
 }
 
@@ -145,9 +180,25 @@ static int qcom_icc_noc_set_qos_priority(struct qcom_icc_provider *qp,
 	if (rc)
 		return rc;
 
-	return regmap_update_bits(qp->regmap,
+	rc = regmap_update_bits(qp->regmap,
 				  qp->qos_offset + NOC_QOS_PRIORITYn_ADDR(qos->qos_port),
 				  NOC_QOS_PRIORITY_P0_MASK, qos->prio_level);
+	if (rc)
+		return rc;
+
+	if (!qos->aux_qos_port)
+		return 0;
+
+	val = qos->areq_prio << NOC_QOS_PRIORITY_P1_SHIFT;
+	rc = regmap_update_bits(qp->regmap,
+				qp->qos_offset + NOC_QOS_PRIORITYn_ADDR(qos->aux_qos_port),
+				NOC_QOS_PRIORITY_P1_MASK, val);
+	if (rc)
+		return rc;
+
+	return regmap_update_bits(qp->regmap,
+				  qp->qos_offset + NOC_QOS_PRIORITYn_ADDR(qos->aux_qos_port),
+				  NOC_QOS_PRIORITY_P0_MASK, qos->prio_level);
 }
 
 static int qcom_icc_set_noc_qos(struct icc_node *src)
@@ -182,9 +233,18 @@ static int qcom_icc_set_noc_qos(struct icc_node *src)
 		/* How did we get here? */
 	}
 
-	return regmap_update_bits(qp->regmap,
+	rc = regmap_update_bits(qp->regmap,
 				  qp->qos_offset + NOC_QOS_MODEn_ADDR(qn->qos.qos_port),
 				  NOC_QOS_MODEn_MASK, mode);
+	if (rc)
+		return rc;
+
+	if (!qn->qos.aux_qos_port)
+		return 0;
+
+	return regmap_update_bits(qp->regmap,
+				  qp->qos_offset + NOC_QOS_MODEn_ADDR(qn->qos.aux_qos_port),
+				  NOC_QOS_MODEn_MASK, mode);
 }
 
 static int qcom_icc_qos_set(struct icc_node *node)
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index cdd5f444b152..e36c378a80a3 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -77,6 +77,7 @@ struct qcom_icc_provider {
  * @ap_owned: indicates if the node is owned by the AP or by the RPM
  * @qos_mode: default qos mode for this node
  * @qos_port: qos port number for finding qos registers of this node
+ * @aux_qos_port: optional QoS port in addition to @qos_port. Zero means "none".
  * @urg_fwd_en: enable urgent forwarding
  */
 struct qcom_icc_qos {
@@ -86,6 +87,7 @@ struct qcom_icc_qos {
 	bool ap_owned;
 	int qos_mode;
 	int qos_port;
+	u16 aux_qos_port;
 	bool urg_fwd_en;
 };
 

-- 
2.55.0

