Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FBC40803B
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355863; cv=none; b=TpSjQXpcyfkhGAIzBzu+rbNGd1ddsbN78pATYEFqEf+vbnc75T/c0npkoOZLa2OHCp4zPZzznqhtjJbshoKm+U3D8iekCuy16IdY78HnqGFdt2PYPAz0RD7iKcaK26l1xCPWBo2Pg3BTH6fyn/zaqI0hygHXdxhOtJQwqlga0xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355863; c=relaxed/simple;
	bh=aqwYlbBZfPmAovG9tQvJQ34ckDn3s8ZtxB+c4NH+OBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=En84qcSvOqK+kxS5Kmg3+TYYkO3PJcUP55p184JcJ34/H4fCz1E7X3gAhdZb+2L3XQQjdngBZjt247+ha97bcFhauVKNQhziJgYWAOGW5Sv6QGNRA+f6I3DPNTIrP0tHWiP8AjYvXUHi92cgHKcpkLugN97snECo9Hu8Fg+szH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ASLcHgRR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cg7pMHTG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ASLcHgRR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cg7pMHTG"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6974TvJA3923451
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 06:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	52nzYadmue4RW4uwDkTflPSkr2BZLVWcOLb+4ASjXtk=; b=ASLcHgRRptef5lgR
	RwEp8AqhDOPJ9G3CrS73dkAPuI/kz0Zo1FczV9FCv/HqPaht+22y+lX8CXzxdMlT
	wPMmLVodl1X8GhVMQrofDQnMSMMUiWpX2IRT2ReamK8YQH7KdcUpLt3fEwaTnbur
	y+43ufPhmMEfTu2/sovHUqfkfee1O4Vq1pDUW3OqzvlkZqEFJ9LErV2COifmIRid
	QgzcjWdBNM8FbkXWIbXUsKqqXzi4BX49ZZEQryGCTIrVLv4lo0OLNpn58kcmvAnp
	UiLlTauM232+LsE40rxmMQVvuhpo4yk/SxlkoRlWu6N8f85ZCjdZz/Kej0tCKHOZ
	V1doQw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c718x9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 06:51:00 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35158d674e1so2929958eec.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791355860; x=1791960660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=52nzYadmue4RW4uwDkTflPSkr2BZLVWcOLb+4ASjXtk=;
        b=Cg7pMHTGZRmYjOcfaEvDUjtUll+SS36QFaU37OndegXk3MxVlM8bSp/EBdHtqwSwWO
         lkr8BF79tVbq4KZmwoZpG2EiwVG7TBhEIh2DTBugaJ6i1/zbI4kJ1whmNXjIc0uGA7eF
         A+Pdloulmyl1xtnFKxjEjEnqYjlPiaSz9wjHFD2ejT3YKeFXYSAArt6kqdB7UTKgxOhV
         04cXgbqRjeHanzTccntmjCCD0JRb7v5/d4tIr80nPARNJ+geKMOKn+TKpVhf4Dno6hSp
         tPTNOougKuNKiA8ILO8IEcFTxIwZZLw58QJQPMSDz8+1vjn+KRpsV9YG8LgpCqNuiz6u
         LcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791355860; x=1791960660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=52nzYadmue4RW4uwDkTflPSkr2BZLVWcOLb+4ASjXtk=;
        b=uv8Fb8tVvL5JGLaCphA3594StIy26Jqt+T+mhfH0ynbRHgCIXs0Adn5bvoNrlOOBUh
         swnFfO24Yt5LQEjnO+b5U93SXb6Ts77RhOmc5WceiWA5LV8p7u/Dx4I7IBjPUSW+gJrO
         tey3k9yuLwekZ/DtFu9A57fiVPNosqlkKIUz/KDKFbMfklgG4OosmBvmTXZ4j8RSS3GH
         DpGdxr5FkMcqF/hmxh+FlL7mitM5NM2d2ljguWXnWYq3eTZxNZpBcitVf6XGr2WKgBpV
         bqN/jqBEOxp9uP8aapOkE0DjEYr1ZVI28SZdF2vhDqNoTZgpjQFXgOY+LbSrCpw/KGlI
         oHSA==
X-Gm-Message-State: AFuF++kE96lRmeptaHy74n4byWSpVgpUxBhmLW+ptpMFAC9TQNM1zZqT
	K0VRyRZ6cd+HEOi/CgVCPsjnhJhyddubTSPd2j9TS8TMayRq31c4kUHAt2PMoGRruMOSPPyNDj4
	HsmaY2CJavSUm/BZ/AvjGjaqXCPAae33F/cWdCvmmrUWI042jbD11T4/8A1bZkQ==
