Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FBC26056C
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211698; cv=none; b=d9Z+/mAx7CjX/2PlwUTy8lNR0DbXVDkga8j52NNt51He6WHO1xzw3xTquiIeES6sXw8+ZlOcvz4wh2Ayb93owOIl6dR6e9HR/367gMa/0A0JmqPHqQbDQ70vYzIdJpy1bYTFYACgH7/tnydGE1C7vLcEHAZBLK0bDHjD8ay3VCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211698; c=relaxed/simple;
	bh=o0KGTNNognzm5ueJpddSZYPS0o0uoX45XbV+lvhn5c0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTR7NRrEH5ygbPnbS/4bnLH4ZTKThSClT6iYXO6gYt2ih+/YjEOcZ+EW8CZbS3+gDuaLdTh3xxMyiTnQk6YdAfIWY0gjs+VSif5wXFVVBWMu0hmHeyOzISFGgnsdgRluJ0JQnvVropFpNpMzxtclC8/dH78NrYZ8V0sXpOn8YwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iDJ0dUKs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZP/0MV/G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iDJ0dUKs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZP/0MV/G"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JEwdvV1725321
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 17:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	drUWtwA83/EEbEXu3aLtZJgaN28Otw3wIriIN70eSI0=; b=iDJ0dUKsPqaJ5IpL
	FB65N+jBTu9iD7D79LQGOFsW2WmU6BruZQbr3VNhXHMfQqbJnZ/2iXN7CWV6e+7k
	3vR1LPCiNJYHeO4aR3rO4+AsexdDM1EvEhksAvL82qYnSj0YdQsX3G23k5NyFaKP
	nnGEB6B/JKKcrEL6JeuqWD2Hfjv9IKIj0FTdJf6LncQ/HVAPq+ziKo5S2QArK625
	KSoLmPMFcmS/XPizlM1wazeTcaLkCPvabhU61F/cMPWQzJLBvA9Xax2IwSYa7/yQ
	Qu0N45UAW/P/baFkfOuwOyL90GCXZ3bB2pylt2iIbqv2SxKM2E/G0sV4giNHmSL4
	r4BhuQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3qgq07-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 17:28:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba224c3ffdso96052925ad.0
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779211695; x=1779816495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drUWtwA83/EEbEXu3aLtZJgaN28Otw3wIriIN70eSI0=;
        b=ZP/0MV/Gw9iK+XlBW/tBUc3ubhaNJUw68vxM9NT1UsZeFBNOLsGtsuGYR6M66FFOr2
         Q51W9Has2oie2FUKKCdJQOEL1d5/cWPAG+1vFUqRPcXugGWuVoJDpnZ1HJpv8Nwmig08
         1mxssOJvpXtAhuHmlIVivGnjd6rAtUC19TT6DpVF8liemk2b4u4dXNX5KHk6ILKHs4+5
         SuMkgwlqeYEYy4Y2W2BNGin/9K5aErGtUy71dG/Gv89UPGnvQ/4YbJnxziZi19M8mR6g
         uR72KAW+3/q/z8PPsHsO4mQUPRxmAAqaXGwLyR5gePV14Y6l8nlM7XBgLaW92ahL5Ua1
         p05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779211695; x=1779816495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=drUWtwA83/EEbEXu3aLtZJgaN28Otw3wIriIN70eSI0=;
        b=nPmb+RCAt1LEaQ/cXGv30xhF3YRiq323u19E66vF8GxnREHtsnXSPLsSXIUkJclrl4
         2UOWgeqkWzvfP/mYC1xUWK8pP/Bd4X6ZC4ERUFE6/E7JPk2UQ1QKzaxi9sVvxQEIoFEn
         vVTrM3Lcol9oYuDP8HdhVhch0V4Ah30GvSz/0tCUwY5PdZoymrA3nG6h46B745o2hLlJ
         SvIK+D5Ojj3J0dGzex3YacFvRogbCiw3MQPqnNUbGWj8aRBv6aiH4OURxDyMXhMoVX7z
         g6aDyxMuUZ5SqiQYupeYdZ6yfM9t9pZa/P13hLtPmqPbYGAPRPDF7cLeZqc9mHia8jKU
         3y6w==
