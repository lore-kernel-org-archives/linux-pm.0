Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0530B50F
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652169; cv=none; b=AozzoviRI6VJNmESBQ2VPTgacXix1AdcaV68VODcDmhme9ngXPZhkVrtYu24B1oG4RBK2FEkqcFyZDKIk6J7nhyumlxWZjQU4d61VjodWezI4ND31PY+ylWPUlFfeNaJBEIswHXKJVfT22KFH237b4CaOuWlKyVb5So2uHr1YvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652169; c=relaxed/simple;
	bh=UZm98260Y91sD/0xzBGeVhOmEPZZGD7lKsH080IX2tI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CiDhoSqGAVteDeUESLhSBj+73ukGISw17dQPLnLrpwdsmUO1OOUb9VvNr+fkBwRl89Ce7rUMXG3VKRkKNwEeutx3b3xlU1VPDqs6X4+DzQnK58oTgTHwhIKVPGMqblKE47FAVi9i6JHlPhrGL8J5XeQ++UO0JL/pH6/lCavpA00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z4Xhlcb6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OFVj2uIG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z4Xhlcb6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OFVj2uIG"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OEtSv4672527
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=45+iCpvc5VWFUTB062UN7b
	k3k/bR33KPxgqVzcCpnmI=; b=Z4Xhlcb6z7gTxJHTFwMYrcorAWchk/lylHhZTp
	VCLpQgcLgpOHN1M2neZHZ+LciduECg/GF4Wk+G56CFtTO8dlgNOJ09z/zb8P+uFv
	TwI/U/fgDVsn+EEz4FZk1dJ1SY8tVRGqt57m0CsgS2NnKrFVViyK1E8iQDEDejiB
	/Z1QOL8lxxnTFLn6GA9W4P56JSrnG08oiCHYujB5fR0DcrmrblY0TIm7ISC7E9pJ
	a51ccp+lbFHSoz0NoWpThAo/1ByuyrEJWiPAYJ7T7PXbjKmhJ+TG6T/X2mFT4sDQ
	h7uKRdUeFIRLMWSPavqsHXLaM/ippV6KA8GJ4c6bB8To6sxQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb1kmm9pj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:49:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-366122e01fcso8648072a91.2
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 12:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652166; x=1780256966; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45+iCpvc5VWFUTB062UN7bk3k/bR33KPxgqVzcCpnmI=;
        b=OFVj2uIGRJQKgjPr1Ums2d1Hqh16GSKAoLTSPJsq4RIw5ZJIrIQDb8XwxQGVhNJDpZ
         usvTTdveerZsmkHlqQp8zbAwh/u/iUeWivQTSOMvKa9wQiJhdg4KtrcG2bCeqJyIzIRV
         NzDu0UPQcGTRvqzyJRP5AOvzh73vuY8sfkxaDgsd8fv2CKu9VYorNd5tNfdp4E82r2Mn
         J7sLgR3EY+uTvHyLEfb6j/HLBr1QGGfpob1GKtOMV4mLNtSA08DMg2hIewtgRgq3VgAn
         HMdiBfJrzUOghXEoTN0/h1ku/PVjF5pLugdnVwZv7L7xRVLNkExmoKk5qO+ot2ZlFO45
         WcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652166; x=1780256966;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45+iCpvc5VWFUTB062UN7bk3k/bR33KPxgqVzcCpnmI=;
        b=WZNPk/0vHzqJgGQI9t3uDENlSoZBVxnvRBv40b0R9wFvrjC5Wad912dnoayAZnK4tD
         9gvrA+eScq66DtVwNy+BJuiZvA/uJX6kALQPmnEv+s0tWH6o+ck6K/iqa4pa2u30aQQ9
         dsGfWpgTr0EUFgCP+V4y3UrpFXz/kokLkGo6i/rC/914CNh11jzP/X0ERJ3OS6/V+7p3
         L356Y4Gd0bYhu99TFpu56bj3F8YgTi8vNZ90WOkFpk+ue9016QcxG5YVYPGWlHYU/keK
         ERjYurBWfjklVRL5rIWLmDSxm5JR06KRM6Ri3UAOWEbigbUmgWiHi1tEMi59WzdUEhjx
         l1zg==
X-Forwarded-Encrypted: i=1; AFNElJ/Vyo8p9ciuHlG8vXA/zwQpM7cqr3WbCPodMXy9L2D3zUlhtSDhF6qTNpkGwrHg2J6LBTVs6fKy3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMqtbkLNApwkSQ7YZXHpW3jesegcg8C4Estvd9TqWrqJ6+Pb/
	nee2G+bD0JrNTaIOz+AyQaKskHFf2A5Y0DysleYJfaGJnsLX3ZUldvzoYBxfYF/azEzolmAKee5
	tA9r+wscMA2ERPjyJUQR+qsjB9j8DsRe+rUPecRhwDlSqcbxOp4VQuNdosaKhow==