X-Gm-Gg: AYBFou37mcMGtvsZ7M7RFFKDhjjKAcv0Iaciyr9Femku+q7dhC+SvylHFpWmZ+V+kEl
	YmCbYix/ws8Ekv9cHZvtDzqajkZKMUBPafdrET3wCunnI3YNdm7p46BCBy8MSkGj9BA2HlUjA6k
	szfBNcfvFNQRPsIwdh21qqhVV9G/fhg6WyUWtjQo5zVsVMpVnSzb10nyVTv8wcqxkd3OpRCxoXZ
	T5Dzac8liq8u3oCl6FzdTum9uRYyXM6VC7pRIwS6LRQ4zGBOSuvK2WNzRseCZ62bHXIOEZWpWat
	+Jf/arBjD6gPPPU9nxTAycUc0ttVIRL6gx3wGo1P8ttz16LXGGk2QWl9lT+EYmR6RZCca2nnDa3
	gn7f1OIJDHF9g2JsBbLvJtSgi8Nq7vwXozZl3DM1eqn8vZFQWVnr0Wp+HYFJu0qcw/9ps07ThGT
	vy6Vm0k2zTC+0jaUTfuM/DyaMvW3nrvR7ikYE=
X-Received: by 2002:a05:7022:28d:10b0:144:f47b:58b0 with SMTP id a92af1059eb24-1620ab90a5cmr1315402c88.47.1791355859888;
        Tue, 06 Oct 2026 23:50:59 -0700 (PDT)
X-Received: by 2002:a05:7022:28d:10b0:144:f47b:58b0 with SMTP id a92af1059eb24-1620ab90a5cmr1315366c88.47.1791355859178;
        Tue, 06 Oct 2026 23:50:59 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1615f1ac8c5sm7374730c88.2.2026.10.06.23.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 23:50:58 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 12:20:44 +0530
Subject: [PATCH 1/4] interconnect: icc-clk: support N:1 master-to-slave
 topology
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-ipq9650_apss_clk-v1-1-fd4c2b3cbdea@oss.qualcomm.com>
References: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
In-Reply-To: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX0ITIVc4a/mbx
 wjhFn5Xm1AgwJf1xK0xSJcv4XG6BF4cMgB7Vqg+54vvQiEerg7kpjpbbjW+sq62NoHU/DrWx220
 6tb9cigOre6eX6DnYkN8316omtSHZfQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX0+pXgpeIqY0f
 SMCUxgcSPjmm78DmV7ujezFG/9PkR+3vmnCmcdY+X3G7Jr1Pf8VMxcUdKxgorMs6h5HQ5Qjio2O
 ELULuWGZvTo4khUMZ+PHrpNT8dfMIYsJMvT1oLrB940nzqtG+7+ML1A2KechdI5aPDvajrqto99
 d0ngGtMZFYtO7MxQmhr+efrb+npOtImACbKZmJwM5g3XulTRrxb/rEzBOEZt/Sgo/H79sVKFKH5
 6cPrVRL3op3texvcQ/E5wYq6cWB3MwEvsWKaI10fHGCCFBFZ4DiGQiN7ycMIypcEpggcfQpt97D
 gW/wK+a1iMfTyvPGcKhhnjTp8T1wqOwAY/IP0ioyFQxjE+xfek0q4iKq1riqIlTvAIs9BtGsmDY
 F4sAW9TumqDQSeKuwdUDVCnm+rQxivV9elXcMwdyRsrH5NC2hEy1qmCTQF/GMY/Gy2zWT0H9dho
 s7XXdJZfNFyqLH4K9+w==
X-Proofpoint-GUID: qkR6Vf55ACzqJ_UcxYvJQsclLKfNBjX7
X-Proofpoint-ORIG-GUID: qkR6Vf55ACzqJ_UcxYvJQsclLKfNBjX7
X-Authority-Analysis: v=2.4 cv=LvYHWXdc c=1 sm=1 tr=0 ts=6ac5ebd4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Wq9wk9AxASzClJd40FsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070027

icc_clk_register() assumes each icc_clk_data entry describes a unique
master/slave pair and creates both nodes for every entry. When several
masters share the same slave_id, the shared slave node is created and
added again on each later entry. icc_node_create() returns the existing
node, so icc_node_add() hits WARN_ON(node->provider):

  WARNING: drivers/interconnect/core.c:1103 at icc_node_add+0x10c/0x120
  Call trace:
   icc_node_add+0x10c/0x120 (P)
   icc_clk_register+0x1a4/0x214
   devm_icc_clk_register+0x18/0x80
   qcom_cc_really_probe+0x4c8/0x514
   apss_ipq9650_probe+0xc0/0x108

