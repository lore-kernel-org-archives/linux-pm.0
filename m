Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A43FC5B1
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494090; cv=none; b=X+ydNHT2YSW8vX131zOPjdv8/TALQwkuC/8NqA/OeAZh/ohyhmXdSBUG4u4Tfu/BcRAOFJ1W/pJ86ewCT76SoaULH/LiPw8Q3pzc0tWIPGs4l3P5UxQQux7eMGMaiWbjhuhjnIo2XStEKLOPED1zULZdkmn7dd1DQNRbuIALDL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494090; c=relaxed/simple;
	bh=rI/lfG2Xr72NFRsRzf5qgLaHupNxEHCNQqk7ZN2yaEE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dSUixuM+IQ7vxagQgzjdaTAt3UfyHezSeUd7LjVWHODor2shr69dDIwlcEm9RXPdZ7mb1LMIRI2FLc32vLikIca3atOQL2J5qjAIvhv3kI+Wp4jIQP3vY98cgxCXZNas/usDq6xgzf3m5T0q/hk93cRct4W7UkN28cuSsyGIREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OMYbCM6A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hCjc2FCh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OMYbCM6A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hCjc2FCh"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VACLYk3184003
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bbZ1VYGbemv9hkAxGz8eqE
	80wo4ePN+9/sZzn85BIZw=; b=OMYbCM6ATRI9pbWSrXujxv5jBeCarwdA0rrPzA
	/7LgElmQNkQb9OaWWFEZ39+H0lP4ncafyHSRkr9ZSFoD2aPJTUoPhYEtIzxPsHhK
	ObrJO/IPgkAoIB2xXr4ID4UfuTNk3G18SLMieQnrxwxn0vf/PFC2g7s4BGmWIgQo
	ysDoWTNZd+k2QuR8Nfj5eVclq8JaXITZtGUq9zf0Alx/mp+8Fp0nSorUO5hkowgM
	bh3LEmSmmSSJQ7+fL2OWu3y4v++MwJSHz2W5kHcefacYqD3uq1CuxQIp6D1lHg0o
	0HJT0w+MOlERn3F0OwSN3yGT0EmHLmepEigvdPRP5hl5pF2Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frsf1g4p2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 10:34:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38827cee19eso1164094a91.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Jul 2026 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785494056; x=1786098856; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bbZ1VYGbemv9hkAxGz8eqE80wo4ePN+9/sZzn85BIZw=;
        b=hCjc2FChe28Hl2EbnP+HUj8DrntLifB3TZ87F2eFLXgyA3Y/BUDmXbkVUzvWxovHL/
         vu2aZ2/ESmArrk5p7s0ul3EjZ36b1x7TbDkILxFuo9+5UGztfxlNPwcwwWdP9eCw1Zv4
         t4XwVwF7iWYoKa6GXSk7DPki76xpUL2fiXByKxdkjVVlPH6xBeWjFghtUHHWXNDOPu3s
         SsQXl9aJZw5uy0tePd5m2S4b2r4Gw42rSJ1lv5WOlGV0gDG9SQT7+Yr79+ye2HI5SWWO
         lUDjdk89B6k/IAG0XB7LK9cCxZ1Clhf3ngUCIJgaS0kMaWPZHlJRbJRfmsgBAL0fngj3
         VB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785494056; x=1786098856;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bbZ1VYGbemv9hkAxGz8eqE80wo4ePN+9/sZzn85BIZw=;
        b=bw6NCmgl8yRK9yX+zjVKZ6qDNjh6r3umMiBGzVUSugEkh5eJRFLQaWH89TXLmNjOQS
         ob/CUhLcN3i1g5RLkC6hfnkR2RE033ryeyseM2y2R8OtFjQLVIpEnh0HzEfsS+s9B+dS
         mMLNveBBOzOdrC0aix5mOU8punGoVCdJue/hMq9bbXMwm/UGP4pB4camgV4LztIfiGe3
         9VOc4DG6kBjnU6QsW/iGv2I9NZ/LhgwfNPUJF08KkhdkbJMwUznkJy6c4200LU2QtVoo
         ROqjyBn4YovJLBsym7HmNJ+LIaIpAbmpXwEuN5jLGrC25/m8cP+S38IJfbY6Xire4Odq
         D7bQ==
