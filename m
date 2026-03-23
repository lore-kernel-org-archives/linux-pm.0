Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7805A1EFFA1
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774228655; cv=none; b=L3Y9Q/8ZQSuNe26YHmJMkYUpsGesucvoVkKuzGaI404ooaqqhVRkW0dwNgFobae3BfkupuWSsYLmdDzoCFjE0+9MtGL2dmD632ukAiorpKC1rOSk2mIe/7Cu9iUHuwbdMqB+/hECRB2Z9lD2ydXO1LjCJ6tIUljIXa7CsHaZivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774228655; c=relaxed/simple;
	bh=yVthNPm3DjOsdKVYIVqko1MZL9hhEvKfRIuyqdTPA9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NcicX05bT1GoDuwSF9GNZfpirUalILCHEa5RcY9t1UCAKf4bBSN2e/Tm3SY+LHoZoZ9RcakCA4Bjehot82abvxn39xJ8t9H1oIhHWZQiiDBaZIaY5QLsBilEhhltPzTmbujLbYdBB560S6bXpbKIfYrJ4300C16kbl17HuRJUrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FY4KdvMy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jzq4QLu4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FY4KdvMy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jzq4QLu4"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MEwfJl1679524
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hhwgxNDk8Z3SvSduo334zellR1VN2y2e+x1xd/K7O78=; b=FY4KdvMyK6U2JkzZ
	xU9D1xEGHdACm+ssoT+KUEzL3peXrb/nIUTBittNVi0y1UO0osI4qS9Xk6ZO863w
	2geJODqjgkTby9JYFqwsU8XOQ8n4D2k2PSSwPXnFj5D6W8sdNJAtzkS6610IN+lL
	qKlEY2C1hrmh9KMeLbfobH0EvxeScVnGAloHUEKcJZczFxblpYLFiDLjn879XBPD
	73xwt1KUg7NdQWQFLuucOuwpDGKhGUrOY1CuestwZgEN7/28Ns36CMTPX+8rOeIt
	FGA+GSUUUOac+SYbxLXVS1LYze+E2PjYUMPhxWZeyty4Ylu0Jd4NsWiWT3K06Bm2
	Qw4p6w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jb5kb7g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5090bc4823cso50823441cf.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 18:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774228651; x=1774833451; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hhwgxNDk8Z3SvSduo334zellR1VN2y2e+x1xd/K7O78=;
        b=Jzq4QLu4f1Y62ctQqO9wqNGbsDQaEWpEEnEZKO3LEnqW0PqgFgAZs4bAG3j5fa6vcl
         OIbXb/+vk/TWDM7P1WmGwaB/qpZk04yalIbgs3JjbP5svFf1tQiMfvOLfmnS4q4gknOV
         NSD0TznBoRHxod1z/8yEl9jcQiYOosoaeoH1HsbPBdzsnCHFcv2RwqyxOKBOzVlzGwRz
         xB4dRweb+7JPQ6OV2j44wTxoQ625um2epp9mDvoi86Pyj7jZn46vZ/rUqxK3NpGC02G1
         VP2zJwUo6zbR1E7MgNcJr90WvAs6Uy7nGMpuH6GrhIxCah9t+BljlYr+RLyn+0mwFoCM
         aDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774228651; x=1774833451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hhwgxNDk8Z3SvSduo334zellR1VN2y2e+x1xd/K7O78=;
        b=pYRjDUppqyDpKFE/HganwME/kKJm8uba8k1d89d7EbSnP7cGnWUB4dO3ZWdZZcwqxF
         FnoW8uk8EKeBae1X+EPMfp0R1EhInm6UwB+BdCDyu5sELMaTk7jAM7Z2KW6YZFLjPV+q
         8chJbuyAb5NdUBO3TV4inzvGPW6zxUD3RCcm0KE3ZvD2NuQFXaAujFxZs/xkJv8Y1/MR
         nw3PYkJBjpq6HF4FUqIDC4ORof7kXmgqpYhdNEqsjQoCMX/B1i1ngNKfk1XgatlGZAJY
         zR3AW5WWvHiKmHnDnCPTlZYiUdcRWMj1VSuMJawiBYVvHYj7dSvrWMr537dfHVdyRErI
         O2Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVSfD2N44pPZ2uSQ9GCWJyU1zX/F19dW6C7esfPCiFFqlPCpx5Z2/QEbVSAoPs+2RnT5bkBTUdqIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOos5VMRnEMIzLaHvmXXB0TyrD9wYnf3q0siD5vimFoxMpSRip
	RmzNqLVUOtAps51WFq1STPcPwbSm2joYLMqn9zqnaJvCNcoeyTkvr3T3/o+nSlO+hHQMOC95Gmx
	gdSgwLx7qKu/Yzv09qZULukL367VUD+dKGwvSh6QDIy2PFZioF+W5Sgy/+XoMKw==
