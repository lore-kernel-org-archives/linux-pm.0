Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22F7545D8C
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189476; cv=none; b=uI03GtG6gyRW6j+FWxqMKMnp3ZDhWR45DeR5/wGVy052NGylYqTF7EhqCpR+6BSbZJoatrw6dP5IILmerhUF/JaYLDh8EkWrpm0AzNZ/XdwHzKkOKSn+pWFrqiXjMZQSUNLCEbev8l344X/UdV4azIvqFnWmgG3b2Liql2HbTU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189476; c=relaxed/simple;
	bh=Klb6dIIWDbivq7Nwzx0pLrjmulwzyzTJfh2mCwsjH78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H04QGYVSz6N6pUWrMVog0CGe1lvIRYQkRQl4rMfgphXXjLlMzkZaeu8/fHvx2L6PWdxSuk7gHHLri1sut0dG8Wzu+nIdBkrCobe1LnUIdZoqJxMxuQfDgLHEluWEsoQCOPZE86lI2IQvAmNmvSIvE1WYUoU+oVMdZbvxpQ0sKaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sjRNo8Zy; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjRNo8Zy"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba91so732681a91.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790189462; x=1790794262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s2RyWeLbmlvlzy0g98C/45Akp7E/hTZac2wRMvl2ThY=;
        b=sjRNo8Zy++N4nwIiZXjpCtjR8XSxxx9C74RhypZVb+O/4qfq1ZIcN3N2Q5ZHhhKVhY
         ybV86yugoUrYyVPY84uqDCkSfxJTaoZSgDLLRla6E5HZAKuP0yekmNIHM5x/KezMbQEH
         C1+wLRTjLRWfSf20meUA2b6C6KlSLuL02FEIjRpsMoRjzDORdb1MgdYcXbl7ATgdp2ml
         esvCFGN5M9evMPLWUVAWXRjsIeGfzsuTEWXPUIcJTEU8gi4p5X9SxZGaWIWnbHvOvKJE
         s6Q0PePrUvHyOFJURD/w/qSI6TQlXGuqIbSG25AVBC+nB9PBAU0BilxpA3zgWmPScaDT
         yBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790189462; x=1790794262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s2RyWeLbmlvlzy0g98C/45Akp7E/hTZac2wRMvl2ThY=;
        b=EYl9Erf6jj4B0g3SWLq4b3Npw0YD06RPRvPGSu95LqFWW1uso0SXH2vvohxQ9BvE1j
         GR1l9l2gfrM5hF00tfPzpTHYF8uF93UPncafWsFe/i1hFFjx5KPvp4XxDc71a02m5zQW
         fydvatadUAAL/jO17yvt1LT4AhiDJr1HLMwxIcDGq4HkCbgHcCWLxhqpu4jOGI73Ddad
         Rkbr/6VcifBz8PX3nGOnN43q3//mKFCZqYkTg6VOnVEMsM3BF5sdzZcfrGaP8xW7Hc7M
         A7suwRyOCJZrJrgpBryH858qVLtczz6IQ15G1G3sI+/vXRIWOPchu9VwW+PPx2dBH3Gl
         UPrw==
X-Gm-Message-State: AFuF++ltUShbrk8q6wti0idHHGE6NQajKjRNmj9qiRC1eYMtCkLppJxt
	ef+A6oRbZshjvQG1/+GIqmyq/iuj0jv7ltJ7Fl4qyF5URp5J3W5l/mUIQQepkw==
X-Gm-Gg: AYBFou1/ru/ztnUDZnvACB86RYb4yAdd2Vr0mBZfe6jw7ktyaJa8Vsk8u56d+diyfvd
	L3p6B3IEWRGE3AFDR45UfDbiPrxWSxcjkYRh4SfBjDRvzX0JK9tOeaXi6mMVS9UH7cg7tWF+cgr
	24c8a6QKSQ1mYUAlcuyi05SlAqpla+PG+atjbMT3IKmmrZah3Xlh3dgIr47DUuTciY73bEO6y/j
	2Yd2/h2hOgCv4rvvha3s8ezFiWBqwJqikAINaR2LoX9/7dBGYaO5ibR+flIzvcZ6AXVoAAr7s+x
	xHBkJsRslp29V4M5Z9MKeMHYBcdyvbGgHX42UU/tFdmUX1LANxGt6jRvrXTYBrvZ1V02ueERYRq
	yxBYf+l+gFwf+84znjCmlcD2+eOq0On2qOiOA2azQMG5kHl+9I+snTqqniV6T/UyKoUPOUjeydP
	CNRoLkMkPoK+w63B5F3pYak3c7ekMxBGxo4TaAa44iHVqkVk4H/5tvKHrZAvmj+U0ymD4QSoB5r
	TJ27zpShbkp50YKjdja6WWIMfa1RAQZi98LX1gJx2LId0HVACRPoKxtMJCK3mEqM4I2VLxMBnCV
	1JWenykKA27WJTXC6lb3LBeogKlX7sP1bZqaIXhvuOu5fk7h9w==
