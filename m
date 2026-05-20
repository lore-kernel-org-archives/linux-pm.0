Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADAA30EF7E
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304803; cv=none; b=ZMCD9BWbUuU+JuclwoLxcy2iEpHQ4+K4eHzounRG5HnAAv7IENqIRWA1TwhWOWPO74fy8BOQZgodAVGCusTjt7ke1eYeB8Gk5wmaCMIaeOXHeD4rVwHJZTCXB+4OEIi/uQXc0stRxwvs7A3eNABPIZJ6/wGsn0YNR6WA94PqJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304803; c=relaxed/simple;
	bh=4FHLC0bnTekkNLgy7lcHxQjfjLT0Wq3vJixLptjPBrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DqyDsIisQb7WnHwDsfOD2clH9mR4AqDzmI1I4BWBMdHcPKAmx/EfOBdtmjKxCLNqX9jAKbD8HhP5kXwHQl0IiNdtrAzIwezmi2CZrUeWoIV0wt2fist/F4giLMuew8ULejEqAn1WgS1E6dK4azt7Hio3dqg/CYTmuS1jDnSKE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fb9j2PHy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SA0gqKsU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fb9j2PHy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SA0gqKsU"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KF5Vwr4115180
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 19:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=r6YMtjaiaTXIMz4lJ/l5IAROT3th/iPkVaB
	nZpAvcRQ=; b=Fb9j2PHyxuz+kO1pmc0J+OPZFbjx3x1Cdr/aoSGyENZdfgfeAc/
	dZ9LP4cowWVdjrWO5fqawN7uEaHib+Mg8VdrxfZqDNZnrT3pplt4UTenOAPoVy80
	bIIy3z+GnDtwEM60KpzpUAq5fZK9KQkHucWe6KTOjpq6AwKa5/jNDaSkbAlvENGx
	mevRuwtKAB89cbv3hPIyAO10BkIUwHtUO4bud9Tg3cAV4R11ENsoGKKpo+fC3Zle
	1McViLAx8jvtCA21e3bIpmnLSfXRjVY8XCN5QnE07/ymctIPdN2kv3e4hjKo/9Lt
	nwWt3OwsSIxtnQO/hLDrMpDK+uT0fmJC3yA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e99w0jg0v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 19:19:59 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-632ad092bc5so9752374137.2
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 12:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779304799; x=1779909599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r6YMtjaiaTXIMz4lJ/l5IAROT3th/iPkVaBnZpAvcRQ=;
        b=SA0gqKsU1Lg3NFJHdJc/0u1xpm0mAlAZgcYHDy3HIXOJXS0oZcrjH9AnYMR3WnRNbR
         lmli/hkvCVKSwDaFHCSwlibuSAhuujsN9aOZ5sYdxHdUkrJ3TucUVE+K7C+6Tcqw3/RZ
         rCJL7oLkKq4F7/5bnsh2v62V0WPyF6L08VpyPKTOZb2SJ8vn46JPC0HQAzrmWUGaF/8c
         DxvrzEQxSa7xg1+xk5TMehni0BGXHlrfz06g5QKtcFoIOynuxPS45jxMd+e0Yi1Trmqn
         sBii5yTYe6hYoR1SNyGUiIOVmPRPkZQCx+Vm2snIuqzu9Wpto6it6rVxMMlnM/BfZkWX
         5iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779304799; x=1779909599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6YMtjaiaTXIMz4lJ/l5IAROT3th/iPkVaBnZpAvcRQ=;
        b=kH5pWy/EMbMgNnW9CBc6oK7AwuYkdWPYa0U1gj2jFsFgmQBUFLIBAULNFC2Ix/vRaQ
         jDMRWoDTR9w8jCI0wU80w3wgcsuDHXCrPlGjDplqkdc/P5yfzrpBhKYs5brZ21J6T1da
         20zfTFM67pRrWk3irdwEb4GNpjD47VYk7zY6K8o1CCsJLtVroSxxFd2jJxnYHNOunEbQ
         0qb3Q37sXb0ju+lBJyaTGoiGKrJxs3DsMMdRwoy0sf9Mr5C8RkeVZHumv3PXliswWSYF
         RHDL7X8MD1jHecTHua6MDjfHRdRTKb2B6rq+H9hHdoUa/ERwoM42nq6j4l/sJYnrH084
         nw8A==
X-Forwarded-Encrypted: i=1; AFNElJ9HEIgGngyGA+LWGax9toYBEj4/AxebKfZ3OJpBSfuSov+TMjmMYLReTFfEfyj0nRmHTDj725o9Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGsA8+eukd2j4miA0lFVC9lstpaE83wj+1sSzTVjJak1Ji7uCL
	n5gUnNLJrXaslAnWsxykFPVtTJHxyiZcVGz7+B3AYkelty39DmtT+5WwINFx2tWhmB6WIK91OYk
	+Cu/aK3QHWqZlB8j0N3FpeSZU332ChtiBILpzCKQ826hhg7d7T94PwlRjfxetpw==
X-Gm-Gg: Acq92OHBQC9zLeKJ0GmiRQeFBqaRc9Ua+66NUgtGiak6qflszrjej/hB4buncYC2vIV
	Xwby41uLk2KtqLJCm1ER73uDQhHwgBtflKXJzIDg/y99MhrQ748LUOJIWuOsg9lOB7A1vhUkGX8
	alagngrEGf9HrtLCJ1978RodS0vSfsbe0RsIsvbLzftk6NnRM3ynph4kkVEC6BRF0OuAYmouhiy
	3/jNOVghZBK8WRPEJb/PN8FuZ5jXZhzefhci6W1gitmrSiKN4m9pC++PMOIsTnQSPG1kM+A76KS
	unlhXEJkkPtDDGp/9vxwdphYq9JZDN4nHspdUc4RAA31DdLQKsYfR3mNps45gw9U2FhDGYc9l/B
	L3Eq3UQprAwQ60rEgz+dYnx0BOqmgmpFW6cLI
