Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559475;
	b=10BJ4QOQwojVsTkxET8j28awac6VycJJs/AIHYE45ZAdSGWAP6MJrXBXLRrG17DvNwKp
	 5jz87IAAQ/1g/6kZJ/0o+wxuInX4V9u2b+GdVUgyVrFkLpdr2MCv7CVFK3YvMfPBjn/FJ
	 faXzlMJPDcieh+nZxn4iUYSrriKzUpYxgMHvfuBKod0bK0KrqEmItYwi6kxcSLBu4zQ6a
	 T27RObU5bha3Kf7TsouUDfQQpaxza1puA41ur6jaB6mPWBP2JYlpugzjEfFHFpFDUM2VZ
	 b+H78VBWNgz6GPUwBIg0Vu/WXOnOZvYF6HBo461ufKx/RPAi7+rcR9KwObLmOBIFLsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559475;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hW6lTa7vFNr98RfobIlQ5Ds6tLDv26QTpOQS+7WejHI=;
	b=F+kkisTVfbTmyCOKxchcRwX+eW5sxxXbBR9ofD65WTHqQkPYmNXrT7JpBLmb+L17zZEV
	 tOI/tLUBPnaKQ5fK+NYqeaC38t1N5wmnnQ0aJWBqm1WbQYQ5QWawSMbzoBntwBjvkvxph
	 xEH+VdS6Q2J9xYnX7L2GX4IHITTfQgklo7gorpHAkXcVoP/5wp+kzgWjXIoMOx6+rXtuv
	 KfHwjbIPoi17/InA440pzdRk3oNF/1MgBUEL5+t89akaF4VY6OdK8ltQILPaeC05mRjIy
	 JC2fNxA54GHBctguAGIflxpgU5ORz/H5NPuQzc9FbuT+GPvpDt1/ik9MlDGpbnfKs+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f2bCprps;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZBNgf1DV;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC6D606A888
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DC6D606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f2bCprps;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZBNgf1DV
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8VDiP4163558
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hW6lTa7vFNr98RfobIlQ5Ds6tLDv26QTpOQS+7WejHI=; b=f2bCprps+QbQ8FcQ
	m1JLHw7uHuqOiDg7FJwoi8Ny9I1ZrkjIdwWwUhLCTSHSruezsmu8VJQzukmZVMPg
	4/HFLfmDaHGc52INV7+01vWkiAD8WYNg6V9yhqHopUKJbHoW5oRb0idFXjz1PPjz
	nW26YLDwBy0cMjN54NC0er2oKyFaH1y+Jnl4HjPE7cPWpDazfBMz21R3XWVtg+pg
	84PBwpMGloToZPQ+Onq5/xD2XRw0rBUxlav1trNLwVUTwHg/Ce3HLTax30VBsvIA
	hgrDAs7RvQgbeHNmZDKYXs1CGy0dsES6aduH6Z2B0Qfb4QCroGuhPAO68f+9eCmd
	dZH6ZQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwh0ajxyv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:44:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36de26cb4b3so934686eec.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 00:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794559473; x=1795164273; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hW6lTa7vFNr98RfobIlQ5Ds6tLDv26QTpOQS+7WejHI=;
        b=ZBNgf1DV5fKAoQ/gZ85/mYmjrCvMXZiAgNL7KwCuu22r76yKBUZLgON938lyYTiptX
         xYpTnRKD1JAlsXNetjHJpboVbTnbU9PYnJez88tJvqm6oRHLD2aR2wmC1PktJuKa92sK
         LNzkBwMJzVZ7awizUnavXtVNYKwoBoklc/TcGIwVdWb6TyfGezavZB6IWArUaRhWNjf5
         PuwGkxj/rSesPrTT5hJN6ibjXimyel0p2CE6bxvTKGNFeiGkkxuYGMF2/+ZedvKScn7Y
         vZwqew864gfbT7Nl58GA480aNJmIBF+VwavkIhDTyBCSafuZcRa11HvwGJKyryupzpP7
         EGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559473; x=1795164273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hW6lTa7vFNr98RfobIlQ5Ds6tLDv26QTpOQS+7WejHI=;
        b=UgNcPa4Cevm0SIjw18RHbEkpTmUkNrHTFq7Ui5qgcRCu0lJ87JOR5wJ0vdV2dRNoqF
         okOi1AZ7fo776Snwj3VfJzvKdzNEFYxGzLwrMSfsByBV9gMgeIycsyLLMc/GFI+4KL/K
         MO88WDxV587f2pNF8Ihhq9l60cJ4LO2Qo5T3GjYRrdA9hbtUvqMaP8fhClp1Gjj3LDCS
         aZ14v28+JbdOCgNsEpMwixGc53w7ve2l0+b398ja7GsWWmmsqzqR7UKwc/VZiVi9JrDR
         tsOu59+QpF2b/wjMLJVJXxmOosxPs4VuMlF5Fqfo8ZucfQNkhJZ1g6FY4GFs+7wY0sWq
         fbvA==
