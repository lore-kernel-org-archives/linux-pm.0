Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258762F7AB0
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776622984; cv=none; b=uRLVlPzgFrXThUyBoOnLmYlXyRy2Gt9Gz24NednPyi/sl4e1Phl7YBLuL8l8ggaiXF2littWHub6JNR8UdtpUXOavZY57k7xkyLJ2qgusIZl25xIFMl5rQLyIGdFWEYfwICHCCIW5nyWRL3MFduU5/6VPFgXRXKoyxCHOPc/4wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776622984; c=relaxed/simple;
	bh=WzntAKrn3SE/S0P6q3sFoaSPnkduyAfvojxfo8h0D/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0mbB2MwsHYVONBf3nJ0dt7huxXwtB/0mSdrswZ8sLqv41VQwyvIs33s81TtlKzVmBLPEtzLVKM6v9o9N4EtJoJ1bT6tJBMP/5cxjNsXeQaso6xdq1BWL9FoTZjijOVmA85IuU98kb1S3HdPP2XpENckkYTXc5qzk9hlOEQmIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hgkh6xag; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KyJZ7Ljn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hgkh6xag";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KyJZ7Ljn"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JAuGiT1977967
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/O0gxmkDAI9
	OIMx5SPRWuVmH2AlYc/ZdPsgTg3SpEAo=; b=Hgkh6xagQ7VuzMo95XqD7wXM8EW
	RmfJQJnGYCg+zIr14mvfwXRiofcPUgBcJT1x3V2T1HuMu1bZ/9I4psqEwzlv9cPz
	k5lF9nwyVVIpQhownNXkMiTWDzeQh6OfHpte3eXiJ70mLmQZG39C0pfE/Ymj/DnA
	qCk+m/SiN2hpb1hrNRE6hV4JIyPgQzBT0ZPLZmIgH9emvNkFE3sGnYKqxKEz8u21
	7r9/TVICyhptUNTv/Hq7X8CG7gkufNdf/lP6iP7XlctZY+yzuYNg1ic3OQc6ekf4
	FeN9Fk+jGAl0p3nJor4Lm0lpa3KAQJy7Iw20yoya2PbXgkVNJkYkwLT+LuA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm388jxgr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 18:23:01 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8acadca1ac4so69844476d6.0
        for <linux-pm@vger.kernel.org>; Sun, 19 Apr 2026 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776622980; x=1777227780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O0gxmkDAI9OIMx5SPRWuVmH2AlYc/ZdPsgTg3SpEAo=;
        b=KyJZ7LjnQdmhr5hkI2I/xDuUZU46NZYDgRnSq9MQ9cxe+0eDZ+p1shMNvRDkpWDj+C
         aQX4lnpT45I9wx3/trQ5ve2/6W1l3F0J8nu+LcMxVg3ICAbvHMdQhDS7Rq0JSzhaR0Ie
         4KzYEZXfIjG+YICK6lzUPuCkJNRXEZfuRoBmhYrKPEfYir4ybItFviniqfrSyNmZ3nO/
         54HY6tKSzd+rcEAgbVqkd26+FGqaWpSqUaGIYkgCF8W/moiSHKKj0uVcUd2iqrozMTrE
         +vw8fpJbaoz1iZgJ0XVMER/Rfz8fadMLMkIVQ8ANtkuYLCtKHnFF0wHfFfnNtxjMwqyM
         55zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776622980; x=1777227780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/O0gxmkDAI9OIMx5SPRWuVmH2AlYc/ZdPsgTg3SpEAo=;
        b=Qw7A+mO6VDJOu6u6J2Qmk0tAW5ioor0q/qaio2z2WXZkjRotM14qh4XHXIbEpApHyU
         Jae4hKPFp0LmGw0CgRnny0GrINShqqgADgHV3IGCHCfqpXlrfvQR5lWLF5oSh64x3Na3
         T5pgtB1xbTALdgobci8ZwxUr2YCAma7tRiKfahc5GJobK+jEc1udwMWCX3YMpU2zWZub
         1Li5w/4WG+hLPE8rUK457t7zuXlnn7GUI9Z/H3FQ64qTG/QA1AII9GCADJZr+IGFRnT1
         oRWXESxtsfl/WveXnuOYHC8rnBwBWWVym+cEzVGgQLr+KwXNnxhyfCt6OxDOLYgyUebL
         BH2w==
