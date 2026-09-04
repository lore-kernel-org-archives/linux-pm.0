Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D319486B8E
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536576; cv=none; b=HsxxS11aHn9yGsGO7htVraBax+P23ilZjqxUYoHM6hENYuVB1rk3MtBH+EY1gTtP12KNQxnONYWxrN2H0lBceQPyVsiOcfo2rUUQrrhT0AG17K/G5gj6R7LGolA8xZNbcIr84PfBt8Ru2jXtsb8fxuU9vQz+qLYuwsqSkWAZ5/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536576; c=relaxed/simple;
	bh=xbR26F+2IK0SwAaQUmAO2+Xe1VwKVtt+NKXks4bobiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svYA3q9aYjOSx1vQA58o2UKkYG/Y7GYkYd8rHAISmU4vSLV0qdy9nBl1jc/F+jmB5lL1/2b85fNi+eF/KZTKlvWETl+aPqahD4jgBij54b6So9OsFtd9iTuPGNeMpiHPDmzky/WkV9zQw/fCj0kFtqCKC4bzExN8qzq8CgaGo9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BmEHQOFp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C78XCQ05; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BmEHQOFp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C78XCQ05"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684EiTvU3765775
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 15:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=; b=BmEHQOFpvXB48fJ4
	P1WQHuWfNgNBcd48t263ya3ZJ3FjhhfBm4wN2SuGwdL1U261fXC64ttaIDYxEqmW
	1oUwVFtMAx5KKiJ63MSHVAfIIC5dNLddFLwAAKvvd7/dM68VDCUGOYJvbrMoCPtQ
	VQvXNTvIcP+CALYLBm6YOhSrWbzs3krdf8wFvIfz5KzB+yKtvZVgwDLF6Lqqc6jB
	7yPUDMc1gl7psTUCFJW1mOXNw9irpd9wH5OpCx7l5LMO1rWtb/G9mTnVB3ZdH3Ce
	+wqdtKMygx87w72zbuR2KGWYJ/2ngYaqJXH7WKzPcKQadp8lYbhcppfN+yytyocL
	s1D+og==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg0120m6h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 15:42:42 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-980989f5030so362416241.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536561; x=1789141361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=C78XCQ051C/5zkLm85zxYNCBpzTL6jT/I7Cfftz4GuGn6Uuudg/0AMGWPdXIhRgATv
         FDYluS66mNea4TfdCjsfxSejf2xE/nJ6nH14oIvTRmtiD93fAnA9TNKS1Hxh4O5UC3KB
         VDryFl1e1PuEGC4ZO1ATwQoU8tdMuDyRcCAT4FUcmHJCK2/Wm7sVmHMvPmnW7J9D/3F0
         N4WRujgQ6q4fd+Du26J8oqxF3XRVTJtvhQ8gvgy/oivbfbe5HeAYX/+xejPFsxSb96ta
         Wcy1ZvCY5RRJg0p1I4QQPTLVzAPSmNwqQ9NyfNXW64h+vE+zlS50ztbTZqueXsu/EXUX
         QYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536561; x=1789141361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=D8njriyDWbLwRgcbpLQsx+oJY9Jn+1vE9gd5JXs8wAKZcYbHLw0HyOpebiRblzx3b8
         7gd8xgi8qXYADNLRpXJ61A+DMajREIPQVDL/jVdW8m+aXohuoSpIyrlYsli2g9kRIjI9
         Hmt9TNwV/XMHwZUvdGcTWiuMijDlII2Cg9Y2S5r4jocKnDCDSlpdMB3AiJcV/z3k9wmX
         DF36vqlVt19sLUiXeJN1N47UeD74rJtpFvaJHiFS7vl02shPtmahseBbeBaYsVse/Lx0
         UxPuA3UKnW2Qf5+Aa6THkqKODkm3hcXybNHAMxpztSpOWqjmWuNQhgthKcXxd3tQyfIE
         Mn6Q==
