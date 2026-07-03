Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA689339705
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 05:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055037; cv=none; b=IxU6pb9ngi6q6Aji951takQVCNbFAm0h/3HkeiHPxneABJ/mQD+quxdHDJb7l27/nVfLb1IapgngGtfWTaUMmqK2fLTx/aUOD6vkMEUwgr5vuT8AKdInRRlDjSNs7o2i7qSPG5FA0aO2SJ1NVyjYiVxXdS6/47J+lE0fschMxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055037; c=relaxed/simple;
	bh=rVXcKV7+kz5ldKBXO/tHbbJCCqeIj4iVBlRaSUOippg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OyXQwHw4w2x0s9JiMoQFQOczNXUKidZA07ZEAYLTI8G2Qfv7Y60FP/Qk8KDBBqkXNhhOq74jMm2fdxfPZ9iW3yDQtwj8DCMAZrqJdNTMK2vmUS/PGaLFsP5e+DDGBitbetZi+K3dJzHQ7VWX8IEhtzhfOHcfNs/1QTvfq/wN+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kz9PX4ou; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D7jqo7Y8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kz9PX4ou";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D7jqo7Y8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66342V2d2701108
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 05:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NRBgE59QoTQV38VfgncqRJ
	YraRggkHBcu/Lnxj9AfME=; b=Kz9PX4ou0E2rzYJfU2YnTUQ9yhZCPBQNqiPR9p
	CEFvDPQWZjHGBADxTGLxRQqpJ0xB4605ahj3MquNKlSEoIwfn9qSQYiEM+G7JvH4
	ejAU3XxaBOVO0OhkPDQRMLKZJ5yyUZJlSyVZDopfFRao5i1BYVqOR4R9Zxt0SH3p
	rtN/n2J+N1PgsV0Kj5AxPnGAwhLc0MYB1TdeaODbQF+OU96HilRFmC0dg/PY2Zpg
	udjrrHUeXr69qolFQApg6uVlrvU826UNzdT3yUgozsVxmAc1+HzKSYXZzWd8PAhu
	hXwjqv7JeCyQlCRz0wdGOfuVoro8fyFJD8Qvx6a1kr9CqdGA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bma3p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 05:03:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-380a638fb5bso273474a91.0
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 22:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783055023; x=1783659823; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NRBgE59QoTQV38VfgncqRJYraRggkHBcu/Lnxj9AfME=;
        b=D7jqo7Y8b6FRz9ZPg9+iDqieoYuvmbG68XKkCUkwzlXth4Mi/deGtFmSiYvaDWOswk
         x/QPqGy+2cTgFIcGfqpKPWj3yT1HUAy4EaRUg4dIA5kR7KUOmXhRx1j0n8dldwMW46dM
         FV1vcXjjbR/BZgVsLUfCXJhJ17LETb10vHAkPsTRclB6J90aeTUW7i8uv9hM8yQ3gPmA
         FvoyFBQgYJAAqNlrN1eLeScGFwb5iU42147NbkmVw6XXg3hMQ/M/sTmJq+cN/AYJWmhA
         m3slKeVS938WdR8n9G5mQjq1B9HiX5L3hPs74hkpvF9d7x5tnFJe6L3eAChTwj5lGGud
         WpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783055023; x=1783659823;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NRBgE59QoTQV38VfgncqRJYraRggkHBcu/Lnxj9AfME=;
        b=nIoiFmnrg1Rob9NU71ETIth2ARLNuKV9Pl3vQ3HavUWDnX0664VHM6Tuxty09kBqvP
         TMcf89BJXeUY4hoZMsI1A328QyT+Hnum8kTTcapBA5lVPme6qz5lt+ywgBssUcIglz8D
         /IaxNErO8s/VpPKEr+yKqPBp//eZRfe8erRYJ3U1mLPdY/0b/ygvKXESMCjMKvfeUe6A
         dbM3LfPpqHVOgWC6I8iPAAkkmAEQxhlNcRiL1kYGqTI34lNp7tiQMfHn7KzOiiAEmobs
         VTIhiDAFWcVgfDxO7OXlIHkLlyyFKpjDo8W5uyDhRMJ0QAKELNnbPhArkqv/F7bdzDRI
         wBQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDbNmZHKFl/7F4IlPOmeTxSdJ7dBs1+J3BRb+5Wlgtzy4c6ygzcKayWkKorh5o3ktkqu3LRmZJug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjL1BSYH089Ud5ULpVfT/8SVYdrCyxkEDz7LR7BwpDjsrAhex7
	9fBuHr0+2f/O/3z1fX4lP4i9cX13W1bt+bZr2RVs/H8YavvFGXoK/JnBNYFq6uIeZO6omWEXx27
	i9alzmTl/QoxeNHgvJhrC7qIIVdTsBLzoljgdAt1IGe6Hkg65AdKxNMNMZKsPbA==