X-Gm-Gg: ATEYQzyD5VTtlS5FL9ZinTIi7d0x51/fwar6Ee7Jrw/b258S/wzYKXR/Dhzu7ur1NA6
	2OnKCn4BZZ6+qzLoIzzfbU0Ws81OBnMa7ZSKcpqhp65nDrLLv2c3mmBqjaEdG5aiQOHMnCabfwo
	Aao60q26+oHY7s0Te3INO1ye7Dc+67HGxx6J6ECaJwe9QWCvgsTavI8n81g2xyJGZUfgKJmZqa0
	pBord0dMeyhM+Sx6TQSYLIB+DQVP1NhbkULB26DXPhM2bGA+khHd4YN3makg9sUALvLWTMbrNHk
	E7PyNzX2y94VSECfKEbZJPFYksYiBbsXB6JNvx6Pr0u8LCOZAesGOp3LHOGwjM1uqtmeNnc+ZmS
	/NJiNxsoGYzuEOBuRnO4nvo5WHbXM7vGaCkBDHPCWkX48+pS9WDJE4YKMm+CbElEWmxzXVog7kw
	LYeybxFPsLIaiEMPj83qC8N1w6Zs2Bse4EsNk=
X-Received: by 2002:ac8:5f8b:0:b0:509:100e:50b9 with SMTP id d75a77b69052e-50b3744b162mr168872841cf.20.1774228650794;
        Sun, 22 Mar 2026 18:17:30 -0700 (PDT)
X-Received: by 2002:ac8:5f8b:0:b0:509:100e:50b9 with SMTP id d75a77b69052e-50b3744b162mr168872571cf.20.1774228650277;
        Sun, 22 Mar 2026 18:17:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2853050e7sm2216150e87.61.2026.03.22.18.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:17:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 03:17:18 +0200
Subject: [PATCH 2/9] dt-bindings: interconnect: qcom,msm8974: use
 qcom,rpm-common
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-msm8974-icc-v1-2-7892b8d5f2ea@oss.qualcomm.com>
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
In-Reply-To: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=yVthNPm3DjOsdKVYIVqko1MZL9hhEvKfRIuyqdTPA9I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpwJSer1NjPeJAAeCFMaqyxMwRyKlECRmJ7dvj+
 hY4+MkP6zKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacCUngAKCRCLPIo+Aiko
 1YT6B/4oEXhkbm9aK0u/bRgee4XhZ4QKARH8HUCPa8uEUa2iRMNiXqId9Wppq7si1bV9u6WFQPM
 Pkiw8y5oZSoA6GqIMmvUWECOnTceC2gE97WmvfM9x+B9899/VmedCxZfzkrQ5ssN8lubTe5N4lK
 paOhSKvx0ioNCs5gNbYEReILOQmYfJchU3o3FLdEuXfvdcC1DwnQtmWK1YxVJXRDg3Tm/Aje51y
 eQOfRoGEJO35dZpkS6T2Gls1a6z+1QzQzDeuaogqYCd5hP2zFGsrsvEb/dIDLnOsYxyWYMGEQTd
 J100fGwG9/LuVDiaPGD1MdsG29SpiB8koH4/QS47m596utCt
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=aJv9aL9m c=1 sm=1 tr=0 ts=69c094ab cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=wtXhX3L6yvnwcyBavz0A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: IiGQ1SCfD3cBwRwx-OVGQ0ufd4QMX8Iq
X-Proofpoint-ORIG-GUID: IiGQ1SCfD3cBwRwx-OVGQ0ufd4QMX8Iq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAwOCBTYWx0ZWRfX3QjIM4UlpJ+x
 9neZD2G+1VYaUiErp1BvtTvsymB2VTNrGuXb6ry0XUHFJ1goBowj5JWBwpEcukzd8VFzyH1RN9a
 N/+0qHJ6Z7+KZViUDianZhLxosQ24HgPVMVS0Fib4CgPC+fhbVXfrkF3jSz7WZHu+TyrNAHKPMv
 upxJMy09Ix56WgVcoICfLQTWiMFSxiyvYbj7mOnoY9jav+5gD1x7bQqbqff7QR/+7KSVItJWkvs
 hPlem3giPIskE+hL5pdxJCz5JvJptWvBBHrrDRHVegmnLMIdqeh47lQ2fZSvsEKDe78e3lD7LnR
 63TE0IUL1U2d2ahoCyKBW//z88PSrgmDGrsBqrggJRfqhw9VDj2+Kjd4ip50rJhYeZFIOpNL4Ei
 x8uzKkNv5VeCnqx++cgrADvEG2/GSC0a47Dq7mNeEmBMqukNLh5gR2zBtDPyimCoiROsVeRqVeD
 B5NX/HeDl+2cmGTkeWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_07,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230008

Use qcom,rpm-common schema to declare interconnects property instead
describing it again. In future this will allow the platform to switch to
the two-cell interconnects, adding the tag to the specification.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
index 89a694501d8c..b35f6dd11c71 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
@@ -26,9 +26,6 @@ properties:
       - qcom,msm8974-pnoc
       - qcom,msm8974-snoc
 
-  '#interconnect-cells':
-    const: 1
-
   clock-names:
     items:
       - const: bus
@@ -40,11 +37,11 @@ properties:
 required:
   - compatible
   - reg
-  - '#interconnect-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 allOf:
+  - $ref: qcom,rpm-common.yaml#
   - if:
       properties:
         compatible:

-- 
2.47.3

