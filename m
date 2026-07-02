Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CA84C9566
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985909; cv=none; b=ARTc84zeQEZ9CKH9erd/KDdFmc+8qaL1TQxOucR8nfDt/3Hu/z+iBM2MM/xfexIYf8dJo28EGqYOq0xp5Ups5I6OPSKsLAHqGPDXfvh0MXonea4abfxBRKaW87SsrfV/IG8KaIbm1lqUNpl+kMgn1uEo8Ri2tOPsTtsVQP/LiGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985909; c=relaxed/simple;
	bh=ZtZsdV4JkXxbOxcKUCwhxX6Lrgj9McW3w3WH/d5uxLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m4juGbY2oJonS2noJsXamfNUCygD2nI7E+7/V7BQjxME0N/qP4IX1rsB5mYwHatDfPT82u52mdFqXlbrf6okdeCU4acuFSEUGZtgcjQK1gEKqjsuVoUAWLSpmVsXtxWeeRmLstIC0H/S+n+Q9Qdyf7/bor96F9FDV/DCaKfqukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SR0NRDn2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Kwj5Ln8t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SR0NRDn2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kwj5Ln8t"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629KJsd4115130
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 09:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zlvi4GBsjhcL++MyzJOh+e6LH6/D7aaIomb2JYpGLck=; b=SR0NRDn22lvQw/4x
	iobZjKk1eDXxcfnFV91OcbgryKNA+zU7UWCE6Gc0atJjFoOW7a4ZZzMaEVtHYrEY
	+T9COn4qyMYwPO+2r9tCYzMeEgvXqpytCNYLRVvY0ToP98yS+CgGBzPM7Z6UEbEH
	TZJmsLPGB1HJWxNwHmsXBf5eHsiCuEr5w4at6SQbSqETsd39Unn6CNdHbAd+c99n
	UbrJKV64QaBKrRLa1P6DwtF4or/7sY+9IDEi8bZdlV3YDHOP5iUWUT7h6MTT1v5+
	DNzjevcW2RvMkw6sxS6ecOf1ljlXfX1YfymvN1BVUGWt8H7TiTB56qzqr4ss1m3a
	ntClyQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9403uu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 09:51:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84622d6102dso2066340b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 02:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985907; x=1783590707; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zlvi4GBsjhcL++MyzJOh+e6LH6/D7aaIomb2JYpGLck=;
        b=Kwj5Ln8tHb3OIAjyBOjXQV8hZYb5U0vUVHWTLUiwpXQG8xI1x1dJehqtZ1PFdgxF5n
         HsyCBtRKFQTJCIhqux8Au47k5sJZpts2XWaS5Lo6O5ogVf6QBKrIqpyJj9UIYXYyMxBW
         DUkK1WFBTCrgjddOcp5IO5S2iAJY2pkv0moipW7EKGCaB7ICiY6u6gUve65/qucQfiYF
         P8P+Af8wq/89uyWczmZ92ZVR9kyXZlPinQWb8b8hELtIODr2tl+JuEtVa4op4amIOQgv
         9IVG4baNloxUjxK3E+N1KGAWcPV3UCAYpFtJs9yGZCSAx7+nDLhhgcpEW7J/EE4XHQi8
         NNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985907; x=1783590707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zlvi4GBsjhcL++MyzJOh+e6LH6/D7aaIomb2JYpGLck=;
        b=oeyjK0WEZ7HIZI/Q2vWmDfK6jmUClsjm1Vrd1iy+rgw69fpNtdp5X6l2UTBX1ersX+
         HzMcB2pLY0B3CaGH/Od9IITHaEd6a+93K8/vKyyeLW2MnDj5KVmCP6h44YeQ/1AvHo44
         5qAWOKqM1bmCqTL+YhmX9Pk/76ja6M7WCL/6me9FVLWZdHpSuViRv+/YSV5baTLZw+TO
         cLEKkJKaCnyt+1w99A1S2hlAp8FNV9SgjLodt+YAhWa7cCsQnPUJoPAoZQN2o9LIWkQe
         3SPES6dDt33ccFhVI531PEY90J6pBf45Zv0FPcTaEBguz6JMEp+2dmsGRac7aRpRNw3R
         gsrQ==
X-Forwarded-Encrypted: i=1; AHgh+RqL02c7V8TyJF8Wqj8EWeULeMizAJ61u35Gn/EK2WvhF1bmwOUKeI1SXFUlPYD7aIR9/8Chfi+Gow==@vger.kernel.org
X-Gm-Message-State: AOJu0YybM9sTAHw4Ci5mT2039F+3IqfeoK6qiILF2j8NzEfhnyB0Pd3p
	MMb9s5PRK6VdNbSXipig+1cD9MC0dDYeQD7PBjR9DnZ/6/toBrGFcNgdvJQQnC7jmIIFp7nwHbA
	rmp+VtAYRoRxoR1BRZLucnGCfnSxu7neFjcO0om10nH2LNpw/AvsQClriKq6jAg==