X-Forwarded-Encrypted: i=1; AHgh+RoxNgbRJ3P/CzyrMkOXy7hwE9tLcHexSiZJtAZFgtuShvW9eG8I+KbyTEi6D/iVqjQjBViAiNpVQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjy+4mUU/dpEDmbqR4HmV2Sl+IadH8Rfb2xXY/QOR8Kvv2FlHr
	DAab5Jx8NLgonHdxo7DraNcOxP870b6bSe6RjjrtinCDGoRedy3UeP7lMGPWDOMQHt3b8YzEUZI
	bk5DmKEMMqzRfNhdlSIcjH02LvlNqHTgirl2OQk5G2TMy0Lm9UA1eaRb8jY7ZTw==
X-Gm-Gg: AR+sD10Pl/zluqMiyoPf4UaiSAZr3lk1s861a10gS29+NyhQmteWCMRRehtg3vkyz+N
	rFw3s9QavYCV7xeNklTHEtt3whC1MtsKLt4DCBZcEvlpeKb8yiIYysw4+PJbMRpLzb4tC0F2FVt
	kTmFX0/MRGUSrFB1MMPvXDQbBpsyWanvMJqGyEvNq/lLwYE09AuMvDXbg5rqb3MfGx0wNmi7+qj
	YR8MlGnamp4tg9WPPsan396mEbjFb8/Ir8HwsEWTiF2SshIwiJyE0wxxzXCT0NSiFU9bIUKA9IW
	yqLbUYSSQtzqDqbKz9UBplTvH8sQjbaEFLaqEweisphjCl/mxPyql4fQFIyyI5IwWgfU+RfZKb9
	jEqjmKpGwOUcWUw9+wdYEAI8tf2NioA==
X-Received: by 2002:a17:90b:53ce:b0:38d:e658:595a with SMTP id 98e67ed59e1d1-38fb10f1042mr1505604a91.2.1785494056357;
        Fri, 31 Jul 2026 03:34:16 -0700 (PDT)
X-Received: by 2002:a17:90b:53ce:b0:38d:e658:595a with SMTP id 98e67ed59e1d1-38fb10f1042mr1505541a91.2.1785494055699;
        Fri, 31 Jul 2026 03:34:15 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm8493680eec.28.2026.07.31.03.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 03:34:15 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: [PATCH v7 0/9] Add support for Qualcomm remoteproc subsystem
 cooling
Date: Fri, 31 Jul 2026 16:03:40 +0530
Message-Id: <20260731-b4-qmi-tmd-v7-0-3befd44403d5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAR6bGoC/3XO3wqCMBQG8FeJXTfZztwfu+o9ogt1Ww7SpbNRi
 O/elAiDujnwffD9OBMKZnAmoMNuQoOJLjjfpSD3O1Q3ZXcx2OmUERAQRFKOqxz3rcNjq7EGZpS
 2tAIFKA1ug7HusWKnc8qNC6Mfnqsd86V9M4R9jJhjgplSQFVRU6vY0YeQ9ffyWvu2zdJBCxX5Z
 g50+0XkSSgKAcQQaTnhfwSxFeSXIBZBslqzEkCU9ocwz/MLi++Y3SwBAAA=
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dipa Ramesh Mantre <dipa.mantre@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785494047; l=7054;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=rI/lfG2Xr72NFRsRzf5qgLaHupNxEHCNQqk7ZN2yaEE=;
 b=i99GxEoIfZOfUqHz2WNhBqqfw38MMxZtwFhJ8GwF8O7CQ2b9kegIRBSObWS367F/7p3AN756+
 a6szfamOdrJAoBfD0F7cuv+LCI3DP9NaR9HkFA2UICW9fXP9TwCoJwC
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-GUID: AJcBcVDLWaa5SKO0qZN7sil2ogwWqWmk
X-Authority-Analysis: v=2.4 cv=ZJDnX37b c=1 sm=1 tr=0 ts=6a6c7a29 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=myz9wP-PkEfKd50XNCIA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfX0B8gp1cfwjyY
 97x8e+w+H8mMVgdw2HjF4iz1x+KO7RhKpl2qpON0HFzaFQfq4XSqnvickqUpLRP8h902EbPLqb4
 sTYr+odoH78BNRBAeDaV1SkbpDjmd68=
