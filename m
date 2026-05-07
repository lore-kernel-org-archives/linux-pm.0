Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF662FE59B
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778134989; cv=none; b=I5/y4dVwb7xPXqUVrYqbBum4KIqesuzjKoPFQpYvpHaQnbj9TCEIKWrrQVvlZvnu7t887vqadjcd9KjKNExpsZyji7P9HrKwP1E3XaprmIPJEk/g2hMh8Aw3NAnd4APckn6rKHKrof+MrSUMJ809+JCf8C7sbSVrBAq55yCio/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778134989; c=relaxed/simple;
	bh=crif14YmbOExkSC7ZauwFjleVb0oyJmI7QPRCBQarmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZR1CNx0nT0Jbx5tJE7IQnbwQTASn1OVI1I4yGAIlhToH7+s3IVEWcEsPPEaLsAoM43fdtutHs7r9bPwc+lqPh57lsV/uJjEMLHzFZhY1Cz/dEoWVRQnhAojG7d3mwnl8/r1hwg26y+d/68X/Q1WN2Xa2S2Sn0u9lZbLDVsw6MDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AmU4McbE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JMNeHU9v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AmU4McbE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JMNeHU9v"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6475MA1n3156937
	for <linux-pm@vger.kernel.org>; Thu, 7 May 2026 06:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wqlIPTlhmBb
	CJdFzW+UetDgAOjHAm1lIAxJEuFxtZms=; b=AmU4McbEwZZVev9lpbyDoJqTvkZ
	hPQDHckicgyHEsO+7eCNACzVUDqFQXOUhqezQRHVclxaFZm+SHG6FRNI/rOlCv2N
	v84rEOSh/q8us6rcEnKVLT//YfH/KFJ6nLLSYk+lLh1wjNuqaLQBlXlz+uIWGE+t
	GUp0xGIDMMdKgDuGy2I1FG/2aFj9DZ4fnaJOWoma1snmn/vP+Ql+J/EEgraTZ8e4
	UHiU4S0sfBGXAdovky7ykT3CikzEM2uhFH5Srs7HTKiFysCPQXPzDptzYJNBxHKD
	QduVFEoV+rWvGGQ+fVqUM3zhbUefWap01NyQhR/hGxOwdE+RbooicRwOAAQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mhf069j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 06:23:06 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8354503d9acso519598b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 23:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778134985; x=1778739785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqlIPTlhmBbCJdFzW+UetDgAOjHAm1lIAxJEuFxtZms=;
        b=JMNeHU9vP5YfLEuGdAvlNw2kWQBZyk/eU9h+WET4j3L3XQQ70W03wAJWCVMwG1oFHi
         nm4xvLnt68znYhKsswianjYOjKXO82CsNkdBPmwnAsXfZIiIcCC5DcBLgPNdaBcVtj2A
         Un5JRibtlYW3aS0EL2xfd6MSVSTFPq8hI7bbg0qiGdRDgoAJro/mPnESDaXqeavKuzyv
         qb402P2Dqpgu4UoaQQtOeankZ4DCbJhBwopIN+l7ZWD4fbMfgm8ma9qXgOeLWb7fmdIo
         3WcW/vyJK6r2yKSuBJrULhadYGWRMBiL7BfSh4Iic1/Za1DBQ59K3VRmb0Jzv3Cn/DsA
         /few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778134985; x=1778739785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wqlIPTlhmBbCJdFzW+UetDgAOjHAm1lIAxJEuFxtZms=;
        b=SqGMvl2g8DGzmcp27ePEBAC+lY9J1PfqCEe7wtwi1gzJGatT8Z6k/AJmgQviCznJGv
         8RKRlsd1HOJLi2ppySZFNuvI63hqKnjMtMO8QRd/FJOYEG4jzejhXRsBkMZfRUgGz2uu
         3MYCYWTV5xZa0DeAwleFJHq7ldrh2mLM5LSA7nsy4vkghHefLBCkeqbN+79bUVv/HyNS
         kvcho77/A+Uz3okBk2MzHOgiu1ncRc/DECcB+s8F6mi14M766tepYASNGmDd0ioDXyBg
         3it5SC5ZhvFpkQ+JPbT0Ic6gIfDEHtWTzpVSh/4D7yZ3jVa2PgCkvnRroXikKM7z7Iwn
         a7sw==
