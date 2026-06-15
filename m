Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3C3DA7FB
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513558; cv=none; b=d/R2DLAMcqWWkXMUdEUNRAZ63937VjQ5o8c6bvZqtHtaSV+fP1iGWJa0FTSmlhuQtLuy9eUBfm3T3hT/Ka7IIxE0c97b+2pYxQGaqyKSNVTo9A6pqt8p5KWQdJ09+KnkZAkXNZQaGZrVT2/i/YHGsbVhu3zzEavnQv5vIVqm7eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513558; c=relaxed/simple;
	bh=STku0i5TtYmUEEpeQwXvpNR0khl4OJn9mGwqJJMHjDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VyBnol8n6xcAaSRkr9kYuDSHAkkS6uYJTQ+OMD5w4cpJdVWtjjejeJBM3kLALpfQD2r298Y2NkkHV5BfsubzCiw+fF8AvbagHEnqq+Xk4LU/OgXAzj6XROwgaXbCirXMCayiWWDOs8s/8/p46JxRqSKBUnjcOQRE/cC7K2X2u08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aP0eayDV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IDimv7S6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aP0eayDV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IDimv7S6"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6K9n43692441
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 08:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2JSXreH0Ef/
	woXc4rcsCrGvqXy3i53dhdVhB3MtcL/c=; b=aP0eayDVR9rBkE2kk1eHhW+MIFX
	3p+XgnEkHEMPHsoQqzXxM2DMBxJluFsXRbH/hqCkb38RoL3EBw104eyQd+z9Au2e
	N3r794Looeo7pqt3WS97sXITDUoCDOU8nQ86ck3XK/48cLSdrDiQmgeGT3SMi3qp
	sJM82BxMPTy8RIMdlAdzm1+3vxcmyV7VvIpCRbISlLQ+vF1gk07HTe9Mr2ez2TTw
	UaySHNHpmwgeuqVkyiDXcwwwD9F6PKX+8rq8hvYTYzkhBdS/gtXiEX2Dj1mt973S
	IH9Z8kiF2NaqErU7LmCYr2el7+r6eE2L2uwcPSDn3ljZasdvVv7Cd8IVeag==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eryk6eevv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 08:52:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36b9d265308so2276648a91.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 01:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781513552; x=1782118352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JSXreH0Ef/woXc4rcsCrGvqXy3i53dhdVhB3MtcL/c=;
        b=IDimv7S6TDrIBwxk8UW/+Bb0qywXIoxaSYyWKRIHc9ocKMw+eJwUaxSP/i37TkRVI5
         yrlcMpI1mtAkIX0B/81Ie4zDKDLej95Gww1k4GZjkZQ2RHodS77wj0IE9Dlm+NRwQbKs
         /KD/rTlyjNCVhwxXyyHOxSLp1hyENcD+nH6mfQoozALtEZtemHerxzHp9hkBX5E8Mb6/
         92xu2EgcqUyxIEUd3jr2awOelf+RZ1SPzZ7VZqBxYKKziDbyZrwE+EtCaL4E+BBC7s+Z
         d1jY4pHe3u4laSb51E3XwbglD644zTYmCfi4zePVfKV2XInYq3ia1uPVr3gDxT4NUsDq
         JZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781513552; x=1782118352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2JSXreH0Ef/woXc4rcsCrGvqXy3i53dhdVhB3MtcL/c=;
        b=VUKW1Y4US/Bn4CfAiultSw/jGG13tTL1sATO7CGE3p7v2+WaTRHtcx5zJgDmD3eO0H
         VQ7S1DblK73fwvBT8NBj2IgGbqm/yVxOafhpBaiNnupy1YEW84A2XHuo7cMwLtUxO6XA
         riSZ9pAFnHOILFPuyzRkkXZxNvOrxCO6mUED5jpxeYJjJY6gGWNBnbY8tXLli+Sq15zy
         qsh2xiaBEUg7kRp9gInR8OiW9NzYyv2qR0zgz0kDvR2SVOO+pb/wcAh1bG61hIe/u32z
         ouGL1qi/pA5MRjVkMlWrPwTSk3Xdsx2rj94Z0oyjS44oRYfd1eN6Y9shLql/hFBYLxwI
         +VpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8d+aexJ2cGuXF+GnOQOA2dzmRLafKCUZLFHouDp6Q+o0T2eOsXHrF+ORbthvB2EWlMdk9fZtowDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSnkGTSBx223IsZYnri3N4NLobqNVYnWZIrtivbdd13v/nvtkD
	rX0TXj4OQsm2ZnxZeQdJX6mmc66P9+iqYQNnMfcCzT9Q52+HAQ73pijE4sh46qI+k/QlgEXl6IT
	6gUU8WEZCqWjGXb9ond7T2JGaOmRizAA/N3pOa0GzKK2U4ewBI6bQdhZwURa3KQ==