X-Gm-Message-State: APuU4Z+PGTdv7X0PpMOIMVu6EC/Xqz8PgV8uoMjrDHLPds/eufkpzUm9
	CugIIYvyytWJVmVvZ3djDYAQvrhu+9IHVGPAeT3PCZp5ST5I1dFL+26QS1zhMKyOVxbHOzNCA8X
	n94zKOpd90sqiMk9lpJRmGSn0pg/nrsFRUpMRRUN9xWa1ce4jilJj1Zu4aTMIEw==
X-Gm-Gg: AYBFou0uXIbFi66MN/gFnP20Y8iaQTglyHVlY5YnrTa9tHwIA4lfFVMsLhp/TNfIzxq
	lgEmL8qOOh2xyxMqGy+NEgYZJ0074ccP05Bihjtyoo1gV/EW6adjm7VDUO3Hxm5iXLJNThxBklE
	eaY2LxBg/JVZe+Ebx93A9TpAfUXDU4hXbwc7fIqFAC8XuOhcxGhQF8QelZdeG9e2J28CZv6ej1K
	gaDhAQDpVrr7vdxn82xC285LCHASsMfPyYbLoB4ip0CRjCTlTk9TV/aqYS/mRneKb0E6O7wcrui
	g7mY5LLnh7xPj2vmyj94/oNn+rJMXGSzETjukl56kYrHma5eXIQ4oFDUrOA8FPAPxHoMJ0EWI2F
	cd/t0jYJVnpouOY+Ddg3Ldtma0AJ1mmaOIAJeL2UMd53S93G1ofzy4/4r3QKNhEps5IKQBUGGxg
	AOVgM=
X-Received: by 2002:a05:7300:cc9c:b0:371:5cb0:4929 with SMTP id 5a478bee46e88-37967dd4c20mr1646692eec.25.1794559472202;
        Fri, 13 Nov 2026 00:44:32 -0800 (PST)
X-Received: by 2002:a05:7300:cc9c:b0:371:5cb0:4929 with SMTP id 5a478bee46e88-37967dd4c20mr1646662eec.25.1794559471448;
        Fri, 13 Nov 2026 00:44:31 -0800 (PST)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563df84fsm9662357eec.20.2026.11.13.00.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:44:31 -0800 (PST)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 14:13:45 +0530
