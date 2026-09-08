Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6073B0AEF
	for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2026 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788854962; cv=none; b=SrCXl5VaqzhpmKvTf1THTHyWFph8/Gdi7F+hJLkN5wYhEyLmUDpYGiqdMKvchuM/2gHb0szehL95INF6XeG/G/XxpXlvzT3ugL3dm4cmJjtEIYTp5UlOzY8m862HnWAs3hqBm+ZIvfNE9z3oqfrh4DIg/hoOPO/5cbYyZucZqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788854962; c=relaxed/simple;
	bh=jZb9VWJNn//9UIfodFEP6WLVk3CPMdRNJNrNhBck1Wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z67ilXLy1U7jlIaQTKNmAf1EBHybGwTFTOsU1/crMLSGLhkEu02DTzLXS2Hf7xCJsOHGdhNNp49NOYS2Wp71qCujK6AQgnyG9Ck97a6fu9qj156D6XU1eyIH+sUJsEHTHZibf3NZKEMp7db16asrFqbHYLJpQfhOgDkqRaZzdKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PwLWY19U; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PwLWY19U"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49d0726ccc2so18347855e9.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2026 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788854957; x=1789459757; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FrMPA2gnzNAOST949OYokgJZDYzOdtAOrWkmN+04YvM=;
        b=PwLWY19UjoVYyzrYJoYrYSSoK4ilGu5k/wRS/A8NXEPDZC57msuWKy2SYy3JqjZWQQ
         yKnkn2KytgG1icUJWPkx41ZmMkFIXPQBjUgOfv+Qj/8NPLpgAxn78k+ox3DaVvbIoLJL
         cN6l1WyVqFW/5PkFhZOGqJpXihl/0E8k19BkpyRfL8uDHdhUVw4+MtDRK8osSVTYCdGR
         85l6t4LNooUfsxHb/BY1UVOGUO5P+5vwTDZM8tKBG5AOB35ivCB0TNwTLglhowYwMOdN
         r3Ud/PP5RtAA56+dolP/EoByUTScHOs/ksbSaAptnRvkqDqV826TkqLDE2xreQGVFJcM
         WKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788854957; x=1789459757;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FrMPA2gnzNAOST949OYokgJZDYzOdtAOrWkmN+04YvM=;
        b=jzjbmaXWDYQuooRdm1dz4mBZIhS4LFZizWZen53QJG3U/q3qy7XrBkGKtKfGZ337sw
         bLlQPQAxeJMoLUJAKbNjft3M0uhZdAsdGptxRY13NT6t7QKKkEI2zWPGi+BQwYb8joBY
         e02oZHdQyuq/1w8wZ3BvV0Be6FcNRsWJIMAgQWneBSjH7e3n+ijgMVNtmkXylLX4qpo8
         Y7t8uO/QbRSMgvGhpgJlFi7N+SpdR1EK8GAkG1e3yScHp5s+3duPJpSjHyaVmd9vA+xs
         Y3RhgCb/lhkNUUq0wB0I7THOtKwib3cSY2kPqMsAz8BpD5qYOCQMSOESNFpMHpqk8A8q
         XCtw==
X-Forwarded-Encrypted: i=1; AKwUvBwRU0Ri0BOypXMZbZ9PRm30TlFe85JuflKb8PRfNYBJseaje06xqhzrkKJTHca/I6slf7xDt0rvsA==@vger.kernel.org
X-Gm-Message-State: AFuF++lCif+jVl3UDB1Qx7Ky5BgvNUZ04f1AB0sN5+kBJfVA5RyxB+hi
	6VJ0ruWZQs2S45V9oKXDrk+L9DnXyRCVEHzhKsGxMdTNF1B6jiaQKX8pC5Um8w7G+OA=
X-Gm-Gg: AYBFou1W67VgrvXgc7VZ8qIkXo3qRwoO68A9UkkWmYzL0+fFRYcb9YsNbfzVcT28u1i
	DZiJOlDMuIPhhPRsXBoxHDJ8g6SFsUX7Umieg8CAc23VLZo10WHVMOfe6oGJmi+hxKRjRokPVPg
	elvY+wxokjdL0KwVAE0rLKFp7AVbN8swYJhl+N11W1GQSJCtvJJy9NNkaMYwyxgHkn8C3+P46nI
	lSfmSEslL+9IXpWviaiiH78TFpqgktnw3dkSsH/F0Rs4dANLFpe76CnFcM7Ys8Rq5n9x+VdPwdf
	SjhM6b1JBTcOpp4MzFUeMOF4S5rUDmOVkTXKDOS0UwQuSNCPBXnrDOFfAnSViqB+y4TOfhwlgxD
	zHtIkDaXRIdeSeMTHmwsDX1y1BuiWQ145Hg5o3J4HHlWoDoUX0vMMIeR2EyjZ9px+TUb5m/7Ez7
	aY7fX6QjWIg+Gd3w7LLOfuYI4qsF1FPucONAAcTUHkr+fqjPkdn0VO3TltandHK8RTp7exBGF+l
	4ml3LbQPTCPP+17aDA=
