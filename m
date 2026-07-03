Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5A53546DE
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 05:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055042; cv=none; b=WkA011B/YALCyt/htjxQdU9pXIFnggSCHZJYmg0pNybFhi0zFsX7aXygctbgHXlBcxMrmO2Blc2/0065/Tc5hwa5gMIKuhUYF+8rdddG/P3BNDPWTpnTuSrL56lJ2AQeak/3Z0rhkd9nLWDIqkOXy2YL1mcRHK6b3SkaAJj9+3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055042; c=relaxed/simple;
	bh=Z/WKNegsFatsDkLsxVMEZ3HsqNDu3wLrVIGJkYC/vDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tYNx8V9mNXipua8q/oM2zeUzCG8m6Q2witaXEUjBtesg2I3C0cVbgmX759kqwl5Oolqht1OaeDW07bhT0mOxY8+qAcmreKOoBQPsnfkgN3Rh13WrwD9if76T8AldzhsJU+VC4lQdFib8GAO6KhpqAMyneKwbwlUQ7mSWm4h6uJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tfu0MG8E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LsROdTFK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tfu0MG8E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LsROdTFK"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66342ti62816754
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 05:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FZk/vWN/O5F/ZDLqPE8QMw1fE1YoVN9Nf7DQqyExBlM=; b=Tfu0MG8ETJE7D4iT
	uEJssPb+iZky/iJo7Quo0oveYgdgvaMU08mTQfgH8FmVX0OdTrKudsKIPK3OXMMr
	xHXP4kFO5O92LGX7YEQJAaLCVFGdpej2o7MWjmpvQXcxLTudZGh7omqo6HZb0RkQ
	ZpTscgnmX0NxD0Gi7lTYgJ5SdR1pbTNLBgwLqoyXvXE2ZiofeX1P8gONhrMVGH/O
	L3Qvv0rE6ERxjHF7V4OwZjDJ+4kfO0xdyhDHq4wrSDt1MhpFg7Q522RV+R9uq7Tc
	6ruzztQn0zOz/30W/fAjAxnqci4zuJ6D2orYD+Z0suEMNxUtfZC72J75Qf/e1xbk
	u3gt9w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnpbjmv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 05:03:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so169651a12.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 22:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783055029; x=1783659829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FZk/vWN/O5F/ZDLqPE8QMw1fE1YoVN9Nf7DQqyExBlM=;
        b=LsROdTFKp2alb6Zt5orjcg4a2SbRtYbHKKTQ2yc+f1ZzIkdaJ3ogfDrFfeeZLpZIRq
         m4kN2CJJC06elcwbg+BRj3rcNvA6BPMW/Kj+dxFzgLGIwdz8VsZA2wwwTdIMSJ3WZF8I
         w7+QtZkMgNzW4I52YCYdPr7ekonxL/MPiNW7mL+i/Rd8gCqDL7YC7etGk5Vm545L2Z+l
         kUItNuSju+snavAe4mOmH9oqSn90ue0ahOzDOl61aRLcsglfwjuWX5m1O0U6wAJZjxuG
         aOsMqduQ1wtwMO9lWZIc4P06j1lxrU7EO0qKlM4/ctusUXqE2dlXZQVe3DcqCefzVw3w
         A/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783055029; x=1783659829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FZk/vWN/O5F/ZDLqPE8QMw1fE1YoVN9Nf7DQqyExBlM=;
        b=TA6dUrsziIki5JspLxG1hBYpyUYbgYIYrb+yBoDBxyDiqHJs+AIY5enZk5Z5oNLGFI
         DW+ryH/LYJ3hVr2YMVDPkeZhCN9QWd6LhY7uThizDGhJ2LCCbK/IVyywWpC/ziPmlpDf
         WJRreTxi2RvtEifIVSS6oKwYZxYJWvQ2dIRtH2Cl3b83T0+L+z/kFZI5iFeTJ3l+oe5r
         ipvKDlT0dahfUUEhoJ0fmX6yJgkeUF3ctJ4M+AHgSWNHAgaN6oAanIXn7Dg2AqMPVLWB
         X0Y8xT38iS23zQIDhJTjRAn3dbMvONtROg4UGRU3i7HaY7DyAn83x21/f6JFdTe9rOU9
         HNkw==
X-Forwarded-Encrypted: i=1; AFNElJ8alglVhohHv9n4KcUZde/JCevO0ohGvvk9eKiGK6mkn8wPuwPJqByB7J2n+tGt2v2Dr7F0QvnijA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzuq3o3NQT40dpQZhCuryV3Wp1yVIFrNBa3KT4d8uILe/u99Ra
	LnuVNtnXl24Gw+K3DZlr52Y5JzmsjlL/8c5phFSGQ59ASlHwEUS9tesOWYXcoa2RY/1fJcrrREY
	5XiP7mTYRiN+/GNzkQ1qefemx1eWDARK15W48o+f275CqzjIJEKDlwnrASjcbAg==
X-Gm-Gg: AfdE7ck15kehg95RwcoFxZpLleMRpfibyC9UenCwP6vxgWkjQpn9t97M7Plg28AODWh
	RG5L9OPDVTaZdNTYod3at9uRyVRDU+sqR9NcxPbs90bv19CZbwjM9pQdHKJFkwY3XEFzC83QiZg
	+qmaWRT/Gwo3jKJ5eX+b+QQxJlfTaMnS3fys5Awmca2Mp20zHdNM4ljIALq2+VaJtUDyw+cgyWe
	IiLmDvoBmn6++73O9W5VKQMVWEJtypXX4WHpkio2KjxwAfMYZ87DVugAkvZgn44WC2BvvWcrFnZ
	AK4KqaLrv4v0/czGdDGpEJdkA9w/5StFVFWoQWkt0rzaWmxLGeKioQQUluH+Oi+KCvsbWiV1zMz
	JRxxSfZsDkcvpwleHny1IPOmKPn9L2JdbC7flZXCd
