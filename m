Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58583F660F
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724323; cv=none; b=DIJoLtTd8ffVmefPv8xneOn/bU0QmJ0/0SJqgVkYCHrYadt8moGsS0YQdeFIo5+5VZxFXsLps18hdShNlzil3YIG58ZcLtqOYrDVf5tumK0QP/5QOgU7gxphRhIvWI6iGytwcHjkzz1GJwSGf84tUeQnq2e5L4qIcjfgZPVHEJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724323; c=relaxed/simple;
	bh=474PNOoqPhwnp7znKFV3q01C3kbdlREQRa+VBgB/Bek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJQQbQPGa5sZnI2tPhXkiCHMLrOjd0Z85NJYURiGZGvnXvW77Z+E5WDBlfDhcw0iWGS8sSnv+Rn62Ws9mJBsDBZcnkipP20BxhKDVf1SdcSF4pJ0/v9EFkUJFFCla7vDUwfOJfmSeqlBxK0UHQqCyXQOX6hyJ2yvYSQh103FKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D6sHJGB8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R/0in3jC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D6sHJGB8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R/0in3jC"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5xxsK2660297
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 09:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1sm/afsUGXu4pDx0v3+d709yaRHJ/izFXu6
	rD+/ffos=; b=D6sHJGB813uSl9CLhi/yRKnBCJ+DYXAcQEBe0N6oIS9QRnLpBnp
	YOCpPP7YYNT0R2qIB4MaQJ0I52WuREjaFHrYbPQG4J2LTCFFNLGs0SmPwjjRlKBg
	0hZBZ5ZaGzSEF3CS/bpPx0cm2YCBgQQV3YFqbCB3w+Hcvt+uD7VNB6oKwI40M2st
	JOX3/1glVS2+RjHdWv7QsUVCAPMxk6zOa4Vb2W1slUcPk73nZEhl7pHcmJktPF/F
	Q6YndOPdpVxoY8BJcwUzFpsQxruac1LikHVi2XFMKoJEv0105sjotnrHlzUbi880
	vopIlSIf3JBvbt/IWAoOSch4HcvBkYLj0ZA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grjttv7cu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 09:38:41 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-912330dd4dbso36107136d6.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 02:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789724320; x=1790329120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1sm/afsUGXu4pDx0v3+d709yaRHJ/izFXu6rD+/ffos=;
        b=R/0in3jCA3YQwybD0zw5HrXM3U09wxTjqVSdh12tj9DwahlOxM0Q1C3iBtIcQWjMBO
         87iqiEF5QZgKdQ9ltW3jJiXZq/2sgwfQuw4WsJcaGfnoVBNU4OCyoGckANmTlYQ8jlGV
         W2G8QS7gFIF67+6x0VOfPhumMzx+lIMRe7b3OBEcLUnVP4m8nYFTwhXD6ltOo0jHAfiY
         mxTXi5D5Gwhw11qwahGrQmhHqJ4saZAHWn2ydAyLmPpahd508jJPnqPEiQLV/4qnvr7a
         6TRflmQAk+JdBzXVjN/XyC6cuId7UgxYHaRQX71p4ioJ6RDrgItAbikpi9hgz1Tv7dLa
         YH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789724320; x=1790329120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1sm/afsUGXu4pDx0v3+d709yaRHJ/izFXu6rD+/ffos=;
        b=U/8FnyqBeCQZ6I+jCX4pYGnDYRiiIm46Mlxzks6+OCbXesxDoT4+T8JK0U+Pu/oy1d
         pokkGO8lsvw+ClRqD5skHzrIf/NkND6PCotxL/ZRn6KrUA9rFsQ1zIY9NJyFZy/+suNs
         cwF6/n5YdcamxdyXF6z1FEEZLSF6YerzgotJKMZWOepnN7gglzf32mZvcJON49vPCs4U
         jx3RWW4b6nqwr0bh/KicXZV1bCHDIvdMEkbB0adXQ9eLVKbWIAegPEC/lZCn5RgKsq9e
         KgC2asDLPubM7HDIgR70KPBhXbp1f4JHS4nEfropxWe0xOlSkuAeS6dWNyXLTlAQyJbC
         nNJg==
X-Forwarded-Encrypted: i=1; AKwUvByenXb6OtHLOfaKdPbaLmSU36Yka5g5+Zh7qiNcCHQkeeH3EFaoCPbY8gD0jGi0cy5ycQVeotiAvQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mayb0vJHn/vvI7YIt0hcxQrcgQTUr2HyXqtsjLgXTItvtbI2Rt
	a0JxfGR1pZIoJK4V+KERBgN0uw7Op8oOcF34/hXoNviwmZW1MFfgRVGgDF3IW9AEv2BgRNOaMQD
	JU5zqAccCY9zSSOXHPFPwVchaoSMhgke6ezlZQphM1IhgBbrJ/SYm5IDS3aRM9A==
