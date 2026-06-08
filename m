Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBC033CE88
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924248; cv=none; b=TNA09uceE5vdFb9AX75/k2+BI7iGeCLER/SrZUIcKM2z18DtLvroNdTwPFcQc8xfj4KvRAYgyZhDZHxaVeqcdm2RdqHbneigW+xOMdnQ/JSDuVULQ4ASwtamPWmutBKCjB/hVKLVRTXnje0nDl4Pgw5W9h9soWTNtCcsf51xot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924248; c=relaxed/simple;
	bh=ue5t/Mkn+WXC92cP5D+ch+Xn4xQc5TBGd665tzA8pzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uobj6pPFaTlvUBYGQzCyTw7yVc+Q3T9bzA24EmtDaZoOXkrxPcn0gxgLALuA77e9tN5KsMQCIfS/e2C3+gnNayZDRA8bKYOFeckUU89FN02vVm98zerkP7JvEGizwcFhYz22oTAP0sLpuf4CyK26k166FXx5eegVAkSDNxpvsZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f0sXGvMY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JUCxNTka; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f0sXGvMY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JUCxNTka"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9R1F2965398
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 13:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q48k7tN1w7wJ+iHjXC9qpbNvZsHt2Qv6AjglorJLZ/Q=; b=f0sXGvMYdBfdJ9yB
	rEQBGs2KLEhft8D6oOcL7tbyQ3vztZriItaqmWrn3LddIxVPGicA5WTIJddK2e/1
	OfFzZj5pJwbvAuK2TcUsevLNwkJ+J+oR6hwCYoQrQOxtyK1j1kaopxoB9wcgiC/Y
	vgq5sWRnIwhyYUrphmkSPoKnZfzMH09kpmBq7wdrBkOF/e8swWcUWg5YR2DB+Q64
	aozW5nQIz/45C2rgSj+BtLsW3ZTzF5HAUbxvs2XdujJnVDV0pM1qSe+m9asuVg2J
	Ifhqa4VezWkSqmj6KQc2RiB/nzH8zD5CD8YcMw0hVe9ZyBKD+Qkl+5rdjhW/uQAt
	Ei/GyQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entrks218-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 13:10:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso61506685ad.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924246; x=1781529046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q48k7tN1w7wJ+iHjXC9qpbNvZsHt2Qv6AjglorJLZ/Q=;
        b=JUCxNTkaOA1aUmUo1lPRJ8k0+buoGIENBfQ+IBPSsQ9gSNoF+JFNfqJZ6nBzheA1CH
         g4+UuCNS+96PBAlb2KXqv8e0tb0KkODRvuZy14dbl4XEH3kpmsrkFpBuizREQ//nQ9hq
         Ui6qSQd6cXpE+VqXfiN5Ia5F42jHkUQuqKGWsxmy2Y3iAWamxylo/fSy11ZtzeZII2qD
         amLkee7lOy7Wr2u9q7IiTxzOVxEHrttf9Kv3EmTuB7b4EMIzg/6A0ehhld0P2tpC4gCv
         gIqMx0X6DA+0ToGcLv8EzaA1uAlPwfFyAJRLe8O12kQ+JmH0kkCAklDekM4Sj1VAR2zw
         Qa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924246; x=1781529046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q48k7tN1w7wJ+iHjXC9qpbNvZsHt2Qv6AjglorJLZ/Q=;
        b=UC+9eGdze+CrAkyyHBaQmWGh26n4p+YsFY4Qql8rsKb8RV1sZ+MWTRXO0/Wf5R9aWB
         tK2w5iCSZRC0dWjcPyh77j8NIUL6rJIp8aH1LuFS0odw3sp9eh7rF02nrgdkVQNrzLOO
         5/g0yCoP/dpKm8GRFOZ/Nx+J5jfC5WkSte6BD5CoyyyXxSf01EpmhUOh9Cf/qGv7zBy8
         1Rmd4aDaGes/00b3hIXMpNGmo3ojSeuBgJMnsLiP2Iyi6AVzyGxFkufn9HwkiF1Giwpe
         aIEzMd4s3j476SxY5mDX5PbgbXBl096T9a1dnWclrFjgtp06lVw199Q8DixFqK0pES7V
         lBww==
X-Forwarded-Encrypted: i=1; AFNElJ+linU+1OxQFwokMU5zIdSO2nkKHQ0Bq2QIU72RyhcrbOzvy1fySO8/rwqzl/n3TM4raKW9BzWH3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHAx5MWkuojWsdVHfxtqQI5f0a+C3csSNRJM3n2dzOPkamyEh/
	hR19ujJRoIXjkb0k3+xX2Oh1nB/4EkLUyvcszmcmiDippWL8/ivODm7OcV54HOExfebdEE0LcBw
	BfwRlJeFlkL/unKG27j/GS4BC+NZ74VXMsRPYJcS/0DfmGflbo3wjNIOxl43smg==
