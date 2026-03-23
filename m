Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008FA390217
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262752; cv=none; b=Bp/m4/oPlLx/2830L+ayctDpUzu2k4fhR1T9H6vVe2hImy2doWJYBHpU4iMCRmSNY8ZIQb5tN3kzgpF/WWyhEr/GEtViVMpOigJ/gRVTo6CJwp4M/lok4PZliRC2uLwCKZ5DATGXsiby8npPH4vwldUvbNhtUBzzS/IKm8pVdIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262752; c=relaxed/simple;
	bh=XOmGZuBRriVVUK3qirYMAcCDKy2pW2llx9LSWkCYTWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fh5EWx+jaWu6WzZd5cA66giesR4+5RvhGvQNHx2rcsKR/XL+Lf9pDhz169lu43Z5Kmxm1tILLOcXTFKUyNWqOK62MayFFV6g6zSkESx0MJ4rbkTowtR1HKBJln3AXfCwDG7fmZCuBgzH8zwrB5utXsNl/g77phFcA9uP7aGfUfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FzK6ityB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B+kYMLWp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FzK6ityB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B+kYMLWp"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NAJpr21584563
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x9qY/SZDZxH4rkVKgaQLjD+bDNqjcwS6vx8/+OtCudQ=; b=FzK6ityBIUqI0Awf
	8JtL000GtqG6x7BWFhXOs0kh87a9XELjTEJRQyMr1qRbYYRxFn1cZf5FJi1X4pf+
	bZ2YG0yLzwwRTkX9DWQa5XfvkC4khHfjfrji/3bG9gVIGwdd8wyG3siJ+LjNXN3H
	FVSHusO/+lB3CUsNcdR5kwu8b8DQOSb4rT2usiVUASjXx2ibtyd1QNlhaE9jQIYS
	1Yg5nlHCWU5yKywj9pr4txi2jnKPHCoVMvh671KUEf/2sOhRFYRHd9IlCpMlKFb2
	W+4eyE/FoLAC1XGGXWKxnctH4wClLeynhAu+anwvQ6z3kprXl1gSH7jOnOH3klwe
	KcDXjA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jng50w6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:45:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b0565d77a6so231895ad.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 03:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774262749; x=1774867549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9qY/SZDZxH4rkVKgaQLjD+bDNqjcwS6vx8/+OtCudQ=;
        b=B+kYMLWpUohtXYY/UpjGx1py5ObN6ZhOEqTqEuzExKTKGEnLxQWTUEgfltGMo7lVXo
         IiEYaN7Xt4xWQURi1P1nVPZRYQmkJoYvE+mSl4/P/X64wKpzeL3Q9ELOebfhPoe+ZdPs
         jnn4GXcnSFf2ocgQk9I7pHcTTN7qT3GgVMkEXday1PMUYEE5ISJjissruF06W0hUx3km
         Nk3oqrX9MlzT6CKtyFq8hUmoLoI/HdCK2PPq6qVP1V+YEP95Z+7vzCVuvBehO0G598ql
         x9ivqYgVy5HMxjQqvjkqr/SV01FvUc83CrZKH92UxvprIfIKuGD4+QcPpTCfkh2q28ie
         0ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774262749; x=1774867549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x9qY/SZDZxH4rkVKgaQLjD+bDNqjcwS6vx8/+OtCudQ=;
        b=Qg5Ucifp6wzOYf/oWN+blM5aWJoYSiwVllNnrY9gP4/tpFlgQZ+oAO+KvNCavk55gp
         VNMoUEllBjKALqf1/VYlCHEYjzekfGdFCM/CVzOlzP6pq+/PVB73eKw5HDNAVJS0uQsf
         6Gk5/u+rjaz5vHeHT/sbSzmxJbQXLQg73gRcSqKpr2bWHKponeFn5ypqebFUuZ0lqril
         vmfW8dCMCaK04DcrEBQqUYUuwIUa7VQaTBy1wrcPwT2q2VsMdkTcDlvlUDRHpK93Bjx9
         Ph6u3/w1uwt55hIJ3rYLLK1/f1GlT7idgHAKyTt3BtZ84TUoneIrkpQfaUmSrm4LyRTk
         DWfg==
X-Gm-Message-State: AOJu0Yw6InPgRhbctxnnUGQw1/Y7vsjRr6HYB4rLSVzoff99zesaK/NN
	o5vSCn8GlvAzszqyX2JHxFkmJ5sQJNjFYHeRZyhmWQ6Wt57LYFOHhptPFXirOoIxZbX1LIbxZEI
	u2xqGUSVPd+Ujvb9QT2u5mBrMozkEC0UG+6Sl7O2Cgyl8X/U1OIjChc7KAzkF
X-Gm-Gg: ATEYQzwfvybJRy75KZ5egRQ367bsydiGgh5v4XFIqKb5Q15GrGfJXqoXfArCDnxrlIZ
	Lsml+iA3xxC13jNpTxmeSXZN2O9ZAWcDUbBHffXsN9nSN0v/Bx1S1aBgwHp8XhjJ1cXSAOlLaGC
	N8HQEqsQbJHdQwVyquVLwYdjO1OU83ExhEDjKTGXVUKMKSps7QArPZSbff3na3pVwjbuEB+PZ52
	32B5CjHtwIMVK6IyTJ0nxWWGvDi1FsmxCNd9U+XrZ59lUIpTHAB4TWq2BVHOTGCvSCsxItvxKmk
	uNwf3cvJVs/N24itadVBkMhSYEsE2Uu08LRVwKHfU0VsfsOnbcdg5LYA+VCmCMbaPlqhRdqYJxg
	37pm//cC1hPF0xURxK8gbc7ltWlc/qM0MVfIabH33YK+8ccv86Ac=
