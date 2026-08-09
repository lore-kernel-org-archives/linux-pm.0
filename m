Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734B4214812
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786278636; cv=none; b=HcDfz46w6sIJ2WjhXqZajxiMUN/VXdUN2sUEg5TkwOpHzXWdNaYHhAH4smRztOonsxfYYOGA7/4C2jJ3WMK4fCbmJ61wvoGuVO3FMUFJ7WJpJbmeeUOer/anXX2s6FBRlyM1zy/zEI9e5MInbBT5jk85NPLT+ezvbIbu+d/MahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786278636; c=relaxed/simple;
	bh=Hd9Nn9n09AZNGTV46/QfXFtAJzN5htP275zS75BASFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kowxMkmJIhHyPBXtKdk+lhUetP6NeQtg6nzZbxB97b4d12tnm8aF4EBev3pZMsEECI6pLQE+e7zMLemZhYdIOyq2na0ePptFTlHKlVFI3NdXtcroatxRlHFU/vQ1OaVujnDDZo86dMS7kzo05f5fT/G+JJs08Z+tOqgTlJPcc0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nDjYT0uZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ITpIOgKK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nDjYT0uZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ITpIOgKK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679C1sGn2623777
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 12:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NICNV6Yj6xf0uEcuxcYKasRHhguGIhBcucK7mfqbGlY=; b=nDjYT0uZKJ5A1kDV
	LVZEFkfXLTMdZcauNTMZkUGOehJHM64oBqOr9CW8eYglg8lr6y7UKjnr68NtNFCv
	mBmKNTNEIku3A4AN6vkMknUb2oWGuVdBbGE6LpShUacILSh9PkszGw18ov8JDVlA
	T92TD8ZULMtLn3LcZU9P5hMQadd1POc0XphP2ARiPKZuv81Mm2dZiqgJNUcnUsYs
	WNCzyc8Nm2uErwv9klQubTXZL+rtYiT5RZA+K9pTrq75vRtHcoPiiwzaZq4uWCCm
	eugnZ+R/8dJiRwZgGp3BtkcQvXEbcg6EyNGMqE2x0eDLA33Rkd6QDfh3Jfa0Rljo
	JQq7qw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwush2w9g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 12:30:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso1814834a91.3
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 05:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786278632; x=1786883432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NICNV6Yj6xf0uEcuxcYKasRHhguGIhBcucK7mfqbGlY=;
        b=ITpIOgKK66lLAzqQTbozR9VHHSRhtFDFFQpa2BLfUhFoYf/B+xTKmfl7rBdQQdBosh
         P2Bj+7NABdnaYbyAMjV9B+0wP0TDTOAdaW0HHb6Ou+a5EOKN0N18JdQbHsAj9xpqA3FY
         2sPF3W790mqzYI8Paco4VBYxuCjlpRnAJPzxIfC6gcgV71OanYKr/sBtpskNtJTt8GfB
         8QlVTz5fnlWp1ixRNYBZvpEo4Yvdy0/womXKJljp7K+ld6L9mTUNSQYcKtGLwtzD18T1
         pJZ0n1G/yUhe2WHj2hRMGx3oz5/4Fn6c3roFd3xqluE9rHM/3sn3LkTkm6t4xecBRwXl
         oS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786278632; x=1786883432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NICNV6Yj6xf0uEcuxcYKasRHhguGIhBcucK7mfqbGlY=;
        b=X25WtCbEkG2cwm82t3W4cvPeE2BRm/wf+vHnYKh3ty/nm3OAJYuatSdVhvDs4ChQ6N
         rjlOeP3omzpIsqq/G3/fsPCJ0t94blP6piuzU8YIRpWX3EXCjUN4fZDFSvtnA146Skj8
         jxS3ugDWiJZ31+XCx752GY6ESv+5dn3z0EIcW5zRWdLRbWw1DWnDa61YF+JmRp42lh3s
         qw2HrPsZ3F61i9pzQpaOJii/DEqvvZ/Dm5rCrRstPOznD2H2GpUCCDT7Cd74GK3Mj8Tl
         RxGRzQXKJ6MW2gAmOsGguWbp3ezZMs907Kh0jEzzQII3GB3iMGLiDmjSrXM04f6jXYBo
         lKDA==
X-Forwarded-Encrypted: i=1; AHgh+RpYSDQVkyZv/OChmRSAS0SIxv7YTM4wYF2gz028ZOyHv5yCs3OH+Vp1NhY3YDgxqeJHCMHUIIy9dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyM9HvR3luob1bWE1RKxFM8obf9CCgOyKnN+au8yOJqTpH3phIO
	dE26kh+oT2uNnHU8OkQlR4FtcAs7c2ylUAh5v5tLaanU3limWujV2KgKM3QdjDkfCYo9D01oGij
	0Hf2nJmUpek+/tBlksep5v8QK5cHhCfIGJdXKhFPKvZBTLMn5txthbbeoqlk1Mg==