X-Gm-Gg: Acq92OE2c+1miFyC1KLt+hiN8dthhbnb6ZItxH2TI0cSAj0BxbKh+QXkO1EMCzbloVu
	tCFtqrL17Hb64ugBfnBCmW/IrdA39MInnRsvBx7tEhIwzpUB/etJscnX0FtUrWRpy9daMgG/SAq
	DHNUADDEz2wjGKxxrYZwD3/pn1+SdWzwHoeYa5Zk5BE3dkke2OmvpRhlfYhz9cKIaDwiHOEIp9s
	g8cpIYo5KFaw3R2suiYECQ6XWWVwkYays0G2LdoeYobLwOkV1f5DUuj5kgzT8NSZteMsoOndsKZ
	5bF5ymMKKFNNLhYbmGsqvNdpFFXWHp7SOMcrZlgQ3mQqZHaXYSoWKayX922rawOsWem/lu7VGpJ
	pBg6BuhzggBtfBYwfdNxscLHvezpJBL09DT+RlLyj9x3Pw6Y=
X-Received: by 2002:a17:902:eb8b:b0:2c2:4ce4:c5d4 with SMTP id d9443c01a7336-2c24ce4cbe3mr74750425ad.17.1780924246246;
        Mon, 08 Jun 2026 06:10:46 -0700 (PDT)
X-Received: by 2002:a17:902:eb8b:b0:2c2:4ce4:c5d4 with SMTP id d9443c01a7336-2c24ce4cbe3mr74749995ad.17.1780924245869;
        Mon, 08 Jun 2026 06:10:45 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm185235845ad.83.2026.06.08.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:10:45 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 18:40:21 +0530
Subject: [PATCH v4 01/10] dt-bindings: dma: qcom,gpi: Document GPI DMA
 engine for Shikra SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-dt-m1-v4-1-2114300594a6@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
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
        Xueyao An <xueyao.an@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780924231; l=1050;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=siSRub+fQLM5lCWyMREXkIiIBlOosbQGbKhyD/VrTPA=;
 b=W10DtBgK7FWABUPtedxztsCQ/0oAfxE24Fa3aAckjl3CIA2i8EFpxUPo5r2As4NI3BL2z4jDK
 y1uXdp07n/mAZp5YTc46R4v2VRxxAMSldWE4yVkqIheCFiqNO+WDf7d
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: RShDitQa-lmeIkWC2wMqD6aD731LzFBK
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a26bf56 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=FVGO2dOrgB6TF-zC7f0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: RShDitQa-lmeIkWC2wMqD6aD731LzFBK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX/UxudftWAsWO
 tYe6kuUKku6DaLCh0iaECVYc327R+ikAMF8HZasAKjPEDFr7l7YbPZJvwpF+06NdfqLxQUqwgve
 RmNR/nhj1qzzc8M/N2e7pXUTZsixvRpAY+7MCwoQyLUJ8ycoeSInqJNflT0mJH5CD3BAA93F0t3
 YeVD7ldhRUSUWVLwatcAC1uMmo7m2tIZD50xBEN7ZXXGrctZmGnkmGyV5q6DQJENuc8J+3mF6hb
 4Yk9o7zkRBEVG7T8KTgdaQyfT388LsbqQOpL+DP7ldJfbByWu1Lg3XkPXIcswq5doRnRUMLV3tC
 op+rN1/NCuvtUncU1s9hyNuDMlBh1po7BHacsLKSf0mjs2hcR0JF27dzqoRqPpy3JehX9GlT3aW
 QcNDjjzMbSdiEGa4ZXAexeacKORT4krngT9T348rBIIzLEKtiPsEHIm723WvKYKKLCQy2oYa+3i
 da2msu20X1C4QFrmPUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080124

From: Xueyao An <xueyao.an@oss.qualcomm.com>

Document the GPI DMA engine on Shikra platform.

It is fully compatible with the GPI DMA engine found on SM6350,
thus using qcom,sm6350-gpi-dma as fallback compatible.

Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 8f9a552fe30e..54dca623223d 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -37,6 +37,7 @@ properties:
               - qcom,sc7280-gpi-dma
               - qcom,sc8280xp-gpi-dma
               - qcom,sdx75-gpi-dma
+              - qcom,shikra-gpi-dma
               - qcom,sm6115-gpi-dma
               - qcom,sm6375-gpi-dma
               - qcom,sm8350-gpi-dma

-- 
2.34.1

