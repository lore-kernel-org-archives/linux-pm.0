Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375BF3E1704
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544629; cv=none; b=cKkImvne6BKF7saN4ObzhO0+W1E6zRKpqh/PgOLqtTp/YCKczllq0V+N0abTeEybY8tegZ4utov2ye7CuXT0OB5XSbVji1baAcnBoawJBnbivGzjcsySh6usxVuYVRyk9ZGDYdPsAojBkndVvjLYH8arXhySLhmOEelnBONIL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544629; c=relaxed/simple;
	bh=ndGbwRrcy4NquZS34c1u/G7anx0+KiVyIxtxL55NCJ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rlu4CjqspmmeD4nV6MHhs1/cflIk85aT0MzJVYHehaH95YcyFSStshuDriIpTWSLIHA94bfRSFNXwlRWkWZaQ7Wg4pvvRu1l8VzLzBiQJqZgIuA6dAaKhChXG0hxMEbcU25OK6mnQXSuwLopqjaOT27HyvU3cdmILZalcozZaJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fn7F9Sxw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GR+g4a8O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fn7F9Sxw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GR+g4a8O"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K9vWIP1941268
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kvPKWvJHNSLhHMncthnA23
	3T9yEk43en5WxFeOAvwMI=; b=fn7F9Sxw1Crzl3/T3/Jooj9uvQiR8FNhxCs+pU
	w2GUxZyR1sSzcryU05DDju25qobf2a9gWcRZz9qitsxUZdTNsmliky2FcvQPW1Dp
	Uq7xxqnCRSVwNPOUV+fhRsVeoirSl7Dshk2zMrEUtN9ukCVPs8wwqq1IcV4orFpt
	An36qb8iRoA89KmsJYlzTZYNYlQeCa13yuSwkZDDy7oBy4Zs8aHXevIMUqRLGxBl
	7Jp9IRlLronlVsS8R4nHda7IYOTwEEhodBGFQlx1zF4n76cml7FWrJr2kcJv0nJ5
	seXa0ZCHbBwlitxP5MPB/5YeA5OfP2yhlscep0BYcNBytMkQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhh5y08v4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:50:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cefa1a2be6so77810165ad.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 03:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784544616; x=1785149416; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kvPKWvJHNSLhHMncthnA233T9yEk43en5WxFeOAvwMI=;
        b=GR+g4a8OYci9+GF5YJDUSEtVvUMQcbfQ2TTDGK96qLroYzdkSsIXmOCU7taPM1Bn6O
         TEWe3Y7mjkfaxNbHy5zNoX9OMinTRAxxayGK1hp6ySGue760bEgBq/2vg1ltgSMxhE3z
         Fc3SCZ4Na4utwO5QXkJSbnUJExZs7vgz5UdkrnmS83ifs2CRVuN3JyEorrnGr90kNRl8
         hH6wQGiWMnDOaW1N4WEkGdgpU2gl0Fv50QJhgWj7iMYGF8I/EBrxEcL8NC2qaluobpuL
         3mZscJ/RC2KGBJjognV6tJT46y0TNoYeRwNTZFmrQCO+dJLtRsFngwZ/vsw271TpCM5U
         L5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544616; x=1785149416;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kvPKWvJHNSLhHMncthnA233T9yEk43en5WxFeOAvwMI=;
        b=VPIPlc+zDuZiFcovFVVqlQZWkZDDrfggpkTYi4mNQdk/DBY7Th8vAQcGEbfjCLBwLS
         +pN8V4BMPHAsATdKLruCDU/X8+0ZN+f75S7pcl71hBkpCRoEgv89NLljGwtRw5dyhFJZ
         EkTFjCFt/3mHKeE18AZTlPjeie1LKh8reD0Zc6bZAYD9KDMDp/Ltt8QAvVmSqrx6hBqM
         h0IPDYgONGIXHbpztsScT2JV3uSMnH7op6U6Zw+O9DlcsXS+JSemyZ/9V2KrWOuuAHYM
         kWlpWnnhQGFcgMp6jlh6KrI6zm/QfwCxgk6EhWy1106dkXPGogrTBclve2gWWIyIZ/SO
         AmRA==
X-Forwarded-Encrypted: i=1; AHgh+RprFZOQ8z03kQcT5SM2Y2dQq4LQUXARMugXD7/9hr2mWTA4tBePAELgFaHf7kFfwU2fxN2kNlfSyg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5sVJf7p4fML6aqF003vrVhKV6MlXCvOgSjX8SPMYxNkBDCHIv
	wQSqFerDbCRCB7wjFNouEbJ1U8zvUSwa6OE8xbqXrVzyunz1BhOy5QZVHBU7enObkAhX5SJPanF
	w1Gn4I5Y0Hvwfp6l7599h1m3dKzs73Zd9ZaEZJu/TJ3b4GNe6SmWIT0WXIJb9Dw==
X-Gm-Gg: AfdE7cnMnjPRjIIHwSMAt40nQxh56ICJ0l5iwQpPg24dfpnHMoVTPp3ImZku7UngKrn
	WLgNcpthCuR+LT8xgNThKhNoA/eT2aTeGRM9BA94YJfru2Lhbt7VhArpJ2rpNzl7s0Z+WzzSCtl
	tuTctLNCWqdrPuGnZo+4bWGMYrvNE8YTWP79Yyg7wKmvcJTAZdb06foEBNL0N1Q/RE08JKrCcP4
	KX89+pFZfmtuDyaL98XdaQ19L3/hr/xbtS4OJ6rOYRwn7BW8LRgU/bjt9Fyd5FsI62+LsIxLHOL
	+qFcmtIOmqqk9ROI/7E1BScb8GxyzQc9X2TQb0xgbY46TgsRLrBEtvjqWs79X8oCUOIOsQYfKr4
	+QNVkVtsxZXYsfQM=
