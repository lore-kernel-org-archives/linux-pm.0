Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F103C3B2FCE
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081531; cv=none; b=sb0iWkyJdnddA2P06jDORhJdmDcFlxM6b5wdOoIVhW7NcXdP+ueUqfnaJVL0uLrRpEGx8kCtH3X7zRgLNbU/c0esZer5QvC4v43CTbD+ivvUoBJE7CgE2nNGgbJcRjnwkEydAU3pc8PJEWh+/F/wy7218a47Za7wyd5VIrVWWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081531; c=relaxed/simple;
	bh=bAPfzRfBHzCxb9s+4et3S1Cn+8StBrf+NqoLHGPL22w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SD0Yfivs443HWw3sdBACrztFVokJTF8allgkDTdAUiitZh6vBR5lgIXv+Kf0ehXkBDqBafPxTi//HXRBy1BYjhxr0Bmcd5z0wysA0mUf2Gd1ZG+ZZuTFoqq401sLU2a6Z3oya9GBO9+wnBhGtk9VLMN6BIkRaUP/mnmp9NYBI90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SzEek9sw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RJwYxMzW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SzEek9sw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RJwYxMzW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7ipHL997567
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r/YHsMyj/Joax26bhA1eUCPnKJSQ4Ljj+5px71Gw1Tk=; b=SzEek9swZ6J6/ECf
	bKW7lZmkdXIvg+fvKngL654mtW+IW6hRewwFFGe1BEfdD5UvcT1yxSJWD5SYImFO
	U1WDgy01dPEfig5PnVoC3ZwD2BE5dnjam0v5y71ssCYLciYmLgKyaKgTayxh/COF
	RjPs+C/RvueYvUBvj43UujPxevZdhtgjdnJ3aqUKbyl5iatOXlZCvNmI9ZzQRbrE
	pQ1i0j3XN8hoM0MzzFfjLnqmEXKdZRDEgjFalu+YPbAxMV3t50b3tWYM8f5pf/As
	WU5Cek7V/jBnLdcnX5s9TvRDNWCRK3X5IBCbohs+ViV72OkaWA19NDk3N/Pz66o1
	+BLruw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq10a8x01-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:52:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0a81c1738so38547485ad.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781081528; x=1781686328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/YHsMyj/Joax26bhA1eUCPnKJSQ4Ljj+5px71Gw1Tk=;
        b=RJwYxMzWbHeanPEgJyXPhIUm3qGHmS2mIVY1CeLtZ7UkJR1G4siBptg6POGIRbqajm
         gehatadznmy1DpG1GusmJqpYgc9/msKLpoORutKbqA4iS48qScUx3cfjAj+JSc2dLrqd
         v9mCd1MqsZLFer5xQEw7R8qLD+v7e/rnGrnkcT/uMOoSP+ybHXXwZeznsceUWSt+tQ79
         R+F2PiNU5Z6BEJIDTR3HbN20ZWoa/+Z3x0jr4gKtCHL5ddkkZEzTM6clVXotEC0N41eO
         IGPk9XAMvzxb6KyL4fCuqizofpep2KtBK1hWMiDeeBvK1KHF7mdJH7g//rvqVuA9s68I
         wnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781081528; x=1781686328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r/YHsMyj/Joax26bhA1eUCPnKJSQ4Ljj+5px71Gw1Tk=;
        b=gJhn3KR9r7MHtV/tFOG91xHs0l7GzBCBMF81GbbDq+m3un8jkNqFFdIRnfUEqZa9JN
         Ge+kBLDL5BHBHeDRHBF7x6QIhXvlyAWLu4xeKdNP8sxviJ2jQzfZFRHaycoWemDDNG9K
         gFLaKkBmiexFOxH4WqM66804ESQxkrVD/R6fsf7jXLtFloIuS+BX6qum9ZJv0F9Oj2YZ
         HqDp2jb2Ut5/cu4K6POJt37Rbp5cAh7nwn/f1S2ZW29WiW9/StvCZmSOs4yKO1EvoA4T
         LVUwcvimmrdb/3HTgDKYfrmoNnPD5tKkMIXxPgDywpdThlF/Mwgep3aQNi3+c78tomuc
         sQuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ccCgmHnE2qG56Y6QA7Rs9DV6m35YojTTaW2SYQKoS8QWet+8g/wXG3c2Ez2WrVP6pXXR06woL7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiwyrXN9jw3iR5Aja1E5EeQFWSN7XfKD54uY/i12CFO2HS97M5
	6SwsR4BUiCHGyelIGx4GaqRkeejw2wGreYdBEfa+rK7MGCZZ4Nz4f8ETLQJD4725wK0+JAyvmSl
	0HDHIaUpwpBicRVjgqVSzsDgDJJ5+d3I2QSgVcKo6QHf1Hjg4EUIrpQeQj9tZww==
