Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0F32ED32
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773183788; cv=none; b=ON9EQFGSG80sPBzN9dl006sQqKK1vx/L/ztzrbIG9aj3cWeVpok/MGv4Fr+JIgxS2k01pxXNfmhH7M7jB1qRILMA/vGY6Kqq1DxuWb3bwoRWg5dcXUmQxTUF5+Ruws8WAZUDIxsFquC4Cmd7Mq11v4JfKyULG/wGFmuyi07f0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773183788; c=relaxed/simple;
	bh=9rPLcD8BIZrdbg8Oyl4ClN+isoL1y4oxPSnddoXMDL8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K2T9Zoq9HGjNcofb/3LIdWQo1kIfANEl+yuaIZrFGgvG+eAVShtlr3KbVgo8h8A79I4RsPP3gaQGyYh8hU0GN3o6gvNvnb6VWbaW7Em8RJuuSneMfjZow0+Gjd7EgG99/ssYDno5WVMXgjTCLMTTYet26Yl8hpGJx8rKbUaS+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MUaiD9o7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I6CCFHT6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MUaiD9o7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I6CCFHT6"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AHbLJn248344
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 23:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bBYHOAqp6lRrhRn0NU9dy4
	EisUfXlx6xS/crsALosvo=; b=MUaiD9o7zr5Ti5t9tZmsxKa4Ep3FoMCPE2f434
	hOsUY2xqD2czkbUvLvh2jEAM/yBd7FtEcictKON6htqolCPCRetyWBWPHHhhOPGn
	IS9v52WaKv5hZT1pP0PyXGycd8UVkJYjQbs8jM3Wv0ggZWdMw4w3pNGzMtcs2N0b
	BlA/OVIX2wBjGiIA4M3tD8z1lya+JTqbeHJbCSt74aV2uFcPw8CSyRfARgMEY2SZ
	M45NAhFPUDXfp6Hy/9rXGlf1aaqg2aGotVTH6afqWVN4Qfco8sdgFEyfgZu8LaE0
	UeHR3+XFJTkVL53MaLsIpRVCx4DLeeM1hMrCJJYI8prH9HSQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqv111da-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 23:03:04 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5ffad14cd7aso6927061137.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 16:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773183784; x=1773788584; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bBYHOAqp6lRrhRn0NU9dy4EisUfXlx6xS/crsALosvo=;
        b=I6CCFHT6yWkTvjIs+GIQC2kOy6egmCJ2Pg38ovnLZsrPiDwD6FKPvVKjT5DMcIvVJP
         C9UR0jm/8CbFPm7HOrQTwTUvSdwTqMV341vTAXH9P5aGrfTbRZf8ZBQsKUEXPMB0lCRx
         Fdz4SXex8fc6EH9R6dro6mrB2RAlF9s2oqEAfkdIV8dUu5nYnynylfIrpaw87sLS8a9o
         huL0kWiZFQx25DNf6UeBiSliojkw1068BPm4/iVAPmWB61Szm9Cw8ekPDYT9KxrtZpBa
         Iq1guW6BLJftR1EBVzvj1P2wMErik6qG9InDLCzb9bGR4fIXgwSSnfpnjp5LXeAIq9jS
         SAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773183784; x=1773788584;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBYHOAqp6lRrhRn0NU9dy4EisUfXlx6xS/crsALosvo=;
        b=cKRSiDuTTnrNNti7bsRxL2cA9RRlf7oy9a8hd2Bv4MgLC4yfpaCJW9HejW37AdWPJk
         RjvDYehpIlwQ7RoIe/45qD/IA4R1zxbMK56jKQwtidXUZ0tb4BJZGAsvK0UzQQ9ptamz
         FUpn0/ltnWJym/M/7VwaRfJeHoec70Tz6x3EkqOKzHwhMT8lOr3R3Nxktiiu9o0Jiqed
         FWtqgOZULkd3T4VK0ThCERWlrUPAk4Ml4y6aEPMbXnFnIgGKVVbEmPjHesOwLkBqkhXs
         Ewb04Q1B+w+Fnr54/C3x0X2G2T6O/X3piL99Wvgrr5z6eufk1TJNf5K1uOE1qzAeJdnj
         nHQA==
