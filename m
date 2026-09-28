Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B30331EB3
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575829; cv=none; b=mpHRummzexzXkXWvgSrt0K1ea3ffz3Nn2J0Mz7I91JBirBRcpJ6jtm65xzCBobcPuMU3RfwEebrLTJX1YdRs6uQyh7AMImg0fqZYhBh3md1vrh6lw40nfZDWckcN1Q71ybxOQW0WN+WTfEidqfDp0gk972NTvpF7cUGXsn6Kojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575829; c=relaxed/simple;
	bh=X9KZJr7kgVXbU9Bx9ClV9IK6kpd8uGbGeYXDcH/AfOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q8OM/1ozhhn0T4geOzwYO3FW+jHuSGqa0I3uqhD6PuFrq7GcjKVVD1vTdPDxRzNZNC51IUnjQzC+owIAkhiw2dbtXlnYe/HpLr9vScwkd4RpD076jT6ZKKnmPNX3PEPryrbia+4ZIQNjmthpA0S7SEXtYsiQ9lJOhLenlZ5wJYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EhrrnYuX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NDgyjOMw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EhrrnYuX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NDgyjOMw"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S5XhKb1666738
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y/CZep6ohxgA4WGMpffaOg6jtKktfc2ERETEgC6f1UA=; b=EhrrnYuXXGQSe2j5
	ZBmFs6ajGq2VD1QuqCFPMgBGBsRoagRPlPtUAXxu3JliojS/AedzfixtldV4Azor
	RqkVenio3PDtmQf/A6nrgwIB2WUqVIxOslanNkbOZAuMQCxd+2Yf03XJKkqJuFm0
	ADQyM4eHLa7w20xQFNWo8h27Q3tEmBNtCOkWQXU6PG3eRIlbqF3wTTAfUuvuwljT
	Fdoq13YCjDhYoOPX9Q0W4qRZC8PeQ7+gF203bDwZd6D6EtVqZ4HnM6uNcHwolyBT
	kE0zzfbmqi3vHg/SkfXO75AzzsruuhjLYodMbZzcE04i5UP/dLhy09DOawnjEIV1
	lBjOug==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj6t03rc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 06:10:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39533bb224cso4056753a91.3
        for <linux-pm@vger.kernel.org>; Sun, 27 Sep 2026 23:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790575826; x=1791180626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y/CZep6ohxgA4WGMpffaOg6jtKktfc2ERETEgC6f1UA=;
        b=NDgyjOMw8z2G3pttFna4sW3MYNDbkQOb0jQE1M07hIIXUgaG6VmXdt75nRPruvvG4P
         vVLWmej23q39xDOwxGd6xm0gHERt/NW0kRIqu+9xnDgobdeMYJS0hP8q0wKihdmDZvnH
         Q2SaYHQfprEKo6Surl28+YO84tna3M4H+0WZ0F1aElrS8/xxgZ3rhDiXgSvcAD4pVdPi
         D8LGpi0kgUGyKzaDpDbR7LW7mHB2zExDym7gEDavFGGBmNO5gld9NIVnZ4VQgAB1ttYi
         CQo982ac0UUUPrzR8aS9m8aji+u3+Y0sD43BWygFH1hQBoFoGdoCxNtYe2nDV3U7yMWz
         svsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790575826; x=1791180626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y/CZep6ohxgA4WGMpffaOg6jtKktfc2ERETEgC6f1UA=;
        b=i2pdvkWc859JtFszud/iI7zgUCU9By2azTYHm2oVsAARjXPoRzwR3dHytlNqfY4YiV
         rjTIHGomTrQ6seKb41K164xVUKie1DGj285ozecvMVdlKqT2nMeIzinfmKAotUzc/pLb
         X8RqmnnvqP61CNi5f9mxto7xAwSum9uT8W9VAaeipQwoTsIjRT/gBFUuPurVoLl/cLZR
         rL5qQwinwrStQhKrh1ZauUzgQKZbZ6S7vWI1QDfNYHFPcSUJmCSwsERese34f5gDma5A
         NxG5H4X8FcTobw8oJ9tETIqyqE07HfD+P72dZjPXtRveYqa2KTQoMw9/yBS+gfN7Bl4z
         7BJg==
X-Forwarded-Encrypted: i=1; AKwUvBySwq17hi6pgedJSAgKbr7DPkXfQuvsd2Fg4YVGjg1faMFSFKDoTTXItOm3VXU4ukKjoHMsYfYAqg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK50HSiCqwX3DDkKzapPr4D9FWUilTs8A7ih++PMANPoANCyKdO
	XrlTryxwVGXGm0F9bKXuKXR8GV+IFaLbSeCZBccfbR7fnL3MRyRySjUcA6CJPBaWY0tTToL2Hfk
	RsugxT/N+yZBOW0CSMNJSWoWgGYpyjVwH09jANVBucuCw70Pfmv5kHX1x1Un4fA==