This topology is needed on IPQ9650, where the silver and gold CPU
clusters both vote on the single L3 clock through a shared SLAVE_L3
node.

The onecell table is also filled in registration order, so xlate only
works when the node IDs happen to match that order. Size the table by
the highest node ID, index it by ID, and skip slave creation when the
node is already registered.

icc_clk_set() also passes only the requesting node's bandwidth to
clk_set_rate(), so the last writer wins. A low vote from one master can
then lower the clock below what another master asked for. Before setting
the rate, take the highest peak bandwidth across all nodes that share
the clock.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/interconnect/icc-clk.c | 45 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index 93c030608d3e..567d071fade8 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -24,7 +24,10 @@ struct icc_clk_provider {
 
 static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
 {
+	unsigned long rate = icc_units_to_bps(src->peak_bw);
+	struct icc_provider *provider = src->provider;
 	struct icc_clk_node *qn = src->data;
+	struct icc_node *node;
 	int ret;
 
 	if (!qn || !qn->clk)
@@ -45,7 +48,21 @@ static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
 		qn->enabled = true;
 	}
 
-	return clk_set_rate(qn->clk, icc_units_to_bps(src->peak_bw));
+	/*
+	 * Multiple master nodes can share the same underlying clock (N:1
+	 * topology, e.g. several CPU clusters voting on one L3 clock).
+	 * Aggregate the peak bandwidth across all of them before setting
+	 * the rate, otherwise the last caller wins and can undervote what
+	 * another master already asked for.
+	 */
+	list_for_each_entry(node, &provider->nodes, node_list) {
+		struct icc_clk_node *n = node->data;
+
+		if (n && clk_is_match(n->clk, qn->clk))
+			rate = max(rate, icc_units_to_bps(node->peak_bw));
+	}
+
+	return clk_set_rate(qn->clk, rate);
 }
 
 static int icc_clk_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
@@ -82,12 +99,17 @@ struct icc_provider *icc_clk_register(struct device *dev,
 	struct icc_provider *provider;
 	struct icc_onecell_data *onecell;
 	struct icc_node *node;
-	int ret, i, j;
+	unsigned int max_id = 0;
+	int ret, i;
 
-	onecell = devm_kzalloc(dev, struct_size(onecell, nodes, 2 * num_clocks), GFP_KERNEL);
+	/* Find the highest node ID to size the xlate lookup table */
+	for (i = 0; i < num_clocks; i++)
+		max_id = max(max_id, max(data[i].master_id, data[i].slave_id));
+
+	onecell = devm_kzalloc(dev, struct_size(onecell, nodes, max_id + 1), GFP_KERNEL);
 	if (!onecell)
 		return ERR_PTR(-ENOMEM);
-	onecell->num_nodes = 2 * num_clocks;
+	onecell->num_nodes = max_id + 1;
 
 	qp = devm_kzalloc(dev, struct_size(qp, clocks, num_clocks), GFP_KERNEL);
 	if (!qp)
@@ -106,7 +128,7 @@ struct icc_provider *icc_clk_register(struct device *dev,
 
 	icc_provider_init(provider);
 
-	for (i = 0, j = 0; i < num_clocks; i++) {
+	for (i = 0; i < num_clocks; i++) {
 		qp->clocks[i].clk = data[i].clk;
 
 		node = icc_node_create(first_id + data[i].master_id);
@@ -126,7 +148,16 @@ struct icc_provider *icc_clk_register(struct device *dev,
 		icc_node_add(node, provider);
 		/* link to the next node, slave */
 		icc_link_create(node, first_id + data[i].slave_id);
-		onecell->nodes[j++] = node;
+		onecell->nodes[data[i].master_id] = node;
+
+		/*
+		 * Slave node may already be registered by an earlier
+		 * master in an N:1 topology (multiple masters sharing
+		 * the same slave, e.g. several CPU clusters voting on
+		 * one L3 clock).
+		 */
+		if (onecell->nodes[data[i].slave_id])
+			continue;
 
 		node = icc_node_create(first_id + data[i].slave_id);
 		if (IS_ERR(node)) {
@@ -143,7 +174,7 @@ struct icc_provider *icc_clk_register(struct device *dev,
 
 		/* no data for slave node */
 		icc_node_add(node, provider);
-		onecell->nodes[j++] = node;
+		onecell->nodes[data[i].slave_id] = node;
 	}
 
 	ret = icc_provider_register(provider);

-- 
2.34.1