X-Forwarded-Encrypted: i=1; AKwUvBxnIjPhD5kEMmhtF2Jf4wseyuJ13HKtKxtzY92adAtyu4G/VJA7NdLAS7GW1v9vfczT2Wm2nDgLUg==@vger.kernel.org
X-Gm-Message-State: AFuF++lk966gtZ6kJEP27H8mi1EtaKaCpUoCjFHFqLQnAjvEAA16Zhsi
	enrOXP+2ufUa/tBcaAMKBBY96AM0rrj4KhTDRCcU8qIpfA4OC6qcBK6FyF313osJPT6ZylXSthH
	M1BIFIE4059OlK+VZOWi5KXs6BVpFXHdfp76i+Oqv6fdL5Y9fme+GC4qE1Tql3Q==
X-Gm-Gg: AYBFou0JS0+i9QyjmmEnm0ZAPnvvbhBXHW15u+CaaeNNNZmsKO/QkW7loO/odvfpjS0
	2YRZaXF50hrmYtz39DtVEC1dLe12czW6+EZfMk4Zz6nUN3kR89J8lcrKlkVkuOMhqUmap2BJXfE
	8SJSaYKJVb32MhM3vjAxuVFaWX/k6JE31cjMbz4xZkrV93+Xa4VRMvhVRGvZc0fV14pCshZoSCh
	B9EvAO8pQ13VH1tZx/XHnBnkYTNeniA+oMiaNPg5M7kcbjnD03FuScuDU6CXuCeVsS9Rm+101ac
	0kaqlrV65d+niQqO8yKPP73Ucr+ROSosgK2P/rJ5OGwXfTfA1+96y3BljnOEqovnLmdPha2WaOA
	ZYBa3AhFbSexsVCR6oPWso/k6vuaqa6hmey0XJRjpo0+OD9xw6E6gEMt36cZy4ZiA920s1wxV8z
	5t+fHTLykCQo8toOraKN4lNQSL2DiAX/B1RAh+IwZchZ8c67yobOE=
X-Received: by 2002:a05:6102:570f:b0:785:e444:15de with SMTP id ada2fe7eead31-78a4a8b86c6mr2764698137.6.1788536561250;
        Fri, 04 Sep 2026 08:42:41 -0700 (PDT)
X-Received: by 2002:a05:6102:570f:b0:785:e444:15de with SMTP id ada2fe7eead31-78a4a8b86c6mr2764676137.6.1788536560793;
        Fri, 04 Sep 2026 08:42:40 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:39 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:25 +0200
Subject: [PATCH v6 10/11] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-10-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
In-Reply-To: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=dfSwG3Xe c=1 sm=1 tr=0 ts=6a9ae6f2 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX0JJBpFVYU0HJ
 q7zbC4k5jZYoY2czr2ObC96m9+qCslsXmiTs7xSvb2Ts3E/V9KdH4fqAyCE+IecXeAF8c4xW3jT
 dA2yMwTG/JEn0tHgav5DtWBlpxUotIMhOu3BPC6s+6SErdo55awojEiPTFQlSkQ2GU8EVJJLNBA
 o/3Lw+BJTmbMPRkVvCv7r6BCFY2Hq+c2gknDkW+DGEGjyoBBVy7Qd5607o95vouEXDd8XolH+YQ
 aT8hBuDOgPtxS539ofhWA8BOtPCcEik33z8eWG53vG5FJPInuVOnpTtgVGnQwTb0QUszrQEsjH/
 Hg+tlk8SFp92LPSkITPBHqMxEYoyjQkozoVM1foeSEUNx17Pqk5NQ9vtBeCtfnuHTvgQJWnywwC
 PyEF2Be3WfcYa6Tn4b6Hhh2jZec8xsvu5Q5dMgi0dt/QtlYwKjSFxan+DRksh9ER09ajiralpPq
 vBeb97w34zQnQwMzvTw==
X-Proofpoint-GUID: Jr_KVJ2_eho-T0Q45b60WCWuXSAOTMS7
X-Proofpoint-ORIG-GUID: Jr_KVJ2_eho-T0Q45b60WCWuXSAOTMS7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX42jaM8hMq64M
 Cw4djgIjulInw4YWmnG1HjHiopPGKyDuIkY+ghVVENV0RAr/PvnG1aLVoegYng7Dalh/oYt0SIQ
 fSn/P7DoqOtXtiKeC/dBFtWlpW/hnHM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040143

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
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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

