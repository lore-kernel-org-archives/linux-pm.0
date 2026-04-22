Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016C2E62A9
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 02:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776823536; cv=none; b=kPM8jOuICXOJ2gqWs6Wd8/Am1uZlzV/70aaEwWDUMGANxWofQrPnD4mWYeOYOcDWDJFdtK2WdNZnckL/zHjrNG/rU/gJKEDrgoIDgHFf+r6m4ncLClkpYcXrq9Ki0nGX0Zb3StDclqPGyIcQywA8pCCz9KiMvu4mztWv2ZyKhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776823536; c=relaxed/simple;
	bh=5C2q6Rggmfd/2JJwxgiGLwYgn7VmHYAaeGxytzjHEh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g1LjCRJTX2puC2D1+2qVWjC8ERGMnSZ/xZqLW9e1Xc71+imEdfEr9npnytQzalWCijflFd9V/6W4vTQVoEk4ep/zRwabmrt0s3q5Vnj8dtwlKK5Wzh0ZhMRscspK1SFPisJ0xkr1u9GRP2+Ol8LS2+DJ3ru05gwRxnLvFNvgBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UKnsvfRp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fs8HCIXD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UKnsvfRp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fs8HCIXD"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIZkFZ2000983
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 02:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	52+RqOz3orbefw3WyU1JbiSn5ln5+pi1k5H5bpefB5I=; b=UKnsvfRptJ0wRsXA
	9GT8UwFhMeZnQDyY84eEVMbM5x/a9QOqG2Ie0nq+bPjXadFokDsQ3LvbYSI1rSmq
	pp1ZyQAclm4jhD6nvzOdwcBH4uHvra+5py2dC5ikldPcU3/YDxLG0hfe9Rvm1bDp
	tQF8Um+tuxWIzrLMBnxaBIosZwT+G3iNLESWyP7qxmsaDNSsuCfwLj1AVm+iReVV
	d9kYA0AJSbMT1s+3mkd7XEnXBpIZYUrh+ercp0bLB6Dktrvi424vdzxs7ogDspM9
	lThCLzsRi6FwPcr8IK+bhT2QoZSkmcvaQNIrTn/XfG/KxJhrqiQAA5tZLWeCMv5x
	8ONLoQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenf97vj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 02:05:33 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f07078eaaso3793824b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 19:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776823533; x=1777428333; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52+RqOz3orbefw3WyU1JbiSn5ln5+pi1k5H5bpefB5I=;
        b=Fs8HCIXDJj/PHlGDKr4LUUKZp45DGalfKH5ZpXj4h8nthmykAcroBKbhLJXARedIAS
         BlxV3lmAqSGn1043EcC6fdgw9MA9+8gx9WFEZTXadDF/qpmibYPu193CRI19ZeLzsidR
         31AW85GiAVby0ZW2qGYOLFedxxL/KsYDNwwrP03+DIgvcUHyN9yn0kFh61AwVT09aMMi
         6f0ukFJCHIf5V3pOaE8ZluF0ENJ1Yl0UgbbI9xPo4BymyM5NRm7HYbAyh6YIpklolu72
         zf/SiinOlAyKqh+Bs0jy2l88eoNOQsWVdlQwXtOFtMURm45vFi+oAxzriCZ8HgQN8EMe
         iinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776823533; x=1777428333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=52+RqOz3orbefw3WyU1JbiSn5ln5+pi1k5H5bpefB5I=;
        b=d9krThrcugC7gGkQ0Iqdm2aO+LJgZgy8FQVFCpK/u2okCet5xkb4fzs2k2etbwmDcZ
         JbgzFOwexjieyuFDfttza12xM8XMBRe0coUo3+VpW3egV1tKuFxqvq+jIt3LfG7WGsoO
         I7/FBHB4hl737qLPRTmTaF36oomp/ICqE1Y6O3Y9oohXu8pBx5plFf19aq6esvL3IuaJ
         AHbs1hD2NyWqkJBU8yTMw749CNe1wh+wdJ7BjjXspQwJAgTTzBPZIoLMMqju92sgQLva
         2dm2fuFFDvnMBhBoQSYPBXagt2MTLQVJshxKWO5bV1ATcWF63tdiDdtRxD1B2u6g+AVb
         8A3A==
X-Forwarded-Encrypted: i=1; AFNElJ/ZQdsfq+TxnDujZRBySABxpl71i5wJtdMCg2GW+aEcSdxlRNn6sEtUa/Wz/fmZHIOOr56AKD1ktQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhL5EFifkm5Q4U79ECPJV5FuOOl++x5p1xs0I8tU7ALvnfWNE/
	wo2r6GNQsFArsq1+A0Tqaqg5xJEVTijeOGYtHm9fMp7JunAQhDb09Np03KwOIJxHZo/BlUIBU95
	8cySpKdmrblaDvubHvW0mBMW0KHHjwGLh5tqzzEcj2YfopRgL+/sd7PyLnpJ8aw==
