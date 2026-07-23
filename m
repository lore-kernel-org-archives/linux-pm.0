Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D482EEE97
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784777672; cv=none; b=leFz27FWoRYtY8Vluphdz3OJ1yIrP3tf2kCXrqu2W22e0CfizH1h8BTnqzpyaX2W9RwA/aegl0E8zJw0RUYdp7+WpPp71CNRckJkyETxWbrSrX41s4h5JpeOpgguiYuqFJ/ID8hUCZiEes94KyLvIgo6UVp8z7K1S06eJzWQY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784777672; c=relaxed/simple;
	bh=1SZtk/6itkk7jnoids8+nobTa+90ATFJ3nBExnhk4jA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=liTxem1DFKVsQGrxsmV2vm8bsUvsCB7nKTaV5fN1FJIJuWFXb7WgJMWwldFarYi4HevPCzu7LnTjZ+3tqHyVx3ab30rgcOpeZP9nkxZYwkh+Mulk0C2imfrArvCnm8EYj84GOyH4FMyHLh0X/DYqSx76Q1RzDsduSljeCFR+zOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JokoA5If; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JPSll//J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JokoA5If";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JPSll//J"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N0XT2P2658863
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 03:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qbfAd5hooSeWEDkAzv9Kct
	PdQQKDZzzw8NU4r55EwsA=; b=JokoA5IfRCRtMqT5mgv5U5mKPWhxvJRyhLZtvO
	D8U+2vsZUXih25i0DjCdUPdBnQBbVLWvT5zcYzRLW6aiBJoUZkwpehZAPuljuqkX
	Cz47te+YnB5K/2T/o0eh+1dn53Dz4D7HZgsSIi0ir0dSiz/JhRdui8Vg+r2rDxMe
	2HW2ij5HSNEKNJwucC0VIaMTrsg1sBaj40IPR0n7Z+gYpb1bC8Bxn5LTeuH5IiAV
	3WqS+Wc52NMmOpT/83AE/FEHEdrH5dgo/PCPnGU3HiI1T5/qyZ9dzJgbaVl3smjj
	V/lXWNIb8ANQpDJIowXYdQQN5yLzfSQe36E0JAxxlHG1k/mw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk7b50s61-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 03:34:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c6a72d672aso1985775ad.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 20:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784777669; x=1785382469; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qbfAd5hooSeWEDkAzv9KctPdQQKDZzzw8NU4r55EwsA=;
        b=JPSll//JaN5ncVcV2HEVIWD+dMCOoVilxHpejb/ti2uWqybx+om/0uuuuSfmC+iuzh
         mSP7wWavPogcUcNGVBwyMC3dVcJRkqYff/3KLpW5LPEgg/Do7+EEKITqe4ApxSZ8aCQT
         I9LxgmYRQPLEBRBnhRTNtilf0uQ1997ek8CTOgLs0nSE4ePkY+Bghanx5pxoa5Ux7xjL
         /GR/KOCzWi63j6AeeCqYQ7PniykPKMqmEJ0KiW2D/9FQynfEPK7H09TrFRxxfvQ1Ns/v
         El/7uX666wTnl615oUrvoHxKtM3dagjOuS+0iFgbd4/1b2GC3AtcrIdmFvMsySultDd6
         7KXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784777669; x=1785382469;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qbfAd5hooSeWEDkAzv9KctPdQQKDZzzw8NU4r55EwsA=;
        b=pqMv3wTz1U5vnFa3XzrxcCNrYaSONcS0cnXfL3NJXMiaoUsDXEDyRAakfKrYTYEAmR
         ydqyRxoeUpOc88wwOlEaMT1OvYcaut1ulWwXJQYW+OuCsoLnXfGwXRge/NNGEgziDL8E
         2zRMNOCQCQNc4yqrWkaFuG3D7ihKR4wrO/hmufe33iigikp367rodkz4xNFMXJvub4Z8
         Huq2X/ghHHelCORJeajJvJVCOXd79CTk4M9G5xYOlEXM0uhFtyt9ZYWi8VC//bjakPfq
         gCbemXqOBwUXN+UyGuVdc2mfiYsf01D/SNnhtYF58J/WC+lxUm8QgUmNbOMigVeg+4H5
         y2DA==
X-Forwarded-Encrypted: i=1; AHgh+RqcVI4KdBVZOkiAkAmxauZ8Z5Rt239YcLYOGpwj2EjI5D//ZEdrvYAALC+EPfziybtc74PWEUf2sQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhBPsKw1se/mjJ9PtV8xX0gE0je20F/EhguVelpRxXhq+Uj7rl
	JtJ2FO93+8TlhWRWS4ZR55EZ1W5ocI1p5WElqBvmBNs05XKuxoZTW0voet+5vS0a4so3AVl8KH6
	rltd+WVx2+uLwgkCgStsqrW1oDSuWmcE8aVJhVPatjMrSuh2bKUmW5GcZfRc2fA==
