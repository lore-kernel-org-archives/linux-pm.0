Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0938351C3D
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013003; cv=none; b=ANgZPqmhEWYMmZrlejzgBOmDQ1fbHTKmrl83+NmMgUK2LZRYTRFsYEIALFXvoXgvivs4UWd1qyFwyzL9xYYz4CCGR0bgV2nfypmOB0qtkbEIyoyb/7LjQ4rEUb5TRIq5X5/8cKX76CFgXai6q9lMQXJa92SSIb8BlEoefMqj/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013003; c=relaxed/simple;
	bh=SkClX+BRSZeyx/tE3dfrFyvjxOsfCTkuTsmKG3JwtRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kjFb374DSGxxMUpZz0Pdv+YLLrF96e19LSxvxZMpgMlo6phi6psXoN9DibrOW/y69kpgFpwB+Wq/kTeQoImBlDHKQTgqgCp+5cQ5TFMIrUkbu4kIaKZL1vp0mEvPoM7gAoDuqjrNMKMbLrO9BleRXv9hNa9cfM6DK48EahKjwBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iKJVY+5J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S0R3M71Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iKJVY+5J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S0R3M71Z"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662E3dvr560417
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 17:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZVIXvfF08Zv8MetAzCraK24oPCTEkf7t2xGg8nxuk1k=; b=iKJVY+5JGWYbinO7
	vCVteIYV2dbJKlLgwzBEy8CLoOTHlwwsJZVdpWaj9cbAyiSQiCX4FvtmIQ9/noAF
	vnDRv/uivl9ro4aFDR1bdSr8iCln7iBLcgEAM2J8LwqJWYgkiH+SJyWP6/gQrIFX
	Z4uLNF6+/XujjfpRk5vi8MGqDdoHwCe5JfQ3KrQfD+C81t1wgLMuaiFk3Cph32uU
	TSoPqAOyVSomrGzctC4j3uNs2ZvsZq00BKM/wjGqyxt+kTdxIETeeE/lmrdjjK2U
	N0mBud3dJIozy3JyVRxKW3NmpJjJEMDEX55J5AqkQ0FNsbQH3yaW+/XU+kdgfbtj
	EjisPA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bj3c8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 17:23:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9fe2607511so226677a12.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783012998; x=1783617798; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVIXvfF08Zv8MetAzCraK24oPCTEkf7t2xGg8nxuk1k=;
        b=S0R3M71Ze25R3/yDALERuHTXNVA98PeTaxaTFcwcwUgbhORviUXt2+FS+0NaPKqGKU
         IbZxi4ePiKrhQ/M+aACx1v91YSwFvqW4GB17d/Mte6WTUSgBRwGdo09w0+4hfasgHSHE
         MbXNkfWupQOnj0AjhzWa0umv73CzPWjEUfb+T6ir1Ei3IFDf5pY83k6PC6aYWnnJuQMY
         dVxmvUpycw2udtAseBFkO++O9y7m9LWfRM7IbGaGJ5M57BqO6JAvSb1bi5o7sahZgCvb
         xpwFvabKqrpOD+eXjMcdaEvAchf8LNq56LjVfpHRzhiDgyX6cWPBIRyvNIzwpB0yfc+O
         rqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783012998; x=1783617798;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZVIXvfF08Zv8MetAzCraK24oPCTEkf7t2xGg8nxuk1k=;
        b=GPbyaQs4tr6tGpxn7sMUaHgUknAYTVHtvYH8oI2aTvrQ767GCuYb7faylBiM71DzWg
         beS7V2Fx/Dhui9CQg7z7RN2938oJ44/pSRW7koeMiaD3uBjnfnuzwV0C1CK6diEpKZI4
         tiGXzGYMLyHUf/iFeBDxii4O0iDYhJKV2tbvcq6lBR/FqWjItGdCxLwOTXB9A23V8SE8
         zXV8zNIM0Q15F0l5K68RcW++guzgQGgoe7rD73MZmdbz0xU9M8dDpmx2tjrHtf4aS9jj
         MSQy9YqU3dyTg/TiyWxLDSnJDMZI6cAlUamBXVJLkJceArMrEdH5NyIOWId1CIPyY4KH
         u5uA==
