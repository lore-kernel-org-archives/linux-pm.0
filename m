Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE2B37C92F
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218717; cv=none; b=Ok4wN0vje+XS4G1ravOJ+aGAv88R6vREzENd6gBvH7j2JOPgYuZFiGN17CSI1ULi/tEwuWzCl/+T/WYuxaT+UCWJwu2SiZq9a5AGF4PZqM2WN5iofYI1lJF6HEsq2AGUcfFY6XQV8Vg3H171eBYRIJTz+mIrZD+N9w0WMWKQiJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218717; c=relaxed/simple;
	bh=nKSSqjQ1RPL6DEUk3dkrg5ebC3G5l0uX2VfsivKoSfA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Inqfi7ANHills6mdLOQlKmbqcq35cO2wWKHQknw6YVOD2W3jqLaO2xtNFdyZ7VBZBeao4JFYeppnRCKuIapviu5EsgomWU+VEB+1MBkcmCt3u3aURiU6fPqsrkwDkciZnbIeEVwkhlMkV3JN2psSTwfuPPpBkkWDF7QLjD3uPUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mr/JX0pO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BlHGHzWp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mr/JX0pO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BlHGHzWp"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJxZg2692349
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=l3Ygeb3T66TwieiyLUkouf
	a4XGR3kt1gi5YfLRJXmvE=; b=Mr/JX0pOSyNWskzx5zHQWkbKcRvgC/mW2OvT/E
	GrvSkgr6jxfuDZ0FML/6xswv0sVWSA3vBUHd0I5lQFUQQuZurN2+SR900RR/2yRb
	Xzdludk9IB8X2rpTYbZa77YHURgHnsWNZMeDzNt7+g0t7vU8mUf2DoNfT3HgSLTE
	6ezdx+1WlAXusxoS904Mcp/jV7b20ETAlxv1Vy5fDSXD1ep5xLpgZ1U9L0M9mvu4
	lqlGWQ8HQ8vPlm0t+u2YuVofu2UEkqcIrw0ERb65cIiwt4kBRYVdDfzxB5fzh+0Y
	yGG843xI8S27S4njYHdLWh+6PqLYD/dY3Lsf2Grsh9RVvEEg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetb7tech-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1d7886cdso139588221cf.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 09:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218710; x=1784823510; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l3Ygeb3T66TwieiyLUkoufa4XGR3kt1gi5YfLRJXmvE=;
        b=BlHGHzWpT6y4fH2oEG1h4O+ZoKQg4CrqZHLtqK7KNp6/K1T39LiFnRt1jND8xGs1gk
         k4pRCI21/pmjqN8DiIz5cb8zFSV6Eks43UOvImLLqIlfPkoKFICRKon7iPN6Tsy87XlE
         /tilhF1BMP+zfg57uvMDvykxJosrVrtgRKaQ2nElWlxysNYbQqrfNW0H43j/cO5vr3Yd
         zm2bL12q68S7uq8IQlsxYvh1GdLGRHVJUY8nXAN8VuPBLowlvZF4x4zEcbRUmaM9a0Gk
         g00UFB6hZgtvyzNQIUFZe8J3yra4XUf5JpUc2M9W74nwK2iQJwFo02QrySTyq6cTMivZ
         qLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218710; x=1784823510;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l3Ygeb3T66TwieiyLUkoufa4XGR3kt1gi5YfLRJXmvE=;
        b=ESvmG/lNH4GPYXsC1KNu1EMDRODinOG+K7BJd3KWMwLfsjUnXIg4YErnu/sw4Izdu0
         tttoK8MGuvG0x4jaAER6dvzZyEa26XJk25fFMAznmnrxWXQPDriPUGaB/MfaIkPRyJHw
         e+krX4sFoFQ139KumgY9iSVU+JYDd/nA1bQGh5V7d36+XTqvW+FP69AjwTcKSh0I26ot
         E/HX2Qkz9SMLMHHk7yV+eEp2TTDE871TScF5g2g7TCNr7ry+p3/h57clmKe2z2+LjAZw
         jCRM3khfWcIPudXZ24y9aJYWJifprRP1KYYH9h8wdK+Nh1Q/QheCOV9JWjeh3NBvB16S
         eE/g==
X-Forwarded-Encrypted: i=1; AHgh+RpDioZNAUTQAGfU+sBGm4UdOTMzq110vpcOsqKqNO4BtAXxKYZBOFsL+VjaGiatQ0d0YSRe5sE3kA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww3NR7G1l1EiujdLQcijrxg3Q8cGRKDoORcPb0fWFh4JWjAJ2c
	uyQ8oArG7UAwOd+/agGZpp5w7JuODLI+M+vMOrai/FUin4jklkHC99+uA5F9mTUdQvOCJP3H42X
	9OtiL/pPLBsWqhRja98sPTtaTdN96nzN87mX9RC1DDmkfx7o1wmWFxjRh1KadAQ==
