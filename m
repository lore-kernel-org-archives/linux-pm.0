Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE22D5505FC
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170444; cv=none; b=lIIqN7EbOgkNERfmPDXbB8rIK3AMm9UifSMZXlQebPqGCjeps9elvlFdwqitW17UTN67901EmMPIe+XLVrBpjWDG7z3xGfeIB6c7PCTDSFPDVN617v7wZ6JzEK5NPxgNfVwAlMQLwZY9V0kUegjtCDCgMg4DLo6IRr+YJ/LTYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170444; c=relaxed/simple;
	bh=NI+HOKofBp35ZZB5kRjgj6Bca1ZC0PGe481UGKIIlVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mkuxuTvnqJr+/yDajql2ahTSVlOCdpDrTcNGjpgH5s0uENlMuYszbKy3yL+uRh22EBH1k70nMAd1TMUSVkiQzpdXrj+J/8LUZnZbkqOjY8LAY/JIxDge+tKYwv+ImzwEiMgip7MzS/X1x/l0BanAigGvWq7yxIUBxkm9GHVukKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E130aczE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IFVUOXcA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E130aczE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IFVUOXcA"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GE5rMd3577687
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 17:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tf0laCkIY+O
	8Uz++9XKKGPxDxkLjNK9ABuSo7fWpIWA=; b=E130aczEcEfMAlpoL5m1AnQR+aI
	hd9cGmWvovpUhiYm8KPVe/svCtwW37nrFbHx3M4cTFpLGrhV7PknWjvgGWDGSKlU
	7mNbL/pgGv6NeImjpxXznog2xvjEmcQypndJvqGkb8yKBPgj/oQ5Ob7aP2OVg504
	TGAtYen8rKaD0gzYWvY1uykDCwPoMG3PUIVFEBas5tO6jmCi7PhlcUCEONqw/d4H
	lyugpYrosvHUVadsc8Rw1dOGyOeibvErIaCMGvMFnCpaU0njjim2AldiCksCWrZs
	M25vCFN69xKgyjHBluzorb4NG7zimsdpsARkXGvTJUo5ZmarChjNl5dZmMQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hba263cxe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 17:07:19 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5d600e3ee5eso132946e0c.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792170439; x=1792775239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tf0laCkIY+O8Uz++9XKKGPxDxkLjNK9ABuSo7fWpIWA=;
        b=IFVUOXcA1MWfy2CP59zAiIRWGV+yVdtmYw8tmQv0jtQJ9dtub+4cNhLF51Jc9rGUl4
         XXJykMMZva+QgzhSILeUHZQdId9Z0MDCAdAoPbGZWLcuY6yJ3xb74e/teccCy4RQwMhd
         SB/7wBWMfK92sTNMH8P5bGR82xcuR8xHaVsz3S5iUDuIs0kmvdv94mVfmWEK3cDlIM00
         dD5r0pDGl2hr+IS0yIC583brOw/4t6BBYZhwN6IwrCYywsX6IQP2iECCkHKnFnjZw3lg
         +QlSCbUfOqmJ/8dN19Wlb5JYrx1bbjncQcgCq7F0Qs2nx58scEKOgSnyOg1vyaE9G/mR
         jJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170439; x=1792775239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tf0laCkIY+O8Uz++9XKKGPxDxkLjNK9ABuSo7fWpIWA=;
        b=vNGDNdq5vvvSQaWlqfC/vnOed0aR7pQkcmbVrZosVwoj0b86vtIEY9gjiHbZ+k23oB
         oEXR5glgaVqsHXzCD7td87WXwv2tmXINfdxrfLtrb82+2bOpi4ifg0abOUAvNVmVR7FN
         vAwyBjRKzfMUzIIfEoegxDEjB774dbCjwftXVlKoFONKO2xPC+Mebb6zihI4jT1nyJyO
         2YNMdIaRqxdjY2YDyvyvYC1rUnL7sci2vx0jArlWVkAd/k0uMOuDSOQ6GHIDdFdN6jP5
         MTj/f5TwKUK9HufZ31HSTuuM2kIn4+fvGnxXZjc1ImYK8EpiGGDA4bBURAyeCzFh5jvL
         a2+Q==
