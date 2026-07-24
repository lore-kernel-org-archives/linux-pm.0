Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB937F33E
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784877546; cv=none; b=Suv5p/tf8xKaGp4nDq7+Q+y9ucsQu0Y+pn7fdFhyjz20gL/XUowh4/hAyRma7L+IsjVfM8wOdk+zqgpRJ8b5TqUrDp9ilYj3TgYCjsYpiRdM9G0HvMUj3t/RK4ger+Z8L4zeIofRtVW0pfwSFOJE+DYhWoF9cDj7Pw7cJVStZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784877546; c=relaxed/simple;
	bh=8kOkUq8/QNbkFlOXibGos7tK4ImImcoivey6N7UaC1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NWZPzxZnmxktK1rGDgC+3pNLan9En7Fibkueyr0z2Q/6rqvukaVbM6INAxIWbJ+8GLili5lQSPHdHr3uNI2rWfRMdtvo7plYiz6KKxthwWR5OH6t2BCh4IBUagGnpuR4X3zGK1LukaSMtNZIW6t7XAO7t3SECsT5a74+M/MdKEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h+Inf2Zj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i6fnvnla; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h+Inf2Zj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i6fnvnla"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4lHfa1869015
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6KcTwhi8obGfuKLj8dNnCltx59+O49u6DXb3AWbAy+A=; b=h+Inf2ZjQWvrPiCE
	chmr1Np/f/lNLp1yYpWVdXgR4z/nUUVP5nnCdeUQSbDL3mktBPdXXj1jT8WeIiBN
	0jtg8btiWVXuEDbR+ezRdxqkg1FukelNmq7P0Gk13LRcG6+yxu8vyU5A0k6AX3a+
	k3JTuTSD+WJDKKCm+vbvBy0pUY2S6z9Ml3jHttP+xlWZIlq/91mB7Qa6wRApDgYs
	95xOFBCHTPL4+8A/q5ZP3PumYh4nncV2oUaG+9FOdIOP20tITKC2yTZ3sCcKiYvc
	ZwR0NlqjFTquiaQtV61tAG1S6zHeL9JlsRvi4ua9uKhs1Rs3+/xaF08340ZpEByX
	yLNWoA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0pw8mqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so238466a91.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 00:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784877542; x=1785482342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6KcTwhi8obGfuKLj8dNnCltx59+O49u6DXb3AWbAy+A=;
        b=i6fnvnlatmgFtol57dqBBP0VTG8+wHc6CKyNo6DLANvPgFMt7Yt9jb+wC1BKWKIVJN
         bvCPXg3bTc+7fCZYGHjM/HvIBxBTYRjz41Ovn4BR37iFx7P/rNfTmN95cju2GuIrgg5D
         VQjDnk6cz8Xx5ZRqRtPJdtzXapvg4w22xlJhSVV0+nBWKYi80Gb4nk2Ze5/LLWXk0MR6
         lymcQ70+5URYGuc/C0JD4IkiQpxaEWzEy1oSqT5b2G6pJToUJiE8f6AHgX2xh3ULa6cL
         0g3QApzo+6HJT+mRpVjlgHzlrZnWUyqA7bOD4RM/+QedOKgGqJ7ECVlgUzLmBY5WVb/C
         +hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784877542; x=1785482342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6KcTwhi8obGfuKLj8dNnCltx59+O49u6DXb3AWbAy+A=;
        b=J/L9G9o3ATDxN7i0seSM7tSGGdBzRx9AOIwj5Y3QfOvfoj2oi8iIbLt3iQzHX6OPht
         RHOsJ3LOADeMd3NJAwBFXpVSXmadOmflx0W7j4zPH3nY1yxaswYOsRpWDov6e03VDj8Y
         tu8RiwMvVz1zu4q+xAaZx88fHXpjFZdAd6QyF2DUmOIBnH89Q6v+afJhhk4kGELQ2Jrk
         xlnkZ+YngT7mvHN991qtdRaQKh59OTvZ5XxiwPfslkCDlqRXLnZpybmjg/d1dZhCp3Zy
         +H0fBTNOl3RKMouvftDwLFNEmTyJ9M5rySGngFJkWNDu40LDu9RMsIyT9AZMXIRcsYGr
         AthA==
X-Forwarded-Encrypted: i=1; AHgh+RpXzIyoI5VF2lnxcl8W1Gsx8FIhcNvqmezyaKwaxwrw+zAGoCkDKG0mKjiCF8/PS/LZPE/46ePV7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+O/wul/ZztS1JT6i5PN7AC0JpwXtdHB7BXv4ynkEostQlfVt
	AbbZ+SjCE66ba/UEgE0SLAOttXejAgnUiuKK3SmfZoSeXR1MgZ48R20kbVkRP4QEIosyH0VbMCG
	ZiBC0d889ffWAQoeRR0S0OLj+tpo2uPnrnkYtW1wJitSGkrPNM8w5B2yN8QodDQ==
X-Gm-Gg: AR+sD10BHM3LYAyKzvTijc/OELBX8IhVVEHh62TRiQnw09Q1581HUTNEGOvVyqn1b2A
	UhyxPvZox9xQwAfrbEnfYfF0OGBCrADEC3W9ivHSDza5ApaPFSrRgnW2JerpWs83AA62UjcHMpV
	eiFCpdidkrLN01zMrilMKivN7ZgpE7+t5k/Tz49dLUuX01pEg1EuzgwLdO590rl4OuIVPOc81Uf
	jy3iyT533cSrDzxaEzsyKGGUKc+hBY4Th61HxnNre8fTi779Ez/zajj4OSeCCyUyI8mAoD+wyS6
	rIevD+/+mbHYmIzXLelc0AvRD4a4/Auxkl96h/KnFMfgoeeZAkohk2HSvp/ApGDCevx7PpO8mSN
	huLTYBQAe+GIFgTU9w1k2css8afAubTSpy755xtvVrsiwh+7/u8UwnZYdJYJyXSz+wkqJbgxkF5
	SJqU4oeNusIG46de6RfJxlQcL+us8=
