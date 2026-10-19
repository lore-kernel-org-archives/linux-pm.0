Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC03C549FE9
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419196; cv=none; b=FzA/0X8nL01G3ocbnodxPBD9vdQgA6HMnl80TMceQAz1OCxaDgHrWD0OVI4dtBaE8333t4/vVAW+9GBlEkKohiQQEZqSicZMgI6Y2JQ7p4nqQ7jtlt6sTB04qy0G8p8z4jKs5+0g0E18yDR67IWfdxCSaQnPKaxy3QfKkCULyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419196; c=relaxed/simple;
	bh=KDw1fsTCiuriG9Ndr5KdFkkS7fnFpgOyN3rQCmpFgaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jmqy8ZFDzqLE8MtFyXixm8/PhEg+RDYsdWDvatSj3OXvF9iJSMYTRVT6LS9rml7TlMBjVoBsQWHdqgZ8l7zBr+Q0qcWc+ku5wqXav0EUh005aup4SsqJWuf24SDEbKK2oDmpINuI2yAOFOSiIbG7kE05V9UEo5N4XEQobT1dvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tp5wz7cI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c0TrJ4F9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tp5wz7cI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c0TrJ4F9"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JE0dmf2081650
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eXgKM8R+toseZhWkIdtBcojjH2M1WyQ8MWEfnY/Vbsg=; b=Tp5wz7cIZyw+HpnS
	8T9IBRLQCmBKAj4d4AK52Oi3/N+3m+m/KwrIUS5a/CbNcnSgqZaElzXGWfT1hFl+
	DMzRTa6kJ3pKo8CKJFKQtWn8CTLpiISCNBATVcU3lZdIu2QLlvnBaomq2Z3of+Dj
	R9LullYsgSWJ+u3HJ4QUiSPiL6GGlPCELWB/8/foU4elUAUp8aCC7Z+ptE4ROJPj
	fp0Kpi0govpTyv4relCa263NLCZL9s28TyNFEQQy2J23p8KzS9pDy4OZbH247+6j
	+6RK9pi0A7f0h+i8JLw7DbOkr9m+MkvcBNX33qjVBqdbbRkPfNvEm1Ja0Rjaxk8R
	aD1/zQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf4rhhrp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:13:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ce7a85f04so446351685a.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792419190; x=1793023990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eXgKM8R+toseZhWkIdtBcojjH2M1WyQ8MWEfnY/Vbsg=;
        b=c0TrJ4F9KKo7enRvUt7R6fQDF3F7xxMfGxyrB5D+n/xhUEh9ZGFpgoXX9s3XV9LFb7
         fTG6tGnouwpUdH+q15HbfhNMEfBFsqMFLpXxfpX5HEI3k96BtDrdBc/o+IIwP24IAP5L
         ubG8gSgyv3RcfIsqlsQ/zVh17F9rqecypU0bTOaIzls1X/7b4tsGg+a0SZMe3A2izqD9
         oYSMNOhwFm3mchxbiY8BUWC1LQHAJ9mA5Cep9m5QWK5YL3drtqd1PJ9Y5bg7zvFEdQiT
         MWfY7/EkpU1IWAGGsCCr+0WLNAY5FAzm3AoFggbBtBo2VlLlTGOao+tMp89uL8wtEwbb
         ocvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792419190; x=1793023990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eXgKM8R+toseZhWkIdtBcojjH2M1WyQ8MWEfnY/Vbsg=;
        b=ns+zv7PiSP2zEj6RKSHIrrHs+NeuqVSZzel6pbrQpwYYYClXV1bCagOFlKenp9ESVI
         +xOm4eeYv7XSy653BQstWt0nX4oxd6PEXPQEUHYuwR1APcJvlLl3DRDJAiMSt40St79C
         QWnnM9UoVPOEB8S3oGJavQP1Yh0KRMrrUneIUsHryrIIYWKOdyedTt+IIICANYdD9IuF
         SQnr4JGiPKMy1TEPT6QliuOxhSQp5Y7E5CWTQAgj1VimrZj6HkbMMlzHBi1JasrNYCPk
         wxBcAaV9zjKeq8iVq0atZpQn5lzF8/3lf/zXtIjmX4KY8HyZ3wDiS3YicoGX4HJA6U6j
         8w4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwYFRhVkKs2RorxgC1CM5sGvOpmGBVp4neeOTlvqmEWeNwGUaP72vvMzQ4QpkbZy3adiprhTHM4Hg==@vger.kernel.org
X-Gm-Message-State: AFq9FYL7g/2rXT8WGPwgxN1rpOPgOXstb8sQYcmv56UCKdyEn/8s0tsn
	LEdUGWWMboUReAHpZAPXvLZuNM7Q2DOf3jMCSC5udmT7IvhRV4Djh7+TJm7Jp+h36e4Dpd+TdL/
	9/S8dULmhqwQzco9ly/diklR6hERZK6PhFQnyXwHxaJwRwZnfURI+20HEkVy7EQ==
X-Gm-Gg: AYBFou0L9R3mCLN7kbXteI+T+6zDblTBlzu8yxpGMvyaFQwHOv5iAem3Tyo9ri1jrnz
	UijDF6EL0gpps8Q3kE8igpFRqbK9L0U4rRAtkcmIR/W+UXZCk6Djxx7X+BI9Yc5WFoScUYBvZ+S
	YX4oSY00LhY9JQ3727suU5I55pQ44+tNWlzcez0Q744f+/lX50DzLfdwUCPT2aaq1ahDyKjZ4Ih
	Zd16PZNabjQ394HuLgfwLzPvoG24LhtDla/4PT7+cor/t40tFXuwzcPPSgDQtnUv7p+IL/Ste2/
	f2Oqplu7uYniACI5qKBtQiak9HOjtpjkt/XI7IR2WzYw2xC8HOXl7SW3X6m7kac44xuGjWDvTPS
	JMHbOWKOgEKLjT9B247lueitwES/+pzjhgA8rLRsV3Sg+xKNVkMWgZw8iZHWZEclAMWtKPTi9Jk
	CGFhzDFPVyYWfR
X-Received: by 2002:a05:620a:25c6:b0:93e:e425:229f with SMTP id af79cd13be357-93f29e05e8dmr1251607785a.77.1792419189184;
        Mon, 19 Oct 2026 07:13:09 -0700 (PDT)
X-Received: by 2002:a05:620a:25c6:b0:93e:e425:229f with SMTP id af79cd13be357-93f29e05e8dmr1251595085a.77.1792419188208;
        Mon, 19 Oct 2026 07:13:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a42ade9sm2015922e87.14.2026.10.19.07.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:13:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 17:12:44 +0300
Subject: [PATCH 6/8] interconnect: qcom: add MSM8998 interconnect provider
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-msm8998-icc-v1-6-c2da3934b6c8@oss.qualcomm.com>
References: <20261019-msm8998-icc-v1-0-c2da3934b6c8@oss.qualcomm.com>
In-Reply-To: <20261019-msm8998-icc-v1-0-c2da3934b6c8@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=54538;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=RfDg4OIvwCrCnAB+2guT6lTEXibyhIUMruvLqSZX9Y8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1iVhIvi/vtSXIW5OVCKS+yc5krvTxd7xJmDq1
 KuzxweMObWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYlYQAKCRCLPIo+Aiko
 1cZBCACTtjcQnasMHgSxVZ0Ysi8aL3i6gfU84Kp61iCusXbrRr21jQ/8p0TQxu/+v8h53gCLZoX
 SVSpO4hxj2sf0sZ19NXBY1F8ENqD6XcgmfNk7ZrtO3v+KguFxkc9Ym/AqLLOQRI7XFrqAkEj4Vd
 r7yWW0RaaERZbaRTmRjW3kEPLfmchFvQAD0RtCdR6L774eoxuZ7QkehatYGu3bs20++TiSQE2Vi
 wtFH0J8NWKMUGg1J5AJ0Zl3OwI1lbFVxT1vwhOBpKOO++NaDtR7OqAsuAgwoYElewJFPTHXhT7i
 dO+w5ij6LBQWsaPyT3Un9/nmYdKa+qLcvirFjj2jMGMstAa8
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: K-xnVyrg2PKWhsq_DswEoNBlR80WZr6D
X-Proofpoint-GUID: K-xnVyrg2PKWhsq_DswEoNBlR80WZr6D
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ad62577 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=tVI0ZWmoAAAA:8 a=57qEtStrUSvPn45PVs4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22 a=-BPWgnxRz2uhmvdm1NTO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1NiBTYWx0ZWRfX5JifTZnoQPfn
 LlnFBsqn9OiniNapHlFxlyCKJ9UoBJjYIySeTLr2EWAuZhKDkIvutr5wEO/1tTcZ73d+uKaIJIq
 ry21OLYGaU9S6fhFiJJRJASlHpmfHFkolM5Gdq5L7eSiLCo6Z8fFhjVW590D6D+gQC1fjbtHL1t
 6yLjeVIkSt/q5GLLs/O2kSERKKIqrkGZi8Mb3M3hNmR0HgykeBGLCGZUtip+Rm499adWqCs2PGh
 0B9HtMmzFS/0jhPgqGzqMxZgkctBXCTwBHjH5Osz5yHXkjtLmB3GRwnhuMO5qiMiV6Y3BjlKrTt
 Hm3LTZZ35ULYN9Pc2TNo2SM9KNHfNiRJ4iHmXmFIKRKcdWsVUU2jI4YyM/fW7tyzv4Dbf7PHe5n
 9GGYq3JMVuC3jv2W9M/uU7yEpksVdaN/9miGPNfy4FWaIyAXqQrRYPuECFatbDynm1I0gTYQYdc
 8mvyOEV5H4/zSS+hkOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1NiBTYWx0ZWRfX9MBCaiWa1v3h
 ztFzAYhj6tq/lZG3Lia8gll+XfDUBzdFjQ6sM3MNWUvN4FeCBaf+4ze5w80RteXQIFbazUhNdsG
 X4Sc044KPNf5Ehf00mujCbtk0KBubEU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190056

