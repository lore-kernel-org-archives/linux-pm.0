Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD27380FF0
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218738; cv=none; b=WG9n8jxYiKvWrh2qIN+ArlgP/9GVao+4uub/qbiikuK1wt0EpAknlg7dr9QvGYDwuJ5BYxGl8ozrK11tkcK+qmcPuVQ3Z6ji2cuiXvparNhNFWz2cTTGqAqk3XTeuXjbhI2XMpvrkiiEAH8CCCTAJPx7eRtf0qBCZHPKu74P2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218738; c=relaxed/simple;
	bh=Zf1cAa5b0bNP3c/K70OfmcZ/HBkFtBvo/OVNOd6Dz4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ODtw6zqbNJ/dOnm0eSYviqLjbqLp6DEVvxNJq8V9PFus+o9C/QZtWuV0wv2r9EpQAolA79gQw+QqZjcKZbXSVVAa2wk4EtT71pTVsJ+z5+JjK4Y9y3by3UkMqkKqI6NRg6U66CVqVTAXikFGnzEQHiaobaRsLi8tdM5RDeTTjdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iMPASNCl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MLs1F5sA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iMPASNCl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MLs1F5sA"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJdZT3988095
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+v6DYK+7R/PwBLwFZrKIBzxEvo+v4Yk8qTFPX7MFv5k=; b=iMPASNClIiwnBUs9
	TLeukO+yIb2e0ANhVibK7//YIYfas5syQgkyc7wnsJQIoTvpZuYEOeHWBJu5VeY6
	9yogaFGiAWNTzGIMIIezHR11yGsQeL0YgmV4H5AEiZSn0xPzwCfpa79pEc8vxDOm
	UM3B3mozqhtGxFH4trB9B/GYLX3AfqAbkhH274guXhQi1qBlML7CKztgKSocX+Tx
	Xp0bgnLDMnNLUKU0fuwGkEALmg3qiE9mew3+NbFjyghRnqQHK7CYzyuV0sndEKxg
	Xlp7gXtKJteK8Kbso8RPx1ZJBUev+l3SIc9ZjDrxmrrv/gmkWqj2tRSlZrx2DyHD
	2P85SQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feq3pk73m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:50 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c21c01cf3so67937461cf.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218730; x=1784823530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+v6DYK+7R/PwBLwFZrKIBzxEvo+v4Yk8qTFPX7MFv5k=;
        b=MLs1F5sAHKcriSWlp/x+WJuWMmih/wkFDJ4cFY2lJhsMFo5oyhrmcmqayG5nFgd8ve
         yr7GCMwpMdlOYsbPEpTsyw0nXc1Cs2EHVvPwDApaJEu/13kEsADCRQ7CS/9cjruc7rhS
         VvHAo54HOG/k6jS2Y3CL4SgymZ4+pLfSo2UrzKZZQzu7D+Ylyjnd4pGetKpOJ0uhpf+E
         hfAIrdeC+fdg2MEx0c1J3iQA9PKt8WDcAQj5AzTJy5hjOZtc1Nfci0RkLXyVdRL6/y9e
         sSokfaizZlB3l3dAqH2FsvS1HSEeRIsN3hl2Y44qGjzxI1iLfTRvXp7YuS7cR0pL/POQ
         HiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218730; x=1784823530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+v6DYK+7R/PwBLwFZrKIBzxEvo+v4Yk8qTFPX7MFv5k=;
        b=gOY500xV4qULdiXQNY1OACsfiCVNoW0Y8K05aPTZCFVDVCWNac9hrqJEm0/isv9FvT
         52nXwH+wMXxhoXiwSgnWWNZ+BUh6Gd6Y+G46Gn5JsTehx1t5k4s2r9/V2JZRD2iCYJeC
         4jWz5DYaHQzvzA3aV40AFGWap0TMdZoTTQSeibiE8n+UaRH22SSnpR8BGC00BVHCm2Kq
         LUX163TWr9h73Drf1aV8Sg1P8KPi872jHmBYVi7zqe4+xwRsLaA1XZFOyynwFnOgfNQN
         /qFAMeh8VKk9fHhy0sFFWh09WBa1pcertqrjoK+u+FASCNPz6sBBEpoMYkFkjnp+7Uns
         wmVA==
X-Forwarded-Encrypted: i=1; AHgh+Rr0IMe2KcL3w+fTF7X6a9dBEA+2JOnb+QwSd0v24A6yTWeSnPb6EuW290Bbnxf48ZzdQhFKuDiWWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJBW/n9vqMmY3ZoTwmlJpef9Rk+O/L+aedcb/9bCMiTHOKpkQ2
	F8jMiOmTf4jnYeltdrXIP8K7M/nEe1IZC+EvqTBCEQsNGJM+AGFJt1ENfFWCrperl9j5kw+VyIt
	OwTlneLdLHZq+vfsE3e6xIlsGxkPQbQgPRJrQcfDQ9q3ReHuTN2fdEGYGMLN2Cw==
