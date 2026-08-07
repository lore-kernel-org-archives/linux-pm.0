Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F34034E766
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103412; cv=none; b=DIduJuxe657s3ONjjseWLewnsSrZ2+shD3wEg4PPsP3+lEeQmAMBYh2sBukeajsma1rb64k+BHxumCUSNgLuKazzQINuUEZOgkDgyGYnGg6SYtdn5kFVm3SeQ3jwQLOKNU5soD9ngCP9NQ47sJB8Iw0hu31anHRmsbyST1bHmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103412; c=relaxed/simple;
	bh=4CmrAYKHp1Lj7cyPBcomvd8gdC7FB3hmUzd+wvp1kzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBtEWracAa9wvxleDtmegFaNVLeX+pe6CVrlG9OfipnzeE/2WR0Jvuifv+LvzlLidVPu3+hrRJGQFMK1TQchRNXJ08osI6LAZFApHA5vQ2xn51NPkvpuaIfC00hBE0LHgv1JJKt7SVlb1iRL1Gab/cRFLcjesS8fra02jWstiOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jVZ4GwYV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CLZk0TD0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVZ4GwYV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CLZk0TD0"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6779WVkp565314
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 11:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zwZSf2cdgc9vmRwcU4CDp3Ze8ejsg5Z5vyAf9z1BAQc=; b=jVZ4GwYVhbzXfgl4
	26v/MJp3/Z1PyP01c7tRSAFsog4mZBPD2g1oSSQd3JiSeLYxdxiDEV855CfaA4ZQ
	ApoBKRWyQrEXNeeZ3UAqTZ07sWC/E/1ElYdvf1seyzKOuaPAY59oVNbkxO6exCCc
	o5mrNkNzyvsSEilqqo7FEgQOlovNxzq3p6HqUuvLg8gNQTGbk5ya+Qw9ci8oO468
	bvAdrXWyRhlFekq8QRJbMFDddx1eVzth88UZo2JYMa5q4aR8gye5mUzgHVlQ/VhR
	QREH3QHi2Nu/i/KIPSHUZODydMHeJ6vzyN7oE8pKEuUp3YOZ8qXUfN9zLxSEOnG5
	oExNeQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwctp8ewn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 11:50:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c20762d21so38801661cf.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786103402; x=1786708202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zwZSf2cdgc9vmRwcU4CDp3Ze8ejsg5Z5vyAf9z1BAQc=;
        b=CLZk0TD0hOTB776LpgYcQs5DDeoDK1W4Ump+QwfrwxWkTFloFJMJ3xVQDSVbznSYNY
         Lj4azroC435VldMPhGp7Mhxva9IpgY9aEZMhjZD2OenculTCFhnH0RlQNy+vyCJ8l1VG
         JNYMvCf2KU28f77z4NkxBQmIqAsbSl2T/WTQ3AtjoI331HinvBw1bcmpt2oOBoUbv1kK
         doYH2ARJ9gen4FLpqSRTooddvvNmo+pzNGfQuJTo7x2GHVIKIDyKXwIYp2E370TeeEc8
         3WAL49zSv5zWx66bODlBSx3qmpS3vlYq5JHwswNERBb8clfs0n9TxlhwziiMScJAZE7M
         WHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786103402; x=1786708202;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zwZSf2cdgc9vmRwcU4CDp3Ze8ejsg5Z5vyAf9z1BAQc=;
        b=oy3Bk31LgBfm27Y8RTS5TVPtyK5qfDai6IqT8MIDngiOOsS8aUfRxtt83EeE9anZUA
         uq9sUwvNgD9ckVI6Y+HjZTL0CEQ/yzQquoqOnEecuDsKtplofw8W2HC6OKjcRYsrplg8
         6FMW+I9uir/9Vhp06NlGuXQvt9wNn49YFCHtYBA+SHdhJvkv4bzxEBRivCPdRIwBPil6
         w8FqcGbVLNs02Hxq+lYywriS1jOxc6xyzyql9oJmsVCXh8rPHhG0dLNu+/sq10lCReP5
         /kiR/l4qidh4PoVyb30QaOpQCtUtQFePAN+Y+lA/uqvWkKUVWZnlPfYb/bdKMAXYDk/m
         eN1Q==
X-Forwarded-Encrypted: i=1; AHgh+RoXF05xmECRyFTP/Ld5LIhpjne0zjhyXot+sr1ucRljKL6nToxUueJYfA7UwHoATijAH+FSFdVhYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmFmAxMIZOBHSbAJPmmYrnzLpFNYaStQJzhHfTnF6fS6jJjyX9
	MtD575RewCif7/0nT5HsxkNkqgjCcSE1EY9SyhjgdfE1GtXGNLId5XVZ5CdvltR81UFgJ3BOkoh
	4cdA9jk84qGzhkOpCD3IHIr88IDjkhZGabI4LAD8nFEPZ2B0BJVppITk+mjlBVA==
