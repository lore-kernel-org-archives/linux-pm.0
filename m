Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE7402B9F
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479306; cv=none; b=b0vw0bzcwfa+FZZnT/MWiqs/aHIDaq2m33LRCVq4GoHDCjaJ56osB4Ns6Jo8GER+xE6/XNfahvkiZ+QlAmWfKXrPnAlUcNoqHsGsv368HK5FhLV3mJpp1xVUCBpVFO1Nci7xks9azDsK4JfaI24R0vd81eTCLx4A0HhFPuileRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479306; c=relaxed/simple;
	bh=0hqwleN+hGYWOPBNiXuqMAKygpx6yIPIDHS/duN9w3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyvEN+ZagAJpaeXYX3vipqai+75lTmrySE1DqChXaVOX7xO0vjos1fRxHI+ZbGiYJX/ELlvWs0i9iK37TaRsl0IjAGZR1EHBg3h9jkiTCezk926/qktHqzyCBzUkSW3IgEWRmdHXyC9EH9eArdDQ78iRA7YGdz+4RREtI8DHOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R9WDmL0b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KujTTKNl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R9WDmL0b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KujTTKNl"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TFPwuP2094252
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WKIGIXDHh9X
	0RP427er22w6scCsGhci8yorv+QWR6Ao=; b=R9WDmL0b7l2UUA9WUXk12qBecj3
	Zqzn+0RElZ5Wr2DDnRGDSVg7WZ/D0T0tBvW05yY+/1G7bW+nP6HEg7Tta+T7T/lq
	6McZmPRf48leve06DYPIE2OaM3JmoXwQPIA+pHUdmryKfzwp4Oje3h+7XKirv5lw
	oVShu2SuQfkbDkJMqyquhBl6oIjzbPydjdiLvQJ5iXNJRUD1OaxyPF5wARasplPL
	g6LLTicWm2HLI/MiPkJW0sErqbOdPhFAJlq9ATiWkRmKVGXyH56LjHgvWSentj7g
	vQmvnLSwworO/R5eFrnmfwxbKM/jbssDzQi2NOtMJ/xzz0BqvzD7uDMUdpQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dudh3t676-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:15:02 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56f6e1969c8so17084170e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777479301; x=1778084101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKIGIXDHh9X0RP427er22w6scCsGhci8yorv+QWR6Ao=;
        b=KujTTKNlYe44cKWuhsJ79Cs/fFt+iABm0UY4LqSZ3lMjQnRaTJ30aUCg81WIRwM9Oy
         8JCXqdNKT/JyapRmmKzeWqAoUCCitm6vCX5JxIgqo2GN9XfaxlFPB/rJOX3TPrqfnLpn
         YUlp5XIHGPyZUP1ExI9/gkmMw0XgeGM72lTx6UZnzVXurw0EMupV9vxBUrhiYaWqvog9
         9RE6qMALFP0niwkny5p38nohiBmfwRaWcjBydCIJy41gJseGF55ba5U5hGY4Dqtf4bwk
         TG1HfnD1bb4MoTW08BkMuOaoKkzKhpPe5WWRQ+z7c8fyyK5JH6FtTyHKlZR5kLmA1uN/
         HOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479301; x=1778084101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKIGIXDHh9X0RP427er22w6scCsGhci8yorv+QWR6Ao=;
        b=VkB1tZ2skaXB3fOBDc9p1iAQ88Q6ymFq8gMoiMG7Wvy1LolJQXVTZzmVgxw88TQB70
         MLbJWq7qzmjDztgnwUVZSe8vEVB37W/8lFuRrI/Zy2eQ5aweNa7UYoBdtarCOoGwMNHH
         vbrOICu48l9JCLrfXVuO36SqxRpVqGyV5eFClHnD92jyW0nVu7dVtEvjGslp/tvSinY1
         4RGX6s4ZKJ5DHW13qPxc/tASDaojFSg+E72xwQ/DyD0usfxNqFnLA3Ia39lcPTi5HJtb
         o30TUQZsgBx1jKKt1JRlAbRz8VTlpmdY5mqTGeKiqKztZqWy1bqNpuIiWRDVkV5vHkPN
         tzlw==
X-Forwarded-Encrypted: i=1; AFNElJ+sMlAPfnJWt6Pfklf2tWrWEHvvQTz5IRhIJUUXiazAnm3GlUcpF8cL5iltT+Us1FXx+yyhxyfKuw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2NRi3mTvkOX/k1Jw1K+auO0cFeoKdeOyov2BqEWZnSM/AB0WP
	7yol9bwGdj8FyYEwkyyc8oNgaTz6avevsbyypAkxEEhPRLP74zvueFSuydg3z1jbn7NBMcAVTK9
	wFibCu9NXByo0tLl0MFbKUj3YyzTrV3/0YQhzgfz7XH80MOHVNJ+y0kB5z8dB9w==