Subject: [PATCH v3 2/6] thermal: add hardware-binning trip-point filtering
 support
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
Message-Id: <20261113-thermal_bin-v3-2-878df6eef8bc@oss.qualcomm.com>
References: <20261113-thermal_bin-v3-0-878df6eef8bc@oss.qualcomm.com>
In-Reply-To: <20261113-thermal_bin-v3-0-878df6eef8bc@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794559450; l=21658;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=yp+J4cH9/beCl10rSwyNJLTLP1VbJxm04QcHBRtUgXU=;
 b=cj258aaz6KEdO136inrJ/r53H8d0Wf+7pNo47pseAZpWdcc2Md3fL6lu+7b6K+D9PzSHGOQ9X
 T6mwBD+8a/+Bt5LHkCOmb6Vb6lAePXJ6QdN9cc4FaNvViJSDOHj9A9e
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX36q3vmEhsBCn
 SclDJz2gx+khDgjv1U7Hd+t33qpAtI1I4cEjJ9qWISx/ERoWMC+EjIgtCtTHK9P960LklFQ/LzI
 jlv83k5ZsMUVHiThcplPwWPzmxH6Lts=
X-Proofpoint-GUID: ESQujZYl7qhP1xqjjbevqNzWkmuVmL-5
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6af6cdf1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=B0hz1L2w7P3HlZecjf4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX4CADsQXijEZF
 fgeZKfZbztc360dX6cs+ilV0Ifv1/gHxQCHCX7G+FztTXWU9T0EGICXIJDecQ8UCCWuJLkS4qsM
 kvyhe0OqAmZrZquOlAYGJ9PEGr5BQsc9Xl+0hiGBT7w0h2nha6CisO8uxAfvwUjfV+uUD4xVMju
 S8f/SYPFt6ZTqLN+CWbsKX6+71MrkEpwspGHdOLeAyofeuHza/Rruy81YHYyUeczSmhw8Xy7KZv
 /0brIvHWSnR/DDgVVzcave1Crm6TAbPdy7tmS4HX0+oX7UX3teCxRE7fHdTZteEBXESJZK0wo7i
 62Y+2ztWnmqo0CtliOSFMZX56Ca4q1RNf+/qX7d1ZM/yNRGQgWIuD54MJF8RwOGvqcr7K6kE00L
 wVGoOgl4/g9Vtn458Vtnf59yCGfbyyS5imGE5LKNwHB+3X5M1rCfIM6gFih7wUj52uzehQPKNQV
 9PLbOxCSWmke89PQKKA==
X-Proofpoint-ORIG-GUID: ESQujZYl7qhP1xqjjbevqNzWkmuVmL-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130034

From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>

Differences in SoC packaging can be used to provide multiple SoC SKUs at
different thermal and performance characteristics. The underlying SoC
remains the same except for how much heat the packaging can dissipate,
thereby influencing what is the critical trip point at which the SoC SKU
needs to be throttled. This is the basis for thermal-binning.

This SKU-specific data is typically burned into EFUSEs during
manufacturing. We can read back this information at runtime to populate
the appropriate trip points applicable to an SKU.

Linux support for this has been modeled along the lines of the
opp-supported-hw property in the OPP framework that already allows
similar mechanisms to allow/disallow certain operating frequencies for
the processor. The thermal-hw-bin property allows multiple SKUs of an
SoC to be configured for different critical trip points based on a fuse
mask.

Add thermal OF support to parse the thermal-hw-bin and temperature-bin
DT properties. Platform sensor drivers pass decoded hardware-version
information to devm_thermal_of_zone_register_with_bin() before trip
points are parsed, allowing the OF parser to filter trips and select
per-bin temperatures during zone registration.

Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 .../driver-api/thermal/hardware-binning.rst        | 112 +++++++++
 Documentation/driver-api/thermal/index.rst         |   1 +
 MAINTAINERS                                        |   1 +
 drivers/thermal/thermal_of.c                       | 253 +++++++++++++++++++--
 include/linux/thermal.h                            |  32 +++
 5 files changed, 377 insertions(+), 22 deletions(-)

