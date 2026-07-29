Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CB637B415
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336540; cv=none; b=N35YqaTH4Y4AKEN4Nvsz2LeYTfODMXn8q1dzQgvGMrqRQluxA0R/NHrvDiGDntwNvtFztvcAUx4K/AK2BnhpIztqf47TkCZ/SJ1uyVP6oQzzoBEeuKb4ElRKXpKeojt32MD0VpJz84Yy/OFmdqCV4TGfxbLsrEe3EAAjx5bgtaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336540; c=relaxed/simple;
	bh=LzRk42hLPF44h8Qhf774xSXDeVD2osjbP32jNzvxnz0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p0+4WySm0LJFwYaw2Fd/2Dj1zSmSsDY2hwVFtY3O5WNy6Ow1c5If4a50eFUls0F34HmBikAIH4EUAIXlWQ682Ly8kBCdBIWHdF6UptJ/TV/lpjjmpknFq0v43NzzZ45ARTxYit5US3JYQqzEpQLYg/3huYtUWa1THMuoHyvaVpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OJ+TbFjm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iqJL9zzA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OJ+TbFjm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iqJL9zzA"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TEMT1s2081830
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 14:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pWHU+t4rJhXrXpGp2LtA0F
	WHC1o6WO+Pu8Djb/P/jUk=; b=OJ+TbFjmV9ovxMNP0Ec3ypevpf5VOOUVQqxUuu
	vVPo7hfn9NdAeaLKSNTM6Lr3AMM7oZekTkTnlPbTTGgGURWVTlOAFIhJ+eHqTbvl
	X1p9+u1jiIzgb27m84uzVi1ZDO5FA2E3sv+okoozazlBt6MnS6vMfOu08/JlIWrp
	Ps1wKU4tfTvwySN09t40zoy9/LMWFXnX+nW9GSZjqfNc1+QHxoD9m2wOQFIgOxq7
	UTwcqF3OfkpR5K8Gn49yRnsF56wDKOgTx2WEcq8N5csyFsOKFD2ZRDoIa/0EDB8j
	IBoBomHsoxsm88eu8pLoSO2qLEg/X1PjrRAZXC26aJ4RwgNg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqhg8rne2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 14:48:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce7dff6253so20525925ad.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 07:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785336532; x=1785941332; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pWHU+t4rJhXrXpGp2LtA0FWHC1o6WO+Pu8Djb/P/jUk=;
        b=iqJL9zzAc2QI4g+4dllYP7o10Ex7R6WO1rpUa6YhnjXyRxf09dgpmxl4PCK8HoA/hd
         3CYK7j60OTCA4+YPVJ+wMBnPTM7/D7FPO/U+Ll5yoXeED4/cqUTv8QwajSxTjNvl4fRo
         95M8ND2Y+yjZ5HpVz27e6WWzvZAV5GLSHIveJD54IEvehMWTn3fkUiNN0D2wsII4iejy
         IaV4C0DTUf200kSD5unkTPDtXTcv6hjs9QJir8XMSJnXEa4fRIWbclnQQlwwAlLTf0jl
         vya/KCCrXWNhf2DBMixsTrBmMiZa5Dkm4A69/+6V75GpSaeyAoCizSoeKst7jka16N8e
         WLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336532; x=1785941332;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pWHU+t4rJhXrXpGp2LtA0FWHC1o6WO+Pu8Djb/P/jUk=;
        b=RdYvCDDYadhq9iAnShajquJOeLhbFKIbkXUX/QIGBzSpb1n9n4DEDJgCLGXIwVw9t3
         lEn7L6WDaCfRMbS4/jW822/NVAqFOXN1stqRcFy6/60YOobC+H8FoeDsgvNTnWkvQBfS
         1vYxEEUVB03XCsLkj6Ufm5DZ0iUoHbYTmwTpXNPxL/tfXeqpY7ZpPof53he6wU3nNoCI
         ZWYFjo4pYEa5Pwk6KFOiw0v2lD7zZ0o7nz3fcyunwzgPjb5P+mh6bYyBI7GU2Kg+t6bv
         hGU0mCMrqkCGmofadaLaII6frqyZccmpbvMEYH4tj2Q+YidvrAf9A2A1FqHYuPEzTGZX
         SUbw==
