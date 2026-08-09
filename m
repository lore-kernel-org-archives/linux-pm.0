Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA5D531
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786278629; cv=none; b=QZk7WnIYTD0KoBJkHJXnYtpXIC8pR6M7jDRXF/zEjs3PtgVoZYyvxPKMWARJpHCGgvJUiXIBZN9w365e+u4zQ7yOtuoQJKy1zQk7TAPVTrfLC0mTk6qpYxb59AotoCdl7zAkCnlgCImsn/CXJertrBKsxIRdvDe6zhYV6LfTmFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786278629; c=relaxed/simple;
	bh=W1+1+Vbim8qgRg34byZ3OafjXNZYpBFcqhabzIpk6BI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=igYH/9SoKG11BQOZ1npv/o7ZO8J9qsI18P2nCWSnFe2hGg2qQe3/wjTXAmT6exCKnKHeQPo7axEjxA1PXdkphiMuEZTPwNZGZ6dqVjJlDFDXfdggEXYuJnaDPU0syupxRpMFo2uPm7zCe3DK5qNaiVH/8vQOtLXR71ddlxW6pB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZYkvhotC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XYEx5nmN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZYkvhotC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XYEx5nmN"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679C27Xu2999476
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 12:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k8R3z9uIhjCAaevgHTtgoUnkWfEHp3T0uL2mbrKFNto=; b=ZYkvhotCPfyCzOfp
	BtY01Uv/sd7QUP/ArTTU8si5NmIb+mnUsAEaphs8kfDesWE9pnxaHsy2YJLzpUxD
	s9zRXBX0rBcxFDRgMbEa11PWjfi0mTlJ34+iSAGlCbaiVwv6QtYp2iuzyGj6wSn+
	MWHK0paDLQbDt2F4iQIk+0sjYa5oXlSq36Bu/qkRnZXnHWhpRydvM2siAKAykcsJ
	tBI+ccaWrJEHqVM5K/ARjlOKUCddNOcKNMrNupWS5AHHxsx4aj8ofzajhcF8hOhO
	UvrHRbkpWKOFdoGdLA+f51D5T5Cn+/fboRlJg9Kp+7jLpWQtFmxzmWWze83n8RSR
	h18Xng==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf7ax55-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 12:30:24 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38fcaa5f82cso1008728a91.3
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 05:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786278624; x=1786883424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k8R3z9uIhjCAaevgHTtgoUnkWfEHp3T0uL2mbrKFNto=;
        b=XYEx5nmN18s2RfnDMa0R9wBDgaZ6tacCk+G0dYZCHm2GlKFONQ1ixl5fMdLRr09DwV
         8QEwtTr8tc+zJj2LBrZa4b2e03WdQLZxgM87upepcxp5BTn/UIJrSyXJ2cmeu0hvXFn5
         IjvOoB1FNDxpfyPxaohmFpgGxTY+EYGDBX0rtHHlmqum1jCOpbRDHSP2m2W34gjERJzP
         ywWWVgND+dQIYw2qshwN3I/XDlFrWhPVmLhvZxDNyvQnEC9hTb9aF8elokrgKsvUE1eB
         YZI7h5OKXDmlhrMqqQ2P89kBF/rXom1SF4a867NOEXp51NxFWuqCYOmweab1JN1YjT/T
         xDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786278624; x=1786883424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k8R3z9uIhjCAaevgHTtgoUnkWfEHp3T0uL2mbrKFNto=;
        b=O6C7JbFda69rHg43XCi4fKgq5EOP0tk6BWgh/DGO5odcB5NOnHzNzbWwn6HlHkLIEB
         tO57FKvMXafuTt9C6dLtnLVvTOzYI94NM2EF0UFEJDemwmC3fuUczf7SFiIGZiZjFigl
         tSIfcT6Ks8kUMnLsFQp//IpDCAJ2H4P63a9VSy1O/sFXxw3Yl+fYUTh2P8/V1iVu6EIT
         ZYIDBeYIPfDZbAQlycgqxys1utz1r+3c4/ViHxQ2E8MianVAIfyW+xI52yjaJ/r3s+sW
         aVG6cCUN1Npr0gP66SrlTTEXmlMmpMxOzAXzMZrwXE6cwtnFXuMxY5ApTjvvvEDmPqzG
         jZLA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3Lno7so/aKCIzOA5HXaQcShQwF/gF/COhXzxnDnHHwsVUWtKZS2cDs/61y29mEce01ujWhWrU9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7SMxUoWF1eFOfs35nwGCXdYjtNgOfITMJnZTdn/33VsCYTGW1
	2XvDTsj0FqslNpx4iKmOmLvZWSuU8WHC5e0TIHUxLqDjSFgEJyVEcMevBOm71OxFaN7Ku4Q/APv
	SENVvH/zeRvHnPDREVto/OP7jMxW+ou1A6RsZs3lV/eLkmkTN6i2WqyPyMCLWsQ==
