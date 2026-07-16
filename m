Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A4383C92
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218738; cv=none; b=kDmb7B0XTtZKxdJKnVa0ENR9Rd1UzLqwHCbQ8RyK44ZjHI0I/YH0vGU7gummu0tEzWBIButaDlRKVHN5C/l4+tHH4VVuCjnDVNrejzgYWay5FDtn6CEYUVBjZPekB1klwLIxLHo85pdZjgvnwYPmfzNsJXq4IBuVyBq7Kuw9UMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218738; c=relaxed/simple;
	bh=AKJ2rYuq3UXtw84o9Wv2rgBoSN8Fv9N585Y291G3LZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=is22GrBr075UYl82AV3FZhjZUHusieNWj5R5HdUxsKg1iww13scBu1Fas7FwX8FpP768ZSNVY4/UjDyBccJt4DxdSxgK5WZI9dZR6FWMaoHRm3ceiVLwrgDj0phWrxYGnEe/ugrZlcJGcJdSX67ROXl7DqvPFWPWZXKPJYVEAJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iASYWyQi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=USWxPA0d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iASYWyQi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="USWxPA0d"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJd9r3988086
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lSQgtm9Gy/goYjkRUPvH4fsLeTRSZbUNnPPwbkXFunA=; b=iASYWyQiOGz5VgA/
	XTn0KGINXOl7iwun+L+oaK4UAkSppUti72AQRZkNnhLuR7vlGMy9mYHpJZTlL1AS
	UCOFvEyNexd/9B8cYqhNYm874EsqBHlM2inRvqdW77kI96fLNTftVFb/lYiKLtsG
	izL6/2U1hmISKnZKom+b04CJLrwYK/woloqfhSEsBa29akkHZBX4MrQzNyd+LEbG
	YONpu/dlF9TLwyHAXLY1UknVarwA3a50abYjFz/NLt7GhRneucqbDGu+n6johAq5
	POp/1A0LGxxHL8eQfEhXIKFoL1sxcvK77aXu5LiRBgZT/jAy/9+35RjtxI8XPFoE
	ub5I5Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feq3pk73e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c19493ac2so119581671cf.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218728; x=1784823528; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lSQgtm9Gy/goYjkRUPvH4fsLeTRSZbUNnPPwbkXFunA=;
        b=USWxPA0dquVSQCqvRP/vyS8ZY0IzO7Jnh0OHbV+D/3D4RPjH7zGsTYDLljjG4kU9QU
         0IV4wBID7q2wPFNRuUmYo99CUraiqK2SvWuyp14RKFcZKGiD52es1696Rp9oe2KaRyu0
         bzL3pveUsKO1jOFvwSlftMq1LiscsWRo6IyeDK7Kiyt/Mqft+r2KzF4f29qZR1iWiqYW
         RU2CzbBWDEUDgDB0dJFOIh7gvyCuRaVhAvIGNk+lep2tRFgvFJzqwW+Cdnvkapf0uTZp
         xgD8b1DOobcKRlYN/Zd7JCjzopJUTx6YutGEIzJTx9o+jzjzvMjtjpuBtcEdo1SmogWg
         ln8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218728; x=1784823528;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lSQgtm9Gy/goYjkRUPvH4fsLeTRSZbUNnPPwbkXFunA=;
        b=WgFJqIDrpWFeWFL8Yg9MoX13TLAroAK3ACVVWQTLeftk0srCD/9+XsFjySew5slkxE
         BcahuyQrsaJD2wa2bsbwdJDwacijf3VlgDSpeAiXebVtflkkRTFq/v4wbAXvXELZBbav
         UPz4diWk0nauoGRTWO3yC6/kH3o5Owep4osWHwzmN8TrKTmfglcddN2bdmzhapnQyos1
         D1Dv9M/FJFUaUb7TiKUA50syPTm/JULqVS2XbSMuwbhQKonqpX3H1m/1bMWW/B+kfZ0R
         lEyeUYpFvOslYw5AaTrlUQOLFocpNcy8iNMJdDnsV+SXXu5oat1RunRXeX1oyCJ9oc4q
         dgug==
X-Forwarded-Encrypted: i=1; AHgh+RqtDLX2dhnUlw/Y7lQcYT5hGyGAr5A1HUEEoeXGHs9V0e5ANiFI2AjSFLZXmz8uJjwRhwgc9dpkbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbOlENRRNFsCFwox5b1NmrXzuP6zVIs+lAAweZvG3Xc53/1HHc
	rZ34bIxYtff1PWnZhdRqu+OHtOJPa+Tc+cfNn18XDEesTyiUsx/W+qjqUw1UohIwBDpleIjqt6h
	3GYduYuuB+4S51HFvBBSdzglbf2xCbbMRixX4t0Wp9XZYzi/9gsgsEWf1MzVBdg==