X-Received: by 2002:a05:6a21:4a97:b0:3bf:7e2a:e874 with SMTP id adf61e73a8af0-3c3ad6682f3mr14674064637.1.1784544615877;
        Mon, 20 Jul 2026 03:50:15 -0700 (PDT)
X-Received: by 2002:a05:6a21:4a97:b0:3bf:7e2a:e874 with SMTP id adf61e73a8af0-3c3ad6682f3mr14674030637.1.1784544615282;
        Mon, 20 Jul 2026 03:50:15 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb5159b11a5sm4343368a12.0.2026.07.20.03.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:50:14 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: [PATCH v7 00/10] arm64: dts: qcom: Extend Shikra device tree with
 peripheral and subsystem support
Date: Mon, 20 Jul 2026 16:19:16 +0530
Message-Id: <20260720-shikra-dt-m1-v7-0-7dc99100c6dd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACz9XWoC/3XQy2rDMBAF0F8JWldBGj0sddX/KF3oMa5F67iRH
 NMS/O+V04WNqTcD98KcgbmTgjlhIc+nO8k4pZKGSw3N04mEzl3ekaZYMwEGmilQtHTpIzsaR9p
 zygxEDMIANi2pK18Z2/T94F7f/nLG662q41p2qYxD/nmcnPjSHuhTPUBbxZ01wkTv3MtQyvl6c
 59h6PtzHWTxJtgYgu0MqIb2XhnOhIpcHBhiNTTjO0NUg7UoWhMtBmkODLk1zM6Q1QDOpWBMWen
 0gaFWo2GwM9TyD8u5CxYaYOHA0BuDy52hq+ERQasopLX+H2Oe519YrBVLGAIAAA==
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784544606; l=4780;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ndGbwRrcy4NquZS34c1u/G7anx0+KiVyIxtxL55NCJ8=;
 b=SF3zeHdHt3PU46lTsfMnePbCe/suTpCbKczUiyB+pDNEs6oKpmhxR6YCGu4Nnczh/2kekAmI4
 w15wzKVCs1sBmesxu+fdLsUg0CZQBYpDjmALJ/GaJpOwuhW/VZQ1Hog
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyMCBTYWx0ZWRfXzweuBKn13eAS
 bns9g0vjRqUgAAgnGY7Mnx/Cdfq2ip2KyMIOfqkmT54TW6OyXRxKqRsxtMTDEpc0Eweoe0YLGg8
 ULf2iCARFvrS2CloEZFiSxFm/mnQSvQ=
X-Proofpoint-GUID: fThBTsHcj-W1xRWMKzJhmoc8BLxcAeEF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyMCBTYWx0ZWRfXwjKgmm698sgE
 hCdBSpamiBcwRoS14vuoD5Dp+IWLphtKs2++J2ODONYfyA1w7hzvICo8Cg8gwc+MT7+JngHTKj8
 2T/5iW0vR7HiktR5h7IMCGfklWueJ2vYcljaTmuDvzR+OetOkxKHLDixNv3D4s5C/nN7izpmbKy
 G4Xh5GOjs1Nd7L2vE1Dvj92k7P7tntOCSxDu5NpUTqc8uJ3JPpqpoawkr/+9s0+OieyvFQt/sta
 62fvedvlk6Hjlztcs9vFfO+ItWvPRaO/Zfyi+1omo5M91K9BBFH/o8KXKAv8FiLKbpNW17bhEAr
 DGh59sn9hG9EiFKgb5g2bW2sFkm5OUgHEZhKCigSWMBTlBz58FeANzlGq2FvimhvO1WTNyFbfkD
 0pRa3YndW/H4yFw1+z6nzujIvS27tc17RY//rcKPCnc+JI09TFugI79m+o7snwCwwvymHJ+k49k
 TxE8vfDUobjHGhrOlqw==
X-Proofpoint-ORIG-GUID: fThBTsHcj-W1xRWMKzJhmoc8BLxcAeEF
X-Authority-Analysis: v=2.4 cv=f/x4wuyM c=1 sm=1 tr=0 ts=6a5dfd68 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=esFleGvXc86k4vwuY34A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200120

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
Changes in v7:
- Dropped cpu-bwmon DT binding accepted upstream    
- Collected Reviewed-by tags from Konrad
- Minor nit picks from Konrad
- Link to v6: https://lore.kernel.org/r/20260714-s

Changes in v6:
- Collected Reviewed-by tags from Konrad
- Reworked WiFi/BT enablement into SoM dtsi files, including WCN3988
  PMU/regulator supplies, Bluetooth and WiFi enablement
- Updated gpio-reserved-ranges to document reserved GPIO functions and
  drop GPIO115/GPIO116 from the EVK reserved list
- Link to v5: https://lore.kernel.org/r/20260702-s

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

Sayantan Chakraborty (1):
      arm64: dts: qcom: shikra: Add DDR BWMON support

Vishnu Santhosh (1):
      arm64: dts: qcom: shikra: Add SMP2P nodes

Xueyao An (1):
      arm64: dts: qcom: Add QUPv3 configuration for Shikra

 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts  |   19 +
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi |   80 ++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts  |   19 +
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts  |   19 +
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi |   88 ++
 arch/arm64/boot/dts/qcom/shikra.dtsi         | 1682 +++++++++++++++++++++++++-
 6 files changed, 1893 insertions(+), 14 deletions(-)
---
base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
change-id: 20260525-shikra-dt-m1-082dec382e7f

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>

