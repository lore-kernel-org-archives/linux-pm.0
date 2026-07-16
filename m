Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC18337EFE7
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218723; cv=none; b=ql6AKlM+LBJtaHmD7BXhcsJCRZjzeVS21us6jQdpZ7UZvVGQGRWK2EQBLCgMWO4m2rt0xtKZXQyqsS1GL5CH13ePigCPsCzTLVJAE589M0VurKJjergaAPqCq4CLiwoZM8N7F5cXCDhTJUdXP9VqxpVw//LhX5AZwINsox7smik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218723; c=relaxed/simple;
	bh=USfleaUVsPGQXLVUjbre3lqCswipT+fDSdHAw6xnKWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bpPD84EjX0R+rkXuSgSEmrsZKet2JOxvVSvOS4AG3AuM4sm0q/8ZR246oWUvc3WSiICNeX9ISZmXpKNo1Q8G7lqTwBo3VRvzuEpTPCTSIE8gRutwbJSHBm9FGGEcfHdt7R8Bx5noymPK8ZBvCF+OpdcuviIq+zzXTgqv0MnDfF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eF7HNDpK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YC+lqfyR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eF7HNDpK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YC+lqfyR"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJoxW2897728
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CUSdiqJFqg8hwn97+boIemtGgCjGndnT1ZgagmOIPvM=; b=eF7HNDpKPmRuaZx8
	4/5SO3m/WN8rIxWyJyqRFTfL9lRHETXR3kVhlb8C5ztZX8WFv2SBm/TlzxayYyYZ
	TlfMWnXUpU3HZrgPVsdvRLFQUwkU1xFcdnGbXvP/SfM8ZVAolffTKbtAdcpEvNdQ
	vugk7lwawDpVEjYSSZlZhk4vb0OwXs91STcWn/L1NlrFLDUJI3clQdfeQB8rdj1q
	iSQcFURn8OKp8qPFzVBS9JLjcQiefrQttOxtBpoObeSrOZcjYqEuelyiFNZq+AWH
	QY5OmoHodAV6VF3CnnsqjILym/2UpvhfnReqpJjgSPyUnAxp7+4Hi79vSAiS9XSL
	NHhXUQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feve1syrs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bec738909so58677581cf.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218715; x=1784823515; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CUSdiqJFqg8hwn97+boIemtGgCjGndnT1ZgagmOIPvM=;
        b=YC+lqfyRPr+1/ocKvubWH+dlHQnxyk8QyXOFmYpNZQsYLlrMjFl4GEqEYHOaw8HLRj
         Is6v3g1u25bRb2iin5Iy10VpA53F68i2ydF0GA8PNBJDujE6o0YkyKgavciTj2bCH5Vm
         GYARibBAYW5EIFx7GwuGQ2tWOeEY1CGhwqcxvRwAfWarGtkOq9hnmt4QBQSM3ZUgVIt6
         jKF7YT/D8GPyTZEDLjcszL/bM497C46ypNu+V1wE5M4jD2Vs0JBTSI8DJC9zBs+28Fqr
         qtPZ8m4Xe3NhesWFANhyQtyoKwY4gKtmkD7CCf36KVhFudWK6WeUCw+vvO2k1kj33jK1
         7Dlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218715; x=1784823515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUSdiqJFqg8hwn97+boIemtGgCjGndnT1ZgagmOIPvM=;
        b=JxH3V5wWM+YM6mwSNQtcCc29Mgat/Y1KOl39LYF60O67Rto8jaPT89Oq2kkhHr7k9R
         SL/EG2648Zu6CAFEeuYh9Ik+2d/cBeG53FfdaRVaWKVJ2igpfW6G+mCRg7abkdVE0Er/
         v40FbgchZfFr0aOFhbfbhvePv/caWDXMZF92C63s8Ea2ED2h1/LbXfWg4B7bpnjMfA3f
         czfyDYDaQiOW0v7YRv0uFFSJXiAdLy/9waXGA8/PxpwLaX89gJONF7niWPf1pius8FXS
         fE++X3XIyRXyZGitmxQejlULmzJQyVkURzjh92I4uQ6/W456FwyHxwfJ6poGnAt/C2wf
         q/Vg==
X-Forwarded-Encrypted: i=1; AHgh+RoqVl6ULiu9yPXrHk/OAMCF/KofqsQK2dMy+NF6S2yH7j21bMxM8+4/CVkQViLP+AjdmRiD5lv/IQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDdt7/ySDG7lv9vA48i5+Wy9yxtvuvBKsdlvXb3yEu0b6NGBRJ
	QWGqfeNfOe7Eh03AMtYIPAeOAhSInpP/zeC3vK029KMjuqhgOJln225zBEVGfnjTEKnYrHi3n37
	nXQ9BcDKEBYWrmhGt+HXwsSCWLSTzy/Rifz4LcgDpw6kP+q8sh4277wyWDjq06A==