X-Forwarded-Encrypted: i=1; AHgh+RoTlkaKn7kjKMDEiiSI/+stDoY0paAgSlkITCjwO4mcS+a+dYzmCpiLQqDYoQ8Fx+/1anh9U/Se/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm9pHvYmj+Sarcw+0J/l/PeSHzZVusD0NMcD7sRDqPfYvYuJwg
	Jg4Gn3lMLNvYm0X31bYKHLrtsovGpc69r4zjhauKE9529edbQTReo6fQ0bKOqrsgPHl5TPJjf0+
	5fYYvX0NOJTtymFOvg7gp8iAnpPNugcWcL0itXY3+JScKDmsYLaroNR/WKZDlYg==
X-Gm-Gg: AR+sD10urGjs5KgEKGHAZISAhsUze/ogw0pCPi2C3O2g0X5v2v981uhuU325d54Tgnc
	8i2L7Y70JGOWjfrR246bEVQtqmtib+per0EQYHGAHLENDEdSguvUnZCIucrP5PqlxFWrOmho0y8
	u33tiJDGCNj31YPS1puWAd8M8atDEQEdulfjgHEHuB9ptuKuPmav34cPsga+mLzfut7J4F2cpar
	Kwwke8co95aeRI2eVLyY7qg7ARPcb25GoEEt4vhBiZd/kTb9AGoDPatsflEb7IaroCrS+DRzdNd
	MdndKoiuPRHrhABuMd/U77D4dGdgiflez5XdSrcFLGNnO2206UIUSxIp/XidwkvX3svIfrbHEOl
	kZAfpS0WkN+ECDRAwpf9CCr9pvX4SAr/S1i8=
X-Received: by 2002:a17:903:2446:b0:2ca:de3:15d7 with SMTP id d9443c01a7336-2d026742789mr26659035ad.16.1785336532187;
        Wed, 29 Jul 2026 07:48:52 -0700 (PDT)
X-Received: by 2002:a17:903:2446:b0:2ca:de3:15d7 with SMTP id d9443c01a7336-2d026742789mr26658695ad.16.1785336531690;
        Wed, 29 Jul 2026 07:48:51 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d37368sm19515456eec.22.2026.07.29.07.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:48:51 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v5 0/3] arm64: dts: qcom: eliza-evk: Enable PCIe0 and PCIe1
 with M.2 and TC9563 switch
Date: Wed, 29 Jul 2026 20:18:35 +0530
Message-Id: <20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQSamoC/3WR22rcQBBEf0XoOWN6rtIsIfg/TDBz6c5OYnl3N
 VoR2+y/uyWFIJP4RdCi61RN9VtbcSxY20Pz1o44l1pOzzzYL02bjuH5B4qSeW4VKAdOeYFP5TU
 84vxLONLgehelk9Ty/nlEKr9X1sP3ba7X+BPTtAD+bIx4ubLJtK215zClI1scGo8SMkXUDryRK
 YcEGiAEkk5L4ztrvVXkN6e/KsKUEGQH2soYCCBF7MlFDSrLjGSy9zFS+qjyXcouReMt5Sw9CzJ
 27G0sklZogtM9Jr+qBqw1rDUcmq9bCxpEnqq4pNOw1SGG6SyWSkLO4jyUVMUshRRkGAfUpb6P9
 6da7y7X8MSq4Y4/3xZ6DBXF8qdMhyYn69EQBp/7dmnwWOp0Gl/W48xyLWxNwM/d3YGtQHROGWM
 g5s7lf6xW2Kz2gH4PUAxgb6+MSxiD/ASgdwAl9wDNAK+iBNA9Sf1ZArMHfEhgGJD5lh2h5RT4H
 8DtdnsHW3gW6q4CAAA=
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
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785336526; l=3295;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=LzRk42hLPF44h8Qhf774xSXDeVD2osjbP32jNzvxnz0=;
 b=PP5SvVYwhPc7HriIlnoF3NxT21s7ujlCY7niC82a8Qsbv9lybLvdRBF8ts34y2Zum9P7JiNhG
 UcCRq+GzRobB6BdMWeJHqYXrjvMbYTX2bQ+nF8ksZPxCDCKzWI0OqN3
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfX/vxNYiaQ1hLL
 ge88sMZRdZnDXm7lK3cjDo/MvV+ZS9rotxlxB2/TewrS/1THa1XA8ZPewwLwuC9mYi5Bu0OlF3Z
 8YVFkNYXwpx/3XcKz/LIPcvsWs39H+w=
