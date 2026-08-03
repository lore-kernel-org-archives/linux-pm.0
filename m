Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD4407CEF
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756447; cv=none; b=clkN7a7xBTqMoSGCSeJ1Bjc5wd9ilhZYEofH0wDjNPFKGkgK1imQfZ9KdoXIF6cRHgMjY+rhoOOAXQm1Xsw6xYtNGYOv4okGXqq8K2BgKO5PPiBxRUsz8PxN/KcTjCzDyvUInPo4xoLHXOj2v/wzq10wDrdf5ryb1eQexTZpoqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756447; c=relaxed/simple;
	bh=W+J47DLyzKHe2QopLDHxTslHmL997c14k/yofWkF6Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fz/mwZclQnZwkMJyxSKOB6+YJb8zXyI27VPsvJPNyjUCdxMmvWtYt7tVxoMP3JTEJoKNwrRoZ58hD+jRfvK1voKcAcPs1gEnJZvAW/Mn66qMPYMNW/K7adIIEOIaEBe2Fqgm6PNW3SH2Omna+q7n8SwaDuu37FZgysB/75NYwgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aD6pkQOD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R4WHoKdq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aD6pkQOD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R4WHoKdq"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673Ams9B005517
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 11:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y5q6T1WOr2wk4M+dKBh9beKBFr4ByevQ7VYwHg8nO/E=; b=aD6pkQODAnkmWHVr
	c6cuyGiillAX8wRdF78niLwxbH0dafWIUK4Fj2bC4c88EuTcks0UFQ2LbTsMjigM
	XxKQP0IsG7SG7jucKNLXEZzeRtCklze9Rjo96bhpgD/FY8G3eRf5dfDJoISZEsQS
	VeYnjgT3KwGJxbw8JqzAIEhHYHxkvLxE89ppqsf5Wbnps22cvHIabAzkyZvYiukB
	KEN39E/siliQWCoAVK9mwWd29e6hxy9oeQVmvw5TlBw0LO6Q5nh0dFbAifj1ITeX
	3XNlQcPrnm6XEPqPS37ug34sCkyxvyZliCiy2v0+BcQfxk0AKS018HXK/46YPun2
	3MBf/g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnj7993p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 11:27:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so5524472a91.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 04:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785756444; x=1786361244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y5q6T1WOr2wk4M+dKBh9beKBFr4ByevQ7VYwHg8nO/E=;
        b=R4WHoKdqsVfjVaPZ7uq9zT1P6AuKBF3qJkrvagjDhl0STnVOzStZtMU0gpyyJz9e4x
         gdztSBRxEBaBWkK7QIgv6os1ZAx11EGj7rUIqt4ZPVPmlpsloTxEOwnq5ITpeRIJZ0zl
         nas+j6k90IqKhPxqOCgdDir0oiKRYd1gceq09lnKhIqxVaajJ1cQfiGJrxuT1JkU94jo
         JHTifgfuuCvwbe7Vs4vnOMjvg8ysMBqMw7/VgOL64VwvP/zPD+JJI2N/pTVo2K3VVwGs
         SB9xjrufQod+9e8Sq7zlXcQIuYWkd1w4dPZCRmdrf4eaZCbKmL4D/dJmVvhggnwpKNuK
         /nnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756444; x=1786361244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y5q6T1WOr2wk4M+dKBh9beKBFr4ByevQ7VYwHg8nO/E=;
        b=eCw+YBG/00OLDYJS37dpw2j5zDlbPim1IzUvbdfblLpBiFzZowDlQhXt3MUBraR4OJ
         7hUC+WptzDtU9t+usCnTWIr2kXGsYacDhVfyrQEE53ZrQ/ElRk75DjQ4ogjrlom9V/7M
         jT9YSlgKp8xL8IYtVkbprr8nTYailhg6DZknkI8grXlljfjHnk38sSK8/99yKIJgB+DG
         +92KjwGc6RLA3DCy3780n6bY43Mc3iXB5SIX33s4rBfdLRm4Uwv4eTKJd8MV5tNHG2gF
         AXyGz5zayMLcMpaWjuSXvcalM2idnLbQ+n4lLo5rXNKPCtv368n6eQMUGIrg7/g9KO0b
         g4iw==
