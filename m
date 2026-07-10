Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B9E3FDC18
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677469; cv=none; b=hx5k+SxElumQ4+pbLS/3nUo2E5jVUIQMUAiYoelSzvslq91j/btflQvf/4hWy+bWPHpoC3He5BpfY8u3N1y5dJpWNqgHLtOEH0jFb6IcmPTg1zZmNlJCbz6mkf3eeaLZ6sqDMFYVdNFkj0qu6O0PlOmTueZql+7jWUQPEQsetlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677469; c=relaxed/simple;
	bh=drfMTyafP5O0WHcutG+g8kfep1FgBIKDYHEt5UAf2t0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bdb0R24OSTwRj2nOtVXxlyaVKhRL4AS9BqHVPClV5LYYF7jW5IRfFXH1Zdhe6PHUqVWk4QlSIgJ0E6nfItpL+VC18YBFz/Srde1GT3+vSjlaKMsZUiFWgOi2BsnK845Er0pds5WhoNOO+8VE/pM+8iXFm9DhfzI3L2ZEcljn7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KUYNNWBB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V+PbbVCi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KUYNNWBB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V+PbbVCi"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dUeu182768
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uq3021KNWN1PDY5vGnxhuGlTpLYyxahRYp1yr2wnYV8=; b=KUYNNWBBIu1EkpFH
	sc98aZnmd3FGwpsVb3JlSf8DLXQXYQrd631LN26YnCa2tS9qFqzIglrGQ49aZXec
	+ePnCODA1M9s1OAy/Yevh9PrNTjXVzKKsgqt5jsNo2WN+5XVAOhjjOOzwd7Giid1
	i+JyBrX6FkO5Ny5CyDPVWXDJ1U6m98+DPAy3jnSm9pZzRmpmfIQ4p+OcLV4eZu1G
	+kr0F6r2I5tvcdHANh+7PLbS8o87koqOYUXL0whjbT71XIZD7502ueJcVDkAKwTL
	HreYLWKSAD7eWN8vanlwCRFjQtf40F6kAqCoVLK0b1Y28ekbx7uY6YDo3vs1nARn
	J/0QuA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajte2hef-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:43 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c2af04aeeso11799381cf.0
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 02:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677463; x=1784282263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uq3021KNWN1PDY5vGnxhuGlTpLYyxahRYp1yr2wnYV8=;
        b=V+PbbVCilWBSNFW45+Wvucm0WozUVfvAebh523qBewdhauoh0JFqCyFZEMZAxEx/RK
         G3Pw6HF5q9NZBKDduCoMPGlr8RDhu7VhsPUf1hXIpw2iAdkMhdaNM1TT1Kk5D39WQ4VR
         58ei8eRLhmJDyFBFRtPdAIciVSOGT4VCM0KoQwM4N7h67nlxqByvG523Qfz+geCjfH71
         L64FN9XqSo5hWTYPrpjmf7S8wn4/J6sFgWtszdOkB4S+592kRpE4ZG1Ina6ljRY+A/PU
         S/o/LtZchV9GrZwLdzLNevT9Vf1r5yaTJWyHwZXL3W5r3zOkDte10rkgnK3vYSinl0Q6
         +p7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677463; x=1784282263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uq3021KNWN1PDY5vGnxhuGlTpLYyxahRYp1yr2wnYV8=;
        b=ig0CMV4wUjvCRYlBYyZQA6zqjilUVbUhUd+5YWKPY2gqQdvTA6vOe4M3f4FKNP+UuR
         UIJcvDHYgVc6L0fFAg0AvCMuM2nxPQICT1wbqCV46QgAChS9IjfyUg6G81oeMBq5yTEj
         6IbZU+0T43vfVkGwzTx/eje5CpyQJ3e4SWrIpz6OM4lD2k62/eRm/b/f+bNHp4F2T7Ti
         lbn/8M5bm8emKQ2ST9cNQgIw42ts+FJ1/0YwzxEXbGH/fsoVWmoGKwMaGeQi5Y+EzKHm
         qKlpoFpVWaMD8nY/95Jryk+nIImDhaOMgVWnI/9ZTk/+xx6D7l9kxLlj7KqKI+VwpMSr
         xvFQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQqzpEczt4YNkOomNGH7nwNYIfFpeJ27BKL50EncAvF1TfHwEnKSOgXwAwpn349KWraHtm6Berrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7aEoQhnLgeHXex9RTcVvR2IWUrXRu62WigOeZ0AObren7iWX
	SnRJSQ6P1eL1ONIHZv12AVbYy2lMH/fWCUiBHiRVQjuZEBYP62xrx9CJ/IJgDr8cFm9omAwmRuO
	zzIL1qnUubSkJas02ycgdwPLdKO/h0EM8gXpMV4xK66933siDGQenfadnEjomHQ==
