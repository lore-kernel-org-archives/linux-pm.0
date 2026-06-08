Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3131E842
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924244; cv=none; b=NiMCJYlO2PZUf4N9Ehuzqt/ONX+gma81olITGI+q1x9d/f4VUO21Q6j8BxGwz1auoxFxjcRBBs9V7v5wkRoe93lzIz129jXS+7BaGcIxPExekQ/CaeVVsdAZRjcvLEvZiWA8Qv//r8BLNxPkOradAVZlQ69fokQ7Z2IWOj4Z8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924244; c=relaxed/simple;
	bh=mVBNnTb3Zf9XzYbnXn6+HP7psyxdYmGgrj6yj09bM+o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=djVtCoIGkkYE9KL0Fe6U2KnzghEzOfC8Ed2ihAwu/6r2QfuY6PxVcj/n2UZN1VxrjzZ3/q0itOqLZU5TCAEBD6pW8hl7Rcr5BLahfHFVQhZXZU30UKThcb+Y0kaJOviHSHynAoStQ6Q9zxQg8QUVMkoRi0FU5rUdGjD4jc5im9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UcBmBkPY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ucq8o4vv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UcBmBkPY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ucq8o4vv"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658BBsSP3459764
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 13:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Y/RM18weXSqgJL+zE3kaXl
	1XT664lohFQLrYIVtcLww=; b=UcBmBkPYlwuctRhuK13Fq64bKaUdscNsY8b4WL
	7bb/MQ1RRkgQzHrwB5cDDOdwRZGZGSNlmTh43NwWdXTTgirFcPGpwCJZgOXiRMIA
	EIthc18bTTMNaCtMD+DYQ3LuQRnw7bvskXgDQ/3gwVNZZYInrs+e4r1luZYNEZV/
	0W187EUPAUjDpUix7G818+v/lgKtDNgtB8x1Amr2q7CmJoKb0HPhk3s1jj5c+9D1
	RGKvMN1X1bEiB/p1/8g3IrxtL99sMfeTN+49l/sUn6oSta1/40QsoDq2E1s9zSqp
	pnE0Evv3d9g1/E012GpfTizztyZ614Z5TolQNhflUD9BnULg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun8gsa7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 13:10:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bf160f7191so25727955ad.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924241; x=1781529041; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/RM18weXSqgJL+zE3kaXl1XT664lohFQLrYIVtcLww=;
        b=Ucq8o4vv0adAD0cFUO2TKldbKbttD8LZxXHYgVkVd/GGazdEGlv4gMLfmpyPC2li5V
         Mjt23Hl1kNxfEJnneI2VHJpK4+InVmCHP3QtWEBu3bJiVc09bTa4TmhgBF7ZK7FtuUyR
         St4a/6HKDPbioc3kX3urc30bETqya0R7JFpUlwFW8Lchbbe1K7KUSCiyh26zt4i9xyAW
         m4NktQHTSbtIs/OQn+tzjpUievlSlWbOP9XYZ2oiERI01NFUn9AuQ1N2p/8Bamh8Uz6t
         fRXh/wcp9eBv8ccpFBixsVdCMJSlog9CMycHC3GclQGnK8pUL8pEsb9xZRN6LjbkLxga
         hiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924241; x=1781529041;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/RM18weXSqgJL+zE3kaXl1XT664lohFQLrYIVtcLww=;
        b=T0zICu481jlHEVN9E/7htFuzqR7Q0i1glvEf4PVxWN0t/PYSHQ9zBOrd+wlwsWNU+0
         yZnZS0+I2AOyWsupaqiWS2EO9wloyl49IBDZaxaf56RAI2lr3Tbbx3j2OgjbJhGkwEto
         ADE2/Uec0KYid85mnNx64aCZKu9SOWYGdzHjHYlAZupa8qppAP7hm8NCvdRm19+CBIcS
         3VQq43kRM9fpXtPeYVaR99yuqZJlYGQc4UTF8HlmgFhujCnKDWPW3dmJB5fYMuDePQCe
         no/r1BsH75OkbkJJ2KSMqRgLiwiNtb6MsQHaAsQWOi+EYxAxy3X1NWGENSB3kgORjPyr
         aajA==
