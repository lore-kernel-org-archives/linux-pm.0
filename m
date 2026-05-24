Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08AB32F75B
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652226; cv=none; b=rzhhWaG/PdYH4weAkfMtD01EbXUBOh87gTjElRST8gzyE9vywfrY4wzWMzSPNS1NLE6jfBaMcemQ/owjWRVphXzYd2QojnSzmRngGozbTO13mAE0/vZhMRIsFioK48K7tIe0eGd/ib9DFLhHTe5QoKu6gj36b1lNMzozX6w3sWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652226; c=relaxed/simple;
	bh=YaItrr6rpfD+1J0ICz5O4ellYSik3NT/UKk/2vkYGkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MAse42P+Er+XG9mNVMCXhJOLA2nW2ldLHo17S5OaHSFdHT5/sH7mUBaaEHu+lu2tCQAj2VHz8BgcO5yhxS1tOmYguGrErBa6UTh9aA/mw0smjcoC7qTlk9Wu5uqKR0ownfWHRwke6B937yQvza+qrCI4VwbGMs8gH+0u+OcR71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZfwNk3k2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SLw8gpTk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZfwNk3k2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SLw8gpTk"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OBv2RJ824507
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uRmkhfqfhacj1V1czHmTXt56wSL5ts/uC0kRpCFPDdE=; b=ZfwNk3k2E5Poj4Of
	DQYKFpzEJAmAIscs/ryMs/vAb54yqoRLf3K5TIH340+jbakYgnur1azEWq0/PIMD
	NcIOBo10OBGriHD6BJHBvB+8pRoiw5mSUZhlqIfQethHbDgEvTbG+kfyZfWym0gi
	OeQgVXBUVgBDiFTmDC+D0lCg3B0REa14DLH5K9VWvpJT7nRbsKS0y3EOd9TyX4iz
	anjtYPRez25zlAJWlLCqGYF2izYiEO83qQeZ7tq2lZvFOLIOc8tPG+5QcXWiGFTY
	1rEy2HBHFucsF3vk5UM0yMgRMGAmEmA6U/jtthvPCKsRicgJk4gt/HEkZEaIz5ct
	uYAZkg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4m7kuu7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:23 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-369166fe5e3so7695641a91.3
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652223; x=1780257023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRmkhfqfhacj1V1czHmTXt56wSL5ts/uC0kRpCFPDdE=;
        b=SLw8gpTkVy5hInz33I/qL5BTTuNj/SGwSsSGY8lOab6lupaNmoNbkmTfG0LLGqLi5k
         rmJnbHZpz9bH/WaNOWqGTeNmsdy5M5lvXLiY1+3qsdfkSIydLUcllOgyZKlZawBpnS4F
         F3lImM9nOSjsRZU+hD6+CM3zG37OaAgek+pJw+OVPRgpGXy1o/Il62d3ebRgStXlEjfE
         yXP+UAl4gVM1uREh4xZoHJB4KUfJj2xbEF1IPCF6MdRQ47gK2X5/0WItYFGQwM0pUYnT
         rm3VY4Nqz6XFldS0WBS4AuKavqQLgjiYlo6eUnnQd9Vrt2bIF6ejQ/n0rHZMg1znCZ/s
         dWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652223; x=1780257023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uRmkhfqfhacj1V1czHmTXt56wSL5ts/uC0kRpCFPDdE=;
        b=VurTYVB0AmVekb2ccObRiAin1cI33dXmLjJST3FfZXSZIyjHMcNvCeN9qutqJNrm4m
         qQ2vTgAEzZygyqZvA2yDuBQMPJGBdr3sBxKl+OiYLa7rkVTKEjOV4/VCjcneXt8esCe2
         NubtHHjDVxSo0Y8EmmJVPy0lmB8u7KZJpgFn/dW5HU0pAUhExf0usw2GwDDWa4m95D+c
         +bMfShcQpLeDtwtAArt+g04kgU1Rwj1XZ6pykVl98BbDyJRZLcIePdogmkc/v9t9Py1q
         Ad8GtSS+eRQQIKWFbOltAV0N70wIGdf4f3fpPYQY4ibG35oc+x0KjDfBsXJWFBjZefJR
         Hgiw==