X-Received: by 2002:a17:903:2f84:b0:2ae:c907:85e6 with SMTP id d9443c01a7336-2b0827d3312mr97971515ad.50.1774262748833;
        Mon, 23 Mar 2026 03:45:48 -0700 (PDT)
X-Received: by 2002:a17:903:2f84:b0:2ae:c907:85e6 with SMTP id d9443c01a7336-2b0827d3312mr97971235ad.50.1774262748349;
        Mon, 23 Mar 2026 03:45:48 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08340c2edsm123454225ad.0.2026.03.23.03.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:45:47 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 16:15:15 +0530
Subject: [PATCH v4 1/2] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-add_pwrkey_and_resin-v4-1-abef4e4dcc3d@oss.qualcomm.com>
References: <20260323-b4-add_pwrkey_and_resin-v4-0-abef4e4dcc3d@oss.qualcomm.com>
In-Reply-To: <20260323-b4-add_pwrkey_and_resin-v4-0-abef4e4dcc3d@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774262738; l=2559;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=XOmGZuBRriVVUK3qirYMAcCDKy2pW2llx9LSWkCYTWw=;
 b=PfNBzlnpqF+33vFOhF2L/U1lVacTfTKkSBrfBepJL+6WCRP14AHvH8zG+kdxWvpHKDHBO8hDC
 B/fAnbv3AadAI7lwMSpWn4BT+onoXvmfQeu7KqIZcowx01PCXUou6gw
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-GUID: BLLrR8BT0A1nxjdUS4QSSXRPq-H0b6eK
X-Authority-Analysis: v=2.4 cv=Q63fIo2a c=1 sm=1 tr=0 ts=69c119dd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=w-kehPg8drGOkSzOkD4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: BLLrR8BT0A1nxjdUS4QSSXRPq-H0b6eK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MyBTYWx0ZWRfX3cABKIgF6PkK
 qiyMGoDhXW73ORemrBquwAkIpcPdAxYlWL8gdAIfvjMkPn79sWk6vch7AhdUT+4oDDLRXdWAeHd
 SpBDnKod+He1jX4UKi1vOu50I1Jj7EG9znSvRA0A9t27wsVD4WLflmLX7YQavqf00Ki1FFDIGPl
 LkgU9cPUvHSnBx8+YVTztp0zGzdU1XpVHPM+JzK208HSvJXWpyU+bqiTv/bxEhiXQEyy8bmlhX1
 U6nwLqinzACva6G6cYr2GBY1W2b8D4J1BVGYZj6u4LaQhDePtxF80jQ3UdL3rFPKgyxLgpZCuQc
 1AiCHMTK4gRhAMWqAvQOAZk8on8onuf3FwV8yk+EjKFS7jJv6Wj5zooP6yLcWMDxdVVh8ZXG3Hm
 0yUMH7KeJwtYyEYu4lU/zDKertv1bC+H//9TR2u0wSgKom2uwgIkxn9LdsAe4+J4JXT8zxg/iEO
 QWVmpkQDwU7NmzX0ViQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230083

PMM8654AU is a different PMIC from PMM8650AU, even though both share
the same PMIC subtype. Add PON compatible string for PMM8654AU PMIC
variant.

The PMM8654AU PON block is compatible with the PMK8350 PON
implementation, but PMM8654AU also implements additional PON registers
beyond the baseline. Use the PMM8654AU naming to match the compatible
string already present in the upstream pinctrl-spmi-gpio driver, keeping
device tree and kernel driver naming consistent.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Changes in v4:
 - Remove the contain for PMK8350 and new if:then for PMM8654AU as
   suggested by Krzysztof Kozlowski

Changes in v3:
 - Update the commit message.

Changes in v2:
 - Introduces PMM8654AU compatible strings as suggested by Konrad Dybcio.
---
 .../devicetree/bindings/power/reset/qcom,pon.yaml  | 32 +++++++++++++++++-----
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
index 979a377cb4ffd577bfa51b9a3cd089acc202de0c..2a5d9182b8d5c1a286716ab175c7bb5e39b334e0 100644
--- a/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
+++ b/Documentation/devicetree/bindings/power/reset/qcom,pon.yaml
@@ -17,12 +17,16 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,pm8916-pon
-      - qcom,pm8941-pon
-      - qcom,pms405-pon
-      - qcom,pm8998-pon
-      - qcom,pmk8350-pon
+    oneOf:
+      - enum:
+          - qcom,pm8916-pon
+          - qcom,pm8941-pon
+          - qcom,pms405-pon
+          - qcom,pm8998-pon
+          - qcom,pmk8350-pon
+      - items:
+          - const: qcom,pmm8654au-pon
+          - const: qcom,pmk8350-pon
 
   reg:
     description: |
@@ -100,7 +104,6 @@ allOf:
   - if:
       properties:
         compatible:
-          contains:
             const: qcom,pmk8350-pon
     then:
       properties:
@@ -113,6 +116,21 @@ allOf:
             - const: hlos
             - const: pbs
 
+  - if:
+      properties:
+        compatible:
+            const: qcom,pmm8654au-pon
+    then:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 2
+        reg-names:
+          minItems: 1
+          items:
+            - const: hlos
+            - const: pbs
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>

-- 
2.34.1

