Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099849;
	b=3M4LxqMVvvc/ZfS8nYw4pesyENZmt2Fa7Kb9q1Ur6oHMlHFMBmCFAWRpX+w+W+NxYbJu
	 l3s68XNxMSm+K/qTFmqPPxrhNFA+CjFVtNWtfI5LlIZ5GXlaVcd6625Ev+PAgCleby0TU
	 Os8dmmud4IyT+bb5gVBGG08HjLn3jtMXLZXHkgFU79DYa+z7E92g0PCx31DCcVi6jBeI9
	 4DvLFWYM9R+pqTBDfGDK4vvOEF12zOVmLMiGndZyIs1qEST9enYj/gUpO3ufYCzBxBzoI
	 IWE+XIhRfKubQhaxMU962u9dXjlVnRZf13rurGE60Lp797cgb1L7PnetbRWCDKaQ2eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9Nf9mjdzYS3LyCpg7Z9WZNdP5lYcR2or6ZVhn2DOTK4=;
	b=l67AqAVw/VfT906XB67uSlZC91qsjWYy+Z9wo7A5cYU+qleKOJvQvDdKOewRZlsHDs3E
	 ioB/+CstEF/Bi6eAJ0WgENloBxmJXerfB2xn/qTx9kL0alX/UDcxtWbbb8OfqC2EjYkUQ
	 LskpnvYkVjhonrKlKeWmkOfuAsH3JbH4AB2tAPKsMLmUQoBkCBznU/59Q2NOQPxB1udDo
	 r30bisQJlG/IMJuD3IByU6etDq+FNIhpWlO/nX2Bfw/HYzNWbRtE1ieI3J4nu9akYuQ5a
	 n5Jc4CgLB9Xl5xiXhmGWInWsz5BJp1k01XAV55RzmZKBdBivyiP3HdiBdloK8QgFjEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xcsr713d;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7AD606A31B
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 11:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF7AD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xcsr713d
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so5015785e9.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 04:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793099847; x=1793704647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Nf9mjdzYS3LyCpg7Z9WZNdP5lYcR2or6ZVhn2DOTK4=;
        b=Xcsr713dWgbnXlAQQp5fxEmxn11q3+BF088mMEaZbq/qWY1qT3iTAbZ/75QClXjDC6
         jEMJ+A5oRcEdx5/LM3CHPOR1+k5DhNXF5fR9XeXZX5dcrYGFJ5t19kR4Er1O1z5cnweO
         r2EkFA7shUi9YhFHNER/mGf8B0tjO1TUWmshecyz7L0GF9sFydDxkEDXX1SEfjxqUgSA
         lVssrZNS8JUidH3aAn6DHMk1/AmNfkfHikI+371MrozjnJVA9SVRsFzUFcz7MZYKvkvJ
         hkm0y7lBqTGwDoOXLY7evxMVkA8cpi7oYwiyD1RXT8UoIEexBzEWE4pSVogVMKLyhrQP
         w13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793099847; x=1793704647;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Nf9mjdzYS3LyCpg7Z9WZNdP5lYcR2or6ZVhn2DOTK4=;
        b=x/o0nxZ9MmdoXUe/Ow6CpCjfnZYm/FbVFhiZYgHyUF2ICKiLBTDn0X/WryRf5t8dcv
         7C8EzDjcn1/Iiw+dz5g51Kh9XWAOQF8VOMWzVliPaMjv1u57jaNsDKahXU7aEDjqGxVJ
         BO15GUhtJHmDOrLM5IXGsAarDvLFQrXtisIjNBOOIUzNAzezl/aDLv5EKe1qe4QxmJ6i
         QOxaOiiG+fcTI4PyzNcXFBRA8bYek5xIQ+Neh8LSRxyYTp4EDgazMbxQ9bRG4MioOX2V
         jF9I1hbr4x7iiOhPZMG0jjwfkoA1yHwO3qONCjpNsvMRJxhW5a6gjCv3oiUbuo8GvND0
         O3EQ==
X-Forwarded-Encrypted: i=1; AKwUvByD80kf5fThwhQcIxBXkTTihrSb17cTPjIb5oDjQFcGxPXIGCdoMh8GK/lnTg9ZFcVWIsWSJQ6nQw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLDibKpI0XEfZVLMvnlScOmS1NDHRPYC0Sv1bvW0jiyC0F+P/5X
	6ynNPyvd5o70cGX4z6eIRYemPoY7gMYDv65ginKIvgrWKmwJ1As+54MqU/WiZad4ASSqpw==