X-Gm-Gg: AfdE7cl+k/g/Yn3IX9firJL/E5fJTbnfPjgZ14mW7b9BP5/Zl+xw0L/zQAUUrwZlM72
	/ubmaguktZyILu76PJfbNjc2Ne6+R+b9RFoPry+FnuKWf5K4n7ibauLbfiIqKhBBeF7BjwJG1hT
	QxN3DiWPJVUZ0I4xxWcOWWTNP0GLU2bHUbClBpc3FK77l2+B9yimHYtIcnWi6s/xVR4EA5l8zxC
	OS0B05qCC5BrGOhjVD6rF2WLbdg0Kz82eJjjeKM8/ylKiJ9uq4kzmt9mn7n6rh0+DG35FOaeT0o
	zgf+D6+Z+iHicQJN+LvoNENDQTG9GmeseV/6HZ2GDuqkC0O/JsRLL31xZvUWtsk5HHwME7N0nk9
	1FMFRQYyGGEDTiYwwig1qFX1Am8W0vfPb+ZZJkn8M
X-Received: by 2002:a17:90a:e7cd:b0:37f:464d:ea38 with SMTP id 98e67ed59e1d1-380ba70e00cmr8071251a91.0.1783055022918;
        Thu, 02 Jul 2026 22:03:42 -0700 (PDT)
X-Received: by 2002:a17:90a:e7cd:b0:37f:464d:ea38 with SMTP id 98e67ed59e1d1-380ba70e00cmr8071215a91.0.1783055022356;
        Thu, 02 Jul 2026 22:03:42 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd2362sm16771941eec.20.2026.07.02.22.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:03:41 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: [PATCH v4 00/10] Add support for Qualcomm remoteproc subsystem
 cooling
Date: Fri, 03 Jul 2026 10:33:03 +0530
Message-Id: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIdCR2oC/22Oyw6CMBBFf4V07TR9QAuu/A/jooECjZRKC42G8
 O8WXOjCzSTn5t6TWVHQ3uiAztmKvI4mGDcmyE8Zqns1dhpMkxgxwgQRpILJGphtA7zkDSeaKkE
 USu2H1615HqbrLXFvwuz86xBHuqcfB2WSFoVkDDNZSVlyoNCpxauI764fzMWFgKdFDbWzFqeDd
 lvkX8PvF5EDAVZRxdo2rwXP/8y3bXsDcQqP+ucAAAA=
X-Change-ID: 20260609-qmi-tmd-383d30e1a60a
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Casey Connolly <casey.connolly@linaro.org>,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783055015; l=5096;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=rVXcKV7+kz5ldKBXO/tHbbJCCqeIj4iVBlRaSUOippg=;
 b=R2N3EEztkFyImqucagAgpKp8NzRoJaFo2Sly8zMCuJ5DzVuyF7baMMSOJEkNjXzA4AoxyDzI0
 fvQigP25c7XALoF87dIZF4/9xQBqzwSOoTuPeWkBpRKZn6kC7pLZ0/f
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-ORIG-GUID: TzX1BAGUhXi8MeyiW2UFGXKkU4OZVRiC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfX9b36PgszhYGG
 61xUEGhiOy+DLEsLWqUOCDE0tqY7fcjjIDpdKrjWqVDfQcNDh8heiV//RpDrC0Rsnwye737GzZn
 TD0r1v+4O1vs0qMkKsTJBLStf2pa4Uk=
X-Proofpoint-GUID: TzX1BAGUhXi8MeyiW2UFGXKkU4OZVRiC
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a4742af cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=elwFi30hILXyiLWNHsYA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfXz/ykH8dI2F7h
 GEzcMVNh2CdKDH06LWhIEHWrTH/8fDBVS5oC2Atkq2ed5341YdO91wSa8L27JtgyU6BGvsEl/+d
 CFOEyev6DKHBFv7RnLlZxpWtFq0guIVoZ6DO0LGZQT9Wv5noLbIsLbCdydmyRT32dE+blPdVfJo
 scgSRif99krKsPH7geQ0wC9lDmSiasMhp91AvVscmklWNDcVLRmsbqLRSC2lMAoc5OnQUgQdJ5o
 bj4R7++s8me6OOilrKXiQmnh1xCtAc7u/5lWoBiOvzdRG/GJ5cLQZzyMaUExRnLkomWOILsWBNc
 OCK7Xex5Rc8EuTsVr1vvA6XTTEr+cDFt4v6PvB2gt1O8woXIaQOHPlih3dunYML5COtNjTLP3Re
 7a3xXcWx5r6+e3UDPT+KkwR07KPmYX4QaffH6CX2YBkdHv0vWbZMQqHjjWmdv6DomPih/hUcWlO
 v1OhJwQTr+BL6LlrkvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030045

