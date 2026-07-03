Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDDA343D86
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082325; cv=none; b=D0HHQVCxc7UkaJx+MLKhwToflEleH1FlSE2LGriiqfVz3OOqegEe8ZgLdZoiUhnVXWuL9lug++f2RFyowsxD3w7GZEGTC+TDH2twi9dKXaJjzyieidLD7Z+gO22fFGzoFu17vHKpKxnVmcF6igM7YVjgK7P9demVMi3Ea9ae7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082325; c=relaxed/simple;
	bh=S8MYJ0Gty39K24ANe2kgww56Fg/Is+/uFYmYQKcyo1g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UPE2f97Od348x+tNG0eNExheTC2880Ylwip5d6azhzzABXm6vApNQEx2Z6TgepyE4pKiwjfjjgqsC2C6sGNd1hDyyBJLFeKAPDONYSyelmdl3oN1E9N2JhxpfyPXoZL6LoNfVUqXnyWM4LEvmZ5Mb8u6O2A23nOLrH67WxTZSaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=op3LP88S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gVJT4RgA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="op3LP88S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gVJT4RgA"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BW0KT3053805
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 12:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QklNaAE+SC0PdzUYHH/SaR
	KtSfulcJNOcVu4EBzPC5s=; b=op3LP88S5CT/HrkFoyk5BA3Sh+mRPWOl4vnAHt
	OSU8VKyFUulWLGC9g9/D26TNfqwNz9UC8dF2NRO/2uwz5Vh758yGzDMxLf/y2NiG
	aqHqYeaI/SJPmHBSiHG8OEBzknAYNNPJAtE+dWU4cZq3/JPOsBjsmDn2P2wrmtf7
	htPpeC5RBZQl7BiNNg04DgjqdSQbuyly9OTV4VC5aJRGFrIWJ+gXV6THEbxOU5y7
	Z3GHdUO4TCAK8rOxoNOJgEgteOk2lZwxIxJJi3RdU4eLzGVb5ZTPGivO67zVEC/S
	12K4FRoKvA6eilZ39xvdbjHPvEIk+QgSAZNZM+6kTL9uNayA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f67j01f9y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 12:38:43 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-845ea8fd3easo1312118b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783082323; x=1783687123; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QklNaAE+SC0PdzUYHH/SaRKtSfulcJNOcVu4EBzPC5s=;
        b=gVJT4RgAHzAY3dPMQPIIuihgumkfmF8H46ChiJ+Rd7g0ZsGDWUppqxkKMyk3A1UJQ4
         WR99Gsksqj9yDbycYxkEA2p7fKVD2o16ogYEWlzMQdh87rtozV31arC/tfB0rKAg9zcJ
         e1KWuVEz9ucEqCpGCPEBt0n7OdfVfQREU2Trzx+hAn/7GdaM9uogkqdY0/juk1Sy+EU8
         /4RIC7nB7Adj4roCJOHAvRlyia5RJWICSXR5BKso0IfXjN/yy7x2Pc5WwOxDkVnUGiYj
         s4DQNBySJJZZEwZqKpLsXsCgjevvEKVUth9gStaLT/CS/XoEhD5RN5H89EtmVlOyWmGR
         mOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783082323; x=1783687123;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QklNaAE+SC0PdzUYHH/SaRKtSfulcJNOcVu4EBzPC5s=;
        b=sfKpx5icH/eye3JLBaVwyttcqhTHP7fmkdX7U+tJeJBu7vnKCFZDBbD+IQR7gqkGDY
         CDfOc7XtcAuh4G44vy93DbqhNwirayxkV5L4zIb+7h+gZCIoGmxFVBhtzOJTl8/bMT4Y
         YSiY4RErb1kLCJnu/lvA8cIr9B7NoAjl4YiH1+lr46r6Yas2iRQgOxs1Gxao0Ws+T5J6
         FZ0It7AuMSRCYZny3xG/Q3m/F4S5jXzuIin0lMfGZQMIhZJKz1cF3g5hLA8imE58h3Px
         Y9pbQMv10htSthdPZv9ZyFIAf+dFZXFjDbK/90H8HemTDm9wCC2j4LZtp4uvCTAgsY3U
         AllA==
