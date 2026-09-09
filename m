Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1D758496E
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967597; cv=none; b=kvdgbfBa1yH3UFy76ntszZNySeyV5YUfjFh08CHtoXHpsU8ILoJAgE0epGq9b/kDAcwJUNbRrc62PosSt0tfhfjxdonwjX6cv2nuR3X+ypbdqBWyv1a+DRBN9dXJPOxuvEjpcC9aki8/7UwVcfiNNRkhXfYtFfdbTPTb3tDN7Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967597; c=relaxed/simple;
	bh=CKIJqH/pCWa5y9mx1SLRPsTxPwNgxDkXr8WszpYSiwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AwsAQuaIZSOL51Vas2s1TbHjQZNLxa1zvR6z6BxQIf384q4URpwosT+NV7C4csNDDyxIo7ktpRuOj4GHjbqOwQj8GW+vqX0gZKQDu7UsOOfP+IZ2tYRxu12VQh14hz3Evdhy1y0z6ZbHxAHl2rFqP+bIVu/oi5wRu/nHQdSNDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XDTRDQkz; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDTRDQkz"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b94fce6e8so3470455e9.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788967593; x=1789572393; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xi5anwLS5N66sj2Glni4kb1JwbXSCUh9kBtKPwAAERU=;
        b=XDTRDQkzFAEin3GGUQsh+SvldK01VchPyovkKijh0JbLl+jbuTOosPEOkuZCMEqKe7
         M687STJI1SrDAxXVi5hDCAMKr6DPiOyeiAAdEc99CZwrBrDURLqNl/5S5kdek0zMvEp9
         5wpSQ12FMWx4k7v4hxMRTFcP8uaG3QYiunx525b6X1MuNrD5K0zBEwEb29mJd+0G/7sU
         YgScRVTvqtB8fBCVqruRJ1P5/lW2ilY0PqoCqkkrmZjEuTYm1LyHzbDSboFk51CZY5Sw
         1nxd2iFaOcAfHhlNCMCGFMjJkm9jE3qzMG0uPa57PxUtECmoy/1kEfLv7ytnFLs5i7Rp
         Qgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967593; x=1789572393;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xi5anwLS5N66sj2Glni4kb1JwbXSCUh9kBtKPwAAERU=;
        b=HQCrkUhR6lF1y8FEO1ZQsYGa/moOKgMZeMhPnr279eIFLEPiYX3y53v3wI8rUOGLzz
         UqJq2zcB+M8h8YIp0UsVBVi61YaGyM6fmx00pDdfqXQrXgt+uSftVFM/E/UIMUtqD4hl
         ZKCmG1TKZ3c4BweWy0tn21BM8/0Lb/H+Q8R7zvo5rkkhc3KVGUngOBdnkYsjVenaYpve
         clRrMd+sbRetvUGDzyAHJWfecjxP79efVkqGF4VS++RPyCCLTk6rIzdtX4ZhXnumTqr+
         1iO51+8cmDHRxRIsJofIDadzxtwrf1LuyLMCzOrA4TDBOpnbRvrpXO8n0mleZ4UNGfAS
         O2oQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRUUdJzw+EQ+be4rJD2omPn9kBdOsFBNAGNSQBwQvxqjqxZwEIsSJsbUvdz1UcDG+TurO/lk/swA==@vger.kernel.org
X-Gm-Message-State: AFuF++lB+z9IcBjSaAZmeoVVXW6Kd/luEiF7etmP69T78Ztp+Ya4WJhJ
	zWLmaz9vOPJCYYVxi8POQb7tCrg+Ui4tsPgAVcc3IZG9iPrbO8ryXk7H0JwKbyaj6Bw=
X-Gm-Gg: AYBFou0USdZaizFIgqdlKkIpDfXSC+ZTe3utodIYQgcX5ZkDWvwiTzuUngEdUgV9ChC
	bEUqgGUDGkMUSXo7ENV1b5ST4/EeIYNsf6gTveqX/MqMC9GSA3HJ25klhqos9qQzGAYdXMAoU/j
	2T7Yhk7Xb8vgR1MB0x/TBhBvLJ222sRv8/Q/4lGjFDDh5fOMjyRNEoxlaZQb7bTTgIKNH92GEHH
	tLXX24Uai1wVGXfiBEjfefHvpfHVZSRW6Gnuy5pCHxs7XARis/vEAlqL1n+ELopLaRBW1m9kf72
	agX65zPTHyCnaSb2nDpfBxgQbRI3TBWqT2Rw8OafWTa4vB4ucth0Dj5JiPS+96nK1fZ0XAiGaFn
	dAKAal9C7uRfDYYVeeJzET4Fg0zIer0OlLjyUVGeavcmbKACN5KqVtRdhtH8HWyL77MJEIX6vWD
	knCl+uhVB6nsukvrq0sfJslXdqPT3jo81mhCfDNC2E+NBLziGjFtJcidR8WppS+3QXBB4A8HLcr
	yi0wqAqHnEY3xTnBvs=