X-Gm-Gg: AR+sD10PWIUkXrIQEy6ftgdoziK/eynahglEu9r4PoVRF/d/EOX65Qh4c1v83tIV3tm
	6zhNubSl3aFXBuc1UhWpV4GPRBtbBSkvaq57E+YAWaVoXx8l3T/ppqvPOW0YwbggYCq9o2tAeLQ
	fBNCs2eoa2iWc4K/NRerxvuTx5kymfeJt5rMuZozNK51lOQAkq6Vcxg9SatmMsVViH7g/pa1z29
	BKiv3i2WP9j88KBuPZYzLbrU1MJMEMIA8nFi85R1++Ty2Hl7shE0OfD0cZrn1PjUO3U2BSvFRqc
	TmFOOlmSafzcaflT3SjDKeKSfzqZr+lyTACGmpX6xyCqM6WOTUwAp2EJOrf7VCC320W4lrBuesI
	nHF+P8ZI4qWEdpYVfffAgM9OvYAVpJX2VU4HKvYzx94E9aaxlaE0=
X-Received: by 2002:a17:902:d550:b0:2ca:d9ec:3217 with SMTP id d9443c01a7336-2cfa71d94camr13095435ad.7.1784777669283;
        Wed, 22 Jul 2026 20:34:29 -0700 (PDT)
X-Received: by 2002:a17:902:d550:b0:2ca:d9ec:3217 with SMTP id d9443c01a7336-2cfa71d94camr13095145ad.7.1784777668768;
        Wed, 22 Jul 2026 20:34:28 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e088d3fsm14776028eec.25.2026.07.22.20.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 20:34:28 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 09:04:24 +0530
Subject: [PATCH v2] power: sequencing: pcie-m2: Match WCN6855 and WCN7851
 UART BT variants by subdevice ID
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260723-hamoa-m2-sub-id-v2-v2-1-f10f95eb9ebf@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAL+LYWoC/x2MywqAIBAAf0X23IJsT/qV6GC21R7UUIog/Pek4
 zDMvJA4CicY1QuRb0kSfAGqFNjD+J1R1sJAmjrdU42HccGgI0zXUhzehNvQNdpYakmvUMIz8ib
 PP53mnD86QXk+ZAAAAA==
X-Change-ID: 20260723-hamoa-m2-sub-id-v2-f8640ac2520d
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDAzMyBTYWx0ZWRfX8S0TEQzIeF5i
 nA36NJa3kCLK309CYqM4K1Xi/CfVyyxdvk0HTCGHb4SaCdgLb+MsnL+w3MvTlYSLLZzl4JiNXvc
 mSjkH2ZBmYfWUUb5TnsnNZt/uWPIEN7NoTjqjvfWmEuEzDnuOr5pa3Q1IpmSb/PHPPxGjimD4h7
 yyIRnGto1chyA/mkKTc7m1Z2jd8u05KYh861OyX4v5g2RWDqbcw0EZhMgzb31K5Yb3p2l44RXIz
 aViy5TmOPJ0ZOKl++XHDIUPoB9VlMVUFuaJQfWhcHEuiKmm3xDZuoINTXIndxh7htdjC5V7GeOI
 i53elkMgFIMCKmz218eXLK6HOs55MaEUfkqf34d08vHCSkJMG9cYey+YC9MeUzso6MuhsDsaMsZ
 SJZNDFbtjPQUX9hTsJyIZZw/+Edpv6iB+dWZYcqOSxCk8H7bQEltNbQLrhCiBNPIoASjN2ULqmc
 8gs9Sktq0eBoFO5kW9w==
X-Proofpoint-GUID: KLBoabdGz2m8D0ITWVjkwoS43Q1JZmRA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDAzMyBTYWx0ZWRfXxUHwFbn7PnBJ
 JfLoCCnoQZc0vsaXq0DHwe5nSI3RuUALTAfEUMRLeJfLrYvAP4iaK86gUGyGC+NGqORLWFsziSu
 7FTGLi4WM7tHuSRjZ9a6fdqFPiuIeiA=
X-Authority-Analysis: v=2.4 cv=btx8wkai c=1 sm=1 tr=0 ts=6a618bc5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=718rDa6z-us7KMpumiEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: KLBoabdGz2m8D0ITWVjkwoS43Q1JZmRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230033

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
Changes in v2:
- Send this patch independently, at Bartosz's request.
- Update commit message.
- Collect Reviewed-by: Manivannan Sadhasivam.

Link: https://lore.kernel.org/all/20260709-fix-hamoa-m2-w-disable2-v1-2-5e725091266a@oss.qualcomm.com/
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 26f695b98d2b..5dfc9f9ef64f 100644
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
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1112),
 	  .driver_data = (kernel_ulong_t)"qcom,qcc2072-bt" },

---
base-commit: 162ea02941a936f8899f3dbe10607b1d5af1b07b
change-id: 20260723-hamoa-m2-sub-id-v2-f8640ac2520d

Best regards,
-- 
Wei Deng <wei.deng@oss.qualcomm.com>

