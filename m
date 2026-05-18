Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB009481FC2
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112209; cv=none; b=K18RL28QStNrMmmS5UeXTQFY8m3WFbq8+1ehbm33eQTw1EP8P+yEXC67bdrzEv+RwWh7JnEdmbCDML2NVkHEycbcfoqPlP/IAIo/N0GsR00XtTnevnJMX+oKXLkwc30c8mS2s5pQQXeYUaIZpsiWekpaf9C67vZucpiic+4VRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112209; c=relaxed/simple;
	bh=fpyfAuxqXVVXVUx6y23m8FTqtbLsqhHyF/u3USHTtCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hPblKSLFqWBuADVn+ny3xj5P+f7gcwnumRZIQF8fEIsJpwdb9ySlyI1QfuOt+jdf0uIusYFhv9wtZZQeIv4F+CldQqJ/wX2N/Ab908/lzRyDuWVZTyBTN0nrJ/1cfMhYPWHpbci+s4pntO2Zfzgp3ufFLUs7Rg70Swo/ou6cNmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bTpu+gJa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FWGC5Ghs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bTpu+gJa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FWGC5Ghs"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IBHSYk2482404
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 13:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lDqU1NSm48bX3qmgDYOZxIl1cMDyhT8rkY31oVrqSN8=; b=bTpu+gJafC/Md5Ay
	gqy4VZDNHJAD9K2NARbW4QAZ7U3yD1+hrSe8Vvqp/eczGsBKBP6FnzJUcXlEL+HC
	qzqAIl+QfXH1XFQB32V1XIHNIvY5+5qxI8VpnyefOR+Udzm3iWVQpwkWvEEG4pZn
	EeknNQLNNuKF8sKiSuimQPVdDpx+TR8s0gQClSBQKPLeBGENZzcdXisQXV5W1J3J
	CHf61FRZjzTY5DCu3QjQvhvjjMJo32DEsuSTEor5bfg9c3p+8Epv9nkWKQEnPVpX
	jHG6OKFSOutBD7NQdpwBIzkRgF5Z4vVo5zlQgJbj6MquoWmHIdovValZ3utEaA3r
	gbr5Pw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81rvghx2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 13:50:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bd6aeb3637so60651415ad.2
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779112206; x=1779717006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDqU1NSm48bX3qmgDYOZxIl1cMDyhT8rkY31oVrqSN8=;
        b=FWGC5GhsulFS/D8MYOuVaobmMNIZai8OsC9p9E9424WX3cKVzo9fUR6zbye9NxhJpf
         Uh+/fYUpKhejrznoSEe1cBgdFYQwic3tCdz8j/ID9hAYO+dP53SeCaskcOLL7SyLVEmr
         Wsn+2019cv6jJm9nYlLw6jCZMV95f0QaqaXVIx8of8crg0ahNhoprQagI2qCAtmezFoo
         q2vBtlL+4K2nBoY6NumiAhePHLWEiCH7UScZvuRT19eL1se054YBVRLgRCSGPIlJv673
         JYkc/nXisWTeTzaF+Q68JUOjgtMAWtiUkXiHUeIISSoYH4OOsXj7sfi/TevA+8n/R/8l
         8SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112206; x=1779717006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lDqU1NSm48bX3qmgDYOZxIl1cMDyhT8rkY31oVrqSN8=;
        b=ibUDIS3avxx48+2fZVnCn2f0MRae7OQuI17cQ3MqvdDlgX0odZBQ/9QsbrWpSQmJTm
         NhmsXSrttxtEi+EVFiZBRf17hk0Df714hN1iTVLQjJEAF7/m25zLr7Z8JMF8b4Dhb2Cf
         nmzSPlMeXJjHURT9Y7R4tsu0TC3+WZ30Hvkap0cb+qcDAPSohGZ2u5rgfvIHp5iEHaX9
         dkNpSFRpogngEfmKPB5XhSTizNHeKl0YCDGRwcHdyCOIHamMwScAGHvUFEL7ClGRfUJ1
         J4r8yQX2t4gCJ1CuEdamuHc/pzIb0zGOnLYHY/d/nULt+Aa4RrhFZm1KY7dNXs6IC41I
         CXng==
X-Forwarded-Encrypted: i=1; AFNElJ82GLMmGvmjjRCO+QveDyn0LxvJnnNQK30XeI2nqpBfZFOeYR41FP2jNqMawVgnuYNO3O/5MJYn8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN9jqmIUfefbE3+/6uhP8d96HUXrVUU+utcUZfYXQ9cHmPJse6
	EOQoeLunsiSPR9vES5xRfu+xxYwuQtyUE+P68DnniE5BKzud01G31QvlayqvQIZSITtQ4LpStnk
	4e+QdxVZI/afoABK7YHFmeYcpDahKkVc0FWC0Pkxl8CpJzIzln/CqEdLJ4agD
