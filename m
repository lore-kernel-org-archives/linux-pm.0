Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F2D3BB101
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167223; cv=none; b=IxSQmYEvTypmtB6OqEMBizs7vfopiQx1I1yo1J2uP7oz0cBpfCcYo9fzvpEE2jRnTCxNu0JWsWnVM0J0jWoMIoOLnvicJiA9jFopsX4dHbCIQGtTAKSqfIB7Ru/GkA3LnRzYr44D7uxPPmUWdUVn3RLZjOs6x4TzO6BNCR07Thc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167223; c=relaxed/simple;
	bh=WUJVJaQPKb4FmPPBon05kk0BKevAXuQlPhkg/Foit20=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DnHfAkmgBJQ+fpjHR0rlb4C0x4+P3CvY24jfK1NJju97CJ5/T+vaRql5UbR1pvPt9tsN+A3xDIWE7ZY9t4zODCly4cQ3SxRtzY0YWvH+uW2iuqXVRnoZiGAJODS3qfCZr4nwWFj3LtAMJVn5sdTUhQD1jxiF/6KXkPS5U5Gs6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=joEYp206; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jqbC5Py3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="joEYp206";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jqbC5Py3"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDm9pD3823625
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=y/Os8II74xNi3CPYA1RpX2
	RFpqg/9Y7rX+NuKgGBK2I=; b=joEYp206CdowCxq6QdErqFTHIhqRQ6He48RXZL
	qeTKlc6MiwSDU0mbfMCChEe8S2308K4wjJe/2zb/7gBXwnXeEps89/I3mHQ2KJoS
	O2l0Dcy44yhTshr4IqMpkA5WXeGyKLNp6CWEd2epV0T15s6YNwBesbz33jscxKjf
	eFB6Sxm2vvljKyj+kkSrI0hkSH+NbOUZq1J2Yj/jZ/CuuO6oA9zV5eK89thEVhEf
	G6WPVrYi/rebo0Dgcl09rEltekpJO9KwdswyuclA2k3dBKknlOCv5qwHIcZd8ip8
	kJnmh8u1tLpHA7/2H0P2j5Zwwh9zjP6BrLduD/0meci2JS0Q==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbsk52-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:47:01 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7f5b54da461so40782767b3.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785167220; x=1785772020; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y/Os8II74xNi3CPYA1RpX2RFpqg/9Y7rX+NuKgGBK2I=;
        b=jqbC5Py3W67LJSvUOWz14JsfCze2HJNPDQNdjtmxeuyw4qk2egzVFdS8MjetLdHjvr
         +wdxJwOblO2Ohw0+Hq5vRt+GAg2bzfY1Kjh2uRur/WZFjBFT67k7tjlP0SqhM/0gKLXZ
         GNx+Z4+mAdIxdOrfjQf0nMTOaYCGPxRDADPFilkUwLKpjs134OpWSR+DITBbCq73kBgF
         fsp2nwhx6GzSd897hHcccxjgfiZf6kgt+oJ2Dm4rG1U1neecO+vuNxd/vR3j+FaznKYv
         olpPe2rpMWA6e4yB8m1p1J6l/jIllNcovLihcBnUVQnfHzXbYwYu/I5CIucor2oXUd6p
         zs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167220; x=1785772020;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y/Os8II74xNi3CPYA1RpX2RFpqg/9Y7rX+NuKgGBK2I=;
        b=g5mjZjmlcj4jwD70PHVlKe+NJHtciiJQ9QFzMWGnLiE1h2n95hutlynbITkD/67qLL
         1tclOtlYbfoGf4yFZSXnYcyVzunDPw1pdXErsQkksK/7lKusCklK6WbOnDTce7S01Xyg
         Upi+an7vTMz0DOeHVD/tCcu3E6mzhZWxN8hjkCfoLcJm1wOUmOmoh0t6E+8EVURfAiu+
         7BiLGgjP3xPF0BstclGGpOpDQp55n35xj3sEVJiCj/b7G5qk1+Ze0AYnIfXWrPy2Bt4u
         3V8yqp+2d3Io0/mCPE/RPFrQU/HJolwq3SnSEF5coWyKSXyBRtrj+w7pI1euk3e6bwo3
         Hufg==
X-Forwarded-Encrypted: i=1; AHgh+Rqyz3sKaOzFXd0fCep/cJBRvXkJgSKxsZ3+AY4OA4wHRJgtmjFUXUnDsE2phtzxn1lDy6i0Zjzyzg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1z9BA2qYnR4uozKkQb1YekENb/+MJqtL4TnzFVsQvJshsCY9
	CFYoekbsEyNq5xf8zcd7d17wtswVJrYBxKwdjXSZ1DmZKSLbOjKE3qVnHdsK181OvuNZaAROJZe
	x3WDHJnwC35Bp4ExH2OQZEENWssbnH0G9LSGW6+t56Ly0jSgKwOKOUzNkK7J7Xw==
