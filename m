Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BF52147F9
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774228650; cv=none; b=Ywq4OHSxcFP0vQYc8SyvoFbON1m6QK0dcl836B/By9SFnglhJd4O39BhYBUST/DuwwMPmNrDTSMdHQ9cGme1rSWWo4VkS3Dtn3igyNi47Wx30ySfgyTktE+AZDVzNHSBaSIvIYZ3rDSYF6cmKxiIh4Io0aaCVfhzKa0IrSPhpwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774228650; c=relaxed/simple;
	bh=ve60Hat4fjDGd6a0MMY2a+1ZxOsOvrbkOAK4ZWhT+wM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DBYuyqGi5+vs2g7MMKKeYQ34F6AwMAUdyndBK4gCAFUbjif9KaCxJ4SyhdV3mk1fcgZXCIgb2lm3b78gCuBMAYxWFbtZTq34Kj5zFZEp2W1w0k81uE7NVosTLhaoIfozGPVavTSYMcohr/bk1Q5p/GQtnEyvdfimrYw9VF4FFRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F6CYOZCL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cFSJvcjn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F6CYOZCL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cFSJvcjn"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ML1pf5900480
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CsLnVUkiBBNLZ7fR/kaHQdxLUTQ7WZot6+FHpylt1ow=; b=F6CYOZCLv0pLDWtx
	XTI+ZEEIDyqveP9oLmGoSXcAx5pZm1AcAf61skGhoG9Sd0NFiyWUkPge/DsKuu9c
	3I3GWJRNRI5jf2S4I6LVVUgssBDyWs2mQxvC+QD8IL1nfnv3oNLpkRGNqzztuQDO
	w8xM99YPZ28Y63KzcVOLPCdkkbWIH/TCS9+glJcBOJX8yE9hP4gA8QNTJQuNS4SZ
	2QFkUPw4QTKOoVPbGYT4iMZPDNXcghuw2O7Xrb7CMIilj96LSUURGq5m5tAPKucB
	ALOQX/CaoZwcmToG3Tv9eToqXgKxxmecBaKVThWErSuxtdAicmsPHjDFfV2zWBys
	TpTaRg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1j9rb9tx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b44f7b7bbso171126671cf.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 18:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774228647; x=1774833447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CsLnVUkiBBNLZ7fR/kaHQdxLUTQ7WZot6+FHpylt1ow=;
        b=cFSJvcjnY58N86jUXuCsZjCq+MsFIM9u0gjUn8NJwrhN4TeXSoC9+KlpzljE6pBR+h
         IIBx4L9+lzT5MsVUtO09jAGHrgis3W0RIyjfJiarRhQIeLR0sJyUskcIbpGGH5jL+fCp
         ixYefTnFLE1YpBnJjZoJ1WJg9Ch9Xw2oNWJ+W98Xpb8FnCpUsKKpZWiXk9sID6O7SssE
         pLywrZ1ZpR7UkieGZu0XYpnrZBl4GR1FB+1THAGYESNtawlCN1MtVZYQc0rrxzMac1j9
         2q1w9e+WF8CntMBIbFtSvsFTKvJKB23ZvE0sKnADtSPR/2SAeiM0AsOaJugCi1oXXVTY
         Z0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774228647; x=1774833447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CsLnVUkiBBNLZ7fR/kaHQdxLUTQ7WZot6+FHpylt1ow=;
        b=EcLjrY8wM1fPuzYfeU/Ir5q+7HdhzKTH2NJiBrhL0Mwfhsa2Tm437hXducgdaGCYwu
         YwdcD10xGtrk8Yy9skZ0WBO/QGkFrG+Pd6g/u+gd3XaQqWJfGnJzrxhg/i0Q6+zkqpjp
         pa7V++atdTHsYsnQQdjAmb7xc7YfmIy0VoxHAJGCfa7oYNcw3K7VziKgAOXiWeLeE5a/
         Iokes6WSnSjR59K7sGNbij98MPUW8wYU/XjNNRucz1KFdFH7mDmTmY9wxfLFwBKMuIqS
         7z7UOQjFZKSjTlCocKdguvZrSawCyg/GjWE0NCtrWUEyF3DuZL7gOiXWHeiAcQEvyAcB
         Xqjg==
X-Forwarded-Encrypted: i=1; AJvYcCXGVLvzZerMSpfZjC9+8mbe9EeksYiR5U3nw/6+q/naXvCqSzzow86YHJ7xo0urv2d6xw0IOxtrlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYtsSTNdQb+XGfMJ1qFPH/Ccwlyt62ncEltsf4vxgRaTAu06Xe
	JGL0wW4vsCpwM1/ugLkDEI0qeCBp/Z4oSfd3Nd1DyMarKBaADWWN5ZlaGOtVm4l8O1NJK2XYPWM
	nkOq6rNhbzDxX3FiRunwJRxRAJnBMmO11gazPIxSbfnEb7ZyNSn6fPKPT+NR1rQ==