X-Gm-Gg: AfdE7cnaYlOhWAI6dy0vZGZRWx/zVa6IgWH5FKsd/bk0bbdFHTygkczL6TPAkjsCuPa
	1PHHAbDQeeUsdLf5aKqz3mSC4fnqCUWDnImbZZaUBOUnfK2ppo3V2aUEMpsH5GkxymzZDV03Zql
	hAAbsCk3txC8vvQubiPSBC93Ld3w4tSc7MGKGOhWbrRQ9kZctnIm3vScqBUiMFmdsnhf+IFvPJF
	Y43v6g3OSmf9K6TY3ok2AUtgibyyIIN1f8XY8KIxxO2y59thjIaToi5K+CtBdqC8sbfMYh5c+lZ
	NZYtmAA73mcsZsH865DyP9h8cL3vSowyPPvGvN0/5RYSr32wiNsHq7lvk/kBHRjgC1kzbKQyx0K
	WFy32UrHxfqMRKyWdJDo5U0byKcPyHjJOSYKgqGCJLCEeX1TwBOYktAQU1Skpr67S8Xnaxrp3gT
	c1dY4w4DtGfatorS4IZaAlWuRusMhxOG3CYpEqumQK2y0k/rfbevQ=
X-Received: by 2002:a05:622a:190c:b0:51b:fde4:cd4f with SMTP id d75a77b69052e-51e4237cd7bmr114630591cf.30.1784218714888;
        Thu, 16 Jul 2026 09:18:34 -0700 (PDT)
X-Received: by 2002:a05:622a:190c:b0:51b:fde4:cd4f with SMTP id d75a77b69052e-51e4237cd7bmr114630181cf.30.1784218714223;
        Thu, 16 Jul 2026 09:18:34 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:33 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:23 +0200
Subject: [PATCH v4 06/11] Bluetooth: hci_qca: Set 'bt_en_available' based
 on pwrseq power controllability
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-6-9b02e6f549d7@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX8nVaR/Bhxh3p
 kE+p1s14hkkfMYCX4EdIiBQTOAx9KDike8BHO0JLaG64ZzuIvJDUQx5rSzi73XHatKCpQZHM7BJ
 LiBDDmBdUYGdDCS62rr4W4ty9p432itWlKypicat1YFovaQoKCouIdI4Unz5AobPtHmHhYXn1Tx
 pbaLdt2kQmciSjsI/W9ePZnPFcY8WMRFtiSuurva8+AooSKL5nu6fdvMhwktWUFjQaiiMS1/YZV
 70g03fU4OxDG3fSq8tkImZHC4b/lzsVi0TYECnt+VbX8z3aof4jEHtb92ZUZHNCyjD3E8efpDKr
 crAiT7iVQNNrql4FrsOi5ipw9QaBfL4fbX9zg4Kdjqv/PmHvf+5jUMfyohDJUq49chXC8V/EuPt
 Mg+f2ZCcC/ZBbMyAHdtkUXf5OVkl4UEpTfyM9TX/+xQG24g8PWRzmYBzYaTT53h6VCQAnygoJMO
 aTwNhU/MgyDvrXNdvXQ==
X-Authority-Analysis: v=2.4 cv=DvpmPm/+ c=1 sm=1 tr=0 ts=6a59045b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=kStU6zbECEpzgAoP-VAA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: E2qQVziM2ofo9GOCH9y_cICupZa9GIGd
X-Proofpoint-ORIG-GUID: E2qQVziM2ofo9GOCH9y_cICupZa9GIGd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfXwkY/MfTRXO/P
 osNHA8Th2npwR6DcAXXOf70KKQ+W3hIS4QNLjMXvmXC9DowNxD3eQ3IQ7ATKBx2TffW0JOu29+7
 xNSJkMTPZ/8fC0F/SmCG0KWG2as86Po=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160166

A Bluetooth device only needs the non-persistent setup if the host can
gate its power, so that it is actually reset on the next power-on. When the
power is controlled by a power sequencer, whether the host can gate it
depends on the hardware wiring, e.g. the presence of the BT_EN or
W_DISABLE2# line.

Query the generic pwrseq_is_controllable() helper whenever the BT power
comes from a sequencer, regardless of which provider it is (M2, WCN, ...).
If the power is not controllable, clear 'bt_en_available' so that
HCI_QUIRK_NON_PERSISTENT_SETUP is not set.

This is based on Manivannan's original patch that keyed the decision off
the W_DISABLE2# device tree property, it now uses the generic pwrseq helper
and handles the always-on case.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 17f436484e1e74d1dd690ada22134315abb767c4..41e8c302abc2a820022d1783f1fad76b358ae67c 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2548,7 +2548,18 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->susclk);
 		}
 	}
-	
+
+	if (qcadev->bt_power->pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
+		if (!bt_en_available) {
+			/* The host cannot gate the BT power individually.
+			 * Treat it as always-on and drop the pwrseq handle.
+			 */
+			pwrseq_power_on(qcadev->bt_power->pwrseq);
+			qcadev->bt_power->pwrseq = NULL;
+		}
+	}
+
 	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
 	if (err) {
 		BT_ERR("serdev registration failed");

-- 
2.34.1