X-Gm-Gg: AR+sD10Q1AFEohntSNDQd/SNWJtqSfoTxExMXsSnRaakvTYUSowceFhh3L9CKQkH+mA
	NxR7q4hTqR4ylCD9gmNQx5jsOxYzQ+rvmcEiKDE0UM5QjabCZq2+9MoRaYPp5MFiAPIHpNTjrcM
	z0vk+HVTE9os59juNrVHW6C/kBFW2G6+OQgnnYkzWFgoz1soHtRkAQPMK66K4Jnv4XV+f60FQeK
	nYARIE+ln/CaHWzMD1xsCBhwe+EwR7Ewt8ZNfuhSMpby0d54l66jKZRcxkqb1rJ4XvRpobF1568
	ch+RjNDFxgudXnBlW1pcET0YYvOyNa5YFNepw1sMLu81MUlkp5mO45MZC2I5NrJ65q6WDsd2ZXj
	sy/+N4U0m2R2iAH8DZY2FNkG9DIOeWg==
X-Received: by 2002:a17:90b:2785:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-3903c5d2f29mr39018530a91.12.1786278631668;
        Sun, 09 Aug 2026 05:30:31 -0700 (PDT)
X-Received: by 2002:a17:90b:2785:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-3903c5d2f29mr39018410a91.12.1786278631021;
        Sun, 09 Aug 2026 05:30:31 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm51842997eec.18.2026.08.09.05.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 05:30:30 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 17:58:59 +0530
Subject: [PATCH v8 3/9] remoteproc: qcom: pas: add support for TMD thermal
 cooling devices
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-b4-qmi-tmd-v8-3-b15d47adc379@oss.qualcomm.com>
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
        manaf.pallikunhi@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786278595; l=5213;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=Hd9Nn9n09AZNGTV46/QfXFtAJzN5htP275zS75BASFg=;
 b=EcXhX72TwEbL970n1s+boTvvuStl2qaPp/Ka5abO4VTZM465rNyx2YLe5opDFIoFVg/O0qj6D
 EV9VVVMoWJeCt+tBWKtYd8cc6HKWv0pp8Cx35UujwP2eegLId22dWwm
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-GUID: 8Y6-LpZ0b_Bo8wXSGv62_PJAiCv2BrQ2
X-Authority-Analysis: v=2.4 cv=GvpyPE1C c=1 sm=1 tr=0 ts=6a7872e9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=p67dmK6jBiiEd9TVeScA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 8Y6-LpZ0b_Bo8wXSGv62_PJAiCv2BrQ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDExMCBTYWx0ZWRfX/L0je950zt5z
 xdy7EsO+Futhu1t5L5p3NN04Vrb5bk4qi644OZxmY5lQsuL7PN9cFtVf0mRSYvckfsXLyd7WhBS
 aGzOq8znud8uiKtManUmjeHIMmtct4rYolwK/0U1/2W4uqpmR1lD0jCCtASOjl68eX7RiXutrZr
 L+ixtHIUV4+ClSnbZnIiKqQKxOTXfvGsM8j9TDTt6L+HJIgI+pSHPh01jy2zsLMvHUSAVRSsD0x
 woA92pJPlo47+01Kc5v9KCxpOV1P6GgBXHtNt3HvmF9STHJO/WqnXdTyjqvz3q8H/AkxdcCXFOw
 jF92VT6QCjTBU86LW5D+1E3sTF1RYMIRIcsnirIx1KxzcBsXKSdXksLRAFoLskMLBfaxfLpL8xj
 36rq9t3zBF1mr+mPXbwnVaWqqqo6Kyj4nD+lZCnTM2eVWKGh13OmHXu+h+OVKF3Ky3fiAepIkiX
 JWPEPSuifmy5dUxYFYg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDExMCBTYWx0ZWRfX8k0RqBXPWaJJ
 e7Av0pvHH64wtWaYBlU3z5gh1/ZKkdOSWBaXVhJowBcQvL50UfMedPONHtrv5K5EeGA2xssLu4G
 pIwCiOrddK6ETpvpfW2FLMd+hRfEZwE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090110

Register Thermal Mitigation Devices (TMDs) for PAS-managed remote
processors to enable thermal throttling through QMI.

This allows the thermal framework to request mitigation when remote
subsystems such as modem and CDSP contribute to thermal pressure.

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 drivers/remoteproc/Kconfig         |  1 +
 drivers/remoteproc/qcom_q6v5_pas.c | 90 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 65befdbfa5f7..152d7a53aa09 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -229,6 +229,7 @@ config QCOM_Q6V5_PAS
 	select QCOM_PIL_INFO
 	select QCOM_MDT_LOADER
 	select QCOM_Q6V5_COMMON
+	select QCOM_QMI_TMD if NET
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
 	select QCOM_PAS
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 25599d728208..b9c01ce5024e 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2016 Linaro Ltd
  * Copyright (C) 2014 Sony Mobile Communications AB
  * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/clk.h>
@@ -26,8 +27,10 @@
 #include <linux/regulator/consumer.h>
 #include <linux/remoteproc.h>
 #include <linux/soc/qcom/mdt_loader.h>