X-Forwarded-Encrypted: i=1; AFNElJ9Wa16cyzjah83r8Whqh24DqG+/EwRPw8RxdNA55byxlz8LgUmXcdN4JlkR/qiXbq5aDB74vgSoqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgwgXlVw6/98jR7M7ZPG12lAF+VAp2TN4gjuZUFYE0qS5+Aae1
	BDoBJ37n16OGhqN8XroocmeXFQjEoDrXl6VAOSDxGwKf/kWenhAeXKPfXoQI+6u6UoScFlQBjw0
	FayqxBfoc6DBk999yABAKCdN6RjNHdV2rqph9cgMRo8MMtJ0N3GISbAhQD7xqwQ==
X-Gm-Gg: Acq92OE4AhvbIlQU47BDlLxsoYAlAImtZFMVktIQN5MiDGjch7L/ksUCzDz4Z2fomjF
	jRVqPqV6eZ0FK5RFhwKTtuKjPH7iXEbb5boRsUebN+CtI/F4Fcs8FBeuF0Ll1u+f4oAddIqaGga
	qIEp2TqIJdNpC0vVc4DTMtB/1cA//5j7IC8JJv0QNicqPJfBgD6sgvTD5qMbH4E3K9AW9NK+0nO
	2N4rSGV6p9l2Tk+OkLuqha2zJY7xagaKhX/sjF/CbI/CqwD98R+4bQDPqnApPKGU/LdHQJy6qtS
	uEA93m9+SWansO6fb29UNYTaLk8kZI5UJWdHr2AIzMd6lzx9colkNFHxeugICsuJk/mkIsVuAjE
	Fzhf6PgnGB0XNpK+4PH1OoZx9msALj7caZ51KhJgW7NG8OWw=
X-Received: by 2002:a17:902:f70f:b0:2c1:d49c:8397 with SMTP id d9443c01a7336-2c1e7b0748fmr187343225ad.12.1780924240854;
        Mon, 08 Jun 2026 06:10:40 -0700 (PDT)
X-Received: by 2002:a17:902:f70f:b0:2c1:d49c:8397 with SMTP id d9443c01a7336-2c1e7b0748fmr187342415ad.12.1780924240215;
        Mon, 08 Jun 2026 06:10:40 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm185235845ad.83.2026.06.08.06.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:10:39 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: [PATCH v4 00/10] arm64: dts: qcom: Extend Shikra device tree with
 peripheral and subsystem support
Date: Mon, 08 Jun 2026 18:40:20 +0530
Message-Id: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD2/JmoC/3XQ22oDIRAG4FcJXtfgquPqXvU9SgkexkTa7Ca6W
 VpC3r3m0CaE7Y0wwv/N8B9JwZywkG5xJBmnVNLQ10G+LIjf2H6NNIU6E864YsCBlk36yJaGkW4
 byjQP6IXm2EZSI7uMMX1duLf365xxf6jqeP28o93iSjbNAxlaCKaVIJVU3STJ4xV/AfEbyLs8e
 MqCFQAelFemm8R8htOxYF9WLvUh9WtqbGQMUDrBsZua2RCXt0Ur3JWy+hQUOLcRZXQ6wm2VswW
 pH7bbNHYLhVqC867V3oCNRgAzkknmgsTghedOhdBqSc7dbFIZh/x9ab5ecC5nvuSp9kwjNNZoo
 YOz9nUoZbk/2M/z3mV9Lt7EHwzBngxeDeUc6IYJCI34xxB3Q7HmyRDVYBFF1MGgl3rGOJ1OP1W
 HuMVTAgAA
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780924231; l=4807;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=mVBNnTb3Zf9XzYbnXn6+HP7psyxdYmGgrj6yj09bM+o=;
 b=al9J6IyfNQuFiE6iIROoj6ihF4uOXzfJMcaHRQghleo9dtd0p4zwj/hTNl5CyVilEIWQc3FDp
 pYDoSZfN3ccAJYviO0N3Se41ySvJZ+RmHO4SxePQ9U1bJZzs2STENIk
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX2tIxRDjMmStB
 qRa/LH13hCeItDiowJq6VWziM4imsdzq5iOwU3yhNfyX561PkwnjBZfwMF/WQfa9OgavLhE4CBy
 r/8gU674yMBEBZA7OQpXKA8Y3xCzbWB5iNkCEF6yjgF7svLMkBDhppv+xif1jlj+YPxrfMiUSFK
 T62NL2X3i16u4nHDvi4gw59ydl/b8lP0YNGVKnqRHVy93PxTlNe0IdMKOR11PCeYrkLvhRFmNEo
 SfLgdsSJK+zIRs46odaaG0TAOS1bpR1NNQY7BOCjsfazwgGFCfvrvGL8hc63y4+jmViDrTCtQew
 ut7zdWBj/ojvoekbL1zgf5UiMYKMifbbe2UT2CXLDXXtGIp7Z9ciiQ5+mv4avDudSjBHlbeoQ6/
 ogvz5E+FQzp3HQbN80KSM5snHv86xQbXii2Lg/FEesvPkyMbZiurK8QZ424ELzxJwbCuR9OoJ25
 jTJ7l2Ofs4EvNbRVsDA==
