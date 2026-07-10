Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6C3FFAC0
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677474; cv=none; b=Q3l/82UYQk5dI4KwbQqyL2pCtwDamBz/5+O3LaObvNDRIGIT8uIakwtl+fEkNU6gc6Nu0G/g46gGg5lPyl/KpzfZB1QxA6G5FGWIUpzoJsfQKxibN8jGX3J4Zx+bniSqzB1q+uUvLQEJAVy9WVsmbSOrgFdRK6XAoAewv2rvBYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677474; c=relaxed/simple;
	bh=3pbAc12Jj3zIRz8oWGZPCYd6KNJWtOhdSqNPzVF1EiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lOpLHhHxIYJq6jPHXHOXcdazn8A2EHV1POre+C/b+b8Evn0X2jogp5/T2DPsAja0tpKgpFJmB5XFdHTdmlk/2ORWQVIcfAT1ek5hpLLGawYzFvLx6cu1ct+Dwvy1G3EZ5qeg1KtqkHZUJbvnF51+wVaKrwO69tXcnDGV3Fqh4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pg88vCAz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A/5cUMev; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pg88vCAz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A/5cUMev"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7deoG235796
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n7NkL9sW/e578DxWIXV/0BLe24fAF1y1jIyxSoVkA6c=; b=Pg88vCAzPx8z+khj
	GxO7gSx9tGdtK6F29YnF2D1jkJygeRL/iIsIzLLBUvhYINZrs41F4kun2GPF+qyn
	4zE/9vUBLssjPdV1sY7jCNf0Y/xOuwXC6lEZHi+LnuNExDBb41GCAUyWWX83ZtIC
	dvzwfz7B7LSW/kXpFTmSH0OwAnwW7iYemmVy5+gbWzWOy0Nw/V8rhHshg7IIRdnm
	1kpa6+BjIkBu+9YaePq5+xeqmtkteXAzLw7vw/zx04Hv5XU+xhGzSNpYJtpKtG/w
	HcIMPenZLSg4CCPzHuECGJlBCvbIp7RLlz1ZW9HdcPmzYvgLW9QKKLVkBVXt/07g
	9KxdYQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3kwsb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e7ee64b25so91689385a.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 02:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677466; x=1784282266; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n7NkL9sW/e578DxWIXV/0BLe24fAF1y1jIyxSoVkA6c=;
        b=A/5cUMevjc2JZp06iCboiLZzNvcgT69m0pTsN3poes1nzooGTe73MN/tnZMAXTjYas
         JG8H7t/K40/AYLnQoTmOj3KGXnCWZIEwpZ6KPCSF6Dk0f0viS+Co8JUlHa2AP8YLEbdK
         l61Yh4gfNmYoyyPAmvyWIwqs7P4CXnhAs2382c8NLS27UdInTKLu1QENJWU68BAliUPK
         a2aJ5Z2KYlYYHZ9mSk0mMx6o5fRjiFyXstSkIhmcreNZ1SzcV3p+uwZKRfz90T18NYBq
         pD1Px4l650Yc/rcOFdLaf/xrt/R+xWydd9oKLTBBo0aruAfU0OCaLDBJyMqBOsmAapcS
         JSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677466; x=1784282266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n7NkL9sW/e578DxWIXV/0BLe24fAF1y1jIyxSoVkA6c=;
        b=Syh83L3GxQBJjfdhvAxATl2eDNyCM2+/FMOeY5hv87eyX3NDSzGGoaRLMy5eV/c4TM
         GXCMmH7lYXpVdmKhICJ6C8QhlhfCVSLAkDCwQjxgKbLgFyjEH9xeMFekyYcg3qm7Mh3a
         HYqK3CI+YzhAWUqCWZNI0o5/8kfqyYwfE+Fv5rbAIuJZCxabEK7pGwjmfPHIgyegQWsl
         rRIdsMtNPzh8Z8M1le2J2TWWp11EgUc7cohJq0l2kDjnTiEjyNK7xbDIkdR9HaeBNH0i
         Qlbq8+2k4kgsQaw0EylCwodNZnK1StbXzmAJnklX4RA80fB8LgPiNYyTp4wBwTH5j7ty
         lvXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqk0eCmX5qPIzpd2ehWFhquCy/iWaa8rS0uFqGzGY31htLhsEpzvtALlWkwSloqwnUy/QqffCCvHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeG1X8h+Gp9dco0ZKSu3Vh24kUnJcLdyGx7wCBN+g+E8LsYCQ5
	Ss9GI+bQbtzwvaHdSdAfHnkpoa+emDaUTeURM5/+UogcjpjsuHAKlSkxlqUmzmTpv9GCHxGGNEf
	gHt9FY2gyj3F7otvHIjFynxShYu7tpHWumgNXnt7b2rxEltVHRXO0JZyOLfLwWw==