X-Forwarded-Encrypted: i=1; AFNElJ8jfzcr8dqyzw5v2oasUZmN6AnoiPoycV4ex2lpIEFxDE/qAKBjFBqG+91WpVCTKVgi4CBwaaJr6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUEHkCSv/qG9CLrqc8IpADpVYZ8ULpygCxvlyRe8+t+bYURvx4
	E+ZxLJ/a+tEB5/I+kbZiBi10O5bK64NWby8+L06+cn3CS6Q0/rGvq046pxyB5AVLsV8PfoC6cB3
	AmaT+TZ8ayAmH9A3bn2UQZ5DDVh3x/96+JNmhRjaGmAJ6vCD0gc2UzM1h7RJ/8L6/4pHzlQ==
X-Gm-Gg: Acq92OHRPktRWmfoP02gJ+gP5z9P+adJlcJP96m7WXWvxIc4w9X38EXpHaajnHjv32L
	4x7lL4XR5wOixgv8GiV2SD2y/cnPLF3Maf//BTg71ayhkjxXQQZpZZveK4U/KUj2eJ/vepx6Xwx
	GJIJdXT1vwEe6Q5Cd17CoyPEn0lXhYgBuzqKCm3Wu48SGNlFvhMqnz0xgQ8qn5ivxqrc9IVWPcQ
	HUTNYhM+ONY97oYCJIppPk1oTtTRtQPD7HgQHBjJKFCv0w754/L1sW4XX7Yn3ySzEem2g5CB315
	df25fEn+uHKDAn0Zx/k1suZqNUlMP0jVhbD2RTpUAcqHJVbfYQYbXX6ZhVWkHp/HA9REVtyJVAZ
	3wEPUVzqn588+nqYpATmEke6RPkAFhMpvwfQA3Js6IFHyRF8=
X-Received: by 2002:a17:90b:38c6:b0:369:7433:488 with SMTP id 98e67ed59e1d1-36a6741ecafmr11276902a91.2.1779652222594;
        Sun, 24 May 2026 12:50:22 -0700 (PDT)
X-Received: by 2002:a17:90b:38c6:b0:369:7433:488 with SMTP id 98e67ed59e1d1-36a6741ecafmr11276860a91.2.1779652221984;
        Sun, 24 May 2026 12:50:21 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:50:20 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:14 +0530
Subject: [PATCH 10/16] arm64: dts: qcom: shikra-cqm: Enable CDSP, LPAICP
 and MPSS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-10-f51a9838dbaa@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=1019;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=mB3yqU/Z1sFfy8yB7RzQUxCVfP3cMGqsyBxBir2vgWk=;
 b=Gy7LIHwJEGfLhQgF/uZ3m+32Pve1JinDhqNpWJORnk7juWWPIxYT/gMXSJ1/q4/pQ5VRIEDVp
 MkniWCgBoUHAzhfMWbxfTrZPhu+uVMTWCAqjt98UzvitY4gQ54HuCYx
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: 0EnBWAwwXl4N4pOAp4xCElzmTfiX-42_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfXzC/CXGVS3BXb
 yD+d/8z8t4BeoZOffxdlKnLYNq3+G/aJhsJwMMWLMp0A/x1fZlj/0b5B0C+KdkkUoBIOq2Rqw2j
 lHjbPMyCd7RhMSXcUh1TFgeyCOPdxw0x5WUZfL6NXYHk8nE4NXHCo7aXUhlDe5/ohYbqH/yGfWQ
 6fbzU8BQekhBf5UfrEUGRqZi47z/uG1lbBYM2tglFCWxZsr8VDWIprrPAGEXnjn341nOJkgtMSr
 iM+HQGnlHDbp2rUTg4SmHs/DgknOgKBytwS1w7vGnHhjD3WhHxOegRmvQt1rDl2GrLj+bxfmX2m
 LmLgVyZmM40FKCac6EmLuMQ5GiJUn2ffiIdvu1ESdu2ArLMD/fYTFFUze5JbJFi42GEwwPlXgi/
 /Tci8MxyMNc+kM3GZOB3gvcZDMjQUe2Vh5HojObmMJOxGetGdDxB+hraYKh8e9YXWN5o0am6mXZ
 b8B4iwisF8JPn9yGqZw==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a13567f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=0ebg2YenFEddjv6MTxsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 0EnBWAwwXl4N4pOAp4xCElzmTfiX-42_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240198

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQM EVK board.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

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

-- 
2.34.1

