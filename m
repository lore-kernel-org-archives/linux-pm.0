Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F894F55C3
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536545; cv=none; b=HTs3TN1Q5KL41/R3x2gvY+sFfr1eAwMmDWSuq7uuPgUgkQGeHDwbijEitg7wLMBT/J0yDIhImLeDVhaSjl2MYuXfrUkOBHNBg51blUrVKa3VYmeazyXOmaKR7n+asJsYRulmauW6Or4Pcmch6d51qujK3RMxxJh9tNtIhqFw0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536545; c=relaxed/simple;
	bh=6m1dLRMRYpGClJBzWkVNKmB42fF10wL8UP9BK+nR8RA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K0Njb6ruOuCedhZI2e3AtdZgSBobBENDR+/rjq3JkE62NeKxLvnce/g7giDD758CnsWhyfjbpevp5Jd6T0W5iHBBIA6qehC+nf5hdnrp2IChPCItKZMUICC9huLQBOkbQ0TV0PGTNAz8rtARSWMxxA+IxlyAs+kz8ANUesTh/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GHhF7Ckw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MURs99+H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GHhF7Ckw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MURs99+H"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684DgrgA3720004
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 15:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ct+oVOCA3OtR9WKc2Je1VS
	IcYhLwHZO6XZ2sp1l3mhc=; b=GHhF7CkwjMeCdHa/6n9/cpdCl6JvBqWGLRS3M8
	sAUu9BSTSvMzZoywZUSDph3iA2cktbfXZZAp/w+L5l9KyfmSgO74h+8Fg5OLU2CT
	NTpOn37KhiykVUsnp5WhRbJqQbj+cdSQTzfniZ8AWp4NGVTNLJlzM/ppHcVrWyx4
	IohREgDWc96oeEgaq8FQLEbc5MnGzDOkiCwBFIvGsnJTpZgXqrNv0r5aaLAKCADD
	41QdOIFUiZnEx9qUooPkI0cDuBYuQECrgrFE10gQeXve17w0EfkkEQ7zkNo5JRSd
	cpXnd3CECEZfaEXBAzAn0U4cLY7LWWzMxqV68tivb89sbAnw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfqqd2p0s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 15:42:20 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c7b0f8e40bso1223507e0c.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536540; x=1789141340; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ct+oVOCA3OtR9WKc2Je1VSIcYhLwHZO6XZ2sp1l3mhc=;
        b=MURs99+HYscMd/lftM6qO0z/1qc/Zn23TG/zRCKRC1RC0DAeA1nEUj/MduYCAT8ttq
         7A6UX9Khl1Oa/EgUvMmyYszoYEa1GLeVdmglmlPO3rQ9B0pMpXCdrUIVqwNSLSh1bIDu
         bRrtB1BQm5AcpGraUCZzKPFlyKzDW3bB85dlW17boEoedJO8OQp3hzP4FIAkdDMDTxWv
         jJp8eugUBXEvi7UWJWh5/g5upTzGTApmQMcCv3M5SL744kpE862MIlHD9nqw+XYhnW/j
         QrMDa+Ie6hdegynIlhSt4scY1ncX2wdwg1LlHhqmNgv1YDX1JCgUYxvcfxIPi+TompbS
         Bk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536540; x=1789141340;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ct+oVOCA3OtR9WKc2Je1VSIcYhLwHZO6XZ2sp1l3mhc=;
        b=W59QWeppQ4T80gUTmI/FD1pXYiU0vK7xBNHQvMyaJMOAYcLlUxdnNKUefCYeRmxgLU
         H4oHd8ZHSNOqm1/rI+RCWMbtYzAVQKT4/q9ndz0mvDVbpz7+3rH7bmht+mRjQPf6YNJ6
         zGLs2hQtpWK9ogLLZdlk4Z4F3Z287ZI1eozO8kIBWvMMU/2+03wPuEe4C2mU/yfFYTBZ
         +NIZfzQ/bFr8BEm0vHi6Mrf+XlZ56usYlmoYFRcKUKQZnTQHvaVwmZP2qm/v74s6aSkh
         Wp9RXqIQNbdDbr4I9vv4LD7O4IzVssdopJeEU/G2q2pC2veCbN2vC66Ib5NrMwDUPbFp
         1iZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhqIRwJmI9rEMx167ttVsa1xuoIbPpcZdJkwAKC7i6a86E2rDsSCg6OSZRZum4nQFi+hBLyZ+bFQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mtDQIZCxCxNUQ2M7hABQy7ze7/NJpRQ9yjUw+0hLueWmZs0/SA
	kWAHBMK5zLfk/AdJu5DQ3W1DW9zCVmYjd394eo1B158CsvqtfMJtMvHXI4QOgEQCnDQmMQu+tN+
	NG1xpvOc1VVLV5rIsV8X2JQsvNk/R6QrcpNypLi56j0w59d0kmcUttulASB1HSQ==
