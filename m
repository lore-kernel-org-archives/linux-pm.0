Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6C9369970
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311377; cv=none; b=Z9KRbqAk8g2f7iiNJbit0RUzZDx5gew1t9MktwPvdz1MgmGIl3HfSSMigCNn+UcF7bLguTLduzhP6YYF3MQDflyTJvBiG/zekeowOLeUwfv2K9k2R26FJEFB/boz+v9W+bbUNsyMSZIg6DfA5zQgEXDRxaSVNlK370HueSs42g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311377; c=relaxed/simple;
	bh=yBVN4FEHADdTSQ++LEmhmTEyByZ3pz1DEJtf2+BqO1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esUzDAWJQ5nFd75pkIww4dVjQ6wbfzqQ604Xh6zu8gMT5yRIT4pSuVQoMNCu/pm9GQyiJJ/4w0OLTSMCuOLAVpE6q9qdTaz+LMfh8Td82mAlYnbFHmTPdVdb5nOq1yWmAXWeDmnMQ3d2EOJbHnbb97jIhOUO7pETmjHoO1BEhzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gIabg0Fw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=akNrQzMb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gIabg0Fw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="akNrQzMb"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RHNqn2663125
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PO6gg0/IWEmCTv8xrfB/fKl5SzRNa5BhzNOETtSDJoo=; b=gIabg0FwLPE9SRzD
	3tRU9MsWqNjMpmEiRRi/3sk83rdVBYVO5cpgUkPZDn87Yr9f4IT3fEMVshLO5U56
	9BKM+gB23Fi4JYl+Z5msoS45PR1WyxNarhcke91MbRu0tRY1IZ0Jq9QJRRX1JZMQ
	G+1MxNiV9OX9MjVo/KLF1wncTKJP2y7ZaqRAWIRhMNvBzpVqgfWWxEKpNmLGX9wg
	slxAeFSw+5trK6XrLkcoDOVLdQSlGy8j41NlGT9NZcT5l21dS9jm3S6DSTSmTO3f
	X5jyMGYUFeFz10iuXd5WdNrzhuXJUKz3Q7OK4V5l4rcluTtswwGen0Z9I49CNEyc
	+IUupQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtc5n0200-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:36:15 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b24a00d12cso106647095ad.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777311374; x=1777916174; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PO6gg0/IWEmCTv8xrfB/fKl5SzRNa5BhzNOETtSDJoo=;
        b=akNrQzMbPhD7AX6Vp6RbVcbDEJqPbXRRzDJQ+iHkKs8lvdS6L7EGll2ku2V6aSl6bd
         gfvGSsaveJvkZLtvbxIvH5tO1Fof64nYIEd+/iOxeT484EoNNi21ibeDmtDYnG4qlNwB
         q8LdtsjIES0F0xJKiLeHlGNgLU02iuPQuFfILB+C+S54q3/T4LpU/+XOhwwNekGqAwF0
         XiNmfGDlsIWu1cBW8xlDXm13PCe46tmv6tNd0MPRpwzg1bA/gTCn1wTjW9iUv/17qq4i
         CaUVtxV/iS3KaNESWjQTr0aidTmYdoqu5ev7wNuMqe9BefX1GrnBHjMs6C0uWXs6y4BG
         3TRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311374; x=1777916174;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PO6gg0/IWEmCTv8xrfB/fKl5SzRNa5BhzNOETtSDJoo=;
        b=hwIzBFm48KYTjn82tw8/OsSrupdirKH3QY/Dqnrmb5XXuUEdKugPNv6xDhbw3LTTlM
         7PrOdwaO0afxjMM+4iDx052FV0uYugxcIXiNlCjapNUItq+gSeLEJHHdXQOO9OzhgOmA
         uezddIgpNkIn5xt/tjEv34lpagxhyXDKVH9ApyJPF9UNK99HuZYQhNUGSBHKqHfABsA2
         dJ7/FuApmy1rF4vFw3RV1Rn66RvX5TFBqdc8OGCKvRssiyrIqPSaiCPZk1jI62cWUib1
         yTvF/I+1CObz2rmC2MLzElvjM+lFNWQ9qH6pZhNLnUFWLdF0IvY9TJZHzQTF5E+yLv4m
         ZPdw==
X-Gm-Message-State: AOJu0YyJqaSsgvlrlheX/q7mA5ymbWFVR9ZSKgYIK5ceZgcADaAxepix
	tOiJAJKK2SwH1eLZB4bBlUo1JQ7vq/hmI95QI33nuPkFU3c3nmouw1s/H7C4Umrrz8hYiaJAYli
	sWA4lkbOOx+EGAJN9/qcPPHgDKn5X95NPeRtk28Bc/zS03nrjHowuHfyNQ5jBtA==
