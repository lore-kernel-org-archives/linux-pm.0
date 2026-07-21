Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B15408636
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615362; cv=none; b=iutZTlU6gERUpjwWbTZTqS9i6OVHYUKhYSJFrJDCORN8y70hAgbSAxAHCSPJm7r/Cb92tXRcw2wr5CcgFWAc+sJKNpNAKXxmKCE1m++Ok5WOBhnFmBdsemGOr0UTf7omu1cze4XXGZdu9WipGrvRJHbyaYdDc45bi/VZAKq2KVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615362; c=relaxed/simple;
	bh=SB0uz/fFOkzPWejEdv5yGesB/rGWOX3SPX9SB8qqMPA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=epJV89TaP7ngfuKrh7ebTFBbaXCYJpEOBXxiFWPAO4VQoesGTyre/6wjs+LPRYRMytZWVVaoD5JGhpZgaoktSg9dctSnfmsTCZYgjRwxF1Sws3ZwVvxaMfVmIgkjEfzJQH6CgQOt4/htKdinF/Oa4ygiwd+EwOn7/g28jGvWxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nUoTKSHP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D/ROePIr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nUoTKSHP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D/ROePIr"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KND4os046591
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=w+ErVWErODfH4K2sO8W6VR
	D4KUYTvuaU+ADbi9EuYws=; b=nUoTKSHP04AuAUoBNkcsw0AfNQynI1JS3gC//r
	sB6K6ppIOFU9BCnekBO8EJpyV/0TbNx808ALfZtKa10wM4oAClwyMYYtAG8igWgI
	rwmkYGEGq5iQKyuPwkxDaA2iK5SrYZ8y4X40DYFjd+kPnXQPZg8eCWPS01GzFPBb
	tFlxhDj8bcGi2zepUIcSV8HgTaQKRtL4F6yrdxiwcbnxjxpyV+E10Hi+gSPLbiN/
	eYKmFmlwZOErWlojQSsFdVzY9wv2BkuWYHu/K6e/ShV0ueiYZ0H1brfudGrjU3Vm
	nxmy/pWI6gV4zzpCd3d9DO0RfGs9aYr27Sqf6D7Ag30MVsTw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5tpas-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:29:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cee1ec30f2so103683735ad.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 23:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784615359; x=1785220159; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w+ErVWErODfH4K2sO8W6VRD4KUYTvuaU+ADbi9EuYws=;
        b=D/ROePIrFUTTYZ5JZYGpOB8zubczZ5njzrPlLa5aBoc5/3u+x4pqE1f6AGgh53Nk0C
         XR8iTqy04HAbJj5xNh4VWqodNTtdkuRiDwSbQdbvuq2Ak+9lxcFCnF8vqRGjEIBowWde
         KlyG7yylsaso9XQgpSQHt/AOLgNubhzk8nWDkVkOztp+XafSVAB9jXIplPwbusmA4NBE
         qtn2bcbWLBzuGxX3XlObT+QfeD0LFO5+4HkD0HcZIAen23dbvSMs6RrXKF19+natWpU8
         sPu67cc+mf2yQUk+zAVYpzDfYD0cpxSOaw+15xNukQJ9CrqxXXbntFGMfZ31AEG3MjY6
         +DbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784615359; x=1785220159;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w+ErVWErODfH4K2sO8W6VRD4KUYTvuaU+ADbi9EuYws=;
        b=pEt7x+8RL8K5rwns8qu3psVffGAdhQuBbAHb99mk9kB8MqL3oYjKYzEDtuDpWZqEmf
         RTWRWTs2TYr7Kcv4GB+BcqYPRUSoCL/e2vk6DWXmmPAInBxo/CZTTQbDT1tZ7Q6SOPCY
         E7QqXkhjR3gOhDkTvU4JvrUflrL/XO+mzx3eZxvYVfzVXWm0YeYSltFjliwH1UWI0lqS
         9CYFISiE3mejrjCAfRfOC/EV0QWLI2vSA0I5PFdHOS2w8b0qok+9TdtwbiRL4l/+ONa4
         q1vFWFub8PgfZHaYwsQ93rBR1Smi7tzsTw5pbelKApiCOuw3bMo7h0NPLbkJbomDMf/q
         dhVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp46hHSaPl5XYwxitrYupxnvt0FTvF1ZAYvvgNvGzNs3vYddw/jwd+sAlsKNZnFAM079A/6MHuKgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNY/d/db+SW4RUzEqPTKeVVVGvURBk9KyFCwm4t0h4ZBt4Ykh2
	9EQtHliRIab2Q5ON7r+eY22UuGe31WnYUmvbj/vxHQ77HrHvpkXb0C5Dw3qTY7x5qNtUnvsdV6o
	B+VwLtt6wMKL9rfnFQuznknakQHbMd5dlRBm/Fdss3nPkNSIubBKeEchhh7pLeQ==
