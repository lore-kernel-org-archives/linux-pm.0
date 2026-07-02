Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8C4DC55B
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985896; cv=none; b=u3waZJ7PuG/JxZO05hGZXrINqk3afIzr63nQ6VdVx2FJbixJc6uziCFjBqziLDDJ1sg7rdUQ0nlH4k7SQ4kR9YTqUgnAKdAlMac3By1RK4ICowG/92l/6hBaHo6KIsgLvn+je9A8YWA2WSFpJy5o7En3OOLMTmrKJMR41kHfJQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985896; c=relaxed/simple;
	bh=W+J47DLyzKHe2QopLDHxTslHmL997c14k/yofWkF6Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ri5ZLNKTFrejNqHI+Mg80bzqNr2EO4su1QjZnoT27Xy+9wg4N2zgPZw7CblUSiCkNb9YNahEVJ46lLmXtOkIj0URJG8VVE9tIk0pMNuVmeNUKZAR0fnu350hMLoXow7g3zYn0i8yehOPjJa3BG9cl3W/rwujBagvU6XzwyKnAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mt/FVJP/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b+dO6UBe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mt/FVJP/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b+dO6UBe"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6628sNZC4172571
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 09:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y5q6T1WOr2wk4M+dKBh9beKBFr4ByevQ7VYwHg8nO/E=; b=mt/FVJP/tJ5BWdlV
	MFtSrp87h2XL4XjVlr8vGd+hkcnvXtHPGqIcL1k6a3eXrZ++8LtRL6SRaNh9vGt/
	9Jd7JO0BmAt8Lsr2ehIbSPs8tVV9R08C7E2rQx1dga+xwEtUcK8MmCOJ60wQ2ZY7
	efglepwEIW3wXOlyMWuGm4YmXVrAvyCfGVzeQX1OyeK2X5swe6aJQQqkMqXnc0a1
	8SKd86sJsX6XGVEAZ4mZ6YQzqynSLwK5Te/ZGDNPF0RnhctWixIR7m8PTT/30vAe
	6Xtr2KMHPi8tYHpJTSjCDYg4dNNvAZknosHC3ddQT88g8ho5MxTrcGaysMMSvPo3
	JSud6w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5mvwr7qy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 09:51:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8478423e020so2328574b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 02:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985894; x=1783590694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5q6T1WOr2wk4M+dKBh9beKBFr4ByevQ7VYwHg8nO/E=;
        b=b+dO6UBeqvLQJZNOGMTlKmJ0T1R5bbKNmUYuTMybPKCn//pHtk7CSeRsbxpWqLEXkV
         gIJJroPjdlUAnMKErU20HTON2LhgjqWZXLA3TAC9QWdex6Aw/+7xUsNJQCL2y2qmx1T8
         48SOrXKysP292GZSiZxktlZvp5chYg71rlwtnfdWErwXQ2MlYn+lPTMC32NKdKpZZLGH
         +CEV3bitquxuf+XS4+jUkSeDgL7K5V29pHmUqJstU8Ob7rtdeadOxJHE6aaTBYQ3oMKX
         82sqJx1vea7I1LjpyPL1w4xc+IG1h3HD1e0ZYCEp4Zpn64/uaL1NuN76lIJDtNuhVeFe
         hk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985894; x=1783590694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y5q6T1WOr2wk4M+dKBh9beKBFr4ByevQ7VYwHg8nO/E=;
        b=svfeheTglH/cu2t0qeGS6RG07Hk8PtTICKb7iWjw6A4+zJGuh02P4ImFVx5/Nc2+ln
         PXt0ZCuYeIDaJBWeOehOMO2S8GWY9Sn+fXNGZsrC9JNhIIEA7ism9CpGyYf4krfukuaE
         w8eTKBXSytddI6pirP79XCptFfHneLtqk78P/R+Krq+PXRkfp47BtoDivvtYpWMXPKvn
         ob1mgEHxTJIRk+HbP88L9jxGNn5sEg6Ml9SVoz+yUpq2qosPwn8EvK7xrbRj9KT3thdG
         k3+vpsJ5yOoBEl9oG2XzqlIobCcUEoK0DyxlEjMMqEp4d3HzlrRXjEZf+0V6qt6xaSmz
         fg6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq6pt50i1xlc57R8N/DKzL6ZQU+hwovgodTDTMSBoWKAPBIRCO1jqgVQPrjevQ+UXV9l0ImIdfbvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ZhmyqZgqTvfnBlc+0GPz2ULfGT8s+Jim9AP2TrZcWsTLhgVX
	glQSoHozHy67Z4a9F3TP43ybQA6Fg2053N0N7ZvXXi8009OIKHIeRuBAZ1Lybj9jdAH4uhRZYYk
	kVPp1ilog/0TipDUpp3koJsDVWgOmtsaq9U0lZhx0z9crEjRvwANt5znfN8/4OA==
