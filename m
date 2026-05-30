Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8AD3C9891
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165720; cv=none; b=pghx2shC3hkOr37XNf41gO+W2QNpbH/8t/wiP+HBN6xKyKGcJkR/c0kN9PzQuBKQQySHHdezDPRoaoSVdntbDJeBzTsbgBEnemAamyNQPzEnn6Ae+h71HRPnTgw64msQBLWAmrTGeUa74uSbhMjn42OB7Gt52WhABagqYWDJqsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165720; c=relaxed/simple;
	bh=O0ITinEiBDoqyNtfUbyM/puvl4+BRtjPN1CGKUba4DA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WoZP/xg4gUtYCJGSrYQKIAEXXVjtoIIA7I6dVrNAiCE8++HqpvWjRt8juw8rNiqhQmcsNYIIxPWbleN8of7/Vf8bCCmyk1bhF7RzmRDkTjgFYBggop5FMxwEs2eg0ZIqDkvYa/QgFfpCNf4c/gpFyzy8u8CNSUIZm5WqhZPHLCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dHgIef0q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MPRsA6js; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dHgIef0q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MPRsA6js"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64UEOuAf250640
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gl6RrGCb/bv32859x3E1VYQ4SH2J4WZy2L+TCOfEc9g=; b=dHgIef0qJ0ao9xb2
	I8wRr9pKXlFy/pwzyoWOt0Wg8YEi3RROYYxN69szm0eEgLsYTlrnZYNla7UOOuB2
	Dv+6JywuMacAR8/jnx73/EG1SrPebVeqWg3jC4FfyYDLcpLavfly2EROb8/6sKrB
	mODw8lEhBzU1pyvQB2Nrk4cQfjka5H4jSDfqinGRIW1EdK18fHCsBnjP9yMZrFzp
	JNznWyN2AYFYE044+ME0cUe9u+4DAT0ztXoDFggYQHy6LkaWT+3Hro0JbtBKkPo6
	wwtl4BQfijbEV9Z54QLzWFF+PryWzp54vUna+GfyhOudnS1an1v+HDZrFs5yLvL+
	Yg0H4Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efux519mu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 18:28:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf08c2a24bso31795365ad.2
        for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780165718; x=1780770518; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gl6RrGCb/bv32859x3E1VYQ4SH2J4WZy2L+TCOfEc9g=;
        b=MPRsA6jsJwN7ezEg1C9rMUesoewPRg1kBUnKaRaSgPM9+GU+6rUafFj1M3tZXBoMfC
         58roQ/+uJBwBF88Slj7xKsiJOvkJdyILywaL0k371KXs5weXlAii9rkAAi3XrKXYkmnA
         yH5UMIrYOirlmJ5knzdULYT7jB9HxpbHL4Uf6u5dKS9E9oG6dibY8AJ+dUPTnLQGu+vc
         eVstQsBGv26qaoWyf0aTKXMRTd4o3QW8V0hKZufjeZcBkhwIDvejrZZO9kmHdJq0Cntn
         vMMbNkPa4Deqmhh4D7yRaXFk/yFcAEZ6cC/WXcWpZlDAY9pDdohKLs5kVZ/SH19XaQF1
         CCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780165718; x=1780770518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gl6RrGCb/bv32859x3E1VYQ4SH2J4WZy2L+TCOfEc9g=;
        b=Iu3L21gc2HbVxVFtEgHUwJR7KPa8oEFlaEQJVdbOM4eapxtrITaM8XTwKw3t52ojqu
         uPdFxF6Tjc6t9WvQ3tIeBd2bBYZvw0v28MlzFGaMT4bPMDAyqywtGd/bq+cPtgEYJZSL
         EUeEEfOA5T7N0CtxN2oJnrvMyzMnGN9hwb0b9c5w3CV07X6vooqP/H3j+sdLk3Dlhmtu
         vHZX9cpuV7zPXKMeRXZmtx/vh+J8fzZvPz7jIENY/KLyKyq0OQjgTzPTq+/cU1E5Eaxk
         LgrMMtnSyuV9Rz4y63Swuy+LVsdyPxJAMa1lwZY2W3t3xCqRJsYhfVSpPGrzG0EBG1V4
         ViwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/sbG/dqJnUkZ03x8RnC4NS06iMv4kg+XarzrtVS2XeMUvjsyU3hobiVcfrz0ty1EJJ0SdhKa0Pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPfHXdgCQrYXsEhCueTUrfjBFZ249drXNUcWCnLd0XfrQf3Fuq
	56M3tb/sp4ADuli6mh9Fh7JBS8rvUeJVoH3AToXK3JeQRQj1QNqpl5hHkePcDA169k5HhDg64/E
	vfJxvTzPWt+ZFhkvkaex0OTV93WLXpPTVPlCphvUUwFQU6cnMI4XJMSwm1tD28Q==
