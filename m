Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2083B42F8
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901573; cv=none; b=DLhECwjMcF0aorLooG9GrXch98Ugw7PwOSntHQZhbvJrlLG/woXndr70k/f1DjhFERPt9jvwLnwBN2tEj+kFjBX03WTtYWk5HCqNBjgDd1Kbc5egnjzDhSJPW4UPaMNeNyjgefoZazHrvRKuf10Flr8S/6AQcYIU+KtVY1oP65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901573; c=relaxed/simple;
	bh=703nbJ9+AremmpLmpfLaXhNDAPkhsejmF/gbf10YyyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iLiXkducpH+cDbxYwyYPU3uT+prQJb3At2+a2aYdCUXTYlxdxQKXRVgGilJcdTpY1qi9YZw7XPxN9ssKiZSN9cKGcO1AezXsSp1cZyxeJdBfXYkEI/lKWSl34FN1eBl19wFmp2t+8LCOKcRsYv99vFORMvNOYE70h5z1wBIoLWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JH8LdBdN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=URZQ8S7R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JH8LdBdN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="URZQ8S7R"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHVVF11155286
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 20:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kVaKYynhspx2lTK7GMhim3cT5wvFl+yF3CrSCp59GD4=; b=JH8LdBdN4cxkZhqY
	WLjU25+wJmXS2Oym5uzycc29yXzLsKA6XH54ohHdMA1/Bt8GupVLK4dRcspva8O8
	rMEnxgeee54pHFH/TKdNMMZ2tO9Hhh2J1MwG1stGyqkwp1g14YoAYA+a8LfaRg5Z
	9/agjZZcu+DJYj56cFUJYvk98xno7aKw/naElE3LBZVJ5m/kDDG2mI/TWCHdvEOr
	U1ATF4R60Li616Utv3jOSOLneHvW1vS7lu+6tZjve1QaIdiZiC5dJJ/c8PUIRfmX
	a9lotuTeM1Fby/wwN63dE3//JswfaHgX/FXL3qiZnPJgFT2mQKzCkz2Jm/T6TRVc
	iPDWAA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6scx5g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 20:39:31 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8421ffff8a3so2788949b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2026 13:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781901570; x=1782506370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVaKYynhspx2lTK7GMhim3cT5wvFl+yF3CrSCp59GD4=;
        b=URZQ8S7ROCIKIEZ+KjwOcFwYo74289NYZbaaJKYxXLSNoETDkXPHEsiE9SnEwbnLgm
         sdBh1gM6wZ7/Qexjj1niB0k6suopFxALRJ4a6jI/0UKV77DhsWC2MH5Dz84JYboc44o+
         mhXlWqKCHyOQ20iV6wXUm/ApTNfBayujBMXC860ohQZ01ZtX1cjIHHQPZEzNkIqsleqs
         gnwVIUJ06PvxIJ+oAJAaidLDjot25i2mpOx9YHgVuECpYtVRxZmvJpqcu6MH9udkNJ1Z
         bUZO5BZJDR5uJtHdvpF2p0I8vLfaFY2ULZbKLWjRrbdAZ3fMY5/mQu9hSuJWkozRARVW
         wJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781901570; x=1782506370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kVaKYynhspx2lTK7GMhim3cT5wvFl+yF3CrSCp59GD4=;
        b=F3XlbnQXjV46A5v/VBEOEijEPtDMNJmQhC8L2wrZ2NSPwl8d9xcjaiD2eKqUoH3wKZ
         TjyVVKKTHKmMk1Xs2O5qmDCUF7RGxaishYVaH0N6oY1nLUIDIujRWtRojm2VLdHcRf5O
         bH6wEgy68rI1uO9JdwyhjbBMHb2vHiB8sT6UI+NnFIGYqra0i/eYuEylo5Z6sKbx+DC7
         6dW+81kG86EiC0+gE9le7kiYaoMoYzGkjViYksK4juUtMsIY5+k8+MRw2BTiMdhmsqjl
         DUe52Pi1Zgmk71QJv2fym4WsF/PZwxbb6SfaaUTAxvVzjy0uYX9oZ1DTUvOJSUnUZFiL
         Fncw==
X-Forwarded-Encrypted: i=1; AFNElJ/ecpfADFthUaaU/uCHCrFijLNYiXo7WOG6xRNiEwLmZ3jz/ABeZUF/QcJSw6gRoJJcKPiOtsCmpA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0L4YdrpW6ylkWkYtUr7EKXPe7NGK/ssnHTgmHn12uCamQ8L+W
	aNcZrMqhtGfpEphdrSGeQG1bRxaSb4Fu7Ja71n24TOrn8dF7vTPGMSxkDIMqk2BcyWq2FUJSVYN
	jwXfuk9sDTOCakDrVyrWAF3Eddw2zZ7FfeEABoLMM608/uJhswbhRyef6o5F5MA==
X-Gm-Gg: AfdE7cnhSB6dGdAGD7qgEjY7Gl9NirP3MofE2SzcbAqf/cNQrLXjFsxaBiUo4xg/30b
	GSLECxjfEzHcUvkvrCWpPrY2PjOI4A69TOuAtpjC8jGV6ZMhtRRLU4eLrLO5HBUtsXcFCOhznLW
	zv+cypgna7JyXkgE5Hm5fwYiN67HQmsFeR4B0VS0zmimOfcEpgcyqYHl+7zSnkhEouAyjhQnCY8
	4YDB9sTl5B+9jcU0D/qmY01AwWef6gUwQrusJqmHey6MotPTpBc9XU7ms1MpccQe/P0LcX39aJI
	cexlhlpCZyTUoTSudHifMacgi9IeXgL57hJX784YaGtlq4C6xxmoyl89rWIXd/1oUOEjIO6MhbS
	gKRWMl8hqQBxemv6uTPtEeV/inYG0cz3CD3zLGmzuyM/Vdg==
