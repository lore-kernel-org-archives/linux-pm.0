Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264530;
	b=xt9mB2s2RbaooNpOhTBKRDalMUrta9kXUCB2/CLhoXyh/SBPmXuYY/d83H+R1unpojEs
	 AeJIf0/AQSpMcTZEZIHOw0oqv++AWDdJvpcdJXqDwjD0W/dnXDIP2rZ0hu8+hpGSTcxEn
	 ZgtV3FPSCiQwWTNCoCyr/AF5uD5gBApT4NGZDzg2B3UusHRWFahOE1fJpSLuN1bBZbRtg
	 4Ge4IX8FW8UrpKmwjfp4MjTcfViSJWIheakmH09Qt9vFOZC3XtMF/WCODJPW7s68HR/8R
	 ILqUJos/WyhWiotCJAEyBI56Z+ePRQZZz830zg2yGdmRfNlgGCaYzmOf6A204oE6tRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264530;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=SaegZ9+Myhai8ugI7bQJbLZnEb4ZbtFQqLe5y8eXwqc=;
	b=FxKBGRlPp/F7SCnwyu1v9AwpIk5NNVECaD8tjtUPhnPb4E6AR3Dx1OlmbOBLE+opy+y0
	 aDLEy17JFA0m9FFdZ/D0+gHjyNZS2ywMLw0P/FFYKaiYWrMCqxBCgM/BKMSrWh4Bu8wjM
	 u00PMt62fsqDHEKz+fNi8+QPfzxwE0nEVj1XcwHFlDLuZtl2MCmxu1jxpGIFfXYYNlpUD
	 nS+oWxOCxW9TSrnsjzFa00sXvvySz1SirkdKk09nxvZn4xIM9OdNpAjFE1GcZqNIp0zKe
	 YNfIxiTjaUIv5xkoUSWlHWHNVx61P2dveHjRiSFaADGcc32lgPZ8s7tA4PsnKfP57Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WySbZcI+;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UI5ozPQ0;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B25460A2604
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B25460A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WySbZcI+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UI5ozPQ0
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8vFPH3775284
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SaegZ9+Myhai8ugI7bQJbLZnEb4ZbtFQqLe5y8eXwqc=; b=WySbZcI+8afrzpQk
	ML1Y7Q7bN5nEfvXGA+Jj9n5kryGtvJzhklTEoJVHe9P3fQDJ7mfXqurHBecdUlbH
	D+k5LTwoBKvoxsmkU5GB46KyyPJJO/M3ojDgXutVYOZoB2YHNk+9nmGpRstkV1uK
	GMd2sS3+bz2POenyn4tgd0abhzKcwZYnRWcwL7iBToTEMF5ong3kIRi6GsjIq0Jy
	71lUD9JiNcV+Id8yAU4cwEcsdY33BV0ipLrjcJhVppUQrJLH7UEUzvdV06jvBwGT
	EG8i9WuymuT2CS5nUdSPVg9HrROSD/EItOcs9SLfpx8BrrIxGGoexZy8dEoWP8qX
	5KJf8A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkxshrytq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:02:08 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd652c0385bso1269302a12.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 02:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793264527; x=1793869327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SaegZ9+Myhai8ugI7bQJbLZnEb4ZbtFQqLe5y8eXwqc=;
        b=UI5ozPQ0KwNbAuPtxsUQdT+8N0OoNW5Q9my8an1E277fErF5727uDb0LbdHm3G1xEJ
         XDo93HMQQmoLhfbQgjKrtA7lpuYp/HXufbbxu8JRujUIjP/SOVQ00TGfjcncwJO4UoKW
         Xh4Khnx2uXwI8UmBirThU9wbh5D5+ou2b7BQbl0n0bkzZhj8vndBvaYrq+AU7lDM389n
         e1C7W8P5PXBvHUMdzwA/gf+yb35+/RSGUYAbrAaPSzCuZ7ZJl1q5KMbCITTzE9uk/Xd+
         V6WsiSvd43zUUfI4lr0qo+heFUoTV9RYcjjyrcqUXXdV6YOlXw58mnOBS+NOthOHmadJ
         3c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264527; x=1793869327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SaegZ9+Myhai8ugI7bQJbLZnEb4ZbtFQqLe5y8eXwqc=;
        b=Lb5xAnbZAus9B1rNI5cQpFplT6KyVSve0htrTA/8u/32qhhtRhg1KYUF3XdykICrFY
         PtSKN1HcfhM9q7TGIydPttjH95iIhQvh53DPdwZG3vBNyiWQpxi28bn7+lUUCOGTbYAI
         IIopz4ANtclQaZSGpObPoLYXNUO1RjTy2B7jQ9ujZBOfIpLUkKvemjsul4M5p01TAgNH
         4bVRrbp4VhhmzmePu36jLyp8IelNDkmGNXK1bTHs4PfHKPr0FZZiJVf+9m69Uvq4qriO
         dgih7HP54EwKh5K2XFDs67RO+5UbnOXdgwfAR2KnBgriCdefWJY5CYnsHvt1yz7H2F2y
         JHJA==