X-Gm-Gg: ATEYQzymhoLXxWuW2VsnCrFyQxDw9cTotjsqSQCBuOLBvhyRXJXTFNnUV8g46ooVb58
	eaxmiPsbi8pQo6zBwLCrFVZRSZpQqzrpcAaK0dfk9poCXAjDVzxKIquc+5PssV5Dm3ywfrSwZzH
	ttz1BEqgIBQjZNp7bnc5MRxXu2OE9ZpoWkPYq10YN0nAnSOb/MaLDmN9DBbeTR40g8rLfRordK/
	J0Wa4Uyzm+xiHeGlGm9bfnYbmY7tsXGgDlcbhw9OfEMRUM+U6hgxbL9twfpt2iEi4gPcEfD3NSH
	y63RhBz09hy0AXIoY/sIhPPgWXsi5/r0JQF3YT3b0moim/AEQOxuuflBF3i5cXjFcoDnJvgBZX8
	g1/HCqx/9+KSz9t/gk/tO0G7GJfK+5OPOAIqdpI+wb8qlOpys5MMayTm6SttVjHsrsmMbukEpbK
	dP58jKElx1+23rxivfh7oZJZdgc6EY/5riHDw=
X-Received: by 2002:a05:622a:8c:b0:50b:3831:417f with SMTP id d75a77b69052e-50b3831446cmr155920641cf.45.1774228647273;
        Sun, 22 Mar 2026 18:17:27 -0700 (PDT)
X-Received: by 2002:a05:622a:8c:b0:50b:3831:417f with SMTP id d75a77b69052e-50b3831446cmr155920261cf.45.1774228646653;
        Sun, 22 Mar 2026 18:17:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2853050e7sm2216150e87.61.2026.03.22.18.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:17:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 03:17:17 +0200
Subject: [PATCH 1/9] dt-bindings: interconnect: qcom,msm8974: drop bus
 clocks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-msm8974-icc-v1-1-7892b8d5f2ea@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ve60Hat4fjDGd6a0MMY2a+1ZxOsOvrbkOAK4ZWhT+wM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpwJSe3RQdQJFeHh2xXQt4k+38SLjcj2g9+v+Nc
 s9xarp4oQqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacCUngAKCRCLPIo+Aiko
 1TuBB/9xmgcOyCA7bpzuVj8O8Z0KrnHaDq0TyTJ6Bv6KFU+xUce704YUp5HWPkbolR4kyocq6t2
 c6Vn96ja8bJN1L+uS5g1Z3VxA1BTh6o4QkYu9SVsCMMieVOp82xsIu3QJtyvo9rB35eVdJbe28N
 UKf4HIOA6y1XrLi0/EQkJmRS94HEgRx8CgT00wnYEcFDnYyhwv/cOzDqAr7TkTJIDx+oTwer0Ad
 Pw1C2ncE0GzrocHxvmckHAZmyA4RA/l8kLNult6q6uwY6EbYTZ0AII/sCL7zZKVrrG7T6URI1a1
 zWtx37rlS3/gvihjkFrJ92N645FTALb+DBK1xH31qmQPYYaj
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: o_hN-sy5lE5kPZer73M9J1ql5gaon-H-
X-Authority-Analysis: v=2.4 cv=ZPDaWH7b c=1 sm=1 tr=0 ts=69c094a8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=xO2zaiYFPJaqVjnw6b0A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAwOCBTYWx0ZWRfXwn/kr4TXYXne
 ocAXROGdzf8YKbojWx9eNzTo79m5o6cF0+Or27WXm2nv/kbsjmS2eVjyMyrn0njK9n0aq2uc9pB
 ALkHgYnrPbGsFWHtpCohP3Lz7j+M33jJfak0hQ9XERni5O7asnkczXnISKswjXD39AuVAtteC3o
 wgze5PVsuGwIV2B5e0ECDBidCqQBfNegTChiLAqDZYd1601EHOFsOIMn0gP2EZF4X/Bxm9/DQu8
 GGe4Dc9scUvpJ9cxjbhO3Dc8Yj4U4iVrY4z5t+ZIuaNvvSFZ30oW/ubo5M28nFk7z8or4F6htcD
 E7m5Dxte+NLRE48xnnUmN9aO3b5UPLeznduY4n6+y/EDxbjk1Z6vbW4X7hLcxj0v6vWgZ5Mii1F
 UnlJkz6jN8ixxFX63i+I/pr/jAmufW2JkTIkIdAfSJUFu49TxCz8ldgeLGIHCj5W4VZSF6Neakm
 clXCZw3ukq8UVpSIFcw==
X-Proofpoint-GUID: o_hN-sy5lE5kPZer73M9J1ql5gaon-H-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_07,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230008

Remove the wrong internal RPM bus clock representation that we've been
carrying for years. They are an internal part of the interconnect
fabric. They are not exported by any device and are not supposed to be
used.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,msm8974.yaml         | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
index 95ce25ce1f7d..89a694501d8c 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
@@ -32,22 +32,32 @@ properties:
   clock-names:
     items:
       - const: bus
-      - const: bus_a
 
   clocks:
     items:
       - description: Bus Clock
-      - description: Bus A Clock
 
 required:
   - compatible
   - reg
   - '#interconnect-cells'
-  - clock-names
-  - clocks
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: qcom,msm8974-mmssnoc
+    then:
+      required:
+        - clocks
+        - clock-names
+    else:
+      properties:
+        clocks: false
+        clock-names: false
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmcc.h>
@@ -56,7 +66,4 @@ examples:
         reg = <0xfc380000 0x6a000>;
         compatible = "qcom,msm8974-bimc";
         #interconnect-cells = <1>;
-        clock-names = "bus", "bus_a";
-        clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
-                 <&rpmcc RPM_SMD_BIMC_A_CLK>;
     };

-- 
2.47.3