diff --git a/Documentation/driver-api/thermal/hardware-binning.rst b/Documentation/driver-api/thermal/hardware-binning.rst
new file mode 100644
index 000000000000..c385a2e224e3
--- /dev/null
+++ b/Documentation/driver-api/thermal/hardware-binning.rst
@@ -0,0 +1,112 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Thermal hardware bins
+=====================
+
+:Author: Amit Kucheria
+
+Overview
+========
+
+Differences in SoC packaging let a vendor ship several SKUs built from the
+same silicon but with different thermal characteristics.  Better packaging
+dissipates more heat, so the temperature at which a SKU must be throttled (or
+shut down) differs between SKUs.  This SKU-specific information is typically
+burned into eFUSEs during manufacturing and can be read back at runtime.
+
+Thermal "hardware binning" lets a single device tree describe the trip points
+for every SKU of an SoC and have the kernel pick the values that match the
+silicon it is actually running on.  The mechanism is modelled on the
+``opp-supported-hw`` property used by the OPP framework: the platform supplies
+one or more 32-bit hardware-version words decoded from fuses, and each trip
+point declares the hardware bitmasks for which it is valid.
+
+Hardware-bin trip parsing is part of the thermal OF helpers.
+
+Device tree properties
+=======================
+
+Two properties are added to a trip-point node (see
+``Documentation/devicetree/bindings/thermal/thermal-zones.yaml`` for the
+authoritative schema):
+
+``temperature-bin``
+  An array of trip temperatures in millicelsius, one entry per
+  ``thermal-hw-bin`` sub-group.  It is used *instead of* the plain
+  ``temperature`` property when the trip temperature depends on the hardware
+  bin.  Exactly one of ``temperature`` or ``temperature-bin`` must be present
+  in a trip node.
+
+``thermal-hw-bin``
+  One or more groups of N 32-bit masks describing the hardware revisions for
+  which the trip point is valid, where N is the number of hardware-version
+  words supplied by the platform (``supported_hw_bin_count``, see below).  The
+  format and semantics match ``opp-supported-hw``: a sub-group matches when,
+  for every word ``i`` in ``[0 .. N-1]``, the bitwise AND of the ``i``-th mask
+  and the ``i``-th platform hardware value is non-zero.  The trip is enabled if
+  any sub-group matches.  When paired with ``temperature-bin`` the number of
+  sub-groups must equal the number of ``temperature-bin`` entries, and the
+  matching sub-group selects which ``temperature-bin`` entry is used.  When
+  ``temperature-bin`` is present, ``thermal-hw-bin`` is required.
+
+Example::
+
+    trips {
+        cpu-critical {
+            /* bin 0 throttles at 95C, bin 1 at 105C */
+            temperature-bin = <95000 105000>;
+            thermal-hw-bin = <0x1>, <0x2>;
+            hysteresis = <1000>;
+            type = "critical";
+        };
+    };
+
+Here the platform registers a single hardware-version word (N = 1).  If that
+word ANDed with ``0x1`` is non-zero, the first sub-group matches and the trip
+uses 95000 mC; if it ANDed with ``0x2`` is non-zero, the second sub-group
+matches and the trip uses 105000 mC.  If neither matches the trip is skipped.
+
+Platform driver API
+===================
+
+A platform driver decodes the SoC fuses into hardware-version words and hands
+them to the thermal core, which makes them available to the OF trip parser.
+The words are carried in ``struct thermal_hw_bin_info``::
+
+    struct thermal_hw_bin_info {
+            const u32       *supported_hw_bin;
+            unsigned int     supported_hw_bin_count;
+    };
+
+``supported_hw_bin``
+  Array of N bitfields identifying the running hardware version.
+
+``supported_hw_bin_count``
+  Number of valid entries in ``supported_hw_bin`` (the N above).  Must be in
+  the range ``1 .. THERMAL_HW_BIN_MAX_LEVELS``.
+
+Pass a filled ``struct thermal_hw_bin_info`` to
+``devm_thermal_of_zone_register_with_bin()`` when registering the thermal zone.
+The hardware-version information must be available at registration time because
+the OF trip points are parsed synchronously during zone registration::
+
+    struct thermal_zone_device *
+    devm_thermal_of_zone_register_with_bin(struct device *dev, int id,
+                                           void *data,
+                                           const struct thermal_zone_device_ops *ops,
+                                           const struct thermal_hw_bin_info *hw_bin_info);
+
+The caller owns the storage referenced by ``hw_bin_info``.  It only needs to
+remain valid for the duration of ``devm_thermal_of_zone_register_with_bin()``,
+because the OF parser consumes the values before the function returns.
+
+If a trip uses ``temperature-bin`` but no bin info has been provided for the
+zone, the core cannot select an entry; it warns once and falls back to the
+first ``temperature-bin`` value.  Platform drivers should therefore provide
+the bin info before the zone's trips are parsed.
+
+The Qualcomm tsens driver is the reference user: it reads the named nvmem
+cells described by a per-SoC ``struct tsens_hw_bin_desc``, converts the raw
+fuse values into hardware-version words, and passes the result to
+``devm_thermal_of_zone_register_with_bin()``.
diff --git a/Documentation/driver-api/thermal/index.rst b/Documentation/driver-api/thermal/index.rst
index a886028014ab..5f858fabc865 100644
--- a/Documentation/driver-api/thermal/index.rst
+++ b/Documentation/driver-api/thermal/index.rst
@@ -11,6 +11,7 @@ Thermal
    cpu-idle-cooling
    sysfs-api
    power_allocator