X-Gm-Gg: AR+sD11jeyoMUDJVKrSLWIIDB70C9bJzP2sdKAj9gsJx554pamwEGTALyrL3jwTy3zq
	wCa+dm7Tk3H5qdswSbMhfgSpJKSkeHhiaC/RY8l/FXJ0l81YRJ17dtFPlJIqVBeAIMEMwhLt4s0
	O5gyIERPnjFP9rgwOcfC3wudw+8850+g1RgiKT3GhKbV3heK2lD7kjWVskVyP0Y8KSkqm71lKJq
	17QQ6e6vd3/6dlwF67Nnpb9HkiUpsXHOiqG8qhKqbtQDV8ErdZoyZ8aOTOnoAiPP+hKt4oocdyk
	EjyM6p05qstFFJ5EriIlvIPceGTE8+Yumuvj5oSdfMyYL15aG4jYCOKQdobmY1GUmno3v20mNE2
	5f0xH/wT4EVX4vGOteqIVUFMZ
X-Received: by 2002:a05:622a:5796:b0:51c:849e:e222 with SMTP id d75a77b69052e-52d1919d9f5mr23253931cf.36.1786103401442;
        Fri, 07 Aug 2026 04:50:01 -0700 (PDT)
X-Received: by 2002:a05:622a:5796:b0:51c:849e:e222 with SMTP id d75a77b69052e-52d1919d9f5mr23253151cf.36.1786103400918;
        Fri, 07 Aug 2026 04:50:00 -0700 (PDT)
Received: from lin-0772.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080c9047esm43046266b.33.2026.08.07.04.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 04:50:00 -0700 (PDT)
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
To: djakov@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, krzysztof.kozlowski@oss.qualcomm.com,
        odelu.kukatla@oss.qualcomm.com, raviteja.laggyshetty@oss.qualcomm.com,
        vivek.aknurwar@oss.qualcomm.com, quic_afilipov@quicinc.com,
        loic.poulain@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, atanas.filipov@oss.qualcomm.com
Subject: [PATCH v1 2/3] interconnect: qcom: Add CAMNOC interconnect provider driver
Date: Fri,  7 Aug 2026 14:49:50 +0300
Message-Id: <20260807114951.4164439-3-atanas.filipov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807114951.4164439-1-atanas.filipov@oss.qualcomm.com>
References: <20260807114951.4164439-1-atanas.filipov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Fp01OWrq c=1 sm=1 tr=0 ts=6a75c66a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=muAYhjqZ-AtuC14g7DYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: F63JjBEP8nJgu5pVoQvaeHHaSnMD8x50
X-Proofpoint-ORIG-GUID: F63JjBEP8nJgu5pVoQvaeHHaSnMD8x50
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5MSBTYWx0ZWRfX2RhA3LOR8i4x
 veHAXNwvdd4mdz/ytnhLwx1B5/UyUYCrqX+Ka7XjVBLQplGmfIFclq/+yv1CGjNDxK35upufaAZ
 HKCXPtiUi450WrRYo2fl7BDA3Xv/kqWKcYoSfCaoktj4nr1DLb/pqY8wD5xlTnphCoRTEfM2Df6
 SMwB+LngTdX/u9fUZnHRn8VEgvvEpFPos3OwbFtk2bznWiHmD9PV02kwLdOf/khB471IJy8PB8o
 zkWVA+PM77VDeRw32xs2kJw2kNpxVyg4xxDRBQBuGkXbKRK8GJabBoeUT3/WNsUodKiFOIPdiQF
 0ZCYc3GpvNZMgtEXG3DD/pfvw+vIaEImWrN6sfbHFCScA0QpqeJLEC9P+IN15BmPpTwbX+jUZ9Z
 vY1dOwRZvFnRWHVLpeiRLQBp4HW8q0esWzpw32GrhkPTLtTEPHSOcAhqTOQwAkmQho7/N8ZvXqe
 wtoz2EPvLoqtK5gpguA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5MSBTYWx0ZWRfX4xunAWnfXNy1
 li9N/bokOBeMuoPdHar8DqvNucgPJ+OTIw6vM6GdLmDVuFFexh/SWOsRcfDSG3KO1wfEKZJUCsZ
 cwQiuA7CjeyunVsdN/99M/JcFOcqUSQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070091

The Camera Network-on-Chip (CAMNOC) is the internal AXI interconnect
within the camera subsystem. Multiple camera sub-devices share the
CAMNOC AXI clock. When each sub-device calls clk_set_rate() directly
on this shared clock, a last-writer-wins race condition arises: the
final caller sets the rate regardless of what other active consumers
require.

