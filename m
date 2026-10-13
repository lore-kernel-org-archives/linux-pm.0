Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD32347ACFB
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791875412; cv=none; b=TQ/CYnmHGvEV32QX1Mqoc3sJx7jnUGzr2wsJnqNRYXYQBsXGeG04x5l52uATScM72d6iDd45driPvy+maP19wMjoIAkyr+Kp18Oa1A9QAWZp43820guxJOi9fPCcaiPFX+Mlgiz36Eu8t26ah5riEO199A7aP5S0VbgD104Chm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791875412; c=relaxed/simple;
	bh=GT4nQWfAHHvUyvID0wXUdxYaJ9PYrHZUrmHJ+kW7nDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yg+ksxkUYAJg81sp9cVyir5MLsawSFs56d1hwDf569iUt2uxDoUvY4yahwssrf4UKFHZRgvoxvdBSKj3s3fSdBVMx0arn422EmHdMAKfA2gFEZQuHMS0MmHYbAkDjUBvehs6Y182HzE4Jxq1Pko+cNleRVKUnJC/2NbVB8EIh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o2B4vkQ9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hBqbk8+O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o2B4vkQ9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hBqbk8+O"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D6CRaW949369
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 07:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4ZfDSPkxZWxiCfJTiYTWUgSm+iAf7ms4spkP7C4FtQY=; b=o2B4vkQ9dgvGAZ62
	hx5SBfB96tWb8IInoRfzOsGLvgnpE9fZl4ovzPvVKiDQgCfxTLTs04FMk3TR3vHg
	V9W3IIOjyhG0gmg/Cy427W2tbCAeRskl3vq/YOEmtpAW/8EmZRNMyiguCgfJyr8E
	OB2Xq8aMppvR+h6Q7MwfntiusqDiT8ZwyP5OFr8w0WoqM/wLOcLvqjpOmUvecaxu
	0iqHpxWDXoOUTdqaM8h/AYDfmfM9DIQbBr/NmVJiMZ8HLLlQm1+oecLwFoNGhs18
	Y59VdQnc4bnoi9FO3vHEz8eXOegy2vbzBdfLVvGW30mrGni31MsEP8j4L+pBOn2x
	iW6ECA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9f62877f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 07:10:08 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3510d0baf63so7853190eec.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 00:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791875408; x=1792480208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ZfDSPkxZWxiCfJTiYTWUgSm+iAf7ms4spkP7C4FtQY=;
        b=hBqbk8+OIJGfSaMAILIDoCJX6P8sLdlLZb5PSnBzFNg94Rc+HVWlJMb0tKAH9q7nGL
         thPDqgXzl0SLYU4HQtpB6SuDoc9BK1yEw/uXJDtHFaYZdFsmAbNvEdp4MzFqs7RdPzw/
         b0JTQ91V+zQTPMLvRWe+q2Q+iTmyxwM1tQt2D+9fa8PMya/F5nsXmZwluMm9kvjPlbzK
         WAbuMUZpel5d9ee+5EjhBgePWTqRpRczbwc0ELUgaILamJw6HQiKZkb9XMg/Sid5OROo
         9WXjtXGbB/LczLTqniU1Cdlb1xuXqMnEEMhk3J3i8tK0n7OQ6A7PyvJWmuhgUenl0LxQ
         s44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791875408; x=1792480208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ZfDSPkxZWxiCfJTiYTWUgSm+iAf7ms4spkP7C4FtQY=;
        b=e6jcRH6Y0zMTRQD7i6NI1FUtaHoDH3+Wn6AjD+wDVBrOmHprshigbLqE189lW9VL6q
         GaH0V2too4zbtGh9pMn9HM6+CGxplq+DqSnxocE4k3TUEtUMG1MOqqYPEtFGIDcDZX+T
         KypBcLXZp4SVanU+AqrKsU8coVvV0YGLrq/QoDcRiMOhatYbxVbDJJqjZCxt+S9gl14l
         +d+Mb0u0p3dQTkpluuh5Fzm1wIU1asmoCcx0+DO+QGBfNxUNOb2vEcigJiAo2L5YBQzr
         Rnu6N9SHWQtJt1khrcIwxfyQ6oY66wyMv/UesYlBtXBM4R4sqygQ7ONA5VsbpT112XGB
         WHkA==