X-Gm-Gg: AfdE7cnNQajYqcE6miheL7TH07Ouo6dTO+2CX83c5HwcrK9cggbbjvpUR9vFQrsu4xi
	SYZYLE1iqdLHpAHyj7VMk1KDVvM0KCBdWS9UTo0x9Y3Ws7dR2fsw9XNYIcVfMDiyNlYxlHae7Va
	pkAuztNmUxPktDsPcdmz1QqMRgWpUGLOE7tOegoE4L5I3OY9iblWinF94cSjPxCAFPEis13qlSl
	1eXDY32C8KhYlrZPDxATnCEKba6QAqIJrafUHpmhdVBlF3Qf7MdKe9e9CLqIY0K5gC8W9lIoezM
	0h0WGSTJ0fclfeiF3wNvGR9neFsI8IrlC3zAoRAtQTPDS3ne4MUStEZprL3+rnyT+obM/RUJrT/
	idiyqnWFeZOqbPR9VZjsiRTrdC0p20yEa2VsELDOJT9kSMyjfExe49Bp9ArV8J2Og62SWAuP2yN
	ITQK9RwIVB+sr3uoKuCPodojZIZ2oIB928IOGcKt3PZVDR4IaaAMdDbKdV0FDClHP3hYQC6clrv
	ngEA17/8JcI6bE+HxrK
X-Received: by 2002:a05:622a:1192:b0:516:5019:d27f with SMTP id d75a77b69052e-51caa0b5790mr27855981cf.18.1783677462750;
        Fri, 10 Jul 2026 02:57:42 -0700 (PDT)
X-Received: by 2002:a05:622a:1192:b0:516:5019:d27f with SMTP id d75a77b69052e-51caa0b5790mr27855781cf.18.1783677462351;
        Fri, 10 Jul 2026 02:57:42 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:41 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:32 +0200
Subject: [PATCH v3 06/11] Bluetooth: hci_qca: Set 'bt_en_available' based
 on pwrseq power controllability
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-6-46253587af64@oss.qualcomm.com>
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
X-Proofpoint-GUID: pwVIusp3MNYVgLpheDJcFa8TZbyqii64
X-Proofpoint-ORIG-GUID: pwVIusp3MNYVgLpheDJcFa8TZbyqii64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfXzrBODRhwaSXY
 quFtAfqvdFHjxd+SYm9EBptQujBfXoop2X1+ME5qGXnC2m7QpI9Rua6j8rq6ET3xlDEzSClDcV/
 dLrVu+NVu5xqMq+8nWgkUomfDUZryX6Ovyjis3r6JFbjMU41qArowETqhQZDdrfeZVOwJZIvLye
 UXdi6cNgSzDU1iq6Q+QkzYmdOEFP7p+jZxFmDceMkri0gv/9hOylmIAn/w84M+nZX3g3jzGPtMD
 V+401JteCdI1g/2j/PjIfR7igeXET4INUxpOc91E+GxirbXXuakLDImeQA2QdApuZIt3ZK2wkdt
 yRP8fyHQ/6dT2PWmYh2Plgr7DJ3Zf6DMjgBV2BhTmtHbtGsr4pklyCNe9y5vg5W1zTXA23mRJBE
 UHGz+GyK0OvE3tLMdkBDQA2FPWSf8A/Nf4TEXY5bByITbBaqIADjEoeJIHlZqMdYjlo4JbYwtjh
 /LKJ6HmiTlkrVd4uMbw==
X-Authority-Analysis: v=2.4 cv=N7MZ0W9B c=1 sm=1 tr=0 ts=6a50c217 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=kStU6zbECEpzgAoP-VAA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX2z5IoGKNSoGG
 85P4ZR+r8vfz1Uex6OLd9DddB+EFyvZ6xKzNZKQladlVGZGaea3IJeknbWRaqaj9UUP8UBmYcWl
 4vdhmRdB+wDCPNjCFNsr1onSzakrx8Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

A Bluetooth device only needs the non-persistent setup if the host can
gate its power, so that it is actually reset on the next power-on. When the
power is controlled by a power sequencer, whether the host can gate it
depends on the hardware wiring, e.g. the presence of the BT_EN or
W_DISABLE2# line.

Query the generic pwrseq_power_is_controllable() helper whenever the BT
power comes from a sequencer, regardless of which provider it is (M2,
WCN, ...). If the power is not controllable, clear 'bt_en_available' so
that HCI_QUIRK_NON_PERSISTENT_SETUP is not set.

This is based on Manivannan's original patch that keyed the decision off
the W_DISABLE2# device tree property, it now uses the generic pwrseq helper
and handles the always-on case.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 17f436484e1e74d1dd690ada22134315abb767c4..4a1ef316e715f4f1f0c8f7deafa971887af040f3 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2549,6 +2549,17 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 	}
 	
+	if (qcadev->bt_power->pwrseq) {
+		bt_en_available = pwrseq_power_is_controllable(qcadev->bt_power->pwrseq);
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

