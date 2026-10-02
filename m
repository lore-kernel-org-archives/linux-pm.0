Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA51048595E
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938051; cv=none; b=g+0S/s+rcl4se1Tk7QbzkE81EClO1xRpJ4xtShMtF2JItvHSJcNlvqB2aI5qwdxvaULCwxUzusnqFIgZ8PfLJ3R4L12eg8MLIIDWz8r9z7n1M2uWPBuoBUbDP20RhZphgYux4qmnK12e1Mj3lvxsFuNotRt51lKiRkaIC6/d4Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938051; c=relaxed/simple;
	bh=uAuIlC9+GH5PSJbGiPZIRo2KEQfrlnn+AiCdbSenVUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bppfjmzY8HuO6rC9RZ1bi9SfjVhRkrjEdaaDJTKWBdCzrCfIbF1YT3qoGTMcHkn6S9kKBt7IMPTZ4S5P9OYhjsf47BMT9mo0bKVfWqoAtRW1/kk8eGk8g3kG+beW/+CuPxqnlZqKbCGuRxqF9fYzz18wRtmIGOTPLypW8Q9lZ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qb48jN1v; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bcM2Rqsn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qb48jN1v";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bcM2Rqsn"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6929nhGu3935404
	for <linux-pm@vger.kernel.org>; Fri, 2 Oct 2026 10:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fob5svhOF2c/zZlbsOR4LmadaafDcoFLLbvGqliPgok=; b=Qb48jN1v2rX2aAVs
	Ekb9qTVM01+Of5ZD2LNLuYGDo7dpzv403AWyrlzcEnwo38OWCciCm0Mvnsx8XRpt
	9ywL0nvT/HLNADdLzWp60cixPsU78YcY5Kb8Hm0tpBSZn+1goVmUQxvWzWc3/MmN
	syHeBHwf3YGK22BFenxk6uGaJoIlNMbtTtCROSFqQKX57x922CXAW2ZLEi8Qb/UK
	ODwkitVmrRasyY72BO2XmHPHBkgZrvE15CXCMfeMSX43T2y/Hv7u0pnMM7H3u81n
	Sp8pMfAuONTcA0UXTTNAOzFTqT/oXLRkOhHEx8U22VQUWhxgVt4WtTzJPuzeNATV
	rzQhug==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1vxearcy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 10:47:26 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-14fc5852326so436379c88.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 03:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790938046; x=1791542846; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fob5svhOF2c/zZlbsOR4LmadaafDcoFLLbvGqliPgok=;
        b=bcM2RqsnmKVhHbmmER7gCV+/6l/1FuB4HMndILX1UErWuU7kAM6W2+E+UagHlUU7LG
         hBxS5BrHnbeOAelUVpwp4VJ/YU+tsguruOE8Jac5i2/R+rNNuvFxYGiTUXAfg+/J3/u1
         18diLEo6LwL6A/kKWVho3pt3avYoxi3flm0myADdkqyW4MfDcTmdHCkSIy9YNDFTNeOK
         LDL2/8u8NeVajGGgCaFrmqg8ulYKeSQSSnFBNY8KkD/nb4d66j65t9W7p9DY+GufrgGK
         Zb/tSr9mHeop9coCq/Jbmm/tWhlngkoFTVvBPZMGg2MYtNds3Q7uzW+FHAZCDPl99glx
         /AFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938046; x=1791542846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fob5svhOF2c/zZlbsOR4LmadaafDcoFLLbvGqliPgok=;
        b=0mPvfNIVqiza2umnK7q2IAcZ1nQeNodu7WBBc3t1ap80zVu9WMRRr7A01bvP/GkXZ9
         0QfjoTmom7/4AAVUHL1cIdmkXYI7zo0/rDYx++zNU05+tqzU9X1WcYMIoegJogrefBe9
         8HgBUGryk623lbNsCLX/kmTFnMslUzK/Mt1YbwU5WKFFBa127YcC4b5A3lQn7vz9O//I
         Vm/bG11Vk7sK4Nqsug6a651wpw+evyGwB7CDutwpvIFJP1utuYgdSS7bQHyQiMsQ1jUK
         FOFPZqYqxmvslEuPoDNpmaaoerIxIa6GRi1zQ2eSGVPtWczuFey83w7Im3AekG7CFNEz
         VWlg==