X-Forwarded-Encrypted: i=1; AKwUvBwVNo6bJVn6k6VStVEas1k1OpRDm8uQKseSwXgvVp7kctWj7FFXeNZSv9R97VBMgxFNC98ur6rs6w==@vger.kernel.org
X-Gm-Message-State: AFq9FYL1ffSn6OMYmxLXL+EWlWnPvgjY+WC/fjbtx07anG3lXS+vEhwK
	YLubwmSl2jGPdWzF/xGGBjWtnv4AHU4BJow6+8wWeIoTtCApX5DuFgYah+kcAj4QkkNeIqTbefY
	d6VLmYBdxjBr8rBb3NQfw+mMtqVBlqKteLcN9a9aq0wbcx3+tDHbKDK1/mSntPg==
X-Gm-Gg: AYBFou0r74f74BAL3MWMih0+Pz+rYaUWsp/a4k0rIkXN8v4nZiACZZWxDlkw6CAvdpZ
	5/OSxtDS6o9WkUnHfc2vbywAw4nI7wBEo242ZFuWnY38+dxDSrEPmv07bHsjZnRBFihWGyIfwx3
	Og1uHiK3gncztnARKtkPwtR74QW5SLCZ/6H4lZfu0P+FlJBAYAzTxf690WNCahwjUF9AD9k79IO
	qUjNlBSr2lvEhZulOLdFwnmHDgISMBiXja4ncXtQzcXficOJIgaoB3lkMd42YNLyN/UmY6ePcvs
	piaAuWGr1FpIIF4L/qtpuR5rdxtNl9MpivfIwK7CgZi6PE4kB/oU3V6r1Rm+WKRt8bdw8Qn+3ca
	H3FtuZ9DH4S/ed6abTAi0Ylh8OZ7xxuIlvTH88OPSht1NrMDxEovKYCkVXHeHYzKC709cnKmpAF
	1QyYkvdhUSfsI/7gzQEYASuS/J03iD8A==
X-Received: by 2002:a05:7300:c00c:10b0:35a:22a4:12a with SMTP id 5a478bee46e88-35a22a420demr8884457eec.18.1791875407354;
        Tue, 13 Oct 2026 00:10:07 -0700 (PDT)
X-Received: by 2002:a05:7300:c00c:10b0:35a:22a4:12a with SMTP id 5a478bee46e88-35a22a420demr8884412eec.18.1791875406757;
        Tue, 13 Oct 2026 00:10:06 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cab27d5sm46081248eec.17.2026.10.13.00.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 00:10:06 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:39:44 +0530
Subject: [PATCH v2 2/3] clk: qcom: ipq5210: Use icc-clk for enabling NoC
 related clocks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-icc-v2-2-196b219e25c1@oss.qualcomm.com>
References: <20261013-icc-v2-0-196b219e25c1@oss.qualcomm.com>
In-Reply-To: <20261013-icc-v2-0-196b219e25c1@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=FOKOVOos c=1 sm=1 tr=0 ts=6acdd950 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=2vMkRBvVivtXAe3DWLoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyOCBTYWx0ZWRfX8+KhHRULwytg
 WT61hNKEUi2zBZn5eLc1Nl1c5GvBJYgEhxuvVbyY0+NBo19v/CALKbPxaHb/rVRTc1fgxwhWcVA
 IY3x2NBNY2im8WOiBy8uCIsuuveq5Zc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyOCBTYWx0ZWRfX2h1qAnDssQgO
 XqoRToHbVtSXIjnb4NC+RrWhWh7Eozz4JESTGbS6t3R7BT2q8HdebwT0xlJH6tJqx5GMKQ/3bI6
 iYAOFKnkCpJ7FNoqofbkszb2WUr3BVNBGxsXZWKQA+8Nyx3nlCbESqVLU6PmHV5NZhFxd0Cl5TQ
 Ck2kaWvMe+KLZmhqXBD4J5aawpkKyelgRQsVWn9XvZkmLqEnTiQAv3aE53JUoIuCbJRjYoUxQ1x
 DzcvRj+FvrneCHwdvxGaGR++Hs1JQJx1I6/kcI6YrxaO/eHQv9V+WQzNbD4jgKkF8tbft5XdIFY
 TRp5lgXB53PTK+EUKr4BoEzYpiZiWQ3ofD5wFGv0HT94cY8iirfQG9vFu1f0XiDAX8wtGEmLpBf
 At9+kaiGwvHhYhJ4NOoZ7ZUL0oRr+/76/er2t4DvMHqsrMZaAHnxxrW0+NP76vOW+6Zwa/1+MQX
 a6EVl7iMbsHBJfyGSqg==