X-Gm-Gg: AfdE7cnFo0+K5GAXYF6/eo2l5K7NgPAf4R3ooW8KwquKgadRUT5x3iitmhc9GmW7nAL
	TbF04xcjiNQX3WcxyvZndFdyu5iFfbKZ+gFv84cIosvIittV0slO3vSmTe4+tcTW6ZyL6DixcKd
	Dejvk59z11dqk8/KpBWfQMdhj3CBN8mhBrpMxfpwbaW6D1Adir3mBKCbFz1d9M6IzdRxm2G30IM
	uFOpYGdVWJ56r6Swx7i5wRQf/TK3sS3pjkeQZiZ+kpAQUDtcrMwktgJ8WqFQoqXkc2siQlOd/e/
	oJfvPDxSd1kqRuPFTFTeh65+7uv9++15+QzN7EDYv4gQOsJh3aeDA4v+SjAxY6+vDjvIOmNJ5VZ
	LbKydf39hklzjwJFtsCgDJ/l17CnI3QjVImuTRw+L2Q+zn9rKlIY5J8khCEqoj+0EOOdLode80x
	I/0McIe2wLHmMs6XL1iMZCqp1h4AXVnoseqEUxrMVbIRx4Mkzd44w=
X-Received: by 2002:a05:622a:408:b0:51c:7b12:120b with SMTP id d75a77b69052e-520bf276cf2mr2129921cf.73.1784218729387;
        Thu, 16 Jul 2026 09:18:49 -0700 (PDT)
X-Received: by 2002:a05:622a:408:b0:51c:7b12:120b with SMTP id d75a77b69052e-520bf276cf2mr2129611cf.73.1784218728955;
        Thu, 16 Jul 2026 09:18:48 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:48 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:27 +0200
Subject: [PATCH v4 10/11] power: sequencing: pcie-m2: Add QCA2066
 (QCNFA765) BT serdev ID
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-10-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: noTVZ3YYJ42lRgUWj2MlN_tcHEMktgy6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX9elYNAKctJSA
 ffDz3wi5Pv1YMaovHYrJs74xKkz8uJKY6X+NpgWvHBKrX4vnnuqTVN/n3CBdiNCD6P5NpAze9CW
 Ja3sWYdVKF0yucR0WvNaOZ08iB1vQIM=
X-Proofpoint-GUID: noTVZ3YYJ42lRgUWj2MlN_tcHEMktgy6
X-Authority-Analysis: v=2.4 cv=PN8/P/qC c=1 sm=1 tr=0 ts=6a59046a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hhiJJhbhXc7jC-Wm4KYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX7m9EqIf1PSDk
 MzsBbo+CXlteNUhCf+6o9iDOG7hlxG/iOly90AGUnJK8f+QV+Kq8y50wpWaE7+RZeiTqu8qDVqr
 ryjJ/sL+1MI0a+wlgWM3avU7sRTM690gathEEHzFXUIlyQiALbjnHyhqCZiSxHFY/1xaAlL/l4B
 n5jGOyqKemVJfEENeS/dJqLl5XISl54SECFEI+JxCkRzi0SdjOM5r0Z2MLB5yhb2Y5hXzE36n/w
 ZDp1Nli622/HJnvydo+qQQdUNYMZOF5gyrblRM2oXuGYy6J1lHmw7tHD5cH1stGS+L2PJZQddvb
 DF3xnQuSOev0pZ416mWJXKYWhMilPFffQbFo/GqKx4cVzc+KcT0ysjnjQUgTn4w0JRate1WZiiM
 kY/kIf/6PBnbPK/omQG/YlFc/F7sifoXaSn6PHzixmLow11BfaFuaqGKhPApERmW9Aj41b/zXfV
 yn2U85nKzRV3aaiTTog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160167

Add PCI IDs for Qualcomm QCA2066/QCNFA765 to the M.2 serdev ID table,
mapping it to the qcom,qca2066-bt compatible string.

The Subsystem Vendor ID (SVID) 0x0108 distinguishes the QCA2066 from
the WCN6855.

This allows the pwrseq-pcie-m2 driver to automatically create the
Bluetooth serdev device when a QCA2066-based M.2 card is enumerated.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 8e4cb778e31f66aa171ad9831d4213e17d2e6145..741bf593d1716d55494cae99d4452600555e53b3 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -216,6 +216,8 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
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

