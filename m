Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C29379EC1
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784881334; cv=none; b=S+qEM6O8igwO21Cz6i3YkXY7giqBYBI1pSu+ZRx3b2deJ6koMFbayoOI3vgfg08rqv5H+F98e2w0GbB9/6D+bKixYocG/GKbgNaJl7/6FqtxUk2q6tEi7ogFSbBwCwO/5lWG6KK86EFrS9NQLNParahAq3y5LM4as5o7gk0v7d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784881334; c=relaxed/simple;
	bh=wnPUTo2woLQKL9B8/b8Kggda7ZKkWWpXwGvcaz8OfvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VF6/xKdjxqVkGV2wHVWjU2ihifRHpG0mMQIImkw6E5FMb/OQFnHJIcg+vu15tvQ7oZoIh8/lIgW4KIppxO8NKmu3uM6GoN+ptBJ3mfAXRivqOAIbvNDsn1F4d06ibPMYLbnyjWAksWdSlN2jCLex8ITY5lwhGiNCc/8XbrJgk4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F+SqpYUb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ioOvcUXT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F+SqpYUb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ioOvcUXT"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4lSrF2162981
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9LqU3seTDsR7yCvja3IPNP
	87ur/dJ9Yx/+EA0use6Xo=; b=F+SqpYUbIRIfvU4nvIFxshjNo8NxFAEoyP3+RT
	rz8+BpzAUnsz1ZI9vy5T67rU0f1k8Z6516N+Q+r6u1ATMde2vvCDdo/Vg2IEQpmx
	GiX+n1Zob+FY3VJKP1+KspTeZzBq8NCGPgSUlfdhBbW+0fshTWCc4EFlh8kW4rWn
	zdHQwFdGkQui6B4Es6/PKN6UKiGyfa7FS2otlpJWMSQ3sBKirN1rK+ELKXzmhY9/
	mr0x1ZZS02rJ0wjMtG0j1qJhm1n79ODjBm7025gHMiVGtofyqa3/x1in4y/yGb5I
	3NXerRR42MeYXMIO//O8rBH1EykyCA96MKevxFywvLABNJmQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkp5vk7xy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:22:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc98d6a88bso818295ad.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 01:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784881322; x=1785486122; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9LqU3seTDsR7yCvja3IPNP87ur/dJ9Yx/+EA0use6Xo=;
        b=ioOvcUXTZhlgdNpJIdTm4PwKG7DaF4NZhH6LWxIxjvm28q0wpieWXiLxcNXPHUbpeI
         bijpZ8Gr+SH4A/lSl9ge6kczz/oPqqQPYxfE+aOoVyKjKzk6buQJYvpD7W4ZoCNuqeLi
         0B47xyO+xs0Wq6sCLshCZ0O6IxTlav5aTxn7z9De5oY37Hd0hSa+AHFbZG/ib71Jq3di
         kyZ6EGGoMC4t19J9ND62sbBuTDuhzkJsioXQrh/wmSrcYuKZ6XE5Q2H0sGQVDLA/l9RI
         3DN1F0ytTE6GINicKCV+Y8nc975B7rOpvA4U2Y+1owY5BkrdB21JWm48sSTWbsRXFlJd
         /4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784881322; x=1785486122;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9LqU3seTDsR7yCvja3IPNP87ur/dJ9Yx/+EA0use6Xo=;
        b=KLak/NccZ8Nx2XC4+UOHa8EqJvMaDzdtGJL4yRsp7Tx0jX3Wke76E8c1r/G7NyzxID
         ax/Q2YOdMiJ+bNvAyCOOSURldunIVopgyZqo5h80utrCJnb1LwAMRj/gEmdvC7lwVLns
         7T7ED6GsxBFPlgGzF6aV9oeBBFLnUkA8whW6thP+1o/qr+abxrFHeuh2SoFV2VMM5FZC
         ZLd9h2oreBlJU3+a6cjmU6vyMLj1ZgIVqNr2OvPQxhr+NF0E605vsFEeSSPcULPYeHZ8
         hAOcyAz1DoFDIna+Ods9tO+/NKxjP5dh8v6TIUsZtIVc4zZQ/XpuuuRSnRMUJRtsXYZT
         sHSQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTF0487jwVNky2dX4IvTRDepON0Jjbbp2Xhnj6nBQCMO6j7pAUr4Wg3sRaXKQNBpwg9cIrFnAeLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv9znPrhV/2ZYYMpVAbA730K+eBLO6hszylRE5a762Fei03nsm
	RqedkxfKpmjA6HO5g/ipgZ+wemp112IXkf1sBYHkFDq5qDHNy7KprgfUPFYCYkBMDJRdx8HbJmx
	ieWamC88lCbBWnGWIFfJL3IBgpUOlZxIZ/lHO2C00uk+xt5QiIVOgR1UqqDGLJQ==
X-Gm-Gg: AR+sD12Ysuh6eHrqbtGEcXiVRtONpnr4q3GmtYW80Op7CwQGxWuITFgoVkSDEaWIRlm
	2B7sC+zXQ9kYOJsgIdrtYUv67JALsWLJ31jXhrYKgAHwKFInd6080gnV6tDRxhX1AXq1DAwLeEC
	paMOldWHGSZDwu7ZE91n36E4VSW7srTZyD739Y3nNvwEwCgn8jHGc2wXpvPNYZfOOfUBKgL+PRC
	uPAKgyE6JKTye80+/PDgpcR4hhRJHtJgFrvDsqAMYus1BZXn0gGu14PuCKvdjp+qn5hh97gUGVE
	xvtplO6pmAQFx9LrgX/qGPOugWil47/fgo30z3+pgZZVA/NY+ZHX29ptdNDff45EKY4OBCWgHMZ
	bVwal2lF8y1UwuWhpSdj788b4cckKiuvlvjDY1Lrfevn30QG4yzw=