X-Forwarded-Encrypted: i=1; AFNElJ95U0y/xluSNwT6C4KQd4Q/EEBG4Jfz98Lgjf8s+WcnD7Rsiyugnhc0cxSuFyP0IQIjleSvyz5NBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc0u8AuA+1Wzsvfsked+gx5c+x6iJHp11OQU8KRgy9wD6FjW0G
	plVerFTtPOzI4SnTXXWaPaGoZg+0GH+sA11G+RUjHa9dNs0t1KF0ZlE91eSMvgkOecodFHL0j3d
	LLSL0Ry/u+ezwKt5VZK06+miO5DBGtg5+McBf402uSZ0rSa5C/fICA5NL4xKAAg==
X-Gm-Gg: AfdE7ckLt8ksTZ8AtXQmT41c/v+7rEMPD6oahHi3H4/sneyl/wYPLsObpQhkAt6me2l
	i806xEyBxts+n31jaV2i3lV15+lIOS4XzdR0hRKz3B1a+IP8Dfh8AIr9OF7AIaFxtCgvFPN7wXL
	Ye2/qs3a7J0IOe8hD93Fz29JJSI4JcOBh/be9BA7Q1GKYi8xRgQEJH9dT/ZiSRaQGTCGiuN6Ejp
	ywcOeYuBBtpKzB4X0a/8qlKQpcn3MLIgmwSddlRzAQ8TqI3pt7QkCKfaUWP3xLwoty2fKoPcf2P
	Eszwqnej2/E7mo4wuBKDkZhRnRwZqjERfenJSweTWH4f3XRIiTnEdcDdUczoK5mR1ddLCLLQnDk
	g+5jdBqv5GUtCRqs+CC5JRGBiNuf+I3RxFc+l//TTC8JxSQ==
X-Received: by 2002:a05:6a20:5484:b0:3bf:6c08:2842 with SMTP id adf61e73a8af0-3bff42c92cdmr11762194637.49.1783082322913;
        Fri, 03 Jul 2026 05:38:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:5484:b0:3bf:6c08:2842 with SMTP id adf61e73a8af0-3bff42c92cdmr11762156637.49.1783082322433;
        Fri, 03 Jul 2026 05:38:42 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c870effsm24356993c88.12.2026.07.03.05.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 05:38:42 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/3] arm64: dts: qcom: eliza-evk: Enable PCIe0 and PCIe1
 with M.2 and TC9563 switch
Date: Fri, 03 Jul 2026 18:08:29 +0530
Message-Id: <20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEatR2oC/3WQ20oDMRiEX6Xk2pRkc9oUEd9DiiT/wa52e9hsi
 1j67qa7vVH0JjBhZj7mv4hCQ0dFrBYXMdC5K91+V4V+WAjYpN0byQ6rFo1qvPJNlLTtvtIrnT+
 kZ6N867P2mkX1Hwbi7nPqelnPupzyO8F4K7g7BjqeKmScbaKnUtIEWS0eZ4ZWdwaO8qylliHn0
 OTgGFx+3peyPJ7SFvZ9v6zP09SbRthMHZG0Qs5kvIpWAyZQRqmUWHujbQzORddw5J8pJgBSOij
 jdE6sFGRq2WejGtRIbDHGnBl+sQKgh2yjY0QdawApVLZ1xKYhm7xpCeKU+mOnURLHIo91xDxY9
 uNB3g6bEOWh76DM+9nWOsUB2vaf/TkVkrefblwtEFwky5QitmJ9vX4DM5AhYuMBAAA=
X-Change-ID: 20260629-eliza_evk-6f30686b161f
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783082317; l=2586;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=S8MYJ0Gty39K24ANe2kgww56Fg/Is+/uFYmYQKcyo1g=;
 b=eCnlEQQS/VPL+DBFFcnPgXI1ANDDRlsdaedBLxzYzGkRRCOvQ9Dh8rNik+0bkwNwbholgkcqO
 t4Q6+2fXqWVAo+j5d7BQK15YusyNeHniPLgw90lI9ICt6SYyWbaW/AJ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: u-uOVQ_nzv5eezo0v-RvvLFvNER_Xg-C
