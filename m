Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FFD3B52FB
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910237; cv=none; b=BtS3HllDLoekg5h1KubLSIVsUnDg4MLNiWMlAS46PY8LG1BAm+1/PcteYTKiXSoCDC+0KuavzERtKob1PFaZKzaDO+FDUPM2XulKZJY5uH3PndkJ+Y37hGLr2EmOaBIvbFssvXWIhBXXaFqnupxh6tKf9lImPryVAJ9ByguipgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910237; c=relaxed/simple;
	bh=VC+OAXuz8EAO0x2CZC4Csp47ug8+MAbajNt/UTVkJS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ie0cgxvAw9u2qrXCwgtz2jR40GOX0+FN+cYHScRX4hF7Z3YrSLCODB4weF7Cm410UQPyitBidvjiEalKE+gi06CJvQI2GNpLfmlMBVNAqZEGzNZG7uvxDrHR69Pc4ko+s945+8ExRSNROyWtvro6idc49lwl2AOsHzmT+05JyjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nm/j/93t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BF2cIrQi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nm/j/93t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BF2cIrQi"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586Pl2e2733126
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 09:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cGbKRVpcAfB
	zmwnC0CIk+WS2eHsVaNTyn9isA5S6dME=; b=Nm/j/93tcKam1NhBCXoXtouwDoM
	1BONcnKJBWdwlNCe/bE47ja/gwnAnxPISiWHM3uRRhJrIdqyYvMWCkFuV9hpAA7x
	vV7YnI2mK7MPzoYT4mLWz6H3GSts4Bpbh/Tg3GT5nmgzqMk+I1x0T+cnqcL6sfA8
	7yqrGFE9TZrwxBJ2EFdaUqRAUnCmq4NLCke8ZGOlR6bQ6xGYXUpo+GuWt5KRkw2l
	pWUJ341K4cVDecusc6ON/3zAL3b9Bx1Jdqtv79ZKkZg/99jqWUz7i6GRnMBEEAHJ
	5yHxFo3fDS73a/ICUryzG5cjLfuC2tLpt07xnoXESF5X39KO60kI2PLgEpg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf75bn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 09:17:15 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-137f3041088so402958c88.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780910234; x=1781515034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGbKRVpcAfBzmwnC0CIk+WS2eHsVaNTyn9isA5S6dME=;
        b=BF2cIrQiuqKKMM2PijhlhbGH98wITK/xAxWdU0nidWTq4dICHLys0xLMpzineqbv1m
         aa41ol4l6IGfAs9Q1VkhLkG6tU8DWyPKeWb4rYOVESwBBZOwXfgKvKFFE+jZ1tRFqy/9
         6dY+ajBm+vu7hWLidxPOTKT1HNLqjvGtnfYfg0YqqGRS3ZNpz9GDnlvZg0qD50R38WpN
         NaOw9jJIyj2TvuQRoFE2uALHnt0qeFZjeohcwfwRIZALTRWzEPoREZJPYF5Aj9WPTL2z
         oqlq1TQq4rqV6zBy57Jy5oXT47F5dAJ0xiOiKtX838cxBWOHjkbyBiESwaJpg6vmnL/Y
         +HLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780910234; x=1781515034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cGbKRVpcAfBzmwnC0CIk+WS2eHsVaNTyn9isA5S6dME=;
        b=YB2L/MmgEGHD64DP0Yg5uwlV6HOmcwhX5YJ+LZU9HE1RqdV/ID6sxMWhrsHGMZRoWp
         7rhQhWQsQCWvE58Z4+evWhQEMxUhn1+oDmNeKck363oythLJgL6xSCguYbYmM3l9c2SJ
         B/ORVek1gqmrYBZuEPxnAr+4JuLP+nl+FSkgZ4kAk3Qs9X2ddmaa5+d9jsUPLBRcXVAx
         vKst3RISlfCrI9t3498qNGWxCDtUINvlWqrMs2sT/Ey7laKGG0+X0innxGF3Wyr82CXi
         5ndhuibimJHZmJh3USVyysHwBa/e1HvjfglLCXISjU4sfPKzdycF/Bll+NVL8wKmvay9
         41rw==
