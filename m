Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A653090C5
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 05:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779860244; cv=none; b=tDE0fMvWLOYSMSBZR3q833VcBwo1jH0h2v9V7TU0ltESCFvyWFIzOOHv9qW4PNfuGlqhlHcgRNBBTM9y+9DoS2QKFU7qx/kQD80rRNyASrEX/XPkEUCl4sXFf25s24BCAOiqtIsv7Tpw3jJqwGu8WlxxMUtTs8TwruJXBmxtMQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779860244; c=relaxed/simple;
	bh=dMLwqR1crQi+4CdMwYL+C6nmcS074NTfuxIqhzbU6rI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=duGGNUghSrqDxF0S63Nb7MSLemQFKVUmeXtbeH6dgsKl6OVb3I9/nf/u/THsjPBAAOjwyaFr+xl1DWiSicz21AukPSuq6xL4W/36psdsHkHSuU8JvpGaq021bGQVZr8Idet9Gem0wg9FBSn0CgjZy6lNKFnFjj0ktFG8zyQ7J/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pC+m3AqK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AJMHSCli; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pC+m3AqK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AJMHSCli"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R2Wv0M019336
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 05:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U/BfpPPa6tLkYdFoTNDCcKAqwX8p0KQApAnuVt6hWic=; b=pC+m3AqKIPRfqehx
	dTwXuVZ17ZIvPlzJG+YmZPLdfMPLQJqZ2Ra4jjfHzZXkVA94hsqRdWc4sChiluDs
	6yvx3z06pB5YHPoAFyksHFz5Jyc64u+pmqNuhGWCOuigIUFbtUsHIGSy2JddiVqX
	XhCbbGiZn7kV4OgbWfQaKTY+UZBhdpfUsvOhCvqMhCtlGtVSCKUYppaL1TwgP9aQ
	5eBfkGg6imYrQaZcG+4EJyNsWGyKV78xN4Wk1+ZS0K19RHpCJRzyQE23BJji9hFM
	hj+jM7gIcZDHnaKqcYaJZ/QAYq7LSx+a7QzsLOg5VOSaTmXCoAzPRNX7eM8DBmfg
	deHK1A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eddqktut0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 05:37:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ba86e35aa1so180906045ad.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 22:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779860240; x=1780465040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/BfpPPa6tLkYdFoTNDCcKAqwX8p0KQApAnuVt6hWic=;
        b=AJMHSCliTb5WNHxPMlycpL2Lpf10Aok04Q2zDwrz0JhkZtkzXB32IkOZ0uPe8Di5U6
         NmdD7QNeTTQ59n2C6NUkTuFnd5YzkTEtRBdQlAtf7nAFeFStNp18rc5foL72XkYY0OKR
         eYGhmLmHtP6TdLNI5jPS+kwSn2EvlG6sHFz15tSaUUI47oIcljVG05MB1/qCvwkZ+tKw
         KyMwMxMbMIZ4izqQX1hl9ZGZaHgmMk3jQCkDilu/c3XlEvepv2D/Mk9uvAE/l/d0aa3Q
         0YF7HxcYSH4ZZUiHeT+s3Q8XAUzxuma/8iv767V6a50MjzqmrYEUj+pNgVnrsiwNgkiI
         ddHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779860240; x=1780465040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U/BfpPPa6tLkYdFoTNDCcKAqwX8p0KQApAnuVt6hWic=;
        b=cwzVifRRvYg2TC0tZOaRNqbmApoGj0HuegWoAWbCKS/maJ4mIT76NDBjkbzFQweaEC
         d6nnDGaM9TDpBvOVZw8PMWZxSe+ERAPrADtYshwzIfiJ0E8QUke9ODtmhUrRrKEGxIs+
         3U5fGhlxWhT/b//fmgiw/K/2ZyG1Xz+zrDUMVKT/IHWMNy0skdarbJXJuZo6aRW0bRze
         pwDOdtGEuk3c0ElfXzo7kAatJ/A+/EQ6n6wtqnpHaEuhEmw77lRz/W0WG1xq4+FBIuxf
         ustvYvOUvK9sGdtjLz7SjJXaL5pQTDRqZVRwJlhNb4IV5tHtRHRCBfwB8/g237rDbzy+
         kRsg==
X-Forwarded-Encrypted: i=1; AFNElJ9c7GtJ/Gs+DDLXr5cKhAxelpQg0r3OTyAAYCmn6KxCAu8TG2RxfYtMnuf0FERjovjEX/VAX4gD1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbyCdNwvBnho2GNSXA6XcmcDBU+/+JaYEP1DJV3ocAy/qLkj3x
	tIcALDhyZ55aFy2SY56b6UiBy2VARW3BGCVqQ/hmoVNAH+EdmUzn9i0R7QYR/9zKoTri1sFbwPO
	8VfVaCi4LnJwYHbAh47ynTvcKVUB377GPFBtA8RzUKLZGmv7ZNwc753QYd7HOxg==
X-Gm-Gg: Acq92OFLa6QM3ckNpxmfmvv/3FxrTfCL9Slk8QhAHbLtixQ8x3BiPtbSMoRfWrcM2ft
	MrOUejT3R4bz41BiwIgbowW2u9uqLe+v6Va16dGKmVbwcnPaWId07rZQ/RrqYtrWyiVA8qCYcV/
	TVaoXttn+o5nTr8/xaT2rfVkw9doAuyHRTj1LYsI6HR56/XwabvJP0/oohAW20UIzertybdSjaY
	hfcl56ffxsjoc9z1AYDD7NqCPtqc6sCgzZQS2/GBxBcSimhyTNE4ISWGJM+sXEP3M+BcjPwPmI9
	fVw2C4prGwQrpOMNcGh57tJXo5wHagQHGezVv9q8yxQ44Q0r3XDOOzZHa7SgP4UdLnTQNufiCR3
	tBaQRZ5tvsOJmBiZ3KtYTF1g6D1d4DLC/o/NAyC5DVXsw