X-Gm-Gg: AYBFou3GidkkHb3vZLcGx3oF1MFLJ+1n4TPQP0MsiWhqIEYrvCpDIRlJAgyzeA/N13p
	mKWcDMcI/fxusaumBpy75bXgYIj5BzxYxR7+i13IIj8jBkuzs2kb3LsZZ6Ebz9JaTqsoiq181ZJ
	tYo03le9f7uhPdNdwuQNFYWq0KjJvdcbHTAE/VqdfGOeKclwjkmzKt0xU32Gjrq7GiMK1sEjuix
	T6j+n/Txl+ohPllcdwfWXG3h2L/eslQ+cN+bk2hg17zGW8AJ1iVVpiELeclF/PSShEqavSsYuYD
	eInbjEGzGm+a4GQfspXPnxoqXzLCDOvZkzYHVGLUgM8FSk3bnMsYBP1SmJlGngIpPJmFIZAUWyZ
	FG6LVXPJ/D0z8M3fChnCMO79uhNPiYUxQsXfFuzpKwxGYNEU731UYc1+Wsi4asuUf5j80lD/9G3
	4cI7Q/iD3V3DBx6WpRWP9EbNq+L/y1Hf/JTOwWYAWx6jCZ/+3OOVA=
X-Received: by 2002:a05:6102:554b:b0:786:4607:bdaa with SMTP id ada2fe7eead31-78a4a8983c7mr2708235137.4.1788536539648;
        Fri, 04 Sep 2026 08:42:19 -0700 (PDT)
X-Received: by 2002:a05:6102:554b:b0:786:4607:bdaa with SMTP id ada2fe7eead31-78a4a8983c7mr2708206137.4.1788536539180;
        Fri, 04 Sep 2026 08:42:19 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:18 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v6 00/11] arm64: dts: monaco-arduino-monza: Add support for
 LGA WiFi/BT module
Date: Fri, 04 Sep 2026 17:42:15 +0200
Message-Id: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANfmmmoC/3XQTW7DIBAF4KtErEsEAwxxV71H1QXBQ4MUmwQS9
 yfy3YvTRSw53iC9J80HzI0VypEKe93cWKYhlpj6GvBlw/zB9Z/EY1szAwEoDAjepf7X8a+Y6Ui
 lcEJPNgipgtqxOnTKFOL3HXz/+M+ZztfqXh7lIZZLyj/3Swc5tav+ILngTcBGg5ICjXpLpWzPV
 3f0qeu29WCTOMBDsQIWClTF7g0SOHTY6hVFzRS5fIuqikYwyuysC7im6LmCC0VPP9oLIAxGN61
 dUcxMebIXUxVsyKPVymjlnyjjOP4B0Xa8IuABAAA=
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
X-Proofpoint-GUID: MWZHWe-F-n93kBR8GH1-rUjjEsmjH7H8
X-Proofpoint-ORIG-GUID: MWZHWe-F-n93kBR8GH1-rUjjEsmjH7H8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX2osIKgrSQGzd
 BwBl5QQiF79teuCtfAntqihxXw69WrPmVdNGHUqHR0OSQOM7/8rzBVZgP6lVnvzlI3M9d/pTBl9
 iawOY8RCoOiyZc5FaHvGWBjQ3pKu2IM=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a9ae6dc cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ojWIPoK9sOC7OVCjIIkA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX4m36hi1HPsbm
 ZxpVo9RwC2VB2QUKIKHKOycqKNd1eEMfFhutMGgDJlESzg1I6pjh0nzOAjGwoxoWfOinj7uYyZr
 nLGOBx+jXuWTo1rcX2BgF4VNClQiI2PnCOMq+OtTJf5+bToC2Oy1NRJLKPR/AsyAqmmBKk1SyED
 4qE2JRdH3BVtBNdsfrsox5I638XlQkCjcTdyihSEjK3kdqBT2SKk+YQcgCUN0/Zeg10LNr+Yamx
 E7WtwDn1TcQmumHm72BddxgxhTKKf4SHdNcX3+DzY2KcUL9+IGdYc8ZwZOqdFK+op/eqdU1G5jF
 Vwvnk+gLZCbAtAG7oVk6W9T+D6l3q8cCS6VXJf/E0R+rkhfzhrE8XzDwx7Gk6pTDqaiZ1SRq+cp
 Oyor5jqg3SKU+QzpV+p7ro3/1I6n0eQyvr3d1qi1Sf3brVYj/bKZ7oVYa5bSsv5uDEw79xVcTrT
 dVMcSYsXQkb4X06Fp/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040143

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

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v6:
- Rebase onto v7.3-rc1: drop the now-upstream "power: sequencing: pcie-m2:
  Add QCA2066 (QCNFA765) BT serdev ID" patch and adapt to the
  pwrseq_power_on()/pwrseq_power_off() -> pwrseq_enable()/pwrseq_disable()
  rename that landed in this merge window.
