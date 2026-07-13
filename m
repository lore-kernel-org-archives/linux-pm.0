Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E16355F49
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971431; cv=none; b=WGOfvYz3BxFE/acDJ/7+8VjXFmzYjc2O++TA01Uf44b8Wp5Mm5b9kzAw1wU0TwIKPOdDJsErje/p+yzPaTpwmI4Bn3mOUFYqo3kHltU3T7BnqNCnzq/tG0/7tzuydUBRn87FGIRayn+xYpfdu9e/ZM66Ep2a6gZhNIAka2mgJ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971431; c=relaxed/simple;
	bh=VzRE+mW6bIFbzTSbJl62fZ0E1L4ZozEW46P/80rxb0o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IwaifbPKqJHhGPyyWMKaZwXYAQEjHPSK/mSsZFYTzLtoXf6Q6tKBedmrpL/5B2xX2AtAiWrpfkmbdliEEgAVf5DxRcpCHNbZxFTKYrRNQ40T9tIPAhGcg8nMaKKNXljsCl6pItR8TuDBnEIA3lBwQQ4pPm8VNONKKZPie4RWBKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KsrVT58A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I5ZrecXX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KsrVT58A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I5ZrecXX"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9Nnt2247689
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hLZiCfxmYB7bwAfCoP9oXf
	Q7q5N7blEMsw29C0ndjAc=; b=KsrVT58A3vyj+5jef5IiPl0i6m8qDgl/iNXQSW
	F3Ev5mFrF3Zv0r6KykFnSlFdvSqPogXRq/+/dVmHJNOe0BfYWphp2R5kzAZV0sAq
	DAHalhYBwgiI+w5cpsogw6LEqmATD2+RKNBZ/7sWSYWh1ZeBme0zjIq8pQ3tqBwQ
	FKWjQU5r1yx66R/96fvRTbj2M9kpjZ6rie001SbqxLEk1xTwJzIEJIzdKYSb8aHz
	QwyJlOSSLF8zIUkw4KI6LPmAdkWxtFwOTTtQ5D4a3g6l7jrBmnvariHb9Silo61N
	2av5kJhNQCA6KkGiILoFnkR7hgn+fnF8HfolkXSR+odJ/b1Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk3jc3s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37d4f23eb37so5743705a91.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971428; x=1784576228; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hLZiCfxmYB7bwAfCoP9oXfQ7q5N7blEMsw29C0ndjAc=;
        b=I5ZrecXXx17Zd+nzANwRpYQQAAHbhO+fBcIZCAnSsHGX8kwDEucglUOaPdrva0yC8r
         thxVIZ7nvN6q/uB4LcrFgitpqxLWxhKApYty2YrIdibOuP/rrvUCKUQirfO/zTI16luB
         X2rPE72P4F5eLr6r2qeBf2HMoo22lCnV4SWlD8HGn5Bpk1zkeuhMC5CYCqKS+diUTR0m
         aFYsyMxRWCicwnG/noJGOha+lJ69IQsCPrJllaHgxNs+fEkJ8hD8DT47xAI3MlaRIGD/
         7DV4xORxTvsnjdalD5Dpy7x2XUx5YWE02vzFhE8UsAAKDmFHYGVm/eK7/AFrC0/5igWc
         F3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971428; x=1784576228;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hLZiCfxmYB7bwAfCoP9oXfQ7q5N7blEMsw29C0ndjAc=;
        b=UphSlOiTU0Xt71mRV2Ed1LNLpTTeL5dFuLX4gXEo2oh5LsC1hIpXuZt+DO6D9GH3Bu
         38PCryIFDm5sVZ5xgYu//mSzLXR9FNx66Z6NnrNnin36BuZ+CfpIIECevHfatY6dPMyM
         B6wvFhhjHJRtL470UhLI2n+2TJcKY37RSNfAR3nPs7Bfy+a3O8qRZBe9SzWVQEruSaxb
         5uOEWIXGBvwD1t/yqZ28KXxTD9W0VumvLd0+DfhNBvqT2+U3BEyIM1jlwDne3sKz53gc
         qsbB2Miku/sDbgV2MPsLC5WqQlLzKa0n7bLSb1H8UuQxB6saBi+Ap8pugAIx5hnmceza
         /P1w==