X-Proofpoint-GUID: WK2DoGC3ChWfloJi7XmkErILOdLtl2Mg
X-Authority-Analysis: v=2.4 cv=LOdWhpW9 c=1 sm=1 tr=0 ts=6a6a12d5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=h7GK-HNMy1QVH8K1SrQA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: WK2DoGC3ChWfloJi7XmkErILOdLtl2Mg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfXzS+pD+PBWpDG
 sPmJA6kqOQq7qVfCdb0qJ3xtwo/HcZW+qSeo4HxvHTXkUpNngQHTts9+0Q6ExHDfkMihIZYFx/b
 U6frLDHLNzPUQcf0ABobDw2776ze9WofW4UEfrHScpB4ceKD2+4glCk3IkVsts4PXZ15sxSbmVw
 3i0eaHaurViz9zzV4Pdyd/gU89nXH8IYtvnTS9IB9VMK1nlNFRr7GOgabc/NGlmew8Kr7V6xQXj
 xYLcYYpz//rCBXF6ktyYDHaheGuleyeUCTfySfbQMjN0dTnBuEQ2pX57ekhcRNzJY/90pC7/ixB
 8DDQCS1j1QkqmcSWYdsMPne1O8DwTbXCBcMspWT3MjbXB6lEds7oagH8yQZPAiZyoXYVzTM/DFr
 /Mf4RKumW+S2IaY0ztPHorybiJ/ud2TLC/n2jtYBXzabAtK1XQT3x2iIxDsnPcxmphCUsLplwW7
 zVYVOa9oB3WZBPVKfhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290120

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

This seris Depends-on:
  https://lore.kernel.org/all/20260630-eliza-dts-qcs-evk-v4-3-18cbbdba6e7e@oss.qualcomm.com/
  https://lore.kernel.org/all/20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v5:
- change from pci to pcie for subnode names (konrad)
- Link to v4: https://patch.msgid.link/20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com

Changes in v4:
- Added new line and used pcie port names as pcieN_portM (Konrad).
- Link to v3: https://patch.msgid.link/20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com

Changes in v3:
- Clubbed pcie nodes to this series (Bjorn A)
  (https://lore.kernel.org/all/20260708-eliza_dt-v2-1-e6281da26408@oss.qualcomm.com/)
- Added comment for PERST (Mani).
- Extended ranges property for pcie1 (Konrad).
- Link to v2: https://patch.msgid.link/20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com

Changes in v2:
- Drop patch 3, as this is already applied
- Rebase on top of https://lore.kernel.org/all/20260708055017.A90C91F000E9@smtp.kernel.org/
  and remove pincntrl as pincntrl is added in the eliza.dtsi patch and also remove
  pinctrl for resx as this is covered in pcie1_default_state as perst gpio.
- Link to v1: https://patch.msgid.link/20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com

---
Krishna Chaitanya Chundru (3):
      arm64: dts: qcom: eliza: Add PCIe PHY and controller nodes
      arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector
      arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch

 arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 229 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/eliza.dtsi     | 415 +++++++++++++++++++++++++++++++-
 2 files changed, 642 insertions(+), 2 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260629-eliza_evk-6f30686b161f
prerequisite-patch-id: 9e10dfbe360941cdac0300aaf163149755952f9f
prerequisite-patch-id: fecce0170351baf00cbe8f6b302d1def4d99bbfc
prerequisite-patch-id: 97cd6cb495fdd198f6de7fbe45ef32e4a638ec9c
prerequisite-message-id: <20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com>
prerequisite-patch-id: f3615b5c1e2222a2491f862a7fba3994058ecc53

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

