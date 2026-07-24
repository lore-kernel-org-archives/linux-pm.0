Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF46C3A8735
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784877547; cv=none; b=I6+8K5/LqKWf/5D1xv/VKgeww5riw8IWXILPcBl8kZiLzsvWtcfy7rNkXcERKQdVIRq6VzW5yJRU34yrWbuy+dLzBs8ylM50otzdUoE4GJ/9OmIip01nLoNtw6Kf/u2Ec5exstnamZoulCulH8jKXh13L3CyjpXhqYxuLTeyFk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784877547; c=relaxed/simple;
	bh=P4iLWqSOx8m4l5BwsyeRQVXBUvaN2sg1EaB/FNylOQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NXMkrVH6JoGKa/qjFkS/nF4Goi0ffZke09TMttbTSlaEhP1q9/6vNYAeOQMAX+yWFBTO1PldKWlJU6DWBXSoUepIHcziait8uwh/RcjXCerdNc1A2zcAG4ngF+ZHiwLg/zNEKfI2p7C92O9Gg+Cb9sCWnXTsox/b5iGayBJkDsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d/PWweqI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c+TjeMPJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d/PWweqI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c+TjeMPJ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4lPv02276539
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4ktNg6XJGZ2meMDmQflSETM8JP37ditLRaUIshpuxOE=; b=d/PWweqIGWVCxUHC
	HvPFM8bStcXRlxjXXn68ojRKyBh3wjFvECKFYVZfm9e6B8H8o3crX+hQEtrlpDCo
	miPzlzM3PGbQuSMCWZXidodK4lfbqRlBWaKx8K9MKNKK8fkdjU2UW9olvhij+eIR
	BQHUeHo2OO8gqkHVtR8O4sBD/3cR1Uq0lJp0uG/nF9/V7D8t79ODdtV2C/qM7czi
	CGgVEzDhpylkNKBj4ta2p4nmjEN9v8FcsuvJqp1l1FCYHGaHPwvRpCBdX77PCXNd
	IemkKsQ9Thhl6C2xc+IkMmWp2VxKdIH+lHgQwz+WieN26C7+JWD1bPalQKveHK+k
	SWT/GA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa0ak3t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccb6823efcso1688585ad.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 00:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784877544; x=1785482344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ktNg6XJGZ2meMDmQflSETM8JP37ditLRaUIshpuxOE=;
        b=c+TjeMPJKRmmqxisQcT3oXBmbNnElXCeDSOdBqY9OykpCVuGp6ZmMbjZ8MhVC+DTRt
         t/WH+L/1metRL9bNVjv3ivV9cvxGRBNSP/E1LNQVUzVQKeLq7Uv04M6Ou72ln/hhba16
         L9hW92Y1RaSRZWcUP5+a77iRiJ1wKex0hYe6ew28juhABIIoR3rY+lUUWbsc1tSbV+Hd
         S53rJkxuGeo636QQZLd1af1aYecopUSjaAn6BEVuMBmsXsYl087M5yzj5jjbzuvbGenX
         /d3d/6ku/64yFxmq+/UoDo4U18R6jLBd12UOY0LqadOlNFHqnmNU9Un4EUUsu3nhk8eZ
         i6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784877544; x=1785482344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ktNg6XJGZ2meMDmQflSETM8JP37ditLRaUIshpuxOE=;
        b=AsKyom7BZvyRlXj/pp0XoTEsA1r8ufNo7VsGpFa0mN2FbLH95VCSxd70vq2MJb4QZB
         9lgQ1bEpbORUcIwsXpI+L1xhuooK91SyDLjZpnrH974iHQkwM1Kgv4LqprD5FoIcWisd
         aBV8WAi0YO0eCh4A7fGOmjNdACGGlUIf/QVzDfSLEsdkDoaHJfbyoLnkEYtcEdolHKfB
         rHTxeURpieiUT5GouJCRMs1a8vGVwSo7cGwKoi1bZRYXciKR6ppRrCIk5uuL5UXjNgD6
         C6fr2LwbViF+Ak66gy1boE0Gh9EJ45HwSzctmkenVxcT/byS2XDMVXKqv44tYJopEHa2
         SZ2w==