X-Forwarded-Encrypted: i=1; AHgh+RqyWi1G8zCz1+Uo6Jj9TKmE3dXNnhFlvewpe8ufurz6DBnGEv8d0VZRZywLGdSxdFSI9ZC6trm+NA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHapbju8ThO8k9yTp8bfBCqUpcQwYtls+dTETG0eqD8zPta01i
	Z/23xavcu8aN5UJdwVqrdA4YRGWjZyNLW36T9ZrD+OpUFKnLLxKRW5R7L4c+XvLOMaLDxKXawPy
	kG2v3anjT3k0AvUYObpGVq7FqfvWQj3lLcS+XR1OJRwJA1+SoEXCj0kyrIXPgBbQe7A7l9g==
X-Gm-Gg: AR+sD13y0xjAwOxATBFqRQ7fL3BTr6JKACPcFUJcAsXiYV7aQEyVo4ozQCkAc9iujRP
	DDfbmL/yXN3fkGmkUu1XkOQrwi6IBufkWlxw040kOWUaxyn1QxtMwUhVgv0JKlgZWvfKldyb5cl
	z8f+LZ0g3kv81Z905Ulbh2k0hsGrA291Qx84x8B1wWTe+/TmuqqJ7dx3RMmnVu9nWVLmEX7CxJm
	KatQC8FJ6vN0687AUc7N3QJV+m+sahXmH0CvvEX9yXRcRrWNVtrcrbKuOywlRiqEadm3CtUCI4M
	RDu7O5xCy12zasS2qaMFG80pNBf+wlpUDiC67EGqG24T5K0ZoQT2cNARK7f2SZMkGAqJLJM9WF+
	ybX4SXjXnJ0obUy0=
X-Received: by 2002:a17:90b:2604:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-38fbc414a45mr9636374a91.10.1785756443690;
        Mon, 03 Aug 2026 04:27:23 -0700 (PDT)
X-Received: by 2002:a17:90b:2604:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-38fbc414a45mr9636338a91.10.1785756443256;
        Mon, 03 Aug 2026 04:27:23 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab132cc4sm29967043c88.2.2026.08.03.04.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:27:22 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 16:56:35 +0530
Subject: [PATCH RESEND v7 06/10] arm64: dts: qcom: shikra: Enable CDSP,
 LPAICP and MPSS on EVK boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-shikra-dt-m1-v7-6-7fec8e777076@oss.qualcomm.com>
References: <20260803-shikra-dt-m1-v7-0-7fec8e777076@oss.qualcomm.com>
In-Reply-To: <20260803-shikra-dt-m1-v7-0-7fec8e777076@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785756396; l=2699;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=B2Dpn2axDYIMHLk1wigFR9Q2p/KX8LBdfSSHhm53znE=;
 b=3WW/jjVoanz9dGGn8n7Xshe3VA+MsMAPWlb/jTF9G8BpIiqQ6uuAEhirn4hQabaZAXkL7dgkK
 +WM7KzaEgThACPVMVg6h6ZMom/Tt4djsTSv3ukejIESEuCr6SpU/Txy
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: LePA3iSr45HgL8axC-eHQ-BicmqjJHqM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfX3efx6c6WsT+H
 myzrQbvOxdDhJZQD6RaKCJqx2Ai5wT6qJQvr9Rej//2nzcd7P12Eh5ermXeX+qVFTgQsNVjPJvI
 fEl0jXq9a7pimQQ8IwY/Vh2dEUj/6SpaeKng7RXIJDSeg14E/kygIP3yGgNcB70sWtoANlMk12k
 6Pf/ceIxzNsyWXK+PPJog9HcKzzZYWKARPA6lMJgr1uTWu4GSjGLpbdAyKYlWUf+FB7TP2yJGDI
 X8Cwt701Aa9WhCGq0B1mJC5u36q9Bvio6ZYUTI2eOj13b5Y7gGQIkHm3CjjPEN/xu9hkKDAcZvz
 /Z+0ws9AdyLBHOToj8wh07bSbiFbWzFF2ySaxL+XCt7oFCaoD79//t29ceCNNYuaCW5INvx1ZP6
 WVNRsIHUTXKbghkWNBEtPkxBLIFG9uARFJf3y/XTUXbwh8RX+0mYqPvkRPkdGJvz6Np0TfDgNUR
 ffOahZk/HBeLhiHdCNA==
X-Proofpoint-GUID: LePA3iSr45HgL8axC-eHQ-BicmqjJHqM
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a707b1c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=nu3v8zf0uA-Bo5sjUnsA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfX3WqrWoBDhIVr
 xLd8V8Ro5EqsGpjVeLm4DEurUJA1RN9Az0lrptDZaeOrIAgeGVZQH+DvIUONX9S0LOl/UqSXKtV
 TyRFGKgr0kz7+W9+9ZRiKdfzZetWwJQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030102

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