X-Gm-Gg: Acq92OFJ0OXYDWmkwtaoP3wvP4rqlSGXd1KhHqL6TnsM5scOatBcfufdo+pDmrO/oNq
	haDMXAeCZsNsXFpElVTClZ28Ek2O1E4C2y2yXA+/SCKE0r86oKn03ttw8fua0nVzzHdO7N+X5Dw
	eCe5USqa6Tf0CSlKrshpYrXls+q/sst68EdNelHfdEgyFzzhoZTNZrY8x9CD1OmrSSSVS49N5Pp
	Ix+uFFH2nHkGUzYyF7RHQQz4g9pTEf1PbK210W7X9tY1SvCuylXnwqXvkhvLBJgduQEfkxdeCuU
	PipBkl0Y0gtmCdy2jQYutTlOIlRtoLHeVuJK8cDPrW8yolF7DtxVl/Mfj17eqXwifNCvvwOlGcF
	YANkheb+fYIjVT0OkgU/HJcraOkzHm7yLezT9y+vccbe6Baw=
X-Received: by 2002:a17:903:380d:b0:2bf:343e:731c with SMTP id d9443c01a7336-2bf367c0d68mr55836595ad.10.1780165718237;
        Sat, 30 May 2026 11:28:38 -0700 (PDT)
X-Received: by 2002:a17:903:380d:b0:2bf:343e:731c with SMTP id d9443c01a7336-2bf367c0d68mr55836275ad.10.1780165717752;
        Sat, 30 May 2026 11:28:37 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf28973335sm51702635ad.63.2026.05.30.11.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 11:28:37 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Sat, 30 May 2026 23:57:26 +0530
Subject: [PATCH v2 08/10] arm64: dts: qcom: shikra: Enable CDSP, LPAICP and
 MPSS on EVK boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-shikra-dt-m1-v2-8-6bb581035d13@oss.qualcomm.com>
References: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
In-Reply-To: <20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780165667; l=2571;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=jZ5sk6mDCOuUmvLcAvbMml5Kmz0BhTO2YLQnfm6VPW0=;
 b=PbFIyNvoBdBIOscCpaSJwnHPwIZ7/VErt4P/TvuWXAVL7yjduiICUyX9woCSpVGUs4zKGSRoQ
 wUI9WC+gqh1DxR94QUJTAmiiTmY9BbNN8XmtiEtKX7/M7550LwbHgQp
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: 5UuNgFbVx21VRrMqe6qYxryPcE5vP7cf
X-Proofpoint-ORIG-GUID: 5UuNgFbVx21VRrMqe6qYxryPcE5vP7cf
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a1b2c56 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=nu3v8zf0uA-Bo5sjUnsA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE5OSBTYWx0ZWRfXzUBapkz9HtfT
 YyWTkmu/Hmt3xgFSgegcjqKvjn6Ssbklz/HdoAcKvlCT3ne9UmAdAEup4ixnSjB2gMeJdSb73Ty
 hjVn6c+EKvPUnpOIq2vQX2IxukaRgMlFP+ppLnlmimtbb13vdX+0hYcTtnQlrE5y5YhzH4G723S
 FvaVwJTJovzro+tM4AgEG9ZDyaREYKS1vPBMphGL1ze234r8xvm+qQkBNvKz4kHqjIj9R9b2Oxu
 a/y0PAkMAnNhI9lLRWNCCk/KWGNvq1Kz5Cbs+JiUOnkcthQvfyevXIKOKpAkeEgwrTVk1DN5T3a
 sRmVD3nb+oqz3qnE1VnXke4Nncl7MFA08oy0eIojSGSaLowCxVSrKedTWM14z2MnzZhyUkNtzvI
 9X7ZuBCz0WzO+cBU0Bfyt1rjmNAow0y9g66sy5Sp8VPPoniBBLpgLSdKmhl6G9KyY8ygvtRoSSX
 m6w4tpJoX0PMYXVUhRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300199

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQM, CQS and
IQS EVK board.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
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