X-Gm-Gg: Acq92OG5iD7WVV4xklRZ2oLncH9/rEd+/qXz2tXokV1id7NlC+sXfDYpinpQtdGzmJY
	w8mDyy5UlYit/46SyX/e0kSNOS1CzuPUlQKiNxNGW6XROxHCAVgv5g02KNQ5MxaSD2a1lKKkto0
	5bCWx+hVY9lozcV6dTbpaHbL7E2DXm/IY1GNeGtLXHxi/J0SJuZflqpm/yhDBgul3ecOCkvcSYm
	MR7ysRhxEcEityHlG1k4b7B+Q5UCzfycy/yk2UP+UB3oPQbXiwWkrYdjJuq5QM7388k5AYBdavc
	VqiqJe7SNEKVywaiWDkZVkjNxYqOh+JQ/GtP9XHqKknQukc66S3tjEHiJ9ByPw91IGR2NIoVV05
	T2g/w19ESyNrZY/qacGZzmZSwPeAd5mb+AY/VNtVu7by2oEvfL/YS3VNW/OC6cqWopGYsxnRCZR
	2jlK69cYicDSc74i00AquVODABfgOWap1q97lE7GThST1d8yXp+8E0n79xE5o=
X-Received: by 2002:a17:903:2b0f:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2c1e79f68c3mr292217915ad.9.1781081527638;
        Wed, 10 Jun 2026 01:52:07 -0700 (PDT)
X-Received: by 2002:a17:903:2b0f:b0:2bf:7b62:a038 with SMTP id d9443c01a7336-2c1e79f68c3mr292217545ad.9.1781081527194;
        Wed, 10 Jun 2026 01:52:07 -0700 (PDT)
Received: from hu-ppapaniy-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c24edc8acasm114618175ad.45.2026.06.10.01.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:52:06 -0700 (PDT)
From: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 14:21:29 +0530
Subject: [PATCH RFC v7 2/9] dt-bindings: firmware: arm,scmi: Add Qualcomm
 Generic Extension Protocol
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-rfc_v7_scmi_memlat-v7-2-f3f68c608f25@oss.qualcomm.com>
References: <20260610-rfc_v7_scmi_memlat-v7-0-f3f68c608f25@oss.qualcomm.com>
In-Reply-To: <20260610-rfc_v7_scmi_memlat-v7-0-f3f68c608f25@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781081505; l=2124;
 i=pragnesh.papaniya@oss.qualcomm.com; s=20260120; h=from:subject:message-id;
 bh=bAPfzRfBHzCxb9s+4et3S1Cn+8StBrf+NqoLHGPL22w=;
 b=3IHb8xgfodeZAAvSCSF4qHqkSYryDWxcbJLlvj9a0b0v5bs3O9BHpGV7cJ0/YiWVycOereh7W
 bssXFnSFdxCBPUYH+4pHumxvGDs/0WVyTQFrYVc92HPIzicZlQHM4pP
X-Developer-Key: i=pragnesh.papaniya@oss.qualcomm.com; a=ed25519;
 pk=09P9nFmZLXJ9+4Jx10ZK5rIW0Fmk79A/DLErm6aVA0c=
X-Authority-Analysis: v=2.4 cv=GoFyPE1C c=1 sm=1 tr=0 ts=6a2925b9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=4P7DloUKvxegLOL1_H0A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: w1S8uvkYx449WYw2gCghUgm7nlpMx1fc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4MyBTYWx0ZWRfX+gvBZCEpzXW+
 1gTni0Iqc5NJgOYHWAvchkSeW8ucuzZcakABmagKZzpcqDN+qAbbOiUxDAbvpVmgiDz4K3DX1v3
 h4tVPsObXUhRbZMF7zO3sqA0gkrdtDTFkhkknZEYlxoTwMw0QtDMzhykgNVCXGBo1dPlV7RJIvv
 FI5vOU+tmh+CRk1RkvSmuQSqMHZAN/Q9cxNOiIv6GmIVcbZXzR0gjIY2XXJtCnbTC/CScIo7hnT
 RnZyMq0n9b2oI1Ui7F9X4Wne3jvWQqC+g1P/pu39EMVPvkfZrMVundWzglcp7HaeH72fbczxMO/
 xx5euvvz6bLZ4SjQXInikyTkVp5vSkRzQU7N6+3//5hFPoyXpO6xFHwjrrSr7A30yw53Sux+UxD
 fu1ME9yxGNkDxyk4VNYurw1BAFHQVa8EsAErkjKH0130nET73NJsAUl4QU60Y+uLdSFN80d5IK6
 f5TgUOCQLXrDwloy2QA==
X-Proofpoint-GUID: w1S8uvkYx449WYw2gCghUgm7nlpMx1fc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100083

Add the binding schema for the Qualcomm SCMI Generic Extension Protocol
which helps support Bus DVFS on Glymur/Mahua/Hamoa/Purwa SoCs.

Signed-off-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml     |  1 +
 .../bindings/firmware/qcom,generic-scmi.yaml       | 27 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index d06cca9273c4..aedc57dd3b38 100644
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
index 000000000000..077653dc1cda
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/qcom,generic-scmi.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/qcom,generic-scmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm System Control and Management Interface(SCMI) Vendor Protocols Extension
+
+maintainers:
+  - Sibi Sankar <sibi.sankar@oss.qualcomm.com>
+  - Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
+
+properties:
+  protocol@80:
+    description:
+      SCMI Qualcomm Generic Vendor Protocol which exposes a number of
+      Qualcomm SoC specific features (such as memory bus scaling) through
+      a mixture of pre-determined algorithm strings and param_id pairs
+      hosted on the SCMI controller.
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