X-Forwarded-Encrypted: i=1; AFNElJ98jkusUNpJKVSFcjVR4UzJ9yKKKZ6PDlYSyfgLhKvXo5INfLwXmje1D1lNfpnxrxkaFhITvVte+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfPzqrMWmhl/x0KQ+B6xIS5d438VvTiF1jOEtJxBlCVw1VBPmv
	svqNKXZqajfYjdRbNXFp4v6AG0guV9K7EvsToqcSeL2NRKt9uP9A/QKUYGLcKkqxLS2CEDriPYX
	s0Es24pEWfJkck2R2G7kEhYaXg/mrqegGnMWYNtRAr4DDemRvMC8jVmljfJg8kA==
X-Gm-Gg: Acq92OHimDvG6snx9orOYa783JkVZ3jAqi7ikQomaewC2x6P/5GjZayheWibDMqGgM1
	7o3Nflt4hom85L0/sZes3w+SNVoFTmuW38gQUI6cnM/avTOcpT3a7vfHOaGtqfmc5DLLxH1qpMk
	qUMMEhe9+uHptMeabDlUmWkpTztYzxImMZEVnRyGrZ836Gwh247nqycX3poQGGKijS4xsq1HUod
	AqY1qkvku9ZDK9vWzKCw+5eg6hEhMXxgfTnGtvFTHBqy8CmqlIjIRt5D8+Fze7G9+67OeUk+Kb4
	0y6rDACObGpWOHjb8J/Eq3h4b2OifXe5pydxPZrIYRy7z3m9Q0oq4uQsGJEsaynmLU7mfr+yMZR
	7mZ219ydSjOGUTclRtL7Du1zMP5wIHd41PBjmlrXsBf9wi62EQAD1
X-Received: by 2002:a17:902:f64c:b0:2ba:fed:7891 with SMTP id d9443c01a7336-2bd7e92c24amr235115365ad.30.1779211695267;
        Tue, 19 May 2026 10:28:15 -0700 (PDT)
X-Received: by 2002:a17:902:f64c:b0:2ba:fed:7891 with SMTP id d9443c01a7336-2bd7e92c24amr235114905ad.30.1779211694780;
        Tue, 19 May 2026 10:28:14 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d125159sm182248365ad.76.2026.05.19.10.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:28:14 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Tue, 19 May 2026 22:58:03 +0530
Subject: [PATCH v2 1/2] dt-bindings: cpufreq: qcom-hw: Document Shikra
 CPUFREQ Hardware
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-shikra-cpufreq-scaling-v2-1-2b09f0e1c9d8@oss.qualcomm.com>
References: <20260519-shikra-cpufreq-scaling-v2-0-2b09f0e1c9d8@oss.qualcomm.com>
In-Reply-To: <20260519-shikra-cpufreq-scaling-v2-0-2b09f0e1c9d8@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE3NCBTYWx0ZWRfX7b9CeUh4lx3l
 aCdFMMxegRNZhIhoPDBt380byDL8DMJ1SAOlySTmtrKpkhMgKDxQDN7uG49U/e/lHyUi/0rcrmV
 Zo2JVVjk2EIvb0svhwvQ6iQns8254LfQLEaY/Fie9jBMMKD8a+wOzKT2QTiBEOtq7pS6ahudQru
 VSntm0GoFHKp9jDdYx1PfIgtHYeKOFsbQXG/55YBYvTLYTNaNpTj6YYEBW+ipXCe6QCOEcjkpH1
 qEX08fVE272I2HEQOR3Qqo8YbD2tHGsxIn7/4twGI0yLUC1lxRLz91Fl9cwFAq4C/Z1tEXWDWtd
 WBkUFMcJ2tHC9IzmzAT/rqk2TDR3IUL1ISSrJ1meHtIYJSYGXqVl88mxsAYqKZl6CPhFCCxKu6o
 FYuGpv6KT8mes1GrukGjcSxwGd7xWqAzJPq2q614wc0oZ5adeU9J5iUBw6uw9EGECRiKKvoLCI7
 wxqOV2ZTNj8VLNCGQJQ==