X-Gm-Gg: AYBFou0EYP85yZKNwIYsp1xwwPiI81Q5cgRM0evBPMBazVGkztTIMXxkvLmWy38GJTS
	STfH1yaUzGrdbp/O1m4RrhGw8aPWxUxWF1IcydOymMwzqYDFL/OaGJfaI7OtLmTbRukYKieuf6v
	K4uBEZkAqr7Amizr6xm8nx97CRws1idUXkJaxgJL3uCL0sio91fY1b5CNNPebx4UAQiXjgsEQLw
	8asv+XfLdvXRTZu4xr/zhRyg5pm23Fx8e2p+FeLrGHAJf1FA3StYfFD0QDNavh8XYQyolSXIXS4
	cskDDVx1wewa78ehvFv1Dfqny4CMSfk3T8wHIdeyYbCQF+jJqos05U3Y6SekzQr1Xr3RCQsaW0J
	vnt8LBVykSEBoUV7wx1anNnc8dB+O0Zk5ApfDW0sVd99Y2WTq0sfQRodCIWF/zxx4G4QmeoC5iR
	KfvpgooGhhxFCT8Mhg15FEnFtYICYLCTmLZg5kSHJ3RMVXZNM4Y1aHFzjAK3ajZy2E6ORrui5in
	+2iZDEZZBbsq+YjKyom3yQ3HMRzOHKV4F+9i3RYzpEt8/hlnRxAnXxZIeERaHPkicvX8Knl2+zg
	FzHNLIECGGKepz3JVNZUo8ur8YzRkA==
X-Received: by 2002:a05:600c:530d:b0:4a1:c27d:e1a8 with SMTP id 5b1f17b1804b1-4a7c100c816mr54013175e9.10.1793099846767;
        Tue, 27 Oct 2026 04:17:26 -0700 (PDT)