X-Gm-Gg: AfdE7clnViwyefIDRhzffUY11rJqsy+pKPxlHd8KGnb0VYqHYvL6PFwK08mOP6p4Tmf
	vA2KDTJoAYp12g7fh7mCGBVRfPnDAq1BOC6BcWJVEmSpd6saRPzkQlQja3MsRwx3iGxA/rp7lOM
	ZZ3zj/VRINTlCnL1LfaDWn4RVZ3hITqI1RfU4jrWpa7WyvqfbnBSGKyyVF5/De+sts7fx+r8liu
	hMVeUwjU/cDVDS9BPMHFVps1WhYzkG3LK3UfWGpAfSRW7AGGCn8iXATOv7Ez7rgMOwqHcP/ADXt
	KYrqcMKq7GNXv/XR+EvxpVXCjIxuqwdjcuHHXy6tQiqnM3nVInIhyZKurTx8Tk2J0Zz9hU5nrjq
	Qj7CppKTXx0d6sxiz92hYB33sx4PKPCms1TrxdLpP512twVacROCctX3/Bsq+RDYjX8wwIev9FG
	LaAYT7V74IAo/WgRsWS59itkvIpXU7lz0FHLNQsRrM5VY5EzKtVtc=
X-Received: by 2002:a05:622a:1903:b0:517:9095:c31b with SMTP id d75a77b69052e-51e4f0a2380mr86437281cf.42.1784218704039;
        Thu, 16 Jul 2026 09:18:24 -0700 (PDT)
X-Received: by 2002:a05:622a:1903:b0:517:9095:c31b with SMTP id d75a77b69052e-51e4f0a2380mr86436211cf.42.1784218702934;
        Thu, 16 Jul 2026 09:18:22 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:22 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v4 00/11] arm64: dts: monaco-arduino-monza: Add support for
 LGA WiFi/BT module
Date: Thu, 16 Jul 2026 18:18:17 +0200
Message-Id: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEkEWWoC/3XPzW6DMAwH8FdBOc8o3wE0TXuPaYcAZo1UoCQ03
 Vbx7gtw2CTWiyVb8u9v30lA7zCQKrsTj9EFNw6pkU8ZaU52+EBwbeoJp1xTxSn04/Bt4eY8njE
 EQN2g6SgTnShIWrp47NznBr69773H6ZrceR+SPq3Zza2y552lBi43H3CCnkM9Q+RAgRlJ61aaQ
 onydQwhn6723Ix9n6fysmbVNiCsEzdXWTQ5A99IsqaeXJhH/7V9FdkW++iByFJW2elScsGoVuK
 QtYmR/yqG8oOyXmxqpZFbbXUrHyjij8KOt4ikSM2VUIWxnf5PWZblB9aykxm1AQAA
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX8PnFkqVrXBQc
 DGoPQWVf/kXc4ec7z+zIoTnb70ocs582DdeKYEE4MdPbp//TZoT8V6h9FS2rUuhRo8M8EOafoL2
 GkWd/8An3VfjuFZuQZNXNFGShQff97M=
X-Authority-Analysis: v=2.4 cv=dM2WXuZb c=1 sm=1 tr=0 ts=6a590456 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=SvWx0ZcHii_7YJoE2l4A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NyBTYWx0ZWRfX69r33zyKAlyQ
 AGQUFxCZr3iPOPSQexvxOBuyrpVerfTMvhwv6kf3ulVbDJHCs5YGqRNj6m8+GJMQ8CE+6zzY8PD
 g2XtdMD2h521vpDIiqT4uVad33Oc2fvhYJHe/VfLuS1yD1GjuZt24Ki88H5fee7elwNP2+6GsAS
 +EfbOxksUTnFv4vrxiToWvfw5PaXFFuEB99RzwwOEPOgBSpprkHONqJTUGRleXfT2GnCWBZKQsk
 UxQ21Wne70zMSrKhEwJ6b4arazl+WNf/TAXAEt420NAsql3Rtnj6LQbdeWrq492RjmCc9ljnMtf
 2HnQzhLPT/iAAAsQPCb+dfq3E9UeCxNoUfwnLHLQ8Cod0ruV8vzxlPKhQjdtMHHHWJ+mCKUGw5r
 WmjpMp2sSwnm0S1CpoXBjy/ilZT3F/H/ahGu1tq/NxTpXZzdvY9+b+Hzf/Ci3lzMqGBrS8B8pe+
 FMujqAYWUEzGYtBvJXg==
X-Proofpoint-ORIG-GUID: fffAeNtIzKd6BiurGtNTqC96quYp0TEo
X-Proofpoint-GUID: fffAeNtIzKd6BiurGtNTqC96quYp0TEo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160167

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
      dt-bindings: connector: pcie-m2-e: Add vendor LGA connector compatible
      power: sequencing: pcie-m2: Add QCA2066 (QCNFA765) BT serdev ID
      arm64: dts: qcom: monaco-arduino-monza: Add QCA2066 M.2 WiFi/BT support

Manivannan Sadhasivam (2):
      Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
      Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_available'

 .../bindings/connector/pcie-m2-e-connector.yaml    |   8 +-
 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts  |  64 +++++++++++-
 drivers/bluetooth/hci_qca.c                        | 109 +++++++++++++--------
 drivers/power/sequencing/core.c                    |  49 +++++++++
 drivers/power/sequencing/pwrseq-pcie-m2.c          |  28 ++++++
 drivers/power/sequencing/pwrseq-qcom-wcn.c         |  30 ++++++
 include/linux/pwrseq/consumer.h                    |   7 ++
 include/linux/pwrseq/provider.h                    |   8 ++
 8 files changed, 256 insertions(+), 47 deletions(-)
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