X-Gm-Gg: AeBDiesLJ+S2SjF8cDxBI03AS8QECAjYPFkffvlpUWkGc8tzFMBMT1RtwTVJtKJaj9k
	FXdWp4fX1uW+Xw8TPRyBra0qNHTgNfuMgIo2wB/fAlYGooYVyS5B0+ZP5NIA9ssjqz8B5gPP7dX
	JmVqgYEFXDjRcCyYYZQX+quuRhNEOHkOyWbkJE3ALArD2j3buOB0yRd2Y7DbazxeLYNYOcyCED2
	UtmVDh90OucoZmcB8mcwP3cFoKSqIrBD1B81HACc7hVybdIzJtxkRWQmusjqZOmCavA8WcmuLmy
	VJfACa0IH03oEOwSK5QMSzAYrtXoPe04SQCGMnTW6baJP2xq7H+TSzyo+llpTx9d4JNKWuheOro
	AapCMof1A5SeoGlu4xyVufxzhCJRlpvt9ldtbblz8yyLT1c3WSM7guTqg+GfyDPUNGqR0
X-Received: by 2002:a17:902:c40a:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2b97a951600mr1695615ad.35.1777311374235;
        Mon, 27 Apr 2026 10:36:14 -0700 (PDT)
X-Received: by 2002:a17:902:c40a:b0:2b0:7d3d:756a with SMTP id d9443c01a7336-2b97a951600mr1695025ad.35.1777311373686;
        Mon, 27 Apr 2026 10:36:13 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aca8369sm329115ad.75.2026.04.27.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:36:13 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 23:04:46 +0530
Subject: [PATCH v21 06/13] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-arm-psci-system_reset2-vendor-reboots-v21-6-dcf937775e73@oss.qualcomm.com>
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
In-Reply-To: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777311301; l=2477;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=yBVN4FEHADdTSQ++LEmhmTEyByZ3pz1DEJtf2+BqO1w=;
 b=lmkiWsLFoZiVy+q+yRqg9SpaKjLQxt8Mmp5CQJoF/Ii4uoBHHfeoTnxYq/6ce9i3yob3pcaPr
 anKDkGgjULpBrTuJ097A+tFD1/IfB8Cv6S2JKHq6y8M7Wxpx75aljAe
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4NyBTYWx0ZWRfXy8+sEojnKhLI
 ZZIBezKJfpDt3AwAHQsrGIzlpJs8cErMEzFw5iI2QnsZ2hQ8WX9l+01XKIYItf6H1vfm61HNXy/
 LFagoaCB7rv0+W6z02hUeIeFjjYezck6F9WSiFe5nsBzb2MtRcIGY6nq2ditJO3D6RwDjs5I0zB
 bypogBalQoQBvnKigUm/sYcIOWate4T4bErZQswmsN6DDQLkE2mk8Ituh3WHX9aVqZJmmxzVKuc
 hWp/KzTFflDgxKZk+FjUL8o9EWEiM532xSRIZPUQ8pIkTw4MSuEsVz/AZjjMqEysXMaE8DD/eyB
 17hlLk8lOXsEhtOHyPuF2WYH/7nn4AJE229D+9Q3DWN2RN796K2x2AaJp6iZYImsDdK3Z2u6AFg
 g3jG+sDZJ30DtSDTST8vjkF8tOxgmvErpGo1V8du5biSJOKdTZzy0q06SVgDe+BYwqxPZkglPVf
 1k6fSAqOI8yogKd1f/w==
X-Proofpoint-GUID: MkaxPuFWbtwxnxIGincsyrg0zBgGJ8JE
X-Proofpoint-ORIG-GUID: MkaxPuFWbtwxnxIGincsyrg0zBgGJ8JE
X-Authority-Analysis: v=2.4 cv=ZMfnX37b c=1 sm=1 tr=0 ts=69ef9e8f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Z1E3qa2j_4PWJv3PNLYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270187

Add bindings to describe vendor-specific reboot modes. Values here
correspond to valid parameters to vendor-specific reset types in PSCI
SYSTEM_RESET2 call.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 6e2e0c551841111fbb0aa8c0951dca411b94035c..5fdcbf331ea5620363638feb6f8105427a87c00f 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -98,6 +98,26 @@ properties:
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
+        minItems: 1
+        maxItems: 2
+        description: |
+          Describes a vendor-specific reset type. The string after "mode-"
+          maps a reboot mode to the parameters in the PSCI SYSTEM_RESET2 call.
+
+          Parameters are named mode-xxx = <type[, cookie]>, where xxx is the
+          name of the magic reboot mode, type corresponds to the reset_type
+          and the values should be provided as per the PSCI SYSTEM_RESET2
+          specs. The cookie value is optional and defaulted to zero.
+
 patternProperties:
   "^power-domain-":
     $ref: /schemas/power/power-domain.yaml#
@@ -137,6 +157,15 @@ allOf:
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
 
@@ -260,4 +289,17 @@ examples:
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
+        mode-edl = <0x80000000 1>;
+        mode-bootloader = <0x80010001 2>;
+      };
+    };
 ...

-- 
2.34.1

