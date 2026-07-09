Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9443DE445
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582188; cv=none; b=Y5r2lO1rWOa8GQCc/V3B0NadoMdpqxrUHpRtCqlqsq+zWnMViUd75cknafo96DX4U7k62tCUU7T5jmDthjm5qMOYzNUkcOX+UCMOP0/zI6aRBEZCP23s9i5BsY3Sz8k1XF23huvTR0hnUFsczojWeRCKAbKZetgmBxLaHPzmW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582188; c=relaxed/simple;
	bh=0s1aN4Mi0AzWm/Hayt7uymch60EarJ0VTt156et5w+Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sH6PyqYlyZUYIhKyl1b13lXCkVFaAbbi0VKnnFxl/w7ZcU5evO8MXsnJMM17UxPD6SL4lIsydEuT3+gNEYZD6X/Qx63qaiPpKU5EvVRasrGmS0MUYhLIkeK8kG7on5iz8BLyvAczNEZHfZtomvUYGS2iRQ3u9XWtbJ6NUnj6yy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U8FIlzz4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IBirFVS8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U8FIlzz4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IBirFVS8"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6695xveC710658
	for <linux-pm@vger.kernel.org>; Thu, 9 Jul 2026 07:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=24AQujv9vKySCI+b9FnmRb
	ZgOeazlB7CEm9iOmkIzr8=; b=U8FIlzz4sgYpiaugQKX03IEBhuE4qll7VT927r
	rZAhKIOtfOrWUI4AUf1D1J3BjNBWnT52LHPauV0TwlH+n6IdMQNdKXYI64BDheJD
	pKSecc/fQnK1WKAZBLjpLDS6Kd24hZnM6xbAnYTt3fjXxFs14p0FA181+khZMWfU
	wFglt5uuLm0gW4fK4c8Q45yWbJRHgw3STCnW7fWahPKaN5dMlrOZiMmazTllc75P
	G8RCrTmQ5sUIrtkzGAqPCLjZ/KzkDmF9HeWxXNqu3yIgXb4G6Gohcy9e7qyyCh1w
	66GjMG3bxyX/rtWOevqVlfP20xAAiJbpv83V3NQIgC9vlPug==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa55vghhe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 07:29:45 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84848067b0aso442183b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 00:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783582185; x=1784186985; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=24AQujv9vKySCI+b9FnmRbZgOeazlB7CEm9iOmkIzr8=;
        b=IBirFVS8kt/emi1fH62YQwVJRgtbgs0f8qC+JO4+Ytu7T0M8o8QMwsLmJLvEnYi9k1
         lRZTchggG9XPHW2jp15T3RgH9NFfP4RGDlmGoLoBTi7thgbVAdNUVY3Vvrb6LtNHHTZp
         eJomsXRbeXXci9t8uHWSWQNiNxi2qtUqG7azNyZGLsXu4U+wqL7CqhEII8tTtO3ARUnJ
         bqaMRB4uJG6kLNlX20Ee/GmjhCCThmb2sjBrWNe+szQv6LHE1FoXvS6DD0vadSS8kLFR
         2eXHPsHGg46NR1T7Bq0diYt3OVkYS+OgzugNr+l+p2iDlxPF08LtPxj6jQ8uYaT2bi6o
         OOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783582185; x=1784186985;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=24AQujv9vKySCI+b9FnmRbZgOeazlB7CEm9iOmkIzr8=;
        b=LN58PJBHYnynD7LsF5b5XmM/hvyhigGf7gJaqLT/PUo1rxQLKJpc+dA73FhU7rN3oO
         Gbkvp8esi/3KytPSys47Yxg54n/na+5XxVsriK3yDH8/bF+KPXwk1+qUlpTCH+ADeS2w
         omyZrqaL9hpsxl0bNMb6vIFU4Ris9tceHAwzY5VK4PG5MHAwmOOyRN3+ROIHg2A272Y4
         Cu6fn09mc/y9GZSVsBlguDyE87SEreL4gc3CcbqbVGLTcqP0XKPnwE7t33LcRLQnJ4Kf
         DrywRGkzyLfHEfqBsceHRmaOPqJ2ZdeiPNAJOUObmQM9B6JDLpi4H5QdUyJBavIJir99
         +QQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0Iro29trZWG2n0QalZWyoTrI3u8lZOSY7jwSAikPmavegbijEt6NnYR06FSd1G/rOWeQQ+t1XRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzddPrzOYZNNSAQpqIvRkPdjyUPnDviUUHLs5SttB8Syi2+n6Gu
	c/8BxQglbyKpe64Aq1KFPktvyKa+WdnvLwpcsCUWa9B7hS5MHLVqdbwjaijKuwYC23wNFiHIEJr
	GHOqCn4+pPa5dgg28m9rvWasj8iiRokpPIEacesNl+xhY/dXgdxwdD8C4RKSpuQ==
X-Gm-Gg: AfdE7ckCI6DB8ad4Lx7LCvI9VLXYOaOZDIW4u2RbA856uM//QEZptVv/hA5ItFBJMRv
	izL/rpTJwBj2M3CLuKuTY8U25iDKyKNLGkLkAfRohRe2D1FRWs6uMhg3V2PO21xtTnvqKyJ6I+l
	sWdgYWqDkd3CdF/YswQBR1yYlnEKNfoTFNEJbBhGAnIGzrC7nedugNQiVT6MMZ5byZnELW4mfxC
	EBkoMIRW1iyECKxfU1jcaby4qBwgNluzePGutca07JA6tfHKG3RDqyljt4Lo8VvAT8TWxiVzwfL
	ec7rvbmREHcqIBzJ+/7r3BlI3Eg7LyIfx9CZSy3hYxiawN2PS8jro4MPOF7CINiRCBd42jurPKG
	3JeGtKRNFIYs/mb4EiIN50N38rJvm3hh4uAxf0yBrfgslMq47M/TtxcjZI7iDaQ==