X-Gm-Message-State: AFuF++lpRxhJJwYK3V905J2HKsItsL40nuFVGpuKf8dupui1r9H/3HcB
	b+TZHC4gXoMRJEAoPdiPuFmu4NXoqW+JPRWCD2Myk4dNTJUZhbVwBM4VSLFbHbGpeRexCztpZRm
	bHyrgRsykadEWy7DNpO6wXNed+92HqjpepvB107cTZt5z/SQ/ZeNs2eFjJg/nKw==
X-Gm-Gg: AYBFou0aVGj+PwMqvf6vNurrv0pOol9Rkk9ihYuUVCUrtKxnp+V0wLysHQNsKlnZkGx
	P9EPphAJlaVkj69oyfvAh8A/cg/Ib6Na7TJaY6+f/jVeY44Y2QVtR/21G3KKtOzbZ0/SxyaDiFS
	MBJMbQPpEByUr5MpvaGQUMRlRWdA6cW46L6ejklZdT2tI92bHbc5rwuFzPrepHFibiQ1FHPEfKv
	ZNH/m8kQkvOxL9Dd0I6P8dqaGUWVGywt1gTouvyORULErJRopDdvmAYHQ9ZHdWlsTBJ5JeAHH9Q
	Q/SgyJqyazhzgLM6KVtmB0LXXHToY6VaR24JHDPcMwotIbLQ9VDylhuQ99r8BbiJvSauJ6IVKRF
	3ox1o3BIYrHZ+Jztc+lNVVJzILDay
X-Received: by 2002:a05:701b:2915:b0:14d:6b42:c8b0 with SMTP id a92af1059eb24-14f5bc0031amr2472214c88.7.1790938044685;
        Fri, 02 Oct 2026 03:47:24 -0700 (PDT)
X-Received: by 2002:a05:701b:2915:b0:14d:6b42:c8b0 with SMTP id a92af1059eb24-14f5bc0031amr2472097c88.7.1790938042880;
        Fri, 02 Oct 2026 03:47:22 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f45fedd43sm10645191c88.4.2026.10.02.03.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:47:22 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 02 Oct 2026 16:16:57 +0530
Subject: [PATCH 2/6] thermal: add hardware-binning trip-point filtering
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-thermal_bin-v1-2-5a29be7e8ec5@oss.qualcomm.com>
References: <20261002-thermal_bin-v1-0-5a29be7e8ec5@oss.qualcomm.com>
In-Reply-To: <20261002-thermal_bin-v1-0-5a29be7e8ec5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790938020; l=33020;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=AwWqNxaiR3nRHO32aWRUzrypt/fVo7vwmYJh11vaL1o=;
 b=ZX+z/e/dTrBdTqdnTcwafQRDQTJJvZq+eK2ItvYjpsnZIs5QD/Kbmsn+Tc/PuC0OCefMDnQ1q
 LrJ4xAJWmjTBuocuTmFUXYLkkcuHH6d6YzfdUyWsHxihXO8ebm/lCQB
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Authority-Analysis: v=2.4 cv=fdc4WEQF c=1 sm=1 tr=0 ts=6abf8bbf cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=EPnjrnW5xBTLgY6r9OwA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: cqr3XOjUmSg0ijaVWHewtzr3yYta3dC8
X-Proofpoint-ORIG-GUID: cqr3XOjUmSg0ijaVWHewtzr3yYta3dC8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0MiBTYWx0ZWRfX4yQbtObRNl2i
 MJ/++aBfHvs83EcVls1DNmkAC/tbZ0wc5z3wbL/QOG+TEVwPuMxbeT7PPc4YqwJFzORDQFTI/E9
 UQchs3sSjNrpGIJWxdKlKEOqP0Y/CiQn+n5Wa5l4TKVSL9Sx2VUZT546P6aF0Hda8CFIGpkbVp4
 fMPCVgG+ZN+UVE660/aY6Ylv2m8TcqfzQzbkDx108u2fYldPG+VPSbnmW4Jo+LPYTupPM80jZdZ
 +3GozcEtP66bYYLzGKir7ObV7Mne8AQNsUR/JJtj0U1akg57cffsr+LPdMxf74MzxsTHb+LTy8m
 vykZMY7bBbb/qxGzyDzo5gB2Qgt07MiAvyZ7h6ffH9HjpGuJqaLSZ+yTmtJqNii1p4/Q2IMlrT6
 6os8t5rt1alsb8EZjUvbUQHbc3519X9xQLgwZW29Oa+d0lBXpY/t6oimM27Tk+2RGmlDnw3iUXe
 X9VRS/EP+gcelYjS9KQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0MiBTYWx0ZWRfX1tso2YBe6hWc
 0jFWFK1zCnHYDLSQfdQlfGC2PFLQ4jSZ+/SY/CNwy08YYTimwYWnKVLh8v4Ph77uQ/aV1K+dfFU
 QTxhRsqDRdj/vq6fevYoYhea0D+00Vc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020042

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