X-Forwarded-Encrypted: i=1; AJvYcCWq5z6l1nYIx1oShjplyTZW8X0JoUb2im7p+EWYl39YsvzhczNltTKEkabqvDHu9cHL6vp5ZGga5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJk1PN84AvDpkqp3ZnKq9z0ICx6YVwXQzatcGybqHEwZvfJH7s
	nltliVbRqqwZTvShjVld1jL2+tbdD1t6oPMBJFT1US32AZuA/Ot3GmGMzdUoi2IsQG7HiUUCwpA
	aJnMUV6H6vD2mrilsSadQjFw4bJon9Jp9/Xy5ZBN6hKmNJiAymwmrlh33IgJZhA==
X-Gm-Gg: ATEYQzwHpXRKyvKCJC04187JpZP6xa0RdpUQ8wNpU22lY9wLrjsjIxdvCml9rgayJlR
	MHizlwkOLOJv90iktvsMZya1XHltYqS0GtnCMBoPnIuy6vzGprP4zNHMZPbvbHkej+8I9jXN0N4
	la8Pw3jiLF3oLeAK9kOXD67AT0d/Lh5U9m5m1rts03UrYxdNbgtjLsr2LxU6YIp1UmuHFiSqAKS
	MtfhlptKXSZijwHXGZzQKXKlzkYvj3S5qAQQovl+Q4bmMb9unfYlbxxaWFyLMEPsuO8jbdRyycf
	qlljfdmkdFvhn00HNEhbPGuGM1V8BkvTsSJFZ+9Ifsf+IJA4gIZdvp1FVqWXQ5tDtV7Lxyc/VZP
	g7mmSej8QZHwE+HGvf2NIXPlcPBhd+F7rQgALL/NY+Y7V4O5PUidXJlKjOncjbCY3yMSguD1YbH
	8Hzih60xAkCKaMkkHYV9PzWx+BApkucme0WH8=
X-Received: by 2002:a05:6102:f07:b0:5ff:dbcd:3453 with SMTP id ada2fe7eead31-601defb73c8mr183752137.34.1773183783731;
        Tue, 10 Mar 2026 16:03:03 -0700 (PDT)
X-Received: by 2002:a05:6102:f07:b0:5ff:dbcd:3453 with SMTP id ada2fe7eead31-601defb73c8mr183733137.34.1773183783159;
        Tue, 10 Mar 2026 16:03:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156366a74sm80743e87.75.2026.03.10.16.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 16:03:00 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v4 0/2] Bluetooth: extend WCN driver to support WCN399x
 device
Date: Wed, 11 Mar 2026 01:02:56 +0200
Message-Id: <20260311-wcn3990-pwrctl-v4-0-70e571a18e40@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACCjsGkC/3XQwW7DIAwG4FeJOI8ODGHQ095j2oGCWZGapAVKO
 1V599FEk6Z1u1j6LfPZ4kYypoiZbLsbSVhjjtPYgnzqiNvb8QNp9C0TYNBzAEMvbhTGMHq8JFc
 O1AWrZDBec/VC2qNjwhCvC/j2vuaEp3Nzy9okO5uRumkYYtl2I17L82BzwUTu4/uYy5Q+l3MqX
 +bXzYL/3lw5ZZSHIL1ioK3vX6ecN6ezPdzxTSuLWOFbUYwz9aBAU5jQCpgUoHf4jyJ+KPzhF6p
 oipHaB25Cjw7+UOZ5/gJvwNEMbgEAAA==