X-Gm-Gg: AR+sD11iTaxWMFZcjtJWZN2qmc4CarEmrFDCSux2Tg4oAjgBDCNJDENbuO4xh4w+IaQ
	aW6m13qf+ty9hZk8X9YGaHHFgJeHI1kPcu/4leK85I2E7kQvG93q/ttj1Hm2YZhNONbQBeS/3wa
	phGH7OsWGAZ3xi6SowjCCigY8filuuKK2KR1mwe2O6mZTO6Sp3STGmhs2jDmwjz1NQYvn2/i1e7
	s9mMNUpNfv87kNvETMXmvYdHMzU9QmlnV+hrqYmkbadmArQkfTYuJET4T9CKXs9CBH843zWoPL6
	v/e1h8uNj/7SMQ/coKH/7J5Qhk539b0D817LUMHrMlQ0jkpkV9enUelAH1VjrRWSSAVxffcToqi
	PFTfMiumipGGKCp4M7DT714/05IKKcA==
X-Received: by 2002:a05:6a20:2589:b0:3c4:3321:4fe9 with SMTP id adf61e73a8af0-3cb85e991e7mr41268898637.7.1786278623793;
        Sun, 09 Aug 2026 05:30:23 -0700 (PDT)
X-Received: by 2002:a05:6a20:2589:b0:3c4:3321:4fe9 with SMTP id adf61e73a8af0-3cb85e991e7mr41268830637.7.1786278623253;
        Sun, 09 Aug 2026 05:30:23 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm51842997eec.18.2026.08.09.05.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 05:30:22 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 17:58:58 +0530
Subject: [PATCH v8 2/9] soc: qcom: Add QMI TMD support for remote thermal
 mitigation
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-b4-qmi-tmd-v8-2-b15d47adc379@oss.qualcomm.com>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
In-Reply-To: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786278595; l=20890;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=lqymAg5/KUO8LEUkD/N9DiUxTSpsamB91N3q0Q0Kb/s=;
 b=LOS4Gucr307izs4XqsIoywQqlxJxLIboEA7noDcNBUCa5d1t18ahMZTrFDX9/HKE1zw6vEK4p
 6KhnWmcUNHZBt4X/FLjvOQHQUT7ibkwTMWObcedrJiAsDkR3K8/U4vA
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDExMCBTYWx0ZWRfX6YJLplJhWP5M
 Cs86O/d57ne1e9YLjA05+EtWuPm60yyY340g2P7earLvtS/4lW7SrneyW3QkBProqWwXqwlwFT/
 NtAE0D4d8vnjMFhOOBFAgO/JX4nEOlc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDExMCBTYWx0ZWRfX03czO3KyYTKf
 wLBcRFxFKrZ952s2de/kaV8uBfQuYVBs8IQ6qQ8+hYyvK+qJSYaU10yJsLgqnidWk4ubTo3kI7C
 wK9hnNq7Egj747Dh4Xfs/Uk0warEt6Kz53rcvpTTVhvIVVZ+BfiXKaBdEimYBbLkelL2yHgMLVo
 OOjwp7Uq9s3eF6gpYP2I46JA+JoccWGqZt34yOVOcNqTIC/cOTQixVSzXlQsyVZmp5mW+ROKmaB
 59TLvShPkwQRJXSRrhsDWFhPt1ZLgf7hlPnMxxsB3X5lx5t2kxhr1maoVM5XkDQ790lkUJIiPJ9
 pEESgVCcWJi7Bzl36CIo6u5KhpKfUA5tw6jCFMgd0oaE8a0O4S583JeZ+z63VJViVq+nbbE1FVv
 3WjaUgQSh0L0ZgUgupSxO61jz2G9NJqF4EY4hrOSvV7/mPUPD4YbCW5OaebFcxK4hzpeeznLGp+
 kuw9gKfbN4D7br0Q8zw==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a7872e1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=vxRmu5Slt9wj_6SMVmQA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Ft5YfnktnPGtUc0H8xNT3FCOqIog_-fS