Add the thermal core/OF framework support (a new THERMAL_BIN config and
thermal_bin.c providing the thermal_zone_set_supported_hw_bin() API, OF
parsing of the 'thermal-hw-bin' and 'temperature-bin' DT properties) and
document the feature.

Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 .../driver-api/thermal/hardware-binning.rst        | 151 ++++++++++++
 Documentation/driver-api/thermal/index.rst         |   1 +
 MAINTAINERS                                        |   2 +
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/thermal_bin.c                      | 135 +++++++++++
 drivers/thermal/thermal_core.h                     |   5 +
 drivers/thermal/thermal_of.c                       | 253 +++++++++++++++++++--
 include/linux/thermal.h                            |  77 +++++++
 9 files changed, 613 insertions(+), 22 deletions(-)

diff --git a/Documentation/driver-api/thermal/hardware-binning.rst b/Documentation/driver-api/thermal/hardware-binning.rst
new file mode 100644
index 000000000000..fcb8cdd8b2d1
--- /dev/null
+++ b/Documentation/driver-api/thermal/hardware-binning.rst
@@ -0,0 +1,151 @@
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
+The feature is built when ``CONFIG_THERMAL_BIN`` is selected.  It depends on
+``CONFIG_THERMAL_OF`` and is normally selected by the platform sensor driver
+(for example the Qualcomm tsens driver) rather than chosen directly.
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
+  words the platform registered (``supported_hw_bin_count``, see below).  The
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
+There are two ways to supply this information:
+
+At registration time
+  Pass a filled ``struct thermal_hw_bin_info`` to
+  ``devm_thermal_of_zone_register_with_bin()``.  This is the preferred path
+  when the platform driver registers its own zones and already knows the
+  hardware version, because the bin info is in place before the trips are
+  parsed::
+
+      struct thermal_zone_device *
+      devm_thermal_of_zone_register_with_bin(struct device *dev, int id,
+                                             void *data,
+                                             const struct thermal_zone_device_ops *ops,
+                                             const struct thermal_hw_bin_info *hw_bin_info);
+
+After registration
+  Call ``thermal_zone_set_supported_hw_bin()`` (or the devm-managed
+  ``devm_thermal_zone_set_supported_hw_bin()``) on an already-registered
+  zone::
+
+      int thermal_zone_set_supported_hw_bin(struct thermal_zone_device *tz,
+                                            const u32 *vers, unsigned int count);
+      int devm_thermal_zone_set_supported_hw_bin(struct device *dev,
+                                                 struct thermal_zone_device *tz,
+                                                 const u32 *vers, unsigned int count);
+
+  Both copy ``vers`` into storage owned by the zone's parent device (the copy
+  is freed via devm when that device is unbound), so the caller's array need
+  not outlive the call.  ``count`` must be ``1 .. THERMAL_HW_BIN_MAX_LEVELS``
+  and the zone must have a parent device.
+
+  ``thermal_zone_get_hw_bin_info()`` returns the bin info previously set on a
+  zone, or NULL if none has been set.
+
+Concurrency
+===========
+
+Bin info is published once, at probe, before the zone's trips are parsed, and
+cleared once at unbind.  The ``supported_hw_bin`` pointer is the publish gate:
+``thermal_zone_set_supported_hw_bin()`` stores it with ``smp_store_release()``
+after filling the array and count, and ``thermal_zone_get_hw_bin_info()`` reads
+it with ``smp_load_acquire()``.  A reader that observes a non-NULL pointer is
+therefore guaranteed to see a consistent ``supported_hw_bin_count`` and array
+and may dereference them without further barriers.  There is no lock guarding
+concurrent writers: drivers must not race two set/clear operations against each
+other.
+
+When a build does not have ``CONFIG_THERMAL_BIN`` enabled, the
+``thermal_zone_set_supported_hw_bin()`` family returns ``-EOPNOTSUPP`` and
+``thermal_zone_get_hw_bin_info()`` returns NULL via inline stubs, so callers
+compile unconditionally.
+
+If a trip uses ``temperature-bin`` but no bin info has been registered for the
+zone, the core cannot select an entry; it warns once and falls back to the
+first ``temperature-bin`` value.  Platform drivers should therefore register
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
index 6e50747a621c..e0e65cef6a74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27343,7 +27343,9 @@ F:	Documentation/ABI/testing/sysfs-class-thermal
 F:	Documentation/admin-guide/thermal/
 F:	Documentation/devicetree/bindings/thermal/
 F:	Documentation/driver-api/thermal/