Introduce a lightweight ICC provider for CAMNOC that solves this by
leveraging the ICC aggregation framework. Each consumer obtains an
ICC path to SLAVE_CAMNOC_AXI and votes for bandwidth via icc_set_bw().
The ICC core aggregates all votes (max of peak_bw across consumers)
and the provider's set() callback translates the result into a single
clk_set_rate() call on the CAMNOC AXI clock.

Consumers encode the required clock frequency directly as peak_bw in
kBps (e.g. 400000 for 400 MHz). The conversion is:
  rate_hz = peak_bw_kBps * 1000

Implement get_bw() returning 0 for both avg and peak to prevent the
ICC core from defaulting to INT_MAX before any consumer has voted.

Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig       |  10 ++
 drivers/interconnect/qcom/Makefile      |   2 +
 drivers/interconnect/qcom/qcom-camnoc.c | 184 ++++++++++++++++++++++++
 3 files changed, 196 insertions(+)
 create mode 100644 drivers/interconnect/qcom/qcom-camnoc.c

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 5b8a094ca4ed..9d9d238019a0 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -135,6 +135,16 @@ config INTERCONNECT_QCOM_NORD
 	  the RPMh hardware and communicates via Bus Clock Manager (BCM)
 	  through the Resource State Coordinator (RSC).
 
+config INTERCONNECT_QCOM_CAMNOC
+	tristate "Qualcomm CAMNOC interconnect driver"
+	depends on INTERCONNECT_QCOM || COMPILE_TEST
+	depends on ARM64 || COMPILE_TEST
+	help
+	  Say y here to support the Camera Network-on-Chip (CAMNOC)
+	  interconnect driver for Qualcomm SoCs. It aggregates bandwidth
+	  requests from camera sub-devices (IFE, JPEG, BPS, etc.) and
+	  scales CAM_CC_CAMNOC_AXI_CLK accordingly.
+
 config INTERCONNECT_QCOM_OSM_L3
 	tristate "Qualcomm OSM L3 interconnect driver"
 	depends on INTERCONNECT_QCOM || COMPILE_TEST
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index 1c7d410b40cc..52a5998ae6a8 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -18,6 +18,7 @@ qnoc-msm8974-objs			:= msm8974.o
 qnoc-msm8976-objs			:= msm8976.o
 qnoc-msm8996-objs			:= msm8996.o
 qnoc-nord-objs				:= nord.o
+icc-camnoc-objs				:= qcom-camnoc.o
 icc-osm-l3-objs				:= osm-l3.o
 qnoc-qcm2290-objs			:= qcm2290.o
 qnoc-qcs404-objs			:= qcs404.o
@@ -66,6 +67,7 @@ obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8976) += qnoc-msm8976.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8996) += qnoc-msm8996.o
 obj-$(CONFIG_INTERCONNECT_QCOM_NORD) += qnoc-nord.o
+obj-$(CONFIG_INTERCONNECT_QCOM_CAMNOC) += icc-camnoc.o
 obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) += icc-osm-l3.o
 obj-$(CONFIG_INTERCONNECT_QCOM_QCM2290) += qnoc-qcm2290.o
 obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