X-Gm-Gg: Acq92OGoUh8CqNdK7rnaNtNWkKSf5vKTOQQN33a6Y/oFe7FF622LvY7uWBWAjh+9BWY
	MDWzShilGdyymz03t5+ncRHWOJuf3NDbROV3kEm9ru7RCohbReXojMsx3slT3M0x30QSI7OUAUk
	Fqy07uqO8fGqXVTUEwtm1ch2JAdDIVYeXRBAMBvDrB1anpRTy2fzTauptOZiZOx5S3pb+ltTrMK
	VapVQjTiuegvvW6ndnSOJKy34K62HKzxUkQs/eSImDdYPaRZAilDunWgpJv6mfb5arw3rxj8Eig
	4E61wRK51ZsIxQR32Sd1oYUUoPsnPQbuaDkHlGyNY7mmIFgsE8Ql/luA9YVGcbKxMSKPRYlTQUW
	1qwQKwfMKl8a0yqOuzobBoi0MrynBF2sifast
X-Received: by 2002:a17:90b:5385:b0:366:346a:6891 with SMTP id 98e67ed59e1d1-36a67836e6fmr11627655a91.16.1779652165618;
        Sun, 24 May 2026 12:49:25 -0700 (PDT)
X-Received: by 2002:a17:90b:5385:b0:366:346a:6891 with SMTP id 98e67ed59e1d1-36a67836e6fmr11627621a91.16.1779652165020;
        Sun, 24 May 2026 12:49:25 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:49:24 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: [PATCH 00/16] arm64: dts: qcom: Extend Shikra device tree with
 peripheral and subsystem support
Date: Mon, 25 May 2026 01:19:04 +0530
Message-Id: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADFWE2oC/3WO3UrEMBBGX6Xk2kAyyaRNX0WWkp/JbtD+mNQiL
 PvuFrvqXujlGTjnmyurVDJV1jdXVmjLNc/TDvKpYeHipjPxHHdmIMAIBOT1kl+K43Hlo+Sig0h
 BdUBtYruyFEr54yv3fDq40Nv7Xl2P42+0b46klA/J2GK0rUZttOk3xR6/+BHUt1CWMgcuolOIA
 U0w9l8H+FppqoPPU8zTmVuXhEDSXgH1m/xTAn0fGmipdXhVHAFcIp18l/BueVeJh3kc89o3QVL
 woGxySqNBsE4BICq0KbSdN5a8jZ1u2el2+wR0chzCegEAAA==
X-Change-ID: 20260525-shikra-dt-m1-082dec382e7f
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>,
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Yepuri Siddu <ysiddu@qti.qualcomm.com>,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=4127;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=UZm98260Y91sD/0xzBGeVhOmEPZZGD7lKsH080IX2tI=;
 b=djc7KEpkzBuKIiYDY3FJdJT7raiwQCvqgI0jCHnIKyp8j2e1af42aiqq192kSWKkKp4PZrffa
 dVndidU8Kt/DdHN5Kt9TKArpKDfjvx32qioknpxqKCim42k8JZwuIi0
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfX8ARB4bMKp5Nb
 J6kp1ZrRfr3jGm65kJI/E63bv9u0XdV/dtIek4WEPgMA0Q/iW/rZPl0rdGTMWV0W0HxZpB0p4/c
 9r9M4eFyXNTQFFOBUbrxXJDEoIjswdutubu//aD1oh5HzVfdEEQpkEaxoT27EWR0r9tl990nMWl
 itEebHi07uR7GcgQnvsU5iNzuIWWpTwh4tLiEfZ9PxaAoOFPMeWsDjFxo6+ppM6/d3WfehzjW+o
 ZGRislhbLVYTAfsXDt+7/wXwe0f3dsgrWN1POBHzx6ZHpXhCn6yMyKBjKM/3GsDCdreEQMEX8G+
 mQUP2HGO7fjkglW6YAIA7XmjALeDcQpFLmUvplcYuTVeWsH+B8tStFEy0z78CP0BxdKk4dkwCG1
 RjzIiJd+72o3/R2w7ruNcB0MmMtcyXFKACvjIRoWAVv6Vyq/WXymviqOIB4kl4fJjsXEae5x0Ng
 ZC63ucgVp6yg2qmqhmA==
X-Proofpoint-ORIG-GUID: UUzdD9yWCT3Id0VAY-ofzmKQGBaIYub9
X-Authority-Analysis: v=2.4 cv=cN3QdFeN c=1 sm=1 tr=0 ts=6a135646 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=F_wByC5qsg8vutzaSOUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: UUzdD9yWCT3Id0VAY-ofzmKQGBaIYub9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240198