+F:	Documentation/driver-api/thermal/hardware-binning.rst
 F:	drivers/thermal/
+F:	drivers/thermal/thermal_bin.c
 F:	include/dt-bindings/thermal/
 F:	include/linux/cpu_cooling.h
 F:	include/linux/thermal.h
diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 810eeccedfba..da553dcd8e86 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -92,6 +92,16 @@ config THERMAL_OF
 	  Say 'Y' here if you need to build thermal infrastructure
 	  based on device tree.
 
+config THERMAL_BIN
+	bool
+	depends on THERMAL_OF
+	help
+	  Enables hardware-bin trip-point filtering for thermal zones.
+	  Platform drivers that read SoC fuse or hardware-revision values
+	  to select per-bin trip temperatures can use this API to register
+	  hardware-version information with a thermal zone via
+	  thermal_zone_set_supported_hw_bin() and friends.
+
 choice
 	prompt "Default Thermal governor"
 	default THERMAL_DEFAULT_GOV_STEP_WISE
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 3b249195c088..e91ba57fd1df 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -16,6 +16,7 @@ thermal_sys-$(CONFIG_THERMAL_DEBUGFS)	+= thermal_debugfs.o
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
 thermal_sys-$(CONFIG_THERMAL_OF)		+= thermal_of.o
+thermal_sys-$(CONFIG_THERMAL_BIN)		+= thermal_bin.o
 
 # governors
 CFLAGS_gov_power_allocator.o			:= -I$(src)