From: Konrad Dybcio <konrad.dybcio@linaro.org>

Add the complete MSM8998 SMD RPM interconnect topology, including all NoC
providers, global graph IDs, local onecell binding IDs, QoS configuration,
and RPM clock resources.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig   |   11 +
 drivers/interconnect/qcom/Makefile  |    2 +
 drivers/interconnect/qcom/msm8998.c | 1978 +++++++++++++++++++++++++++++++++++
 3 files changed, 1991 insertions(+)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 7f3a977e8f10..1287f525085d 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -158,6 +158,17 @@ config INTERCONNECT_QCOM_MSM8996
 	  This is a driver for the Qualcomm Network-on-Chip on msm8996-based
 	  platforms.
 
+config INTERCONNECT_QCOM_MSM8998
+	tristate "Qualcomm MSM8998 interconnect driver"
+	depends on INTERCONNECT_QCOM
+	depends on QCOM_SMD_RPM
+	depends on ARM64 || COMPILE_TEST
+	select INTERCONNECT_QCOM_SMD_RPM
+	default ARCH_QCOM
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on msm8998-based
+	  platforms.
+
 config INTERCONNECT_QCOM_NORD
 	tristate "Qualcomm Nord interconnect driver"
 	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index a71478aaf591..078598ee782f 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -19,6 +19,7 @@ qnoc-msm8953-objs			:= msm8953.o
 qnoc-msm8974-objs			:= msm8974.o
 qnoc-msm8976-objs			:= msm8976.o
 qnoc-msm8996-objs			:= msm8996.o
+qnoc-msm8998-objs			:= msm8998.o
 qnoc-nord-objs				:= nord.o
 icc-osm-l3-objs				:= osm-l3.o
 qnoc-qcm2290-objs			:= qcm2290.o
@@ -69,6 +70,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_MSM8953) += qnoc-msm8953.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8976) += qnoc-msm8976.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8996) += qnoc-msm8996.o
+obj-$(CONFIG_INTERCONNECT_QCOM_MSM8998) += qnoc-msm8998.o
 obj-$(CONFIG_INTERCONNECT_QCOM_NORD) += qnoc-nord.o
 obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) += icc-osm-l3.o
 obj-$(CONFIG_INTERCONNECT_QCOM_QCM2290) += qnoc-qcm2290.o