X-Gm-Gg: AfdE7cnTIjf6hxnCxI5x2CiRxf3VqHG2bsPDLkQMokPcwfevuOSxErx0TKfWLgoxytP
	oQ2/P7R4g36K6KWrX+hbSvevKIT5naqYOYT0ppNMWTdJstwRtCazyzO7ctlXxiKdiBdReAs1vbq
	rv3mo3rl4iEJ/KJQNt0apQXwBxmaGDZFS2KUc9+Fx8sKFmeOXzjn0ihFf0013QXBJ4XcNgtfYjM
	hKeti64vX3OMurhp8Wq1TSq0iBONuoDnJPoUD+VO8sQBQSRgjs9WQSL0ZyrONMUJazKG+cFL3mb
	YxywhGi9hDqJYOBcdbEcE5ifab1u7Wf2WwQ/lQ9hIKLpldwF0zv7L702362yLqCJ2/y7E+6sG28
	6sDkH0khRqsRPgp3pulXk5ZK3IQ==
X-Received: by 2002:a05:6a00:3d04:b0:847:94bb:30db with SMTP id d2e1a72fcca58-847c51b72b9mr4232446b3a.49.1782985904070;
        Thu, 02 Jul 2026 02:51:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d04:b0:847:94bb:30db with SMTP id d2e1a72fcca58-847c51b72b9mr4232416b3a.49.1782985903508;
        Thu, 02 Jul 2026 02:51:43 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:51:43 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:51 +0530
Subject: [PATCH v5 09/11] arm64: dts: qcom: shikra: add WiFi node support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-9-f911ac92720c@oss.qualcomm.com>
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
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=1847;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ZtZsdV4JkXxbOxcKUCwhxX6Lrgj9McW3w3WH/d5uxLA=;
 b=JHIFUjwh8ZTgiC3GBrS3iPiXG1b8RKwl2fVzZhOo9lgtfDqizMApzLt58p0nx33cBYI3mp1fr
 lfHfzqFj66jADU/uSZVWcLxfQnsVAEg6+CIfIDZhq296tyRrYgjsyvd
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX4TSuTpDZ50pr
 +dVKCSNKm/DJg1Lu883TFjXLVX/4PjhpMpfc47vOdKr2t+swFtzT+86iJi4z6eI5KkqaKJi3wlI
 /BaFPfTLvIQPQ5rC0RsnM/lCZ02Lf8UA8wSd7lfL5O4n2tYOF+2JU5yBrJ3Df8Ek+l8i4j9M1Uc
 6MFRuf/9doLjSi68bDkJ5OdjXVmZIlmngDGpnU430KZi49VyoXw6UXnp2MrXDnzRYtmGAqNZmql
 DZ1ERNJPHAjxc7cWjwWlrjIwlkMFnZt4NryqxaBFIkji+jnfOvMHipZefVaypcfbr1tZKbnyQXv
 22/SM8DF7xBHUr6WpUL6ddprWMOwU+9NbfK5MdaVNOYD9AMarWAAw1Bsknbd9d7NO/Z9EFxHMUK
 GqN3c3VLR2lH3b06TqsSekaBWLetdK7HKgwsib6ODEu8KUxEaG4gMRPZAfUmseHpNW339nuaB58
 2ZLjW8R14uSqh6S3CnQ==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a4634b3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=QXJAvSDBUSNnL2LUfNIA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: c1_5YaYqYPA_B8oPYqykjP6brY_RSVZF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX25C8qtpL06Wr
 W9C4DMe8vrz5syO/1Yb0Y9MLkIaaawuK9YTsmzRz0/MMdtj59ZBXt/+vz7IwPyEtfIuzczMcWfb
 AOWZt6yfq4sB8L1xfXNDmlmFbo0KDLI=
X-Proofpoint-GUID: c1_5YaYqYPA_B8oPYqykjP6brY_RSVZF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101

Introduce the WiFi hardware description in shikra.dtsi, including
register space, interrupts, IOMMU configuration and reserved memory.
The node is kept disabled by default and is intended to be enabled
by board-specific device trees.

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 3abd0a686d0e..205814c4b349 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2079,6 +2079,29 @@ apps_smmu: iommu@c600000 {
 				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		wifi: wifi@c800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0x0 0x0c800000 0x0 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_mem>;
+			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&apps_smmu 0x1a0 0x1>;
+			qcom,msa-fixed-perm;
+
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@f200000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0xf200000 0x0 0x10000>,

-- 
2.34.1