X-Forwarded-Encrypted: i=1; AFNElJ+WsNj/suMDJYGuGXMtz/bKF+bp18E2K08ggZQJ01Gdf0/0U2Lo1u5hzEljJT+LJg4CYxLPQo3+dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/KIsrJXyuoqDKnE4jxTnaMOVyk1RgmtT+vnbA+rbeDlgN/ZqP
	3yOG37mZLWIOZGfbFyQmUcZhlzSQ5rKiZCvMSprJLQOUYAOYODWGAuHhO3xoPKOk3jm3f8cdWVs
	lvy3b2e2yStj2dVtlX6Gb1S04AzjcmC/T9+CMKovIXBltBrZXGOCm1eYRQIUNrQ==
X-Gm-Gg: Acq92OHHjsFfKwWAW7esTFhippYff2v7yscLSZU5aPQouWYygIh/L1Oj+giraAq6SmE
	iyyoAkjFaCz5h434lobZZi+a0CR+XwPTu2SrdwOa/V8hpJxNsr56pj7T/kUSKYHVFpUBctkQvvh
	RgSFsjKXkiDYL2B3rxtpfBaSGaRaw608RNlw4H0hz/2M6VlJg+rFdlXjO8wU/fRooiZC1M14fyv
	aYI64WBxAVFzwhxRdnqu2v/K/v4ol8Xt43Row9wgT1VKbDnZXiNY28hVM1hioRC8xhyXuyEFYv2
	0LskstbBdAucOkoRObus2xPndNsC/87oQGWAIBE+w/uFvjGKmBBl/QaiTmGH47y7ZACr0stYWLj
	eQ+CY6Wl7ctwD3NPJm3YCaSjm1sWIhqrUw53oNjtLyevO3lTiqOwUllMJpvBRgEklFYg3GC5x7e
	ZoEncu0ME=
X-Received: by 2002:a05:7022:fa05:b0:137:d966:d890 with SMTP id a92af1059eb24-138067af64amr3099101c88.7.1780910234066;
        Mon, 08 Jun 2026 02:17:14 -0700 (PDT)
X-Received: by 2002:a05:7022:fa05:b0:137:d966:d890 with SMTP id a92af1059eb24-138067af64amr3099082c88.7.1780910233547;
        Mon, 08 Jun 2026 02:17:13 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5550bcdsm12178656c88.14.2026.06.08.02.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:17:13 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: [PATCH 1/2] power: sequencing: pcie-m2: Add PCI ID 0x1103 for WCN6855 Bluetooth
Date: Mon,  8 Jun 2026 14:47:01 +0530
Message-Id: <20260608091702.3797437-2-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com>
References: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a26889b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=ohc_vuBGHJ6k7NFuzkMA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: U8_yuXzpnyTHjuAN1OkA-P9Dxs2cNuIP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NSBTYWx0ZWRfX1BUnkpC3zFH1
 7i3t3UbRMKBcc0kZJqFF0vvXC+EjV6AFlccJ+pX87qPfyH2yxr2OLC6D0EX98tahkmG2oenF4Bn
 Odj13fzQxcaapbdWYFNI2avocjE8emkZzUoQMbzT27m9mGquUiKF4RZA1WAhHEr3nFooZVk4NFJ
 /BumaLaeillv49uj3ckkXbzy28WMM1Rhvb4B5Amacvt/5PtwvWEWawWyw/1S/MaQ13nTvoFI8DB
 ZIuZLZ/ysFlB+ps5+ryu1HNJ61AtClQN4ZGNbooZWTXeQUvw/IJkSEikkrHz0Y0XkCsVS+ePMMX
 om99lp3gWUB01NGSyNZLJ1BRT3+TFNkTTYZIiq+h7UORQetHeC6bpJ5gRatZ6m2Cw45R09oBR6p
 Um2vTgUlt1sDybbUoRVIPrPF/TxstgDNsSZlirTh8yWYjMDndwzj7cgmFK8KLEUi3mS77xHqFhI
 ff7HtutwDT3B+LMCzLA==
X-Proofpoint-GUID: U8_yuXzpnyTHjuAN1OkA-P9Dxs2cNuIP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080085

WCN6855 is a Qualcomm Wi-Fi/BT combo chip that uses PCI device ID
0x1103. Add it to pwrseq_m2_pci_ids[] alongside the existing 0x1107
(WCN7850) entry, so that the pwrseq-pcie-m2 driver creates a Bluetooth
serdev device for WCN6855 cards inserted into PCIe M.2 Key E connectors.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index efeb25ba9c79..b3af14464314 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -188,6 +188,8 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
+	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
 	{ } /* Sentinel */
 };
 
-- 
2.34.1