X-Forwarded-Encrypted: i=1; AHgh+Rrz6iTIid4qvfPP88patgY17bo91U3ew+zk7m0EFptNnDeTldTRZx8UIJ3Y1HOEU7c21IasukBM3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJys4HT6UYtzdmVi3FnWmdc+0wvhGfORVGAXLAdHU9nzABApEZ
	hcg61j/BZmf0CMpwZVVHckI235i/g/Ffns+/DbXUN0nOdwp9/yn2lzNZ3nLJ3R7KLMgwNqC2Wzv
	4OMgAEMBfOa5tPerpI7fiktWfYv7IxxBKx9MDbUpClm0sVC7A8DvLYaBsRWjhbA==
X-Gm-Gg: AR+sD101IioI7pCFiVOdnXULkjgPyAT0G4szjgoevepVZ2LidxAC4qvWcNK3Bb6Hw4K
	9tx5kQCnbnzstowBLFOn/WU7/RCHUlcP0XLXrgOt3gMzz/r/U/FmRUktK/kU0dceW7nLjD0VKC4
	p/27m8NUdHakBZZiU8Qxj+auGH5/cPUJaP3D1YKQJErsMapTxT8rdWk7/FnrVoAjV5hWlRj+Xlc
	r9q9eedQJH8YN5N/cZ+mvGT7C4L/vBOhj6fiK7NbvMykplUB+Yb3lj9pLM64+/vmETJSRIr0iEd
	H5yq8ly9UE/kffJmKXlUFkUkaUVyJwLh67j84u1vaDR/sZeKggss/0YCVvlkICkBzGPlnWrCR4c
	QTPWLUrg/EiBduEjsoXIQ1O0aJOfuwgbhMqeYRKDP2SjWQ0y/HNHXTiUUeF1YVmAOuBNpMx0Z3D
	9Jm1v0rBnZ1V3VY+bQFF7qXmRAfXo=
X-Received: by 2002:a17:902:cece:b0:2c0:e5ee:f55e with SMTP id d9443c01a7336-2cfa6a4b3dbmr74815105ad.7.1784877544171;
        Fri, 24 Jul 2026 00:19:04 -0700 (PDT)
X-Received: by 2002:a17:902:cece:b0:2c0:e5ee:f55e with SMTP id d9443c01a7336-2cfa6a4b3dbmr74814865ad.7.1784877543679;
        Fri, 24 Jul 2026 00:19:03 -0700 (PDT)
Received: from hu-ppapaniy-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efe3afbsm45993805ad.33.2026.07.24.00.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 00:19:03 -0700 (PDT)
From: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 12:48:08 +0530
Subject: [PATCH RFC 03/10] firmware: arm_scmi: vendors: Add QCOM SCMI
 Generic Extensions
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-rfc_v8_scmi_memlat-v1-3-cb732bcff1f4@oss.qualcomm.com>
References: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
In-Reply-To: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>,
        Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, Amir Vajid <amir.vajid@oss.qualcomm.com>,
        Ramakrishna Gottimukkula <ramakrishna.gottimukkula@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784877514; l=12506;
 i=pragnesh.papaniya@oss.qualcomm.com; s=20260120; h=from:subject:message-id;
 bh=vBs1nrZfnrohzT4k2onMHNTX4TddQbE0+AmlJbHYHu0=;
 b=LRr4gPrWhvzZt2NhfqsIf1G9MexjRNr+aJ+U6LRom7Y8/B5rsHRtw8EBz76LP/biLifMAsPX1
 Ly/y0EflGLXC3JATLvxtAZGXD9CGDQPhHbpdnzVAMGCzX4Izvni0Krp
