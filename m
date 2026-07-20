Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCEE3E0731
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544672; cv=none; b=U7A2lN5ILIrjthiIbMB+A86DSEWUcLi5RW2I9Kma8L/XOC8y/QdcNnyEGdEDU4pe+44T+DrZCaR6H/JofyE4NroMvwbpC6s/huAQV+vwj7J4m0HD8hyCLFGLUYs2R1iLt95xKbJ3NEy+ueYnHHtt3EnAsIvdfNGuryMYcIO66CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544672; c=relaxed/simple;
	bh=W+J47DLyzKHe2QopLDHxTslHmL997c14k/yofWkF6Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o6uE+vrkC8kkEkV0zvjMpv7q1CU8eMusHTBBERbDsbhCW6R6ti07DI+5ojIyhyZHxCLMmQVc489CDBLNQ/sel+XrBPCS92+x+i8o59KsxR4+nSdHV3aAbKTdfwU+uS2fsbsHHgOAPHr17UPyv9s/0mnl2gml5E3pTI3ZojJyjD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TQoB52MY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=erDZzWVN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TQoB52MY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="erDZzWVN"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K9w12R2189181
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y5q6T1WOr2wk4M+dKBh9beKBFr4ByevQ7VYwHg8nO/E=; b=TQoB52MYxPUPNtpB
	CjZsdSV7vUtw0GHJbQYdXNcheLXvDcneoAw8Yqx/j7Tx7hfJJFcN5Dak5V27e5r3
	+l9K5qtq7b7ax85iw5SOs1G7TxQwjIcUoYXCuw9l6klnqXpt/2k22IboQlXQWr/+
	gbagWrfpg45mLCedLOJccGqdKzkkQsSu2Bjwqebzep+xPduAebWXQsQJmkcLGACD
	W9QMaEbxCZ8LaM7nWRIayXluj07rQqe4hoN0tAtGTaGyrSqj7trHqoKYGZiFPz3F
	p1R2wLTpjFVfWTeR7jz+Pb31XWgiNRnQtJNO9wGAsOtwIhliU8zUM5vVh23WAra4
	UXoIEw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04vtk8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:50:54 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8484f26852dso6287241b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 03:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784544653; x=1785149453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y5q6T1WOr2wk4M+dKBh9beKBFr4ByevQ7VYwHg8nO/E=;
        b=erDZzWVNIiMNxamrPpOi6mgrpM5nS2A8Ob+oErNFN0YPa3srmMcmPhcVs5vvTB+HO3
         51Dj/7d+bBVhdX3vzsx2dxBGBXK4ipoE7yoQ2ZudvwTA344greavnKSgn2wTBW4stP++
         4uejvrINRhb7Q21RoY1wUDbCqrNT0PWudIs50cG2oiYLdhfA2sLcNbHzWyJAacLWwj+D
         vf7ao6vaV7bA0QrhReGEMI5mZB6cPY9as8Y5fIInvvstOBbBp8cE0Si/zxn8b2ZZToqm
         OhlRMpYo71jI8ki3W4pmbzrf9UcQyACAGYg7j34Jjxg+S7eiP6/Gtl29aff0ghGSelrt
         2qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544653; x=1785149453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y5q6T1WOr2wk4M+dKBh9beKBFr4ByevQ7VYwHg8nO/E=;
        b=tA4vcQ45aiToJDX+35oUB+ZQmQW+m8IwcP8nm2SY4E8CgmJp8nTurNQmO3Alaiw0Fa
         J8ynAhPhHmcj3z3oyicEMhB3p8aSByrN/9iocZ+kVD68cz8r14cv6djBC3BnPjNjHG8I
         yKRmkSi3DwYd8AFldpFmHXHLf+qyheG3/bgacvj8QfJfoE3N4HEu+LYr8lCxXuEGF83b
         FkBoPqWOW4DAQR0sZDbrG4deMuL8ZPLVS/5KJjo9g+Crs/BkZ561+qRHK0zC5HQVYnO9
         FCDjkYf/AGJ8prlGAIW/4PXbHqdAiuLQ7WA47LpASuKHhIX3z+its+pxpRevR4eLvp50
         huag==
X-Forwarded-Encrypted: i=1; AHgh+Rr78cS72bjwfNS5GxWwfApCPRHiY47ndk/vvFE5N3kp8uwMq2xihY1mUaVW2fyXoQWb3eFVXeiZlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZZhBSVbduCRsO7X+nqT0W7XouOzZW9uiwJI5Ows2XIFGEzmx
	JoAtHhrwN/DKJfG6MOgmSNqf6jYAb9POnIMfCTDuR25Y38ejjc8SsYSPabf+bgIglVbx9JVX5x7
	fu0XJDB0Sbwnf53UfkaEYGNdnwbo4/i1L+xAU+FY9jW67k1NagWqb6X4YYUzS3Q==
