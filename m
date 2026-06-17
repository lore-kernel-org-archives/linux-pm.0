Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25E3F0ABE
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706666; cv=none; b=Y+fXk993N7mCzCXqgRG5WrLPj6Nfbkw0cnR+T0SFCojZqE1cPaElaHOU8riFy3rBNJlUN99ikByb0YF4vmI11XFKDEzW+tMfwzjLiHMoKuJUSRb2AmFgCLkPLtt7RU2iL10XyAdcCy2d3ixBCDKCDI4lVs5wvcHm5NpGYmsBg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706666; c=relaxed/simple;
	bh=A+lBLB1doShuM8W4lpJJK21Ex8TQp3+bUtgDerepGR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qPOA8Xh2Iq4VfqTIdOXIbr00AKwYqMDBGH0O5ANKPU0HJHvEI8jxmDSNK2PXs3H2DNrdi9eScFZh0mNd9x2HAB45WwETF9fDgSF6KgeEw5THdg1VokSFKk12hRmn6Ul35JSE1Ntoidv21l1KhD27tPnJ9rP2o4hKJ4lA6Nye9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j8PE5aO6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LVTJhFBB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j8PE5aO6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LVTJhFBB"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HEKLvk3059501
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 14:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qasGdUfjcGOfe+d3UxUQ7ny7NNPrRxm6R7k
	OWdfDKls=; b=j8PE5aO6wl2yqJiBQajuAnWtafX3thaW7FoowzBypEVaYRw240r
	7tTR5j9paV1EkOs5eh5HCgOMkh/ZPMUwNiLPaNXMtlPDy1qmzaYekcl+09GvLDNt
	dF1emosvVgsERw0tC4A8kQFbd9Df1vnThvNf7+FLT+8EX58hglHOh5nRYpV6TmNo
	t+0w0s8cOaiSY5kXFcV4Kg7bsF61+os+hbvdOouRmIzXs7VUnV4JVa/s1dye7vZN
	v13oc+iN4AkmxCXvpwezIO069QbNWNyaw4cZe2dkJTw5hE8tggAFRjs5XY2gP7SF
	wJ/uR6T889n7JZJFgMcG9y6v8SXjyrdS+8w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef2bp1u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 14:31:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-305eb106829so372732eec.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2026 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781706663; x=1782311463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qasGdUfjcGOfe+d3UxUQ7ny7NNPrRxm6R7kOWdfDKls=;
        b=LVTJhFBBWHQimvAyppKNetJb6uGN3sV/t/V3ccoyTeDBc6W3MQdWZolGRTLqo9yVWJ
         esCeDcZXcqhS3bGoxJyy2IwYOirOTJM0aSx4QWLEpH2wtllGsbxiEcz/3iX+akeoHVWa
         eR8u+Ko0bBfpeXUtxsfR4vclimAPEAsYYUxAwvHEtOVxDNT6Oxmmu+gPxGFqnRqYR6Tn
         A4bXOUHBvqsHd+nATBe24Bow/r8cJPR2lSLDf+kUjrjvLSgTJcJ+U/5tGndqbsGkuq1N
         lOlyPbksDBLI7E0OLo4AahTP46sfZVcpx59lexIGW1T/edUsFTVP/P07Xv7hZtLrA/Vx
         gWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781706663; x=1782311463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qasGdUfjcGOfe+d3UxUQ7ny7NNPrRxm6R7kOWdfDKls=;
        b=Ce4/QI/nRFptEG7J/H3zPizx80kNHgyJLjQr/iWTAJl1jPPOY2SxDNv7WGqxJA6otw
         IXJ7RN4OaLh5wPYL+oN3ca4gp+V0Ah53GPFsVM1uoyi1C9APjLbDtvOuk/16z/yiWy+m
         yLC/JK8RjlvAmFG9OH7l6CWUG2c2PP2owPfYtf54Tv8kxUdord1lHHGHXRb/xSiO/xa9
         FSUDN9aXi5NlxOJilHhODSIPEgrDiJa5AMn42LDtgNbzAci5jzn0aMZL9fAxE0/EJ58K
         Ey0Fhc/lLBLx/PTul6LqiKNa+hlQPBvujWlT8M1F0brsa+y6uS9H77yxBGQIrin/2Yn8
         xPcw==
X-Forwarded-Encrypted: i=1; AFNElJ/IHeTf8hayhgVdU5JwFVChFP3/Wb1a7LjljHnjgO5LSMVBccsPkKEH+BW+ESc8Mi9YWkYs9cWqDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0JQcHUF/ueulkbXGrD9+QsetW5gcBQ0dkzgIr9kdyJmFJVHTT
	OR44gOdJeW+XwKbBvzkzaubvEc1vXuAQs5NnnxVrZ+MyJZ5hbQD83MorFiOy0vY9L2fchCzCYyr
	lLISP0/Pri0LL6uppeZvJUgGL0T5E46wcGaYQwTRKtSIgWpgBD9XVAGUbkAGY0w==