X-Forwarded-Encrypted: i=1; AHgh+Ro8cRKt2U4sItfBa+qD8VLa92VNt15WPxlaJlSbUK37SAE+8qxHFFwCd05Vqvqg9KVj4iESM0uu7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw68plaoe2kO5A5TuMpFM1eNZy/llTYu/Z9KgxfExVopPJ4Jw/d
	27htAOirfHpNLSm8CDHamMoUnAMN6Bvn5kZ/5rEthA0Pjk1kA9hZ3/GfQQS0JbaP6S4Pd1n/Iuv
	edLEj7Ujfj/nkBRoxn/r85Ia2pWnStZFi71OTvrO7yvC42CLhpErIZfFibE1XgA==
X-Gm-Gg: AfdE7cmXy3bABOlg1b1VNQutn6cIWEkG1nbVw4XkU0RwqBfZLdr0+aRNxQV/wEywbnv
	SMFYQnFIf7ygiOWW8A3Uwg5nPgE7URXq8pEJyirGBR2bUc0Z+/26ISPwYTXS+C/+T8JZXD1RcEK
	utssKM2DG8CJ6Odmuc3467vjhlUmnFKiqIDtn/D+hwX+1iE1aVeo2zRDLXJywHS1T0Gpi3pxKaL
	tNoNOUDiPctzFQCFpUFSYH5lrvw6m2WdI1GH7MVlG98VWFvlFeR8JmthszljUJ85rotSN2YajDv
	OWm4K0doMf+6zDFtgB8/gYh78twyOzmVwnrWaQqQo99NNeDeyxrvvuoAm5awi/6u5S9nO81hc8i
	HoyFV/2Dxt2zjDcen7oz5/PXz7g==
X-Received: by 2002:a17:90b:5590:b0:38d:a8be:a592 with SMTP id 98e67ed59e1d1-38dc75e6dd8mr9410763a91.19.1783971428214;
        Mon, 13 Jul 2026 12:37:08 -0700 (PDT)
X-Received: by 2002:a17:90b:5590:b0:38d:a8be:a592 with SMTP id 98e67ed59e1d1-38dc75e6dd8mr9410732a91.19.1783971427801;
        Mon, 13 Jul 2026 12:37:07 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:37:07 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: [PATCH v6 00/11] arm64: dts: qcom: Extend Shikra device tree with
 peripheral and subsystem support
Date: Tue, 14 Jul 2026 01:06:49 +0530
Message-Id: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFE+VWoC/3XQy2rDMBAF0F8JWldhNHpY6qr/UbKQ9ahF67iRH
 JMS/O+V04WDqTcD98KcgbmTEnIKhbwe7iSHKZU0nGtQLwfiOnv+CDT5mgkCKpAoaenSZ7bUj7R
 nFDT64LjG0ERSV75ziOn24N5PfzmHy7Wq41p2qYxD/nmcnNjS7uhTPUCjZNZorn1r7dtQyvFyt
 V9u6PtjHWTxJnwyOGwMrIZqW6kZcOkZ3zH4aihgG4NXA2LgUXsTnNA7hng29MYQ1UDGBAeQRli
 1Y8jVaAA3hlz+YRizzmCD4P4x5nn+BQdED63UAQAA
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Anurag Pateriya <apateriy@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=4797;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=VzRE+mW6bIFbzTSbJl62fZ0E1L4ZozEW46P/80rxb0o=;
 b=5CblA/c4Gwk5lkwo72Dup0WlNN4P9wxPg5gycbri4vZAkzBLE1OasX4GSb2BXTcsQuZPvhqo4
 hZ2+Kx0nK3IDjgPfKRvsk/JeAOAxyJqzAZuLnQnRYnqdxflqWojVpmL
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: c1HgNwKlwSHVE3YRhwXO5g6j8aalWXEa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfX2bE5ePNwG9ig
 0rNJmJeFkk97hbI8BFVVVX0FJ0LGO4LGFl/facl61KE72DiVcqA9B+BkEE9C2U9m/YtUKf1FmVO
 VGoj6444AQ6VGkVw+2jq5ObZAXe3ERo=
X-Authority-Analysis: v=2.4 cv=e6c2j6p/ c=1 sm=1 tr=0 ts=6a553e64 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_oGjjxQr57uqCMXUvsYA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfX34bb4k9Z5JtG
 ZSXZ8CGYD7Q7jKl/74m3O6UbPcXJY1vtAQmEjbTSYgqWASiSk2j/krtDTUbXxyH103V6FBFxLmj
 Qpa/XQ3V6bdTTtjnNmLPqeyboOiym2S80CCXzaMnPrxo/SOW9OXFb5cGnTktrgFfuGdQ/CVmdjv
 c23nBRo1T/YWZv6aLynufTz71GvBKN3Shaqk4g+Oaek90h4kzPT/tTcIzfyyAGPSvQoRi43t26i
 /8tHsFYsTP2k7EePaxxv0jA443t/OwxDBhJtnRBkpBM7mthAgwDY/pfciGRTeW4cMrIQicrLAvi
 PC2pxvxcxZC0shfX3s+OaRYq6jRaA+u+D4jnmwhc542X/B+V/IBZIhO5StqIMpJrSxgffCNGvW+
 jMd+zZE8Q3RZaEzT6AMa6gYuoEY1QdVqwgZ7lrfg/XI/MwcinVV/tVu0/yt7dw45orxiqJyf+uH
 vV0LKNZqb5Z6bjHaUog==
