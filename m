Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A16400965
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756407; cv=none; b=tvobzkpXBkDnF9Exc7WLhvjjEmF1zbh/z3qs2qORYlwgsu5t2U48oC+HxQN1157JJO0OuIeSVf/rx0cTNSnwNmCKwN3fvU2GVrxqnlA+Ai9y6f4DyCe9daKM4daRmBB7JAZusnOx/kxdY5+zm9Ts5gk35t7HUg1bQzbPLaKMJgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756407; c=relaxed/simple;
	bh=Z54fp+A8rhz+1JCSRByQHylHOkiRPkAicem9dXygKt0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ranZ3qK+grq3yFihRYzIkXnVwpiD7v99H7TT0L22ciyLoOKzYzemjEf6BcGJVEcgzT49OGJ8qdOeAndH1InmernSVYoYNYGcPRQxAxkLaAZ2xE3cQ0+KADpPdwYqr4YBbTF7jiMTgumTHzPfh7ZS/wFRC1wHDgKNLaOdWbgSv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Doa3uNbY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JQXzWK03; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Doa3uNbY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JQXzWK03"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673AuKAN3960583
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 11:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZTV+8epRJQLqhCZuuHJEWE
	H/PCZ+clp0qR2Uq+u3jfA=; b=Doa3uNbYqSeGHanwlz8iLwlayQ+Ys8JwhjFsst
	IlkEfOwOSU2Vr3O6H1jiy5yG+3GosLdzIV8NNoDaId2XU9bdGFWA1anPu83r/9Zf
	0olCXdrNHrlFemLvSfyZHi3aJYEHTh93umHAADHNm0AD1fWtFuqRKzFkHXCfeQs9
	Z+udXQpy3iZGsqJfzu6DmNPh9N9SmajvT414XnJxHO8gh+qZKSiEL2SBWngd5iX7
	uvZ/ih4nvQwfGxVfe49XQjcq9QLLv/me+OzvvnXSU474BM1DrGcJOEndQmOU5wUb
	MPQ81ffcy00C0+GTE/oCp/p8CbOY4KlHApzpPB1KJuISV1aQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ft9fajxcn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 11:26:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c85798977dcso5543820a12.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 04:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785756405; x=1786361205; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZTV+8epRJQLqhCZuuHJEWEH/PCZ+clp0qR2Uq+u3jfA=;
        b=JQXzWK03VJXVIkbt1s87/BECEh1m48aem57BjQgufknkz6fRG5Oj6Eggvsr13kkP8/
         F/Jfyx9F7gmbns0BeKNLmtttLyIFBuGsQ2ubMqbtnmGaQg3CFTsGvCAQ6ZIvvDDY53RE
         zVPCwcYo35ioH/NbUSlCidxR6Q4WleY7SnSdyk2E9Uk7V1UuRlUHhwmTMXRxj7e7GwGU
         NHDBRBXg64KzAXSQ1FbMZSgFUPvvASMWDf9UpqmLG0lgekUs+uxzjGxxX60v7iUV4ho+
         l21xGQuT+atbVeVfLnYL+en4QhHdyrfBjTgR3L1NezHzkXEOvQYX2/51SlXr/7gQ9WnG
         pxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756405; x=1786361205;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZTV+8epRJQLqhCZuuHJEWEH/PCZ+clp0qR2Uq+u3jfA=;
        b=QnL/emaZnws7SqslQmqtS/SjQzxNwshVAIakscxfVSC4SD+MgS5ZbOmSFLoSsS+72W
         iAVUzjWHMB3GfUw4LwWqpgWx1rRHiawND5nxYq877DxeJ5ur9LnTV73OEgc7Cn6YYNWx
         Y+bI9VJYQu9ygewbmOHH0FJkdsihhouGmqUdmO5Q622RMcRCWl2j/dyDW7mEUM3HLoIp
         lYD34kDpI7h8LLoWnS2mlQSuG1XQ+R4BfAR0QwbLrbNzzXq7thDBJ51YHjk/oVjMkF2W
         PrVCsh/HAjgEWBI8bAgYNnBtlBCB04EDuDEbacTgLImh0VpAX/jyZx29j0ZVDDOvI6QA
         CrJQ==
X-Forwarded-Encrypted: i=1; AHgh+RokSsr6pWELFd0YpN1rOmG7jKo5HydLU/kjh66+d+DcD+7p6qzJT+dZz4toBfNnwJWBDz1PSJGjcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdEgAG4UgZQYauM23Dp7mVuziDs42cZT6YZqtHjkdSuItajwag
	fv5nUQp4KlzxWxHhVtpsTwdFgAh2f/VRtdWHzMp45vw0FqarveUaCPqJ0ZMVmmbI2vayjSVkbw3
	SAnuuLKTeRKETwT7CLC6Dz4GAe9DfirEZOmmWaxe761ybSAalu1jAlqvTEX8N6Q==
