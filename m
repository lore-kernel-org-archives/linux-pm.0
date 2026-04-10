Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271DC3AA4E9
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775810812; cv=none; b=d8Xd24ipwfPKUzHk72lixxTdH1Ai6C+XB/LtcjwSQo9gezdM1tc+1R8UPyiT0wRe43ShkNAh0zwmMEd4rHFPCnltB8BaHgK82IsqjMagpjb4SawwhUlVgRoX6G37x3BKvTt5wH5QzUmwi8SbOh7swRUJ3jB5Of0dEyFIrUC5QjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775810812; c=relaxed/simple;
	bh=sy3IM94J0YA4FPUYACOkqZOUDS1xDuihTps704Bqv60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k//n8Ly7essZONhMdlmutH2+GgZSrYa2UfGlG8uyRKULeX8RDGGURz0yg2kNWr3hHjry+7NrRlH119D0H5jBfUMkzXNZUPINsmIX0ksm5rDjyAUiCQP62Q5w30/nbL+XNgxv1TnRrSItz324tIZ/ESgzXRETaRpep2og4QRQ20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aDeYLcYg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YTo7dNtD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aDeYLcYg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YTo7dNtD"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63A5oKZt708994
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 08:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ISnxQr9CyErWBDiGnnkQoFdi7q9lsidim/S
	Kb2VHosI=; b=aDeYLcYgGxPEFy19/LIes9HV0OSfciFOYZtGWItZ7YXHVp9MhbP
	RJiJ/aOk967PoEEZr5x6QI7ECZ/68wMkvxfs6rOIBUWabYQNpcxmDE+R7IoQ5JQD
	Zc5bEApGVfWjgaDcStuUnQp8G8Yb6Ph4lkCxgMfaFDmxdG8v6NDabkO5fC8H6U5+
	7MuWzm4wjlhOMKeyxzs80QUmS6RaSMMgCtv4R6c3A626d7EOrsYLY9pNOnJoYXIE
	joyLRI2t/6J/l4MHk6IPIoS0S1fczIeT2R6N2eBAQFNCLQbPxIx8biBDWrZLRTgW
	RtQU6g5o2JZi+uaAMSKpG1RU7v9ltP+5Y2Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudj0mc0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 08:46:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b323c43fdso33362621cf.2
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2026 01:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775810809; x=1776415609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISnxQr9CyErWBDiGnnkQoFdi7q9lsidim/SKb2VHosI=;
        b=YTo7dNtD6CH//VmZ+3+t/RPDU8miwlbJPkjq0RpFAVkcWj/YxvDj8E00yCvUPa5wT4
         932Zr8FE8c3pubfiIcc2a8Rv41nA2tCsHA1BNiVHJL/pb/OPlXuZik8mwRt6Wbtoa9IT
         lwDbliIVt6jJXjsGFu01yrExRq6tzxN9mNvqqSSNsi+88yW3XzEWErjr9+fOudXoHQGj
         MS/V7ZFpbKbV2qnP0m6ZYqKfb5Zdh0tS+KDj/QMHtQKRUU0yw3i8Ky7R9VFn5gC2NDCz
         krLimt0lNEAwqrmNi57kcf7Z5a0hpzyIIrNz/8we8gyyG0u/5WuVMnziH89weh0K3xXm
         F/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775810809; x=1776415609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISnxQr9CyErWBDiGnnkQoFdi7q9lsidim/SKb2VHosI=;
        b=hxa5RFIw6+VXUsW6oSS8Zm2tixf+IlYf1vNOUovw1miB9Ok7WCHIVHMpPPd1RQKdmY
         DGjgfsuelJSWkEsGHmoUCh6vniARZPnN26gK9oe7HNVyoUXQN7ND9ZpNr8JdeP2JyqoW
         pH57PWYd1uCa+fhaAVIsdVkzR89IXmv0Cw65IrFwg2Kd0reYUITRD6TelTrGQbtaUccb
         MRdhu4jGlJl659amPIUJHBcAfyK7rrVs0sPRUT6jV28fNNv1hqpCICzIuSHh+S2v7Ulv
         hmvwS+yLwFot7vhS5LotyDBFof9uoLpinmHZXOkd4ElB1hcVOFtVSdxNz+9GehReJ0yy
         y8XA==
X-Gm-Message-State: AOJu0Yw40nJliNw36/1UVR+q/Pm/IKnEhhhL8MK75tZNzsEc9oSoy0/z
	WXSB5BOCGpS3kkN7AHLTVX2dxIMzarLBfJrycOf5+NKBPzoOt3qyib1LNhS+W+hVVGBvpGmhmAR
	ZZj/F9D7FG+SfaHoF/WEq8wJRtONDPjbnq2mQjjVylKvnHXzG3BH4CxK5Y5Eebw==
X-Gm-Gg: AeBDietDQHUNL+u3FvaeeAFQg1SJXCpck+J4lHiokkBxGOpep007pLYz+I/M1wIki6y
	kShZkR0fcbPIl3oZBeEe6XvN7NCV/1fPPd3VCEef+Av3coLpTxwFL22yUJdufu5Z6oaex1TvJYI
	o8PU+46zhrCS5SGJn/m1fqdYAZiNlP5qi+jHpmuPvAqBxvs3tRMaITOUU++s0q+6y8UCvwWd2sG
	JcxQ2Nhr5WT5LafAV6ndDUdvRMMIfWAEFCWVPDwqlBbJU2aN3tJisRXBRfLPALnPkqoQXFTgeeY
	1TDkSzRNleOheFkeKzTeS8lqxErgW/TOT0r32oPPGlaT3BdqfsXVdHYxcBKJUQfqC0EPem8HHSC
	mvNFcRKGI4HAo1YqitKRBWrUJtOiB7OAK4ZIqgiptDTpJjjih4A==