X-Proofpoint-GUID: c1HgNwKlwSHVE3YRhwXO5g6j8aalWXEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130202

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
- Gpio-reserved-ranges to tlmm to mark GPIOs used by the SoC
  internally and not available for general use

This series depends on:
- https://lore.kernel.org/all/20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com/
- https://lore.kernel.org/all/20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com/
- https://lore.kernel.org/linux-clk/20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com/

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
Changes in v6:
- Collected Reviewed-by tags from Konrad
- Reworked WiFi/BT enablement into SoM dtsi files, including WCN3988
  PMU/regulator supplies, Bluetooth and WiFi enablement
- Updated gpio-reserved-ranges to document reserved GPIO functions and
  drop GPIO115/GPIO116 from the EVK reserved list
- Link to v5: https://lore.kernel.org/r/20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com

Changes in v5:
- Split the WiFi hardware description into a separate shikra.dtsi patch (Konrad)
- Moved common WCN3988 PMU, Bluetooth and WiFi properties into
  shikra-evk.dtsi, leaving board files with board-specific supplies and
  status updates (Konrad)
- Added missing CPU OPP entries for 768 MHz and 2208 MHz
- Added gpio-reserved-ranges for TLMM on CQM, CQS and IQS EVK boards
- Collected tags fron Dmitry and Konrad
- Link to v4: https://lore.kernel.org/r/20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com

Changes in v4:
- Updated commit message for first commit of the series (Krzysztof)
- Collected tags from Dmitry and Krzysztof
- Updated wifi fimmware name (Dmitry)
- Link to v3: https://lore.kernel.org/r/20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com

Changes in v3:
- Add missing interrupt affinity cell (0) to GPI DMA interrupts
- Link to v2: https://lore.kernel.org/r/20260530-shikra-dt-m1-v2-0-6bb581035d13@oss.qualcomm.com

Changes in v2:
- Collected Reviewed-By tags from Dmitry and Konrad
- Squashed cpufreq_hw, EPSS and OPP tables into single commit (Dmitry)
- Removed labels from CPU OPP table entries (Dmitry)
- Squashed CQM, CQS and IQS remoteproc-enable patches into one commit (Dmitry)
- Added WCN3988 PMU support (Dmitry)
- Squashed Bluetooth and Wifi changes into one commit (Dmitry)
- Link to v1: https://lore.kernel.org/r/20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com

---
Bibek Kumar Patro (2):
      arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS remoteproc PAS nodes
      arm64: dts: qcom: shikra: Enable CDSP, LPAICP and MPSS on EVK boards

Gaurav Kohli (1):
      arm64: dts: qcom: shikra: Enable TSENS and thermal zones

Komal Bajaj (4):
      arm64: dts: qcom: shikra: Add cpufreq-hw, EPSS L3 interconnect and OPP tables
      arm64: dts: qcom: shikra: add WiFi node support
      arm64: dts: qcom: shikra: Enable WiFi/BT on SoMs
      arm64: dts: qcom: shikra: Add gpio-reserved-ranges to tlmm

Sayantan Chakraborty (2):
      dt-bindings: interconnect: qcom-bwmon: Add Shikra cpu-bwmon compatible
      arm64: dts: qcom: shikra: Add DDR BWMON support

Vishnu Santhosh (1):
      arm64: dts: qcom: shikra: Add SMP2P nodes

Xueyao An (1):
      arm64: dts: qcom: Add QUPv3 configuration for Shikra

 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |    1 +
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts        |   27 +
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi       |   74 +
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts        |   27 +
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts        |   27 +
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi       |   82 +
 arch/arm64/boot/dts/qcom/shikra.dtsi               | 1682 +++++++++++++++++++-
 7 files changed, 1906 insertions(+), 14 deletions(-)
---
base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
change-id: 20260525-shikra-dt-m1-082dec382e7f

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>