X-Gm-Gg: AR+sD12KSKh9hM322P5j1IV4tCOwzDcQdnEzwAKaov7mqlSBpearItl3pErcYLqzaxz
	WSvY5HaEP7LDTUk1a4NpyLHfbqkooY7MxqeREmzqtaHdNLNoBxSkJwJCEqNnSu4SXYr5TNLExj4
	fw0kwAJ1CbBWfHQETgi3LeFXn0h1WIl0BAJn/XUvjA5i/boFAMxKL5jPpsUFNat2L19A/MmmCMS
	GxeowVwzsQnrDzDrP6teZhUB25zhAYfuQ62zKXyDtXX1dPpH2uHbAnnlGfSmIOcP5usZIAiETx0
	3IjjDtgx6QufOMDYLO8tRmkEGXUxcIeI870QFm7HzUun4q3GL5qtJfH0Kv6bEMOLILSfRd470qG
	MV1D2hWfjzXgdVDY=
X-Received: by 2002:a05:6a21:4e02:b0:3bf:6c08:fb88 with SMTP id adf61e73a8af0-3c92a8b423fmr9502913637.56.1785756404927;
        Mon, 03 Aug 2026 04:26:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:4e02:b0:3bf:6c08:fb88 with SMTP id adf61e73a8af0-3c92a8b423fmr9502862637.56.1785756404493;
        Mon, 03 Aug 2026 04:26:44 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab132cc4sm29967043c88.2.2026.08.03.04.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:26:43 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: [PATCH RESEND v7 00/10] arm64: dts: qcom: Extend Shikra device
 tree with peripheral and subsystem support
Date: Mon, 03 Aug 2026 16:56:29 +0530
Message-Id: <20260803-shikra-dt-m1-v7-0-7fec8e777076@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOV6cGoC/3XQPU/DMBAG4L9SecbV+fzNxEBXBhgRg2M7xII0N
 E4jUNX/jpsOjaJmOenudM8r3Ynk2KeYyePmRPo4ppy6fWn0w4b4xu0/I02h9AQBFUiUNDfpq3c
 0DLRlFAyG6LnBqGtSTn76WKffiXsnr7u33csz+bjO+3g4Fn24Li/DJuWh6/+m6JFNJ/dTxhJEa
 8mcNdyEyrmnLuft4ei+fde221KmkBFnBoeFgcVQVSUNAy4D4ysGvxkK2MLgxYA68toEG70wK4a
 YG2ZhiGIgY4IDSCucWjHkzdCAC0Ne/mEZc96iRvArhpoZTCwMVYwqRlQycGFttWLomYHLn+pi6
 OCtZQBehXDHOJ/P/+fvGfhkAgAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785756396; l=5056;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Z54fp+A8rhz+1JCSRByQHylHOkiRPkAicem9dXygKt0=;
 b=KBp2hE4W079W9R9Svcn+Cv7xOkFttXolbWHLRKDmLhF39blO+eGlF74L/UqgPqA8Ul/vWtQO9
 +11+sFBmJqMC6XrTnG2I/LBC4Z52mrRop7AdWUXB4EgsLlr1J+M17wt
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=PZPPQChd c=1 sm=1 tr=0 ts=6a707af5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=esFleGvXc86k4vwuY34A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 4I5B-URIUKvfPCUZvppyHPpXm3b0bQy5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfX0kn3V5Cfklh/
 YR39wObYuCeaq9BeB4aGS3jgKpoWiJCW0QhVzNytxGUi5w8npnWxo5QrYDI3j2TsX8MnF9cqwSM
 MRlZdzqdsklfl16KKcZQ/Mb8HYD9PWQ=
X-Proofpoint-ORIG-GUID: 4I5B-URIUKvfPCUZvppyHPpXm3b0bQy5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfXxDwE/sA9VIPx
 whDkNu50OTA9uSa99DMjnY3b773s+VXZTd2ywXAAzq9VyjoEITNGUwcPJllexVGGk8R8rgLSIyL
 8SyyjN2JdY6MxDW622fj4DhbO+CRvVDLG6TJd7hLqgSxnyjgWcC38mLSfBRZB3d5PL0H5wzQz2V
 3sHhRfUIhmE499voXMsrfXktO8/6J0G5YMzAj1hV22xVUcF+9mRml12DFR6G7H6CItXiT0rSFQy
 4L/d+KU+PKRn/k7bZ3/ZF5GJs3lD+ulZBCYbkrX7x1EAAx1DamDzgIKWJcMKkExKNiYl62DGgxv
 Ykk6QS3t3Kytmc/WuaKDb6gbgjpbR01+ywwTVwC767enRLZ1Sd93oU6ZyhR9iF4PiB5RQtT86XV
 VirCJc1D0kWL32qv/Oh2K2x4bzWwwKBPxx0W76DbgaSibDWI2QozM+6jJQYBAvET0d29j2Wsa/t
 /D8p3gHsPztDIlmoYCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030102

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
Changes since last v7:
- No changes in patches
- Added Co-developed-by tag from Anurag to 10th patch
- Collected tags from Konrad and Dmitry
- Rebase on latest linux-next
- Link to v7: https://lore.kernel.org/r/20260720-shikra-dt-m1-v7-0-7dc99100c6dd@oss.qualcomm.com

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
base-commit: 415606a7be939835db9b0d6b711887586646346d
change-id: 20260525-shikra-dt-m1-082dec382e7f

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>

