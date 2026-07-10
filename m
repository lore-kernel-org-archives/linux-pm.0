Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CF63FBB6F
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677455; cv=none; b=gSCglIW7UO89/ygaYXSzIMiVwV8wK3V6+gCOyqEqKJmdIoLogyX5E+/7Gzu6WOuI/WgjzFlMmNY/k14/zomXEuKT4KeYsY0AccFyixhRgEBiwxPL8TKeWdUqk+rRLjcjNRLAeBb5gM0GmIb9CddybdVtAG676ppVD5lPoDc0S68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677455; c=relaxed/simple;
	bh=BC1i5CTT8hEROlpRriYXpfyJBmL+KtWxwcFIQuJ74ik=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GPNiRHjnOJlzsJgV2OtR4ww4L2M+foPiJCwvGHRFtRw3oCaStaq0DCF8wvb99VbPHgajKZCT6uJCltmpy4hGZ9eCMZTvEKuDcuR2QbJCkdLq1rzk5tIbVWJrIbwZaHrsoT9GABTbPQRLQPm4V62gKVuY9SdFvt5xyJKtT1z1efE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fyf/j1sP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SWn3+Q8Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fyf/j1sP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SWn3+Q8Y"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dIfN172117
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eCe+9upivq7I1QkHqTrfks
	jrU/cl381iB5pepWLOaAk=; b=Fyf/j1sPQXJaruPX6ZgdSINKXnpfWASglcf39Q
	hd/RgeCONCE1aCcn6LmVn6sMYC5ifOpqnvhL1VW5MJKds+jTUoQIDbWz7RQpEC0r
	s6fHYdrO1goz3nIhC1+x5T8vVuPqAs8ZC81nSYftZCe5NgfEhSh+2zRoLI4f6URO
	Rkrx8LEil+AydnyakdpOUUcqIhiuCAlV9zRkAMe+HKi5IX4LiHFnJH8VkWBeuFxO
	hliK7P3Akc278C5aJii8WUJKZy4jHyu9Os/b+or1rHMFTWISvYZVbmSsCJwirR77
	vIH918QNKrlgsPDaAy0QQQ6giN+QSHtQnu++yL/0q5w5R6iw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwe9x98-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:32 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8eb8914e651so17968116d6.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677452; x=1784282252; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eCe+9upivq7I1QkHqTrfksjrU/cl381iB5pepWLOaAk=;
        b=SWn3+Q8YnbjgQaLMCHFwnUwRfumL1xp1UwF9eH53ml+QUZCy6K4tGFMs7xE0oNyrpD
         0EFvxx82/829oTRYys0umuV7vZdjgK4+JzB4pKbyoZXlC6NCLegPP4GCq1jpgDJKDfdA
         ZL1iYYQoeyEeIj/hZiJlto6fcHTbcH9QlTRBMm5QnArv4H6zrhyiJdeubzKXZ981IJ/C
         3yTautOETutiiBu3xNhT9f6aDN3oA2qrEyGC3ZdzHrN0rKtpRAcO50oqDfkaF+qhhomQ
         a147d+iagd+cDyvLs3ZOl2gvF1P7ycqiHXuXIPuMqBVHp0X37qR00d/LN/sxUVnc6Py5
         2V/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677452; x=1784282252;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eCe+9upivq7I1QkHqTrfksjrU/cl381iB5pepWLOaAk=;
        b=NtCj7gHub/wxEo8anqxeoHby6EzaHEGPHKjoz1xZ4+DYEuwDd0WuvetBOKzCCj8uTf
         Tgscv5gvuVSn6XKoR5Wmqnm7y3x037k+jnhNYL88fSfGDg9xbHSAIXAFO5R8d5MWDsTe
         Oio6iro0u/kKR7KOH+w75BgCcVcHUO2XCd/IXkDybPu2ZAUrWA4VHFIWbA7Zr7xIxLz/
         IQbywR88bdX7ynMzsyQTVyShxxlP/JhoVti1rmBNKdadWc4XLAEO0xQKvoYuELl1Ia7I
         6E4UKuAGuaAyt+AmbNRO4xhiu52s3PFrbetAbMF2qpLaSTkadkVmqrX0ZiKWsN++cRB9
         QQOg==
X-Forwarded-Encrypted: i=1; AHgh+RqCJSEHxsV4j1pTJqkCfVTZrRG2LMTP4VRVNmFChLqtlY4uMigBqyBkRafl3oM8ir7zdjP7pUJKmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiRyoG2xD7VU2I1jnD+F8EJDiQeIG1xuyBy66H+FD5wFWwW2dv
	yN1emPMOZTUKdlY+1LXMVwKEAOQxeS6TrtNFJg/bYZWQhbZyPpwb0Hxo52g7uArWBx5TVw30Isq
	45lyxHjANj70fOIpb3/lmgXRFc9JvJs1meOkGlVyTuZ5ga2el3mid60MskHl4KA==