X-Forwarded-Encrypted: i=1; AKwUvBwshHUwEEpsLAEiOF07/ro4zz9IiiHO8s3Lr71N3I4aUt1utm6TPbcVvEhVo2DODs8NXcqz/oXJyg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLxgCnQ66KA9F2wFem5v2/hm4sbrGjBONOyqBEVN1nEsqSTMIA6
	baYTyrIcofdxKmADdCzV+itDVHIgu6IC+1l3dnQu4gJ00BU29CStgkv/EEoQ0F2IUqSPRAoP3/4
	DENIEymMEmulQC69FKQiEPAyAf6++f+kMJvKoGrMui3d5tOZmZrtvHuZNRIxC6w==
X-Gm-Gg: AYBFou2zEdImlNGHsj0LFckEJD9ZfvPyR9Y+NlMagHRflYQy6hMDFLqI9HMe1tl5eaR
	A0Vx1uR3IOiCAeic7Aa1r8YTQlKYzYPOk4g4D+fDCPO+8vSy1DZMRH8+dsTvMgHis2tABilwQuJ
	srGu90/MsiPB8N4R8UlODn8ijG6gBx2x/kfRdyT14UeJlv+2oOzzfzFO08Wh03w8GgAPVJ8zh+s
	mcd1aMv0I+MYJXZ6NnmU+3mDHfRPw2hfwcbghNKahsv6dpMsnSfVIfL3VIFPSEBv50xah674Uyo
	g4ZS3dbRCpHjaJGOTVlwuLHB2SCZGoKTF5kmKUOySDbM0hfQORmWW0ejpmKjPV4H54vRLeyZ0/c
	BkKbHjU95LAtwQ34SOQD12o/lOUWO4pvjUl1WDqFMAVOBoCPnCSBDFRK/HeAv26NGBaPAB0or36
	gPlnp55iJk
X-Received: by 2002:a17:90b:5386:b0:3a2:b16d:928b with SMTP id 98e67ed59e1d1-3ae5825051fmr3869175a91.46.1793264523900;
        Thu, 29 Oct 2026 02:02:03 -0700 (PDT)
X-Received: by 2002:a17:90b:5386:b0:3a2:b16d:928b with SMTP id 98e67ed59e1d1-3ae5825051fmr3869128a91.46.1793264523384;
        Thu, 29 Oct 2026 02:02:03 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e7ad710sm3197385a91.3.2026.10.29.02.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:02:03 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 14:30:59 +0530