X-Received: by 2002:a17:903:46c5:b0:2b4:656b:aeb0 with SMTP id d9443c01a7336-2beb065e2bemr269819445ad.35.1779860239965;
        Tue, 26 May 2026 22:37:19 -0700 (PDT)
X-Received: by 2002:a17:903:46c5:b0:2b4:656b:aeb0 with SMTP id d9443c01a7336-2beb065e2bemr269818955ad.35.1779860239326;
        Tue, 26 May 2026 22:37:19 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb569592dsm136338585ad.16.2026.05.26.22.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 22:37:18 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Wed, 27 May 2026 05:37:09 +0000
Subject: [PATCH v2 1/3] dt-bindings: interconnect: qcom,x1e80100-rpmh: add
 clocks property to enable QoS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-x1e80100_qos-v2-1-305c6539e6d2@oss.qualcomm.com>
References: <20260527-x1e80100_qos-v2-0-305c6539e6d2@oss.qualcomm.com>
In-Reply-To: <20260527-x1e80100_qos-v2-0-305c6539e6d2@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=Zubd7d7G c=1 sm=1 tr=0 ts=6a168311 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=NnUtUk1SRsyLyR8-XE8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA1MSBTYWx0ZWRfX0CM4lKWNCRld
 ajKZ+M08m0AdFZrjapCLjid5BI3bRVEHXOzeFT+I5gTy/eYbPqfR3DMdNk75I+WtbSWa+4Zl0N1
 sN3BoChLP0Ce+TIS+mTFw01PDfvkFhnxWqwaTcLJidTEcpRWByK/5QCtMHVmhR+BjyChxF+zRFb
 oIz9MahYEHXxddVY87y+OMbWSzKzJE8kPEtrezo7Po7P1xPHD84zG6AgHYKwWCo70TWUmspRb67
 u9mUmDUGkWidv5LVjMLENfY9+rp7xfHsfgNcGHUzdi1CqspiOJZ/iO9ahaoZA0LYmhxDfLDryS0
 +X7z+ZucOwSwuzKGCLesHzus7lGtzcpeIdHE/pWaedfINFCxNisUsQLdjkELdXA7b8784Dp5nvz
 y130XKG0tV9Ak0nv6THk8q1nb/HmNsHC9gCX/qOcjQNbpuPjUorAll4VNIUT66izFXZxgn2RO8g
 /riZZTyBmq9ZFyj+maA==
X-Proofpoint-ORIG-GUID: yvjqffJ0mJXz_Cs5yys231SNUi2xiL9U
X-Proofpoint-GUID: yvjqffJ0mJXz_Cs5yys231SNUi2xiL9U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270051

Some interconnect nodes on X1E80100 have QoS registers located inside
a block whose interface is clock-gated. For those nodes, driver
must enable the corresponding clock(s) before accessing the
registers. Add the 'clocks' property so the driver can obtain
and enable the required clock(s).

Only interconnects that have clock-gated QoS register interface
use this property; it is not applicable to all interconnect nodes.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,x1e80100-rpmh.yaml  | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml
index 0840b0ec6e27..d863cddb21ac 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml
@@ -46,6 +46,10 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    minItems: 1
+    maxItems: 6
+
 required:
   - compatible
 
@@ -65,6 +69,73 @@ allOf:
       required:
         - reg
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,x1e80100-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,x1e80100-usb-north-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre USB2 PRIM AXI clock
+            - description: aggre USB3 MP AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,x1e80100-usb-south-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre USB3 PRIM AXI clock
+            - description: aggre USB3 SEC AXI clock
+            - description: aggre USB3 TERT AXI clock
+            - description: aggre USB4_0 AXI clock
+            - description: aggre USB4_1 AXI clock
+            - description: aggre USB4_2 AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,x1e80100-aggre2-noc
+              - qcom,x1e80100-clk-virt
+              - qcom,x1e80100-cnoc-cfg
+              - qcom,x1e80100-cnoc-main
+              - qcom,x1e80100-gem-noc
+              - qcom,x1e80100-lpass-ag-noc
+              - qcom,x1e80100-lpass-lpiaon-noc
+              - qcom,x1e80100-lpass-lpicx-noc
+              - qcom,x1e80100-mc-virt
+              - qcom,x1e80100-mmss-noc
+              - qcom,x1e80100-nsp-noc
+              - qcom,x1e80100-pcie-center-anoc
+              - qcom,x1e80100-pcie-north-anoc
+              - qcom,x1e80100-pcie-south-anoc
+              - qcom,x1e80100-system-noc
+              - qcom,x1e80100-usb-center-anoc
+    then:
+      properties:
+        clocks: false
+
 unevaluatedProperties: false
 
 examples:
@@ -80,4 +151,5 @@ examples:
       reg = <0x016e0000 0x14400>;
       #interconnect-cells = <2>;
       qcom,bcm-voters = <&apps_bcm_voter>;
+      clocks = <&gcc_aggre_ufs_phy_axi_clk>;
     };

-- 
2.43.0