diff --git a/drivers/interconnect/qcom/msm8998.c b/drivers/interconnect/qcom/msm8998.c
new file mode 100644
index 000000000000..df0f5f206d46
--- /dev/null
+++ b/drivers/interconnect/qcom/msm8998.c
@@ -0,0 +1,1978 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm MSM8998 Network-on-Chip (NoC) QoS driver
+ * Copyright (c) 2020, AngeloGioacchino Del Regno
+ *                     <angelogioacchino.delregno@somainline.org>
+ * Copyright (C) 2020, Konrad Dybcio <konrad.dybcio@somainline.org>
+ * Copyright (c) 2023, Linaro Limited
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dt-bindings/interconnect/qcom,msm8998.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/interconnect-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "icc-rpm.h"
+
+static const char * const a1noc_intf_clocks[] = {
+	"aggre1_ufs_axi",
+	"ufs_axi",
+	"usb_axi",
+	"blsp2_ahb",
+};
+
+static const char * const a2noc_intf_clocks[] = {
+	"sdcc2_ahb",
+	"sdcc4_ahb",
+	"blsp1_ahb",
+	"ipa", /* mas_ipa */
+};
+
+static const char * const mnoc_intf_clocks[] = {
+	"iface",
+	"mnoc_bus",
+};
+
+static const char * const cnoc_snoc_intf_clocks[] = {
+	"iface",
+};
+
+enum {
+	MSM8998_MASTER_IPA,
+	MSM8998_MASTER_CNOC_A2NOC,
+	MSM8998_MASTER_SDCC_2,
+	MSM8998_MASTER_SDCC_4,
+	MSM8998_MASTER_BLSP_1,
+	MSM8998_MASTER_BLSP_2,
+	MSM8998_MASTER_UFS,
+	MSM8998_MASTER_USB_HS,
+	MSM8998_MASTER_USB3,
+	MSM8998_MASTER_CRYPTO_C0,
+	MSM8998_MASTER_GNOC_BIMC,
+	MSM8998_MASTER_OXILI,
+	MSM8998_MASTER_MNOC_BIMC,
+	MSM8998_MASTER_SNOC_BIMC,
+	MSM8998_MASTER_PIMEM,
+	MSM8998_MASTER_SNOC_CNOC,
+	MSM8998_MASTER_QDSS_DAP,
+	MSM8998_MASTER_APPS_PROC,
+	MSM8998_MASTER_CNOC_MNOC_MMSS_CFG,
+	MSM8998_MASTER_CNOC_MNOC_CFG,
+	MSM8998_MASTER_CPP,
+	MSM8998_MASTER_JPEG,
+	MSM8998_MASTER_MDP_P0,
+	MSM8998_MASTER_MDP_P1,
+	MSM8998_MASTER_VENUS,
+	MSM8998_MASTER_VFE,
+	MSM8998_MASTER_QDSS_ETR,
+	MSM8998_MASTER_QDSS_BAM,
+	MSM8998_MASTER_SNOC_CFG,
+	MSM8998_MASTER_BIMC_SNOC,
+	MSM8998_MASTER_A1NOC_SNOC,
+	MSM8998_MASTER_A2NOC_SNOC,
+	MSM8998_MASTER_GNOC_SNOC,
+	MSM8998_MASTER_PCIE_0,
+	MSM8998_MASTER_A2NOC_TSIF,
+	MSM8998_MASTER_CRVIRT_A2NOC,
+	MSM8998_MASTER_ROTATOR,
+	MSM8998_MASTER_VENUS_VMEM,
+	MSM8998_MASTER_HMSS,
+	MSM8998_MASTER_BIMC_SNOC_0,
+	MSM8998_MASTER_BIMC_SNOC_1,
+
+	MSM8998_SLAVE_A1NOC_SNOC,
+	MSM8998_SLAVE_A2NOC_SNOC,
+	MSM8998_SLAVE_EBI,
+	MSM8998_SLAVE_HMSS_L3,
+	MSM8998_SLAVE_CNOC_A2NOC,
+	MSM8998_SLAVE_MPM,
+	MSM8998_SLAVE_PMIC_ARB,
+	MSM8998_SLAVE_TLMM_NORTH,
+	MSM8998_SLAVE_TCSR,
+	MSM8998_SLAVE_PIMEM_CFG,
+	MSM8998_SLAVE_IMEM_CFG,
+	MSM8998_SLAVE_MESSAGE_RAM,
+	MSM8998_SLAVE_GLM,
+	MSM8998_SLAVE_BIMC_CFG,
+	MSM8998_SLAVE_PRNG,
+	MSM8998_SLAVE_SPDM,
+	MSM8998_SLAVE_QDSS_CFG,
+	MSM8998_SLAVE_CNOC_MNOC_CFG,
+	MSM8998_SLAVE_SNOC_CFG,
+	MSM8998_SLAVE_QM_CFG,
+	MSM8998_SLAVE_CLK_CTL,
+	MSM8998_SLAVE_MSS_CFG,
+	MSM8998_SLAVE_UFS_CFG,
+	MSM8998_SLAVE_A2NOC_CFG,
+	MSM8998_SLAVE_A2NOC_SMMU_CFG,
+	MSM8998_SLAVE_GPUSS_CFG,
+	MSM8998_SLAVE_AHB2PHY,
+	MSM8998_SLAVE_BLSP_1,
+	MSM8998_SLAVE_SDCC_2,
+	MSM8998_SLAVE_SDCC_4,
+	MSM8998_SLAVE_BLSP_2,
+	MSM8998_SLAVE_PDM,
+	MSM8998_SLAVE_CNOC_MNOC_MMSS_CFG,
+	MSM8998_SLAVE_USB_HS,
+	MSM8998_SLAVE_USB3_0,
+	MSM8998_SLAVE_SRVC_CNOC,
+	MSM8998_SLAVE_GNOC_BIMC,
+	MSM8998_SLAVE_GNOC_SNOC,
+	MSM8998_SLAVE_CAMERA_CFG,
+	MSM8998_SLAVE_CAMERA_THROTTLE_CFG,
+	MSM8998_SLAVE_MISC_CFG,
+	MSM8998_SLAVE_VENUS_THROTTLE_CFG,
+	MSM8998_SLAVE_VENUS_CFG,
+	MSM8998_SLAVE_MMSS_CLK_XPU_CFG,
+	MSM8998_SLAVE_MMSS_CLK_CFG,
+	MSM8998_SLAVE_MNOC_MPU_CFG,
+	MSM8998_SLAVE_DISPLAY_CFG,
+	MSM8998_SLAVE_CSI_PHY_CFG,
+	MSM8998_SLAVE_DISPLAY_THROTTLE_CFG,
+	MSM8998_SLAVE_SMMU_CFG,
+	MSM8998_SLAVE_MNOC_BIMC,
+	MSM8998_SLAVE_SRVC_MNOC,
+	MSM8998_SLAVE_HMSS,
+	MSM8998_SLAVE_LPASS,
+	MSM8998_SLAVE_WLAN,
+	MSM8998_SLAVE_CDSP,
+	MSM8998_SLAVE_IPA,
+	MSM8998_SLAVE_SNOC_BIMC,
+	MSM8998_SLAVE_SNOC_CNOC,
+	MSM8998_SLAVE_IMEM,
+	MSM8998_SLAVE_PIMEM,
+	MSM8998_SLAVE_QDSS_STM,
+	MSM8998_SLAVE_SRVC_SNOC,
+	MSM8998_SLAVE_BIMC_SNOC_0,
+	MSM8998_SLAVE_BIMC_SNOC_1,
+	MSM8998_SLAVE_SSC_CFG,
+	MSM8998_SLAVE_SKL,
+	MSM8998_SLAVE_TLMM_WEST,
+	MSM8998_SLAVE_A1NOC_CFG,
+	MSM8998_SLAVE_A1NOC_SMMU_CFG,
+	MSM8998_SLAVE_TSIF,
+	MSM8998_SLAVE_TLMM_EAST,
+	MSM8998_SLAVE_CRVIRT_A2NOC,
+	MSM8998_SLAVE_VMEM_CFG,
+	MSM8998_SLAVE_VMEM,
+	MSM8998_SLAVE_PCIE_0,
+};
+
+static const u16 master_pcie_0_links[] = {
+	MSM8998_SLAVE_A1NOC_SNOC,
+};
+
+static struct qcom_icc_node mas_pcie_0 = {
+	.name = "master_pcie_0",
+	.id = MSM8998_MASTER_PCIE_0,
+	.buswidth = 16,
+	.mas_rpm_id = 65,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 1,
+	.links = master_pcie_0_links,
+	.num_links = ARRAY_SIZE(master_pcie_0_links),
+};
+
+static const u16 master_usb3_links[] = {
+	MSM8998_SLAVE_A1NOC_SNOC,
+};
+
+static struct qcom_icc_node mas_usb3 = {
+	.name = "master_usb3",
+	.id = MSM8998_MASTER_USB3,
+	.buswidth = 16,
+	.mas_rpm_id = 32,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 2,
+	.links = master_usb3_links,
+	.num_links = ARRAY_SIZE(master_usb3_links),
+};
+
+static const u16 master_ufs_links[] = {
+	MSM8998_SLAVE_A1NOC_SNOC,
+};
+
+static struct qcom_icc_node mas_ufs = {
+	.name = "master_ufs",
+	.id = MSM8998_MASTER_UFS,
+	.buswidth = 16,
+	.mas_rpm_id = 68,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 0,
+	.links = master_ufs_links,
+	.num_links = ARRAY_SIZE(master_ufs_links),
+};
+
+static const u16 master_blsp_2_links[] = {
+	MSM8998_SLAVE_A1NOC_SNOC,
+};
+
+static struct qcom_icc_node mas_blsp_2 = {
+	.name = "master_blsp_2",
+	.id = MSM8998_MASTER_BLSP_2,
+	.buswidth = 16,
+	.mas_rpm_id = 39,
+	.slv_rpm_id = -1,
+	.links = master_blsp_2_links,
+	.num_links = ARRAY_SIZE(master_blsp_2_links),
+};
+
+static const u16 master_cnoc_a2noc_links[] = {
+	MSM8998_SLAVE_A2NOC_SNOC,
+};
+
+static struct qcom_icc_node mas_cnoc_a2noc = {
+	.name = "master_cnoc_a2noc",
+	.id = MSM8998_MASTER_CNOC_A2NOC,
+	.buswidth = 8,
+	.mas_rpm_id = 146,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = master_cnoc_a2noc_links,
+	.num_links = ARRAY_SIZE(master_cnoc_a2noc_links),
+};
+
+static const u16 master_ipa_links[] = {
+	MSM8998_SLAVE_A2NOC_SNOC,
+};
+
+static struct qcom_icc_node mas_ipa = {
+	.name = "master_ipa",
+	.id = MSM8998_MASTER_IPA,
+	.buswidth = 8,
+	.mas_rpm_id = 59,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 1,
+	.links = master_ipa_links,
+	.num_links = ARRAY_SIZE(master_ipa_links),
+};
+
+static const u16 master_sdcc_2_links[] = {
+	MSM8998_SLAVE_A2NOC_SNOC,
+};
+
+static struct qcom_icc_node mas_sdcc_2 = {
+	.name = "master_sdcc_2",
+	.id = MSM8998_MASTER_SDCC_2,
+	.buswidth = 8,
+	.mas_rpm_id = 35,
+	.slv_rpm_id = -1,
+	.links = master_sdcc_2_links,
+	.num_links = ARRAY_SIZE(master_sdcc_2_links),
+};
+
+static const u16 master_sdcc_4_links[] = {
+	MSM8998_SLAVE_A2NOC_SNOC,
+};
+
+static struct qcom_icc_node mas_sdcc_4 = {
+	.name = "master_sdcc_4",
+	.id = MSM8998_MASTER_SDCC_4,
+	.buswidth = 8,
+	.mas_rpm_id = 36,
+	.slv_rpm_id = -1,
+	.links = master_sdcc_4_links,
+	.num_links = ARRAY_SIZE(master_sdcc_4_links),
+};
+
+static const u16 master_a2noc_tsif_links[] = {
+	MSM8998_SLAVE_A2NOC_SNOC,
+};
+
+static struct qcom_icc_node mas_tsif = {
+	.name = "master_a2noc_tsif",
+	.id = MSM8998_MASTER_A2NOC_TSIF,
+	.buswidth = 4,
+	.mas_rpm_id = 37,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = master_a2noc_tsif_links,
+	.num_links = ARRAY_SIZE(master_a2noc_tsif_links),
+};
+
+static const u16 master_blsp_1_links[] = {
+	MSM8998_SLAVE_A2NOC_SNOC,
+};
+
+static struct qcom_icc_node mas_blsp_1 = {
+	.name = "master_blsp_1",
+	.id = MSM8998_MASTER_BLSP_1,
+	.buswidth = 16,
+	.mas_rpm_id = 41,
+	.slv_rpm_id = -1,
+	.links = master_blsp_1_links,
+	.num_links = ARRAY_SIZE(master_blsp_1_links),
+};
+
+static const u16 master_crvirt_a2noc_links[] = {
+	MSM8998_SLAVE_A2NOC_SNOC,
+};
+
+static struct qcom_icc_node mas_crvirt_a2noc = {
+	.name = "master_crvirt_a2noc",
+	.id = MSM8998_MASTER_CRVIRT_A2NOC,
+	.buswidth = 8,
+	.mas_rpm_id = 145,
+	.slv_rpm_id = -1,
+	.links = master_crvirt_a2noc_links,
+	.num_links = ARRAY_SIZE(master_crvirt_a2noc_links),
+};
+
+static const u16 master_gnoc_bimc_links[] = {
+	MSM8998_SLAVE_EBI,
+	MSM8998_SLAVE_BIMC_SNOC_0,
+};
+
+static struct qcom_icc_node mas_gnoc_bimc = {
+	.name = "master_gnoc_bimc",
+	.id = MSM8998_MASTER_GNOC_BIMC,
+	.channels = 2,
+	.buswidth = 8,
+	.mas_rpm_id = 144,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 0,
+	.links = master_gnoc_bimc_links,
+	.num_links = ARRAY_SIZE(master_gnoc_bimc_links),
+};
+
+static const u16 master_oxili_links[] = {
+	MSM8998_SLAVE_BIMC_SNOC_1,
+	MSM8998_SLAVE_HMSS_L3,
+	MSM8998_SLAVE_EBI,
+	MSM8998_SLAVE_BIMC_SNOC_0,
+};
+
+static struct qcom_icc_node mas_oxili = {
+	.name = "master_oxili",
+	.id = MSM8998_MASTER_OXILI,
+	.channels = 2,
+	.buswidth = 8,
+	.mas_rpm_id = 6,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 1,
+	.links = master_oxili_links,
+	.num_links = ARRAY_SIZE(master_oxili_links),
+};
+
+static const u16 master_mnoc_bimc_links[] = {
+	MSM8998_SLAVE_BIMC_SNOC_1,
+	MSM8998_SLAVE_HMSS_L3,
+	MSM8998_SLAVE_EBI,
+	MSM8998_SLAVE_BIMC_SNOC_0,
+};
+
+static struct qcom_icc_node mas_mnoc_bimc = {
+	.name = "master_mnoc_bimc",
+	.id = MSM8998_MASTER_MNOC_BIMC,
+	.channels = 2,
+	.buswidth = 8,
+	.mas_rpm_id = 2,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 2,
+	.links = master_mnoc_bimc_links,
+	.num_links = ARRAY_SIZE(master_mnoc_bimc_links),
+};
+
+static const u16 master_snoc_bimc_links[] = {
+	MSM8998_SLAVE_HMSS_L3,
+	MSM8998_SLAVE_EBI,
+};
+
+static struct qcom_icc_node mas_snoc_bimc = {
+	.name = "master_snoc_bimc",
+	.id = MSM8998_MASTER_SNOC_BIMC,
+	.channels = 2,
+	.buswidth = 8,
+	.mas_rpm_id = 3,
+	.slv_rpm_id = -1,
+	.links = master_snoc_bimc_links,
+	.num_links = ARRAY_SIZE(master_snoc_bimc_links),
+};
+
+static const u16 master_snoc_cnoc_links[] = {
+	MSM8998_SLAVE_SKL,
+	MSM8998_SLAVE_BLSP_2,
+	MSM8998_SLAVE_MESSAGE_RAM,
+	MSM8998_SLAVE_TLMM_WEST,
+	MSM8998_SLAVE_TSIF,
+	MSM8998_SLAVE_MPM,
+	MSM8998_SLAVE_BIMC_CFG,
+	MSM8998_SLAVE_TLMM_EAST,
+	MSM8998_SLAVE_SPDM,
+	MSM8998_SLAVE_PIMEM_CFG,
+	MSM8998_SLAVE_A1NOC_SMMU_CFG,
+	MSM8998_SLAVE_BLSP_1,
+	MSM8998_SLAVE_CLK_CTL,
+	MSM8998_SLAVE_PRNG,
+	MSM8998_SLAVE_USB3_0,
+	MSM8998_SLAVE_QDSS_CFG,
+	MSM8998_SLAVE_QM_CFG,
+	MSM8998_SLAVE_A2NOC_CFG,
+	MSM8998_SLAVE_PMIC_ARB,
+	MSM8998_SLAVE_UFS_CFG,
+	MSM8998_SLAVE_SRVC_CNOC,
+	MSM8998_SLAVE_AHB2PHY,
+	MSM8998_SLAVE_IPA,
+	MSM8998_SLAVE_GLM,
+	MSM8998_SLAVE_SNOC_CFG,
+	MSM8998_SLAVE_SSC_CFG,
+	MSM8998_SLAVE_SDCC_2,
+	MSM8998_SLAVE_SDCC_4,
+	MSM8998_SLAVE_PDM,
+	MSM8998_SLAVE_CNOC_MNOC_MMSS_CFG,
+	MSM8998_SLAVE_CNOC_MNOC_CFG,
+	MSM8998_SLAVE_MSS_CFG,
+	MSM8998_SLAVE_IMEM_CFG,
+	MSM8998_SLAVE_A1NOC_CFG,
+	MSM8998_SLAVE_GPUSS_CFG,
+	MSM8998_SLAVE_TCSR,
+	MSM8998_SLAVE_TLMM_NORTH,
+};
+
+static struct qcom_icc_node mas_snoc_cnoc = {
+	.name = "master_snoc_cnoc",
+	.id = MSM8998_MASTER_SNOC_CNOC,
+	.buswidth = 8,
+	.mas_rpm_id = 52,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = master_snoc_cnoc_links,
+	.num_links = ARRAY_SIZE(master_snoc_cnoc_links),
+};
+
+static const u16 master_qdss_dap_links[] = {
+	MSM8998_SLAVE_SKL,
+	MSM8998_SLAVE_BLSP_2,
+	MSM8998_SLAVE_MESSAGE_RAM,
+	MSM8998_SLAVE_TLMM_WEST,
+	MSM8998_SLAVE_TSIF,
+	MSM8998_SLAVE_MPM,
+	MSM8998_SLAVE_BIMC_CFG,
+	MSM8998_SLAVE_TLMM_EAST,
+	MSM8998_SLAVE_SPDM,
+	MSM8998_SLAVE_PIMEM_CFG,
+	MSM8998_SLAVE_A1NOC_SMMU_CFG,
+	MSM8998_SLAVE_BLSP_1,
+	MSM8998_SLAVE_CLK_CTL,
+	MSM8998_SLAVE_PRNG,
+	MSM8998_SLAVE_USB3_0,
+	MSM8998_SLAVE_QDSS_CFG,
+	MSM8998_SLAVE_QM_CFG,
+	MSM8998_SLAVE_A2NOC_CFG,
+	MSM8998_SLAVE_PMIC_ARB,
+	MSM8998_SLAVE_UFS_CFG,
+	MSM8998_SLAVE_SRVC_CNOC,
+	MSM8998_SLAVE_AHB2PHY,
+	MSM8998_SLAVE_IPA,
+	MSM8998_SLAVE_GLM,
+	MSM8998_SLAVE_SNOC_CFG,
+	MSM8998_SLAVE_SDCC_2,
+	MSM8998_SLAVE_SDCC_4,
+	MSM8998_SLAVE_PDM,
+	MSM8998_SLAVE_CNOC_MNOC_MMSS_CFG,
+	MSM8998_SLAVE_CNOC_MNOC_CFG,
+	MSM8998_SLAVE_MSS_CFG,
+	MSM8998_SLAVE_IMEM_CFG,
+	MSM8998_SLAVE_A1NOC_CFG,
+	MSM8998_SLAVE_GPUSS_CFG,
+	MSM8998_SLAVE_SSC_CFG,
+	MSM8998_SLAVE_TCSR,
+	MSM8998_SLAVE_TLMM_NORTH,
+	MSM8998_SLAVE_CNOC_A2NOC,
+};
+
+static struct qcom_icc_node mas_qdss_dap = {
+	.name = "master_qdss_dap",
+	.id = MSM8998_MASTER_QDSS_DAP,
+	.buswidth = 8,
+	.mas_rpm_id = 49,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = master_qdss_dap_links,
+	.num_links = ARRAY_SIZE(master_qdss_dap_links),
+};
+
+static const u16 master_crypto_c0_links[] = {
+	MSM8998_SLAVE_CRVIRT_A2NOC,
+};
+
+static struct qcom_icc_node mas_crypto = {
+	.name = "master_crypto_c0",
+	.id = MSM8998_MASTER_CRYPTO_C0,
+	.buswidth = 650,
+	.mas_rpm_id = 23,
+	.slv_rpm_id = -1,
+	.links = master_crypto_c0_links,
+	.num_links = ARRAY_SIZE(master_crypto_c0_links),
+};
+
+static const u16 master_apps_proc_links[] = {
+	MSM8998_SLAVE_GNOC_BIMC,
+};
+
+static struct qcom_icc_node mas_apss_proc = {
+	.name = "master_apps_proc",
+	.id = MSM8998_MASTER_APPS_PROC,
+	.buswidth = 32,
+	.mas_rpm_id = 0,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = master_apps_proc_links,
+	.num_links = ARRAY_SIZE(master_apps_proc_links),
+};
+
+static const u16 master_cnoc_mnoc_mmss_cfg_links[] = {
+	MSM8998_SLAVE_CAMERA_THROTTLE_CFG,
+	MSM8998_SLAVE_VENUS_CFG,
+	MSM8998_SLAVE_MISC_CFG,
+	MSM8998_SLAVE_CAMERA_CFG,
+	MSM8998_SLAVE_DISPLAY_THROTTLE_CFG,
+	MSM8998_SLAVE_VENUS_THROTTLE_CFG,
+	MSM8998_SLAVE_DISPLAY_CFG,
+	MSM8998_SLAVE_MMSS_CLK_CFG,
+	MSM8998_SLAVE_VMEM_CFG,
+	MSM8998_SLAVE_MMSS_CLK_XPU_CFG,
+	MSM8998_SLAVE_SMMU_CFG,
+};
+
+static struct qcom_icc_node mas_cnoc_mnoc_mmss_cfg = {
+	.name = "master_cnoc_mnoc_mmss_cfg",
+	.id = MSM8998_MASTER_CNOC_MNOC_MMSS_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = 4,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = master_cnoc_mnoc_mmss_cfg_links,
+	.num_links = ARRAY_SIZE(master_cnoc_mnoc_mmss_cfg_links),
+};
+
+static const u16 master_cnoc_mnoc_cfg_links[] = {
+	MSM8998_SLAVE_SRVC_MNOC,
+};
+
+static struct qcom_icc_node mas_cnoc_mnoc_cfg = {
+	.name = "master_cnoc_mnoc_cfg",
+	.id = MSM8998_MASTER_CNOC_MNOC_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = 5,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = master_cnoc_mnoc_cfg_links,
+	.num_links = ARRAY_SIZE(master_cnoc_mnoc_cfg_links),
+};
+
+static const u16 master_cpp_links[] = {
+	MSM8998_SLAVE_MNOC_BIMC,
+};
+
+static struct qcom_icc_node mas_cpp = {
+	.name = "master_cpp",
+	.id = MSM8998_MASTER_CPP,
+	.buswidth = 32,
+	.mas_rpm_id = 115,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 5,
+	.links = master_cpp_links,
+	.num_links = ARRAY_SIZE(master_cpp_links),
+};
+
+static const u16 master_jpeg_links[] = {
+	MSM8998_SLAVE_MNOC_BIMC,
+};
+
+static struct qcom_icc_node mas_jpeg = {
+	.name = "master_jpeg",
+	.id = MSM8998_MASTER_JPEG,
+	.buswidth = 32,
+	.mas_rpm_id = 7,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 7,
+	.links = master_jpeg_links,
+	.num_links = ARRAY_SIZE(master_jpeg_links),
+};
+
+static const u16 master_mdp_p0_links[] = {
+	MSM8998_SLAVE_MNOC_BIMC,
+};
+
+static struct qcom_icc_node mas_mdp_p0 = {
+	.name = "master_mdp_p0",
+	.id = MSM8998_MASTER_MDP_P0,
+	.buswidth = 32,
+	.mas_rpm_id = 8,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 1,
+	.links = master_mdp_p0_links,
+	.num_links = ARRAY_SIZE(master_mdp_p0_links),
+};
+
+static const u16 master_mdp_p1_links[] = {
+	MSM8998_SLAVE_MNOC_BIMC,
+};
+
+static struct qcom_icc_node mas_mdp_p1 = {
+	.name = "master_mdp_p1",
+	.id = MSM8998_MASTER_MDP_P1,
+	.buswidth = 32,
+	.mas_rpm_id = 61,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 2,
+	.links = master_mdp_p1_links,
+	.num_links = ARRAY_SIZE(master_mdp_p1_links),
+};
+
+static const u16 master_rotator_links[] = {
+	MSM8998_SLAVE_MNOC_BIMC,
+};
+
+static struct qcom_icc_node mas_rotator = {
+	.name = "master_rotator",
+	.id = MSM8998_MASTER_ROTATOR,
+	.buswidth = 32,
+	.mas_rpm_id = 120,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 0,
+	.links = master_rotator_links,
+	.num_links = ARRAY_SIZE(master_rotator_links),
+};
+
+static const u16 master_venus_links[] = {
+	MSM8998_SLAVE_MNOC_BIMC,
+};
+
+static struct qcom_icc_node mas_venus = {
+	.name = "master_venus",
+	.id = MSM8998_MASTER_VENUS,
+	.channels = 2,
+	.buswidth = 32,
+	.mas_rpm_id = 9,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 3,
+	.qos.aux_qos_port = 4,
+	.links = master_venus_links,
+	.num_links = ARRAY_SIZE(master_venus_links),
+};
+
+static const u16 master_vfe_links[] = {
+	MSM8998_SLAVE_MNOC_BIMC,
+};
+
+static struct qcom_icc_node mas_vfe = {
+	.name = "master_vfe",
+	.id = MSM8998_MASTER_VFE,
+	.buswidth = 32,
+	.mas_rpm_id = 11,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
+	.qos.areq_prio = 0,
+	.qos.prio_level = 0,
+	.qos.qos_port = 6,
+	.links = master_vfe_links,
+	.num_links = ARRAY_SIZE(master_vfe_links),
+};
+
+static const u16 master_venus_vmem_links[] = {
+	MSM8998_SLAVE_VMEM,
+};
+
+static struct qcom_icc_node mas_venus_vmem = {
+	.name = "master_venus_vmem",
+	.id = MSM8998_MASTER_VENUS_VMEM,
+	.buswidth = 32,
+	.mas_rpm_id = 121,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = master_venus_vmem_links,
+	.num_links = ARRAY_SIZE(master_venus_vmem_links),
+};
+
+static const u16 master_hmss_links[] = {
+	MSM8998_SLAVE_PIMEM,
+	MSM8998_SLAVE_IMEM,
+	MSM8998_SLAVE_SNOC_BIMC,
+};
+
+static struct qcom_icc_node mas_hmss = {
+	.name = "master_hmss",
+	.id = MSM8998_MASTER_HMSS,
+	.buswidth = 16,
+	.mas_rpm_id = 118,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 3,
+	.links = master_hmss_links,
+	.num_links = ARRAY_SIZE(master_hmss_links),
+};
+
+static const u16 master_qdss_bam_links[] = {
+	MSM8998_SLAVE_IMEM,
+	MSM8998_SLAVE_PIMEM,
+	MSM8998_SLAVE_SNOC_CNOC,
+	MSM8998_SLAVE_SNOC_BIMC,
+};
+
+static struct qcom_icc_node mas_qdss_bam = {
+	.name = "master_qdss_bam",
+	.id = MSM8998_MASTER_QDSS_BAM,
+	.buswidth = 16,
+	.mas_rpm_id = 19,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 1,
+	.links = master_qdss_bam_links,
+	.num_links = ARRAY_SIZE(master_qdss_bam_links),
+};
+
+static const u16 master_snoc_cfg_links[] = {
+	MSM8998_SLAVE_SRVC_SNOC,
+};
+
+static struct qcom_icc_node mas_snoc_cfg = {
+	.name = "master_snoc_cfg",
+	.id = MSM8998_MASTER_SNOC_CFG,
+	.buswidth = 16,
+	.mas_rpm_id = 20,
+	.slv_rpm_id = -1,
+	.links = master_snoc_cfg_links,
+	.num_links = ARRAY_SIZE(master_snoc_cfg_links),
+};
+
+static const u16 master_bimc_snoc_0_links[] = {
+	MSM8998_SLAVE_PIMEM,
+	MSM8998_SLAVE_LPASS,
+	MSM8998_SLAVE_HMSS,
+	MSM8998_SLAVE_WLAN,
+	MSM8998_SLAVE_SNOC_CNOC,
+	MSM8998_SLAVE_IMEM,
+	MSM8998_SLAVE_QDSS_STM,
+};
+
+static struct qcom_icc_node mas_bimc_snoc_0 = {
+	.name = "master_bimc_snoc_0",
+	.id = MSM8998_MASTER_BIMC_SNOC_0,
+	.buswidth = 16,
+	.mas_rpm_id = 21,
+	.slv_rpm_id = -1,
+	.links = master_bimc_snoc_0_links,
+	.num_links = ARRAY_SIZE(master_bimc_snoc_0_links),
+};
+
+static const u16 master_bimc_snoc_1_links[] = {
+	MSM8998_SLAVE_PCIE_0,
+};
+
+static struct qcom_icc_node mas_bimc_snoc_1 = {
+	.name = "master_bimc_snoc_1",
+	.id = MSM8998_MASTER_BIMC_SNOC_1,
+	.buswidth = 16,
+	.mas_rpm_id = 109,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = master_bimc_snoc_1_links,
+	.num_links = ARRAY_SIZE(master_bimc_snoc_1_links),
+};
+
+static const u16 master_a1noc_snoc_links[] = {
+	MSM8998_SLAVE_PIMEM,
+	MSM8998_SLAVE_PCIE_0,
+	MSM8998_SLAVE_LPASS,
+	MSM8998_SLAVE_HMSS,
+	MSM8998_SLAVE_SNOC_BIMC,
+	MSM8998_SLAVE_SNOC_CNOC,
+	MSM8998_SLAVE_IMEM,
+	MSM8998_SLAVE_QDSS_STM,
+};
+
+static struct qcom_icc_node mas_a1noc_snoc = {
+	.name = "master_a1noc_snoc",
+	.id = MSM8998_MASTER_A1NOC_SNOC,
+	.buswidth = 16,
+	.mas_rpm_id = 111,
+	.slv_rpm_id = -1,
+	.links = master_a1noc_snoc_links,
+	.num_links = ARRAY_SIZE(master_a1noc_snoc_links),
+};
+
+static const u16 master_a2noc_snoc_links[] = {
+	MSM8998_SLAVE_PIMEM,
+	MSM8998_SLAVE_PCIE_0,
+	MSM8998_SLAVE_LPASS,
+	MSM8998_SLAVE_HMSS,
+	MSM8998_SLAVE_SNOC_BIMC,
+	MSM8998_SLAVE_WLAN,
+	MSM8998_SLAVE_SNOC_CNOC,
+	MSM8998_SLAVE_IMEM,
+	MSM8998_SLAVE_QDSS_STM,
+};
+
+static struct qcom_icc_node mas_a2noc_snoc = {
+	.name = "master_a2noc_snoc",
+	.id = MSM8998_MASTER_A2NOC_SNOC,
+	.buswidth = 16,
+	.mas_rpm_id = 112,
+	.slv_rpm_id = -1,
+	.links = master_a2noc_snoc_links,
+	.num_links = ARRAY_SIZE(master_a2noc_snoc_links),
+};
+
+static const u16 master_qdss_etr_links[] = {
+	MSM8998_SLAVE_IMEM,
+	MSM8998_SLAVE_PIMEM,
+	MSM8998_SLAVE_SNOC_CNOC,
+	MSM8998_SLAVE_SNOC_BIMC,
+};
+
+static struct qcom_icc_node mas_qdss_etr = {
+	.name = "master_qdss_etr",
+	.id = MSM8998_MASTER_QDSS_ETR,
+	.buswidth = 16,
+	.mas_rpm_id = 31,
+	.slv_rpm_id = -1,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_FIXED,
+	.qos.areq_prio = 1,
+	.qos.prio_level = 1,
+	.qos.qos_port = 2,
+	.links = master_qdss_etr_links,
+	.num_links = ARRAY_SIZE(master_qdss_etr_links),
+};
+
+static const u16 slave_a1noc_snoc_links[] = {
+	MSM8998_MASTER_A1NOC_SNOC,
+};
+
+static struct qcom_icc_node slv_a1noc_snoc = {
+	.name = "slave_a1noc_snoc",
+	.id = MSM8998_SLAVE_A1NOC_SNOC,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 142,
+	.links = slave_a1noc_snoc_links,
+	.num_links = ARRAY_SIZE(slave_a1noc_snoc_links),
+};
+
+static const u16 slave_a2noc_snoc_links[] = {
+	MSM8998_MASTER_A2NOC_SNOC,
+};
+
+static struct qcom_icc_node slv_a2noc_snoc = {
+	.name = "slave_a2noc_snoc",
+	.id = MSM8998_SLAVE_A2NOC_SNOC,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 143,
+	.links = slave_a2noc_snoc_links,
+	.num_links = ARRAY_SIZE(slave_a2noc_snoc_links),
+};
+
+static struct qcom_icc_node slv_ebi = {
+	.name = "slave_ebi",
+	.id = MSM8998_SLAVE_EBI,
+	.channels = 2,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 0,
+};
+
+static struct qcom_icc_node slv_hmss_l3 = {
+	.name = "slave_hmss_l3",
+	.id = MSM8998_SLAVE_HMSS_L3,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 160,
+};
+
+static const u16 slave_bimc_snoc_0_links[] = {
+	MSM8998_MASTER_BIMC_SNOC_0,
+};
+
+static struct qcom_icc_node slv_bimc_snoc_0 = {
+	.name = "slave_bimc_snoc_0",
+	.id = MSM8998_SLAVE_BIMC_SNOC_0,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 2,
+	.links = slave_bimc_snoc_0_links,
+	.num_links = ARRAY_SIZE(slave_bimc_snoc_0_links),
+};
+
+static const u16 slave_bimc_snoc_1_links[] = {
+	MSM8998_MASTER_BIMC_SNOC_1,
+};
+
+static struct qcom_icc_node slv_bimc_snoc_1 = {
+	.name = "slave_bimc_snoc_1",
+	.id = MSM8998_SLAVE_BIMC_SNOC_1,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 138,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = slave_bimc_snoc_1_links,
+	.num_links = ARRAY_SIZE(slave_bimc_snoc_1_links),
+};
+
+static const u16 slave_cnoc_a2noc_links[] = {
+	MSM8998_MASTER_CNOC_A2NOC,
+};
+
+static struct qcom_icc_node slv_cnoc_a2noc = {
+	.name = "slave_cnoc_a2noc",
+	.id = MSM8998_SLAVE_CNOC_A2NOC,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 208,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = slave_cnoc_a2noc_links,
+	.num_links = ARRAY_SIZE(slave_cnoc_a2noc_links),
+};
+
+static struct qcom_icc_node slv_ssc_cfg = {
+	.name = "slave_ssc_cfg",
+	.id = MSM8998_SLAVE_SSC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 177,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_mpm = {
+	.name = "slave_mpm",
+	.id = MSM8998_SLAVE_MPM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 62,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_pmic_arb = {
+	.name = "slave_pmic_arb",
+	.id = MSM8998_SLAVE_PMIC_ARB,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 59,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_tlmm_north = {
+	.name = "slave_tlmm_north",
+	.id = MSM8998_SLAVE_TLMM_NORTH,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 214,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_pimem_cfg = {
+	.name = "slave_pimem_cfg",
+	.id = MSM8998_SLAVE_PIMEM_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 167,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_imem_cfg = {
+	.name = "slave_imem_cfg",
+	.id = MSM8998_SLAVE_IMEM_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 54,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_message_ram = {
+	.name = "slave_message_ram",
+	.id = MSM8998_SLAVE_MESSAGE_RAM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 55,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_skl = {
+	.name = "slave_skl",
+	.id = MSM8998_SLAVE_SKL,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 196,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_bimc_cfg = {
+	.name = "slave_bimc_cfg",
+	.id = MSM8998_SLAVE_BIMC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 56,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_prng = {
+	.name = "slave_prng",
+	.id = MSM8998_SLAVE_PRNG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 44,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_a2noc_cfg = {
+	.name = "slave_a2noc_cfg",
+	.id = MSM8998_SLAVE_A2NOC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 150,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_ipa = {
+	.name = "slave_ipa",
+	.id = MSM8998_SLAVE_IPA,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 183,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_tcsr = {
+	.name = "slave_tcsr",
+	.id = MSM8998_SLAVE_TCSR,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 50,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_snoc_cfg = {
+	.name = "slave_snoc_cfg",
+	.id = MSM8998_SLAVE_SNOC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 70,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_clk_ctl = {
+	.name = "slave_clk_ctl",
+	.id = MSM8998_SLAVE_CLK_CTL,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 47,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_glm = {
+	.name = "slave_glm",
+	.id = MSM8998_SLAVE_GLM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 209,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_spdm = {
+	.name = "slave_spdm",
+	.id = MSM8998_SLAVE_SPDM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 60,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_gpuss_cfg = {
+	.name = "slave_gpuss_cfg",
+	.id = MSM8998_SLAVE_GPUSS_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 11,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static const u16 slv_cnoc_mnoc_cfg_links[] = {
+	MSM8998_MASTER_CNOC_MNOC_CFG,
+};
+
+static struct qcom_icc_node slv_cnoc_mnoc_cfg = {
+	.name = "slv_cnoc_mnoc_cfg",
+	.id = MSM8998_SLAVE_CNOC_MNOC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 66,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = slv_cnoc_mnoc_cfg_links,
+	.num_links = ARRAY_SIZE(slv_cnoc_mnoc_cfg_links),
+};
+
+static struct qcom_icc_node slv_qm_cfg = {
+	.name = "slave_qm_cfg",
+	.id = MSM8998_SLAVE_QM_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 212,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_mss_cfg = {
+	.name = "slave_mss_cfg",
+	.id = MSM8998_SLAVE_MSS_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 48,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_ufs_cfg = {
+	.name = "slave_ufs_cfg",
+	.id = MSM8998_SLAVE_UFS_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 92,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_tlmm_west = {
+	.name = "slave_tlmm_west",
+	.id = MSM8998_SLAVE_TLMM_WEST,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 215,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_a1noc_cfg = {
+	.name = "slave_a1noc_cfg",
+	.id = MSM8998_SLAVE_A1NOC_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 147,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_ahb2phy = {
+	.name = "slave_ahb2phy",
+	.id = MSM8998_SLAVE_AHB2PHY,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 163,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_blsp_2 = {
+	.name = "slave_blsp_2",
+	.id = MSM8998_SLAVE_BLSP_2,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 37,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_pdm = {
+	.name = "slave_pdm",
+	.id = MSM8998_SLAVE_PDM,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 41,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_usb3_0 = {
+	.name = "slave_usb3_0",
+	.id = MSM8998_SLAVE_USB3_0,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 22,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_a1noc_smmu_cfg = {
+	.name = "slave_a1noc_smmu_cfg",
+	.id = MSM8998_SLAVE_A1NOC_SMMU_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 149,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_blsp_1 = {
+	.name = "slave_blsp_1",
+	.id = MSM8998_SLAVE_BLSP_1,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 39,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_sdcc_2 = {
+	.name = "slave_sdcc_2",
+	.id = MSM8998_SLAVE_SDCC_2,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 33,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_sdcc_4 = {
+	.name = "slave_sdcc_4",
+	.id = MSM8998_SLAVE_SDCC_4,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 34,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_tsif = {
+	.name = "slave_tsif",
+	.id = MSM8998_SLAVE_TSIF,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 35,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_qdss_cfg = {
+	.name = "slave_qdss_cfg",
+	.id = MSM8998_SLAVE_QDSS_CFG,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 63,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_tlmm_east = {
+	.name = "slave_tlmm_east",
+	.id = MSM8998_SLAVE_TLMM_EAST,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 213,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static const u16 slave_cnoc_mnoc_mmss_cfg_links[] = {
+	MSM8998_MASTER_CNOC_MNOC_MMSS_CFG,
+};
+
+static struct qcom_icc_node slv_cnoc_mnoc_mmss_cfg = {
+	.name = "slave_cnoc_mnoc_mmss_cfg",
+	.id = MSM8998_SLAVE_CNOC_MNOC_MMSS_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 58,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = slave_cnoc_mnoc_mmss_cfg_links,
+	.num_links = ARRAY_SIZE(slave_cnoc_mnoc_mmss_cfg_links),
+};
+
+static struct qcom_icc_node slv_srvc_cnoc = {
+	.name = "slave_srvc_cnoc",
+	.id = MSM8998_SLAVE_SRVC_CNOC,
+	.buswidth = 4,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 76,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static const u16 slave_crvirt_a2noc_links[] = {
+	MSM8998_MASTER_CRVIRT_A2NOC,
+};
+
+static struct qcom_icc_node slv_crvirt_a2noc = {
+	.name = "slave_crvirt_a2noc",
+	.id = MSM8998_SLAVE_CRVIRT_A2NOC,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 207,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = slave_crvirt_a2noc_links,
+	.num_links = ARRAY_SIZE(slave_crvirt_a2noc_links),
+};
+
+static const u16 slave_gnoc_bimc_links[] = {
+	MSM8998_MASTER_GNOC_BIMC,
+};
+
+static struct qcom_icc_node slv_gnoc_bimc = {
+	.name = "slave_gnoc_bimc",
+	.id = MSM8998_SLAVE_GNOC_BIMC,
+	.buswidth = 32,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 210,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = slave_gnoc_bimc_links,
+	.num_links = ARRAY_SIZE(slave_gnoc_bimc_links),
+};
+
+static struct qcom_icc_node slv_camera_cfg = {
+	.name = "slave_camera_cfg",
+	.id = MSM8998_SLAVE_CAMERA_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 3,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_camera_throttle_cfg = {
+	.name = "slave_camera_throttle_cfg",
+	.id = MSM8998_SLAVE_CAMERA_THROTTLE_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 154,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_misc_cfg = {
+	.name = "slave_misc_cfg",
+	.id = MSM8998_SLAVE_MISC_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 8,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_venus_throttle_cfg = {
+	.name = "slave_venus_throttle_cfg",
+	.id = MSM8998_SLAVE_VENUS_THROTTLE_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 178,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_venus_cfg = {
+	.name = "slave_venus_cfg",
+	.id = MSM8998_SLAVE_VENUS_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 10,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_vmem_cfg = {
+	.name = "slave_vmem_cfg",
+	.id = MSM8998_SLAVE_VMEM_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 180,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_mmss_clk_xpu_cfg = {
+	.name = "slave_mmss_clk_xpu_cfg",
+	.id = MSM8998_SLAVE_MMSS_CLK_XPU_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 13,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_mmss_clk_cfg = {
+	.name = "slave_mmss_clk_cfg",
+	.id = MSM8998_SLAVE_MMSS_CLK_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 12,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_display_cfg = {
+	.name = "slave_display_cfg",
+	.id = MSM8998_SLAVE_DISPLAY_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 4,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_display_throttle_cfg = {
+	.name = "slave_display_throttle_cfg",
+	.id = MSM8998_SLAVE_DISPLAY_THROTTLE_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 156,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_smmu_cfg = {
+	.name = "slave_smmu_cfg",
+	.id = MSM8998_SLAVE_SMMU_CFG,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 205,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static const u16 slave_mnoc_bimc_links[] = {
+	MSM8998_MASTER_MNOC_BIMC,
+};
+
+static struct qcom_icc_node slv_mnoc_bimc = {
+	.name = "slave_mnoc_bimc",
+	.id = MSM8998_SLAVE_MNOC_BIMC,
+	.channels = 2,
+	.buswidth = 32,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 16,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+	.links = slave_mnoc_bimc_links,
+	.num_links = ARRAY_SIZE(slave_mnoc_bimc_links),
+};
+
+static struct qcom_icc_node slv_vmem = {
+	.name = "slave_vmem",
+	.id = MSM8998_SLAVE_VMEM,
+	.buswidth = 32,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 179,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_srvc_mnoc = {
+	.name = "slave_srvc_mnoc",
+	.id = MSM8998_SLAVE_SRVC_MNOC,
+	.buswidth = 8,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 17,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_hmss = {
+	.name = "slave_hmss",
+	.id = MSM8998_SLAVE_HMSS,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 20,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_lpass = {
+	.name = "slave_lpass",
+	.id = MSM8998_SLAVE_LPASS,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 21,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_wlan = {
+	.name = "slave_wlan",
+	.id = MSM8998_SLAVE_WLAN,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 206,
+};
+
+static const u16 slave_snoc_bimc_links[] = {
+	MSM8998_MASTER_SNOC_BIMC,
+};
+
+static struct qcom_icc_node slv_snoc_bimc = {
+	.name = "slave_snoc_bimc",
+	.id = MSM8998_SLAVE_SNOC_BIMC,
+	.channels = 2,
+	.buswidth = 32,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 24,
+	.links = slave_snoc_bimc_links,
+	.num_links = ARRAY_SIZE(slave_snoc_bimc_links),
+};
+
+static const u16 slave_snoc_cnoc_links[] = {
+	MSM8998_MASTER_SNOC_CNOC,
+};
+
+static struct qcom_icc_node slv_snoc_cnoc = {
+	.name = "slave_snoc_cnoc",
+	.id = MSM8998_SLAVE_SNOC_CNOC,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 25,
+	.links = slave_snoc_cnoc_links,
+	.num_links = ARRAY_SIZE(slave_snoc_cnoc_links),
+};
+
+static struct qcom_icc_node slv_imem = {
+	.name = "slave_imem",
+	.id = MSM8998_SLAVE_IMEM,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 26,
+};
+
+static struct qcom_icc_node slv_pimem = {
+	.name = "slave_pimem",
+	.id = MSM8998_SLAVE_PIMEM,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 166,
+};
+
+static struct qcom_icc_node slv_qdss_stm = {
+	.name = "slave_qdss_stm",
+	.id = MSM8998_SLAVE_QDSS_STM,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 30,
+};
+
+static struct qcom_icc_node slv_pcie_0 = {
+	.name = "slave_pcie_0",
+	.id = MSM8998_SLAVE_PCIE_0,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 84,
+	.qos.ap_owned = true,
+	.qos.qos_mode = NOC_QOS_MODE_INVALID,
+};
+
+static struct qcom_icc_node slv_srvc_snoc = {
+	.name = "slave_srvc_snoc",
+	.id = MSM8998_SLAVE_SRVC_SNOC,
+	.buswidth = 16,
+	.mas_rpm_id = -1,
+	.slv_rpm_id = 29,
+};
+
+static struct qcom_icc_node *msm8998_a1noc_nodes[] = {
+	[MASTER_PCIE_0] = &mas_pcie_0,
+	[MASTER_USB3] = &mas_usb3,
+	[MASTER_UFS] = &mas_ufs,
+	[MASTER_BLSP_2] = &mas_blsp_2,
+	[SLAVE_A1NOC_SNOC] = &slv_a1noc_snoc,
+};
+
+static const struct regmap_config msm8998_a1noc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	/* 0x60000 downstream, but that would clash with SMMUs! */
+	.max_register	= 0x20000,
+	.fast_io	= true,
+};
+
+static struct qcom_icc_desc msm8998_a1noc = {
+	.type = QCOM_ICC_NOC,
+	.nodes = msm8998_a1noc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8998_a1noc_nodes),
+	.regmap_cfg = &msm8998_a1noc_regmap_config,
+	.bus_clk_desc = &aggre1_clk,
+	.intf_clocks = a1noc_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(a1noc_intf_clocks),
+	.qos_offset = 0x9000,
+};
+
+static struct qcom_icc_node *msm8998_a2noc_nodes[] = {
+	[MASTER_IPA] = &mas_ipa,
+	[MASTER_CNOC_A2NOC] = &mas_cnoc_a2noc,
+	[MASTER_SDCC_2] = &mas_sdcc_2,
+	[MASTER_SDCC_4] = &mas_sdcc_4,
+	[MASTER_TSIF] = &mas_tsif,
+	[MASTER_BLSP_1] = &mas_blsp_1,
+	[MASTER_CRVIRT_A2NOC] = &mas_crvirt_a2noc,
+	[MASTER_CRYPTO_C0] = &mas_crypto,
+	[SLAVE_A2NOC_SNOC] = &slv_a2noc_snoc,
+	[SLAVE_CRVIRT_A2NOC] = &slv_crvirt_a2noc,
+};
+
+static const struct regmap_config msm8998_a2noc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	/* 0x60000 downstream, but that would clash with MNoC! */
+	.max_register	= 0x40000,
+	.fast_io	= true,
+};
+
+static struct qcom_icc_desc msm8998_a2noc = {
+	.type = QCOM_ICC_NOC,
+	.nodes = msm8998_a2noc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8998_a2noc_nodes),
+	.regmap_cfg = &msm8998_a2noc_regmap_config,
+	.bus_clk_desc = &aggre2_clk,
+	.intf_clocks = a2noc_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
+	.qos_offset = 0x5000,
+};
+
+static struct qcom_icc_node *msm8998_bimc_nodes[] = {
+	[MASTER_GNOC_BIMC] = &mas_gnoc_bimc,
+	[MASTER_OXILI] = &mas_oxili,
+	[MASTER_MNOC_BIMC] = &mas_mnoc_bimc,
+	[MASTER_SNOC_BIMC] = &mas_snoc_bimc,
+	[SLAVE_EBI] = &slv_ebi,
+	[SLAVE_HMSS_L3] = &slv_hmss_l3,
+	[SLAVE_BIMC_SNOC_0] = &slv_bimc_snoc_0,
+	[SLAVE_BIMC_SNOC_1] = &slv_bimc_snoc_1,
+};
+
+static const struct regmap_config msm8998_bimc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x80000,
+	.fast_io	= true,
+};
+
+static struct qcom_icc_desc msm8998_bimc = {
+	.type = QCOM_ICC_BIMC,
+	.nodes = msm8998_bimc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8998_bimc_nodes),
+	.regmap_cfg = &msm8998_bimc_regmap_config,
+	/*
+	 * QoS offset is -0x300 (instead of 0x800 as one would expect) in this
+	 * case, as MSM8998 includes a peculiar design decision, where
+	 * what-would-be BIMC_BASE is really occupied by BWMON and then the
+	 * "useful" BWMON regs end right where BIMC_QoS begins.. But the driver
+	 * assumes we reserve BIMC_BASE and that the QPORT 0's register is at
+	 * (BIMC_BASE + QoS_OFFSET + 0x300), but that's what we unfortunately
+	 * have to treat as our BIMC_BASE in DT..
+	 */
+	.bus_clk_desc = &bimc_clk,
+	.qos_offset = -0x300,
+};
+
+static struct qcom_icc_node *msm8998_cnoc_nodes[] = {
+	[MASTER_SNOC_CNOC] = &mas_snoc_cnoc,
+	[MASTER_QDSS_DAP] = &mas_qdss_dap,
+	[SLAVE_CNOC_A2NOC] = &slv_cnoc_a2noc,
+	[SLAVE_SSC_CFG] = &slv_ssc_cfg,
+	[SLAVE_MPM] = &slv_mpm,
+	[SLAVE_PMIC_ARB] = &slv_pmic_arb,
+	[SLAVE_TLMM_NORTH] = &slv_tlmm_north,
+	[SLAVE_PIMEM_CFG] = &slv_pimem_cfg,
+	[SLAVE_IMEM_CFG] = &slv_imem_cfg,
+	[SLAVE_MESSAGE_RAM] = &slv_message_ram,
+	[SLAVE_SKL] = &slv_skl,
+	[SLAVE_BIMC_CFG] = &slv_bimc_cfg,
+	[SLAVE_PRNG] = &slv_prng,
+	[SLAVE_A2NOC_CFG] = &slv_a2noc_cfg,
+	[SLAVE_IPA] = &slv_ipa,
+	[SLAVE_TCSR] = &slv_tcsr,
+	[SLAVE_SNOC_CFG] = &slv_snoc_cfg,
+	[SLAVE_CLK_CTL] = &slv_clk_ctl,
+	[SLAVE_GLM] = &slv_glm,
+	[SLAVE_SPDM] = &slv_spdm,
+	[SLAVE_GPUSS_CFG] = &slv_gpuss_cfg,
+	[SLAVE_CNOC_MNOC_CFG] = &slv_cnoc_mnoc_cfg,
+	[SLAVE_QM_CFG] = &slv_qm_cfg,
+	[SLAVE_MSS_CFG] = &slv_mss_cfg,
+	[SLAVE_UFS_CFG] = &slv_ufs_cfg,
+	[SLAVE_TLMM_WEST] = &slv_tlmm_west,
+	[SLAVE_A1NOC_CFG] = &slv_a1noc_cfg,
+	[SLAVE_AHB2PHY] = &slv_ahb2phy,
+	[SLAVE_BLSP_2] = &slv_blsp_2,
+	[SLAVE_PDM] = &slv_pdm,
+	[SLAVE_USB3_0] = &slv_usb3_0,
+	[SLAVE_A1NOC_SMMU_CFG] = &slv_a1noc_smmu_cfg,
+	[SLAVE_BLSP_1] = &slv_blsp_1,
+	[SLAVE_SDCC_2] = &slv_sdcc_2,
+	[SLAVE_SDCC_4] = &slv_sdcc_4,
+	[SLAVE_TSIF] = &slv_tsif,
+	[SLAVE_QDSS_CFG] = &slv_qdss_cfg,
+	[SLAVE_TLMM_EAST] = &slv_tlmm_east,
+	[SLAVE_CNOC_MNOC_MMSS_CFG] = &slv_cnoc_mnoc_mmss_cfg,
+	[SLAVE_SRVC_CNOC] = &slv_srvc_cnoc,
+};
+
+static const struct regmap_config msm8998_cnoc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x10000,
+	.fast_io	= true,
+};
+
+static struct qcom_icc_desc msm8998_cnoc = {
+	.type = QCOM_ICC_NOC,
+	.nodes = msm8998_cnoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8998_cnoc_nodes),
+	.regmap_cfg = &msm8998_cnoc_regmap_config,
+	.bus_clk_desc = &bus_2_clk,
+	.intf_clocks = cnoc_snoc_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(cnoc_snoc_intf_clocks),
+	.keep_alive = true,
+};
+
+static struct qcom_icc_node *msm8998_gnoc_nodes[] = {
+	[MASTER_APSS_PROC] = &mas_apss_proc,
+	[SLAVE_GNOC_BIMC] = &slv_gnoc_bimc,
+};
+
+static const struct regmap_config msm8998_gnoc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x10000,
+	.fast_io	= true,
+};
+
+static struct qcom_icc_desc msm8998_gnoc = {
+	.type = QCOM_ICC_NOC,
+	.nodes = msm8998_gnoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8998_gnoc_nodes),
+	.regmap_cfg = &msm8998_gnoc_regmap_config,
+};
+
+static struct qcom_icc_node *msm8998_mnoc_nodes[] = {
+	[MASTER_CNOC_MNOC_CFG] = &mas_cnoc_mnoc_cfg,
+	[MASTER_CPP] = &mas_cpp,
+	[MASTER_JPEG] = &mas_jpeg,
+	[MASTER_MDP_P0] = &mas_mdp_p0,
+	[MASTER_MDP_P1] = &mas_mdp_p1,
+	[MASTER_ROTATOR] = &mas_rotator,
+	[MASTER_VENUS] = &mas_venus,
+	[MASTER_VFE] = &mas_vfe,
+	[MASTER_VENUS_VMEM] = &mas_venus_vmem,
+	[SLAVE_MNOC_BIMC] = &slv_mnoc_bimc,
+	[SLAVE_VMEM] = &slv_vmem,
+	[SLAVE_SRVC_MNOC] = &slv_srvc_mnoc,
+};
+
+static const struct regmap_config msm8998_mnoc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x10000,
+	.fast_io	= true,
+};
+
+static struct qcom_icc_desc msm8998_mnoc = {
+	.type = QCOM_ICC_NOC,
+	.nodes = msm8998_mnoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8998_mnoc_nodes),
+	.regmap_cfg = &msm8998_mnoc_regmap_config,
+	.bus_clk_desc = &mmaxi_0_clk,
+	.intf_clocks = mnoc_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(mnoc_intf_clocks),
+	.qos_offset = 0x4000,
+};
+
+static struct qcom_icc_node *msm8998_mnoc_ahb_nodes[] = {
+	[MASTER_CNOC_MNOC_MMSS_CFG] = &mas_cnoc_mnoc_mmss_cfg,
+	[SLAVE_CAMERA_CFG] = &slv_camera_cfg,
+	[SLAVE_CAMERA_THROTTLE_CFG] = &slv_camera_throttle_cfg,
+	[SLAVE_MISC_CFG] = &slv_misc_cfg,
+	[SLAVE_VENUS_THROTTLE_CFG] = &slv_venus_throttle_cfg,
+	[SLAVE_VENUS_CFG] = &slv_venus_cfg,
+	[SLAVE_VMEM_CFG] = &slv_vmem_cfg,
+	[SLAVE_MMSS_CLK_XPU_CFG] = &slv_mmss_clk_xpu_cfg,
+	[SLAVE_MMSS_CLK_CFG] = &slv_mmss_clk_cfg,
+	[SLAVE_DISPLAY_CFG] = &slv_display_cfg,
+	[SLAVE_DISPLAY_THROTTLE_CFG] = &slv_display_throttle_cfg,
+	[SLAVE_SMMU_CFG] = &slv_smmu_cfg,
+};
+
+static struct qcom_icc_desc msm8998_mnoc_ahb = {
+	.type = QCOM_ICC_NOC,
+	.nodes = msm8998_mnoc_ahb_nodes,
+	.num_nodes = ARRAY_SIZE(msm8998_mnoc_ahb_nodes),
+	.regmap_cfg = &msm8998_mnoc_regmap_config,
+};
+
+static struct qcom_icc_node *msm8998_snoc_nodes[] = {
+	[MASTER_HMSS] = &mas_hmss,
+	[MASTER_QDSS_BAM] = &mas_qdss_bam,
+	[MASTER_SNOC_CFG] = &mas_snoc_cfg,
+	[MASTER_BIMC_SNOC_0] = &mas_bimc_snoc_0,
+	[MASTER_BIMC_SNOC_1] = &mas_bimc_snoc_1,
+	[MASTER_A1NOC_SNOC] = &mas_a1noc_snoc,
+	[MASTER_A2NOC_SNOC] = &mas_a2noc_snoc,
+	[MASTER_QDSS_ETR] = &mas_qdss_etr,
+	[SLAVE_HMSS] = &slv_hmss,
+	[SLAVE_LPASS] = &slv_lpass,
+	[SLAVE_WLAN] = &slv_wlan,
+	[SLAVE_SNOC_BIMC] = &slv_snoc_bimc,
+	[SLAVE_SNOC_CNOC] = &slv_snoc_cnoc,
+	[SLAVE_IMEM] = &slv_imem,
+	[SLAVE_PIMEM] = &slv_pimem,
+	[SLAVE_QDSS_STM] = &slv_qdss_stm,
+	[SLAVE_PCIE_0] = &slv_pcie_0,
+	[SLAVE_SRVC_SNOC] = &slv_srvc_snoc,
+};
+
+static const struct regmap_config msm8998_snoc_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x40000,
+	.fast_io	= true,
+};
+
+static struct qcom_icc_desc msm8998_snoc = {
+	.type = QCOM_ICC_NOC,
+	.nodes = msm8998_snoc_nodes,
+	.num_nodes = ARRAY_SIZE(msm8998_snoc_nodes),
+	.regmap_cfg = &msm8998_snoc_regmap_config,
+	.bus_clk_desc = &bus_1_clk,
+	.intf_clocks = cnoc_snoc_intf_clocks,
+	.num_intf_clocks = ARRAY_SIZE(cnoc_snoc_intf_clocks),
+	.qos_offset = 0x5000,
+};
+
+static const struct of_device_id qnoc_of_match[] = {
+	{ .compatible = "qcom,msm8998-a1noc", .data = &msm8998_a1noc },
+	{ .compatible = "qcom,msm8998-a2noc", .data = &msm8998_a2noc },
+	{ .compatible = "qcom,msm8998-bimc", .data = &msm8998_bimc },
+	{ .compatible = "qcom,msm8998-cnoc", .data = &msm8998_cnoc },
+	{ .compatible = "qcom,msm8998-mnoc", .data = &msm8998_mnoc },
+	{ .compatible = "qcom,msm8998-mnoc-ahb", .data = &msm8998_mnoc_ahb },
+	{ .compatible = "qcom,msm8998-gnoc", .data = &msm8998_gnoc },
+	{ .compatible = "qcom,msm8998-snoc", .data = &msm8998_snoc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qnoc_of_match);
+
+static struct platform_driver qnoc_driver = {
+	.probe = qnoc_probe,
+	.remove = qnoc_remove,
+	.driver = {
+		.name = "qnoc-msm8998",
+		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
+	},
+};
+static int __init qnoc_driver_init(void)
+{
+	return platform_driver_register(&qnoc_driver);
+}
+core_initcall(qnoc_driver_init);
+
+static void __exit qnoc_driver_exit(void)
+{
+	platform_driver_unregister(&qnoc_driver);
+}
+module_exit(qnoc_driver_exit);
+
+MODULE_DESCRIPTION("MSM8998 NoC driver");
+MODULE_LICENSE("GPL");

-- 
2.47.3