X-Developer-Key: i=pragnesh.papaniya@oss.qualcomm.com; a=ed25519;
 pk=09P9nFmZLXJ9+4Jx10ZK5rIW0Fmk79A/DLErm6aVA0c=
X-Proofpoint-ORIG-GUID: 9Lu2UNpyaAUt0QLaWTXC268VCaSW_IPW
X-Proofpoint-GUID: 9Lu2UNpyaAUt0QLaWTXC268VCaSW_IPW
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a6311e9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=3GEwtj1osWxiqG9AIrUA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2NSBTYWx0ZWRfX3GVWOFmYw6qd
 mswMCYj4UxqHwtSYsXbI45E5/+7wmf6cCcp00lowQNA5myt51bDsLWGh/3A9CS0apaq8+PkcOmq
 B8TqOPFdQ5QoWc9P1SvJ+jinugqqXombMQ32spxGfJu3n3nzQ+64dt/nQ4TQB6w5IabXvknD5hZ
 isZ37S6DYL8JkMvfOStCuv0EIfgqooee2BhGIQRC2bgzCq2Mql+ytxSGBcKpDhvhH+EfEvGlAjn
 NklDiSjfRezXw1hyUmNHLUJ83Zv9XHF9b71Ycbxc3iiMkcfna0oZxlJoWdPPh434jLEil8fJU9e
 o0R4E5cuo+KMfWLD2IdEKo14c7FqN/9dgdXiHkpwjUtPvfexU/xyzY9D9u0a45CAyt11kUQ233w
 mVrh8BxKUS11/X738gGIUUZXk1P7LaAdbo3pa/y5+SEVfwT0o+0JlCN4mE+OGHNWDp9h3FJ7H7u
 /E1sm1xqIn4QZHilTKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2NSBTYWx0ZWRfX0DTEtUwkUKzB
 HBS+BeiTuGKktBEIp670DJbdcnBS+y2iROk7WJC+Sko8tJhefxvZgrozTWBr7uNwQx4M0kgoUTU
 pANiMLGy2+J3Chnx9nn5ZMR4BUinMbc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240065

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

The System Control Management Interface (SCMI) Qualcomm Generic Extension
Protocol consists of a small set of generic SET/GET/ START/STOP commands,
which is used to turn on/off and configure Qualcomm SoC specific algorithms
that run on the SCP.

Co-developed-by: Amir Vajid <amir.vajid@oss.qualcomm.com>
Signed-off-by: Amir Vajid <amir.vajid@oss.qualcomm.com>
Co-developed-by: Ramakrishna Gottimukkula <ramakrishna.gottimukkula@oss.qualcomm.com>
Signed-off-by: Ramakrishna Gottimukkula <ramakrishna.gottimukkula@oss.qualcomm.com>
Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Co-developed-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Signed-off-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
---
 MAINTAINERS                                        |  10 ++
 drivers/firmware/arm_scmi/Kconfig                  |   1 +
 drivers/firmware/arm_scmi/Makefile                 |   1 +
 drivers/firmware/arm_scmi/vendors/qcom/Kconfig     |  15 ++
 drivers/firmware/arm_scmi/vendors/qcom/Makefile    |   2 +
 .../arm_scmi/vendors/qcom/qcom-generic-ext.c       | 183 +++++++++++++++++++++
 include/linux/scmi_qcom_protocol.h                 |  37 +++++
 7 files changed, 249 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc3c01eecfa2..265eb99bdc7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26487,6 +26487,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/firmware/nxp,*scmi.yaml
 F:	drivers/firmware/arm_scmi/vendors/imx/
 