X-Forwarded-Encrypted: i=1; AFNElJ8KflnkAOBxu15iz1zxlOf1nRJRcFjl9du7MBEs2dfqi4ywrrgCB/H1A7WbEqvbW5q5QfLHEjThFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoOTpcw1AaqmFqm81tcvaceHFl1StV7u1xK5W68GWTa6kxi4nO
	gkuilDpnTq3yGBdFNY5T258Oz0zb2vb3janp+GYyWMe6k/VcWlXL/loncGVcudrGan1wQmum9Qj
	fzaBzBrhLan0pFP+bANvu1I3WDPC63aeoOjmeZDTu8rSeN46+60RcVwARBVOyOg==
X-Gm-Gg: AfdE7ckQjrVLRV0Q0aGeQ8FzYRfD2c32HYL0UKSlHNhQQXVJL9vcH0NFHvBJRFUCDvy
	22eTHg0i4+cZNzer8ImO6jxx405TFb01CurZLa/szTCHbwVQqdNPb9UUUuBYqWJDBNktVnZ6d+c
	EG03Vz+GhElUf2uCLqK6876IL2G4AVb7IWDuu6Ijqc5SKvG4d3FJxIZr1tPI5q0fhkR4N0KmfxU
	q77grZ3ADN8UpzfNExSDPCYJF3NJpzFBghtTnUi0cPPUE0h8Dm7B6cP8sXDmwrKJNBt6oK9O81U
	Vf65ME7QLBQ4pQndJRcbgkRwMZ6Px8pboWEfD9C0gLrK92t0I28wY+k5Qpavx7cbYK7oO6xNEmZ
	xf+pidNTpVO6EPNqW6piGgyolS4IwKmnTcp5zUGELKkZjgA==
X-Received: by 2002:a05:6a21:400d:b0:3a0:bc61:62e6 with SMTP id adf61e73a8af0-3bfed0f659bmr7633114637.8.1783012998548;
        Thu, 02 Jul 2026 10:23:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:400d:b0:3a0:bc61:62e6 with SMTP id adf61e73a8af0-3bfed0f659bmr7633060637.8.1783012997955;
        Thu, 02 Jul 2026 10:23:17 -0700 (PDT)
Received: from hu-manafm-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3ececfe4sm10564289c88.8.2026.07.02.10.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:23:17 -0700 (PDT)
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 22:52:55 +0530
Subject: [PATCH v3 2/4] dt-bindings: power: limits: Describe Qualcomm SPEL
 hardware
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-qcom_spel_driver_upstream-v3-2-434d50f0c5b0@oss.qualcomm.com>
References: <20260702-qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com>
In-Reply-To: <20260702-qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783012984; l=3981;
 i=manaf.pallikunhi@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=SkClX+BRSZeyx/tE3dfrFyvjxOsfCTkuTsmKG3JwtRI=;
 b=yClmCf9za530h3JJpKiRDGS2JiTZ2o7Vib+IN6Cvc+NhSYxbjEUsbUEJGgvNtymDJpCXeF48A
 wqoVqi+0pdrCyJryFPTEUM/291Ql+8RkOHGrUnU2SA3eQ4aszmawO3H
X-Developer-Key: i=manaf.pallikunhi@oss.qualcomm.com; a=ed25519;
 pk=oZ3x9jh+FDyPwxHmCbyzEMQHMzKqrH6hUbbL7dEBe2g=
X-Proofpoint-ORIG-GUID: 55zZyAV35a_HeSWKJuHQxDb57s22yLpI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE4MyBTYWx0ZWRfX/BNuHQRC1ji6
 0GHO0fyvHvClrw2CJMPO5v626s9BuAVBTI1EYcxVI2A3R80roEv8JuT3NPT0APxHfHSzlTPDfCu
 Iy18F6HidOz1fKyWKNNI/+TqeKD2y5Q=