X-Received: by 2002:a17:902:da48:b0:2c7:ef84:c58e with SMTP id d9443c01a7336-2cfbca01dccmr25215295ad.1.1784881321496;
        Fri, 24 Jul 2026 01:22:01 -0700 (PDT)
X-Received: by 2002:a17:902:da48:b0:2c7:ef84:c58e with SMTP id d9443c01a7336-2cfbca01dccmr25215045ad.1.1784881320820;
        Fri, 24 Jul 2026 01:22:00 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1b6a45sm27960484eec.28.2026.07.24.01.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 01:22:00 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 13:51:56 +0530
Subject: [PATCH v3] power: sequencing: pcie-m2: Match WCN6855 and WCN7851
 UART BT variants by subdevice ID
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-hamoa-m2-sub-id-v2-v3-1-af97de70bbbe@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKMgY2oC/32NQQ6CQAxFr0K6tmQoguLKexgWA3ZkEofRqRAN4
 e5WDmDSNHn/p68LCCfPAqdsgcSzFx9HhXKXQT/Y8cbor8pAhmpzoBIHG6LFQChTpx3OhO5Y743
 tqSJzBT18JHb+vUkvrfLg5RXTZ/sx0y/9q9Mp0BXGNRV3DXfuHEXy52TvfQwh1wXtuq5fCzNWF
 LsAAAA=
X-Change-ID: 20260723-hamoa-m2-sub-id-v2-f8640ac2520d
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA3NSBTYWx0ZWRfX/yRP7ZbJwOww
 sShnCZxBbg69TFFJQxOWYfZsb4fBvQ8wVlD+HNPQi134bXVEZStZqavcj2YIQjfgSfOz+mjC4ew
 nFOr09LZmcgOqTxlNmJB2zpu1KWPQ20=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA3NSBTYWx0ZWRfX3UH9N25bA4D+
 dYl+Tu93lPzARUFtYlrIUUjMNLtzNqZddaXPU6x7ewFnORrPCfZt2aIq424RZOO5XnkiW7aFN2U
 bEqbBRGKcXquUNqVRecP962SJrGlIsFt77wzcp773OfLcf22EE6XlrBFr9CN+bRYVwkNLb+bCUo
 tNfkeIVs1qLt2wTwI2YNco9Ut7qpUaUx6Ii+JnWxmz0XpkrLU6E3d6MJu1YLlpkho/1kqaSMPqI
 7KCwLNttK4BiPEHrtwtOdbvH8w/2Cgp/s6wncjmomma1TWT25LqKB2aOWJ2PG//1K9lHqlNulcy
 6RNnB0WQuUDViMw/crtAZ34oJpqlORjV95DWO+JmSq+fFJCxDIGH2G0KBjb8JO3Kob5YHFcawGb
 m1PGaIM2FAe8m7RNOWm1MfgHriwbnP++2dCKtTAayKCx9WLU1sMWq91qQVYM1+cTDJexQEZk/aK
 f7Pt06/YaV5HfRkX/hw==
X-Authority-Analysis: v=2.4 cv=Z9Dc2nRA c=1 sm=1 tr=0 ts=6a6320aa cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=718rDa6z-us7KMpumiEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: bOV0b-hpj50akkU-G26s_B07JGkETqQI
X-Proofpoint-ORIG-GUID: bOV0b-hpj50akkU-G26s_B07JGkETqQI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240075

The WCN6855 and WCN7851 combo chips are available in M.2 card variants
that differ by their BT interface: some expose BT over UART while others
expose BT over USB. Both variants use the same PCIe device ID for the
WiFi interface, distinguished only by their sub-system device ID.

The bare PCI_DEVICE() entries match all sub-system IDs, so both UART and
USB variants hit the same table entry and trigger UART serdev creation.
For USB variants this is wrong — there is no UART BT interface on such
a card, and the serdev probe will fail.

Narrow the matches to UART variants only by using PCI_DEVICE_SUB with
their respective sub-system IDs, so USB variants no longer trigger
UART serdev creation.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
Changes in v3:
- Rebased on current pwrseq/for-next tip (Bartosz dropped a previously
  queued patch); no changes to the patch content itself.

Changes in v2:
- Send this patch independently, at Bartosz's request.
- Update commit message.
- Collect Reviewed-by: Manivannan Sadhasivam.

Link to v2: https://lore.kernel.org/all/20260723-hamoa-m2-sub-id-v2-v2-1-f10f95eb9ebf@oss.qualcomm.com/
Link to v1: https://lore.kernel.org/all/20260709-fix-hamoa-m2-w-disable2-v1-2-5e725091266a@oss.qualcomm.com/
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 7cb455569d8e..9c096388d8a2 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -192,9 +192,11 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x0108),
 	  .driver_data = (kernel_ulong_t)"qcom,qca2066-bt" },
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_FOXCONN, 0xe105),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x337e),
+	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_QCOM, 0x337c),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ } /* Sentinel */
 };

---
base-commit: 1656f4f2eb45d9f18515ac00657a2494719fa065
change-id: 20260723-hamoa-m2-sub-id-v2-f8640ac2520d

Best regards,
-- 
Wei Deng <wei.deng@oss.qualcomm.com>