X-Received: by 2002:a05:622a:a948:10b0:50d:9cda:70ed with SMTP id d75a77b69052e-50dd5b7d2aemr27490641cf.35.1775810809119;
        Fri, 10 Apr 2026 01:46:49 -0700 (PDT)
X-Received: by 2002:a05:622a:a948:10b0:50d:9cda:70ed with SMTP id d75a77b69052e-50dd5b7d2aemr27490301cf.35.1775810808696;
        Fri, 10 Apr 2026 01:46:48 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:7d6c:c663:fa06:9ee8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d681ea59sm15351255e9.14.2026.04.10.01.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:46:47 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] power sequencing updates for v7.1-rc1
Date: Fri, 10 Apr 2026 10:46:43 +0200
Message-ID: <20260410084643.14631-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OI8i2BR1wFqqt9db1GLbxnhpdyJ2FaN9
X-Proofpoint-GUID: OI8i2BR1wFqqt9db1GLbxnhpdyJ2FaN9
X-Authority-Analysis: v=2.4 cv=cKfQdFeN c=1 sm=1 tr=0 ts=69d8b8fa cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=D8G_PBefrYurufu0zZoA:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MSBTYWx0ZWRfXwNewIlJy7clJ
 5+rUy2DEUF9HE7xfdpP3R0mCEfSIt90vVfp+RPdEB1f5MBFcZWYV+abTmluYdus04BbmOVidLzk
 0x0kBFMf4aBcaCTTECwcSjtR83G3fWBFGSkT/QJvLv2HeQBLUWsj43m1R7ylM5s62qowzG8wyt0
 /npgMONlY9fkOJtF2x7iHF3i+zOBnlXub/MOB070KNaAoB3CYIUPHmqfE0YUYypPqPcekr4NxI5
 CKkgq25w4cP2IpO8wKjdx2RwBpTY9R3fY5SgxvF+0gH8wO+z9mHmE5ZOrja+RRByvpcu9TD1eq5
 jqNBPkN4D2NGZVSAsM9A5KeF+TzUFGVXcuGPkjx0NNpVkZdp8gBGZdznprWxBVCHSeD0Lv+lbYf
 u+MtNLhZ202X7ajbZQeVZD2jsjASCHX5qROjFSFxZvz8tCbraeoNKahbnQyEyFA/Jq3wQVT6Z8r
 oJsNOCQVzhor1xtBt/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100081

Linus,

I'll be OoO next week and disconnected so I'm sending an early PR for the
next cycle.

For this release we have an extension of the pwrseq-pcie-m2 driver with
support for PCIe M.2 Key E connectors. The rest of the commits in the PR
fulfill a supporting role: document the hardware in DT bindings, provide
required serdev helpers (this has been provided in an immutable branch to
Rob Herring so you may see it in his PR as well) and is followed up by
some Kconfig fixes from Arnd.

Please consider pulling for v7.1-rc1.

Thanks,
Bartosz

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v7.1-rc1

for you to fetch changes up to b4464d8f313f903ba72db06042f3958a9a1e464a:

  power: sequencing: pcie-m2: add SERIAL_DEV_BUS dependency (2026-04-03 14:20:36 +0200)

----------------------------------------------------------------
power sequencing updates for v7.1-rc1

- add support for the PCIe M.2 Key E connectors in pwrseq-pcie-m2
- describe PCIe M.2 Mechanical Key E connectors in DT bindings
- add serdev helpers for looking up devices by OF nodes
- minor serdev core rework to enable support for PCIe M.2 Key E connectors

----------------------------------------------------------------
Arnd Bergmann (2):
      power: sequencing: pcie-m2: enforce PCI and OF dependencies
      power: sequencing: pcie-m2: add SERIAL_DEV_BUS dependency

Manivannan Sadhasivam (7):
      serdev: Convert to_serdev_*() helpers to macros and use container_of_const()
      serdev: Add an API to find the serdev controller associated with the devicetree node
      serdev: Do not return -ENODEV from of_serdev_register_devices() if external connector is used
      dt-bindings: serial: Document the graph port
      dt-bindings: connector: Add PCIe M.2 Mechanical Key E connector
      power: sequencing: pcie-m2: Add support for PCIe M.2 Key E connectors
      power: sequencing: pcie-m2: Create serdev device for WCN7850 bluetooth

 .../bindings/connector/pcie-m2-e-connector.yaml    | 184 +++++++++++
 .../devicetree/bindings/serial/serial.yaml         |   3 +
 MAINTAINERS                                        |   1 +
 drivers/power/sequencing/Kconfig                   |   5 +-
 drivers/power/sequencing/pwrseq-pcie-m2.c          | 346 ++++++++++++++++++++-
 drivers/tty/serdev/core.c                          |  28 +-
 include/linux/serdev.h                             |  24 +-
 7 files changed, 563 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