X-Received: by 2002:a17:90a:d88e:b0:398:9c39:520f with SMTP id 98e67ed59e1d1-3a0985b8f62mr75751a91.15.1790189461897;
        Wed, 23 Sep 2026 11:51:01 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a081274d7fsm2148797a91.2.2026.09.23.11.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:51:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Georgi Djakov <djakov@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] interconnect: qcom: fix endian annotations of BCM aux data
Date: Wed, 23 Sep 2026 11:50:59 -0700
Message-ID: <20260923185059.25196-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct qcom_icc_bcm::aux_data keeps a copy of the struct bcm_db read
from the command db, whose unit and width fields are annotated as
__le32/__le16 to describe the little-endian on-disk format. Using
those restricted types directly in bandwidth calculations makes sparse
complain about endianness.

Keep aux_data typed as struct bcm_db, copied verbatim from the command
db buffer, and convert the fields with le32_to_cpu()/le16_to_cpu() at
the places where unit and width are used. No functional change.

Fixes: c96fc14322ce ("interconnect: qcom: add COMPILE_TEST")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609221350.3Y8MOce9-lkp@intel.com/
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: don't use a separate struct
 drivers/interconnect/qcom/bcm-voter.c |  8 ++++----
 drivers/interconnect/qcom/icc-rpmh.c  | 13 +++++--------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index 6c7e9a7c17e2..0880a287b0c0 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -88,20 +88,20 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 	for (bucket = 0; bucket < QCOM_ICC_NUM_BUCKETS; bucket++) {
 		for (i = 0; i < bcm->num_nodes; i++) {
 			node = bcm->nodes[i];
-			temp = qcom_bw_div(node->sum_avg[bucket] * bcm->aux_data.width,
+			temp = qcom_bw_div(node->sum_avg[bucket] * le16_to_cpu(bcm->aux_data.width),
 					   node->buswidth * node->channels);
 			agg_avg[bucket] = max(agg_avg[bucket], temp);
 
-			temp = qcom_bw_div(node->max_peak[bucket] * bcm->aux_data.width,
+			temp = qcom_bw_div(node->max_peak[bucket] * le16_to_cpu(bcm->aux_data.width),
 					   node->buswidth);
 			agg_peak[bucket] = max(agg_peak[bucket], temp);
 		}
 
 		temp = agg_avg[bucket] * bcm->vote_scale;
-		bcm->vote_x[bucket] = qcom_bw_div(temp, bcm->aux_data.unit);
+		bcm->vote_x[bucket] = qcom_bw_div(temp, le32_to_cpu(bcm->aux_data.unit));
 
 		temp = agg_peak[bucket] * bcm->vote_scale;
-		bcm->vote_y[bucket] = qcom_bw_div(temp, bcm->aux_data.unit);
+		bcm->vote_y[bucket] = qcom_bw_div(temp, le32_to_cpu(bcm->aux_data.unit));
 	}
 
 	if (bcm->keepalive && bcm->vote_x[QCOM_ICC_BUCKET_AMC] == 0 &&
diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 7f2b5673629b..45662d1a2060 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -166,19 +166,19 @@ static int qcom_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
 				peak_max = INT_MAX;
 		} else {
 			if (x) {
-				x *= bcm->aux_data.unit;
+				x *= le32_to_cpu(bcm->aux_data.unit);
 				do_div(x, bcm->vote_scale);
 				x *= qn->buswidth * qn->channels;
-				do_div(x, bcm->aux_data.width);
+				do_div(x, le16_to_cpu(bcm->aux_data.width));
 
 				avg_max = max(avg_max, x);
 			}
 
 			if (y) {
-				y *= bcm->aux_data.unit;
+				y *= le32_to_cpu(bcm->aux_data.unit);
 				do_div(y, bcm->vote_scale);
 				y *= qn->buswidth;
-				do_div(y, bcm->aux_data.width);
+				do_div(y, le16_to_cpu(bcm->aux_data.width));
 
 				peak_max = max(peak_max, y);
 			}
@@ -228,10 +228,7 @@ int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
 		return -EINVAL;
 	}
 
-	bcm->aux_data.unit = le32_to_cpu(data->unit);
-	bcm->aux_data.width = le16_to_cpu(data->width);
-	bcm->aux_data.vcd = data->vcd;
-	bcm->aux_data.reserved = data->reserved;
+	bcm->aux_data = *data;
 	INIT_LIST_HEAD(&bcm->list);
 	INIT_LIST_HEAD(&bcm->ws_list);
 
-- 
2.55.0