Received: from the-kernel (79-139-145-200.dynamic.spd-mgts.ru. [79.139.145.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a5697a7sm254850715e9.7.2026.10.27.04.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:17:26 -0700 (PDT)
From: =?UTF-8?q?=C3=84ngsblomsterskymningen=20Zefir=20M=C3=A5nskens=C3=A5kerh=C3=B6jden=20Zetterstrand?= <angsblommansken@gmail.com>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: djakov@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=84ngsblomsterskymningen=20Zefir=20M=C3=A5nskens=C3=A5k?= =?UTF-8?q?erh=C3=B6jden=20Zetterstrand?= <angsblommansken@gmail.com>
Subject: [PATCH] interconnect: qcom: Use semantic names for BCM bandwidth fields
Date: Tue, 27 Oct 2026 14:17:10 +0300
Message-ID: <20261027111710.112743-1-angsblommansken@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rename qcom_icc_bcm members vote_x, vote_y, and vote_scale to avg_bw,
peak_bw, and bw_scale, respectively.

vote_x and vote_y are legacy names inherited from the low-level BCM
vote encoding. They describe X and Y rather than the actual values,
which represent average and peak bandwidth. At the command encoding
level, X and Y make sense. In the data structure, they make readers
remember an implementation detail that the code can name directly.

These names also match struct icc_node in <linux/interconnect.h>,
which already uses avg_bw and peak_bw for the same bandwidth dimensions.
Keeping the same terminology across the core API and the Qualcomm
provider is preferable to maintaining a second naming scheme for the
same concepts.

Sure, we could keep the vote_ prefix and use vote_avg_bw and
vote_peak_bw. Both names would be valid. But qcom_icc_bcm already
provides the voting context, so what exactly would that extra prefix
explain? We would essentially say "vote" twice without making either
bandwidth component any clearer.

Rename vote_scale to bw_scale as well.

Keep vote_x and vote_y unchanged in the TCS command interface, where
they describe the hardware-level encoding rather than the BCM data
structure.

Signed-off-by: Ängsblomsterskymningen Zefir Månskensåkerhöjden Zetterstrand <angsblommansken@gmail.com>
---
 drivers/interconnect/qcom/bcm-voter.c | 58 +++++++++++++--------------
 drivers/interconnect/qcom/eliza.c     |  4 +-
 drivers/interconnect/qcom/glymur.c    |  6 +--
 drivers/interconnect/qcom/hawi.c      | 10 ++---
 drivers/interconnect/qcom/icc-rpmh.c  | 38 +++++++++---------
 drivers/interconnect/qcom/icc-rpmh.h  | 14 +++----
 drivers/interconnect/qcom/kaanapali.c | 10 ++---
 drivers/interconnect/qcom/kuno.c      |  2 +-
 drivers/interconnect/qcom/maili.c     | 12 +++---
 drivers/interconnect/qcom/milos.c     |  4 +-
 drivers/interconnect/qcom/nord.c      |  8 ++--
 drivers/interconnect/qcom/qcs615.c    |  2 +-
 drivers/interconnect/qcom/qcs8300.c   |  6 +--
 drivers/interconnect/qcom/sa8775p.c   |  6 +--
 drivers/interconnect/qcom/sar2130p.c  |  4 +-
 drivers/interconnect/qcom/sc7280.c    |  4 +-
 drivers/interconnect/qcom/sc8280xp.c  |  6 +--
 drivers/interconnect/qcom/sdx75.c     |  2 +-
 drivers/interconnect/qcom/sm8450.c    |  6 +--
 drivers/interconnect/qcom/sm8550.c    |  6 +--
 drivers/interconnect/qcom/sm8650.c    |  6 +--
 drivers/interconnect/qcom/sm8750.c    |  6 +--
 drivers/interconnect/qcom/x1e80100.c  |  6 +--
 23 files changed, 113 insertions(+), 113 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index 0880a287b0c0..6cb426656a63 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -54,26 +54,26 @@ static void bcm_aggregate_mask(struct qcom_icc_bcm *bcm)
 	int bucket, i;
 
 	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
-		bcm->vote_x[bucket] = 0;
-		bcm->vote_y[bucket] = 0;
+		bcm->avg_bw[bucket] = 0;
+		bcm->peak_bw[bucket] = 0;
 
 		for (i = 0; i < bcm->num_nodes; i++) {
 			node = bcm->nodes[i];
 
 			/* If any vote in this bucket exists, keep the BCM enabled */
 			if (node->sum_avg[bucket] || node->max_peak[bucket]) {
-				bcm->vote_x[bucket] = 0;
-				bcm->vote_y[bucket] = bcm->enable_mask;
+				bcm->avg_bw[bucket] = 0;
+				bcm->peak_bw[bucket] = bcm->enable_mask;
 				break;
 			}
 		}
 	}
 
 	if (bcm->keepalive) {
-		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = bcm->enable_mask;
-		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = bcm->enable_mask;
-		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = bcm->enable_mask;
-		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = bcm->enable_mask;
+		bcm->avg_bw[QCOM_ICC_BUCKET_AMC] = bcm->enable_mask;
+		bcm->avg_bw[QCOM_ICC_BUCKET_WAKE] = bcm->enable_mask;
+		bcm->peak_bw[QCOM_ICC_BUCKET_AMC] = bcm->enable_mask;
+		bcm->peak_bw[QCOM_ICC_BUCKET_WAKE] = bcm->enable_mask;
 	}
 }
 
@@ -97,19 +97,19 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 			agg_peak[bucket] = max(agg_peak[bucket], temp);
 		}
 
-		temp = agg_avg[bucket] * bcm->vote_scale;
-		bcm->vote_x[bucket] = qcom_bw_div(temp, le32_to_cpu(bcm->aux_data.unit));
+		temp = agg_avg[bucket] * bcm->bw_scale;
+		bcm->avg_bw[bucket] = qcom_bw_div(temp, le32_to_cpu(bcm->aux_data.unit));
 
-		temp = agg_peak[bucket] * bcm->vote_scale;
-		bcm->vote_y[bucket] = qcom_bw_div(temp, le32_to_cpu(bcm->aux_data.unit));
+		temp = agg_peak[bucket] * bcm->bw_scale;
+		bcm->peak_bw[bucket] = qcom_bw_div(temp, le32_to_cpu(bcm->aux_data.unit));
 	}
 