X-Forwarded-Encrypted: i=1; AKwUvByFEB/dJbweJZFdcJc9uaoqjbkIx6+6Xi51GAoTOSbiJk3FJ+A/BaHAxCJiB9bAq/W8jp+HWo7DAw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJDZFJM1GzCdIqrufuKQl2IFHyc8SHVQcn6oihkatnu2B4LJhvn
	76K42kV6yI6FrJIqcZU7+TamTVA/+uiWeOyZUz635WATOMxh8vVm1ISo0R7cVF0OZRWITeW6uLV
	SKQZdPhO6QENtTe5FB65+xbAIFcAg6KyR9H1QudVj7Bv8EYi/zfI8YRa3/5/1IQ==
X-Gm-Gg: AYBFou1a0u9qakeNmGIWExOaw402bJdiogYRUc4HkojV0yEmF84T1KmBfXaMOcPFvLX
	KTr1PvgHxcHGbM48dfsx/Y952+ELQb5ZbM+M32g0aLiI1iXgM8cP9khnsPW55XxnzplJiPVaA3k
	BmfZJWgwMXlSZ00ElCJphhFhdElGQ6bi2ou2uNvOHOETduZj+xKbxnGM9YqdBFLNR9kHWTpD8A5
	03ovy2eNA7rIbAvX/gpHQgqRTHyKeC+lF01I3VQQ+E6krFAXpm0bobnzx3hxnZuzK6GXGlEXmSv
	Oieiy2uTfARqy5K7+0/YA7u/Ob/4PFjOHGIePQPn/DZtGBbxBwntzIMLfVW4Agbr6qi6QOja5sc
	tZs22lT9O116iNoof3jY7wzz7
X-Received: by 2002:a05:6122:32d4:b0:5e9:176f:a548 with SMTP id 71dfb90a1353d-5eaa9eb7e68mr392980e0c.0.1792170438850;
        Fri, 16 Oct 2026 10:07:18 -0700 (PDT)
X-Received: by 2002:a05:6122:32d4:b0:5e9:176f:a548 with SMTP id 71dfb90a1353d-5eaa9eb7e68mr392952e0c.0.1792170438403;
        Fri, 16 Oct 2026 10:07:18 -0700 (PDT)
Received: from lin-0772.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f5b2dsm6630571f8f.31.2026.10.16.10.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:07:15 -0700 (PDT)
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, atanas.filipov@oss.qualcomm.com
Subject: [PATCH v3 2/3] clk: qcom: camcc-sm8250: use icc-clk for camera NoC AXI clock
Date: Fri, 16 Oct 2026 20:07:00 +0300
Message-Id: <20261016170701.1504338-3-atanas.filipov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bsHZl0ai c=1 sm=1 tr=0 ts=6ad259c7 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=cu8AwxT6VGdwWvmfZG8A:9 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2OCBTYWx0ZWRfX7WFxmX20KLOI
 HKkCdj8Rd71mUltU58dBGrECybFbpex7wZ14j5J+JZ3mRniYG3GGuzLh5ickqmUKjOkI/kXcZ5c
 0D3NroVTOiON1a8nM/tQOuDG3YbS4jywhRi2YxYAkOddZPIcKopSePqOGnnH69ydrm4hR7PhkoW
 rVlMJUG/h4wLp6QnhuetAAPe5yJ7WZ7o/TtkNyXYzOGq5fg+uyO54xTRoMD8A5JjrZKDvb40EzE
 OW9je15GRShvY4y8OUd1iIpOTuuDaDcwED3ZhH30vifngKjailx+bZhWD/ppIuBY6mdAGKqayhE
 Eo6l/isFYEQstE7KX/zEty7rFwZe67KnmHHwLbUBfM3V7eZA+thGzzXu3bSrmpmmEn5BaIHoggT
 6Tor+r7nG55wrSkmp0/LNY1RisXNwaV1jyz4hAjQIOylQP4RE/n6xabuDHwE2CLR/tjgVk+23tw
 4xqasGmNRwE0IqDekbw==
