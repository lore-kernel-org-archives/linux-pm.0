Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795081671;
	b=w5jVuXCPGzJB0k6w12rp1Rn0eLxyR+icTo03yGqQIeZ8IDtUjcIKV18kq/oMS2AiuEUf
	 WFNIGEtoFXT/uEGZq2HLLEIL8Nyl/g1kakF/5Pc4En+b6SYMfHj2mkpyqAX3mP6kJCUIo
	 8gwHcZWarhETwNVpHv6SyTP1W0mswivMCCEErpTNvO9/kDJW2p1mj1hTes7QMNXInfbqZ
	 ubKD6xgCoGVyp0w0NJlOvc6QQig3Fx32DaQqhfqQfIq3fAElJuwtIokQ0/z5/VgHFZqe/
	 KuLU6EjBzgahhdaH6qbL3pz6WcJGzJ+vRy04ljY2QLRI8pAtcILMv/VIt/0Mob/6I1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081671;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YDKM0GnslWm0swyMpWGTkx9eij2uqm5Ft78sdozYTFg=;
	b=ve5ruoFm5K4RD93O5juCUbksWsu0waT13w5vXqCPuKhqb/OLjeKTWSwQ0LbZuytQmiwS
	 oEytKWlwhaG+LxKgxc99WDIDN9zbSsLur9+ktKEvbVuHy5+Eyvwu47ko+spCtcZcYw1Ci
	 tHJJQtJxVAZ7In2ZRjFzH7J53y+yP+ThWz4v+hOJowSgw5wpEdwyF1xLvHKnHbf+wReSN
	 omS+sWBoyWC9781kBKxX2+IkL3+aaNeApqqad6ZGPWa7bYE3K4xIGmsxh9Q4gIjofMjxx
	 N5TJ5aLJYz+/NwwuqzGmDrXhsYmW5xkKI/hCk1aoSJfDHphwxI3h2BRMP2YKWiROAKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O3PmX1VL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BDPh9ozt;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07960A2623
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F07960A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O3PmX1VL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BDPh9ozt
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ7ZhGj3717954
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YDKM0GnslWm
	0swyMpWGTkx9eij2uqm5Ft78sdozYTFg=; b=O3PmX1VLnG968TtC1UlacMdd5Ag
	pC639/lanCDVFCRDPi5IxEe196AXpb5p9LbHGaTd1C7PAFXv7STeKPw2jAL3LMYE
	gxITqjGqC+gzlXc8i/MvTAmCsMcyLJ8HLRriGIk/M/+7dtcVcdjhzjkvyDZWmtJO
	oyMScC0eXhwBGSCm4g8L7pfyzzVbo1KXtWGfvR++ORuRvQtnXwchZHPeI+kFhMBL
	J6n1HvfSzCDIDuDEzkqQ9XRWgf2QFTQuq1f+Ujl3VFHEp86LKspiInDANeFe8jkH
	dOgIqFBjoPNFpnFjA0YrA1mAHj3axF6iyB6aSBeyPN9yYMzmQqNBB89Yscw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1vv2rkpt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 09:47:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934963b2bc0so386044285a.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 01:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795081669; x=1795686469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YDKM0GnslWm0swyMpWGTkx9eij2uqm5Ft78sdozYTFg=;
        b=BDPh9ozthZntHDMe5PrqBFBcWLQz0Yl0s7GnxzhY9wEFId7J62z+2MPv/k8UE8r1kA
         QVBzmNszFcxpVyAQKZHqtD5EFKXy38+j8OrZzU4wkvDkVhFjnsfsfbuX/KHHYh+IHpVV
         PM3MdShy9aUYGlwqpef052WJcrOZUWEppE249aafxUJnQylNpddk44BIHx/f1OMCPmdd
         QSBt1Sn/MvmCU0PiinKjXmJx6TWl3EKrKuAfKe2raLarLtgCNfaJF+uzDIuRqQZ00Uhj
         tvB+E8no+FetzXp9qDjmnAA9yqcIZbqFB0+5XGk1ziD9MFW8kt74N+zLf4fN8kcvtksp
         4DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795081669; x=1795686469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YDKM0GnslWm0swyMpWGTkx9eij2uqm5Ft78sdozYTFg=;
        b=amyLSGvo+owpNFnc7FY1xPtHVG/CwylPA4YZtff3vPJTI0xpNKIbUr+VKGcI43pShW
         baNbegHIVUFZYWpzPodtJQn/SC0rBlx4Rm9geOdJI455K7pKKQQal9hK7A3YOlVhQvoG
         tXmvLBF0rmYGpePJrTLAvVKxkwCqtCUhSUg94xuNpHv7iHGp7Jrk9H1GGjIQ/E+E95U1
         PSdMJXISIZg0ACVh2NBVf6e25pZkY+xCaJlNCDPkDQPHeeDzdYmufHWugCl3ltBdX1mi
         QZPpyckk/dhjMOVKCBVPs2Fy0MKc/Pc0sqlDVI87hZ1+/mVpIkgf+tOksjOHpot3oRMc
         MvtA==