+#include <linux/soc/qcom/qmi_tmd.h>
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/smem_state.h>
+#include <dt-bindings/thermal/qcom,pas.h>
 
 #include "qcom_common.h"
 #include "qcom_pil_info.h"
@@ -38,6 +41,16 @@
 
 #define MAX_ASSIGN_COUNT 3
 
+/**
+ * struct tmd_name - TMD device name to cooling-device index mapping
+ * @name: TMD device name
+ * @id: Cooling-device index used as #cooling-cells cell 0 in DT
+ */
+struct tmd_name {
+	const char *name;
+	int id;
+};
+
 struct qcom_pas_data {
 	int crash_reason_smem;
 	const char *firmware_name;
@@ -58,6 +71,10 @@ struct qcom_pas_data {
 	int ssctl_id;
 	unsigned int smem_host_id;
 
+	unsigned int tmd_instance_id;
+	const struct tmd_name *tmd_name;
+	int num_tmd;
+
 	int region_assign_idx;
 	int region_assign_count;
 	bool region_assign_shared;
@@ -122,6 +139,8 @@ struct qcom_pas {
 
 	struct qcom_pas_context *pas_ctx;
 	struct qcom_pas_context *dtb_pas_ctx;
+
+	struct qmi_tmd_client *tmd_inst;
 };
 
 static void qcom_pas_segment_dump(struct rproc *rproc,
@@ -798,6 +817,64 @@ static void qcom_pas_unassign_memory_region(struct qcom_pas *pas)
 	}
 }
 
+static int qcom_pas_setup_tmd(struct qcom_pas *pas, const struct qcom_pas_data *desc)
+{
+	struct qmi_tmd_client *tmd_inst;
+	const struct tmd_name *tmd;
+	const char **tmd_names;
+	int i, ret;
+
+	if (!device_property_present(pas->dev, "#cooling-cells"))
+		return 0;
+
+	if (!desc->tmd_name || desc->num_tmd == 0)
+		return 0;
+
+	tmd_names = devm_kcalloc(pas->dev, desc->num_tmd,
+				 sizeof(*tmd_names), GFP_KERNEL);
+	if (!tmd_names)
+		return -ENOMEM;
+
+	for (i = 0; i < desc->num_tmd; i++) {
+		tmd = &desc->tmd_name[i];
+
+		if (tmd->id >= desc->num_tmd) {
+			dev_err(pas->dev, "Invalid TMD id %d for '%s'\n",
+				tmd->id, tmd->name);
+			return -EINVAL;
+		}
+
+		if (tmd_names[tmd->id]) {
+			dev_err(pas->dev, "Duplicate TMD id %d for '%s'\n",
+				tmd->id, tmd->name);
+			return -EINVAL;
+		}
+
+		tmd_names[tmd->id] = tmd->name;
+	}
+
+	for (i = 0; i < desc->num_tmd; i++) {
+		if (!tmd_names[i]) {
+			dev_err(pas->dev, "Missing TMD mapping for id %d\n", i);
+			return -EINVAL;
+		}
+	}
+
+	tmd_inst = qmi_tmd_init(pas->dev, desc->tmd_instance_id, tmd_names,
+				desc->num_tmd);
+	if (IS_ERR(tmd_inst)) {
+		ret = PTR_ERR(tmd_inst);
+		if (ret == -ENODEV)
+			return 0;
+
+		return ret;
+	}
+
+	pas->tmd_inst = tmd_inst;
+
+	return 0;
+}
+
 static int qcom_pas_probe(struct platform_device *pdev)
 {
 	const struct qcom_pas_data *desc;
@@ -925,16 +1002,24 @@ static int qcom_pas_probe(struct platform_device *pdev)
 	if (desc->early_boot)
 		pas->rproc->state = RPROC_DETACHED;
 
-	ret = rproc_add(rproc);
+	ret = qcom_pas_setup_tmd(pas, desc);
 	if (ret)
 		goto remove_ssr_sysmon;
 
+	ret = rproc_add(rproc);
+	if (ret)
+		goto remove_setup_tmd;
+
 	node = of_get_compatible_child(pdev->dev.of_node, "qcom,bam-dmux");
 	pas->bam_dmux = of_platform_device_create(node, NULL, &pdev->dev);
 	of_node_put(node);
 
 	return 0;
 
+remove_setup_tmd:
+	if (pas->tmd_inst)
+		qmi_tmd_exit(pas->tmd_inst);
+
 remove_ssr_sysmon:
 	qcom_remove_ssr_subdev(rproc, &pas->ssr_subdev);
 	qcom_remove_sysmon_subdev(pas->sysmon);
@@ -962,6 +1047,9 @@ static void qcom_pas_remove(struct platform_device *pdev)
 
 	rproc_del(pas->rproc);
 
+	if (pas->tmd_inst)
+		qmi_tmd_exit(pas->tmd_inst);
+
 	qcom_q6v5_deinit(&pas->q6v5);
 	qcom_pas_unassign_memory_region(pas);
 	qcom_remove_glink_subdev(pas->rproc, &pas->glink_subdev);

-- 
2.34.1

