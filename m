Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691673C5DB6
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989197; cv=none; b=EDFSJ5D1/4Ysg1dqsbQM2H6f0fnr+VXQwS3Qzg04QQq4ST/+xeRaVlAw27v6ZmW5IdEG4qvwCzvdWzbzuSc5MOVHsgfAWMfvctA+SsOtqxxfNZTjEs/z+fWMxDBM59AYb2M6j9X4mduB7vosC78IO9Ek6/2hVET+GrUs8+WinKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989197; c=relaxed/simple;
	bh=mh5EHmkfn+Hckeu/ga+6Zfj+PX1LbiyTWZjnRAILnCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sXzm640SZyRLHHXeYZxAkSjw0NJx0rhoBb88m2pEyiRXgNP3u7A89pHF8U4/Dz12/gC/SAWLLEzS9/NjqXyYXJpLm6GZ+xksBD2lZY2ZfC9+Wl0DV1QGlTZ8b88EUeo5UkYdBdKh7KlL27IUp+ho5IkUrzK9NExuLD7X53wqOPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k5FpqsZJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KEfb8a+O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k5FpqsZJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KEfb8a+O"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629Kn0l4116732
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 10:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WzcL6bqjKCQ2yH1CTUP5oKTLu2gCWJgGGyQKXMvuqS0=; b=k5FpqsZJ/ul9VIdn
	MS/ExLfdrIu6kqgYNn79L58nooAp35PFbE2pSFIciwHwN50Xd0HbtCub+OE2k9mM
	2qFE4lAZb2imrPSZs8RdEnnf7CqrU+IvkSlWWM2OVCVIVPIIaBFvvKn2UHlB3mZ/
	YiyuGgqriNu/zKaPHWaYKykSyaCR/6q70El3YyKU2KfnTRSmJkTWKEh5PaPp7G4X
	+atz6T3tEB9TX8YVcabtXEL6fP/vK50px4OmWNecr+YA8SFtZH3sWlkl5xOCdJ33
	PVvF3F/ZZLECVAZir16LM6rqDw5zBmxOjge3VviZiraH/HdrWdne1MiAfAHDRQl0
	2rSg9w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bgagb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 10:46:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92d1cae5939so209508485a.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 03:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989194; x=1783593994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzcL6bqjKCQ2yH1CTUP5oKTLu2gCWJgGGyQKXMvuqS0=;
        b=KEfb8a+OoAeh4QyoGcHyrZ1/wrPYax1n4qq8mjJRlfxpdjW1ZXkvFGjVyatoKbL2UF
         wary64vlG/oU2OIUrDK+ltbpj1gyCyMwqlcAJlqt7rOBef5uU7UDUY3jdOIxVZDBoniR
         4dUDIjvGxiamjtMFg5WkWXIuaDAcrZVVORQSlE53B/BcA7l95NBJ0/CSrFQaWtOFu0Eq
         cV9f+RxCxBWM7JNrgPDXty+IYueA7IfhWgyApcNAUVWsaYqQClK+xUKfy2n0ftpd0dmn
         GUeic7WSMMXOvv0OYlcwAKfWEhr07wZc2Yp0A4AjT1gQAjcUv9V1rQcBX9ALOYH63rSO
         DyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989194; x=1783593994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WzcL6bqjKCQ2yH1CTUP5oKTLu2gCWJgGGyQKXMvuqS0=;
        b=TYZghMoxkGXI5AGM/liXNe6dghQJu9QCqYqK/ZgpmQZuY5qyZw1jbiahP5tKJYREuj
         HMKSkmb/r6ZnUHAaJyyBtNsxxjwzs6EIKsrz5yopUMH1UvoLfyW/+EdaEH4NElaTWGKe
         NBNiu7QMCJYQtqW+7y1WZ2GynBhGC6nLsy/jFo53Gsttf0FHEEQB/SttNutCDxcngAGu
         vSAT+fxvtbL/W2ooJrOEJ+9Yy2bHCs5zQI1MjfLDbs+yI3fiVjfMy4Z/e7B8E8Dw4JK6
         bife6lE7siB+IdnkBZQ8UtO1B1BIpLis+bRrsq0YOGIBebNlDL+bIK7bKrLEsQLomUC0
         nLZg==
X-Forwarded-Encrypted: i=1; AFNElJ9tcE86VMUcAcemfWBO1GQ5Pwouvdywy6jcFKmmOp77aRNcVgtnMNNT7fLlu6qD8styXCBtY5YYew==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhc6ocNXtcLGoZKyiFh4XEMD+ghHzXFoXqRDqa4YhByVDS60cN
	0mL302UKRdoPFz/1aOukUV010I2YNDhKXcvTm893xoyy47FFxni1mtvG7YmlUU5OqVm4CA+9668
	9rv9ieuCh8xMje5ajT5iUYxI3XZMb4YLns/N12bgchiN7eGAIiY8DDFVDU7lxDg==