X-Received: by 2002:a05:6a00:c8b:b0:845:1715:3b1b with SMTP id d2e1a72fcca58-8455616a5a6mr4495609b3a.35.1781901570174;
        Fri, 19 Jun 2026 13:39:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:c8b:b0:845:1715:3b1b with SMTP id d2e1a72fcca58-8455616a5a6mr4495581b3a.35.1781901569661;
        Fri, 19 Jun 2026 13:39:29 -0700 (PDT)
Received: from hu-manafm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ecd779sm94190b3a.53.2026.06.19.13.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:39:29 -0700 (PDT)
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Date: Sat, 20 Jun 2026 02:09:08 +0530
Subject: [PATCH v2 1/3] dt-bindings: power: limits: Describe Qualcomm SPEL
 hardware
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-qcom_spel_driver_upstream-v2-1-a3ee6837c18f@oss.qualcomm.com>
References: <20260620-qcom_spel_driver_upstream-v2-0-a3ee6837c18f@oss.qualcomm.com>
In-Reply-To: <20260620-qcom_spel_driver_upstream-v2-0-a3ee6837c18f@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781901560; l=2547;
 i=manaf.pallikunhi@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=703nbJ9+AremmpLmpfLaXhNDAPkhsejmF/gbf10YyyU=;
 b=+ZgHbBUKa235ZUbytlgNLfOf/qZmqEFOG1cpz5nUuF5rRNTu9E2ny3p5lRwn2iQ/OQWOd3atE
 NhECZb6q6N2D16SQMNyYMVxeJy1Zy10xk69myketaGkJRz8GBVMmSmR
X-Developer-Key: i=manaf.pallikunhi@oss.qualcomm.com; a=ed25519;
 pk=oZ3x9jh+FDyPwxHmCbyzEMQHMzKqrH6hUbbL7dEBe2g=
X-Proofpoint-GUID: XwBLXvyvMy1ZQaoxHE5UGO3Xv-P8NvyY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE5OCBTYWx0ZWRfX3CE/pFUdDz9l
 24oQC/VtIYo7Vy37g0aDTQUbk+ekbscsUPNkWR1LQINKNHU+BMRELUhG+UcVVWD8TMwrJkllIIk
 LURgnRb9feGuGgtRlBqXsjRzgAX1EZzhNuy/x+Q7CSm7ORQCe/rRWFh9KNdXXoUxNtrkpYQ6GgF
 /TGRosCMcBjsKqwnTm0JRH/nIFgNLI0G1vUerlLhvBddrayDgTDrZXvl7M6Zasln/HYpaxc3f7D
 dG1gml/kk3ufJG1DiB2ReUPXKOtDgrotdj6qv7fpmWqwhITCyg0QU8jMowKIGZbDabUSQiOn/jy
 UM5cOTz2oSLkMY/pEPnjfskC68gFRtMzKntRZg5pyi/s7260Qr31kT07uJaCRskgJGt8+dMkx8t
 FalTLbO0VofodcCkMQjPVLnUgtDxDzt7rsHBcniHfJbvdQNcFPUHTjtAXTwWWUpYOqAMZd4svj9
 vGDXqpBs0JEawGkToBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE5OCBTYWx0ZWRfX7PhwQ7w/aFJw
 StfirOuiKz1Ac44UJAWsJy/+vdOslKAkt9f2aUVMbt7rg1wdIlKnTo/eo2BTu6MExW+5OcSaXVp
 aR6Qr/17smDLc0wWutz18jzykG7jyM4=
X-Proofpoint-ORIG-GUID: XwBLXvyvMy1ZQaoxHE5UGO3Xv-P8NvyY
X-Authority-Analysis: v=2.4 cv=KbzidwYD c=1 sm=1 tr=0 ts=6a35a903 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=j4VyU_MS_U4jYmp-Sq8A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190198

The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
based power monitoring and limiting capabilities for various domains.

Add a DeviceTree binding to describe the SPEL block on Qualcomm's SoC.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
---
 .../bindings/power/limits/qcom,spel.yaml           | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/limits/qcom,spel.yaml b/Documentation/devicetree/bindings/power/limits/qcom,spel.yaml
new file mode 100644
index 000000000000..4c6e6cbfbfe4
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/limits/qcom,spel.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/limits/qcom,spel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SoC Power and Electrical Limits (SPEL)
+
+maintainers:
+  - Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
+
+description:
+  The Qualcomm SPEL (SoC Power and Electrical Limits) provides hardware-based
+  power monitoring and limiting capabilities for various power domains in
+  Qualcomm SoCs.
+
+properties:
+  compatible:
+    const: qcom,glymur-spel
+
+  reg:
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: config
+      - const: constraints
+      - const: nodes
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+examples:
+  - |
+    power-limits@ef3b000 {
+        compatible = "qcom,glymur-spel";
+        reg = <0x0ef3b000 0x1000>,
+              <0x0ef3d000 0x1000>,
+              <0x0ef3e000 0x1000>;
+        reg-names = "config",
+                    "constraints",
+                    "nodes";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3dd58a16f06a..c63f147e8c54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22233,6 +22233,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
 F:	drivers/power/supply/qcom_smbx.c
 
+QUALCOMM SPEL POWERCAP DRIVER
+M:	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/limits/qcom,spel.yaml
+
 QUALCOMM PPE DRIVER
 M:	Luo Jie <quic_luoj@quicinc.com>
 L:	netdev@vger.kernel.org

-- 
2.43.0