X-Gm-Gg: AR+sD124XB4AGHECf30mGk7ZwOgO+ZWgYkDl3iCddVSjNbxJaYDlwGgTEpB0m3VoCXf
	uc4jcfcptjt7ah2Enua0LFioDtkxhmqKGjqm8n/jWm7Yq0GllyZ3ahxO6C7c+iv7jvObsS84j8u
	mNoKxkat4AUiH1Mqy3zB30hQXVE4sieFd5ZfM+02SjjJaaB6Hi4sihnURe2XfWs+0S+A2fJW0iJ
	pdW52tkYN8UrH+taN7+8BClAon08nd+6PCJPTV5rq58F1GnR8OI0EKo6r+QX8+izk7WHfhol8JO
	QHGn+hQGaEvwXVD3N1DgtDWIn9Fb350waGKQDB+gflya3lUv9D3mFPf4n7Y2JxnlQz4OwgL7FWm
	0AnZQ/l1Ep7UwWEMiOo+g6Anu6Gg7hg==
X-Received: by 2002:a05:690c:6d8c:b0:80b:bc16:8a2a with SMTP id 00721157ae682-81f69e2e741mr28011207b3.36.1785167220071;
        Mon, 27 Jul 2026 08:47:00 -0700 (PDT)
X-Received: by 2002:a05:690c:6d8c:b0:80b:bc16:8a2a with SMTP id 00721157ae682-81f69e2e741mr28010937b3.36.1785167219651;
        Mon, 27 Jul 2026 08:46:59 -0700 (PDT)
Received: from hu-samana-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657c727asm33307617b3.19.2026.07.27.08.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:46:59 -0700 (PDT)
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
Subject: [PATCH v2 0/6] Bluetooth: qca: enable QCC2072 on RB3 Gen 2
 Industrial
Date: Mon, 27 Jul 2026 21:15:00 +0530
Message-Id: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPx8Z2oC/4WNQQ6CMBBFr0K6dkgpQcGV9zAsSmllDFKdaYmGc
 HcLHsDNT17y/3+LYEtoWZyzRZCdkdFPCdQhE2bQ080C9omFkuooT6oE6krAqY8cCPUIXYCoKYB
 ram20c6ZxlUjjJ1mH7/342v6YY3e3JmxvW2NADp4+u3kutt5fyVyAhNLUtqqlkU1fXDxz/op6N
 P7xyFOIdl3XL9yUvVPVAAAA
X-Change-ID: 20260723-rb3-industrial-bt-uart-f98acaffc9f5
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com,
        Vivek Sahu <vivek.sahu@oss.qualcomm.com>,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: TMPGj2a1396bbZLqmiyl0-urZrLYII2z
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a677d75 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Dei6p5SHAAAA:8 a=pGLkceISAAAA:8
 a=COk6AnOGAAAA:8 a=4-NKwLwbh81bemdoGZAA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=M-Yerj1wOn-OpK7r_3ei:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX9NiW5+ylS++i
 jQHnFZkmKpZR3LSXHhBg1d5ao/7kGzF1TRib8jCnTHDgIPd9HW3AYm3mXYI2MHuQ8m/MSQo0Deb
 Iq/jx1aQk4eV+9gQfSvMkjP3GopmXZ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX0UuZrvs120nH
 6Hsz/IN/EyBqhTNq8H9LhWzW9k9JOdDjrcDw8IhANJ6dqSVLw3EL0cswukPzotW9Q171BHYUo1h
 oNBeF+0FN4drNEMV0k/IX6qFUfu7dFGoeNkCzwXrtaY5iOG4x2rKWkq/02wC65cFFkKpaSPd3qY
 n0SuYHoo0Ir1wVkNVUlzA05mFG/sQ3HjqWkEyMWskohiWRaRHngStiwO9mDS3DpH/q8R+dsUYgS
 8ZCMyN8qEnY9YCGJXCczg1FeGtVvqZqIoZVc9202jgBvm1wZoM+d2MocVd8db5wEv99q1GTFY4G
 kM/4BBlgB/GSyi56PVukVH5TjxaixXRTxN3TjAVFRi6P6Hnhq5y1345ld3jdtT5ElfguGlddpYS
 Gy8fcwKKvL7xazpMdpXLrot5IAOMU1KofsmFrOICiVqzcVqQXbNixQdpybQ9Q+g9+x69k0JTLsQ
 s+owwg2+I+dSsKBKBxQ==
X-Proofpoint-GUID: TMPGj2a1396bbZLqmiyl0-urZrLYII2z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270148

The RB3 Gen 2 Industrial mezzanine normally uses the M.2 E-key slot for
Bluetooth over USB. This series enables a reworked Industrial mezzanine
variant where the same M.2 E-key Bluetooth path is routed over UART4
instead.