X-Authority-Analysis: v=2.4 cv=N9cZ0W9B c=1 sm=1 tr=0 ts=6a0c9db0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=sA6xLUNpRn-UYiqxgCcA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: RQbogpMJjYYg6W6pTZhYJXZ5FV6SG6T3
X-Proofpoint-ORIG-GUID: RQbogpMJjYYg6W6pTZhYJXZ5FV6SG6T3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190174

The Qualcomm Shikra cpufreq hardware is functionally identical to EPSS,
but supports only up to 12 frequency lookup table (LUT) entries. Introduce
Shikra specific bindings to represent this constrained EPSS variant.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 .../bindings/cpufreq/shikra-cpufreq-qcom-hw.yaml   | 133 +++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/shikra-cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/shikra-cpufreq-qcom-hw.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..52079ed661671554fcca8677409ee11199f5727b
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/shikra-cpufreq-qcom-hw.yaml
@@ -0,0 +1,133 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/shikra-cpufreq-qcom-hw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CPUFREQ HW for Qualcomm Shikra SoC
+
+maintainers:
+  - Imran Shaik <imran.shaik@oss.qualcomm.com>
+  - Taniya Das <taniya.das@oss.qualcomm.com>
+
+description: |
+
+  CPUFREQ HW is a hardware engine used by some Qualcomm SoCs to manage
+  frequency in hardware. It is capable of controlling frequency for
+  multiple clusters.
+
+  The Qualcomm Shikra CPUFREQ HW supports up to 12 frequency lookup table
+  (LUT) entries.
+
+properties:
+  compatible:
+    enum:
+      - qcom,shikra-cpufreq-epss
+
+  reg:
+    items:
+      - description: Frequency domain 0 register region
+      - description: Frequency domain 1 register region
+
+  reg-names:
+    items:
+      - const: freq-domain0
+      - const: freq-domain1
+
+  clocks:
+    items:
+      - description: XO Clock
+      - description: GPLL0 Clock
+
+  clock-names:
+    items:
+      - const: xo
+      - const: alternate
+
+  interrupts:
+    items:
+      - description: IRQ line for DCVSH 0
+      - description: IRQ line for DCVSH 1
+
+  interrupt-names:
+    items:
+      - const: dcvsh-irq-0
+      - const: dcvsh-irq-1
+
+  '#freq-domain-cells':
+    const: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#freq-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+
+      cpus {
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        cpu0: cpu@0 {
+          device_type = "cpu";
+          compatible = "arm,cortex-a55";
+          reg = <0x0 0x0>;
+          enable-method = "psci";
+          qcom,freq-domain = <&cpufreq_hw 0>;
+          clocks = <&cpufreq_hw 0>;
+        };
+
+        cpu1: cpu@100 {
+          device_type = "cpu";
+          compatible = "arm,cortex-a55";
+          reg = <0x0 0x100>;
+          enable-method = "psci";
+          qcom,freq-domain = <&cpufreq_hw 0>;
+          clocks = <&cpufreq_hw 0>;
+        };
+
+        cpu2: cpu@200 {
+          device_type = "cpu";
+          compatible = "arm,cortex-a55";
+          reg = <0x0 0x200>;
+          enable-method = "psci";
+          qcom,freq-domain = <&cpufreq_hw 0>;
+          clocks = <&cpufreq_hw 0>;
+        };
+
+        cpu3: cpu@300 {
+          device_type = "cpu";
+          compatible = "arm,cortex-a78c";
+          reg = <0x0 0x300>;
+          enable-method = "psci";
+          qcom,freq-domain = <&cpufreq_hw 1>;
+          clocks = <&cpufreq_hw 1>;
+        };
+      };
+
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      cpufreq@fd91000 {
+        compatible = "qcom,shikra-cpufreq-epss";
+        reg = <0x0fd91000 0x1000>, <0x0fd92000 0x1000>;
+        reg-names = "freq-domain0", "freq-domain1";
+
+        clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gpll0>;
+        clock-names = "xo", "alternate";
+
+        #freq-domain-cells = <1>;
+        #clock-cells = <1>;
+      };
+    };
+...

-- 
2.34.1