X-Gm-Gg: AfdE7cnzc0OKr6OwJ05dntipNnYAOtYPUbmp6zAdZKh5WrpbZrvrg9lEIRKMF4B2hz5
	aa16nBoAXKMflH31sO6E1JKLh82yBp5LHLcXOVHWk26qNEyWSxWMSLTWa6qd04JEQhP9WL4iZZn
	oK9CQO8wXiQnDaVyFCFbtXOsJfEr+4cG2ts3f8+jfZkzuWvzv+HfCXDZXjOnJyBOoyx9c/h5OYQ
	TJ0l28p1xRl+rtF/mcT7vuwtcHbV7tM7JfhupYPPlqBPq5OSNubiLgqLP1pzA2MbgHzPrfX3H1x
	qB5YKdnMO2/W2XlUR+vTMT3G+FekXnIEBBkpw/zmhupMCI8FAtFWYONHlZPwcX/8QnTBLrze9t7
	HmsaL1Vsz0Cm5IK/ECVgNrmUX+KMYOGErqpkUGwUOs/enwZj+AoqbakTSCBYGMBwaYmXGZ/pvXk
	cTa5a9MCSOdVQdaWx5MyTLFAxG9IrV8kBI8pRZvi8HfyRfsrAprqmkkbswIhVaOeXJ9D+226/H+
	SNME9afuc3O7N9dcYJG
X-Received: by 2002:a05:622a:1c0d:b0:51a:8c97:fb94 with SMTP id d75a77b69052e-51c8b4bacb6mr108170051cf.61.1783677451900;
        Fri, 10 Jul 2026 02:57:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1c0d:b0:51a:8c97:fb94 with SMTP id d75a77b69052e-51c8b4bacb6mr108169921cf.61.1783677451484;
        Fri, 10 Jul 2026 02:57:31 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:30 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v3 00/11] arm64: dts: monaco-arduino-monza: Add support for
 LGA WiFi/BT module
Date: Fri, 10 Jul 2026 11:57:26 +0200
Message-Id: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAbCUGoC/3WPy26DMBBFfwV53UF+YQdUVfmPqAsDQ2MphmATp
 23Ev9eYRRdpNyPdkeacuQ8S0FsMpCkexGO0wU5jCuKlIN3ZjB8Itk+ZcMoVrTgFN43fBu7W4wV
 DAFQd6oEyMYgDSUdXj4P9zMDT+549zrfEXfYlcenMZG5TvO5YquF69wFncBzaBSIHCkxL2vZSH
 ypRH6cQyvlmLt3kXJnG2+ZqTUDYNnZpiqhLBr6TZLOebVgm/5VbRZa1/xWILLnqQdWSC0ZVJZ5
 cmRj5L0VT/kTZPtZtpZAbZVQv/6Cs6/oDoN8SCG8BAAA=
X-Change-ID: 20260520-monza-wireless-e6ce7f013f38
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a50c20c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5z_Ge3scFvwj-DIjt2UA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX/v6I+owB5afB
 tzNN6DJuwl8ff5PgWF+yByvN8V5QeAjFFwv3dKktp2mUR9hxsGNm2kOtSsfG+eC5riaEZvSiqOT
 uAG5t4bgU9sVQmPP7zB0t3uyYLT2pTXzofXq//oUesfFC2In3t1qIkRIsSkgB2qQWGhGpEesMDX
 CzQ8XJxy5p4o4pQDXCeUto+KnEBDSx6UqtFOOQeXUX6GYwjPyvjw78Bkp75JXRIpj6AhRIoAinO
 gqOJGQXFS0yOe4lDEHmJ7zNvnEM44wvF7p/cliEj6Vwq4zeu2BPAtc24PeARtWVq8mxxUOLo/7Q
 wm7aHQhxMrFqUEc3akmNoLmAPqZz76bJfvcXwyaPtsx8Le+Ju9sljJV8MFJRurdTNh5ajM24Mej
 mOE+ricWF2ePOpvuhznbnT/gRiBxrmXMtxo5kY/WhQBwE63JzdLkD5IsTylBsStylOxBXY3hg2C
 9Vrc8MgdslkuOI30lQw==