X-Gm-Gg: AfdE7cl2D/nkdGdsHCHuu8EpcWvGw+DYNe19FYQ37eatkKgeykLA54byEI+QHfPVf4j
	1cNHwdMn2estSWEka/JqJXUoFZSKKNA7cy3y91MWcRU8vEg8MUewHauT2+fQUuL3hyfzQXldR9c
	od3mShew2AwQSINzQQyADrqImOuAAcDD9gkJ4gN9mw/TOn1luhAQvvwXy2DVIEErtMroZ1gnq3y
	NK+BizuPekemQ0wZXBhfDb3cYpqhSw5MZqOxR/AaJHcybh5uyffZeCR3RIVvfb5xiBqD0nJS/xy
	MuDO1JX+vId0G+PbC+j2zRXYgXiNyKxkvbodb5HLFXeDbJAWW8r2CBM2zRWPTDwTBGgJINbT9zV
	p7XSpfyOphsUqqvgEEPsXuz1TKe80wSRJuyNODByelTbNoKhApTUZyIAPZUs9s2JCd+aI3z5F0r
	2ASHtnfcPAJ75P2CuGTI7JRa1BEKHOzJlb1YHmrsmOFy6jFtQxn9ufz98ldM+7+8B9/cBRDBS4I
	izBWMJ2vUipOKp+dXg5
X-Received: by 2002:ac8:5fcd:0:b0:51c:1568:3a53 with SMTP id d75a77b69052e-51c8b39902fmr117003051cf.16.1783677466352;
        Fri, 10 Jul 2026 02:57:46 -0700 (PDT)
X-Received: by 2002:ac8:5fcd:0:b0:51c:1568:3a53 with SMTP id d75a77b69052e-51c8b39902fmr117002821cf.16.1783677465981;
        Fri, 10 Jul 2026 02:57:45 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:45 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:34 +0200
Subject: [PATCH v3 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-8-46253587af64@oss.qualcomm.com>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
In-Reply-To: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX1jewozb+Yapd
 xYz16JhzFkVTfncZev83mucrmVGLuNONUMLKnkZElN+y1PlpdIoD6IgoXVRXahP98Vu3DSYf2R9
 WilNkyRW1T1d4Y/eIv8pTWyYDk/xHYkam+tD5VL0AGKa0mdsKKqdSBKWp3Lope4PNCfWc0wNgAM
 ovH5/mvhlqx989CaNsPHMH3nl4sy4GNfxNUBB16z3LOrZfkaz7NjRQ4eoQIfeY+FCWNZ7Q9pQqM
 LCiMwmSwSB1s7p2kMrIJVoHjsrMDwgiaWqxuiL7mGPc8pkHEEWOe4Qy2TG1SqZ/dLWRA+IAKuKb
 IbNVyRoctXkXd5dzew0EDES9t/P4kgBiFULFopMbk01NdSgx5e5iSx9x2tguan5RfIYX0LV/mhd
 nskRFNv3/UBUjThZ/fd5pEb8BepXWoovirSCsroq7F2uxmnRSpl7ePTtSEH8t/P0d75FCLTEjEb
 GwRiVNCJron1w2y5N/Q==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a50c21b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CW3gqymaXyTMcD2nhgsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX+MPBaSVjH4SH
 snw5ZIidCcMv0XiekYACoYwsCVQrA3LB1cxqrNhJ8jNqI9x7Rs2JTVd+JvTucQqEfefbAMqQV/O
 J7vG0n16rX2XnVXZk57Ec8uCyclluRI=
X-Proofpoint-GUID: vV38Qi0Qo1vyhxw92OX76ttZwPOFSseO
X-Proofpoint-ORIG-GUID: vV38Qi0Qo1vyhxw92OX76ttZwPOFSseO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
rather than a dedicated BT enable GPIO.

When the serdev controller has an OF graph (indicating it is connected to
an M.2 connector), acquire the 'uart' pwrseq target from the connector's
power sequencer and use it to control BT power instead of the bt-enable
GPIO. This is factored out into qca_serdev_get_m2_pwrseq().

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 24dc5bf6d192be7e1d500df6bdf36e6184f9eaf7..f6529d359ffbd97f8a3c4c0593680ab200215b36 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
 			/* Controller needs time to bootup. */
 			msleep(150);
 		}
+
+		if (qcadev->bt_power.pwrseq)
+			pwrseq_power_on(qcadev->bt_power.pwrseq);
 	}
 
 	clear_bit(QCA_BT_OFF, &qca->flags);
@@ -2387,6 +2390,20 @@ static int qca_init_regulators(struct qca_power *qca,
 	return 0;
 }
 
+static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
+{
+	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
+
+	if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
+		return 0;
+
+	qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
+	if (IS_ERR(qcadev->bt_power.pwrseq))
+		return PTR_ERR(qcadev->bt_power.pwrseq);
+
+	return 0;
+}
+
 static int qca_serdev_probe(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev;
@@ -2417,6 +2434,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	else
 		qcadev->btsoc_type = QCA_ROME;
 
+	err = qca_serdev_get_m2_pwrseq(qcadev);
+	if (err)
+		return err;
+
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
 	case QCA_WCN3988:
@@ -2426,17 +2447,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		/*
-		 * OF graph link is only present for BT devices attached through
-		 * the M.2 Key E connector.
-		 */
-		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
-			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
-								  "uart");
-			if (IS_ERR(qcadev->bt_power.pwrseq))
-				return PTR_ERR(qcadev->bt_power.pwrseq);
+		/* M.2 connector modules are powered by the pwrseq acquired above. */
+		if (qcadev->bt_power.pwrseq)
 			break;
-		}
 
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
@@ -2528,7 +2541,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->susclk);
 		}
 	}
-	
+
 	if (qcadev->bt_power.pwrseq) {
 		bt_en_available = pwrseq_power_is_controllable(qcadev->bt_power.pwrseq);
 		if (!bt_en_available) {

-- 
2.34.1