X-Gm-Gg: AYBFou0JXbo+Iat/5wscLQPRIPdve5DPHFwpdcoraX9AIFWnA5EFzqsOyf2tRDGoc+X
	hTwO76j619pINPIna/muUTwJU7ePQl1/xqNXN1LpdtNJhcJR7a+MsUUTarRfhzW0HOJJiZXtu1s
	eXkbYYQKbGnTRCbH+ndKQSy/Sn57X3nyI7GSPiXdtp+JWtQX0wMFBiCKYuBOxBOf1iGJ0NmB8Cz
	1y20E9iJL1SmZ8/EApgMFLT+U3o9zmtH3n0NNuL4idmTp4fq1iSwBnJrXohZzn0AUrS1VzPci7a
	9r8XkDOzJ7ltx3ER1MwdIK8PDJqkTovdz02YiCVZLOrSGxsdjKY6bfLLMmCfp/qbuuuMYvmlNSB
	kLhVl2OXXr/cryyZ6cPAhex26Mxyds/aQ+5LY
X-Received: by 2002:a17:90b:2d8a:b0:3a0:b959:4472 with SMTP id 98e67ed59e1d1-3a0b95947cdmr7634974a91.41.1790575825519;
        Sun, 27 Sep 2026 23:10:25 -0700 (PDT)
X-Received: by 2002:a17:90b:2d8a:b0:3a0:b959:4472 with SMTP id 98e67ed59e1d1-3a0b95947cdmr7634923a91.41.1790575824896;
        Sun, 27 Sep 2026 23:10:24 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm20040846a91.1.2026.09.27.23.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:10:24 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:39:17 +0530
Subject: [PATCH v26 05/10] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-arm-psci-system_reset2-vendor-reboots-v26-5-b24e2348e8e1@oss.qualcomm.com>
References: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
In-Reply-To: <20260928-arm-psci-system_reset2-vendor-reboots-v26-0-b24e2348e8e1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790575761; l=3059;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=X9KZJr7kgVXbU9Bx9ClV9IK6kpd8uGbGeYXDcH/AfOI=;
 b=5901wfsiP2wM4LURUGsDnb2W4ctDY1mmhAlaROpftYaWoGFdJydZj5l5XbdLqRnvkbZJ52h9Y
 kCUyy0nJYo/D3YQUokIA/EkT/qcy51K7GO1xEIEPoTFPL3VGT50qV6r
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=ssWsJFX3OM9pkdoe4+guOfGPaulHOFt0GVnVlB6on+s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfX4aKoQYL+j5H4
 Hj9On1ZZIi75SPa9RMXIbUEvlSDAvKI4+CZKERR8UD5gGZbfKv7+fdh3MmTfEyBdErCcm+J1qMC
 nEtbz4rBJnMW9PtEFBoZd+INusqe6Q7wss7iGrxF8VwZznyUbXUJ79Q7TecX6hGPutcozKUu8wO
 rA8AX+mKDrjA3N2Zbpc9DDzdsnL8zjH+NVP/YtDV95UNUAq7p6/u9JKDlBIZvNQyDh6OTIcmzK9
 MO8/XxYZclTm6h8NUozE7Vn8+/BFI8yxfVZdptHrvbISXvG+/HXaFbHGd2fQ9/kNbl9OfBiCWif
 P/B1iMQWXjsIBogWPEfBg5oYkdaBnU4KgiiXSNcpu+oONpCiGk9eCzcJVIUWgiRWKVPtUHncOp2
 lakY9EIGoTViwifv/Jz9ganD6wpw+/YlbQ7LlAdbzCKkaMFYzSg2umfux+4QY4fi7vo9iVPNzkU
 0kZYJhP/NjKETL1SLMg==
X-Proofpoint-ORIG-GUID: tYHClvrzw0TQKYlHkd3iqsUj_DUud-uJ
X-Authority-Analysis: v=2.4 cv=dZkVTnXe c=1 sm=1 tr=0 ts=6aba04d2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=MLL7hoemGGfarhQ97J0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: tYHClvrzw0TQKYlHkd3iqsUj_DUud-uJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNCBTYWx0ZWRfX51yBMOP/oERd
 QCXsjP+oZhr8eXXR2jgemFa/HPXgyjRi1NgGoqrD+CuuCFUDXcqyiX4laReaAX96ZbcoftuI05y
 gWQUahPukimZUBYbT33/dYJLpXp3Nag=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280024

Add bindings to describe vendor-specific reboot modes. Values here
correspond to valid parameters to vendor-specific reset types in PSCI
SYSTEM_RESET2 call.

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

