Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4303C4544
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225390; cv=none; b=lxCyWCbfzhaK80GzUtf4rWZhukMeFmZbkwZVqujRxmA8EIAwlhWfa/32UZij1mpPwi6Rz2OXnZl7qXYk7X3YHC4YiKv2hW91XB7dAzbIHnaBK5JATogonMnUfEPQ0Ocw1OTTCaF8wOACLpYJ6yO/pS5MgTtWsX5YP/N+sHxmiQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225390; c=relaxed/simple;
	bh=kxZo7ioQhvtoHjeZPVYY3GMaH9CaQ1h9s3DRTXP5qow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFN7j8D9SsThLPGvVveZm2fBkhHWemybnQ++ezb13f0APyu6rbpIgEkgsKC6yOVOleWXY4lI3uHgLjyUz85lho+X9MA//pm5cHgj7xfBYivSw9B7H/dAkbJ8MSBkSoJj8Z2V/XMsOdAyxfQ+TAqiuqO9EIe/IZTV0h3QhdSoVKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H4h2wrrJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Baa7Zr8W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H4h2wrrJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Baa7Zr8W"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B9nmm53893470
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 10:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HbZj9tv7s1K
	+qsnLUWbHvi8x21FiaRRcwrvvVvQVwKE=; b=H4h2wrrJSgSGdDWebATTwGoBugs
	Kpjh3zOo29TjEHhlxwhhslr7/QBVwCrCDxJuJ1kQVbf8VudB+u/wauVHodm06zcW
	2u3VY8SA3UuXAZIcGp8vsnybLrApluh9QJJcesQtOVFynvhhWZjoU1EC9CkA7Zsp
	JE0uDXvFu3L017iK0fqY1V0OLaOa9hcVnoyKzqsTDQhHQUXgdI8qNta2xMqftlUb
	UjVzuVDrqv3tFZDVyfVqNkKAyqij6dHERcgta8MMLIZK5/RXJ158CmfjZbxx885Q
	M0s38x8/nnfkws4H4WsnUwpOl6xUoFaFqBV109Qdn4EjULKcLDCSjc48sOQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctkmyvbwq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 10:36:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae47b3adacso100084785ad.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 03:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773225387; x=1773830187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbZj9tv7s1K+qsnLUWbHvi8x21FiaRRcwrvvVvQVwKE=;
        b=Baa7Zr8WqQkpbcDatk2f0pMRMHT7AeslpYl5RTo0Iut5uHHIqk2a+YaQJJRUIKyowV
         Y/Itsc9sB5YhPycJAEWCA4AIIUseuKoC4JK0+wTtSZqk4AVP/yetiAPXIbuDgjDILVg2
         9XVVxdN8Y7NO21YqMEeA1ORZII5S6ViUDKuwkeA+sgmmaBGBxczeNuJpN769MN0urLCh
         NOyCQVHq2iPvdIkOkAHgsWXn4qWeKtRv1J8FuRyerz6MjXybzI1e4xo3/ueXaJBnFBxI
         vgsqNhHeInC2LvWcvwNd3MOjyczcc5e0J4Px+skMO3LlEN7m/GvkHYcM1jRnCrvjRXC4
         KouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773225387; x=1773830187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbZj9tv7s1K+qsnLUWbHvi8x21FiaRRcwrvvVvQVwKE=;
        b=HlRYkK8ermi8oJ4a3EBXEQ9b4R1GyaUZqaGCDuFQHhpGZ+kyPzkzqRhRJfyF9F/DYz
         Bm5U4xdMSyw5MrWg9awaRLkuOKboI6hOAYAAETL87mt7Muj09rNNi8bCBuJb/89lkksM
         uerx5PPVddgXDMR5vulmoK82V3au1xvKPAFIe9c+62e7euO0LjFS6jmKo2My4QI3Kfy9
         iQK/Nhhf8bC/H1MDNqszU9I6Zcb0pmq2k2JJLljLf/1+cm7PCYK6zTmBw0B9vpaYSOYi
         o3jkOHLFr9wwYg8nb3+F3SuLp17OJHS1TVubG/MsshWFuNVk/isDwIhjZMpECFoGnmH2
         pomA==