X-Gm-Gg: AR+sD13JobvoootJ2YCEH0Un03nT9n6U5Twxo8efMIQj3bHgxJJNdmjfSjMb5o6IvnC
	uaNoDxlmrf41MIJnBFFA3JdVRNTRrv8NpYn2BhNn5Pg3QhA/R+DO4iriFCPTJjSontLBfIg1aSd
	62RChtyvh1uXYH3BMHlhDF9gB+lo5wx7Lek5V9El1isHmTQjZJWaikUEbCVke5TOMwPZymLtyJO
	TH5ypTxaUhWvUuvyN1NyAyxxiJj+8nGb8rv6VUn/bHe5kMx8bn5CAirvSgpP7cmZ99lzvNSwXAf
	ACso6USMRBpQxbxJo/VslfBdJDCZHTdDpleJFE8aBk0mppmTsjiU/HpFO1MUZG4d7jyHDqzwvE8
	7nggiSgqEQR66GBM8Vb+8g6cdSEkbXw==
X-Received: by 2002:a17:903:380f:b0:2c1:ea95:8297 with SMTP id d9443c01a7336-2cf3483687bmr179831535ad.7.1784615359004;
        Mon, 20 Jul 2026 23:29:19 -0700 (PDT)
X-Received: by 2002:a17:903:380f:b0:2c1:ea95:8297 with SMTP id d9443c01a7336-2cf3483687bmr179831325ad.7.1784615358526;
        Mon, 20 Jul 2026 23:29:18 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347a1201sm69376505ad.81.2026.07.20.23.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:29:18 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: [PATCH v5 0/9] Add support for Qualcomm remoteproc subsystem
 cooling
Date: Tue, 21 Jul 2026 11:58:57 +0530
Message-Id: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKkRX2oC/z3MTQ6CMBCG4auQWTukP6DVlfcwLIC2Moml0GKjI
 dzdSoybSd5JvmeFaAKZCJdihWASRfJjjvpQQD+0490g6dwgmDiyE6+xq3B2hIvTqIU0SlveCSU
 gD6ZgLL127NbkHiguPrx3O1Xf749h8m+kChlKpQRX555bJa8+xnJ+to/eO1fmA822bR94fYRfq
 AAAAA==
X-Change-ID: 20260715-b4-qmi-tmd-d23e8df1b282
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Casey Connolly <casey.connolly@linaro.org>,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784615351; l=6404;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=SB0uz/fFOkzPWejEdv5yGesB/rGWOX3SPX9SB8qqMPA=;
 b=K9h/5YTHg6f4jqt7L6GyvzPDmxqNAuBrJd7zszS2oNZWi+1gE5GoiL2tpPJiWV/VR3wPteV6x
 QdRnqG6E0idD/MmeZw1lljd6jQb4sacGssvlKj5YcUu6vI4Xm2f4127
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA2NSBTYWx0ZWRfX0mVBOom7Hoc2
 wd4Yt+SGpo6Bd7E/wVX+kdWoc+ILSwMVSDgVuYuhTMjhnmrE+/Ja7PYC0F6QRvWev9ac3ibX6yC
 ILhZ9j5f7SzQ8Dl4T/CudAorwR4Mndd8XTbEg80kAi8dGT/FdiNC5DBRM3aSSc9GYM/O56Ic5CL
 sB+qFRF5R5JiN/gMwpQOSB9Th8U5vv2AG2nUm+0S+9oa+PRh6hyH2uXTXcMzfaaGYcwXqhBHiyv
 N6QuAD4NGGNtAI6pOr7dyb8p6RNiWJ55UuizQz43AyVt+0B70h0aFtb6ybmydjGENFd078+oWfO
 IkIfCvj0MiI28hvpq7nFtALh+KiuuXR9ERGjLrAKFGMEV7oamBo2f0b0jJ56tsn3IDgEcQNiTv2
 cqYVsqlWVup2elQf4OqGt9k7t5EK7L0yxNWV7Nj3KqwmlynN/Jvqx7IwgGcBZnXBbWtEHvHBfK2
 ZdLWhifxsBSiD0w3U+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA2NSBTYWx0ZWRfX/3aIX+nmV1Zl
 lAA8V9NBXDzVb8urySLft2HtpRF2iTTqdTDgWwL07V9oUb5d6VN5mFKoS5Dfk/Z/koNUHKeIEIP
 4DojSMBzUqElA8Y5xUSuW2fOEBifpgU=