X-Gm-Gg: AfdE7ckoosH16NhRaRMrs2dP86+o+bcULYBdRyTDdr8QTxc5VBtF9p4sNB2bsvvRV6/
	jXUS8NZV5SKVXKn51kxbvJTqz47NDk/9Gsv6P3oxleUsJiQDJ0awdQFiWlX5uLwRqESm+jCHxp0
	QshpinKEm2wnsGDv3rDLvblshNT8+4Ni5KGOQkZ5Tq94+nlHDHfq6EI6SCPymAd0rj3QzW3AmI+
	Z1YNQk/mSDhu2eXuoARiImNXpEtk3Eq0kEwEs6GO8AsesxzrP/ji67lw+FZE+UKv4EygTJDgKY5
	h6hGh0oNzQdeuf5wQa+bQ4ulZ9/3hYft+3GQjLCNakJ7t9s3Igty856/+IqPvgnTv9+QvR8fw+Z
	v5rHcZwvZdrDmeQBkWnd4KG3HuA==
X-Received: by 2002:a05:6a00:4194:b0:847:87c6:486c with SMTP id d2e1a72fcca58-847c08d16a0mr5329776b3a.51.1782985893502;
        Thu, 02 Jul 2026 02:51:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:4194:b0:847:87c6:486c with SMTP id d2e1a72fcca58-847c08d16a0mr5329576b3a.51.1782985892939;
        Thu, 02 Jul 2026 02:51:32 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:51:32 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:49 +0530
Subject: [PATCH v5 07/11] arm64: dts: qcom: shikra: Enable CDSP, LPAICP and
 MPSS on EVK boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-7-f911ac92720c@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=2699;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=B2Dpn2axDYIMHLk1wigFR9Q2p/KX8LBdfSSHhm53znE=;
 b=C01sg74303YfJrG1IZIvaMytNKmgM29upDf3ZU2cIOxelbs66nkDIIxIKa4ICb5StnUkXqH5J
 jKy0yJGGe3mCj8WKPgr/6jlJGeltSEHJm5fbGOiIOP9OloNeKbjNPVS
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: quuoWAYilPXznzHVl5-ra-R3XDPU-aIH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfXykyycJGetX5F
 RRA4itmws4OuieCP9tL4cehfzpbxQ671+XbKd79/F4wud2q2jsV1EJkOJCK/eU04PYvaJQ9Jz7O
 9BxPuBh6xdUqQaL+BqkS2vUWE9JXCZVmZ2zNwPkiaqj8fS6rN3Wp9TbDcn4FoSJQT9CWImuHJHp
 BrLeJ759yOWLdzfcNMls5xu1OSn4oMcMLYB1LrhpsbauUkoftB210cpT/uiiSt2+LdWV9s+8zWr
 cdlnpEcqgQohKQKLiMXm2shpTET3Bvb3p7+ZKNtt6f3NjpuZHw19LbfPSRo95f5nCDQ2DF5l3Es
 JkrhPmzKtgAt/inWDb7ptI+2DWBSg46Zq6YR4ftX8PmB6DPtLRnFZfCZ5t9O3VGO1lj97o33Y1h
 r7YWmU7OZmNWXBp3E8B6WCPmcDLydLD5ic7V8wwSRucxr0Rlh6KlcJDjnO0hhQSYTwgGrTtgZtN
 tbqghC+SUx5WeSn1J2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX+06r+17hEe7s
 PkVOgqbm3ov0xq2oxKX7x4ToqxqEaqlUt5WBQ9Feqrlzh1BNKDv+mwaEoLMu4isZmRXmdd9BI5l
 kFuF+fLeg7SSDxmAefFrh/WG1LhPIiI=
X-Authority-Analysis: v=2.4 cv=N+UZ0W9B c=1 sm=1 tr=0 ts=6a4634a6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=nu3v8zf0uA-Bo5sjUnsA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: quuoWAYilPXznzHVl5-ra-R3XDPU-aIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQM, CQS and
IQS EVK board.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 19 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 19 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 19 +++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index 0a52ab9b7a4c..b112b21b1d79 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -23,6 +23,25 @@ chosen {
 	};
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/shikra/cdsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_lpaicp {
+	firmware-name = "qcom/shikra/lpaicp.mbn",
+			"qcom/shikra/lpaicp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/shikra/cqm/qdsp6sw.mbn";
+
+	status = "okay";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm4125_l20>;
 	vqmmc-supply = <&pm4125_l14>;
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index b3f19a64d7ae..e62ba5aef71f 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -23,6 +23,25 @@ chosen {
 	};
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/shikra/cdsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_lpaicp {
+	firmware-name = "qcom/shikra/lpaicp.mbn",
+			"qcom/shikra/lpaicp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/shikra/cqs/qdsp6sw.mbn";
+
+	status = "okay";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm4125_l20>;
 	vqmmc-supply = <&pm4125_l14>;
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 3003a47bd759..727809430fd1 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -23,6 +23,25 @@ chosen {
 	};
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/shikra/cdsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_lpaicp {
+	firmware-name = "qcom/shikra/lpaicp.mbn",
+			"qcom/shikra/lpaicp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/shikra/cqs/qdsp6sw.mbn";
+
+	status = "okay";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm8150_l17>;
 	vqmmc-supply = <&pm8150_s4>;

-- 
2.34.1