X-Received: by 2002:a05:600c:1d0c:b0:49d:243a:e4f9 with SMTP id 5b1f17b1804b1-49d258d8623mr16411955e9.10.1788967592466;
        Wed, 09 Sep 2026 08:26:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d1fd58c31sm53751755e9.1.2026.09.09.08.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:26:31 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 09 Sep 2026 17:26:29 +0200
Subject: [PATCH v3] interconnect: qcom: implement get_bw with rpmh_read
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-topic-sm8x50-icc-read-rpmh-v3-1-2bc65d7b25e5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKR6oWoC/43NsQ6CMBSF4Vchnb2mLbSgk+9hHEq5wE2EkpY0G
 MK7W0gcXIzjf4bvrCygJwzsmq3MY6RAbkyRnzJmezN2CNSkZpJLJQTXMLuJLIShWhQHshY8mgb
 8NPSAtSm0MIWSWLIETB5bWg78/kjdU5idfx1fUezrX2wUIKDhuZGorFFteXvSaLw7O9+x3Y3yY
 2l+4dVPSyar1q2wheSqUPzL2rbtDWyAx7URAQAA
X-Change-ID: 20251106-topic-sm8x50-icc-read-rpmh-eba461a452e7
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5802;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=CKIJqH/pCWa5y9mx1SLRPsTxPwNgxDkXr8WszpYSiwc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqoXqmFeu/rKq+igBSw+T5HRR5uvIGS7HxOw+YjniI
 d+5WjfyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaqF6pgAKCRB33NvayMhJ0QdOD/
 4lltqQ8PFuL0SASQG9SI3hEkcf1wtAyaDAjal4BC7LL1TqOKeFf2NhyP62v/VwM13VUEFm6R4AdUo7
 2fv7ottyA3PZwtKSBW4GT+tkxnVfkhMX8qRWFEydYvJBMzzQDkbfnl4MzCMQsiJk+WPzPv+GKAZ6kJ
 VOWs1+v94Eogz271piwoMLxYTfRJmdLoFoyaVxydQJE17L7GnNen5POba1NYsbiyPiLxH8mW12IIfx
 wzVn1Up7bxJZ0NOBL8pmOXxLzc+R/F3GL3kg1sceq7dTVKznScl6XYtH0DaasosxrxXEUb3VCNQLge
 zu7xKUp2JqvHAcYRshvyrbKugHTbHiD3O/WuXeVfONrBacu5k0pzYOEj6Bh761yr0NhulQ9pIdsJ2A
 SS3959xRNv7B9Y/W0zFDVfvla7O5dTouBiHjV+3FKjTfT1fn/LlqnBF0LdCNiuEFaa3zPEG9jeomrG
 80ieIB653yZXUZpJkPKFrtBMfvZijRpt1FuCiI3KAHIg50B6jS61bFDxrR9H8iW6dZFXdVv99rNSWq
 OpbrC2apZjC3McyDQKe+EpbQkCKiqjIVsSOvlNebrAs/3hXr42ZMJk8xicE3K43ysoGWfW3anSMt5x
 f+UcICsKZLe0fkHSwJfjcvOe7XUh/XnGS0ycpS31ZWGu+v6rFK8NPIItSkrA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Since we can actually read back the APPS rpmh interconnect
BCM votes we can actually implement the get_bw() callback
and provide a coherent average and peak bandwidth at probe time.

The benefits of that are:
- keep disabled BCMs disabled
- avoid voting unused BCMs to INT_MAX

If the interconnects are correctly described for a platform,
all the required BCMs would be voted to the maximum bandwidth
until sync_state is reached.

Since we only get the BCM vote, we need to redistribute
the vote values to the associated nodes. The initial BCM
votes are read back at probe time in order to be ready when
the get_bw() is called when a node is added.

Tested-by: Georgi Djakov <djakov@kernel.org> #db845c
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Dropped unneeded rpmh_invalidate()
- Link to v2: https://patch.msgid.link/20260908-topic-sm8x50-icc-read-rpmh-v2-1-b6f1c4205450@linaro.org

Changes in v2:
- Added tested-by
- Rebased on v7.3-rc1 now the rpmh_read() is merged
- Link to v1: https://patch.msgid.link/20251106-topic-sm8x50-icc-read-rpmh-v1-1-d03a2e5ca5f7@linaro.org
---
 drivers/interconnect/qcom/bcm-voter.c | 34 ++++++++++++++++++++
 drivers/interconnect/qcom/bcm-voter.h |  1 +
 drivers/interconnect/qcom/icc-rpmh.c  | 60 ++++++++++++++++++++++++++++++++++-
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index a2d437a05a11..c15abb57cd24 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -261,6 +261,40 @@ void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_bcm_voter_add);
 