X-Proofpoint-ORIG-GUID: u-uOVQ_nzv5eezo0v-RvvLFvNER_Xg-C
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEyNCBTYWx0ZWRfX/ltWP+jJFvIv
 Bes7ScRxRsyp9tr44hKVudhUWGhM6OXTI2/LvOEJYEWAl/e8ecrC0kXVDFQHgQnNOPMq6YwGN44
 zHUTmg7rugfgE94F6E4lc2jCg20/mRc=
X-Authority-Analysis: v=2.4 cv=Yuc/gYYX c=1 sm=1 tr=0 ts=6a47ad53 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Fm6EAR0vVewXWd2bb8wA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEyNCBTYWx0ZWRfX/Noohv7/1BLq
 0LEhssatxyl6+FjzdDQw505rSdluHbllUghLYrybrMC1u2QoHU5wD2GN6ofvZrwPkZSNOUaARBG
 opyN3Nj27aF5JpXYT/JTqU4yQxMZD7q8fC1oD4x7YJ6S7EXkp9Ho33OsXx4D4c5Xbo506FRkMHK
 YbkBRpjxb2rq4TAcEPxEDuoJ16LzuS2s/Djwl1Xf3J1Mgy0ZKQcS7PI+yJTkdvzrYm5qnS8ThZu
 3FMoOIYjqExWwFXCC6SwZ4zOWBs/Y9fmtMOTCzBxIws2kVbLrYAKBFfAYrpwEQB3xii8D8E/kb6
 +fMNTNg0shOBipIOlw7XT1TraDwwLCnmJ17LGaafNDjyhguC7i3LOgcw2dwRrD1jHhQhTgvUu8Y
 yHTg0HDsceUY+UjRHxzhTS3DfI0qp+9Fl1ZF+GylTGNHEB7FqiMvKs3vwfZw9TxtUadwFzm/mbj
 Xc944CgSqUUEDFHw9wA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030124

This series enables PCIe for the Eliza EVK board (CQS SoM on EVK carrier).

The Eliza EVK exposes two PCIe ports:

- PCIe0 drives an M.2 E key connector. The 3.3V supply is GPIO-controlled
  via a TCA9538 I/O expander on I2C4. The slot hosts a WLAN module
  (connected over PCIe) and a Bluetooth device (connected over UART5),
  modelled with the pcie-m2-e-connector binding.

- PCIe1 (8GT/s x2) connects to a Toshiba TC9563 PCIe switch, whose
  management interface sits on I2C4 (address 0x77). The TC9563 RESX# and
  PERST# lines are OR-ed internally; reset is driven via a TLMM GPIO on
  the RESX# pin. The iommu-map covers all downstream switch ports
  (SID range 0x1400-0x1408).

The M.2 WLAN module carries a Qualcomm QCC2072 Bluetooth chip. A device-ID
entry is added to the M.2 power sequencer so the serdev node for the BT
UART interface is created on PCI enumeration.

Bluetooth is enabled with this patch https://lore.kernel.org/all/20260529175822.3366535-1-yepuri.siddu@oss.qualcomm.com/

This seris Depends-on:
  https://lore.kernel.org/all/20260610-eliza_dt-v1-1-7bb72b75fc5b@oss.qualcomm.com/
  https://lore.kernel.org/all/20260630-eliza-dts-qcs-evk-v4-3-18cbbdba6e7e@oss.qualcomm.com/
  https://lore.kernel.org/all/20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Krishna Chaitanya Chundru (3):
      arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector
      arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch
      power: sequencing: pwrseq-pcie-m2: Add QCC2072 BT PCI device ID

 arch/arm64/boot/dts/qcom/eliza-evk.dtsi   | 283 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/eliza.dtsi       |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c |   2 +
 3 files changed, 286 insertions(+)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260629-eliza_evk-6f30686b161f
prerequisite-message-id: <20260610-eliza_dt-v1-1-7bb72b75fc5b@oss.qualcomm.com>
prerequisite-patch-id: b6c6123bc2cb3a5e6c309c1cfcca80f7f950d390
prerequisite-patch-id: 9e10dfbe360941cdac0300aaf163149755952f9f
prerequisite-patch-id: fecce0170351baf00cbe8f6b302d1def4d99bbfc
prerequisite-patch-id: 97cd6cb495fdd198f6de7fbe45ef32e4a638ec9c
prerequisite-message-id: <20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com>
prerequisite-patch-id: f3615b5c1e2222a2491f862a7fba3994058ecc53

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