X-Gm-Gg: AfdE7clmfG9QNb0b5AiL1etLTS5o6lBVBT+eFJkBvFAplQRgTksvGPUoe/2kWE8LzPv
	78N2hboFTKsKtv+KlvZS3TzVHnGUUDZYC8xMyhsNUOrFEW+DdnvYVMAIrSuPtk2KL/AxwvvDNQz
	2c/S2oIryUMFGhmPSEdx2LqXy0GL214COL3sE740AiT68B3cAckqs3094XbubMDy8AALltu1XPl
	s8+qAHUVOiIDE1CeL2HsbW5zK+hB78n+BlGKTZ4c2qveXdyG7VxaLXp0omthuIVdKgUp2eKxJTy
	xKQaEb5M2b5RuEyQ5TJwUkr2uT2VWOeiyKXNllxtvbg098UV96Qv8Zyow8mnXS1JybMzmQQyAuC
	MrspBsJ1ZhP8FdmFREH0iOuKWcQUyPFLXFfQmzbE2sh+n0oOpBBvOKDsoOf8Olw==
X-Received: by 2002:a05:7301:3c0a:b0:304:5074:83b1 with SMTP id 5a478bee46e88-30bca07c512mr1043509eec.6.1781706662256;
        Wed, 17 Jun 2026 07:31:02 -0700 (PDT)
X-Received: by 2002:a05:7301:3c0a:b0:304:5074:83b1 with SMTP id 5a478bee46e88-30bca07c512mr1043476eec.6.1781706661368;
        Wed, 17 Jun 2026 07:31:01 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f878sm22962978eec.17.2026.06.17.07.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:31:00 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: [PATCH v2] power: sequencing: pcie-m2: Sort PCI device IDs in ascending order
Date: Wed, 17 Jun 2026 20:00:55 +0530
Message-Id: <20260617143055.820096-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=F8hnsKhN c=1 sm=1 tr=0 ts=6a32afa7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=EF50nfIsKRdRTP-bws8A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEzOSBTYWx0ZWRfXxqxeSk5ySYYJ
 ff2xHFgcp2la587g0E6d+fBS9qGaRr1I/0b6aCb36TNzrTdNOtHp7HvUapU685z6fx9OP62s0ki
 8b3lJ6z+2E7MNn4HqnrcRt3pCiMHms4=
X-Proofpoint-GUID: PwQ-exl_IfzbTsBzZiJzzuW4y1GydcQp
X-Proofpoint-ORIG-GUID: PwQ-exl_IfzbTsBzZiJzzuW4y1GydcQp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEzOSBTYWx0ZWRfX1XS+XCk+rIm0
 +AB9QaPOubzMB/BJspoXTaQ/yHi7uRqSSBns9B/vkCh0W9lxcPPItRMTAGrpw8igVVRrbPclK42
 BytYU+RYN34sarq5C3V3PR1tBAIlABBO/hK7evJRZs5kL2DVIkcVQCAnc9oXy95WaeOLyNUy8r7
 xqqpLfedNyBIAtCVRgvHN51AmPQgJKdLeDLMhPQb8OMuFCMLC7zBAkxhJkYXU8NtIENuSw0tfxV
 5AgW3MNd3C0eiFcxgQOMPPx1zS6Zmwd1Yr0+NbGYNsBK5EMP0jEBugfI1bx1SPZzCw8Eo3P1CvP
 jrNjsbMsos4FPZfN/v/HrQeoknQKcSTbIBGIHSSNpE4iKxVS/0vITYi5K53dWMPiMlokXmDyGCH
 YvmtaircmVd5KLIYeBdcwwp/YIQ6IT2OjK1iBORuXcFMk33o2t9/6CieH4967Low5/Ex9eUtp1X
 qxLWx+P5sdm3UW1n6hQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170139

Sort the entries in pwrseq_m2_pci_ids[] by device ID in ascending order:
0x1103 (WCN6855) before 0x1107 (WCN7850).

Fixes: 2abcfdd91e6a ("power: sequencing: pcie-m2: Add PCI ID 0x1103 for WCN6855 Bluetooth")
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
Changes v2:
- Resend as standalone patch, not as a reply to a review comment.
- Link to v1
  https://lore.kernel.org/r/20260616025632.3697863-1-wei.deng@oss.qualcomm.com

 drivers/power/sequencing/pwrseq-pcie-m2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 94c3f4b7ee36..b5ed80d03953 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -186,10 +186,10 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 }
 
 static const struct pci_device_id pwrseq_m2_pci_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
-	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
+	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ } /* Sentinel */
 };
 
-- 
2.34.1