X-Forwarded-Encrypted: i=1; AL+hErGDD/44ikGNoJxnmrP/cms8dBZvcxXodI0PksvxLhoc73sKiG3qwpIGCzqDtr5f7rv/w4Rlm4U0og==@vger.kernel.org
X-Gm-Message-State: APuU4Z8/ouM57uzTAfW+WDqfr03vUctZDYHsgrGQssj5KR6klV0YTAaI
	CaXjq6Nkli/LNKWqGCyzv15QN5MTKRbqhtbIo+Q8zrdYZyfZAL29dz5C+trQur2aScnulmCc20O
	ksICp7cki1Y4YptY6CDzgI8D2HEKt4EYSgVJL+VB+oKeUsQWmzIsU7yHXYacp+Q==
X-Gm-Gg: AYBFou1BKzBJvPOOMGWWT+bZ4ThNXLP9ZC6HzBJgg/LlSsaUXJvXsRhYsDe3dnLGyEY
	zLx+qmwCpK2FBAr/18QvI74ehy10OaifsZqrwnr07qEjljsVwxwgSqIguLQiNOPX0U/Vifm8bYp
	1ckYK1HUfhf1GADArF6BKFLBYBiiQ2VngdSamtYLXwm0wnPASo/R2NISrqB+DBqRbakM1Vnncku
	K71A+N1yM7XvDHBKkA89mM8GspfgasCjx1J+i3EbNpQI6yNNAjiL1CEv3BxKtOVsEuXhp8/afxA
	wwey/5VeRwo4nN6QuUj6GxIJE0FGo8c0VVHiQkvKkkPPaRumLvzhkIESiF2+VGb6fkVK1//FG8I
	lTFIc0FQySNC8UehJ7pMvNPhc2eEGTd/tKaB8/CWGh5aWEUHIXyOP82w6F7yedGBZIeMY4q/Td1
	aq
X-Received: by 2002:a05:620a:6f0a:b0:93b:c58c:d3be with SMTP id af79cd13be357-949995ab389mr889380085a.37.1795081669260;
        Thu, 19 Nov 2026 01:47:49 -0800 (PST)
X-Received: by 2002:a05:620a:6f0a:b0:93b:c58c:d3be with SMTP id af79cd13be357-949995ab389mr889379385a.37.1795081668831;
        Thu, 19 Nov 2026 01:47:48 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d162:32b4:dec2:8b31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656c1145esm9652992f8f.52.2026.11.19.01.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 01:47:48 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Anvesh Jain P <anvesh.p@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 11/12] dt-bindings: thermal: Describe multi-source zone aggregation
Date: Thu, 19 Nov 2026 10:46:53 +0100
Message-ID: <20261119094706.3439040-12-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119094706.3439040-1-daniel.lezcano@oss.qualcomm.com>
References: <20261119094706.3439040-1-daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ys1clFNBk-nRgmikAo7D3gAVgIYDOX9f
X-Proofpoint-ORIG-GUID: Ys1clFNBk-nRgmikAo7D3gAVgIYDOX9f
X-Authority-Analysis: v=2.4 cv=ZZWIpcVA c=1 sm=1 tr=0 ts=6afec5c5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=MW378T3nY0SQNsI_83wA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX/2cfliXeuVxM
 L6C3sc9rFQ8U/2Pzp1tgKEs2YzfwramcgwmpZ/JLVGf/+JJky1kdEpLU+lHzmkyRvE8y6rWmqIx
 t4QNIvTA9bBEH2Ec42tKBI+bFeLJFK8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzOCBTYWx0ZWRfX79T6LBPuXDCQ
 mU0gpgUXbpuO+tu7XlNrscVgQx/iuy0uNHGI1I4QCKcH0KappCY7vqWiWBoCtiI31TMphIFj9dB
 lFmuntVPoLRD5Kf4GpNkY/plipfxza6Y4ectzp0dBDkvT/V6gssNTuicIL3xP44zmOlNJjYnA62
 /Ev4iTL/sDJuC5veoo9OX7FPQcnhy0WxQ6Dl+8RyKJKhvsCTIGdErUd6gT5aOLhfXrNDQK/uZBf
 Zcheul96E+VfQ4jtNQU+c0uvgfIGWLan254hZpvb0YVTxc2YqRoeOedZA2XOC4nwPdHD2al3ByC
 tfUfIx0sI0j1SjyVhaMHAMorDxzFvXSziwQ2AbBkEqNOSDhR2PRmIK95fpKZoUwhk2uQoRxMy7G
 xeYMHs8w3tjFNoSLnCOuAGgEbhuU96cSWxmfdyB16Ghyw7HoVEbVUPE2cUZUopcnFVTbgGqPnNJ
 VKFuLd8Kv8JQkp8hlfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190038