The BT UART overlay is applied on top of the existing Industrial mezzanine
overlay because the reworked board keeps the common Industrial mezzanine
hardware description and only changes the Bluetooth transport routing.

This series continues the QCC2072 enablement work previously posted by
Vivek Sahu and Yepuri Siddu.

Vivek posted the initial QCC2072 binding and driver support up to v5:

  https://lore.kernel.org/all/20260218114955.3970974-1-vivek.sahu@oss.qualcomm.com/

Siddu later posted the RB3 Gen 2 Industrial BT-over-UART use case with
QCC2072 driver additions, NVM + BCS calibration handling and a
card-specific DT overlay:

  https://lore.kernel.org/all/20260529175342.3363935-1-yepuri.siddu@oss.qualcomm.com/
  https://lore.kernel.org/all/20260529175822.3366535-1-yepuri.siddu@oss.qualcomm.com/
  https://lore.kernel.org/all/20260529180234.3373056-1-yepuri.siddu@oss.qualcomm.com/
  https://lore.kernel.org/all/20260529180431.3373856-1-yepuri.siddu@oss.qualcomm.com/

This revision carries that work forward using the M.2 power sequencing
model.

This series depends on the M.2 Bluetooth pwrseq support from the Monza
wireless series, which adds the hci_qca OF graph handling needed for M.2
Bluetooth devices to acquire the UART power sequence from the M.2 connector
graph:

  https://lore.kernel.org/all/20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com/

Unlike v1, this revision documents the qcom,qcc2072-bt compatible before
using it from hci_qca or the M.2 pwrseq driver. It also carries the QCC2072
M.2 pwrseq PCI ID in this series, because the earlier standalone dependency
was being dropped due to the missing binding.

The QCC2072 M.2 pwrseq PCI ID was also posted by Krishna Chaitanya Chundru
as part of the Eliza EVK PCIe/M.2 series:

  https://lore.kernel.org/all/20260703-eliza_evk-v1-3-7624440bd76d@oss.qualcomm.com/

It is carried here so this series is self-contained after adding the
qcom,qcc2072-bt binding.

Tested on RB3 Gen 2 with the reworked Industrial mezzanine. Bluetooth setup
completed successfully over UART4, hci0 was created, and the runtime
Bluetooth child under UART4 was created with compatible qcom,qcc2072-bt by
the M.2 pwrseq path.

Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
---
Changes in v2:
- Document qcom,qcc2072-bt before using it from hci_qca or pwrseq.
- Fix uninitialized QCC2072 BCS calibration filename handling with custom NVM
  firmware-name paths.
- Carry the QCC2072 M.2 pwrseq PCI ID in this series.
- Call out the Monza wireless M.2 Bluetooth pwrseq dependency.
- Preserve prior Vivek/Siddu QCC2072 driver enablement lineage.
- Rework the PCI bridge commit message to explain the reason first.
- Add labels for the WCN6750 PMU and M.2 PCI child and patch by label.
- Remove unused overlay labels and the ineffective overlay delete-property.
- Link to v1: https://lore.kernel.org/all/20260723-rb3-industrial-bt-uart-v1-0-3c8e580c09d1@oss.qualcomm.com/

To: Bartosz Golaszewski <brgl@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
To: Rocky Liao <quic_rjliao@quicinc.com>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Krishna Chaitanya Chundru (1):
      power: sequencing: pwrseq-pcie-m2: add QCC2072

Rahul Samana (4):
      dt-bindings: bluetooth: qca: add QCC2072
      arm64: dts: qcom: qcs6490-rb3gen2: label BT PMU and M.2 PCI node
      arm64: dts: qcom: kodiak: mark PCIe root port as bridge
      arm64: dts: qcom: rb3gen2: add Industrial BT UART overlay

Vivek Sahu (1):
      Bluetooth: qca: add QCC2072 support

 .../bindings/net/bluetooth/qcom,qcc2072-bt.yaml    |  39 +++++++
 arch/arm64/boot/dts/qcom/Makefile                  |   2 +
 arch/arm64/boot/dts/qcom/kodiak.dtsi               |   1 +
 ...s6490-rb3gen2-industrial-mezzanine-bt-uart.dtso | 129 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |   4 +-
 drivers/bluetooth/btqca.c                          |  72 +++++++++++-
 drivers/bluetooth/btqca.h                          |   2 +
 drivers/bluetooth/hci_qca.c                        |  24 ++++
 drivers/power/sequencing/pwrseq-pcie-m2.c          |   2 +
 9 files changed, 272 insertions(+), 3 deletions(-)
---
base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
change-id: 20260723-rb3-industrial-bt-uart-f98acaffc9f5

Best regards,
--  
Rahul Samana <rahul.samana@oss.qualcomm.com>