X-Received: by 2002:a05:6a00:a0c:b0:845:ec35:6d7f with SMTP id d2e1a72fcca58-84855fd49b0mr1758077b3a.4.1783582185328;
        Thu, 09 Jul 2026 00:29:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:a0c:b0:845:ec35:6d7f with SMTP id d2e1a72fcca58-84855fd49b0mr1758050b3a.4.1783582184905;
        Thu, 09 Jul 2026 00:29:44 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d44d53sm8167222b3a.38.2026.07.09.00.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:29:44 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
Subject: [PATCH 0/3] power: sequencing: pcie-m2: Enable USB/UART BT
 coexistence on Hamoa EVK
Date: Thu, 09 Jul 2026 12:59:39 +0530
Message-Id: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAONNT2oC/x2M2wpAUBAAf0X7bGtt2PgVeThYbLl1TqHk3508T
 s3MA0G9aYA6ecDracH2LUKWJtDPbpsUbYgMTFySUIWj3Ti7dXe4Ml44WHDdoow0qkhBwr3kEOv
 Da1T/c9O+7wdPMdSdaQAAAA==
X-Change-ID: 20260709-fix-hamoa-m2-w-disable2-0fe775072c74
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>,
        mengshi.wu@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2OSBTYWx0ZWRfX4gul+FizNQjN
 Y54qIHLHUGT96lvDym5ov0zHtASFQAVg5H/9dPLfXVsSJrfMDjtBTULy/XibWll36UXKth8tMCp
 eWxvhV9gSIN25xZG1+LyHmH/6AkNNPDiaQz+g+oegcUxlPxujlxQ2Xg5HZWR0zgOiKKhpw0tsJG
 li7eQLkmhO0VxtmzBtwZVI381kRQzYrE9LcPamu9B+g77mGPCJnHrHoZBBsC5YPsKbxFRkxr7A1
 M0IFmwT0dx1Lr0FN4+yc6FdAHbOStCtMswzJ8tuGO2YDiD+ZNSyXeN36+lQnnKr7bkjmoSBmMz0
 FZhnRAuxMpeZByPQkrLIBts8ridI8G49sIY3sO3Bdn9n5NEKnFLzMYB26n9syUO6YyKcBOYhVsI
 DBI3hZIudPdii50GOYaPUL7SV96j45Qz0DhLejO5nhjDtSJ3ZeDuLqhI9sDJllXM/atdr+nt9JY
 Pc2eBM0ixrVXeMbkEwg==
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a4f4dea cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=H5-0xJHwKRPjY1VIS5sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2OSBTYWx0ZWRfX7dbN0h2ooC4i
 GHiQTHBMOTOzhVYbhAaQMUAi3UiqI2fyZaOreqRKZSkPIB2GPyfWzm2+Rawu2yq0PRmKkKZKogm
 DefX1Z5qcJrcH6xudemkR0BqZ4vligU=
X-Proofpoint-ORIG-GUID: JNtXJARNXWgZhL6ZD2gwGYPco6N0Z6JI
X-Proofpoint-GUID: JNtXJARNXWgZhL6ZD2gwGYPco6N0Z6JI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090069

M.2 combo chips expose Wi-Fi over PCIe and Bluetooth over either UART
or USB, depending on the card variant. Both variants share the same PCIe
device ID but use different sub-system IDs. The current driver uses bare
PCI_DEVICE() matches that cover all sub-system IDs, so both variants
trigger UART serdev creation — wrong for USB-only BT cards.

This series fixes USB/UART BT coexistence by:

1. Narrowing WCN6855 and WCN7851 table entries to UART-only sub-system
   IDs so USB variants no longer trigger UART serdev creation.

2. Deasserting W_DISABLE2# for any PCIe device detected under the
   connector that does not match a UART BT entry, allowing the BT
   subsystem to power up and the USB BT interface to enumerate.

3. Describing the PCIe M.2 Key E connector on the Hamoa IoT EVK,
   adding w-disable2-gpios for software control of W_DISABLE2#.

Validated on Hamoa IoT EVK (IQ-X7181-EVK) with multiple M.2 cards:
UART BT (WCN6855, WCN7851, QCC2072) and USB BT (WCN6855, WCN7851)
all work correctly.

Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
Wei Deng (3):
      arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe M.2 Key E connector
      power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID
      power: sequencing: pcie-m2: Deassert W_DISABLE2# when no UART serdev is created

 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 129 ++++++++++-------------------
 arch/arm64/boot/dts/qcom/hamoa.dtsi        |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c  |  39 ++++++---
 3 files changed, 74 insertions(+), 95 deletions(-)
---
base-commit: b9810cd75b9fb56a3425d391cba3f608502bd474
change-id: 20260709-fix-hamoa-m2-w-disable2-0fe775072c74

Best regards,
-- 
Wei Deng <wei.deng@oss.qualcomm.com>