X-Gm-Gg: AeBDieuIviOFCyZyx5jt1L18gSaa9JL3nLWJtrbxUkBiT1aYwT0b/UdYe261JiIF2pb
	oB0XO5SGE0zMabxmJQNGwMC2xZDKcNM0+KQPqBCMOOp9gnNGg6fEcE4j6JC6vyRJprU4taTKqt6
	F51kRbkOfHEmGn72Y6hObFCJ1UenZYSzr29o316NWrQMJnMMVxAxOGAG0QCg3kyinAsMtE8o7zE
	sJboBF7LcyyY+FZDWMj8Perb6X7HBAr0qNPWWERAQRUhgiogIhr2BsEwnSBMS8mkQtjJe+lp4v+
	3dVLI0bLLMY6pIis7AAFZPZTx7x8LPvmba/YMWiXlltG3L026zjOQBZWRgfcJHjEMXWnoxD8Nk6
	DvGR+CuTEQO9XFCzqJDjEtfdEbI+crspoEH/q6yI3sIB689X5OvsjEPcLVdXJ
X-Received: by 2002:a05:6122:45a5:b0:56b:815c:961d with SMTP id 71dfb90a1353d-573a5580601mr4806213e0c.5.1777479301546;
        Wed, 29 Apr 2026 09:15:01 -0700 (PDT)
X-Received: by 2002:a05:6122:45a5:b0:56b:815c:961d with SMTP id 71dfb90a1353d-573a5580601mr4806128e0c.5.1777479301015;
        Wed, 29 Apr 2026 09:15:01 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed659dsm2438525e9.2.2026.04.29.09.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:15:00 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: gaurav.kohli@oss.qualcomm.com, Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Benson Leung <bleung@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Subject: [PATCH v3 11/11] dt-bindings: thermal: cooling-devices: Update support for 3 cells cooling device
Date: Wed, 29 Apr 2026 18:14:24 +0200
Message-ID: <20260429161430.3802970-12-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429161430.3802970-1-daniel.lezcano@oss.qualcomm.com>
References: <20260429161430.3802970-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JLPBHWvp35Oq91YpoyEVKr_fABSGlC9y
X-Authority-Analysis: v=2.4 cv=A4dc+aWG c=1 sm=1 tr=0 ts=69f22e86 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=WD-cMf_r4H3F8z8mj00A:9
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: JLPBHWvp35Oq91YpoyEVKr_fABSGlC9y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2MiBTYWx0ZWRfX8x3hbmBUkIfr
 53uVqHK4Ja6NJ8yCfd9vIlKGEZjn6yoK/kpRmyLtAY27qRRvY+Vq7VMEEoGNbS3UlB7r1cgVXXy
 Bi7QDjtCuSTMoF4YLzizMk/Jfy2dcEedhfi+5c8lQCZp3b8CyIcPd6Qa7NPW+JpBwoUxthpY0ys
 1j6zMUZBOioh/pCtMToCu5nW/Ezw6uaAZ7uUUYdD/ZI4WEPu0S+J4d3ML0vtZxA2B+1ldXXYD3G
 2X2Jpmg52/nmWyEFfIY73iHJQru5C2LrVomCFujYu9Gee6sHoA45hDu7eq/QIrwOO86un7060by
 DHCtLqdMWY9JRfhRz5J489LiPC7dfG2JvJ+MVE+Uw1b7snSDCS5IkLFhafm2EJkb0bjolfPh40D
 npcVAmbELHehQ5WxsAcnP1njfq2BAdI3eSS//BIb9NXXVY8kTXYQCDPX4rHAUQLZPQoRfpyX6cT
 SQuLZnoH+67aWA4hPcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290162

From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

Extend the thermal cooling device binding to support a 3 cells specifier
along with the 2 cells format.

Update #cooling-cells property to enum to support both 2 and 3 arguments.

Fix pwm-fan.yaml to restrict the number of cells to 'const: 2'

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/hwmon/pwm-fan.yaml      | 3 ++-
 .../bindings/thermal/thermal-cooling-devices.yaml         | 8 ++++++--
 .../devicetree/bindings/thermal/thermal-zones.yaml        | 3 ++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
index a84cc3a4cfdc..6a24851fd80d 100644
--- a/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
+++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
@@ -63,7 +63,8 @@ properties:
     description: The PWM that is used to control the fan.
     maxItems: 1
 
-  "#cooling-cells": true
+  "#cooling-cells":
+    const: 2
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
index b9022f1613d8..28f5818f1e60 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
@@ -44,10 +44,14 @@ select: true
 properties:
   "#cooling-cells":
     description:
-      Must be 2, in order to specify minimum and maximum cooling state used in
+      Must be 2 or 3. If 2, specifies minimum and maximum cooling state used in
       the cooling-maps reference. The first cell is the minimum cooling state
       and the second cell is the maximum cooling state requested.
-    const: 2
+      If 3, the first cell specifies the thermal mitigation device specifier
+      index for devices that support multiple thermal mitigation mechanisms.
+      The two other cells are respectively the minimum cooling state and the
+      maximum cooling state.
+    enum: [2, 3]
 
 additionalProperties: true
 
diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 0de0a9757ccc..1261ba0e802e 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -214,7 +214,8 @@ patternProperties:
                   device. Using the THERMAL_NO_LIMIT (-1UL) constant in the
                   cooling-device phandle limit specifier lets the framework
                   use the minimum and maximum cooling state for that cooling
-                  device automatically.
+                  device automatically. If three arguments are specified,
+                  the first argument is the cooling device specifier.
 
               contribution:
                 $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.43.0