+SYSTEM CONTROL MANAGEMENT INTERFACE (SCMI) Qualcomm Generic Extension Protocol driver
+M:	Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
+M:	Sibi Sankar <sibi.sankar@oss.qualcomm.com>
+L:	arm-scmi@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/firmware/qcom,generic-scmi.yaml
+F:	drivers/firmware/arm_scmi/vendors/qcom/
+F:	include/linux/scmi_qcom_protocol.h
+
 SYSTEM RESET/SHUTDOWN DRIVERS
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-pm@vger.kernel.org
diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index 783c24a20e29..3918aa2e7140 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -84,6 +84,7 @@ config ARM_SCMI_QUIRKS
 
 source "drivers/firmware/arm_scmi/transports/Kconfig"
 source "drivers/firmware/arm_scmi/vendors/imx/Kconfig"
+source "drivers/firmware/arm_scmi/vendors/qcom/Kconfig"
 
 endif #ARM_SCMI_PROTOCOL
 
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 780cd62b2f78..5a0e003c2477 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -13,6 +13,7 @@ scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += transports/
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += vendors/imx/
+obj-$(CONFIG_ARM_SCMI_PROTOCOL) += vendors/qcom/
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
diff --git a/drivers/firmware/arm_scmi/vendors/qcom/Kconfig b/drivers/firmware/arm_scmi/vendors/qcom/Kconfig
new file mode 100644
index 000000000000..8aa0efd6a03d
--- /dev/null
+++ b/drivers/firmware/arm_scmi/vendors/qcom/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "ARM SCMI QCOM Vendor Protocols"
+
+config QCOM_SCMI_GENERIC_EXT
+	tristate "Qualcomm Technologies, Inc. SCMI Generic Vendor Protocol"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	help
+	  The QCOM SCMI vendor protocol provides a generic way of exposing
+	  a number of Qualcomm SoC specific features (like memory bus scaling)
+	  through a mixture of pre-determined algorithm strings and param_id
+	  pairs hosted on the SCMI controller.
+
+	  This driver defines/documents the message IDs used for this
+	  communication and also exposes the operations used by the clients.
+endmenu
diff --git a/drivers/firmware/arm_scmi/vendors/qcom/Makefile b/drivers/firmware/arm_scmi/vendors/qcom/Makefile
new file mode 100644
index 000000000000..6b98fabbebb8
--- /dev/null
+++ b/drivers/firmware/arm_scmi/vendors/qcom/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_QCOM_SCMI_GENERIC_EXT) += qcom-generic-ext.o
diff --git a/drivers/firmware/arm_scmi/vendors/qcom/qcom-generic-ext.c b/drivers/firmware/arm_scmi/vendors/qcom/qcom-generic-ext.c
new file mode 100644
index 000000000000..7ca920c8da05
--- /dev/null
+++ b/drivers/firmware/arm_scmi/vendors/qcom/qcom-generic-ext.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/module.h>
+#include <linux/scmi_qcom_protocol.h>
+#include <linux/string.h>
+#include <linux/stringify.h>
+#include <linux/types.h>
+
+#include "../../common.h"
+
+/*
+ * This protocol is intended as a generic way of exposing a number of Qualcomm
+ * SoC specific features through a mixture of pre-determined algorithm string
+ * and param_id pairs hosted on the SCMI controller.
+ *
+ * The QCOM SCMI Vendor Protocol has the protocol id as 0x80 and vendor id set
+ * to Qualcomm and the supported version is set to 0x10000. The PROTOCOL_VERSION
+ * command returns version 1.0.
+ */
+
+/**
+ * enum qcom_generic_ext_protocol_cmd - vendor specific commands supported by SCMI Qualcomm
+ *                                      generic vendor protocol.
+ *
+ * @QCOM_SCMI_SET_PARAM: is used to set the parameter of a specific algo_str hosted on
+ *			 QCOM SCMI Vendor Protocol. The tx len depends on the algo_str used.
+ * @QCOM_SCMI_GET_PARAM: is used to get parameter information of a specific algo_str
+ *			 hosted on QCOM SCMI Vendor Protocol. The tx and rx len depends
+ *			 on the algo_str used.
+ * @QCOM_SCMI_START_ACTIVITY: is used to start the activity performed by the algo_str.
+ * @QCOM_SCMI_STOP_ACTIVITY: is used to stop a pre-existing activity performed by the algo_str.
+ */
+enum qcom_generic_ext_protocol_cmd {
+	QCOM_SCMI_SET_PARAM = 0x10,
+	QCOM_SCMI_GET_PARAM = 0x11,
+	QCOM_SCMI_START_ACTIVITY = 0x12,
+	QCOM_SCMI_STOP_ACTIVITY = 0x13,
+};
+
+/**
+ * struct qcom_scmi_msg - represents the various parameters to be populated
+ *                        for using the QCOM SCMI Vendor Protocol
+ *
+ * @ext_id: reserved, must be zero
+ * @algo_low: lower 32 bits of the algo_str
+ * @algo_high: upper 32 bits of the algo_str
+ * @param_id: serves as token message id to the specific algo_str
+ * @buf: serves as the payload to the specified param_id and algo_str pair
+ */
+struct qcom_scmi_msg {
+	__le32 ext_id;
+	__le32 algo_low;
+	__le32 algo_high;
+	__le32 param_id;
+	__le32 buf[];
+};
+
+/*
+ * The firmware only implements a handful of algorithm strings. Keep an
+ * allowlist so a client cannot push an unsupported (or garbage) string to
+ * the firmware; extend it as new algorithms are added.
+ */
+static const u64 qcom_scmi_algo_str[] = {
+	0x4d454d4c4154ULL, /* "MEMLAT" */
+};
+
+static bool qcom_scmi_algo_str_valid(u64 algo_str)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(qcom_scmi_algo_str); i++)
+		if (algo_str == qcom_scmi_algo_str[i])
+			return true;
+
+	return false;
+}
+
+static int qcom_scmi_common_xfer(const struct scmi_protocol_handle *ph,
+				 enum qcom_generic_ext_protocol_cmd cmd_id, void *buf,
+				 size_t buf_len, u64 algo_str, u32 param_id, size_t rx_size)
+{
+	struct scmi_xfer *t;
+	struct qcom_scmi_msg *msg;
+	int ret;
+
+	if (!qcom_scmi_algo_str_valid(algo_str))
+		return -EINVAL;
+
+	/* Reject calls where rx_size exceeds buf_len. */
+	if (rx_size > buf_len)
+		return -EINVAL;
+
+	ret = ph->xops->xfer_get_init(ph, cmd_id, buf_len + sizeof(*msg), rx_size, &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	msg->ext_id = 0;
+	msg->algo_low = cpu_to_le32(lower_32_bits(algo_str));
+	msg->algo_high = cpu_to_le32(upper_32_bits(algo_str));
+	msg->param_id = cpu_to_le32(param_id);
+	if (buf_len)
+		memcpy(msg->buf, buf, buf_len);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret && rx_size) {
+		/*
+		 * The response is returned into the caller's @buf, replacing
+		 * the tx payload. Bound the copy to the caller's buffer since
+		 * t->rx.len is reported by the firmware, and require at least
+		 * the expected rx_size so the caller never reads stale tx data.
+		 */
+		if (t->rx.len < rx_size || t->rx.len > buf_len)
+			ret = -EPROTO;
+		else
+			memcpy(buf, t->rx.buf, rx_size);
+	}
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
+static int qcom_scmi_set_param(const struct scmi_protocol_handle *ph, void *buf, size_t buf_len,
+			       u64 algo_str, u32 param_id)
+{
+	return qcom_scmi_common_xfer(ph, QCOM_SCMI_SET_PARAM, buf, buf_len, algo_str,
+				     param_id, 0);
+}
+
+static int qcom_scmi_get_param(const struct scmi_protocol_handle *ph, void *buf, size_t buf_len,
+			       u64 algo_str, u32 param_id, size_t rx_size)
+{
+	return qcom_scmi_common_xfer(ph, QCOM_SCMI_GET_PARAM, buf, buf_len, algo_str,
+				     param_id, rx_size);
+}
+
+static int qcom_scmi_start_activity(const struct scmi_protocol_handle *ph, void *buf,
+				    size_t buf_len, u64 algo_str, u32 param_id)
+{
+	return qcom_scmi_common_xfer(ph, QCOM_SCMI_START_ACTIVITY, buf, buf_len, algo_str,
+				     param_id, 0);
+}
+
+static int qcom_scmi_stop_activity(const struct scmi_protocol_handle *ph, void *buf,
+				   size_t buf_len, u64 algo_str, u32 param_id)
+{
+	return qcom_scmi_common_xfer(ph, QCOM_SCMI_STOP_ACTIVITY, buf, buf_len, algo_str,
+				     param_id, 0);
+}
+
+static const struct qcom_generic_ext_ops qcom_proto_ops = {
+	.set_param = qcom_scmi_set_param,
+	.get_param = qcom_scmi_get_param,
+	.start_activity = qcom_scmi_start_activity,
+	.stop_activity = qcom_scmi_stop_activity,
+};
+
+static int qcom_generic_ext_protocol_init(const struct scmi_protocol_handle *ph)
+{
+	dev_dbg(ph->dev, "QCOM Generic Vendor Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(ph->version), PROTOCOL_REV_MINOR(ph->version));
+
+	return 0;
+}
+
+static const struct scmi_protocol qcom_generic_ext = {
+	.id = SCMI_PROTOCOL_QCOM_GENERIC,
+	.owner = THIS_MODULE,
+	.instance_init = &qcom_generic_ext_protocol_init,
+	.ops = &qcom_proto_ops,
+	.vendor_id = "Qualcomm",
+	.supported_version = 0x10000,
+};
+module_scmi_protocol(qcom_generic_ext);
+
+MODULE_ALIAS("scmi-protocol-" __stringify(SCMI_PROTOCOL_QCOM_GENERIC) "-Qualcomm");
+MODULE_AUTHOR("Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>");
+MODULE_AUTHOR("Sibi Sankar <sibi.sankar@oss.qualcomm.com>");
+MODULE_DESCRIPTION("QCOM SCMI Generic Vendor Protocol");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/scmi_qcom_protocol.h b/include/linux/scmi_qcom_protocol.h
new file mode 100644
index 000000000000..41632ee7bbc7
--- /dev/null
+++ b/include/linux/scmi_qcom_protocol.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SCMI Message Protocol driver QCOM extension header
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _LINUX_SCMI_QCOM_PROTOCOL_H
+#define _LINUX_SCMI_QCOM_PROTOCOL_H
+
+#include <linux/types.h>
+
+#define SCMI_PROTOCOL_QCOM_GENERIC    0x80
+
+struct scmi_protocol_handle;
+
+/**
+ * struct qcom_generic_ext_ops - represents the various operations provided
+ *				 by QCOM Generic Vendor Protocol
+ *
+ * @set_param: set parameter specified by param_id and algo_str pair.
+ * @get_param: retrieve parameter specified by param_id and algo_str pair.
+ * @start_activity: initiate a specific activity defined by algo_str.
+ * @stop_activity: halt previously initiated activity defined by algo_str.
+ */
+struct qcom_generic_ext_ops {
+	int (*set_param)(const struct scmi_protocol_handle *ph, void *buf, size_t buf_len,
+			 u64 algo_str, u32 param_id);
+	int (*get_param)(const struct scmi_protocol_handle *ph, void *buf, size_t buf_len,
+			 u64 algo_str, u32 param_id, size_t rx_size);
+	int (*start_activity)(const struct scmi_protocol_handle *ph, void *buf, size_t buf_len,
+			      u64 algo_str, u32 param_id);
+	int (*stop_activity)(const struct scmi_protocol_handle *ph, void *buf, size_t buf_len,
+			     u64 algo_str, u32 param_id);
+};
+
+#endif /* _LINUX_SCMI_QCOM_PROTOCOL_H */

-- 
2.34.1