X-Forwarded-Encrypted: i=1; AFNElJ9isJJJdJqtI7FR729/lg9GuXDh+FjxJwDTXPXXjIYl0pUGy1wYuvIPiCJc8WhEVkConlLIUEhTlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzdqfEvkPQRyQztAoOi/va9NKOB4bNg2+w//54ZIpauqQF6RsK
	d3vMX2SIrG439AlH74rip0WwYtSeZ9gDdG8JcbGY4IsNV8k0GeIqs5HoEea8324MTZzI60APFZ4
	aPklD/9rRnKs6I7RqsWuE66en4qCqMDepwqt3n1lBtEDjN+rpY0PpapjCS6wZVg==
X-Gm-Gg: AeBDieul7OZ593D1kFG7ctA6wn8ZqG5/Mtm9qrIRUTUBCQRsvhH/2rxSxj4wN5VFWe8
	de7SQRiOsSuOJvyvhUZ/t7tCkmnxIfqFRTYvhgxSIVP/S9B/lxocLoctDS+982VoUOgGt2g/33t
	Fei1VgsnSBhf50OzIFknwYGEce1GPXcFf2/mHri5keuCtg5zDVzBRddTFwgURr7nIcKdR1doJ44
	3vNR5s5xsUAvH7l31SaEY7ce/XO4l9IcrXu0d4VJs7BIvbjSyc8iNkuRShPYFmjInljpLGfgjuY
	4H5EZJoc31BDGbYQK1mTvAak3kxDctAAJizXJ6+Azk1S/sxlFeFp1rCbwT8WGQO8uVnbrijG6Dr
	0CsB5V3He3yfq2fXGd6oaJqgmoZuuFIL1vtByaAeSj+MBHEGPIseFSl9UHLjh
X-Received: by 2002:a05:622a:a05:b0:50d:dd3a:73b4 with SMTP id d75a77b69052e-50e36c49454mr168590581cf.37.1776622980436;
        Sun, 19 Apr 2026 11:23:00 -0700 (PDT)
X-Received: by 2002:a05:622a:a05:b0:50d:dd3a:73b4 with SMTP id d75a77b69052e-50e36c49454mr168590301cf.37.1776622980036;
        Sun, 19 Apr 2026 11:23:00 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm25723070f8f.37.2026.04.19.11.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:22:59 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
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
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Subject: [PATCH v1 14/14] dt-bindings: thermal: cooling-devices: Update support for 3 cells cooling device
Date: Sun, 19 Apr 2026 20:21:58 +0200
Message-ID: <20260419182203.4083985-15-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
References: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GthyPE1C c=1 sm=1 tr=0 ts=69e51d85 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=GhBi0EG2tKjOyko4s0MA:9
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: ZtOO-sxn1ZXeONqM9sT11GDSNcbItIPF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE5NyBTYWx0ZWRfXwm7XbXC9Oewh
 zQED0IUHaUUhf0ZDv4LhQeXgfncIVUw47Q486wn9f7QXggy6Mc5AlgLfKtip29IaoqavXH1SBSo
 7zqXUGRMRubueVgBFHVW87G2j9fm/3OHuKIIJods4dW8MGj/IPH39nNKNucEGidrU86DjA9Z3va
 +oCJgOp7wksARFWUSTy/k8n6mxcPs+j8kX/CaQzO1sM3PpuSHKzY1jxWC6HhscwzurExqJhqafx
 jE0zCYsQwVpu+Yt+TEd9WCYLWsJytCWvLbzn10Ckizd+rUTwUfuh7ws/D/OojsGwQkZyl7vjzxP
 FMAYdjkSNnxjs2q54H750zrlqsWJjWgDW/WgqfWICQGjL59Za3eDTxfcEM9C45DwlJ6PmOtCjxd
 rKjhbiDGvt23OVNzbSha943DlyiEPBFlyO0SORQ3MYBHoNIXlpekZ4NJd76IDmWepREBf1fGMvh
 Li2YQNaf38m3LcRk00g==
X-Proofpoint-ORIG-GUID: ZtOO-sxn1ZXeONqM9sT11GDSNcbItIPF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190197

From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

Extend the thermal cooling device binding to support a 3 cells specifier
along with tje 2 cells format.

Update #cooling-cells property to enum to support both 2 and 3 arguments.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 .../bindings/thermal/thermal-cooling-devices.yaml         | 8 ++++++--
 .../devicetree/bindings/thermal/thermal-zones.yaml        | 3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)

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