+/**
+ * qcom_icc_bcm_get_bw - get current bcm vote
+ * @voter: voter used to query bcm
+ * @bcm: bcm to get current vote from
+ */
+void qcom_icc_bcm_get_bw(struct bcm_voter *voter,
+			 struct qcom_icc_bcm *bcm)
+{
+	struct tcs_cmd cmd = { .addr = bcm->addr };
+	int ret, i;
+	u64 x, y;
+
+	mutex_lock(&voter->lock);
+
+	ret = rpmh_read(voter->dev, &cmd);
+	if (ret) {
+		pr_err("Error sending AMC RPMH requests (%d)\n", ret);
+		goto out;
+	}
+
+	x = FIELD_GET(BCM_TCS_CMD_VOTE_X_MASK, cmd.data);
+	y = FIELD_GET(BCM_TCS_CMD_VOTE_Y_MASK, cmd.data);
+
+	/* For boot-up, fill the AMC vote in all buckets */
+	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
+		bcm->vote_x[i] = x;
+		bcm->vote_y[i] = y;
+	}
+
+out:
+	mutex_unlock(&voter->lock);
+}
+EXPORT_SYMBOL_GPL(qcom_icc_bcm_get_bw);
+
 /**
  * qcom_icc_bcm_voter_commit - generates and commits tcs cmds based on bcms
  * @voter: voter that needs flushing
diff --git a/drivers/interconnect/qcom/bcm-voter.h b/drivers/interconnect/qcom/bcm-voter.h
index b4d36e349f3c..fc75d457dcc7 100644
--- a/drivers/interconnect/qcom/bcm-voter.h
+++ b/drivers/interconnect/qcom/bcm-voter.h
@@ -13,6 +13,7 @@
 #include "icc-rpmh.h"
 
 struct bcm_voter *of_bcm_voter_get(struct device *dev, const char *name);
+void qcom_icc_bcm_get_bw(struct bcm_voter *voter, struct qcom_icc_bcm *bcm);
 void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm);
 int qcom_icc_bcm_voter_commit(struct bcm_voter *voter);
 
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 3b445acefece..7f2b5673629b 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -136,6 +136,61 @@ int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 }
 EXPORT_SYMBOL_GPL(qcom_icc_set);
 
+static int qcom_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	struct qcom_icc_node *qn = node->data;
+	u32 avg_max = 0;
+	u32 peak_max = 0;
+	u64 x, y;
+	int i;
+
+	if (!qn->num_bcms) {
+		*avg = INT_MAX;
+		*peak = INT_MAX;
+
+		return 0;
+	}
+
+	for (i = 0; i < qn->num_bcms; ++i) {
+		struct qcom_icc_bcm *bcm = qn->bcms[i];
+
+		/* Use AMC vote for boot-up */
+		x = bcm->vote_x[QCOM_ICC_BUCKET_AMC];
+		y = bcm->vote_y[QCOM_ICC_BUCKET_AMC];
+
+		/* Consider enable mask and convert to INT_MAX */
+		if (bcm->enable_mask) {
+			if (x & bcm->enable_mask)
+				avg_max = INT_MAX;
+			if (y & bcm->enable_mask)
+				peak_max = INT_MAX;
+		} else {
+			if (x) {
+				x *= bcm->aux_data.unit;
+				do_div(x, bcm->vote_scale);
+				x *= qn->buswidth * qn->channels;
+				do_div(x, bcm->aux_data.width);
+
+				avg_max = max(avg_max, x);
+			}
+
+			if (y) {
+				y *= bcm->aux_data.unit;
+				do_div(y, bcm->vote_scale);
+				y *= qn->buswidth;
+				do_div(y, bcm->aux_data.width);
+
+				peak_max = max(peak_max, y);
+			}
+		}
+	}
+
+	*avg = avg_max;
+	*peak = peak_max;
+
+	return 0;
+}
+
 /**
  * qcom_icc_bcm_init - populates bcm aux data and connect qnodes
  * @bcm: bcm to be initialized
@@ -255,6 +310,7 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 	provider = &qp->provider;
 	provider->dev = dev;
 	provider->set = qcom_icc_set;
+	provider->get_bw = qcom_icc_get_bw;
 	provider->pre_aggregate = qcom_icc_pre_aggregate;
 	provider->aggregate = qcom_icc_aggregate;
 	provider->xlate_extended = qcom_icc_xlate_extended;
@@ -272,8 +328,10 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 	if (IS_ERR(qp->voter))
 		return PTR_ERR(qp->voter);
 
-	for (i = 0; i < qp->num_bcms; i++)
+	for (i = 0; i < qp->num_bcms; i++) {
 		qcom_icc_bcm_init(qp->bcms[i], dev);
+		qcom_icc_bcm_get_bw(qp->voter, qp->bcms[i]);
+	}
 
 	for (i = 0; i < num_nodes; i++) {
 		qn = qnodes[i];

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20251106-topic-sm8x50-icc-read-rpmh-eba461a452e7

Best regards,
--  
Neil Armstrong <neil.armstrong@linaro.org>