- hci_qca: fully drop struct qca_power and move its fields directly into
  struct qca_serdev, removing the bt_power indirection (Dmitry).
- Pick up Reviewed-by/Acked-by tags from Mani, Bartosz and Dmitry on the
  pwrseq_is_controllable() API, the pcie-m2/qcom-wcn controllability
  reporting, the bt_en_available rework and the M.2 connector support
  patches.
- Drop the pwrseq-m2-bt prerequisite series link, it is now merged upstream
  and included in the v7.3-rc1 base.
- Link to v5: https://lore.kernel.org/r/20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com

Changes in v5:
- hci_qca: comment why the M.2 'uart' pwrseq lifetime is bound to the serdev
  consumer device instead of using devm_pwrseq_get() on the controller (Bartosz).
- hci_qca: note that dropping the always-on pwrseq handle is not a leak since
  the descriptor is still released by devres (Bartosz).
- Link to v4: https://lore.kernel.org/r/20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com

Changes in v4:
- pwrseq: rename pwrseq_power_is_controllable() to pwrseq_is_controllable() (Bartosz).
- pwrseq: move the is_controllable() callback from the unit to the target (Bartosz).
- pwrseq: add might_sleep() and guard pwrseq_is_controllable() against
  concurrent provider removal with rw_lock, matching pwrseq_power_on/off() (Bartosz).
- pwrseq: clarify the pwrseq_is_controllable() doc (Bartosz)
- hci_qca: lifetime follows the Bluetooth device rather than the UART controller (ChenYu).
- dt-bindings: also add the "qcom,pcie-m2-1620-lga-connector" compatible (Mani).
- arm64: dts: monaco-arduino-monza: rename the 'pcie_bridge_ep' endpoint to 'pcie_ep' (Mani).
- pwrseq: reword commmit message (Mani)
- Link to v3: https://lore.kernel.org/r/20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com

Changes in v3:
- Embed bt_power in struct qca_serdev instead of allocating it (Dmitry).
- Add generic pwrseq_is_controllable() API + per-target .is_controllable()
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
      power: sequencing: Add pwrseq_is_controllable() API
      power: sequencing: pcie-m2: Report power controllability
      power: sequencing: qcom-wcn: Report power controllability
      Bluetooth: hci_qca: Set 'bt_en_available' based on pwrseq power controllability
      Bluetooth: hci_qca: Embed bt_power in struct qca_serdev
      Bluetooth: hci_qca: Support QCA2066 on M.2 connector via pwrseq
      Bluetooth: hci_qca: Flatten struct qca_power into struct qca_serdev
      dt-bindings: connector: pcie-m2-e: Add vendor LGA connector compatible
      arm64: dts: qcom: monaco-arduino-monza: Add QCA2066 M.2 WiFi/BT support

Manivannan Sadhasivam (2):
      Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
      Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_available'

 .../bindings/connector/pcie-m2-e-connector.yaml    |   8 +-
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts  |  64 ++++++++-
 drivers/bluetooth/hci_qca.c                        | 160 ++++++++++++---------
 drivers/power/sequencing/core.c                    |  49 +++++++
 drivers/power/sequencing/pwrseq-pcie-m2.c          |  26 ++++
 drivers/power/sequencing/pwrseq-qcom-wcn.c         |  30 ++++
 include/linux/pwrseq/consumer.h                    |   7 +
 include/linux/pwrseq/provider.h                    |   8 ++
 8 files changed, 277 insertions(+), 75 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260520-monza-wireless-e6ce7f013f38

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