X-Received: by 2002:a05:6102:854d:10b0:650:94b2:b209 with SMTP id ada2fe7eead31-65094c2070fmr7545574137.4.1779304799325;
        Wed, 20 May 2026 12:19:59 -0700 (PDT)
X-Received: by 2002:a05:6102:854d:10b0:650:94b2:b209 with SMTP id ada2fe7eead31-65094c2070fmr7545549137.4.1779304798919;
        Wed, 20 May 2026 12:19:58 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm54567601f8f.16.2026.05.20.12.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 12:19:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: [PATCH] interconnect: qcom: icc-rpmh: Fix resource leak in case of missing QoS clocks
Date: Wed, 20 May 2026 21:19:54 +0200
Message-ID: <20260520191953.190564-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=4FHLC0bnTekkNLgy7lcHxQjfjLT0Wq3vJixLptjPBrs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqDglZH+ClU22WgzuRSsjPrkjZHN/yZFiwN1QGr
 5+DofLulIiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCag4JWQAKCRDBN2bmhouD
 1zN4D/9079hBkeNaOJXFm/yX0bDWLgwYhAydjlIymxjEFffVfWSoyzP2SJdEskNsO1t1bM4OTOq
 87+CVtXnVi8Jyqm1h1wP0HyK9CSI4DobGoduG8PI3I+fBt56Svo0Vnq3jFS60VAnE/ElJ0Q5eLt
 ae2BNNGAzaMaA3siuFd2ST1RcGb6r+hvAddJzUPR2/EIhAJOrHH1J4BPwT5JvtpWuvHbisDCIsr
 U1DPZ81gukmBAy/Isp341v3WclToV9nxLOd3ZutOcRgjwsPLyFu1xRwYRbicBdRQNWnfZy4HXNh
 dC2+YSKr4KNUmnhKvQ+ufZE/wLpKuGY+3AktkPajOeM6AKt0MMjZQh3qubBQZISf001uF+dPveh
 wqEIST6DUnK2wXMWrsH0BV6APG6aAF7IEJvCspU4AAGEX7yoBlBFwYTAxxwoDQDjAGsXJ7l7iTU
 vu0qPvc0quFUStmKbkXGk3KYZS/JfWFIVAC+T8FSsPekn32gDYdnqMp7BRNB4YAaG2ySsPmVo8J
 ahLqb7Y2bfm44z7deD/YNbtLmTXlBK39/M776WB0ksCCFa7d2sehiH1wwzyYcHP0J93Apqsq5dg
 qW++udrAaPzOaJqGJOAPCgHJiUPAnv0YaW2vr1obwDBbH+hfw0XumkinNdOlnkcHiGxdu3lf3YY F2LUb3n5fVQPY7g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NwHYa7NWKgoR2Mc_gZE8nnNAmWESS82j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE4OSBTYWx0ZWRfX+Y1EzjnBkln5
 Vp2sdSRNG9Ij7Gfk8NVtCJyL0MModtsbF5jKcFva90M2C7jZfBwMkvBcR+vbGMk4B/b/v0zFnhI
 wBPbJpT4HmYJ94/ffdCOG9WBsPq37nDxRoqzxwtQ3zV1omiH9YMSqvdUrPlMCEvefBZbz+MoupX
 6MJWQCv3mecB47WsIuO9z+qFA9iEn4Ix5pBcWL/u8j3Tg1q9zKAvEhFbeiTfn9hG/VDDcoYneC8
 pMcacT/FmpVCKgNxfgIv1PwyDLIjaxJdzUlpuai4SHsUQ/7RZOP+p7sUbPYouQwt5J5Y+0/DU3O
 1HlwNrAt+FOPhtdBasOvRbsDHmyHjuQwjs+trcbUvS8msmYtshJNWturgWvH8MbkK8OH5GM5F0m
 kWng8rqTQFpbbK8TC52VfatTxTxZC9CaOyFAJpaMbVVk9V8lQy0hgrAMa+v1WY6WH5UX8ocUon6
 D/YR5x93ksyajlLicSQ==
X-Authority-Analysis: v=2.4 cv=RZigzVtv c=1 sm=1 tr=0 ts=6a0e095f cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=IQQy_Q3euI4hPQ5xFQ0A:9 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: NwHYa7NWKgoR2Mc_gZE8nnNAmWESS82j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200189

Driver defers probe if getting clocks for interconnect providers with
QoS returns -EPROBE_DEFER, but it fails to cleanup in such case leading
to both resource leak and potential use-after-free, since the ICC nodes
are stored in static driver data.

Cc: <stable@vger.kernel.org>
Fixes: 05123e3299dd ("interconnect: qcom: icc-rpmh: probe defer incase of missing QoS clock dependency")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/r/20260520190807.509871F000E9@smtp.kernel.org/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/interconnect/qcom/icc-rpmh.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 3b445acefece..56512989d1af 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -324,8 +324,10 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		}
 
 		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
-		if (qp->num_clks == -EPROBE_DEFER)
-			return dev_err_probe(dev, qp->num_clks, "Failed to get QoS clocks\n");
+		if (qp->num_clks == -EPROBE_DEFER) {
+			ret = dev_err_probe(dev, qp->num_clks, "Failed to get QoS clocks\n");
+			goto err_remove_nodes;
+		}
 
 		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_requires_clocks)) {
 			dev_info(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
-- 
2.53.0