X-Proofpoint-ORIG-GUID: AJcBcVDLWaa5SKO0qZN7sil2ogwWqWmk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3OSBTYWx0ZWRfXwPshbQtSNrHo
 tC3vK2KPCrk8NDA5GWCqK+l0w4XHdxTKC3auNfkp+kXV0IATqY1IiNgVOjG+sUiVqONlUDZXaim
 J3WuarWBZoedsQwRQRaFV/hLFpmf7BA7HgB8TJSb8QrL10dlh46RB2Ep4T9h+LDBNc989xNFSAa
 GnIZl7XidTSJiMsWf/aCb/vL9mP6qr0om9ZIizuCLtrtp5SsiJYaWZNjDKfGHbV2PH9/RRleNeE
 90lyRrfWBEksVkHesZcIx8EBdqKKE8kqFg8S9H3xvUmGts1WfGgoJtDNl0N1UwcPyx86D663bfT
 Ik2MxfoCwZGlnMxDDbQq5h1KLbER85hhe0wulZbd9HpkeND4HAKqjk+7NBTnaznfKhsfFYdi3Sq
 Yfyt4dDkcbVt+JdFlZ+Xa01W94eFvkmAWNOL/JnsQA0b4HceYFvOuOEYWg5QG0KyRaIEiOUjy2c
 txGpeSivzH+UTfTwRTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310079

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
Changes in v7:
- Added Daniel's Acked-by/Reviewed-by tags.
- Serialized cur_state update with QMI state request. (Sashiko)
- Link to v6: https://lore.kernel.org/r/20260727-b4-qmi-tmd-v6-0-973cd3a226af@oss.qualcomm.com

Changes in v6:
- Added Reviewed-by tags from Dmitry.
- Kodiak: delete MPSS cooling maps by label on non-modem boards. (Dmitry)
- Renamed qcom,qmi-tmd.h to qcom,pas.h. (Krzysztof)
- Made QCOM_QMI_TMD tristate to fix unmet dependency issue. (Sashiko)
- Removed redundant negative TMD id check in qcom_pas_setup_tmd(). (Dmitry)
- Fixed QMI_DATA_LEN type issue by using u32. (Sashiko)
- Link to v5: https://lore.kernel.org/r/20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com

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
 arch/arm64/boot/dts/qcom/kodiak.dtsi               | 125 +++++
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 125 ++++-
 arch/arm64/boot/dts/qcom/monaco.dtsi               |  99 ++++
 .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     |   8 +
 .../dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts  |   8 +
 .../boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts |   8 +
 .../boot/dts/qcom/qcs6490-vicharak-axon-mini.dts   |   8 +
 .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  10 +
 .../boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi   |   9 +
 arch/arm64/boot/dts/qcom/talos.dtsi                |  19 +
 drivers/remoteproc/Kconfig                         |   1 +
 drivers/remoteproc/qcom_q6v5_pas.c                 | 117 +++-
 drivers/soc/qcom/Kconfig                           |  12 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/qmi_tmd.c                         | 592 +++++++++++++++++++++
 include/dt-bindings/thermal/qcom,pas.h             |  20 +
 include/linux/soc/qcom/qmi.h                       |   1 +
 include/linux/soc/qcom/qmi_tmd.h                   |  36 ++
 22 files changed, 1298 insertions(+), 13 deletions(-)
---
base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
change-id: 20260715-b4-qmi-tmd-d23e8df1b282

Best regards,
-- 
Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