diff --git a/drivers/interconnect/qcom/qcom-camnoc.c b/drivers/interconnect/qcom/qcom-camnoc.c
new file mode 100644
index 000000000000..a5a484491515
--- /dev/null
+++ b/drivers/interconnect/qcom/qcom-camnoc.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Qualcomm Camera NOC (CAMNOC) interconnect provider.
+ *
+ * CAMNOC is the internal AXI interconnect within the Qualcomm camera
+ * subsystem. Multiple camera sub-devices (IFE, JPEG, BPS, etc.) share
+ * CAM_CC_CAMNOC_AXI_CLK. This driver acts as an ICC provider so that
+ * each sub-device can independently vote for bandwidth; the ICC core
+ * aggregates the votes (max of peak_bw across all consumers) and this
+ * driver translates the result into a clk_set_rate() call, avoiding
+ * the last-writer-wins race that occurs with direct clk_set_rate().
+ *
+ * Consumers express their required clock rate directly as peak_bw in
+ * kBps (e.g. 400000 for 400 MHz).  The driver converts kBps → Hz:
+ *   rate_hz = peak_bw_kBps * 1000
+ */
+
+#include <linux/clk.h>
+#include <linux/interconnect-provider.h>
+#include <linux/interconnect.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/interconnect/qcom,camnoc.h>
+
+#define to_camnoc_provider(_p) \
+	container_of(_p, struct qcom_camnoc_icc_provider, provider)
+
+struct qcom_camnoc_icc_provider {
+	struct clk *clk;
+	struct icc_provider provider;
+};
+
+struct qcom_camnoc_node {
+	const char *name;
+	u16 buswidth;
+};
+
+static const struct qcom_camnoc_node camnoc_master_jpeg = {
+	.name = "master-camnoc-jpeg",
+	.buswidth = 16,
+};
+
+static const struct qcom_camnoc_node camnoc_slave_axi = {
+	.name = "slave-camnoc-axi",
+	.buswidth = 16,
+};
+
+static const struct qcom_camnoc_node * const camnoc_nodes[] = {
+	[MASTER_CAMNOC_JPEG] = &camnoc_master_jpeg,
+	[SLAVE_CAMNOC_AXI]   = &camnoc_slave_axi,
+};
+
+#define CAMNOC_NUM_NODES	ARRAY_SIZE(camnoc_nodes)
+
+static int qcom_camnoc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	*avg = 0;
+	*peak = 0;
+
+	return 0;
+}
+
+static int qcom_camnoc_set(struct icc_node *src, struct icc_node *dst)
+{
+	struct qcom_camnoc_icc_provider *cp =
+		to_camnoc_provider(src->provider);
+	unsigned long rate;
+
+	/*
+	 * peak_bw is the aggregated max across all consumers (kBps).
+	 * Consumers encode the required clock frequency directly as kBps,
+	 * so the conversion is simply: rate_hz = peak_bw * 1000.
+	 * A vote of 0 means no requirement; leave the clock at its minimum.
+	 */
+	rate = icc_units_to_bps(dst->peak_bw);
+
+	dev_dbg(src->provider->dev,
+		"CAMNOC set: aggregated peak_bw=%u kBps -> rate=%lu Hz\n",
+		dst->peak_bw, rate);
+
+	return clk_set_rate(cp->clk, rate);
+}
+
+static void qcom_camnoc_remove(struct platform_device *pdev)
+{
+	struct qcom_camnoc_icc_provider *cp = platform_get_drvdata(pdev);
+
+	icc_provider_deregister(&cp->provider);
+	icc_nodes_remove(&cp->provider);
+}
+
+static int qcom_camnoc_probe(struct platform_device *pdev)
+{
+	struct qcom_camnoc_icc_provider *cp;
+	struct icc_onecell_data *data;
+	struct icc_provider *provider;
+	struct icc_node *node;
+	unsigned int i;
+	int ret;
+
+	cp = devm_kzalloc(&pdev->dev, sizeof(*cp), GFP_KERNEL);
+	if (!cp)
+		return -ENOMEM;
+
+	cp->clk = devm_clk_get(&pdev->dev, "camnoc_axi");
+	if (IS_ERR(cp->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(cp->clk),
+				     "failed to get camnoc_axi clock\n");
+
+	data = devm_kzalloc(&pdev->dev,
+			    struct_size(data, nodes, CAMNOC_NUM_NODES),
+			    GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->num_nodes = CAMNOC_NUM_NODES;
+
+	provider = &cp->provider;
+	provider->dev = &pdev->dev;
+	provider->get_bw = qcom_camnoc_get_bw;
+	provider->set = qcom_camnoc_set;
+	provider->aggregate = icc_std_aggregate;
+	provider->xlate = of_icc_xlate_onecell;
+	provider->data = data;
+
+	icc_provider_init(provider);
+
+	for (i = 0; i < CAMNOC_NUM_NODES; i++) {
+		node = icc_node_create_dyn();
+		if (IS_ERR(node)) {
+			ret = PTR_ERR(node);
+			goto err_remove;
+		}
+
+		ret = icc_node_set_name(node, provider, camnoc_nodes[i]->name);
+		if (ret) {
+			icc_node_destroy(node->id);
+			goto err_remove;
+		}
+
+		node->data = (void *)camnoc_nodes[i];
+		icc_node_add(node, provider);
+		data->nodes[i] = node;
+	}
+
+	icc_link_nodes(data->nodes[MASTER_CAMNOC_JPEG],
+		       &data->nodes[SLAVE_CAMNOC_AXI]);
+
+	ret = icc_provider_register(provider);
+	if (ret)
+		goto err_remove;
+
+	platform_set_drvdata(pdev, cp);
+
+	return 0;
+
+err_remove:
+	icc_nodes_remove(provider);
+	return ret;
+}
+
+static const struct of_device_id qcom_camnoc_of_match[] = {
+	{ .compatible = "qcom,sm8250-cam-virt" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qcom_camnoc_of_match);
+
+static struct platform_driver qcom_camnoc_driver = {
+	.probe  = qcom_camnoc_probe,
+	.remove = qcom_camnoc_remove,
+	.driver = {
+		.name           = "qcom-camnoc-icc",
+		.of_match_table = qcom_camnoc_of_match,
+		.sync_state     = icc_sync_state,
+	},
+};
+module_platform_driver(qcom_camnoc_driver);
+
+MODULE_DESCRIPTION("Qualcomm CAMNOC interconnect driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