This series introduces Qualcomm Messaging Interface based Thermal
Mitigation Device (QMI TMD) support to control thermal mitigation
on remote subsystems such as the Modem and CDSP.

The QMI TMD is an interface that instructs a remote subsystem to adjust
the performance level of the devices it manages, reducing power consumption
in response to critically low battery charge, overcurrent alerts, or
overheating conditions.

The series is organized as follows:

 - Add a shared dt-bindings header mapping TMD device indices for use
   in DT cooling-maps, ensuring a consistent binding between the thermal
   zone and the QMI TMD driver.

 - Extend the remoteproc PAS binding with the optional #cooling-cells
   property to allow remoteproc nodes to be referenced as cooling devices.

 - Add QMI TMD support in the remoteproc PAS framework, hooking into
   the probe/unregister lifecycle to register and unregister cooling
   devices with the thermal framework.

 - Enable CDSP and Modem cooling on kodiak, lemans, talos, monaco and
   hamoa platforms using the new binding.

This work revives the earlier QMI cooling series by Casey Connolly [1],
with the following key differences:
 - Uses an id based API for cooling-device binding
 - Integrates QMI TMD directly into the remoteproc PAS framework and
   hooks into the probe/unregister lifecycle.
 - Removes unused code and cleans up macro names

This series depends on cooling device id support from Daniel Lezcano [2].

 [1] https://lore.kernel.org/linux-devicetree/20230905-caleb-qmi_cooling-v1-0-5aa39d4164a7@linaro.org/
 [2] https://lore.kernel.org/all/20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com/

---
Changes in v4:
- Drop the tmd-names DT property.
- Move TMD instance id and tmd device name into PAS platform data.
- Add a shared dt-bindings header to define numeric constant for TMD id. 
- Add mutex documentation comments for get/set state callbacks.
- Link to v3: https://lore.kernel.org/r/20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com

Changes in v3:
- Removed the remoteproc-cooling abstraction approach.
- Integerated QMI TMD with remoteproc core framework.
- Cleaned the macro names and removed unused code.
- Switched to index-based thermal_of_cooling_device_register() api.
- Link to v2: https://lore.kernel.org/linux-devicetree/20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com/

Changes in v2:
- Update Remoreproc thermal config to tristate and removed unnecessary NULL checks.
- Fixed dt binding file format and added generic name support for cdsp.
- Fixed memory leak and cleaned up qmi-cooling driver file.
- Corrected DT formatting errors and commit descriptions for all targets.
- Link to v1: https://lore.kernel.org/linux-devicetree/20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com/
---

---
Casey Connolly (1):
      soc: qcom: Add QMI TMD support for remote thermal mitigation

Dipa Ramesh Mantre (1):
      arm64: dts: qcom: hamoa: Enable CDSP cooling

Gaurav Kohli (8):
      dt-bindings: firmware: qcom: tmd: add TMD device type constants
      dt-bindings: remoteproc: qcom,pas: add #cooling-cells property
      remoteproc: qcom: pas: add support for TMD thermal cooling devices
      remoteproc: qcom_q6v5_pas: enable QMI TMD cooling support
      arm64: dts: qcom: kodiak: Enable CDSP & Modem cooling
      arm64: dts: qcom: lemans: Enable CDSP cooling
      arm64: dts: qcom: talos: Enable CDSP cooling
      arm64: dts: qcom: monaco: Enable CDSP cooling

 .../bindings/remoteproc/qcom,pas-common.yaml       |  39 ++
 MAINTAINERS                                        |   7 +
 arch/arm64/boot/dts/qcom/hamoa.dtsi                |  63 +++
 arch/arm64/boot/dts/qcom/kodiak.dtsi               | 134 ++++-
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 125 ++++-
 arch/arm64/boot/dts/qcom/monaco.dtsi               |  99 ++++
 .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     |  17 +
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |  17 +
 .../dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts  |  17 +
 .../boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts |  17 +
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  17 +
 .../boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi   |  16 +
 arch/arm64/boot/dts/qcom/talos.dtsi                |  19 +
 drivers/remoteproc/Kconfig                         |   1 +
 drivers/remoteproc/qcom_q6v5_pas.c                 | 120 ++++-
 drivers/soc/qcom/Kconfig                           |  10 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/qmi_tmd.c                         | 581 +++++++++++++++++++++
 include/dt-bindings/firmware/qcom,qmi-tmd.h        |  20 +
 include/linux/soc/qcom/qmi.h                       |   1 +
 include/linux/soc/qcom/qmi_tmd.h                   |  23 +
 21 files changed, 1327 insertions(+), 17 deletions(-)
---
base-commit: a87737435cfa134f9cdcc696ba3080759d04cf72
change-id: 20260609-qmi-tmd-383d30e1a60a

Best regards,
-- 
Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