X-Authority-Analysis: v=2.4 cv=WNpPmHsR c=1 sm=1 tr=0 ts=6a5f11bf cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=myz9wP-PkEfKd50XNCIA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: r28cMriSpT4-7b5cuKxWwjx6X0XVYaLi
X-Proofpoint-ORIG-GUID: r28cMriSpT4-7b5cuKxWwjx6X0XVYaLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210065

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

Not all TMD endpoints advertised by the firmware are wired into kernel
thermal zones. Endpoints such as BCL (battery current limiting) and cold
temperature protection are handled from userspace via qmi and do not
require kernel thermal zone bindings.

The constants defined in this series cover only the endpoints actively
used for thermal mitigation in the kernel thermal framework on the
currently posted targets: cdsp_sw (CDSP software thermal limit), pa
(modem power amplifier), and modem.

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
Changes in v5:
- Added Reviewed-by tag (Daniel Lezcano)
- Squashed dt-bindings header patch into the yaml binding patch.(Krzysztof)
- Renamed constants: QCOM_CDSP_TMD_CDSP_SW -> QCOM_TMD_CDSP_SW,
  QCOM_MODEM_TMD_PA -> QCOM_TMD_PA, QCOM_MODEM_TMD_MODEM ->
  QCOM_TMD_MODEM.(Krzysztof)
- Replaced dev_err() with dev_err_probe() in qmi_tmd_init() (Krzysztof)
- Fixed qmi_tmd_exit() teardown order to prevent cancel_work_sync()
  re-queue race.(Krzysztof)
- Removed only MPSS maps instead of entire cooling-maps node.(Dmitry)
- Added cover letter note clarifying TMD endpoint selection rationale.(Dmitry)
- Added NET dependency in Kconfig.(Julian)
- Link to v4: https://lore.kernel.org/r/20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com

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

Gaurav Kohli (7):
      dt-bindings: remoteproc: qcom,pas: add #cooling-cells property
      remoteproc: qcom: pas: add support for TMD thermal cooling devices
      remoteproc: qcom_q6v5_pas: enable QMI TMD cooling support
      arm64: dts: qcom: kodiak: Enable CDSP & Modem cooling
      arm64: dts: qcom: lemans: Enable CDSP cooling
      arm64: dts: qcom: talos: Enable CDSP cooling
      arm64: dts: qcom: monaco: Enable CDSP cooling

 .../bindings/remoteproc/qcom,pas-common.yaml       |   9 +
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts         |  32 ++
 arch/arm64/boot/dts/qcom/hamoa.dtsi                |  63 +++
 arch/arm64/boot/dts/qcom/kodiak.dtsi               | 134 ++++-
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 125 ++++-
 arch/arm64/boot/dts/qcom/monaco.dtsi               |  99 ++++
 .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     |  29 +
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |   1 +
 .../dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts  |  29 +
 .../boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts |  29 +
 .../boot/dts/qcom/qcs6490-vicharak-axon-mini.dts   |  29 +
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  29 +
 .../boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi   |  28 +
 arch/arm64/boot/dts/qcom/talos.dtsi                |  19 +
 drivers/remoteproc/Kconfig                         |   1 +
 drivers/remoteproc/qcom_q6v5_pas.c                 | 117 +++-
 drivers/soc/qcom/Kconfig                           |  11 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/qmi_tmd.c                         | 595 +++++++++++++++++++++
 include/dt-bindings/thermal/qcom,qmi-tmd.h         |  20 +
 include/linux/soc/qcom/qmi.h                       |   1 +
 include/linux/soc/qcom/qmi_tmd.h                   |  22 +
 23 files changed, 1414 insertions(+), 17 deletions(-)
---
base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
change-id: 20260715-b4-qmi-tmd-d23e8df1b282

Best regards,
-- 
Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