X-Forwarded-Encrypted: i=1; AJvYcCXV7iEgpTLJYvtn5qxHuz+VY4kMbJs0+rV7acO/jZ/ZHU6nlNCXacQ/rrxaYuNTWBvSV/dK+dQRUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSf5TD5Dm1FaSaKgw6vH/3qSY1qaWX6CYRQRb8ShezEk4zgyW0
	Ufci2UofuJI+Fh+NoZexG0hKkxU6QVzPDFHalZhuID/dkwfRbHvPkXAu5gdqwYc75aK/+Tj6RBS
	gZ4Ej3170Wf2+tpAskqk0Ej/Ss2WV6XLwvFb6EEdBVdi5w8YXYpM0xLaSNjIX1Q==
X-Gm-Gg: ATEYQzy+N3aftXJ/QDjl6qjhIQMhU7wg52+N3ysMtvxXqh8UYNiX+V72ICVqrX71ZfS
	g9wNigEovTgazhS3YukPpcLh5uWyff0Z0Pv/k3gR6dprmXgoz0qBr+qNzqpivqHacnUGAcXBf5s
	kZ+7aoRWHj23cBwfcoajFwED6dAQoITFnNs9MKo0zv16/FTKU65WuekvUwnWnxZBr7iZ8qBalZt
	itJpnR8fpct7jNkLulYxWPzLcW85ZbEo+9j3i4sbwo45j1AnpM5weSNuoG4By2YJpSjFiHBHpUi
	dCXjETh7GZlxgZyKioJtKrlWbTpQVCfMsqs3kuycaK2rgXTdu6j2am1jBQ6NEjfovm65xrff6tv
	9rAKfCddtdy8IuiZdctFULxvprV1Eudc4m+mphomb+Htu4bxdfgsJQJY=
X-Received: by 2002:a17:903:1a4d:b0:2ae:48e9:8c89 with SMTP id d9443c01a7336-2aeae8d244amr21270945ad.48.1773225386552;
        Wed, 11 Mar 2026 03:36:26 -0700 (PDT)
X-Received: by 2002:a17:903:1a4d:b0:2ae:48e9:8c89 with SMTP id d9443c01a7336-2aeae8d244amr21270685ad.48.1773225386085;
        Wed, 11 Mar 2026 03:36:26 -0700 (PDT)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae378a28sm21042925ad.88.2026.03.11.03.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:36:25 -0700 (PDT)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH v3 3/3] arm64: dts: qcom: talos: Add clocks for QoS configuration
Date: Wed, 11 Mar 2026 16:05:48 +0530
Message-ID: <20260311103548.1823044-4-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311103548.1823044-1-odelu.kukatla@oss.qualcomm.com>
References: <20260311103548.1823044-1-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RYudyltv c=1 sm=1 tr=0 ts=69b145ab cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=7s_9-EB0MOrke_GCL94A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: CQ-38covyQ3RfYIYaJVe1z3RiQPb0Un3
X-Proofpoint-ORIG-GUID: CQ-38covyQ3RfYIYaJVe1z3RiQPb0Un3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4OCBTYWx0ZWRfX/YrXUyOzAvaL
 xiHCZKbBeJ9b7ejblNQ9DWDjz3ovlVPsYa1pKkkN2XfRHgA3R4yv04e1uVA3feeQYGv8u5dhT2w
 C5mH5kXGWvX7DEUusFeTAE45dXlACfMM6mHKM4Os+LxEFhdfi/X40CDnatdRlorjHVFODjYAk1w
 BayN2sZhHvZgtqVKsz1bw4BzZiRE3Q3bslIptCTwVf/x9Wb+FX0jtBZ0fukgVSPvVflbSQ+vdo3
 VclylV0k5N0klCBbwXpW8FpmHbwGMq+aQFbDtGvfo7ZRmPnZt5nobNxIn/sKkpktBNFHFPtOZRP
 LbOUCHbmpfCuRhDHClYfnVHgeWzHbKi8BUc7lmn/hZKRNEZolzh/ZrkUTQY9O2HyXh5H8LK4SLJ
 VtHUvgqBmPhPSUihWCPNpTaWyB8sq4SthTRq8XOxk4NGyewxWrVufwPA8Ie5SP1swjgujHkFw5Y
 14dL57E+1Ko34gfhIdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110088

Add clocks which need to be enabled for configuring QoS on
talos SoC.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index e0282a5f9a6a..73a7544d8283 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -1237,6 +1237,10 @@ aggre1_noc: interconnect@1700000 {
 			compatible = "qcom,qcs615-aggre1-noc";
 			#interconnect-cells = <2>;
 			qcom,bcm-voters = <&apps_bcm_voter>;
+			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB2_SEC_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&rpmhcc RPMH_IPA_CLK>;
 		};
 
 		mmss_noc: interconnect@1740000 {
-- 
2.43.0