X-Gm-Gg: AfdE7cm3zSM+W6MP4zoge10fy7pdfR+M3fahNWDcn9PN8wRRwzbIZ6CIqGB48IWt/Gr
	8ZTcvGGjWkTllqbrQyzLs0yQuBu0fbeuIeN1v/7hMSQOfKGOqLJTas/uyaUqUaI8sFicyzMxbuw
	NEXunEo7lHZ9/++3wRev9WA0EKEt39aNzVVryFZgfZ03R4XnSHXcZdVEajP4n1YVhGb4wu17Ule
	3OiRrzzIJN7axYc5eF/yczvoDQhbgcHHNKlLVhAPk1U86xaLzyedQixQ7whQ009Ff2nObUUc6Zn
	vI6/ZwtDbrOoP9TVGqRsW/Fpo8A3fhdNP9wJy1xNsEZ/jIk5FXDxeqjx3Mk4HkMs3iE8/fXthZQ
	er2i597LInbVW4CqqMj5f/C+unlAL4wV6pCBrZwxHfhYVcS0FDJMLJ9PxKvT5WtOCKrHFcAdFCK
	HzHczhYlSHZZBKdGl2DOregq0LUE8swkqeDtErHmTwJFY6mG3gN/E=
X-Received: by 2002:ac8:7f92:0:b0:51a:8c9c:7f3e with SMTP id d75a77b69052e-51e424dc615mr122134671cf.65.1784218727543;
        Thu, 16 Jul 2026 09:18:47 -0700 (PDT)
X-Received: by 2002:ac8:7f92:0:b0:51a:8c9c:7f3e with SMTP id d75a77b69052e-51e424dc615mr122134121cf.65.1784218726995;
        Thu, 16 Jul 2026 09:18:46 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:26 +0200
Subject: [PATCH v4 09/11] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-9-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: s2T4h3iWoh07UCr99jIaNVy_iYTAytSe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX53KV8HWbhBx6
 wST5QvoIBNzaBbK2aZ0kP1hr4uBJYOd+Utv/CEULwYyDdNXbnaSPfgtUKXxNrX+fzlLEp+ulqWm
 M6zXFgqmgDbRaIiI2UCDlpnZmTFHu/Y=
X-Proofpoint-GUID: s2T4h3iWoh07UCr99jIaNVy_iYTAytSe
X-Authority-Analysis: v=2.4 cv=PN8/P/qC c=1 sm=1 tr=0 ts=6a590468 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfXyAtpVwLJbuQL
 gjK1jYA+zYkliAUC/V8/IuchIFbiIE4McNURcEOWfgdDUEs680Nxl2vz9Kre6+fnMO2Vm6xPWqg
 QNnDwkc7RvzhxyIG/StszKBYQrDgGZcwsxLeLBi3sONYCC4Qtq1iA0pNUIKuRqrYIOwMBWdTaQh
 ZPAKWA3d/OvcxQtnkw98BbYWAS8Q5mzzEKmEXjlC0yg7x27i1R/SY1bBu++L3gn7rteVdg9Yecz
 kWUpLFdCo/KOEKOfUCQuhIn1W1QuYYogMX/mbANefcGUqAlerUdoI/hcQixSDUwK/TlFUbiXVys
 hQeKAGAdXkBK8Wxn/BkktVMNtT/VX/8dUSbHKK/xV6BdThOqDprPoAopd/QT9WCr+LaP6DzGKZH
 wFbO0nhOFCtkFjYpAf66DUlnDTYflpSbGI1FGLkAIQd5zDY09WoeICu6WuWP67bpGGBTl93MJCK
 gsFFaVJxA2jgZgyR1MA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160167

Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
Key E interface signals but are physically soldered as an LGA package
rather than plugged into a real M.2 Key E connector socket. Such designs
are not actual M.2 Key E connectors, so describe them with a dedicated
vendor-specific compatible while keeping "pcie-m2-e-connector" as a
fallback for the shared signal semantics.

Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 found on
Arduino Ventuno Q (Monaco Monza).

Add "qcom,pcie-m2-1620-lga-connector" for the M.2 LGA 1620 found on
The Lenovo Thinkpad T14s.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/connector/pcie-m2-e-connector.yaml        | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
index f7859aa9b63469cb43919c0b5719c18694c5364d..ce6173a0ec41cfe8ab4a5780940999c18674ab7e 100644
--- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -17,7 +17,13 @@ description:
 
 properties:
   compatible:
-    const: pcie-m2-e-connector
+    oneOf:
+      - const: pcie-m2-e-connector
+      - items:
+          - enum:
+              - qcom,pcie-m2-1418-lga-connector
+              - qcom,pcie-m2-1620-lga-connector
+          - const: pcie-m2-e-connector
 
   vpcie3v3-supply:
     description: A phandle to the regulator for 3.3v supply.

-- 
2.34.1