X-Gm-Gg: AfdE7cmZtQLWMtY9kVtle60dExYHrh0FQz4C90ZLCyWbhWKFXbXTIBH4SpMbageAXrj
	P3K6bjg/3WXi94BvabrKEHa5N5/saZsz/ugzeYUYbPFqxuXXmzeow6YeUFmuaJjAWYGWoq1ddQM
	CrC5sJH9q950vdTTMfjnWDdFmxs/xzVabylUAg1NnUM+MnzWLZ+en7qgQdb6hIMOaKrdUiXik9Q
	Y/7Wa//e7kFiMdbPnmEjndR192DWNTh1JqfA1n2J263Blt0lCX7IUPQFV/02CM0Gv0SOKlPvQB0
	EIOzQwsar7ZnjpddOhhkSou8kbU0EhvbX/HoQmMI3QqbMWMJHUvdbHd5aStOa6mrUU/cNNsKZN0
	bwYGHf2mJHKz1IZE=
X-Received: by 2002:a05:6a00:94c6:b0:848:6ef9:f5df with SMTP id d2e1a72fcca58-84c2954ed4dmr13883296b3a.64.1784544653350;
        Mon, 20 Jul 2026 03:50:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:94c6:b0:848:6ef9:f5df with SMTP id d2e1a72fcca58-84c2954ed4dmr13883269b3a.64.1784544652872;
        Mon, 20 Jul 2026 03:50:52 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb5159b11a5sm4343368a12.0.2026.07.20.03.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:50:52 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:19:22 +0530
Subject: [PATCH v7 06/10] arm64: dts: qcom: shikra: Enable CDSP, LPAICP and
 MPSS on EVK boards
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-shikra-dt-m1-v7-6-7dc99100c6dd@oss.qualcomm.com>
References: <20260720-shikra-dt-m1-v7-0-7dc99100c6dd@oss.qualcomm.com>
In-Reply-To: <20260720-shikra-dt-m1-v7-0-7dc99100c6dd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784544606; l=2699;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=B2Dpn2axDYIMHLk1wigFR9Q2p/KX8LBdfSSHhm53znE=;
 b=hSEXl+yjQSMLpcZtTvfp44qFT5sxqRAQoE/kRQ6Mic+5t0jaEs6S2o9ncqL5KgISLfsyCWLvf
 8b8h11VqAXgCnkekf6hCNQmjCwpVTvjAA+eHbTmNMz/24/S1zHi/VXO
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5dfd8e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=nu3v8zf0uA-Bo5sjUnsA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyMCBTYWx0ZWRfXzynyMOBp9svJ
 A7LgDSNy6dCSpKI8k41KbP2VVdW+ImysgtWYaAJd+CqDkytv673CJIcEZfJyrtVEs/MPXp19YwW
 PP7dKJyifypVZoJgx1NCtsn5D++5yOKjl1hboC2UmcD7LPFoO4tgj+DuBnKM5VpVR/WCUfoLsMa
 c8M79RsDZooiP7UEY+5x3AMlJ6bOHtMOwJh0k4n3Kj/rq43w7IC2DPOVyTIpOWlMdktJnzjQZT+
 2AvYon5+Gx3+n+B4EGlc231pGi7AvCSsU77zHO2stG7nLk5pCoGubJ/xZXdlkJbrPIxI34/rADM
 ExYAAMhFpUtSRrkYYN3AOLWHz8StiQAcmaqyYVtcr1T6koBdUpUVc6yOXnGjb/SLj76bpU1OfpT
 3CJhJLg2hGZqjmi0uqIlpUPAIOEc4tzdmvNO09ReeaffjD4Ib67tsS15puavu/iseip0A7VsxZG
 Lz7CIxOMgqRiB7H+tGA==
X-Proofpoint-ORIG-GUID: fgtVT-MCdF3w5lM-9i732vyb9pUrvIfb
X-Proofpoint-GUID: fgtVT-MCdF3w5lM-9i732vyb9pUrvIfb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyMCBTYWx0ZWRfXyhpBYCYUs7C8
 T0LMMh8aZZMLUvnZcvRgJWCMvO8GkfmX6GoM6eIDX/73aTxP93IIs6Hd05ajLh8tpRxq8Yha3dr
 OwtnkLY9MP5DzD8eplKWunb6gqxIFVM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200120

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