X-Proofpoint-GUID: 5gVDMYifEOpM1e7j-L5eNH5hZDlLiWxq
X-Proofpoint-ORIG-GUID: 5gVDMYifEOpM1e7j-L5eNH5hZDlLiWxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130028

Use the icc-clk framework to enable few clocks to be able to
create paths and use the peripherals connected on those NoCs.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/clk/qcom/gcc-ipq5210.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq5210.c b/drivers/clk/qcom/gcc-ipq5210.c
index 76adfa8bf2ad..b6d93a5a7691 100644
--- a/drivers/clk/qcom/gcc-ipq5210.c
+++ b/drivers/clk/qcom/gcc-ipq5210.c
@@ -4,11 +4,13 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/interconnect-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,ipq5210-gcc.h>
+#include <dt-bindings/interconnect/qcom,ipq5210.h>
 #include <dt-bindings/reset/qcom,ipq5210-gcc.h>
 
 #include "clk-alpha-pll.h"
@@ -2603,6 +2605,16 @@ static const struct qcom_reset_map gcc_ipq5210_resets[] = {
 	[GCC_QDSS_BCR] = { 0x2d000 },
 };
 
+#define IPQ_APPS_ID			5210	/* some unique value */
+
+static const struct qcom_icc_hws_data icc_ipq5210_hws[] = {
+	{ MASTER_CNOC_PCIE0, SLAVE_CNOC_PCIE0, GCC_CNOC_PCIE0_1LANE_S_CLK },
+	{ MASTER_CNOC_PCIE1, SLAVE_CNOC_PCIE1, GCC_CNOC_PCIE1_2LANE_S_CLK },
+	{ MASTER_SNOC_PCIE0, SLAVE_SNOC_PCIE0, GCC_SNOC_PCIE0_AXI_M_CLK },
+	{ MASTER_SNOC_PCIE1, SLAVE_SNOC_PCIE1, GCC_SNOC_PCIE1_AXI_M_CLK },
+	{ MASTER_USB, SLAVE_USB, GCC_CNOC_USB_CLK },
+};
+
 static const struct of_device_id gcc_ipq5210_match_table[] = {
 	{ .compatible = "qcom,ipq5210-gcc" },
 	{ }
@@ -2631,6 +2643,9 @@ static const struct qcom_cc_desc gcc_ipq5210_desc = {
 	.num_resets = ARRAY_SIZE(gcc_ipq5210_resets),
 	.clk_hws = gcc_ipq5210_hws,
 	.num_clk_hws = ARRAY_SIZE(gcc_ipq5210_hws),
+	.icc_hws = icc_ipq5210_hws,
+	.num_icc_hws = ARRAY_SIZE(icc_ipq5210_hws),
+	.icc_first_node_id = IPQ_APPS_ID,
 };
 
 static int gcc_ipq5210_probe(struct platform_device *pdev)
@@ -2643,6 +2658,7 @@ static struct platform_driver gcc_ipq5210_driver = {
 	.driver = {
 		.name   = "qcom,gcc-ipq5210",
 		.of_match_table = gcc_ipq5210_match_table,
+		.sync_state = icc_sync_state,
 	},
 };
 

-- 
2.34.1