X-Gm-Gg: AfdE7clYG3Rok0kIvcLFyzH58BXUbcNUrinfaofmLeVHsip0otuWn1+yfFBimWFPMlj
	+CW0igYNUmQw7iTy8323jGuwy7A0XeqwP3qk3d2jJrhyQvndyAmD03GFEcqX43oU9KGjSbrmTY0
	l/fxlT2AasyzY9NmBkjQF/cYkQhLx/nyaxyPK3RxMzGEQo8s6Hb0oCfYoxTSgfFcaykk0C1kyeW
	NU72wfNhpL7pNLkbCh16bztUMu/Hzxs/JcZkXO1+KPS+7U+T2nRJjjDruihHs6jvjCsa7lVxsbJ
	vm5mn0nEGWljGM3C5Velyol9nKCa/eaMS57BVXpaXEO8HQFM/IwVpPTLC6968xx5gV+5+lDFlI5
	PFEFD/Ay0Zgf2WanxT6LMpwiyYZ7bDo0idB4JmNG5YBtEtQVdQwkt+dOwAFKmcik5VaIDAqfm1w
	RLNhqxOlk5cc4trFOaBwsxXFtK1iPqasxHS8kkFOeQGcIOjwxOhhol/Un6VbVaYBU=
X-Received: by 2002:a05:620a:284c:b0:92a:f65e:1e95 with SMTP id af79cd13be357-92e7825b261mr707541985a.21.1782989193436;
        Thu, 02 Jul 2026 03:46:33 -0700 (PDT)
X-Received: by 2002:a05:620a:284c:b0:92a:f65e:1e95 with SMTP id af79cd13be357-92e7825b261mr707539285a.21.1782989193046;
        Thu, 02 Jul 2026 03:46:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b5ae4959sm109689666b.0.2026.07.02.03.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 03:46:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 12:46:14 +0200
Subject: [PATCH v2 2/4] power: sequencing: pcie-m2: Add QCA2066 (QCNFA765)
 BT serdev ID
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-monza-wireless-v2-2-7b56e2a6a6d4@oss.qualcomm.com>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
In-Reply-To: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: HIhnl_jXnc9AAcIAlOjZin4bVdagj3kk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX0Aht+vF8YHN5
 7twITUI+rd70n8xu0yoGTtedqmCR22GV/NRCisZImcrIOuKRp9CLj246dgc2oGyrfsxG5FKSljC
 7bz33pC4nyBBkWMDRvuzxJrpkm5/CoA=
X-Proofpoint-GUID: HIhnl_jXnc9AAcIAlOjZin4bVdagj3kk
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a46418a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hhiJJhbhXc7jC-Wm4KYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX6K8luvpiYgtS
 M6jQ4AArhYOLMXlSwVs+EDKDmsCGtUpxo5uyVw1q/fpuuL5TYVZ63HlVpa4cZ7fbAZ4KcqCqsiW
 H7n6RQ2iD6uF4GK/qpM+qUm/xcB765eZS6zX/5ocUb3B2TnCPd8oonj38pzp0myszGR/cJ5kvAS
 XfzbQer+Zach4smNnEopPh95qzI2LbGw3V4TyayHlL80YOP7bIQ8lXtE0gM2bPGXqy02sTm+N62
 MswcQeO99DPYxc2lxwmQzDDxXM3sAIwIvqceoQW4jCPBFYW+UCuyo/fAA0UEFUSqV8AiqytTGbd
 Zlf7UaY5e+ZXUjS5TNF/j7rozyNsEdwaR7/PGlBxJEH3p5QeMK2q3MROmsfutcjiEiA9nC5XbCM
 2QYuJHJA6Aj9PY8W/p4ufH35bed75yDaLfTaMldk7mduxTfUNiJZjnQ1OjvWFATUQbGu1k4umZ9
 foRQnFaCeEbFH2uiEFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020111

Add PCI IDs for Qualcomm QCA2066/QCNFA765 to the M.2 serdev ID table,
mapping it to the qcom,qca2066-bt compatible string.

The Subsystem Vendor ID (SVID) 0x0108 distinguishes the QCA2066 from
the WCN6855.

This allows the pwrseq-pcie-m2 driver to automatically create the
Bluetooth serdev device when a QCA2066-based M.2 card is enumerated.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index e3ba9169144dabbf0c553c0a4302c3b511fcaaa1..7cb455569d8eb5da12e46606d9f25bdaeb8a128c 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -190,6 +190,8 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_PHILIPS, 0x3003),
 	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x0108),
+	  .driver_data = (kernel_ulong_t)"qcom,qca2066-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),

-- 
2.34.1