X-Proofpoint-ORIG-GUID: e5TuPP52BgoaZLSEfEV8IfMMElgRSuQE
X-Proofpoint-GUID: e5TuPP52BgoaZLSEfEV8IfMMElgRSuQE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2OCBTYWx0ZWRfX4VtlS0nf1W+O
 5me5P5liRpMvPwMgfguM8yoEqiQWXBuZFLkYWKBcvwQg04/S8AJEV0U+rgvqHMOC/uwPDYjJFE8
 7XYYG02CycaT3IbbvhaGOJ6Lwpgk92Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160068

CAM_CC_CAMNOC_AXI_CLK is shared by several camera blocks. Setting its
rate directly from each consumer means the last writer wins.

Register the clock as an icc-clk path through the common icc_hws
support, as gcc-ipq9574 does. The interconnect core aggregates all
requests and the clock runs at the highest requested rate.

Use the RCG rather than the branch: icc-clk enables the clock at
registration, when TITAN_TOP_GDSC is still off. Consumers enable the
branch themselves.

Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
---
 drivers/clk/qcom/camcc-sm8250.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/qcom/camcc-sm8250.c b/drivers/clk/qcom/camcc-sm8250.c
index 21e9423676216..84a91103e5bef 100644
--- a/drivers/clk/qcom/camcc-sm8250.c
+++ b/drivers/clk/qcom/camcc-sm8250.c
@@ -4,11 +4,13 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/interconnect-provider.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
 #include <dt-bindings/clock/qcom,camcc-sm8250.h>
+#include <dt-bindings/interconnect/qcom,sm8250.h>
 
 #include "clk-alpha-pll.h"
 #include "clk-branch.h"
@@ -2405,6 +2407,12 @@ static const struct regmap_config cam_cc_sm8250_regmap_config = {
 	.fast_io = true,
 };
 
+#define SM8250_CAMCC_ICC_ID		8250	/* some unique value */
+
+static const struct qcom_icc_hws_data cam_cc_sm8250_icc_hws[] = {
+	{ MASTER_CAMCC_CAMNOC_AXI, SLAVE_CAMCC_CAMNOC_AXI, CAM_CC_CAMNOC_AXI_CLK_SRC },
+};
+
 static const struct qcom_cc_desc cam_cc_sm8250_desc = {
 	.config = &cam_cc_sm8250_regmap_config,
 	.clks = cam_cc_sm8250_clocks,
@@ -2413,6 +2421,9 @@ static const struct qcom_cc_desc cam_cc_sm8250_desc = {
 	.num_resets = ARRAY_SIZE(cam_cc_sm8250_resets),
 	.gdscs = cam_cc_sm8250_gdscs,
 	.num_gdscs = ARRAY_SIZE(cam_cc_sm8250_gdscs),
+	.icc_hws = cam_cc_sm8250_icc_hws,
+	.num_icc_hws = ARRAY_SIZE(cam_cc_sm8250_icc_hws),
+	.icc_first_node_id = SM8250_CAMCC_ICC_ID,
 };
 
 static const struct of_device_id cam_cc_sm8250_match_table[] = {
@@ -2443,6 +2454,7 @@ static struct platform_driver cam_cc_sm8250_driver = {
 	.driver = {
 		.name = "cam_cc-sm8250",
 		.of_match_table = cam_cc_sm8250_match_table,
+		.sync_state = icc_sync_state,
 	},
 };
 
-- 
2.34.1

