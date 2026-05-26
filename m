Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CA401A1F
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804549; cv=none; b=CLGNAukFIIGTWZGc7MH/LF9WSLAEh3alsgc/VHXhMiGg1uD44oXI/AbDxPttpOQiV8edWAj9mcZcSuk7K3LhIdGsFhwo6CWEz2hA/hT0r18WBV9szp7U9N4EyjUToZtHpaodZohuvfCC018/tstkaXc+GbYuRsSCTCoR9v/FGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804549; c=relaxed/simple;
	bh=vNBmXUp+qr7T1swL568nvBKihzEO7mn9iQtvdZQjD38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mg9wD37xEexH5opHHPskh+acMwc2k4VOrE49/oBKhQ57QN9MguYyH3wI0tnpyimQNPShjJvUeQzBWRJ+0PBzf1GsBr3Rmkm0TGjj7xEuE6BWJscZQbEUV1TUOxKzn9IHVQv307k/lE081+ulXdvoatjI/UT18RKBSdJu6h2q4Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZhqakRQh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eMr6blFe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZhqakRQh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eMr6blFe"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsdfE1163862
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sRAimFW15YZ
	LFDJYTwa3t/Vg46FcoMMGZciPbr7L3vY=; b=ZhqakRQhVJzpZHKGl6hRcCdCBN4
	jqN9bDL532gO/es5ZfJqGbpVfTTQ11+up4rZ3QUcxWrbMQRm+oP2adaWfOwjwoaD
	LlP+havwX7NM3R94LEqx2h56XjCN9PVzrWQ2uNf+4i62SUvIfbqK0CiG3Bh2orRZ
	4mDDMtGngcPflpTVT3xJJz3QRil+FIYwIJiKDCvn+dRFKGV5SKqUWtHQodOOiCTa
	tKuVIolTsofahIxiR3E8RX6UwMzZP2E2PA+ToaUIQJgcGEv3dUz70z/7Jp2N3U4+
	HPZYaQ4VmF4tMmy1F0GswyQZlvHUA2VxzeS8fdD7Kbpc4MU/knT1pZPrt9g==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckyqnex8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 14:09:05 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dcde7bf859so24770602a34.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779804545; x=1780409345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRAimFW15YZLFDJYTwa3t/Vg46FcoMMGZciPbr7L3vY=;
        b=eMr6blFes1UPoIeZSNWD13Hc+MXmtJGTYsXXm1g42Nzrlxe1D9BZzhkgpXqztcXio/
         un32IQdLl3/tbtr6KffI2TDTCKQVZL9aqOKjb9FSccCxBvL/y9AZPIKiXQ+EBCTUYmLz
         Z16smRJTqV52Xf4gFzeAgTSt2e+2aWNrq1dDvI/ld+nBkecJQeycNKaizEtJx/48/1x6
         u8jHpgFeJSJ8PXmG4yUWDvHhE1feqnc0+iHCyYxB7xQYsVPurkoR11SV32I4G32dOha0
         3V59uV4q25ogSk9TVuBlDJCIcoS5XCc8ILcdOTwQGoY/sya3CO45//NymGdXsa7O8/bq
         +++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804545; x=1780409345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sRAimFW15YZLFDJYTwa3t/Vg46FcoMMGZciPbr7L3vY=;
        b=AqLLrMhboHtI/F4qKG83c/IAwqCRIL0mjSc5RUan+kkWTK1oq6O/b4LPKxhcmqG62a
         1PJ1ssL9B3u0KXmDZ3KVWWJe0cPBKzgRRizJ1mSVRNSRzYDQPzjkcP08CDX5ImY11skF
         gFfdy+86n/KwjqXUlY4Oj0Gmlo+w8FRicUeHDXL6a+lBix9NAOFo3gRXgTVEwRoj89N0
         2sVy8c+wDGJ1yrc/uDsfn2+pfF8NU+GnkY/Lpz3gJIURPW8W1ejI+Edo2L4gh2IRBxMv
         chZVrcho8HRtmJvlLoRFuaeX0iGsldJpcQ82uJCSayr/d2x8/i1q2Z1EPF9hXrLwUbM3
         e12w==
X-Forwarded-Encrypted: i=1; AFNElJ+YoNFLN7cScdVzEuOTVMLnQT2i740IFHRETNom9KEUz7DwtZ2GMzvgS8hnQGKUN6z9pR53RCbdTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbE1jwEngliBLC3ASXCoKmmjViD9rEBibD+juiu3LmF5N3ARea
	V1bzR2HWTOetL3oZRxzJBot5M5FF+LO0gDmX8X+EULr6gpJQ06stB0AJ8mXuGQv/oBsnd4RCFIC
	nbP+6f4spswFuZWetn8T8dbRToJTwM251JVfV0aWjeUS9C2D4YFmqDdZbjRllVA==