X-Forwarded-Encrypted: i=1; AFNElJ+ugNIZOyfJRl002CaoVlvBmhRYsgk+PSUij/sS+H34fBOzxZyfGQILouqIZOw9RDyGx8lYK+LcOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YziH9nt7+yV3ROUAZEV1FRKI4uUfK6o/zo+uEto23ALyb4xAtJC
	nyiP6cpSqRCl6LUN//arL40fwx4fJRZ3wMU0daD+z31HjEeAnGEDNe1jHzgv/3OE5pI8IyEWloY
	RdH3ifpUSXh+00ApxqggIVPh47mQn/z+s8uBnrlFMWwu9PkyFJZ/3YyFl7vj8Kw==
X-Gm-Gg: AeBDietxkxu19ZLZrH6Vi++2AF2kq1QWnWUjlB7It4KEnBMsisvyNvge1+v9AZCMwDk
	Eez0EyGQjxb9ZDegDiNH7X/fh0ndiBlFzd7Ytw+vrItGnnn5LXqpRqK8KbshW077iVz560ecHY/
	5NRB92owLQf0lYwlcre9VnI8UFCvA5scMPv7uRHwO0ozH66aADRfnQk5OYawGFYIEWhsUb9jejO
	2wZslxTvleAeCwOy3pvSPV6slgFRhRkH5k9vEnBxZY9dJNmkntI1CCJOj0aJNMfrKJgqTMlkdgU
	BVNSRCNWftb4dQh+svCffgpyf1i42YZEKLN+q1IVv2FN0ngg1EMr3VMPAbEIhyfKWVTopbXwakb
	TkeNF0iavfr2iFx3azqe4vZL8Xyv1X6AQJIloiDOoiVb66+ZErYcRv158gbl/mjuYF5NOB1UE5b
	9deWrM9Z1e2BIz/HBQ3sUtyzpxDESlpnWchuGouIk08X7lPhA=
X-Received: by 2002:a05:6a00:c95:b0:82a:65fa:cecf with SMTP id d2e1a72fcca58-83a5bada322mr6431044b3a.4.1778134984990;
        Wed, 06 May 2026 23:23:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:c95:b0:82a:65fa:cecf with SMTP id d2e1a72fcca58-83a5bada322mr6431017b3a.4.1778134984445;
        Wed, 06 May 2026 23:23:04 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965945101sm7346557b3a.13.2026.05.06.23.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 23:23:04 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: cristian.marussi@arm.com, sudeep.holla@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
        konradybcio@kernel.org, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        jonathanh@nvidia.com, thierry.reding@kernel.org, digetx@gmail.com,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        Shivnandan Kumar <quic_kshivnan@quicinc.com>,
        Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>,
        Amir Vajid <avajid@quicinc.com>
Subject: [RFC V6 2/8] firmware: arm_scmi: vendors: Add QCOM SCMI Generic Extensions
Date: Thu,  7 May 2026 11:52:31 +0530
Message-Id: <20260507062237.78051-3-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
References: <20260507062237.78051-1-sibi.sankar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA2MCBTYWx0ZWRfX+IQZj9+lWsss
 Tx//AcIQHjt8rBeeB1PdycMC3oX/G4zSjKNqMEJVa9DIdxSGidxahrRxbn2X8+bBJQIk9Mahxws
 dWjBuq8vqDa+ysR0+zk4zH1DKHh8UuG+fnsglM6epsN314dzk+0VvCsWJMZ+osueHivJsLKVMIe
 078ZjHC7OZwMCBmOU3u+NNr/zN+eoDAECvj6QS/QTFQxXmpo/cSujkbl20Gu+7pnE4JgfgAHQYW
 ahXetllQn+1CbQfRHzpgTCvxb1oqjS8cVWEz3HUn7Rxch3rV8TKitXh5FdKhS+vHIioUwG352fo
 0JzUd2UwS8GLFs7RqqEPL9e6fZejf6vdDxnmnZ6fYKGHnGdfgHtYX8ZV6NVPUdAiPReq4WKJ7R/
 BKnPRtVe/LXZkvzUmga2OHgaJo3bvi3MLZ+u5GUxmskBXY/UpTtGovry9sdvTjLBAaHg83D4xlr
 30ahBtYuLf1PyGmZJDw==
X-Proofpoint-ORIG-GUID: HGt6RK-h3IDdBdgeI4iRjwh9YCtot5n8
X-Authority-Analysis: v=2.4 cv=SuagLvO0 c=1 sm=1 tr=0 ts=69fc2fca cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=5qo32d-oOMBYuVP3DBMA:9 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: HGt6RK-h3IDdBdgeI4iRjwh9YCtot5n8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070060