X-Received: by 2002:a17:90b:4b08:b0:37f:db06:229c with SMTP id 98e67ed59e1d1-38ec65fc538mr6150330a91.22.1784877541267;
        Fri, 24 Jul 2026 00:19:01 -0700 (PDT)
X-Received: by 2002:a17:90b:4b08:b0:37f:db06:229c with SMTP id 98e67ed59e1d1-38ec65fc538mr6150131a91.22.1784877536051;
        Fri, 24 Jul 2026 00:18:56 -0700 (PDT)
Received: from hu-ppapaniy-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efe3afbsm45993805ad.33.2026.07.24.00.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 00:18:55 -0700 (PDT)
From: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 12:48:07 +0530
Subject: [PATCH RFC 02/10] dt-bindings: firmware: arm,scmi: Add Qualcomm
 Generic Extension Protocol
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-rfc_v8_scmi_memlat-v1-2-cb732bcff1f4@oss.qualcomm.com>
References: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
In-Reply-To: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>,
        Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784877514; l=2320;
 i=pragnesh.papaniya@oss.qualcomm.com; s=20260120; h=from:subject:message-id;
 bh=8kOkUq8/QNbkFlOXibGos7tK4ImImcoivey6N7UaC1A=;
 b=kcWWRSTmgHpghdRGCm+tzYMnocOcNLzdIw5A4hcEd3F4SOsgeVTWlBHbs9nPYviDl1lcqVDJl
 XTULEl0Z8EYANL6bYs9r63RpnC+qwCYRqzora1Gjcn8/0ESEKueC6PU
X-Developer-Key: i=pragnesh.papaniya@oss.qualcomm.com; a=ed25519;
 pk=09P9nFmZLXJ9+4Jx10ZK5rIW0Fmk79A/DLErm6aVA0c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2NSBTYWx0ZWRfXzsTh4S2oSw3a
 MPjUhJl52yt3ZojTsAJ9wQ62AHYBIzEoc8jhMiU9bNuh3g6BWVXdK2bb6N3YGNOqm0SpMw1BEuS
 RioBjzbO+fXD8LJovE08i0QXYqi3ruSo8E4VW62sDvM4Zm4MZBubKJJoR80E/JoxziThYPbijdB
 l9qsRe1GH63swwhPXU+ux7KY+VdErG6isJ0ZiQaUCUi5aR47vcPmlLKpdxnw9w9NQINk/duP8Ry
 nkn42/UKaBvRJbTiiU9FKVWFsvobKIhNF3iLZ7JoltqanY+NQp7B0ziOkJAjLu9wTKT/oD4jNyn
 fCbgH24G3wQQY5L5hBt/r6WJi84W8TolaXDo6w0j0zGqobVRtQ9ssHivX8tLhFfsRXnC7WEJSOh
 HN99aAuqh97NVy2XAxtzYWhds0/ClLqDMC6OZqF3RQluWYJfTW2ifghrr+qv3BqYDe8SURLPW68
 Ot4cst1p52n6vNuwa+w==
X-Authority-Analysis: v=2.4 cv=RJeD2Yi+ c=1 sm=1 tr=0 ts=6a6311e7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=dmqMg6edKZ0wKbcdjZwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: sw3ub-a4yOwUWRcThhiwVndjCuXvZW1c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2NSBTYWx0ZWRfX6Jq7N51OcB73
 i/azPCFPvvCorVP5IWhcap9b3pUZ0n4YAjzc+yQWb2hUZDbAIANNWuYp38BUN6ZMLkupHJuLhig
 6NHtrS0Bwn3CO6QMiESYE0y2S9FK9sc=
X-Proofpoint-GUID: sw3ub-a4yOwUWRcThhiwVndjCuXvZW1c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240065

Add the binding schema for the SCMI Qualcomm Generic Extension Protocol
which helps support Bus DVFS on Glymur/Mahua/Hamoa/Purwa/Kaanapali SoCs.

Co-developed-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml     |  1 +
 .../bindings/firmware/qcom,generic-scmi.yaml       | 27 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 6fc44105f1c3..85f06a6a7452 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -24,6 +24,7 @@ description: |
 
 anyOf:
   - $ref: /schemas/firmware/nxp,imx95-scmi.yaml
+  - $ref: /schemas/firmware/qcom,generic-scmi.yaml
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/firmware/qcom,generic-scmi.yaml b/Documentation/devicetree/bindings/firmware/qcom,generic-scmi.yaml
new file mode 100644
index 000000000000..a50e5e8fdccc
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/qcom,generic-scmi.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/qcom,generic-scmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: System Control and Management Interface (SCMI) Qualcomm Generic Extension Protocol
+
+maintainers:
+  - Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
+  - Sibi Sankar <sibi.sankar@oss.qualcomm.com>
+
+properties:
+  protocol@80:
+    description:
+      SCMI Qualcomm Generic Extension Protocol exposes Qualcomm SoC specific
+      algorithms such as Memory Latency (MEMLAT) bound DDR/LLCC/DDR-QOS bus DVFS.
+      The algorithm runs on the SCP, it can be turned on/off and be configured
+      through a pairing of algorithm strings with an immutable list param_ids.
+    $ref: '/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node'
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x80
+
+additionalProperties: true

-- 
2.34.1