-	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
-	    bcm->vote_y[QCOM_ICC_BUCKET_AMC] == 0) {
-		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = 1;
-		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = 1;
-		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = 1;
-		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = 1;
+	if (bcm->keepalive && bcm->avg_bw[QCOM_ICC_BUCKET_AMC] == 0 &&
+	    bcm->peak_bw[QCOM_ICC_BUCKET_AMC] == 0) {
+		bcm->avg_bw[QCOM_ICC_BUCKET_AMC] = 1;
+		bcm->avg_bw[QCOM_ICC_BUCKET_WAKE] = 1;
+		bcm->peak_bw[QCOM_ICC_BUCKET_AMC] = 1;
+		bcm->peak_bw[QCOM_ICC_BUCKET_WAKE] = 1;
 	}
 }
 
@@ -164,8 +164,8 @@ static void tcs_list_gen(struct bcm_voter *voter, int bucket,
 
 		wait = commit && (voter->tcs_wait & BIT(bucket));
 
-		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x[bucket],
-			    bcm->vote_y[bucket], bcm->addr, commit, wait);
+		tcs_cmd_gen(&tcs_list[idx], bcm->avg_bw[bucket],
+			    bcm->peak_bw[bucket], bcm->addr, commit, wait);
 		idx++;
 		n[batch]++;
 		/*
@@ -260,7 +260,7 @@ void qcom_icc_bcm_get_bw(struct bcm_voter *voter,
 {
 	struct tcs_cmd cmd = { .addr = bcm->addr };
 	int ret, i;
-	u64 x, y;
+	u64 avg_bw, peak_bw;
 
 	mutex_lock(&voter->lock);
 
@@ -270,13 +270,13 @@ void qcom_icc_bcm_get_bw(struct bcm_voter *voter,
 		goto out;
 	}
 
-	x = FIELD_GET(BCM_TCS_CMD_VOTE_X_MASK, cmd.data);
-	y = FIELD_GET(BCM_TCS_CMD_VOTE_Y_MASK, cmd.data);
+	avg_bw = FIELD_GET(BCM_TCS_CMD_VOTE_X_MASK, cmd.data);
+	peak_bw = FIELD_GET(BCM_TCS_CMD_VOTE_Y_MASK, cmd.data);
 
 	/* For boot-up, fill the AMC vote in all buckets */
 	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
-		bcm->vote_x[i] = x;
-		bcm->vote_y[i] = y;
+		bcm->avg_bw[i] = avg_bw;
+		bcm->peak_bw[i] = peak_bw;
 	}
 
 out:
@@ -351,10 +351,10 @@ int qcom_icc_bcm_voter_commit(struct bcm_voter *voter)
 		 * requirements change as the execution environment transitions
 		 * between different power states.
 		 */
-		if (bcm->vote_x[QCOM_ICC_BUCKET_WAKE] !=
-		    bcm->vote_x[QCOM_ICC_BUCKET_SLEEP] ||
-		    bcm->vote_y[QCOM_ICC_BUCKET_WAKE] !=
-		    bcm->vote_y[QCOM_ICC_BUCKET_SLEEP])
+		if (bcm->avg_bw[QCOM_ICC_BUCKET_WAKE] !=
+		    bcm->avg_bw[QCOM_ICC_BUCKET_SLEEP] ||
+		    bcm->peak_bw[QCOM_ICC_BUCKET_WAKE] !=
+		    bcm->peak_bw[QCOM_ICC_BUCKET_SLEEP])
 			list_add_tail(&bcm->list, &voter->commit_list);
 		else
 			list_del_init(&bcm->ws_list);