Subject: [PATCH v27 05/10] dt-bindings: arm: Document reboot mode magic
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-arm-psci-system_reset2-vendor-reboots-v27-5-fa4b3ff1359b@oss.qualcomm.com>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
In-Reply-To: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793264458; l=3109;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Cocw8yqxYsC8f+LcKoCIzML/tmVX3vxCTN78aew4Vgg=;
 b=CndWAYSCONDUqL9nIiAiDUAvZM2ja3u7IKu76ZeNE5zbHXufpIJ6xe2m/zsaMxyDqVINOzfbE
 TQ6JqtfIfTAB32c1gOkFYjPzY3i2fxEW1DztsF9Q+t+7i/D9Ommnj0f
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-GUID: Bo9UPLik0mCGnUWAkhPN1j0UgE9VlwnV
X-Authority-Analysis: v=2.4 cv=H6BOUOYi c=1 sm=1 tr=0 ts=6ae30b90 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ZjyxHfqtAiH8XHGUigUA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAzNCBTYWx0ZWRfX7aiNwWmE17a4
 PGp0moMeE/XGPT4DM6lFTf/uH7Ah534ei30I8epj/uSPxvFgy91sV5rik7qv/c0xZEVuco+pBhr
 IkfUColm8njeu4/LN0dT252N1CI53Oc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAzNCBTYWx0ZWRfX6XlIdXgYcGFq
 pScCUfVSz6xs3V2WyKXc6jD0jB4UU8kbIQvW6aNEIAGlyLrgRCCTgmDzqBujXy2FFtmUQZUDB/W
 cZG5GskvxCP2JDqS9DuIntliARaJd+ZUN5Xy8uilJtMzBuKVrJoThehZ38sxOBTUBijz8qAMn4L
 DIu1d7OLs6Hj5ur2IE0ApjhqUW9fNqM70pwJpDF1WrN92O3SmeoQnPa2mvg+f69KUvzU86TwyTU
 m9/MFs6ntN5eHoiT3pHOVWDEJq/J0F94InbwzCmzZGiC+tQCqj27Cez4ukVW4T0wB72rkemEgbQ
 Bhn7FRqn4WKa0ilBx//WgmGjfBv4hqwqESSo5aaJKLqaO9wPQvI6+1JMTvK6/PiOHWFfAENMQ6U
 ikD8TS4gb7KPWsXj2EnvzExZTmY7r+W+c6Du5btPVOTrdsLCfvgujJVW1nBua/2tCsIDyBsHikV
 RcQw4tf/7+pKXjlWKvg==
X-Proofpoint-ORIG-GUID: Bo9UPLik0mCGnUWAkhPN1j0UgE9VlwnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290034

Add bindings to describe vendor-specific reboot modes. Values here
correspond to valid parameters to vendor-specific reset types in PSCI
SYSTEM_RESET2 call.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 56 +++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 0d04389c81fa..82ae25e7a338 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -98,6 +98,39 @@ properties:
       [1] Kernel documentation - ARM idle states bindings
         Documentation/devicetree/bindings/cpu/idle-states.yaml
 
+  reboot-mode:
+    type: object
+    $ref: /schemas/power/reset/reboot-mode.yaml#
+    unevaluatedProperties: false
+    properties:
+      # "mode-normal" is just SYSTEM_RESET
+      mode-normal: false
+    patternProperties:
+      "^mode-.*$":
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 2
+        items:
+          - description: arg1 (vendor-specific SYSTEM_RESET2 reset_type)
+            minimum: 0x80000000
+          - description: arg2 (cookie_lo in 2-cell form, cookie_hi in 3-cell form)
+          - description: arg3 (cookie_lo in 3-cell form)
+        description: |
+          Describes a PSCI SYSTEM_RESET2 vendor-specific reset type. The string
+          after "mode-" maps a reboot mode to a vendor-specific reset.
+
+          A vendor-specific reset takes two arguments, a 32-bit reset_type and a
+          64-bit cookie. The arguments are encoded as up to three 32-bit cells.
+          Each mode property is encoded as mode-xxx = <arg1 arg2[, arg3]>,
+          where:
+
+            - arg1 is reset_type and must be >= 0x80000000.
+            - In 2-cell form, arg2 is lower 32 bits of cookie.
+            - In 3-cell form, arg2 is high 32 bits of cookie
+              and arg3 is low 32 bits of cookie.
+
+          All values should be provided as per the PSCI SYSTEM_RESET2
+          specification.
+
 patternProperties:
   "^power-domain-":
     $ref: /schemas/power/power-domain.yaml#
@@ -137,6 +170,15 @@ allOf:
       required:
         - cpu_off
         - cpu_on
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: arm,psci-1.0
+    then:
+      properties:
+        reboot-mode: false
 
 additionalProperties: false
 
@@ -260,4 +302,18 @@ examples:
         domain-idle-states = <&cluster_ret>, <&cluster_pwrdn>;
       };
     };
+
+  - |+
+
+    // Case 5: SYSTEM_RESET2 vendor resets
+    psci {
+      compatible = "arm,psci-1.0";
+      method = "smc";
+
+      reboot-mode {
+        mode-edl = <0x80000000 0x00000001>;
+        mode-bootloader = <0x80010001 0x00000002>;
+        mode-vendor = <0x80000000 0x00000001 0x00000002>;
+      };
+    };
 ...

-- 
2.34.1