X-Proofpoint-ORIG-GUID: qR4E_pdJxEtpwRbl6iecGFoEVq0ofnEe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX3+nMhwOSanjW
 4a/xmLbwuoMnTqv8HG0OGdwOdAT74WhrnDrWfHH/TjVr4V4iUymqsG/sHLb3ET+KZaH8MUp+a9+
 wfCu5+qAKojdofp5x7LeqaTHNJ23EeE=
X-Proofpoint-GUID: qR4E_pdJxEtpwRbl6iecGFoEVq0ofnEe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

This series describes support for the onboard WiFi/Bluetooth module
present on the Arduino VENTUNO Q (monaco) platform.

The board provides LGA pads for a wireless module. On the VENTUNO Q
these pads are populated with an NFA725B module featuring the
QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
the design is functionally compatible with the M.2 Key E.

The NFA725B exposes WiFi over PCIe and Bluetooth over a UART.
Both interfaces are gated through the W_DISABLE1# and W_DISABLE2#
signals, as defined by the M.2 specification and handled here via
the pcie-m2 power sequencer.

This series models the hardware using the existing pwrseq framework
and connector bindings, allowing coordinated PCIe and UART bring-up.

This series depends on:
https://lore.kernel.org/linux-pci/20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v3:
- Embed bt_power in struct qca_serdev instead of allocating it (Dmitry).
- Add generic pwrseq_power_is_controllable() API + per-unit .is_controllable()
  callback; use it in hci_qca instead of peeking at the W_DISABLE2# property.
- Implement .is_controllable() in the pcie-m2 and qcom-wcn providers.
- Treat non-controllable BT power as always-on.
- Integrate the pending Bluetooth pwrseq patches from Mani.
- Link to v2: https://lore.kernel.org/r/20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com

Changes in v2:
- hci_qca: extract M.2 pwrseq into qca_serdev_get_m2_pwrseq() helper, called
  outside the SoC switch; drop duplicated of_graph logic and redundant
  bt_power NULL checks (Dmitry/Mani)
- dts/bindings: use qcom,pcie-m2-1418-lga-connector (fallback
  pcie-m2-e-connector) instead of the generic M.2 E-key compatible (Mani)
- Link to v1: https://lore.kernel.org/r/20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com

---
Loic Poulain (9):
      power: sequencing: Add pwrseq_power_is_controllable() API
      power: sequencing: pcie-m2: Report power controllability
      power: sequencing: qcom-wcn: Report power controllability
      Bluetooth: hci_qca: Set 'bt_en_available' based on pwrseq power controllability
      Bluetooth: hci_qca: Embed bt_power in struct qca_serdev
      Bluetooth: hci_qca: Support QCA2066 on M.2 connector via pwrseq
      dt-bindings: connector: pcie-m2-e: Add vendor LGA connector compatible
      power: sequencing: pcie-m2: Add QCA2066 (QCNFA765) BT serdev ID
      arm64: dts: qcom: monaco-arduino-monza: Add QCA2066 M.2 WiFi/BT support

Manivannan Sadhasivam (2):
      Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
      Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_available'

 .../bindings/connector/pcie-m2-e-connector.yaml    |   7 +-
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts  |  64 ++++++++++++-
 drivers/bluetooth/hci_qca.c                        | 101 ++++++++++++---------
 drivers/power/sequencing/core.c                    |  39 ++++++++
 drivers/power/sequencing/pwrseq-pcie-m2.c          |  28 ++++++
 drivers/power/sequencing/pwrseq-qcom-wcn.c         |  30 ++++++
 include/linux/pwrseq/consumer.h                    |   7 ++
 include/linux/pwrseq/provider.h                    |   9 ++
 8 files changed, 238 insertions(+), 47 deletions(-)
---
base-commit: aa61612ab641d7d62b0b6889f2c7c9251489f6e3
change-id: 20260520-monza-wireless-e6ce7f013f38
prerequisite-message-id: <20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com>
prerequisite-patch-id: f4a7d1957c1776051608bf3d808b2786606c1ae2
prerequisite-patch-id: 6cd3c33583a9af16b3f6f71517b16b32d8155b7c
prerequisite-patch-id: 0550c57d69cf112fd4830e62f4388db6f8bf397c
prerequisite-patch-id: cc10d8079e37ef0ba0c33d0984c95d76361df9dd
prerequisite-patch-id: d7f4bb2bb4498ac619e67a94f8b59119a5caaf26
prerequisite-patch-id: c00ce9095b2d3a412229796194828b55642d3d96
prerequisite-patch-id: 09600595c2e80b12eda3aae39af192847d0f03d0
prerequisite-patch-id: a6118ed2894c176780ba933750e1068f2819fa4c
prerequisite-patch-id: 1dee41a33e032094e8dda74ac4e0bada928573d7

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