X-Gm-Gg: Acq92OFxpZwhmiZYWjiFt03Qf/Xc5j04cC/tuocmwqoLYb9rD6aWA6/xo6ZXbL0wVVh
	Y2ydphSw8c+7Q6x599sU0ffsypkQQ/spNOFrhKp0ncn9o7st++UuVz6maFQ7QtGadDYFqxePJic
	DeZO6o3rzZ7efUoIgSyupILZx9XUeHhRVjHKN36cUnda40T6htVnL43POMuW9fBSQYkT9Nkqhg2
	OKA2T2T/ETBPjEoCPb9w0ZRpvsdIFiq9Vqr54onQyu3ldGsloODQxlAsQQTBaGG1fYTQB5yaru2
	qWm1L8ih+MfkL4dSC/m2lmnQ2lTKQJNZDb6U2jZILEIsMJFvvu+w7DiaiDYQ6vlwA301rc6zDaL
	5uOrT6jjBtp53fLtZBDya/ABG9KJDcld1La46Lkj4q5f1ucgEJAnuioh6MS62gs7M85kYL5n5BE
	TFmEzP3UpK06tpOgMwAiKb8QZ0B7NZCKTw2H6JR8DFx+MVpevktFA=
X-Received: by 2002:a17:90b:3f50:b0:36a:7c8f:1423 with SMTP id 98e67ed59e1d1-37c2bc73e4dmr9733609a91.9.1781513551941;
        Mon, 15 Jun 2026 01:52:31 -0700 (PDT)
X-Received: by 2002:a17:90b:3f50:b0:36a:7c8f:1423 with SMTP id 98e67ed59e1d1-37c2bc73e4dmr9733570a91.9.1781513551532;
        Mon, 15 Jun 2026 01:52:31 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a25ecd5e9sm9539723a91.10.2026.06.15.01.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:52:31 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH v4 1/2] dt-bindings: thermal: tsens: add ipq5210 & ipq9650 compatible
Date: Mon, 15 Jun 2026 14:22:17 +0530
Message-Id: <20260615085218.1421347-2-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615085218.1421347-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260615085218.1421347-1-varadarajan.narayanan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX0Ih4A6NkFJex
 1NAu160Cr3f0gFzaJedENbPM+gZKwJG9CddbFjelFeOQcTmjMcTBZFjnXKG6trSUHINO2i2jC12
 dD2l1Uf/0+uHEnrErJh1khNOHNhzkcE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX+mqyXygFbKYJ
 XdPBgRYUr0RkQChGI2RhHPjLBnMphboP10N+xM/MBbIoCHmdhc0oWzk1Gxe5TlhWxdc1CwFGoF5
 vgChvAQ/pK1HVbKGdskEHeRc/wpx0/MK9AFWMKp3fyfNkW22+MmEPL/lkxotsaAURFuXe2spSwX
 ubO2kt3Omaojx8wKK5bGKO5sJwReJzpugQGmg1Zc6fkD73pMUrdfZ0Kdefnhriv57d6xWrq+qwd
 M3mAfadNt5BR1dBvqcTb0IamW0mh1+fzMNGdnjCHG7xdEvFXrobjMeUT36B2euP/KQrzyhHhVYY
 6lRmj6xbV4Xyld2yHSxjlFZezC8oUkBmPwOuC+oQfR2dUJyIabPX0YpWhDEjYbkIKcMgL8GBoaL
 5W79ciZnB7k79IQuAxWr4jXqTHHCrQjOaRu4TYiu0vKFfbQUpA8AKuHul4fnew+IpVOVIh6Ax1p
 C8PIeaAsCNMbXVSU/6A==
X-Authority-Analysis: v=2.4 cv=NrThtcdJ c=1 sm=1 tr=0 ts=6a2fbd51 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Cj70nMFs6DzugLwqs6cA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: _PWpS3Pe4zIy5Dt6B9YohoTVIwOZDkZI
X-Proofpoint-ORIG-GUID: _PWpS3Pe4zIy5Dt6B9YohoTVIwOZDkZI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150092

Add the compatible for the thermal sensors on the ipq5210 and ipq9650. The
ipq5210 uses ipq5332-tsens as a fallback, while ipq9650 is added as a
standalone v2 TSENS compatible with combined interrupt.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v4: Fix version number

v3: patch version no. mixup
    Include ipq9650 to all applicable constraints
    https://lore.kernel.org/linux-arm-msm/20260610081241.1468507-1-varadarajan.narayanan@oss.qualcomm.com/

v2: Fix fallback definition
    https://lore.kernel.org/linux-arm-msm/20260609065447.4024695-1-varadarajan.narayanan@oss.qualcomm.com/
---
 .../devicetree/bindings/thermal/qcom-tsens.yaml          | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f0efaa8349ee..bcec314e0532 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -95,6 +95,13 @@ properties:
           - qcom,ipq5332-tsens
           - qcom,ipq5424-tsens
           - qcom,ipq8074-tsens
+          - qcom,ipq9650-tsens
+
+      - description: v2 of TSENS with combined interrupt
+        items:
+          - enum:
+              - qcom,ipq5210-tsens
+          - const: qcom,ipq5332-tsens
 
       - description: v2 of TSENS with combined interrupt
         items:
@@ -306,6 +313,7 @@ allOf:
               - qcom,ipq5332-tsens
               - qcom,ipq5424-tsens
               - qcom,ipq8074-tsens
+              - qcom,ipq9650-tsens
     then:
       properties:
         interrupts:
@@ -323,6 +331,7 @@ allOf:
               - qcom,ipq5332-tsens
               - qcom,ipq5424-tsens
               - qcom,ipq8074-tsens
+              - qcom,ipq9650-tsens
               - qcom,tsens-v0_1
               - qcom,tsens-v1
               - qcom,tsens-v2
-- 
2.34.1