X-Gm-Gg: Acq92OGqtwNFEN2+s11tU2UNGjBPHIMokD5ywW5COBoylNRCQfVuhZq0sly5ZaIauZs
	riphVOnVSPeiwvSEteSp1LkGnEpXg+X8hvdZq/IcxoIS37PtRRLaz2VbcnID1OnyAYTvPIE7QJd
	zpvb99+YDTTeM2rnlC7SB/Tnz2u/e2CZHSOrFzKl1hc6plaF8YbD5bN0VMADwD0hy9txQIX2R6h
	yxdT35KgYAs5TqowSFhRzOzRpvtlJxTHjaqhtE6AFwZ37ih9Yoe9BYYM7QKuyPNpE5Dah0OZeNm
	wq6riTLFUdcsBJLv2Ydv6HG7zUL/NAyZAqODXa4tdaQlGqeJKvo/mGvYTKOLAmigHYg/cSzIGAF
	0tjJJECe7T8zaRaHWSgycTui95TOSuN1on4rkNapsfmgQG5hR
X-Received: by 2002:a4a:ec4c:0:b0:69d:7a88:9cde with SMTP id 006d021491bc7-69d7ebd2540mr9712975eaf.26.1779804545070;
        Tue, 26 May 2026 07:09:05 -0700 (PDT)
X-Received: by 2002:a4a:ec4c:0:b0:69d:7a88:9cde with SMTP id 006d021491bc7-69d7ebd2540mr9712950eaf.26.1779804544565;
        Tue, 26 May 2026 07:09:04 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424aa561sm156266605e9.5.2026.05.26.07.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:09:03 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
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
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Subject: [PATCH v4 10/10] dt-bindings: thermal: cooling-devices: Update support for 3 cells cooling device
Date: Tue, 26 May 2026 16:08:11 +0200
Message-ID: <20260526140802.1059293-22-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3191; i=daniel.lezcano@oss.qualcomm.com; h=from:subject; bh=5i35tXeB+dh8TrJjTALfDVhxhzQaJ333X0Wv22iwE5E=; b=owEBbQGS/pANAwAIAagyI4oqT+hPAcsmYgBqFalU2waeZFc+uXORaM2nz9oOnxTnFcm8cpWx3 s2FzLBGue2JATMEAAEIAB0WIQQafc3hhXPRY1XIeySoMiOKKk/oTwUCahWpVAAKCRCoMiOKKk/o T5NlB/9QnwbtJvG9goEnxhkDoppxiDPtuCMvxHYkSwAc6LoSwaUAHyacygDloVTTtlYpqGKzaqa /GcKZkZq5pt9AxdsqmYnzP9lj2PMAwiExJuQlFef2O5c54WlnVHLoz/MX+2IrazFsJIui5cVLzD Srr29R4eg5f9IOItjOljWua5gVW5uMxV9NmKNAMt/9sbG9BnW+OixxEiXACIAda9LcAyC1IZqPy VjkIv4vdO7MyYSEBED9wNBF0rcYWoHcrYBZl+EDpC8V9o7Ne34lGP4iC33a1l5Jd3kWPDNfm/8/ TYN+POK8V+qJdA6BNYAXAh/3sq/J0yNtJo+uF5WdN+2gJ18W
X-Developer-Key: i=daniel.lezcano@oss.qualcomm.com; a=openpgp; fpr=24D626F253BE9E87E6CE5BF48FF4B8D271675527
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RMyD2Yi+ c=1 sm=1 tr=0 ts=6a15a981 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=WD-cMf_r4H3F8z8mj00A:9
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-ORIG-GUID: 2CNJCH7AFm3hVsJ3m8ZxuUZGGuDo67hL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyMSBTYWx0ZWRfX8H5HdE8L99Uy
 2DxaoXW+4QUkm8uATS2mOfnNHp9SyY3zURS82oGiAxCLVK+ME08Z3B4cSeqT7/HlmEMqyzFh4tH
 aIxyMDTwkUmpyp6c32dqyH0IZr/J4FKi1XxNRqHXW8RxB1Dq40wDztU7PPBOhlymqahUtlpSOcA
 q0uK3NfPh8C5gm6GIqHavMbPjviau7Wow2GDjgZBDO9VXFODUo/3ebyrzd4TCF4VMyeorE/gL+c
 66ycjNILC38PRdOl+o9f5E5n1zzldeGPUNoYLwzy23QuNrRN/kOJnKp9fYxNZNqHFTs+FamiJmP
 DcajTmAO11aKP2EkbPdXqxqxPDcoO8PjxENXIsCZfFHXq2PzpcFum33pyQFz2tPHn79nTkw96iy
 fO+QkxF7ksxOs9rR/sDzFogGyV7ZoWJt8QA9ha2iB643ATLaVkJKyFON/z41/LW7omR35pYYmOV
 2AyjmYnN4srirtbwmMw==
X-Proofpoint-GUID: 2CNJCH7AFm3hVsJ3m8ZxuUZGGuDo67hL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260121

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
index 07d9f576ffe7..999ad40a20d5 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -211,7 +211,8 @@ patternProperties:
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