+   hardware-binning
 
    exynos_thermal
    exynos_thermal_emulation
diff --git a/MAINTAINERS b/MAINTAINERS
index 7070cf5dbfe9..8bb1ddd2ec3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28003,6 +28003,7 @@ F:	Documentation/ABI/testing/sysfs-class-thermal
 F:	Documentation/admin-guide/thermal/
 F:	Documentation/devicetree/bindings/thermal/
 F:	Documentation/driver-api/thermal/
+F:	Documentation/driver-api/thermal/hardware-binning.rst
 F:	drivers/thermal/
 F:	include/dt-bindings/thermal/
 F:	include/linux/cpu_cooling.h
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 9e96fb1b033e..57500e565560 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -57,21 +57,168 @@ static int thermal_of_get_trip_type(struct device_node *np,
 			return 0;
 		}
 
+	return -EINVAL;
+}
+
+/*
+ * thermal_of_match_hw_bin_group - test one thermal-hw-bin sub-group
+ * @np:     device node containing the property
+ * @hw:     hardware binning info (must be non-NULL)
+ * @levels: number of words per sub-group, equal to hw->supported_hw_bin_count
+ * @group:  sub-group index to test
+ *
+ * Returns true if every word in sub-group @group has a non-zero bitwise
+ * AND with the corresponding hw->supported_hw_bin[] entry.  The caller is
+ * responsible for ensuring @group < total-cells / @levels.
+ */
+static bool thermal_of_match_hw_bin_group(struct device_node *np,
+					  const struct thermal_hw_bin_info *hw,
+					  unsigned int levels, unsigned int group)
+{
+	unsigned int j;
+	u32 val;
+
+	for (j = 0; j < levels; j++) {
+		if (of_property_read_u32_index(np, "thermal-hw-bin",
+					       group * levels + j, &val))
+			return false;
+		if (!(val & hw->supported_hw_bin[j]))
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * thermal_of_trip_is_supported - check if a trip node is valid for this hardware
+ * @np:  device node for the trip point
+ * @hw:  hardware binning info (may be NULL)
+ *
+ * If @hw is NULL or the trip node has no thermal-hw-bin property, the trip is
+ * considered valid for all hardware.  Otherwise, the property is read as groups
+ * of hw->supported_hw_bin_count 32-bit masks; the trip is valid if any group
+ * matches (bitwise AND non-zero for every word in the group).
+ *
+ * Return: true if the trip is valid for the running hardware, false otherwise.
+ */
+static bool thermal_of_trip_is_supported(struct device_node *np,
+					 const struct thermal_hw_bin_info *hw)
+{
+	unsigned int levels, ngroups, i;
+	int count;
+
+	if (!hw)
+		return true;
+
+	levels = hw->supported_hw_bin_count;
+
+	count = of_property_count_u32_elems(np, "thermal-hw-bin");
+	if (count == -EINVAL)
+		return true;
+	if (count < 0) {
+		pr_warn_once("%pOF: error reading thermal-hw-bin: %d\n", np, count);
+		return false;
+	}
+	if (count == 0)
+		return true;
+
+	if (count % levels) {
+		pr_warn("%pOF: thermal-hw-bin length %d not a multiple of supported_hw_bin_count %u; disabling trip\n",
+			np, count, levels);
+		return false;
+	}
+
+	ngroups = count / levels;
+	for (i = 0; i < ngroups; i++)
+		if (thermal_of_match_hw_bin_group(np, hw, levels, i))
+			return true;
+
+	return false;
+}
+
+/**
+ * thermal_of_trip_read_temperature - read trip temperature, with bin support
+ * @np:   device node for the trip point
+ * @hw:   hardware binning info (may be NULL)
+ * @temp: output temperature in millicelsius
+ *
+ * Tries the scalar 'temperature' property first.  If absent, falls back to
+ * 'temperature-bin', selecting the entry whose corresponding thermal-hw-bin
+ * sub-group matches the running hardware.  Returns -ENODEV if temperature-bin
+ * is present but no sub-group matches (caller should skip this trip).
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+static int thermal_of_trip_read_temperature(struct device_node *np,
+					    const struct thermal_hw_bin_info *hw,
+					    s32 *temp)
+{
+	unsigned int levels, ngroups, i;
+	int count_hw, count_temp;
+	s32 t;
+
+	if (!of_property_read_s32(np, "temperature", &t)) {
+		*temp = t;
+		return 0;
+	}
+
+	count_temp = of_property_count_elems_of_size(np, "temperature-bin",
+						     sizeof(u32));
+	if (count_temp < 0)
+		return -EINVAL;
+
+	if (!hw) {
+		u32 utmp;
+
+		pr_warn("%pOF: temperature-bin requires platform hw binning info; using first entry\n",
+			np);
+		if (of_property_read_u32_index(np, "temperature-bin", 0, &utmp))
+			return -EINVAL;
+		*temp = (s32)utmp;
+		return 0;
+	}
+
+	levels = hw->supported_hw_bin_count;
+	count_hw = of_property_count_u32_elems(np, "thermal-hw-bin");
+	if (count_hw <= 0 || count_hw % levels)
+		return -EINVAL;
+
+	ngroups = count_hw / levels;
+	if (count_temp != (int)ngroups)
+		return -EINVAL;
+
+	for (i = 0; i < ngroups; i++) {
+		if (thermal_of_match_hw_bin_group(np, hw, levels, i)) {
+			u32 utmp;
+
+			if (of_property_read_u32_index(np, "temperature-bin",
+						       i, &utmp))
+				return -EINVAL;
+			*temp = (s32)utmp;
+			return 0;
+		}
+	}
+
+	pr_warn("%pOF: no thermal-hw-bin sub-group matched for temperature-bin\n", np);
 	return -ENODEV;
 }
 
 static int thermal_of_populate_trip(struct device_node *np,
-				    struct thermal_trip *trip)
+				    struct thermal_trip *trip,
+				    const struct thermal_hw_bin_info *hw)
 {
 	u32 hysteresis;
 	s32 temperature;
 	int ret;
 
-	ret = of_property_read_s32(np, "temperature", &temperature);
-	if (ret < 0) {
-		pr_err("missing temperature property\n");
-		return ret;
+	if (!thermal_of_trip_is_supported(np, hw)) {
+		pr_debug("%pOF: trip skipped: no thermal-hw-bin match\n", np);
+		return -ENODEV;
 	}
+
+	ret = thermal_of_trip_read_temperature(np, hw, &temperature);
+	if (ret)
+		return ret;
 	trip->temperature = temperature;
 
 	ret = of_property_read_u32(np, "hysteresis", &hysteresis);
@@ -94,7 +241,9 @@ static int thermal_of_populate_trip(struct device_node *np,
 	return 0;
 }
 
-static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *ntrips)
+static struct thermal_trip *thermal_of_trips_init(struct device_node *np,
+						  int *ntrips,
+						  const struct thermal_hw_bin_info *hw)
 {
 	int ret, count;
 
@@ -114,9 +263,12 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 
 	count = 0;
 	for_each_child_of_node_scoped(trips, trip) {
-		ret = thermal_of_populate_trip(trip, &tt[count++]);
+		ret = thermal_of_populate_trip(trip, &tt[count], hw);
+		if (ret == -ENODEV)
+			continue;
 		if (ret)
 			return ERR_PTR(ret);
+		count++;
 	}
 
 	*ntrips = count;
@@ -364,27 +516,24 @@ static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 }
 
 /**
- * thermal_of_zone_register - Register a thermal zone with device node
- * sensor
+ * thermal_of_zone_register_with_bin - Register a thermal zone with device node
+ * sensor and optional hardware binning info
  *
- * The thermal_of_zone_register() parses a device tree given a device
- * node sensor and identifier. It searches for the thermal zone
- * associated to the couple sensor/id and retrieves all the thermal
- * zone properties and registers new thermal zone with those
- * properties.
- *
- * @sensor: A device node pointer corresponding to the sensor in the device tree
- * @id: An integer as sensor identifier
- * @data: A private data to be stored in the thermal zone dedicated private area
- * @ops: A set of thermal sensor ops
+ * @sensor:   A device node pointer corresponding to the sensor in the device tree
+ * @id:       An integer as sensor identifier
+ * @data:     A private data to be stored in the thermal zone dedicated private area
+ * @ops:      A set of thermal sensor ops
+ * @hw_bin_info: Optional hardware binning info for trip filtering (may be NULL)
  *
  * Return: a valid thermal zone structure pointer on success.
  *	- EINVAL: if the device tree thermal description is malformed
  *	- ENOMEM: if one structure can not be allocated
  *	- Other negative errors are returned by the underlying called functions
  */
-static struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
-							    const struct thermal_zone_device_ops *ops)
+static struct thermal_zone_device *
+thermal_of_zone_register_with_bin(struct device_node *sensor, int id, void *data,
+				  const struct thermal_zone_device_ops *ops,
+				  const struct thermal_hw_bin_info *hw_bin_info)
 {
 	struct thermal_zone_device_ops of_ops = *ops;
 	struct thermal_zone_device *tz;
@@ -403,7 +552,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		return ERR_CAST(np);
 	}
 
-	trips = thermal_of_trips_init(np, &ntrips);
+	trips = thermal_of_trips_init(np, &ntrips, hw_bin_info);
 	if (IS_ERR(trips)) {
 		pr_err("Failed to parse trip points for %pOFP id=%d\n", sensor, id);
 		ret = PTR_ERR(trips);
@@ -461,6 +610,26 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	return ERR_PTR(ret);
 }
 
+/**
+ * thermal_of_zone_register - Register a thermal zone with device node sensor
+ *
+ * @sensor: A device node pointer corresponding to the sensor in the device tree
+ * @id:     An integer as sensor identifier
+ * @data:   A private data to be stored in the thermal zone dedicated private area
+ * @ops:    A set of thermal sensor ops
+ *
+ * Return: a valid thermal zone structure pointer on success.
+ *	- EINVAL: if the device tree thermal description is malformed
+ *	- ENOMEM: if one structure can not be allocated
+ *	- Other negative errors are returned by the underlying called functions
+ */
+static struct thermal_zone_device *
+thermal_of_zone_register(struct device_node *sensor, int id, void *data,
+			 const struct thermal_zone_device_ops *ops)
+{
+	return thermal_of_zone_register_with_bin(sensor, id, data, ops, NULL);
+}
+
 static void devm_thermal_of_zone_release(struct device *dev, void *res)
 {
 	thermal_of_zone_unregister(*(struct thermal_zone_device **)res);
@@ -510,6 +679,46 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_zone_register);
 
+/**
+ * devm_thermal_of_zone_register_with_bin - register a thermal zone with hardware binning info
+ *
+ * Like devm_thermal_of_zone_register(), but passes @hw_bin_info to the trip-point
+ * parser so that trips can be filtered and per-bin temperatures selected at
+ * zone registration time.  Use this when fuse values are read before zone
+ * registration (e.g. in a platform driver's probe function).
+ *
+ * @dev:         device structure pointer to sensor
+ * @id:          the sensor identifier
+ * @data:        private data stored in the thermal zone 'devdata' field
+ * @ops:         ops structure associated with the sensor
+ * @hw_bin_info: hardware binning info for trip filtering (may be NULL)
+ */
+struct thermal_zone_device *
+devm_thermal_of_zone_register_with_bin(struct device *dev, int id, void *data,
+				       const struct thermal_zone_device_ops *ops,
+				       const struct thermal_hw_bin_info *hw_bin_info)
+{
+	struct thermal_zone_device **ptr, *tzd;
+
+	ptr = devres_alloc(devm_thermal_of_zone_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	tzd = thermal_of_zone_register_with_bin(dev->of_node, id, data,
+						ops, hw_bin_info);
+	if (IS_ERR(tzd)) {
+		devres_free(ptr);
+		return tzd;
+	}
+
+	*ptr = tzd;
+	devres_add(dev, ptr);
+
+	return tzd;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_of_zone_register_with_bin);
+
 /**
  * devm_thermal_of_zone_unregister - Resource managed version of
  *				thermal_of_zone_unregister().
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 306ad17aed89..e9e4b2dc2824 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -86,6 +86,23 @@ struct thermal_trip {
 #define THERMAL_TRIP_PRIV_TO_INT(_val_)	(uintptr_t)(_val_)
 #define THERMAL_INT_TO_TRIP_PRIV(_val_)	(void *)(uintptr_t)(_val_)
 
+/* Matches the maxItems: 4 constraint on the thermal-hw-bin binding. */
+#define THERMAL_HW_BIN_MAX_LEVELS	4
+
+/**
+ * struct thermal_hw_bin_info - platform-specific hardware binning description
+ * @supported_hw_bin: array of bitfields identifying the running hardware version
+ * @supported_hw_bin_count: number of valid entries in @supported_hw_bin
+ *
+ * Filled by platform code that decodes SoC revision / fuse information.
+ * Shared with the thermal OF parser to filter trip points and select
+ * per-bin temperatures via the thermal-hw-bin / temperature-bin DT properties.
+ */
+struct thermal_hw_bin_info {
+	const u32	*supported_hw_bin;
+	unsigned int	 supported_hw_bin_count;
+};
+
 struct cooling_spec {
 	unsigned long upper;	/* Highest cooling state  */
 	unsigned long lower;	/* Lowest cooling state  */
@@ -216,6 +233,12 @@ devm_thermal_of_child_cooling_device_register(struct device *dev,
 					      struct device_node *np,
 					      const char *type, void *devdata,
 					      const struct thermal_cooling_device_ops *ops);
+
+struct thermal_zone_device *
+devm_thermal_of_zone_register_with_bin(struct device *dev, int id, void *data,
+				       const struct thermal_zone_device_ops *ops,
+				       const struct thermal_hw_bin_info *hw_bin_info);
+
 #else
 
 static inline
@@ -254,6 +277,15 @@ devm_thermal_of_child_cooling_device_register(struct device *dev,
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline struct thermal_zone_device *
+devm_thermal_of_zone_register_with_bin(struct device *dev, int id, void *data,
+				       const struct thermal_zone_device_ops *ops,
+				       const struct thermal_hw_bin_info *hw_bin_info)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 #endif
 
 int for_each_thermal_trip(struct thermal_zone_device *tz,

-- 
2.34.1