X-Proofpoint-GUID: Ft5YfnktnPGtUc0H8xNT3FCOqIog_-fS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090110

From: Casey Connolly <casey.connolly@linaro.org>

Add support for Qualcomm Messaging Interface (QMI) based Thermal Mitigation
Device (TMD) cooling devices provided by remote subsystems.

On Qualcomm platforms where remote processors expose mitigation controls
through the TMD QMI service, client drivers need support to discover the
service, register cooling devices for available mitigation endpoints,
and forward cooling state updates to remote subsystems.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Co-developed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 MAINTAINERS                      |   7 +
 drivers/soc/qcom/Kconfig         |  12 +
 drivers/soc/qcom/Makefile        |   1 +
 drivers/soc/qcom/qmi_tmd.c       | 595 +++++++++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/qmi.h     |   1 +
 include/linux/soc/qcom/qmi_tmd.h |  36 +++
 6 files changed, 652 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f1e2bbf7099..7b347a84883d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22389,6 +22389,13 @@ F:	Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
 F:	Documentation/networking/device_drivers/ethernet/qualcomm/ppe/ppe.rst
 F:	drivers/net/ethernet/qualcomm/ppe/
 
+QUALCOMM QMI (REMOTEPROC THERMAL MITIGATION) TMD
+M:	Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
+L:	linux-arm-msm@vger.kernel.org
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/soc/qcom/qmi_tmd.c
+
 QUALCOMM QSEECOM DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	linux-arm-msm@vger.kernel.org
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index fd4d4ecd2df0..6f87e85713ec 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -319,6 +319,18 @@ config QCOM_QMI_HELPERS
 	tristate
 	depends on NET
 
+config QCOM_QMI_TMD
+	tristate "Qualcomm remote subsystem TMD" if COMPILE_TEST
+	depends on NET
+	depends on ARCH_QCOM || COMPILE_TEST
+	select QRTR
+	select QCOM_QMI_HELPERS
+	help
+	  This enables Qualcomm Messaging Interface (QMI) based Thermal Mitigation
+	  Device (TMD) support for Qualcomm remote subsystems. It manages
+	  TMD messaging and handles QMI communication with remote processors
+	  to exchange mitigation state and apply thermal mitigation requests.
+
 config QCOM_UBWC_CONFIG
 	tristate
 	help
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index b7f1d2a57367..4544e61c74e7 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink.o
 obj-$(CONFIG_QCOM_PMIC_GLINK)	+= pmic_glink_altmode.o
 obj-$(CONFIG_QCOM_PMIC_PDCHARGER_ULOG)	+= pmic_pdcharger_ulog.o
 CFLAGS_pmic_pdcharger_ulog.o	:=  -I$(src)
+obj-$(CONFIG_QCOM_QMI_TMD) += qmi_tmd.o
 obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
 qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
 obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