X-Gm-Gg: AYBFou00kRgmK+VbB3rpv/3PtInvxPTBWupVdBF1tJEVkui+l2yhUCYGCoKo25+OzwJ
	ID8otCfLs7eTkg2dAZPVDvs8rnChC1d9hfna3c1SJhdTnqQgL3sPEWO3HwOJWomiKILPDWDyJf+
	SGWa9mhw9mYJ7ozMG5/0gGLvB5zaAl1yW7bGmR9ZnTWQLro2KOEwVpGtKjkmeJ+0IU/5kLBzF2q
	4s7Mykyia0eyPa/9lPlTt3xnXd5vWWg3FlNWShWQ4mJRHoEOMN7sx3DB+mhgLQvD1fXRCPiJNfX
	XR8T+fpRsnC3pdT+5qZD+H1TDVKkI73sEQdGgZ9DPBk8y8aej1TUhNBpGmima7542wZiadZNPPr
	BqQaySB8Lk/kZ44l9dWd4276QYhBH7nQGbG40+1uqf9QKoCTOnInzXQ/ESvkpVzyMtLr5Faw8dq
	hHu2ox0vABgOA=
X-Received: by 2002:a05:620a:4547:b0:939:fe07:a13a with SMTP id af79cd13be357-93bc6241149mr910464285a.6.1789724320397;
        Fri, 18 Sep 2026 02:38:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4547:b0:939:fe07:a13a with SMTP id af79cd13be357-93bc6241149mr910462685a.6.1789724320042;
        Fri, 18 Sep 2026 02:38:40 -0700 (PDT)
Received: from t14s (2001-1c00-0c32-7800-07d4-cca3-ec08-7ac7.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:7d4:cca3:ec08:7ac7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a1bbc6a06sm37315566b.53.2026.09.18.02.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:38:39 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: sequencing: pcie-m2: Add Lenovo ThinkPad T14s gen6 WCN7850 subsystem PCI ids
Date: Fri, 18 Sep 2026 11:38:38 +0200
Message-ID: <20260918093838.6645-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEzMiBTYWx0ZWRfX1X5pdTDU9fT5
 E4NeONRIb8koqdlRXaqgO+WKo/UNgTS78chd2NLoyC9svQhl3osG5g1T9xRlnu7Qm10+8F2rHnX
 el6Slao4Z8DcYelqPfj9Kk4BLQWLWLLPTBtb9F8bv7Ja0KmHJ4vo4ru+pFEpsjYIksK6RYCrCXC
 LrTs+3PvIRkXR18RIwh785en7bYVS2c87fSnb9StuyWmvjYWMAY7l7hnfAlt7UbGNDZeQmy+GL5
 64i0+NfSFHnM3GVIaDPhkcsL2cITI4y6B/1wlPycalFeKTjPDsVqM9P/tMTrHuI/KWRZRxRjkUt
 6dT1lbudXrLye2BczK8NHaLSX0Y0htRhMV3vJ/zIW/sppwkym5cYpG3gusQwyTyMWTYQaKPc3KF
 RbINtUO+jfin4JwjkOdZZ47PaMZnpc8jDVBDL5WCg+cSKO23AxMz3AxXZSVqeFLLgB0A3qGNWgq
 YIHNlgB+KsyWWGTg2mA==
X-Proofpoint-ORIG-GUID: iKF17EgHDFDpCJs8cnDSZl90DMFJZTKr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEzMiBTYWx0ZWRfX6r9u627lpmtY
 /rPOLze6bjOJeSNzR4Mo2G4hq6xxPuyq6RwiSh6vLXYFTCDzR6kxei87PI4STz24+QHB3M9Nd5S
 Vd8+L+al/WNmcQnAVCouDE0E0IT0Y2M=
X-Authority-Analysis: v=2.4 cv=IP2XmQvG c=1 sm=1 tr=0 ts=6aad06a1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=ohc_vuBGHJ6k7NFuzkMA:9
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: iKF17EgHDFDpCJs8cnDSZl90DMFJZTKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180132

Commit a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and WCN7851
UART BT variants by subdevice ID") has caused the serdev for the WCN7850 on
the Lenovo ThinkPad T14s gen6 WCN7850 no longer getting created.

Add a new match using the PCI subdev ids from the T14s gen6 to fix this.

Fixes: a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID")
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 471ffe914a4e..0b72e3a6992b 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -197,6 +197,8 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_QCOM, 0x337c),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_LENOVO, 0xe0e9),
+	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ } /* Sentinel */
 };
 
-- 
2.55.0