The QCOM SCMI Generic Extensions Protocol provides a generic way of
exposing a number of Qualcomm SoC specific features (like memory bus
scaling) through a mixture of pre-determined algorithm strings and
param_id pairs hosted on the SCMI controller.

Co-developed-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
Co-developed-by: Amir Vajid <avajid@quicinc.com>
Signed-off-by: Amir Vajid <avajid@quicinc.com>
Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---

@Sudeep/@Christian, Just moving the series back in RFC mode to get feedback
on the devfreq part of the series. Will add a lot more documentation in the
next re-spin, so definitely not ignoring your earlier comments :).

 drivers/firmware/arm_scmi/Kconfig             |   1 +
 drivers/firmware/arm_scmi/Makefile            |   1 +
 .../firmware/arm_scmi/vendors/qcom/Kconfig    |  15 ++
 .../firmware/arm_scmi/vendors/qcom/Makefile   |   2 +
 .../arm_scmi/vendors/qcom/qcom-generic-ext.c  | 135 ++++++++++++++++++
 include/linux/scmi_qcom_protocol.h            |  37 +++++
 6 files changed, 191 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/vendors/qcom/Kconfig
 create mode 100644 drivers/firmware/arm_scmi/vendors/qcom/Makefile
 create mode 100644 drivers/firmware/arm_scmi/vendors/qcom/qcom-generic-ext.c
 create mode 100644 include/linux/scmi_qcom_protocol.h

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index e3fb36825978..a52f4d1b8b2c 100644
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
index 000000000000..5dd9e8a6b75f
--- /dev/null
+++ b/drivers/firmware/arm_scmi/vendors/qcom/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "ARM SCMI QCOM Vendor Protocols"
+
+config QCOM_SCMI_GENERIC_EXT
+	tristate "Qualcomm Technologies, Inc. Qcom SCMI vendor Protocol"
+	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
+	help
+	  The QCOM SCMI vendor protocol provides a generic way of exposing
+	  a number of Qualcomm SoC specific features (like memory bus scaling)
+	  through a mixture of pre-determined algorithm strings and param_id
+	  pairs hosted on the SCMI controller.
+
+	  This driver defines/documents the message ID's used for this
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
index 000000000000..4f9eba8ff4bd
--- /dev/null
+++ b/drivers/firmware/arm_scmi/vendors/qcom/qcom-generic-ext.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/scmi_qcom_protocol.h>
+
+#include "../../common.h"
+
+/**
+ * enum qcom_generic_ext_protocol_cmd - vendor specific commands supported by SCMI Qualcomm
+ *                                      generic vendor protocol.
+ *
+ * This protocol is intended as a generic way of exposing a number of Qualcomm SoC
+ * specific features through a mixture of pre-determined algorithm string and param_id
+ * pairs hosted on the SCMI controller.
+ *
+ * The QCOM SCMI Vendor Protocol has the protocol id as 0x80 and vendor id set to
+ * Qualcomm and the supported version is set to 0x10000. The PROTOCOL_VERSION command
+ * returns version 1.0.
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
+static int qcom_scmi_common_xfer(const struct scmi_protocol_handle *ph,
+				 enum qcom_generic_ext_protocol_cmd cmd_id, void *buf,
+				 size_t buf_len, u64 algo_str, u32 param_id, size_t rx_size)
+{
+	struct scmi_xfer *t;
+	struct qcom_scmi_msg *msg;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, cmd_id, buf_len + sizeof(*msg), rx_size, &t);
+	if (ret)
+		return ret;
+
+	msg = t->tx.buf;
+	msg->algo_low = cpu_to_le32(lower_32_bits(algo_str));
+	msg->algo_high = cpu_to_le32(upper_32_bits(algo_str));
+	msg->param_id = cpu_to_le32(param_id);
+	memcpy(msg->buf, buf, buf_len);
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret && rx_size)
+		memcpy(buf, t->rx.buf, t->rx.len);
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
+static struct qcom_generic_ext_ops qcom_proto_ops = {
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
+MODULE_DESCRIPTION("QCOM SCMI Generic Vendor protocol");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/scmi_qcom_protocol.h b/include/linux/scmi_qcom_protocol.h
new file mode 100644
index 000000000000..465b2522ca29
--- /dev/null
+++ b/include/linux/scmi_qcom_protocol.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SCMI Message Protocol driver QCOM extension header
+ *
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
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