X-Proofpoint-GUID: 55zZyAV35a_HeSWKJuHQxDb57s22yLpI
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a469e87 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=3TBu0n0mUwvVB62lRZQA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE4MyBTYWx0ZWRfX2A4/QUWliceP
 jk2tdGOQq1A9ssHLKSjIPxbx22dfiLI3TQfB57t+/A1D91p+7TpHqW+b+cRNNQ/9KXL1MtBYSEG
 QKBLEzdUQtrYk4lkj2xAx29SLObjDJ4VYJKwdISYcyCMIJ/auK7oJC+7ym8mf1OcHiXQKc5A4n9
 JApPe9C0UMgOjfuHLFEZZ2rZW9tmTTfuwQHRV5FTHvf7LjlZDV+N7gmo3bbLT0kDr1iKoUlRBmp
 5ZIjleUXtU/ADshkQ09SPfy4SvjvVJEGD5Iho4GsPoWHRlPmzmVsI0B27UKUshI4JbR3j6y860M
 0cVoId/FtBOVZnwK6IlGJts0H7Rl7ty3fyvGoymzkukac2hbqo6Qh/VfJdUkYV7xjMKiIj7rxZx
 mY/vR9DpySP2elvM33nIWQpK1RHGLnu2xiXNkaV3z5deSVBUFtxRAjW7zFad/hsWKHm+R3tjN3/
 rZvc51ojUZBkjLc5Dfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020183

The Qualcomm SPEL (SoC Power and Electrical Limits) is a hardware block
that provides power monitoring and limiting capabilities for various
power domains in Qualcomm SoCs.

SPEL enforces power consumption limits to prevent thermal overload,
maintain system stability, and comply with platform power budgets.
It provides:
- Hardware-enforced power capping with configurable power limits
- Time window controls for power averaging
- Energy counter monitoring for each power domain
- Automatic throttling when power limits are exceeded

The hardware supports multiple power domains including system (SYS), SoC,
CPU clusters, GPU, memory, and peripheral subsystems. Each domain can have
independent power limits and monitoring.

Add a DeviceTree binding to describe the SPEL block on Qualcomm's SoC.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
---
 .../bindings/power/limits/qcom,glymur-spel.yaml    | 61 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 +++
 2 files changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/limits/qcom,glymur-spel.yaml b/Documentation/devicetree/bindings/power/limits/qcom,glymur-spel.yaml
new file mode 100644
index 000000000000..e8d974cbdc64
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/limits/qcom,glymur-spel.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/limits/qcom,glymur-spel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Glymur SoC Power and Electrical Limits (SPEL)
+
+maintainers:
+  - Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
+
+description:
+  The Qualcomm SPEL (SoC Power and Electrical Limits) is a hardware block that
+  provides power monitoring and limiting capabilities for various power domains
+  in Qualcomm SoCs.
+
+  SPEL enforces power consumption limits to prevent thermal overload, maintain
+  system stability, and comply with platform power budgets. It provides
+    - Hardware-enforced power capping with configurable power limits
+    - Time window controls for power averaging
+    - Energy counter monitoring for each power domain
+    - Automatic throttling when power limits are exceeded
+
+  The hardware supports multiple power domains including system (SYS), SoC,
+  CPU clusters, GPU, memory, and peripheral subsystems. Each domain can have
+  independent power limits and monitoring.
+
+allOf:
+  - $ref: power-limit-controller.yaml#
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
+unevaluatedProperties: false
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
index db3d8c441e4c..44e90b2d5e85 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22368,6 +22368,13 @@ F:	Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
 F:	drivers/net/ethernet/qualcomm/rmnet/
 F:	include/linux/if_rmnet.h
 
+QUALCOMM SPEL POWERCAP DRIVER
+M:	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/limits/power-limit-controller.yaml
+F:	Documentation/devicetree/bindings/power/limits/qcom,glymur-spel.yaml
+
 QUALCOMM TEE (QCOMTEE) DRIVER
 M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org

-- 
2.43.0