X-Gm-Gg: AeBDietUAaa1706JGY9BPPJM/10IEybFzJEwtGfVYktELUZpqgMoGyJ7rhWC5gCzJsB
	PYlJva4qxKNbRswzCHVMzkKaBd71DYaX7e1+AbT5SveLLUrc7tH+LBFy5rjTb0qho4r2dC+tVSy
	0IoxVXYdeHoFpQV1mh8Eb+gxPLmFtGnH+mW59k/Zy3UHi4wscRE4SHd7w4gvpa2boNHnbF9gAU9
	pFyeKchyIemO/1d8byFec247UygXuUKBR4YSZYi261Dv2Umvf2yZv+l4fkLN9dNdbN3xu2IO5iU
	Qkryez7w16u1tDe7SXpnEx9VyuYNxbbu5hZTN1Dipoqh3YYLgwJf2A8oaHerLjDlFVEFF1WdYJ/
	JPW57rRqKY01U7JOutQpgTotV3Yfy2UUDYUHpn2CvLCj82YIlKhKmbrU=
X-Received: by 2002:a05:6a00:b60c:b0:82a:5d55:5807 with SMTP id d2e1a72fcca58-82f8c7cf160mr21181615b3a.6.1776823532716;
        Tue, 21 Apr 2026 19:05:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:b60c:b0:82a:5d55:5807 with SMTP id d2e1a72fcca58-82f8c7cf160mr21181578b3a.6.1776823532207;
        Tue, 21 Apr 2026 19:05:32 -0700 (PDT)
Received: from [169.254.0.2] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981be6sm18040368b3a.9.2026.04.21.19.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 19:05:31 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 02:05:11 +0000
Subject: [PATCH 1/3] dt-bindings: interconnect: qcom,x1e80100-rpmh: add
 clocks property to enable QoS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-x1e80100_qos-v1-1-bcc2afe4cc78@oss.qualcomm.com>
References: <20260422-x1e80100_qos-v1-0-bcc2afe4cc78@oss.qualcomm.com>
In-Reply-To: <20260422-x1e80100_qos-v1-0-bcc2afe4cc78@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: zvtyMTcrWZlLxTsKteznFrqgWzeBWJFm
X-Authority-Analysis: v=2.4 cv=fozsol4f c=1 sm=1 tr=0 ts=69e82ced cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=OrdcpLHLpR68xOABugYA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAxOSBTYWx0ZWRfX31B/H+G0VzXK
 PNcQu8QxOEh7hdZmqYhEVObLLk9XWLb7Gwwml69vqv6xM9pASb4R1jv2aIJPpwaqPHSUK8BBAif
 11F3jeeQoxkj0IgSJjdLp+fNplZ4UP7XOPi40VtSwQsHMQ/8mybaqDCModgK4IRgO5qO2vAGA/D
 AfRNa1TxImIaHhOfmgyFXV6rGlo33UwmwrgaAZNC8gGsIQ+HPU06YfTBtO5V5RNF/9hh0c+G1aq
 16BIbqt8rjlCscX7ku6UEwcm7tRKlan94Vck2H5nfp3ck5NPZTOzR2YMRxPyQEMZ1+CUg/wOntu
 83eyWstOm11STiCJC3g6KoQkO445QFniDfsJHHEZoVSdccJlHiAHtNp6yYNTa1ei/55InGVjZkO
 2MfSC6QC3cXvvp+Xc3ax/tq1C+OcmXRhplkDMOwTidmflwYGS+ZYVcVJ0vqSda5+HirBt/kxNKg
 nLGEZ4q9vgdh3jFLAkA==
X-Proofpoint-GUID: zvtyMTcrWZlLxTsKteznFrqgWzeBWJFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220019

Some interconnect nodes on X1E80100 have QoS registers located inside
a block whose interface is clock-gated. For those nodes, driver
must enable the corresponding clock(s) before accessing the
registers. Add the 'clocks' property so the driver can obtain
and enable the required clock(s).

Only interconnects that have clock-gated QoS register interface
use this property; it is not applicable to all interconnect nodes.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,x1e80100-rpmh.yaml  | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml
index 0840b0ec6e27..27d9234bc762 100644
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
 
@@ -65,6 +69,63 @@ allOf:
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
+              - qcom,x1e80100-aggre1-noc
+              - qcom,x1e80100-usb-north-anoc
+              - qcom,x1e80100-usb-south-anoc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
 unevaluatedProperties: false
 
 examples:
@@ -80,4 +141,5 @@ examples:
       reg = <0x016e0000 0x14400>;
       #interconnect-cells = <2>;
       qcom,bcm-voters = <&apps_bcm_voter>;
+      clocks = <&gcc_aggre_ufs_phy_axi_clk>;
     };

-- 
2.43.0