X-Proofpoint-ORIG-GUID: 6D1YiPZ1PsBXtqdEjD-_1Q0YGbTx3lIO
X-Proofpoint-GUID: 6D1YiPZ1PsBXtqdEjD-_1Q0YGbTx3lIO
X-Authority-Analysis: v=2.4 cv=Z7rc2nRA c=1 sm=1 tr=0 ts=6a26bf51 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=F_wByC5qsg8vutzaSOUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080124

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
- https://lore.kernel.org/all/20260527-shikra-dt-v4-0-b5ca1fa0b392@oss.qualcomm.com/
- https://lore.kernel.org/all/20260521-shikra-rproc-v3-0-2fca0bbe1ad7@oss.qualcomm.com/
- https://lore.kernel.org/linux-devicetree/20260513-tsens_binding-v1-1-1780c6a6caf2@oss.qualcomm.com/
- https://lore.kernel.org/all/20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com/
- https://lore.kernel.org/all/20260522-shikra-cpufreq-scaling-v4-0-f042a25896c5@oss.qualcomm.com/

Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
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

Komal Bajaj (2):
      arm64: dts: qcom: shikra: Add cpufreq-hw, EPSS L3 interconnect and OPP tables
      arm64: dts: qcom: shikra: Enable Bluetooth and WiFi on EVK boards

Sayantan Chakraborty (2):
      dt-bindings: interconnect: qcom-bwmon: Add Shikra cpu-bwmon compatible
      arm64: dts: qcom: shikra: Add DDR BWMON support

Vishnu Santhosh (1):
      arm64: dts: qcom: shikra: Add SMP2P nodes

Xueyao An (2):
      dt-bindings: dma: qcom,gpi: Document GPI DMA engine for Shikra SoC
      arm64: dts: qcom: Add QUPv3 configuration for Shikra

 .../devicetree/bindings/dma/qcom,gpi.yaml          |    1 +
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |    1 +
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts        |   78 +
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts        |   78 +
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi           |   15 +
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts        |   86 +
 arch/arm64/boot/dts/qcom/shikra.dtsi               | 1679 +++++++++++++++++++-
 7 files changed, 1918 insertions(+), 20 deletions(-)
---
base-commit: 6e845bcb78c95af935094040bd4edc3c2b6dd784
change-id: 20260525-shikra-dt-m1-082dec382e7f
prerequisite-change-id: 20260511-shikra-dt-d75d97454646:v4
prerequisite-patch-id: 3a689e8dda5fd2755b689d94d095806b3f2e6eed
prerequisite-patch-id: 2acc300a68ed8c5364fb5f2f7d28fc0d56ab07bf
prerequisite-patch-id: 2357cac636e019eaf14d6a493a1c72bca56fe405
prerequisite-patch-id: 2885f299e711582da312ca9d13983d296a3dd5dc
prerequisite-patch-id: 91af5f3c01e766a53ce8de69aa21847a2d6bbbf8
prerequisite-change-id: 20260513-shikra-rproc-0da355c56c69:v3
prerequisite-patch-id: 39475cddaf673b2cbbae703165a782916f199885
prerequisite-patch-id: 6f7f265abfbdffdc0a1fdc5a7e08929e4eec5b7a
prerequisite-change-id: 20260512-tsens_binding-9af005e4b32e:v1
prerequisite-patch-id: 35141047f44b4845f9d94618bcf26ec58ab4a0b2
prerequisite-change-id: 20260524-shikra_epss_l3-522afe4fb8f5:v3
prerequisite-patch-id: b5d7f75df02fde56181f576a936baf09d0a72276
prerequisite-patch-id: 3ce52e07ae57139c2e2b71a29ed7d7250f6fcc87

Best regards,
-- 
Komal Bajaj <komal.bajaj@oss.qualcomm.com>