Extend Shikra DT with peripheral and subsystem support across all SoM
variants (CQ2390M, CQ2390S, IQ2390S) and their EVK boards.

The series adds:

- QUPv3 serial engine configuration
- cpufreq-hw node for hardware-assisted CPU frequency scaling
- DDR bandwidth monitor (BWMONv5) nodes with OPP tables for dynamic
  DDR frequency scaling
- EPSS L3 interconnect provider node for L3 cache frequency scaling
- CPU OPP tables to drive DDR and L3 scaling per frequency domain
- SMP2P nodes for CDSP, modem and LMCU inter-processor signalling
- Remoteproc PAS nodes for CDSP, LPAICP and MPSS subsystems
- TSENS instance with 14 thermal sensors and thermal zone definitions
- Bluetooth (WCN3988) node with board-specific regulator supplies on
  all three EVK variants
- WiFi node in the SoC DTSI with board-specific power supply and
  calibration variant selection on all three EVK variants

This series depends on:
- https://lore.kernel.org/all/20260522-shikra-dt-v3-0-80ffde8a3dc4@oss.qualcomm.com/
- https://lore.kernel.org/all/20260521-shikra-rproc-v3-0-2fca0bbe1ad7@oss.qualcomm.com/
- https://lore.kernel.org/linux-devicetree/20260513-tsens_binding-v1-1-1780c6a6caf2@oss.qualcomm.com/
- https://lore.kernel.org/all/20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com/

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
Bibek Kumar Patro (4):
      arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS remoteproc PAS nodes
      arm64: dts: qcom: shikra-cqm: Enable CDSP, LPAICP and MPSS
      arm64: dts: qcom: shikra-cqs: Enable CDSP, LPAICP and MPSS
      arm64: dts: qcom: shikra-iqs: Enable CDSP, LPAICP and MPSS

Gaurav Kohli (1):
      arm64: dts: qcom: shikra: Enable TSENS and thermal zones

Imran Shaik (1):
      arm64: dts: qcom: shikra: Add cpufreq scaling node

Miaoqing Pan (2):
      arm64: dts: qcom: shikra: add WiFi node support
      arm64: dts: qcom: shikra: enable WiFi on EVK boards

Raviteja Laggyshetty (1):
      arm64: dts: qcom: shikra: Add EPSS L3 interconnect provider node

Sayantan Chakraborty (3):
      dt-bindings: interconnect: qcom-bwmon: Add Shikra cpu-bwmon compatible
      arm64: dts: qcom: shikra: Add DDR BWMON support
      arm64: dts: qcom: shikra: Add CPU OPP tables to scale DDR/L3

Vishnu Santhosh (1):
      arm64: dts: qcom: shikra: Add SMP2P nodes

Xueyao An (2):
      dt-bindings: dma: qcom,gpi: Document GPI DMA engine for Shikra SoC
      arm64: dts: qcom: Add QUPv3 configuration for Shikra

Yepuri Siddu (1):
      arm64: dts: qcom: shikra: Enable BT support on EVK boards

 .../devicetree/bindings/dma/qcom,gpi.yaml          |    1 +
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |    1 +
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts        |   42 +
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts        |   42 +
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts        |   58 +
 arch/arm64/boot/dts/qcom/shikra.dtsi               | 1687 +++++++++++++++++++-
 6 files changed, 1810 insertions(+), 21 deletions(-)
---
base-commit: c1ecb239fa3456529a32255359fc78b69eb9d847
change-id: 20260525-shikra-dt-m1-082dec382e7f
prerequisite-change-id: 20260511-shikra-dt-d75d97454646:v3
prerequisite-patch-id: 3a689e8dda5fd2755b689d94d095806b3f2e6eed
prerequisite-patch-id: 2acc300a68ed8c5364fb5f2f7d28fc0d56ab07bf
prerequisite-patch-id: 391f9dffceaac9f44df7c2daffafb66fa379ca35
prerequisite-patch-id: 2885f299e711582da312ca9d13983d296a3dd5dc
prerequisite-patch-id: 7e351b93b3a238145ca642143bd0824bb90e98ce
prerequisite-change-id: 20260513-shikra-rproc-0da355c56c69:v3
prerequisite-patch-id: 39475cddaf673b2cbbae703165a782916f199885
prerequisite-patch-id: 6f7f265abfbdffdc0a1fdc5a7e08929e4eec5b7a
prerequisite-change-id: 20260512-tsens_binding-9af005e4b32e:v1
prerequisite-patch-id: 35141047f44b4845f9d94618bcf26ec58ab4a0b2
prerequisite-change-id: 20260524-shikra_epss_l3-522afe4fb8f5:v1
prerequisite-patch-id: 9e0a3b4d7b2033b39287b4382ba3c0c856a62e77
prerequisite-patch-id: 3ce52e07ae57139c2e2b71a29ed7d7250f6fcc87

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>