X-Gm-Gg: Acq92OE5uBPSzhSAzA5BfnU6gAbaUgWGwpBnRXr5TOLOlcXS/1+IIp3iBpknCvqGeSp
	BDz8kqvws134KsYPmd9ZQlzL9nvdlCI2A3deHclX2nysTkUszPuVjCWIIdGggvmRg0+3dhi0XnH
	78DHrE5nfOHT01W4jwOgYc/2d0zNuYfimrShPs/IiZ6iV5WJ2C/cVci5CBjFtslmRAbLwslZedi
	J53MqZAMnXm/GoQRDpqUDbKjtNnNyoKy53luzeu56RbozMpp5S8azV7/dZ45h0o3dpz3rdji2nX
	dOWgwFsb4i9NDPV1RINIBa96VAqrVXRvNyRqRBhvqqZ4wPAAHRLGc0v7evlj3i4zpdGml5iNCZM
	MtjDhkSUJfRiYRa+iqdCGefzaQ3uwJjF3r/r8g3I6xvQGddTHizQ=
X-Received: by 2002:a17:903:1b65:b0:2b9:8d39:5e87 with SMTP id d9443c01a7336-2bd7e7bdd94mr167994685ad.10.1779112205576;
        Mon, 18 May 2026 06:50:05 -0700 (PDT)
X-Received: by 2002:a17:903:1b65:b0:2b9:8d39:5e87 with SMTP id d9443c01a7336-2bd7e7bdd94mr167994375ad.10.1779112205060;
        Mon, 18 May 2026 06:50:05 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f36fsm185411275ad.21.2026.05.18.06.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:50:04 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Mon, 18 May 2026 19:19:39 +0530
Subject: [PATCH 1/2] dt-bindings: soc: qcom: pmic-glink: Document
 batteryless property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-add_dc_in_support-v1-1-31fbaa329879@oss.qualcomm.com>
References: <20260518-add_dc_in_support-v1-0-31fbaa329879@oss.qualcomm.com>
In-Reply-To: <20260518-add_dc_in_support-v1-0-31fbaa329879@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779112197; l=1556;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=fpyfAuxqXVVXVUx6y23m8FTqtbLsqhHyF/u3USHTtCs=;
 b=a433+0G5gAjzs/fjzv/ee4VIv5e8wLfIG3YETXZBCngvo7LDy2S4jbgYYUlm3abtaqzLO5dW8
 YvLxWXvlnJDDuc5sMFwGzndvlROvj73H3Wxb92lYhYXgVPQWSBLTUwn
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNCBTYWx0ZWRfX+2VAzC9+iHWT
 3fPaix9S4dIsp6AH0BIFOIWb6b8zgwzLr3oZ/b8jKNEwpXZoZPxKGK2ziiU/XZ5/4qYP1r1VKg9
 H3uBIZ1fX3ZZfu3XlW7zkh1XlATYPt7k7ozmxBqxlUvFAdryGYFPChx9sEGy64XLN58twKpuBuL
 NjnFj4Ew8i2lykDsDMHivRmP2ZZVawrQ8QgSgCA+y36GETgFHn6+120T6ZRoLJEGX2Zw6blrt1H
 YI8l+sk9pGGtW5VkBz03hSC6yo9gmmPK2P34oqHicCRiNPEsc0UYAHcyaWmIbUi+mwWl4OLSk0f
 HKW3YxAgKkPuu4SyBJuK0Fum+cb2+5Cxfg0sRYn/N2rP2u9WxTRSbnh/Mkbnnd0QLiRTEwD/6Y8
 Aj7vNYztCL0Nwucsr5flLriqd8FNHkc3S+LlWiReJmmmvGbcezrnI5k7OwOa0LsHvjaQswga6bn
 Odm04AW69QfYZfvSf8w==
X-Proofpoint-GUID: lmyJ7EgI3dLX1q3InBpHaEiH_eigRHwM
X-Proofpoint-ORIG-GUID: lmyJ7EgI3dLX1q3InBpHaEiH_eigRHwM
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a0b190e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Lbdm12_SwBOpIOl6TaEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180134

Document the "qcom,batteryless" boolean device tree property
for the PMIC Glink battery manager node.

When this property is present, the battery manager driver registers
the power supply as POWER_SUPPLY_TYPE_MAINS instead of BATTERY.
This is intended for 12V DC adapters, where presenting the supply
as a battery would cause userspace to incorrectly trigger battery
power-saving sequences.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index ff01d2f3ee5be18e404591e3f0382ff2b3f7d168..5f7b90d37ea09d9aacff463b2ff4b76d218bbeac 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -72,6 +72,14 @@ properties:
       - const: charge_limit_end
       - const: charge_limit_delta
 
+  qcom,batteryless:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When present, the battery manager registers the power supply as
+      POWER_SUPPLY_TYPE_MAINS instead of BATTERY. This is intended for
+      12V DC adapters, where exposing the supply as a battery would
+      incorrectly trigger userspace battery power-saving sequences.
+
 patternProperties:
   '^connector@\d$':
     $ref: /schemas/connector/usb-connector.yaml#

-- 
2.34.1