X-Received: by 2002:a05:6300:6715:b0:3bf:b0b8:58b5 with SMTP id adf61e73a8af0-3bff422d1d6mr9767400637.36.1783055029085;
        Thu, 02 Jul 2026 22:03:49 -0700 (PDT)
X-Received: by 2002:a05:6300:6715:b0:3bf:b0b8:58b5 with SMTP id adf61e73a8af0-3bff422d1d6mr9767367637.36.1783055028571;
        Thu, 02 Jul 2026 22:03:48 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd2362sm16771941eec.20.2026.07.02.22.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:03:48 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 10:33:04 +0530
Subject: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD device
 type constants
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-qmi-tmd-v4-1-3882189c1f83@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
In-Reply-To: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783055015; l=2444;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=Z/WKNegsFatsDkLsxVMEZ3HsqNDu3wLrVIGJkYC/vDQ=;
 b=4rAKxVmboxTEsxT7HFUBnFpo6MQMdbnmWvyZUSL6xjXKCseXH82IXoJP7DNAKZwcClya1CWVA
 a/S+elRIqK6B9a3GaJd8IrCbMsNhTm75h0rXG2Xf0nt9X2cyTRbxdFd
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfXzQhRSDisHzor
 24tQErG2PtYycDw05wDPbuyJKXyuc93VBQbhXx7y4xtsBEpAhBb4NGAOgBj3IwG2nF/NoTjOEMV
 m7Ujb4BKT1iQFAWSsQfLGCuWyyRS+2E=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a4742b6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=aPnvGIK-T0NEGnooipsA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfX8VEv6rMGALkq
 wGgOyqudGlPt+d7QIX1tiDSa27h+suPWMBTun71qgxz6MHfrYldhNEF6Zu540WlBTUKU3L+uAAz
 rdgdOMDbMaJ2UDrlhuuJYURykSGk/w0ABr/yjliewa/NO5e59gabjcOXM3yoMMY8ocVFo/FnVD0
 Ko8NZ4Se8/BjxZH0lJDSlc0Ci1caqQF/7VGyb6Dnt4uxSO2AeY+MHJgn4ioPQiCUg1tbhX14KW+
 oKD+h3PTMOnrS999P/bzCNQHN3E9tCRrC9Prrl/kv6fPEaVCJzU9DComs4yyAvfEiI1IF569vp5
 /KH1/95xORpWtrUjVEdJpaJtpFjLxCmoEDDif8q4YqntFcYUnKKwhnOm1juEbjz2jtTs1t03fKy
 aHZzIWbDnyGl9jgwERHWY2/52cLO/nHtvA3MoOBKz5det8YL6GG4p79OPz7geXLgfTN2Rg+eeYL
 gnKHy7i2ZOg5orgaLiA==
X-Proofpoint-ORIG-GUID: VvgKED1TF8aDAJWSgiL9SNyu__-Y3c3m
X-Proofpoint-GUID: VvgKED1TF8aDAJWSgiL9SNyu__-Y3c3m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030045

Add Device Tree binding constants for Qualcomm Thermal Mitigation
Device (TMD) types used by remoteproc-backed thermal cooling devices.

Qualcomm remote processors expose thermal mitigation endpoints
through QMI. These endpoints can be registered with the thermal
framework via the `#cooling-cells` property on the remoteproc node.

The QMI TMD protocol identifies devices using string names (for example,
"pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
`#cooling-cells = <3>` requires numeric device id in the form:

  <&phandle device_id min_state max_state>

Define common TMD device index constants shared across currently
supported platforms. If a future target requires a different mapping,
additional target-specific constants can be introduced while preserving
existing DT ABI.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 MAINTAINERS                                 |  1 +
 include/dt-bindings/firmware/qcom,qmi-tmd.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57656ec0e9d5..ffd85fd1dd80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3410,6 +3410,7 @@ F:	drivers/firmware/qcom/
 F:	drivers/soc/qcom/
 F:	drivers/watchdog/gunyah_wdt.c
 F:	include/dt-bindings/arm/qcom,ids.h
+F:	include/dt-bindings/firmware/qcom,qmi-tmd.h
 F:	include/dt-bindings/firmware/qcom,scm.h
 F:	include/dt-bindings/soc/qcom*
 F:	include/linux/firmware/qcom
diff --git a/include/dt-bindings/firmware/qcom,qmi-tmd.h b/include/dt-bindings/firmware/qcom,qmi-tmd.h
new file mode 100644
index 000000000000..73efecef0f3c
--- /dev/null
+++ b/include/dt-bindings/firmware/qcom,qmi-tmd.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Qualcomm QMI TMD (Thermal Mitigation Device) cooling device indices
+ *
+ * These indices are used in device tree cooling-maps to reference
+ * specific TMD devices provided by remote processors via QMI.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
+#define _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H
+
+/* CDSP thermal mitigation device id */
+#define QCOM_CDSP_TMD_CDSP_SW	0
+
+/* Modem thermal mitigation device id */
+#define QCOM_MODEM_TMD_PA	0
+#define QCOM_MODEM_TMD_MODEM	1
+
+#endif /* _DT_BINDINGS_FIRMWARE_QCOM_QMI_TMD_H */

-- 
2.34.1