Allow multiple hardware thermal sensor references and associate supplied
coefficients positionally with those references. Use signed cells to
represent existing negative calibration values and aggregate offsets.

Document approximate averaging when multi-source coefficients are absent,
with unity gain for one source. Explicit multi-source multipliers retain
the unscaled affine interpretation and are not normalized. Require
nonzero explicit multipliers to distinguish supplied values from the
core initializer default request.

Preserve existing single-source sensor-specific slope and offset
interpretations, including zero values and driver-specific scaling.
Add examples of averaging and explicit signed multi-source combinations.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 .../bindings/thermal/thermal-zones.yaml       | 46 ++++++++++++++++---
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 72e419124f98..10cf1fb8cb9a 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -95,10 +95,13 @@ patternProperties:
 
       thermal-sensors:
         $ref: /schemas/types.yaml#/definitions/phandle-array
-        maxItems: 1
-        description:
-          The thermal sensor phandle and sensor specifier used to monitor this
-          thermal zone.
+        description: |
+          A list of hardware thermal sensor provider phandles and sensor
+          specifiers used to monitor this thermal zone. Each entry uses the
+          number of specifier cells defined by its provider's
+          #thermal-sensor-cells. Multiple entries describe an aggregation of
+          the corresponding source zone temperatures. Thermal zone nodes are
+          not referenced by this property.
 
       coefficients:
         $ref: /schemas/types.yaml#/definitions/int32-array
@@ -110,9 +113,23 @@ patternProperties:
             z = c0 * x0 + c1 * x1 + ... + c(n-1) * x(n-1) + cn
           where c0, c1, .., cn are the coefficients.
 
-          Coefficients default to 1 in case this property is not specified. The
-          coefficients are ordered and are matched with sensors by means of the
-          sensor ID. Additional coefficients are interpreted as constant offset.
+          For multiple sources, the first n coefficients correspond to entries
+          in thermal-sensors in list order, not to provider-specific sensor IDs.
+          Supply all n multipliers, optionally followed by the constant offset
+          in millicelsius. Multipliers are signed nonzero unscaled integers;
+          there is no implicit divisor or normalization for supplied values.
+          An omitted offset is zero.
+
+          When coefficients are absent for a multi-source zone, the temperature
+          is the approximate arithmetic mean of the source zone temperatures.
+          Contributions are distributed as evenly as possible in source order
+          with a total gain of one. A single source consequently has a default
+          multiplier of one.
+
+          Existing single-source hardware zones retain their sensor-specific
+          slope and offset calibration interpretation, including signed or zero
+          values and any sensor-specific scaling. Their default slope is one
+          and default offset is zero.
 
       sustainable-power:
         $ref: /schemas/types.yaml#/definitions/uint32
@@ -339,6 +356,21 @@ examples:
 
             /* ... */
 
+            // With no coefficients, use approximately equal contributions.
+            skin-thermal {
+                    polling-delay-passive = <250>;
+                    polling-delay = <1000>;
+                    thermal-sensors = <&tsens0 1>, <&tsens0 5>;
+            };
+
+            // Explicit multipliers are not normalized: board = 2*T0 - T1 - 1000.
+            board-thermal {
+                    polling-delay-passive = <250>;
+                    polling-delay = <1000>;
+                    thermal-sensors = <&tsens0 1>, <&tsens0 5>;
+                    coefficients = <2 (-1) (-1000)>;
+            };
+
             gpu-top-thermal {
                     polling-delay-passive = <250>;
                     polling-delay = <1000>;
-- 
2.43.0