diff --git a/drivers/interconnect/qcom/eliza.c b/drivers/interconnect/qcom/eliza.c
index ad03adef79ba..367e337e23c6 100644
--- a/drivers/interconnect/qcom/eliza.c
+++ b/drivers/interconnect/qcom/eliza.c
@@ -1187,7 +1187,7 @@ static struct qcom_icc_bcm bcm_mm1 = {
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
@@ -1195,7 +1195,7 @@ static struct qcom_icc_bcm bcm_qup1 = {
 
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup2_core_slave },
diff --git a/drivers/interconnect/qcom/glymur.c b/drivers/interconnect/qcom/glymur.c
index 9b9ed99ef242..f41cce8ed57a 100644
--- a/drivers/interconnect/qcom/glymur.c
+++ b/drivers/interconnect/qcom/glymur.c
@@ -1764,7 +1764,7 @@ static struct qcom_icc_bcm bcm_mm1 = {
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
@@ -1772,7 +1772,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
@@ -1780,7 +1780,7 @@ static struct qcom_icc_bcm bcm_qup1 = {
 
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup2_core_slave },
diff --git a/drivers/interconnect/qcom/hawi.c b/drivers/interconnect/qcom/hawi.c
index 6ece9828c62d..fed118a3be12 100644
--- a/drivers/interconnect/qcom/hawi.c
+++ b/drivers/interconnect/qcom/hawi.c
@@ -1441,7 +1441,7 @@ static struct qcom_icc_bcm bcm_qpc0 = {
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
@@ -1449,7 +1449,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
 };
@@ -1457,7 +1457,7 @@ static struct qcom_icc_bcm bcm_qup1 = {
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup2_core_slave },
 };
@@ -1465,7 +1465,7 @@ static struct qcom_icc_bcm bcm_qup2 = {
 static struct qcom_icc_bcm bcm_qup3 = {
 	.name = "QUP3",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup3_core_slave },
 };
@@ -1473,7 +1473,7 @@ static struct qcom_icc_bcm bcm_qup3 = {
 static struct qcom_icc_bcm bcm_qup4 = {
 	.name = "QUP4",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup4_core_slave },
 };
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 4a2a746a4e59..a05b1f534f56 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -141,7 +141,7 @@ static int qcom_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
 	struct qcom_icc_node *qn = node->data;
 	u32 avg_max = 0;
 	u32 peak_max = 0;
-	u64 x, y;
+	u64 avg_bw, peak_bw;
 	int i;
 
 	if (!qn->num_bcms) {
@@ -155,32 +155,32 @@ static int qcom_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
 		struct qcom_icc_bcm *bcm = qn->bcms[i];
 
 		/* Use AMC vote for boot-up */
-		x = bcm->vote_x[QCOM_ICC_BUCKET_AMC];
-		y = bcm->vote_y[QCOM_ICC_BUCKET_AMC];
+		avg_bw = bcm->avg_bw[QCOM_ICC_BUCKET_AMC];
+		peak_bw = bcm->peak_bw[QCOM_ICC_BUCKET_AMC];
 
 		/* Consider enable mask and convert to INT_MAX */
 		if (bcm->enable_mask) {
-			if (x & bcm->enable_mask)
+			if (avg_bw & bcm->enable_mask)
 				avg_max = INT_MAX;
-			if (y & bcm->enable_mask)
+			if (peak_bw & bcm->enable_mask)
 				peak_max = INT_MAX;
 		} else {
-			if (x) {
-				x *= le32_to_cpu(bcm->aux_data.unit);
-				do_div(x, bcm->vote_scale);
-				x *= qn->buswidth * qn->channels;
-				do_div(x, le16_to_cpu(bcm->aux_data.width));
+			if (avg_bw) {
+				avg_bw *= le32_to_cpu(bcm->aux_data.unit);
+				do_div(avg_bw, bcm->bw_scale);
+				avg_bw *= qn->buswidth * qn->channels;
+				do_div(avg_bw, le16_to_cpu(bcm->aux_data.width));
 
-				avg_max = max(avg_max, x);
+				avg_max = max(avg_max, avg_bw);
 			}
 
-			if (y) {
-				y *= le32_to_cpu(bcm->aux_data.unit);
-				do_div(y, bcm->vote_scale);
-				y *= qn->buswidth;
-				do_div(y, le16_to_cpu(bcm->aux_data.width));
+			if (peak_bw) {
+				peak_bw *= le32_to_cpu(bcm->aux_data.unit);
+				do_div(peak_bw, bcm->bw_scale);
+				peak_bw *= qn->buswidth;
+				do_div(peak_bw, le16_to_cpu(bcm->aux_data.width));
 
-				peak_max = max(peak_max, y);
+				peak_max = max(peak_max, peak_bw);
 			}
 		}
 	}
@@ -232,8 +232,8 @@ int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
 	INIT_LIST_HEAD(&bcm->list);
 	INIT_LIST_HEAD(&bcm->ws_list);
 
-	if (!bcm->vote_scale)
-		bcm->vote_scale = 1000;
+	if (!bcm->bw_scale)
+		bcm->bw_scale = 1000;
 
 	/* Link Qnodes to their respective BCMs */
 	for (i = 0; i < bcm->num_nodes; i++) {
diff --git a/drivers/interconnect/qcom/icc-rpmh.h b/drivers/interconnect/qcom/icc-rpmh.h
index 09d8791402dc..b55db9f21edd 100644
--- a/drivers/interconnect/qcom/icc-rpmh.h
+++ b/drivers/interconnect/qcom/icc-rpmh.h
@@ -112,10 +112,10 @@ struct qcom_icc_node {
  * @name: the bcm node name used to fetch BCM data from command db
  * @type: latency or bandwidth bcm
  * @addr: address offsets used when voting to RPMH
- * @vote_x: aggregated threshold values, represents sum_bw when @type is bw bcm
- * @vote_y: aggregated threshold values, represents peak_bw when @type is bw bcm
- * @vote_scale: scaling factor for vote_x and vote_y
- * @enable_mask: optional mask to send as vote instead of vote_x/vote_y
+ * @avg_bw: aggregate representing sum of average bandwidth for bandwidth BCMs
+ * @peak_bw: aggregate representing peak bandwidth for bandwidth BCMs
+ * @bw_scale: bandwidth scaling factor for @avg_bw and @peak_bw
+ * @enable_mask: optional mask voted instead of @avg_bw/@peak_bw
  * @dirty: flag used to indicate whether the bcm needs to be committed
  * @keepalive: flag used to indicate whether a keepalive is required
  * @aux_data: auxiliary data used when calculating threshold values and
@@ -129,9 +129,9 @@ struct qcom_icc_bcm {
 	const char *name;
 	u32 type;
 	u32 addr;
-	u64 vote_x[QCOM_ICC_NUM_BUCKETS];
-	u64 vote_y[QCOM_ICC_NUM_BUCKETS];
-	u64 vote_scale;
+	u64 avg_bw[QCOM_ICC_NUM_BUCKETS];
+	u64 peak_bw[QCOM_ICC_NUM_BUCKETS];
+	u64 bw_scale;
 	u32 enable_mask;
 	bool dirty;
 	bool keepalive;
diff --git a/drivers/interconnect/qcom/kaanapali.c b/drivers/interconnect/qcom/kaanapali.c
index d6e7327bfd7f..a7cc365d24bd 100644
--- a/drivers/interconnect/qcom/kaanapali.c
+++ b/drivers/interconnect/qcom/kaanapali.c
@@ -1320,7 +1320,7 @@ static struct qcom_icc_bcm bcm_qpc0 = {
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
@@ -1328,7 +1328,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
 };
@@ -1336,7 +1336,7 @@ static struct qcom_icc_bcm bcm_qup1 = {
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup2_core_slave },
 };
@@ -1344,7 +1344,7 @@ static struct qcom_icc_bcm bcm_qup2 = {
 static struct qcom_icc_bcm bcm_qup3 = {
 	.name = "QUP3",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup3_core_slave },
 };
@@ -1352,7 +1352,7 @@ static struct qcom_icc_bcm bcm_qup3 = {
 static struct qcom_icc_bcm bcm_qup4 = {
 	.name = "QUP4",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup4_core_slave },
 };
diff --git a/drivers/interconnect/qcom/kuno.c b/drivers/interconnect/qcom/kuno.c
index 546622cf8cea..018a055938cc 100644
--- a/drivers/interconnect/qcom/kuno.c
+++ b/drivers/interconnect/qcom/kuno.c
@@ -708,7 +708,7 @@ static struct qcom_icc_bcm bcm_mc0 = {
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
diff --git a/drivers/interconnect/qcom/maili.c b/drivers/interconnect/qcom/maili.c
index e5eed7f998f9..c5325d7cb7f1 100644
--- a/drivers/interconnect/qcom/maili.c
+++ b/drivers/interconnect/qcom/maili.c
@@ -1488,7 +1488,7 @@ static struct qcom_icc_bcm bcm_qpc0 = {
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
@@ -1496,7 +1496,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
@@ -1504,7 +1504,7 @@ static struct qcom_icc_bcm bcm_qup1 = {
 
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup2_core_slave },
@@ -1512,7 +1512,7 @@ static struct qcom_icc_bcm bcm_qup2 = {
 
 static struct qcom_icc_bcm bcm_qup3 = {
 	.name = "QUP3",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup3_core_slave },
@@ -1520,7 +1520,7 @@ static struct qcom_icc_bcm bcm_qup3 = {
 
 static struct qcom_icc_bcm bcm_qup4 = {
 	.name = "QUP4",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup4_core_slave },
@@ -1528,7 +1528,7 @@ static struct qcom_icc_bcm bcm_qup4 = {
 
 static struct qcom_icc_bcm bcm_qup5 = {
 	.name = "QUP5",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup5_core_slave },
diff --git a/drivers/interconnect/qcom/milos.c b/drivers/interconnect/qcom/milos.c
index 8b5b5ee53e3b..3f520a1d856e 100644
--- a/drivers/interconnect/qcom/milos.c
+++ b/drivers/interconnect/qcom/milos.c
@@ -1438,7 +1438,7 @@ static struct qcom_icc_bcm bcm_mm1 = {
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
@@ -1446,7 +1446,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
 };
diff --git a/drivers/interconnect/qcom/nord.c b/drivers/interconnect/qcom/nord.c
index b3ca5675e7c8..40e469fe5294 100644
--- a/drivers/interconnect/qcom/nord.c
+++ b/drivers/interconnect/qcom/nord.c
@@ -1949,7 +1949,7 @@ static struct qcom_icc_bcm bcm_mm1 = {
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
@@ -1957,7 +1957,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
@@ -1965,7 +1965,7 @@ static struct qcom_icc_bcm bcm_qup1 = {
 
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup2_core_slave },
@@ -1973,7 +1973,7 @@ static struct qcom_icc_bcm bcm_qup2 = {
 
 static struct qcom_icc_bcm bcm_qup3 = {
 	.name = "QUP3",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup3_core_slave },
diff --git a/drivers/interconnect/qcom/qcs615.c b/drivers/interconnect/qcom/qcs615.c
index 017a6017421f..f7743d1d95e3 100644
--- a/drivers/interconnect/qcom/qcs615.c
+++ b/drivers/interconnect/qcom/qcs615.c
@@ -1277,7 +1277,7 @@ static struct qcom_icc_bcm bcm_mm3 = {
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 2,
 	.nodes = { &qhm_qup0, &qhm_qup1 },
 };
diff --git a/drivers/interconnect/qcom/qcs8300.c b/drivers/interconnect/qcom/qcs8300.c
index ebf167182572..14ca3493d413 100644
--- a/drivers/interconnect/qcom/qcs8300.c
+++ b/drivers/interconnect/qcom/qcs8300.c
@@ -1780,7 +1780,7 @@ static struct qcom_icc_bcm bcm_pci0 = {
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
@@ -1788,7 +1788,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
@@ -1796,7 +1796,7 @@ static struct qcom_icc_bcm bcm_qup1 = {
 
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.keepalive = true,
 	.num_nodes = 1,
 	.nodes = { &qup3_core_slave },
diff --git a/drivers/interconnect/qcom/sa8775p.c b/drivers/interconnect/qcom/sa8775p.c
index 998a22d9d46d..00a8da66eb02 100644
--- a/drivers/interconnect/qcom/sa8775p.c
+++ b/drivers/interconnect/qcom/sa8775p.c
@@ -2073,21 +2073,21 @@ static struct qcom_icc_bcm bcm_pci0 = {
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
 };
 
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 2,
 	.nodes = { &qup2_core_slave, &qup3_core_slave },
 };
diff --git a/drivers/interconnect/qcom/sar2130p.c b/drivers/interconnect/qcom/sar2130p.c
index 34cb3fc1f995..a0b3975714e7 100644
--- a/drivers/interconnect/qcom/sar2130p.c
+++ b/drivers/interconnect/qcom/sar2130p.c
@@ -1395,7 +1395,7 @@ static struct qcom_icc_bcm bcm_mm1 = {
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
@@ -1403,7 +1403,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
 };
diff --git a/drivers/interconnect/qcom/sc7280.c b/drivers/interconnect/qcom/sc7280.c
index da21db2bdb7f..29accc1544f2 100644
--- a/drivers/interconnect/qcom/sc7280.c
+++ b/drivers/interconnect/qcom/sc7280.c
@@ -1494,14 +1494,14 @@ static struct qcom_icc_bcm bcm_mm5 = {
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
 };
diff --git a/drivers/interconnect/qcom/sc8280xp.c b/drivers/interconnect/qcom/sc8280xp.c
index 15e284fcd89a..67d1876b46d9 100644
--- a/drivers/interconnect/qcom/sc8280xp.c
+++ b/drivers/interconnect/qcom/sc8280xp.c
@@ -2147,21 +2147,21 @@ static struct qcom_icc_bcm bcm_pci0 = {
 
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
 
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
 };
 
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup2_core_slave },
 };
diff --git a/drivers/interconnect/qcom/sdx75.c b/drivers/interconnect/qcom/sdx75.c
index 5cfccc6cfd1b..241991c32e25 100644
--- a/drivers/interconnect/qcom/sdx75.c
+++ b/drivers/interconnect/qcom/sdx75.c
@@ -776,7 +776,7 @@ static struct qcom_icc_bcm bcm_mc0 = {
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
diff --git a/drivers/interconnect/qcom/sm8450.c b/drivers/interconnect/qcom/sm8450.c
index 54c860b16eb0..6a282b789622 100644
--- a/drivers/interconnect/qcom/sm8450.c
+++ b/drivers/interconnect/qcom/sm8450.c
@@ -1357,7 +1357,7 @@ static struct qcom_icc_bcm bcm_mm1 = {
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
@@ -1365,7 +1365,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
 };
@@ -1373,7 +1373,7 @@ static struct qcom_icc_bcm bcm_qup1 = {
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup2_core_slave },
 };
diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
index 535097eab537..d77ea9cfa74f 100644
--- a/drivers/interconnect/qcom/sm8550.c
+++ b/drivers/interconnect/qcom/sm8550.c
@@ -1153,7 +1153,7 @@ static struct qcom_icc_bcm bcm_mm1 = {
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
@@ -1161,7 +1161,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
 };
@@ -1169,7 +1169,7 @@ static struct qcom_icc_bcm bcm_qup1 = {
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup2_core_slave },
 };
diff --git a/drivers/interconnect/qcom/sm8650.c b/drivers/interconnect/qcom/sm8650.c
index 1967475b9132..6c7ee15a50a2 100644
--- a/drivers/interconnect/qcom/sm8650.c
+++ b/drivers/interconnect/qcom/sm8650.c
@@ -1517,7 +1517,7 @@ static struct qcom_icc_bcm bcm_mm1 = {
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
@@ -1525,7 +1525,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
 };
@@ -1533,7 +1533,7 @@ static struct qcom_icc_bcm bcm_qup1 = {
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup2_core_slave },
 };
diff --git a/drivers/interconnect/qcom/sm8750.c b/drivers/interconnect/qcom/sm8750.c
index 1486c0b8f4c1..a1ac4bc40967 100644
--- a/drivers/interconnect/qcom/sm8750.c
+++ b/drivers/interconnect/qcom/sm8750.c
@@ -1111,7 +1111,7 @@ static struct qcom_icc_bcm bcm_mm1 = {
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
@@ -1119,7 +1119,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
 };
@@ -1127,7 +1127,7 @@ static struct qcom_icc_bcm bcm_qup1 = {
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup2_core_slave },
 };
diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
index 2ba2823c7860..c3e037b2cd43 100644
--- a/drivers/interconnect/qcom/x1e80100.c
+++ b/drivers/interconnect/qcom/x1e80100.c
@@ -1390,7 +1390,7 @@ static struct qcom_icc_bcm bcm_pc0 = {
 static struct qcom_icc_bcm bcm_qup0 = {
 	.name = "QUP0",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup0_core_slave },
 };
@@ -1398,7 +1398,7 @@ static struct qcom_icc_bcm bcm_qup0 = {
 static struct qcom_icc_bcm bcm_qup1 = {
 	.name = "QUP1",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup1_core_slave },
 };
@@ -1406,7 +1406,7 @@ static struct qcom_icc_bcm bcm_qup1 = {
 static struct qcom_icc_bcm bcm_qup2 = {
 	.name = "QUP2",
 	.keepalive = true,
-	.vote_scale = 1,
+	.bw_scale = 1,
 	.num_nodes = 1,
 	.nodes = { &qup2_core_slave },
 };
-- 
2.56.0