diff --git a/drivers/thermal/thermal_bin.c b/drivers/thermal/thermal_bin.c
new file mode 100644
index 000000000000..ef0961981369
--- /dev/null
+++ b/drivers/thermal/thermal_bin.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * thermal_bin.c - hardware-version bin-info registration for thermal zones
+ *
+ * Provides thermal_zone_set_supported_hw_bin() and friends, which allow platform
+ * drivers to register SoC fuse / hardware-version information with a thermal
+ * zone so that the OF trip-point parser can filter trips and select per-bin
+ * temperatures via the 'thermal-hw-bin' and 'temperature-bin' DT properties.
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+
+#include "thermal_core.h"
+
+/**
+ * thermal_zone_set_supported_hw_bin - register hardware-version info with a zone
+ * @tz:    thermal zone device
+ * @vers:  array of hardware-version bitfields (one word per level)
+ * @count: number of entries in @vers (must be <= THERMAL_HW_BIN_MAX_LEVELS)
+ *
+ * Stores a copy of @vers in @tz->hw_bin_info so that the thermal OF parser can
+ * match trip-point thermal-hw-bin sub-groups against the running hardware.
+ * The copy is managed by the zone's parent device via devm.
+ *
+ * Locking: the @supported_hw_bin pointer is the publish/consume gate for the
+ * whole struct.  It is written last, with smp_store_release(), so that the
+ * copied array contents and @supported_hw_bin_count are guaranteed visible to
+ * any reader that observes a non-NULL pointer via thermal_zone_get_hw_bin_info()
+ * (which uses the paired smp_load_acquire()).  This is a one-shot contract:
+ * the platform driver publishes the bin info exactly once at probe, before the
+ * zone is exposed to the OF trip parser, and the devm cleanup clears it once at
+ * unbind.  There is no lock guarding concurrent publishers; callers must not
+ * race two set/clear operations against each other.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int thermal_zone_set_supported_hw_bin(struct thermal_zone_device *tz,
+				      const u32 *vers, unsigned int count)
+{
+	u32 *copy;
+
+	if (WARN_ON(!tz || !vers || !count || count > THERMAL_HW_BIN_MAX_LEVELS))
+		return -EINVAL;
+
+	/*
+	 * The copy is allocated against the zone's parent device so that it
+	 * is freed when that device goes away.  Reject zones registered
+	 * without a parent rather than scribbling on dev=NULL inside devm.
+	 */
+	if (!tz->device.parent)
+		return -EINVAL;
+
+	copy = devm_kmemdup(tz->device.parent, vers, count * sizeof(u32),
+			    GFP_KERNEL);
+	if (!copy)
+		return -ENOMEM;
+
+	tz->hw_bin_info.supported_hw_bin_count = count;
+	/*
+	 * Publish the pointer last: the release pairs with the acquire in
+	 * thermal_zone_get_hw_bin_info() and orders the array contents and the
+	 * count above before a reader can observe the non-NULL pointer.
+	 */
+	smp_store_release(&tz->hw_bin_info.supported_hw_bin, copy);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_set_supported_hw_bin);
+
+static void devm_thermal_zone_clear_supported_hw_bin(void *data)
+{
+	struct thermal_zone_device *tz = data;
+
+	/*
+	 * Retract the gate first with a release store so a reader either sees
+	 * the fully-published info or nothing; the count is cleared after.
+	 */
+	smp_store_release(&tz->hw_bin_info.supported_hw_bin, NULL);
+	tz->hw_bin_info.supported_hw_bin_count = 0;
+}
+
+/**
+ * devm_thermal_zone_set_supported_hw_bin - managed variant of thermal_zone_set_supported_hw_bin
+ * @dev:   device whose lifetime governs the cleanup action
+ * @tz:    thermal zone device
+ * @vers:  array of hardware-version bitfields
+ * @count: number of entries in @vers
+ *
+ * Like thermal_zone_set_supported_hw_bin(), but registers a devm cleanup action on
+ * @dev that clears the hw_bin_info when @dev is unbound.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int devm_thermal_zone_set_supported_hw_bin(struct device *dev,
+					   struct thermal_zone_device *tz,
+					   const u32 *vers, unsigned int count)
+{
+	int ret;
+
+	ret = thermal_zone_set_supported_hw_bin(tz, vers, count);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev,
+					devm_thermal_zone_clear_supported_hw_bin,
+					tz);
+}
+EXPORT_SYMBOL_GPL(devm_thermal_zone_set_supported_hw_bin);
+
+/**
+ * thermal_zone_get_hw_bin_info - retrieve hardware-version info from a zone
+ * @tz: thermal zone device (may be NULL)
+ *
+ * Return: pointer to the zone's thermal_hw_bin_info if supported_hw_bin has been
+ *         set, or NULL if @tz is NULL or no hardware-version info is present.
+ *
+ * The gating read uses smp_load_acquire() to pair with the smp_store_release()
+ * in thermal_zone_set_supported_hw_bin(): once a non-NULL pointer is observed,
+ * the array contents and supported_hw_bin_count are guaranteed visible, so the
+ * caller may dereference the returned struct's fields without further barriers.
+ */
+const struct thermal_hw_bin_info *
+thermal_zone_get_hw_bin_info(const struct thermal_zone_device *tz)
+{
+	/* Pairs with smp_store_release() in thermal_zone_set_supported_hw_bin() */
+	if (!tz || !smp_load_acquire(&tz->hw_bin_info.supported_hw_bin))
+		return NULL;
+
+	return &tz->hw_bin_info;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_hw_bin_info);
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 7ef7c6cab437..6e5f090f5140 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -114,6 +114,8 @@ struct thermal_governor {
  * @state: 	current state of the thermal zone
  * @debugfs:	this thermal zone device's thermal zone debug info
  * @user_thresholds: list of userspace thresholds for temp. limit notifications
+ * @hw_bin_info:	hardware binning info for trip filtering (set by platform driver,
+ *		only present when CONFIG_THERMAL_BIN is enabled)
  * @trips:	array of struct thermal_trip objects
  */
 struct thermal_zone_device {
@@ -152,6 +154,9 @@ struct thermal_zone_device {
 	struct thermal_debugfs *debugfs;
 #endif
 	struct list_head user_thresholds;
+#ifdef CONFIG_THERMAL_BIN
+	struct thermal_hw_bin_info hw_bin_info;
+#endif
 	struct thermal_trip_desc trips[] __counted_by(num_trips);
 };
 
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index fe47d74b7219..8cc5b5aa141c 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -60,18 +60,165 @@ static int thermal_of_get_trip_type(struct device_node *np,
 	return -ENODEV;
 }
 
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
+					    int *temp)
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
+	levels   = hw->supported_hw_bin_count;
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
+	return -ENODEV;
+}
+
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
- *
- * The thermal_of_zone_register() parses a device tree given a device
- * node sensor and identifier. It searches for the thermal zone
- * associated to the couple sensor/id and retrieves all the thermal
- * zone properties and registers new thermal zone with those
- * properties.
+ * thermal_of_zone_register_with_bin - Register a thermal zone with device node
+ * sensor and optional hardware binning info
  *
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
index 306ad17aed89..ba2553a361cb 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -86,6 +86,34 @@ struct thermal_trip {
 #define THERMAL_TRIP_PRIV_TO_INT(_val_)	(uintptr_t)(_val_)
 #define THERMAL_INT_TO_TRIP_PRIV(_val_)	(void *)(uintptr_t)(_val_)
 
+/*
+ * Maximum number of hardware-version words per call to
+ * thermal_zone_set_supported_hw_bin(). Matches the maxItems: 4 constraint
+ * on the thermal-hw-bin device tree binding.
+ */
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
+ *
+ * @supported_hw_bin doubles as the publish/consume gate for this struct: it is
+ * stored with smp_store_release() by thermal_zone_set_supported_hw_bin() and
+ * read with smp_load_acquire() by thermal_zone_get_hw_bin_info(), so a reader
+ * that observes a non-NULL pointer also sees a consistent
+ * @supported_hw_bin_count and array. Publishing is one-shot at probe; there is
+ * no lock for concurrent writers.
+ */
+struct thermal_hw_bin_info {
+	const u32	*supported_hw_bin;
+	unsigned int	 supported_hw_bin_count;
+};
+
 struct cooling_spec {
 	unsigned long upper;	/* Highest cooling state  */
 	unsigned long lower;	/* Lowest cooling state  */
@@ -216,6 +244,12 @@ devm_thermal_of_child_cooling_device_register(struct device *dev,
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
@@ -254,6 +288,49 @@ devm_thermal_of_child_cooling_device_register(struct device *dev,
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
+#endif
+
+#ifdef CONFIG_THERMAL_BIN
+int thermal_zone_set_supported_hw_bin(struct thermal_zone_device *tz,
+				      const u32 *vers, unsigned int count);
+int devm_thermal_zone_set_supported_hw_bin(struct device *dev,
+					   struct thermal_zone_device *tz,
+					   const u32 *vers, unsigned int count);
+const struct thermal_hw_bin_info *
+thermal_zone_get_hw_bin_info(const struct thermal_zone_device *tz);
+
+#else
+
+static inline int
+thermal_zone_set_supported_hw_bin(struct thermal_zone_device *tz,
+				  const u32 *vers, unsigned int count)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int
+devm_thermal_zone_set_supported_hw_bin(struct device *dev,
+				       struct thermal_zone_device *tz,
+				       const u32 *vers, unsigned int count)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline const struct thermal_hw_bin_info *
+thermal_zone_get_hw_bin_info(const struct thermal_zone_device *tz)
+{
+	return NULL;
+}
+
 #endif
 
 int for_each_thermal_trip(struct thermal_zone_device *tz,

-- 
2.34.1