X-Change-ID: 20251229-wcn3990-pwrctl-cfa64f9d8167
To: Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Harish Bandi <c-hbandi@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9rPLcD8BIZrdbg8Oyl4ClN+isoL1y4oxPSnddoXMDL8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpsKMiKobqc2hRxJ8iMRpZGB6e6Mbn86CcotC1Q
 Xt4m0C89+SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabCjIgAKCRCLPIo+Aiko
 1bytB/0TzSSxGHV/qUKB3wG+wh9KAztSO5g38Zx0wfniLr4+z1dFi+pvRvfm3AyZxv/fT/fvs6W
 LR6lcHuZVzchaPqI13F29SCrrj17x5dEQJWCMB7STYgUxjr5uLwRtrUcEt68S7G17bUFLkMapfN
 DTVF+f8Oxjq/8uTp7WxTJ/th+//xVjq52KaQSGKBgdOpOIXCcb+ThF3u5DT5//FWPL8i+z/9UzE
 CkIxS5DQb+Ems2kLswvbea02k8oG22j+DAftRDCbhEcnuPCoW4KJ80m/3Xw74ExAemw8swURGyf
 QBTovKmaGzcOM7CWzcVpUQeGJjKTNtZvUFp+kbwXYNO/1++b
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE5NyBTYWx0ZWRfX9JO5P2FGqCrR
 LBdMKp5nsW69xsp/cduiyWYo+wHtlqnzm+Izy/ARgWUZdylj+xqZvT8me7srgfsUUM8kyQ7m3ut
 xhoGiE281xFbsXfvEWYnG+cI9I8reuUXzm5y5XKGozADzb70S0LA4i7zrNC//keudoMEwKeUBr1
 mUYaZIAxKKEPTD3+PridMmp8Mn3VcywL1PfS1b3fU8IzJfbgIMSJ3emlE+Z4zZpYc9mo3JuUmzd
 bohMBbkc6k3VG0vrIWpN6Nog8PUPSz2vdK+Fq26tMx1VEj91gFYL6RyWgfhcPyEKf6QSfAhwQs2
 ZVD4EKjw1qfdAzAMw5RGOICSkrDqHTpPDkrDDgBSlPNgW01RXbPlIITwIj25v3BHGTeykhzUpRA
 faolPEQxC9XaSWo74iFcUmvphFs+LdWMCfLE9ZkkwLjI12ts1xXTylWTQkDdpChvHET0NJurujc
 oAk7b7xSxQ3XwZhQrLQ==
X-Proofpoint-GUID: fWBWnRlWMmnWcqeEoD2T5qFnkn8S6knj
X-Authority-Analysis: v=2.4 cv=S5vUAYsP c=1 sm=1 tr=0 ts=69b0a328 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=sVAF8I02KzBGxPgs2jAA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: fWBWnRlWMmnWcqeEoD2T5qFnkn8S6knj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100197

Qualcomm WCN3950, WCN3988 and WCN399x families of WiFi/BT chips preceed
the later WCN / QCA devices, but they still incorporate a very simple
PMU on die. It controls internal on-chip power networks, but, most
importantly, it also requires a certain start-up procedure (first bring
up VDD_IO, then bring up other voltages). In order to further unify code
supporting different families of QCA / WCN chips and in order to
maintain the required power up sequence, properly represent these chips
in DTs and modify drivers to use power sequencing for these chips.

Backwards compatibility with the existing DTs is retained by keeping the
regulator&clock code in the drivers as a fallback.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v4:
- Rebased on linux-next, fixing the merge conflict.
- Dropped arm64 patches for now, retaining only Bluetooth patches.
- Reordered patches, putting fix in front of the feature patch.
- Link to v3: https://lore.kernel.org/r/20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com

Changes in v3:
- Dropped patches accepted by maintainers
- Changed ath10k to call pwrseq_power_on() unconditionally (Jeff)
- Added copyright headers to the changed ath10k files (Jeff)
- Link to v2: https://lore.kernel.org/r/20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com

Changes in v2:
- Split the WCN39xx PMU schema from the qcom,qca6390-pmu.yaml
  (Krzysztof)
- Expanded the comment in the WiFi driver (Bartosz)
- Changed vddrfa1p3-supply to vddrf-supply.
- Link to v1: https://lore.kernel.org/r/20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com

---
Dmitry Baryshkov (2):
      Bluetooth: qca: fix ROM version reading on WCN3998 chips
      Bluetooth: qca: enable pwrseq support for WCN39xx devices

 drivers/bluetooth/btqca.c   |  2 ++
 drivers/bluetooth/hci_qca.c | 26 ++++++++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)
---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20251229-wcn3990-pwrctl-cfa64f9d8167

Best regards,
-- 
With best wishes
Dmitry