diff --git a/drivers/soc/qcom/qmi_tmd.c b/drivers/soc/qcom/qmi_tmd.c
new file mode 100644
index 000000000000..54e5ce8dc462
--- /dev/null
+++ b/drivers/soc/qcom/qmi_tmd.c
@@ -0,0 +1,595 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025, Linaro Limited
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * QMI Thermal Mitigation Device (TMD).
+ * Provides cooling device support for remote subsystems
+ * running the TMD service via QMI.
+ */
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/net.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/qmi.h>
+#include <linux/soc/qcom/qmi_tmd.h>
+#include <linux/thermal.h>
+
+#define QMI_TMD_SERVICE_VERS_V01 0x01
+
+#define QMI_TMD_SET_LEVEL_REQ 0x0021
+#define QMI_TMD_GET_DEV_LIST_REQ 0x0020
+
+#define QMI_TMD_DEV_ID_LEN_MAX 32
+#define QMI_TMD_DEV_LIST_MAX 32
+#define QMI_TMD_RESP_TIMEOUT	msecs_to_jiffies(100)
+#define TMD_GET_LEVEL_REQ_MAX_LEN 36
+#define TMD_SET_LEVEL_REQ_MAX_LEN 40
+
+#define TMD_GET_DEV_LIST_REQ_MAX_LEN 0
+#define TMD_GET_DEV_LIST_RESP_MAX_LEN 1099
+
+struct tmd_dev_id {
+	char mitigation_dev_id[QMI_TMD_DEV_ID_LEN_MAX + 1];
+};
+
+static const struct qmi_elem_info tmd_dev_id_ei[] = {
+	{
+		.data_type = QMI_STRING,
+		.elem_len = QMI_TMD_DEV_ID_LEN_MAX + 1,
+		.elem_size = sizeof(char),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0,
+		.offset = offsetof(struct tmd_dev_id,
+				   mitigation_dev_id),
+	},
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+		.tlv_type = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct tmd_dev_list {
+	struct tmd_dev_id mitigation_dev_id;
+	u8 max_mitigation_level;
+};
+
+static const struct qmi_elem_info tmd_dev_list_ei[] = {
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = 1,
+		.elem_size = sizeof(struct tmd_dev_id),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0,
+		.offset = offsetof(struct tmd_dev_list,
+				   mitigation_dev_id),
+		.ei_array = tmd_dev_id_ei,
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof(uint8_t),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0,
+		.offset = offsetof(struct tmd_dev_list,
+				   max_mitigation_level),
+	},
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+		.tlv_type = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct tmd_get_dev_list_req {
+	char placeholder;
+};
+
+static const struct qmi_elem_info tmd_get_dev_list_req_ei[] = {
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+		.tlv_type = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct tmd_get_dev_list_resp {
+	struct qmi_response_type_v01 resp;
+	u8 mitigation_device_list_valid;
+	u32 mitigation_device_list_len;
+	struct tmd_dev_list
+		mitigation_device_list[QMI_TMD_DEV_LIST_MAX];
+};
+
+static const struct qmi_elem_info tmd_get_dev_list_resp_ei[] = {
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = 1,
+		.elem_size = sizeof(struct qmi_response_type_v01),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x02,
+		.offset = offsetof(struct tmd_get_dev_list_resp,
+				   resp),
+		.ei_array = qmi_response_type_v01_ei,
+	},
+	{
+		.data_type = QMI_OPT_FLAG,
+		.elem_len = 1,
+		.elem_size = sizeof(uint8_t),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x10,
+		.offset = offsetof(struct tmd_get_dev_list_resp,
+				   mitigation_device_list_valid),
+	},
+	{
+		.data_type = QMI_DATA_LEN,
+		.elem_len = 1,
+		.elem_size = sizeof(uint8_t),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x10,
+		.offset = offsetof(struct tmd_get_dev_list_resp,
+				   mitigation_device_list_len),
+	},
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = QMI_TMD_DEV_LIST_MAX,
+		.elem_size = sizeof(struct tmd_dev_list),
+		.array_type = VAR_LEN_ARRAY,
+		.tlv_type = 0x10,
+		.offset = offsetof(struct tmd_get_dev_list_resp,
+				   mitigation_device_list),
+		.ei_array = tmd_dev_list_ei,
+	},
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+		.tlv_type = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct tmd_set_level_req {
+	struct tmd_dev_id mitigation_dev_id;
+	u8 mitigation_level;
+};
+
+static const struct qmi_elem_info tmd_set_level_req_ei[] = {
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = 1,
+		.elem_size = sizeof(struct tmd_dev_id),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x01,
+		.offset = offsetof(struct tmd_set_level_req,
+				   mitigation_dev_id),
+		.ei_array = tmd_dev_id_ei,
+	},
+	{
+		.data_type = QMI_UNSIGNED_1_BYTE,
+		.elem_len = 1,
+		.elem_size = sizeof(uint8_t),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x02,
+		.offset = offsetof(struct tmd_set_level_req,
+				   mitigation_level),
+	},
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+		.tlv_type = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+struct tmd_set_level_resp {
+	struct qmi_response_type_v01 resp;
+};
+
+static const struct qmi_elem_info tmd_set_level_resp_ei[] = {
+	{
+		.data_type = QMI_STRUCT,
+		.elem_len = 1,
+		.elem_size = sizeof(struct qmi_response_type_v01),
+		.array_type = NO_ARRAY,
+		.tlv_type = 0x02,
+		.offset = offsetof(struct tmd_set_level_resp, resp),
+		.ei_array = qmi_response_type_v01_ei,
+	},
+	{
+		.data_type = QMI_EOTI,
+		.array_type = NO_ARRAY,
+		.tlv_type = QMI_COMMON_TLV_TYPE,
+	},
+};
+
+/**
+ * struct qmi_tmd - A TMD cooling device
+ * @name:	The name of this tmd shared by the remote subsystem
+ * @cdev:	Thermal cooling device handle
+ * @cur_state:	The current mitigation state
+ * @max_state:	The maximum state
+ * @qmi_tmd_cli:	Parent QMI TMD client
+ */
+struct qmi_tmd {
+	const char *name;
+	struct thermal_cooling_device *cdev;
+	unsigned int cur_state;
+	unsigned int max_state;
+	struct qmi_tmd_client *qmi_tmd_cli;
+};
+
+/**
+ * struct qmi_tmd_client - QMI TMD client state
+ * @dev:		Device associated with this instance
+ * @handle:		QMI connection handle
+ * @mutex:		Serializes QMI request/response sequences (qmi_txn_init,
+ *			qmi_send_request) during DSP subsystem restart and
+ *			protects @connection_active and @exiting
+ * @connection_active:	Whether or not we're connected to the QMI TMD service
+ * @exiting:		Whether or not teardown has started
+ * @svc_arrive_work:	Work item for initialising when the TMD service starts
+ * @num_tmds:		Number of tmds described in the device tree
+ * @tmds:		An array of tmd structures
+ */
+struct qmi_tmd_client {
+	struct device *dev;
+	struct qmi_handle handle;
+	/* protects QMI transactions, connection_active and exiting */
+	struct mutex mutex;
+	bool connection_active;
+	bool exiting;
+	struct work_struct svc_arrive_work;
+	int num_tmds;
+	struct qmi_tmd tmds[] __counted_by(num_tmds);
+};
+
+/* Notify the remote subsystem of the requested cooling state */
+static int qmi_tmd_send_state_request(struct qmi_tmd *tmd, int state)
+{
+	struct tmd_set_level_resp resp = { 0 };
+	struct tmd_set_level_req req = { 0 };
+	struct qmi_tmd_client *qmi_tmd_cli = tmd->qmi_tmd_cli;
+	struct qmi_txn txn;
+	int ret = 0;
+
+	if (!qmi_tmd_cli->connection_active)
+		return -ENOTCONN;
+
+	strscpy(req.mitigation_dev_id.mitigation_dev_id, tmd->name,
+		QMI_TMD_DEV_ID_LEN_MAX + 1);
+	req.mitigation_level = state;
+
+	ret = qmi_txn_init(&qmi_tmd_cli->handle, &txn,
+			   tmd_set_level_resp_ei, &resp);
+	if (ret < 0) {
+		dev_err(qmi_tmd_cli->dev, "qmi set state %d txn init failed for %s ret %d\n",
+			state, tmd->name, ret);
+		return ret;
+	}
+
+	ret = qmi_send_request(&qmi_tmd_cli->handle, NULL, &txn,
+			       QMI_TMD_SET_LEVEL_REQ,
+			       TMD_SET_LEVEL_REQ_MAX_LEN,
+			       tmd_set_level_req_ei, &req);
+	if (ret < 0) {
+		dev_err(qmi_tmd_cli->dev, "qmi set state %d txn send failed for %s ret %d\n",
+			state, tmd->name, ret);
+		qmi_txn_cancel(&txn);
+		return ret;
+	}
+
+	ret = qmi_txn_wait(&txn, QMI_TMD_RESP_TIMEOUT);
+	if (ret < 0) {
+		dev_err(qmi_tmd_cli->dev, "qmi set state %d txn wait failed for %s ret %d\n",
+			state, tmd->name, ret);
+		return ret;
+	}
+
+	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+		dev_err(qmi_tmd_cli->dev,
+			"qmi set state %d failed for %s result %#x error %#x\n",
+			state, tmd->name,
+			resp.resp.result, resp.resp.error);
+		return -EREMOTEIO;
+	}
+
+	dev_dbg(qmi_tmd_cli->dev, "Requested state %d/%d for %s\n", state,
+		tmd->max_state, tmd->name);
+
+	tmd->cur_state = state;
+
+	return 0;
+}
+
+static int qmi_tmd_get_max_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct qmi_tmd *tmd = cdev->devdata;
+
+	*state = tmd->max_state;
+
+	return 0;
+}
+
+static int qmi_tmd_get_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long *state)
+{
+	struct qmi_tmd *tmd = cdev->devdata;
+
+	/* cur_state is protected by thermal core's cdev->lock */
+	*state = tmd->cur_state;
+
+	return 0;
+}
+
+static int qmi_tmd_set_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long state)
+{
+	struct qmi_tmd *tmd = cdev->devdata;
+
+	if (state > tmd->max_state)
+		return -EINVAL;
+
+	/* cur_state is protected by thermal core's cdev->lock */
+	if (tmd->cur_state == state)
+		return 0;
+
+	guard(mutex)(&tmd->qmi_tmd_cli->mutex);
+
+	return qmi_tmd_send_state_request(tmd, state);
+}
+
+static const struct thermal_cooling_device_ops qmi_tmd_cooling_ops = {
+	.get_max_state = qmi_tmd_get_max_state,
+	.get_cur_state = qmi_tmd_get_cur_state,
+	.set_cur_state = qmi_tmd_set_cur_state,
+};
+
+static int qmi_tmd_register(struct qmi_tmd_client *qmi_tmd_cli,
+			    const char *label, u8 max_state)
+{
+	struct device *dev = qmi_tmd_cli->dev;
+	struct qmi_tmd *tmd;
+	int index;
+
+	for (index = 0; index < qmi_tmd_cli->num_tmds; index++) {
+		tmd = &qmi_tmd_cli->tmds[index];
+
+		if (!strncasecmp(tmd->name, label,
+				 QMI_TMD_DEV_ID_LEN_MAX + 1))
+			goto found;
+	}
+
+	dev_dbg(qmi_tmd_cli->dev,
+		"TMD '%s' available in firmware but not specified in DT\n",
+		label);
+	return 0;
+
+found:
+	tmd->max_state = max_state;
+
+	/*
+	 * If the cooling device already exists then the QMI service went away and
+	 * came back. So just make sure the current cooling device state is
+	 * reflected on the remote side and then return.
+	 */
+	if (tmd->cdev) {
+		guard(mutex)(&qmi_tmd_cli->mutex);
+
+		return qmi_tmd_send_state_request(tmd, tmd->cur_state);
+	}
+
+	tmd->cdev = thermal_of_cooling_device_register(dev->of_node, index,
+						       label, tmd, &qmi_tmd_cooling_ops);
+	if (IS_ERR(tmd->cdev)) {
+		int ret = PTR_ERR(tmd->cdev);
+
+		tmd->cdev = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static void qmi_tmd_unregister(struct qmi_tmd_client *qmi_tmd_cli)
+{
+	struct qmi_tmd *tmd;
+	int index;
+
+	for (index = 0; index < qmi_tmd_cli->num_tmds; index++) {
+		tmd = &qmi_tmd_cli->tmds[index];
+
+		if (!tmd->cdev)
+			continue;
+
+		thermal_cooling_device_unregister(tmd->cdev);
+		tmd->cdev = NULL;
+	}
+}
+
+static void qmi_tmd_svc_arrive(struct work_struct *work)
+{
+	struct qmi_tmd_client *qmi_tmd_cli =
+		container_of(work, struct qmi_tmd_client, svc_arrive_work);
+
+	struct tmd_get_dev_list_req req = { 0 };
+	struct tmd_get_dev_list_resp *resp __free(kfree) = NULL;
+	int ret, i;
+	struct qmi_txn txn;
+
+	resp = kzalloc_obj(*resp, GFP_KERNEL);
+	if (!resp) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	scoped_guard(mutex, &qmi_tmd_cli->mutex) {
+		if (qmi_tmd_cli->exiting)
+			return;
+
+		ret = qmi_txn_init(&qmi_tmd_cli->handle, &txn,
+				   tmd_get_dev_list_resp_ei, resp);
+		if (ret < 0)
+			goto out;
+
+		ret = qmi_send_request(&qmi_tmd_cli->handle, NULL, &txn,
+				       QMI_TMD_GET_DEV_LIST_REQ,
+				       TMD_GET_DEV_LIST_REQ_MAX_LEN,
+				       tmd_get_dev_list_req_ei, &req);
+		if (ret < 0) {
+			qmi_txn_cancel(&txn);
+			goto out;
+		}
+
+		ret = qmi_txn_wait(&txn, QMI_TMD_RESP_TIMEOUT);
+		if (ret < 0)
+			goto out;
+
+		if (resp->resp.result != QMI_RESULT_SUCCESS_V01) {
+			ret = -EPROTO;
+			goto out;
+		}
+
+		qmi_tmd_cli->connection_active = true;
+	}
+
+	for (i = 0; i < resp->mitigation_device_list_len; i++) {
+		struct tmd_dev_list *device =
+			&resp->mitigation_device_list[i];
+
+		ret = qmi_tmd_register(qmi_tmd_cli,
+				       device->mitigation_dev_id.mitigation_dev_id,
+				       device->max_mitigation_level);
+		if (ret)
+			break;
+	}
+
+out:
+	if (ret)
+		dev_err(qmi_tmd_cli->dev, "Failed to initialize TMD service: %d\n", ret);
+}
+
+static void qmi_tmd_del_server(struct qmi_handle *qmi, struct qmi_service *service)
+{
+	struct qmi_tmd_client *qmi_tmd_cli =
+		container_of(qmi, struct qmi_tmd_client, handle);
+
+	scoped_guard(mutex, &qmi_tmd_cli->mutex) {
+		qmi_tmd_cli->connection_active = false;
+	}
+}
+
+static int qmi_tmd_new_server(struct qmi_handle *qmi, struct qmi_service *service)
+{
+	struct sockaddr_qrtr sq = { AF_QIPCRTR, service->node, service->port };
+	struct qmi_tmd_client *qmi_tmd_cli;
+	int ret;
+
+	qmi_tmd_cli = container_of(qmi, struct qmi_tmd_client, handle);
+
+	scoped_guard(mutex, &qmi_tmd_cli->mutex) {
+		if (qmi_tmd_cli->exiting)
+			return 0;
+
+		ret = kernel_connect(qmi->sock, (struct sockaddr_unsized *)&sq,
+				     sizeof(sq), 0);
+	}
+
+	if (ret < 0) {
+		dev_err(qmi_tmd_cli->dev, "QMI connect failed for node %u port %u: %d\n",
+			service->node, service->port, ret);
+		return ret;
+	}
+
+	queue_work(system_highpri_wq, &qmi_tmd_cli->svc_arrive_work);
+
+	return 0;
+}
+
+static const struct qmi_ops qmi_tmd_ops = {
+	.new_server = qmi_tmd_new_server,
+	.del_server = qmi_tmd_del_server,
+};
+
+/**
+ * qmi_tmd_init() - Initialize QMI TMD instance
+ * @dev: Device pointer
+ * @instance_id: QMI service instance ID for the remote subsystem
+ * @tmd_names: Array of TMD names
+ * @num_tmds: Number of TMD names
+ *
+ * Context: Must be called from probe context.
+ *
+ * Return: Pointer to qmi_tmd_client on success, ERR_PTR on failure
+ */
+struct qmi_tmd_client *qmi_tmd_init(struct device *dev,
+				    unsigned int instance_id,
+				    const char * const *tmd_names,
+				    int num_tmds)
+{
+	struct qmi_tmd_client *qmi_tmd_cli;
+	int ret, i;
+
+	if (!dev || !tmd_names || num_tmds <= 0)
+		return ERR_PTR(-EINVAL);
+
+	qmi_tmd_cli = devm_kzalloc(dev, struct_size(qmi_tmd_cli, tmds, num_tmds), GFP_KERNEL);
+	if (!qmi_tmd_cli)
+		return ERR_PTR(-ENOMEM);
+
+	qmi_tmd_cli->dev = dev;
+	qmi_tmd_cli->num_tmds = num_tmds;
+	mutex_init(&qmi_tmd_cli->mutex);
+	INIT_WORK(&qmi_tmd_cli->svc_arrive_work, qmi_tmd_svc_arrive);
+
+	for (i = 0; i < num_tmds; i++) {
+		qmi_tmd_cli->tmds[i].name = tmd_names[i];
+		qmi_tmd_cli->tmds[i].qmi_tmd_cli = qmi_tmd_cli;
+	}
+
+	ret = qmi_handle_init(&qmi_tmd_cli->handle,
+			      TMD_GET_DEV_LIST_RESP_MAX_LEN,
+			      &qmi_tmd_ops, NULL);
+	if (ret < 0)
+		return ERR_PTR(dev_err_probe(dev, ret, "QMI handle init failed\n"));
+
+	ret = qmi_add_lookup(&qmi_tmd_cli->handle, QMI_SERVICE_ID_TMD,
+			     QMI_TMD_SERVICE_VERS_V01, instance_id);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "QMI add lookup failed\n");
+		goto err_release_handle;
+	}
+
+	return qmi_tmd_cli;
+
+err_release_handle:
+	qmi_handle_release(&qmi_tmd_cli->handle);
+
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(qmi_tmd_init);
+
+/**
+ * qmi_tmd_exit() - Deinitialize QMI TMD instance
+ * @qmi_tmd_cli: QMI TMD client to deinitialize
+ */
+void qmi_tmd_exit(struct qmi_tmd_client *qmi_tmd_cli)
+{
+	if (!qmi_tmd_cli)
+		return;
+
+	scoped_guard(mutex, &qmi_tmd_cli->mutex) {
+		qmi_tmd_cli->exiting = true;
+		qmi_tmd_cli->connection_active = false;
+	}
+
+	qmi_handle_release(&qmi_tmd_cli->handle);
+	cancel_work_sync(&qmi_tmd_cli->svc_arrive_work);
+	qmi_tmd_unregister(qmi_tmd_cli);
+}
+EXPORT_SYMBOL_GPL(qmi_tmd_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Qualcomm QMI Thermal Mitigation support");
diff --git a/include/linux/soc/qcom/qmi.h b/include/linux/soc/qcom/qmi.h
index b9dcb437a0be..683d27cee413 100644
--- a/include/linux/soc/qcom/qmi.h
+++ b/include/linux/soc/qcom/qmi.h
@@ -96,6 +96,7 @@ struct qmi_elem_info {
  * Enumerate the IDs of the QMI services
  */
 #define QMI_SERVICE_ID_TEST		0x0f	/*   15 */
+#define QMI_SERVICE_ID_TMD		0x18	/*   24 */
 #define QMI_SERVICE_ID_SSCTL		0x2b	/*   43 */
 #define QMI_SERVICE_ID_IPA		0x31	/*   49 */
 #define QMI_SERVICE_ID_SERVREG_LOC	0x40	/*   64 */
diff --git a/include/linux/soc/qcom/qmi_tmd.h b/include/linux/soc/qcom/qmi_tmd.h
new file mode 100644
index 000000000000..452f51f23731
--- /dev/null
+++ b/include/linux/soc/qcom/qmi_tmd.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2025, Linaro Limited
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * QMI Thermal Mitigation Device (TMD) library header.
+ */
+
+#ifndef __QMI_TMD_H__
+#define __QMI_TMD_H__
+
+struct device;
+struct qmi_tmd_client;
+
+#if IS_ENABLED(CONFIG_QCOM_QMI_TMD)
+struct qmi_tmd_client *qmi_tmd_init(struct device *dev,
+				    unsigned int instance_id,
+				    const char * const *tmd_names,
+				    int num_tmds);
+
+void qmi_tmd_exit(struct qmi_tmd_client *tmd_cli);
+#else
+static inline struct qmi_tmd_client *qmi_tmd_init(struct device *dev,
+						  unsigned int instance_id,
+						  const char * const *tmd_names,
+						  int num_tmds)
+{
+	return NULL;
+}
+
+static inline void qmi_tmd_exit(struct qmi_tmd_client *tmd_cli)
+{
+}
+#endif
+
+#endif /* __QMI_TMD_H__ */

-- 
2.34.1