X-Received: by 2002:a05:600c:3507:b0:499:a5c8:c6f3 with SMTP id 5b1f17b1804b1-49cf7fe6900mr509106715e9.3.1788854957231;
        Tue, 08 Sep 2026 01:09:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6023edsm441847955e9.7.2026.09.08.01.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 01:09:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 08 Sep 2026 10:09:15 +0200
Subject: [PATCH v2] interconnect: qcom: implement get_bw with rpmh_read
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-topic-sm8x50-icc-read-rpmh-v2-1-b6f1c4205450@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKrCn2oC/43NQQ6CMBCF4auQWTumrRSMK+9hWIxlgEmUkikhG
 MLdrZzA5fcW/9sgsQonuBUbKC+SJI4Z7lRAGGjsGaXNBmect9ZUOMdJAqb3dfUGJQRUphZ1eg/
 ITyorS6V3XEMOTMqdrEf80WQPkuaon+Nrsb/1r+xi0WJrLuTYB/JdfX/JSBrPUXto9n3/AvsdJ
 EPFAAAA
X-Change-ID: 20251106-topic-sm8x50-icc-read-rpmh-eba461a452e7
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5677;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jZb9VWJNn//9UIfodFEP6WLVk3CPMdRNJNrNhBck1Wc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqn8Ksz1kMm9xb8PHeWR1wLddduvjg2l+f7eAh8u3c
 DKXmp7iJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCap/CrAAKCRB33NvayMhJ0XMTD/
 91K0ue88uHmTaeWrOynq8j9LBjh95zKukeZmm4kmiCSawdwjnhYsQwd+Flr5NoQaBFCoYNWNeQEMmv
 EdUHzsyTDHdDeCWA6LTfo+68pRXFx7Bm4eljjSL4iiWEjeHNe0OmSaWb2Bs5jS3X/p9VoQ0xtIQlxC
 bQe9DyAqwKLuKQNAZf6fnTLNSJpfEEtw5OMhLU/2GJKFFpko4MwhhlnTfsQcuw4iF1SfSjENhawUBb
 tF0geqZxpAqvrkQt9D6D+43FMFeH2L5+JAmqa4a5saUy3wMRNgZ1No/G8FBxV5RlU39C61w9rMaXWU
 /rQDFFEhK+15QDBgZe+U3hNjOJVbGOrxysWhKrLTddx1DWl6aGomzyMfR21FaHzkeDfmgq5cmGmO2d
 b1EdVIJusxe4mzChwS1eDoiFc7FulzplyhUzgx9XNU5mp5KdXRoLAkXYxwiw7v5ZNiNOrN1hNDvbI/
 Bmv9M6dUhUtjyNh8bZzsKRD7PUJPMTu+Xi3WTg+xIhjbf8CwXI7fcSP8vJW/qES6cGZzLskT8O5fyl
 dYuObc/SFlYiNpAj/fHtgLqlZPqxY7hnFqesxWgKjFSq6lcBk9EaQuHlpD5SK7KGEtfclFp9DFcWna
 0h17RZaAAVQurKjJxJQI8iVX8L39PRTo8O8FissVmBsoPtRE7SmsuS986oyg==
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
Changes in v2:
- Added tested-by
- Rebased on v7.3-rc1 now the rpmh_read() is merged
- Link to v1: https://patch.msgid.link/20251106-topic-sm8x50-icc-read-rpmh-v1-1-d03a2e5ca5f7@linaro.org
---
 drivers/interconnect/qcom/bcm-voter.c | 36 +++++++++++++++++++++
 drivers/interconnect/qcom/bcm-voter.h |  1 +
 drivers/interconnect/qcom/icc-rpmh.c  | 60 ++++++++++++++++++++++++++++++++++-
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index a2d437a05a11..9014bf20adad 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -261,6 +261,42 @@ void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm)
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
+	rpmh_invalidate(voter->dev);
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

