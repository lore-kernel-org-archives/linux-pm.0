Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793453004;
	b=hMrlWRus3oNdWAmuipyMwi60BN8vsW1cmxCvtJhrPx6k21inBdLaIrdUy38X5Qt6FzAI
	 SX/7xd0PkQkukzzkRC2YkLNjNwpMNsDvzuXKisbKnCIg7W1rYJDF20S7lHqmErTJj+QtZ
	 XSw/N1utk+NSK3l58tljLROzULvbt/oitA/0irlMgQ26HNZT2L5nuZu+0fP6EbjxD3ANf
	 AWrkB9zlLEa2aHSd7ThXBsB9iYsXfeYeKHeIx97IMg+tHc+NYliSvaJsr+lsaEfz68+p0
	 mJ1DUTD0KX/zR/sFj+Sz9QHnhjY2yfSP4IPUQBj0E5PzITSPcN4rcAChkEK8ymSuPGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453004;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4oSUppzxzHF3D+dg1jUudVpg0qnnD2G2Yi8QoIkwJ48=;
	b=oSoPLTlqvRKyptko4jNUU1vrUi9tIIbxmNqbe48u/fTxWqKNpPHVBqP8X3WoIZQyASDJ
	 63ZGa+IxDd9bYR16vtNo0vFpCFD6oapbSI7yxcijoTifqLYz5ndNc0XdVXzgGKqOW5Zte
	 NICzd1yX+JEetK4rArFnwP0iDL19uev27gJ6Ks+IKx2GNqU7/Y9LEOxqOZ7qumqZM8kqF
	 a78ZXax5/dNSCBvDQ9Nl15wCT7eWE6FL3/+a/5fJWvwOteYzPMZ1cdJ0PlzHdBHIlFi6q
	 9jQT0WUh86mGaJDw599aUOFqYVkXw41hXhJc9xBVC5YhABEpHF5ltRhQsX7qjig7SAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cgvrcHcv;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LZQ3R96Q;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F82D606A31F
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 13:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F82D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cgvrcHcv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LZQ3R96Q
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VD0TOh2162544
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 13:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4oSUppzxzHF3D+dg1jUudV
	pg0qnnD2G2Yi8QoIkwJ48=; b=cgvrcHcvCZNzVtSvV+tBKNVF/ZohKSMCXHsLDR
	7pMaDiDHuenF92r1ZIXt2wUzDXiBmM1US0Bi3Z0jHukA68ihi/IM2pegxHuG/wAr
	6pgvlxLpVNP+kNQOTQXOk/kwf35vTEqTxAvbL0XV0iH9+P2v0nplCY1Rp0gd54j/
	WUdbzCAIwnFcM6bBjWBsaElL2BlbEH3a/MIQvDQgA4ljvQ+83OxMcawZjVGEQytY
	gHK/mxicw2hpNfILmqLLO4A6JxR7jyaNGShPWHcDaIscJUEYjCXDdpguvCkgBMHO
	l+sWrMoEuv3prrxvVD52TlMFXilTYbO/AH/7fpyVDH9uALkg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8j2s6tg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 13:23:11 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-147be78cd56so1905186c88.1
        for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 06:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793452991; x=1794057791; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4oSUppzxzHF3D+dg1jUudVpg0qnnD2G2Yi8QoIkwJ48=;
        b=LZQ3R96QnU+Gi19XZCAZanIqNUuiLezMaVE2deiiYIFJ5SHjkQN2trIpyWarsGnr96
         R2jDqCeNU+6h4q92jJ3+TgIfgCHEDBTBz428/lFCoIN2wXrRj22JCLKQpxbctxYbNL71
         Xa4S+qg/7CJVsK3xiX2hxQJi4XOBj6gNxysu3oeB9yKi/3ZpMVHwHmlAl/0SYPq9TFxx
         MGMdKZCX9suaK+ef1wGwDPZ7JMisVxKkM5+v79E8zX/SACiZFwBdB2Xgj4LFUpJWDh3Q
         73AvgGtn6AMfiyuXTnrSpHioC2HSZ3GS5kDY7L+oE7P+IniYDuCzsqfQNIUkYjMrxKf3
         nxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793452991; x=1794057791;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4oSUppzxzHF3D+dg1jUudVpg0qnnD2G2Yi8QoIkwJ48=;
        b=QeHGVnMtHpOEe4/Zxc91jvjTyqK1pmL2n2+gimZBR1CtXARVb8x0TJx410mcdMsYt9
         nDYpPOm/q5dl4+f1HKqTJ4NRlRAUCNV4rcAZ8VZ4Nv0PrpHON3SXoyQou2fO8AZPJzm7
         pKiNx2DIEnvmbSRM1Jo06ubO8kJ6PZ8zLNByumq+ynDfdrdcAaLgnirGaho7YsoXng3U
         eYO9eL7DnRQXI1aQcJPC1uvlIlzrvzZQivueLfUfc2i6a3Xb8A9MHUlfyRFFo3duKXKR
         HjxZ20qrQ7ZYvDytzxcZTICTeUH/NgTs5qD/P1p9//xLn+JNU+0C5n7Wnkc6Qh89u7zd
         494g==
X-Gm-Message-State: AFq9FYI91CpjpC7fTeF+fxKsFJgXc3Qgn8cEflS+/DMG1Jh1uMsqI16i
	d3XElaT0PbFUtakgaw5WKx5RituMYER7rC0V0etaG24UTJUHOfURiO6WHDMLCKAtoqRaRph64sY
	0BqzUxn/M+20scGrN8qcPfmbjs5JL9XzFq0lgdiK86QayAMQuSULcAbjE88VD2Q==
X-Gm-Gg: AYBFou1otglNARPqOyfaSW7OsBLnuxEdULmh2thL0ILeeF6VNYYX0z8LbT5b0oa5dRz
	FMLzMzWkjJ5TzmHApBmCyBUgN19Pa2er7yR6EdmH+Us70GTo/sA6MxDsR62+xCD9PJxKmZ727G6
	m+4FcYYfJvrQ0ZgzTuqXwz6EWsoQdxxEGEX+py7rBH9ZN4ZhzU5GWXmx5dETjDWDNbYz2EwF4sS
	CQUD6AAz9jhuMW2gG0F4DjvZg+6gZfcnvPGmAb6dcwYQpToLwYhs3ar61VjL1v2fQjdgt/IGscQ
	jCamoSZBwVBvbzaV29AQ5r5RTzickJblWvWIn5S2cWjrHmwMfoJD4UMAe2rfyxGp5UvF+GC9nfE
	ajhQce/t15J9jNFs5n5bK057O8UwzsvEt81vUdrJBHLQmmBcGRGHr1qv8u51mvfx7BxIThF6X+/
	KO624=
X-Received: by 2002:a05:701b:4502:10b0:18d:96e8:b913 with SMTP id a92af1059eb24-1ac5f64afcbmr7058773c88.47.1793452991113;
        Sat, 31 Oct 2026 06:23:11 -0700 (PDT)
X-Received: by 2002:a05:701b:4502:10b0:18d:96e8:b913 with SMTP id a92af1059eb24-1ac5f64afcbmr7058733c88.47.1793452990367;
        Sat, 31 Oct 2026 06:23:10 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac193b8179sm18234699c88.11.2026.10.31.06.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 06:23:09 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: [PATCH v2 0/6] thermal: Add hardware-binned trip point support
Date: Sat, 31 Oct 2026 18:52:46 +0530
Message-Id: <20261031-thermal_bin-v2-0-d76fd073ae98@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKfr5WoC/1XM0QrCIBTG8VcZ5zqHCsvWVe8RI9Sd5YE5S5cUw
 3fPdtfNgf+B77dBwkiY4NxsEDFTorDUkIcGrNPLHRmNtUFyeeS9UGx1GL2eb4YWNqEyaMeJo1B
 QF4+IE7137TrUdpTWED87nsXvuzuCc/nnZME467TsDSo8oe0uIaX2+dKzDd639cBQSvkCfTZIX
 K0AAAA=
X-Change-ID: 20260917-thermal_bin-fe7becdf0e17
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793452983; l=4715;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=MRemRaOBOzvAS+s91I3hR3FSXCHfN0Am3nSSTty9cbc=;
 b=Y+4eo6jLmnpvhRPgCYXsO0sY0h6PwZfNKxRNFHd0HoR+PgpiTyd9NwOWHU2fj2AW5kVaV+Wfh
 ImDebT/ed3pDFmlHJu6sjPOIsUTV5u4Z3aNiv0mayuqPbb7U4n813q4
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-GUID: gEnkmkjcSi7nISg4m5Oiwbsx2WrofsLz
X-Proofpoint-ORIG-GUID: gEnkmkjcSi7nISg4m5Oiwbsx2WrofsLz
X-Authority-Analysis: v=2.4 cv=S5RMU4sP c=1 sm=1 tr=0 ts=6ae5ebc0 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=OGjWj8McAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CgZP1dY-1rEdhbSE9MUA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=UYjydHh6ynBBc6_pBLvz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA1MyBTYWx0ZWRfXxkzhGwr33D46
 5G4sxC0dUCZh9APilpMkuDJJelee4q2/WaokCCma1w7IviTG536fhLLVHVYQBICnxPLjGH+fGNj
 HKliCqji4CIzbC8ERVom8H9PCnPesYk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA1MyBTYWx0ZWRfX9mtLM51BgAi1
 vvtZqhhKyHc5N8amb1DBm9RPmdbnauIbtkBO4elU8y7gZ/e2AylKszGRWHHYQdnpnRzxuvVTvzg
 AFuOasVa1qw3Ib1H+zRjC6co3gC/wn/NNvL5dgb1sVxAejoKYO0G/aMfOsD+nOiVGWWhdpDiblJ
 A/XcojAsdIDmOg6WgGNIm3KzoYHtbTebCzBz/VYHEJQXna2oJubwyUL01K0M4ph0DEV6913aO98
 xyWJPel8vILGiOmR3oLoIi8Ln9EfZyw1MPEx4PaBPIDjcBckdFLbPeOijPwvGJdCIng94zvdEjU
 Mf2Y0VYTuQ+n0xmg5temwLoEJ8vEbuzNmlMz11/SJdFw1WZvTice3OVWBTuWmK59JuRJK56DvoM
 GsgHcuXfdI9KPpjahYTeRs3Kbyq/QrT1IAAGg0pzSunqVcUTqAaEziELfU5kccOIGPKUCx7woQf
 Re9lAmyWxBistX6AHag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310053

Some SoCs are available in multiple thermal/package bins. The silicon is
otherwise the same, but the package/bin determines which junction
temperature limits are valid for a given part. This information is
programmed in manufacturing fuses and needs to be reflected in the trip
points used by the kernel.

At the moment this is difficult to describe cleanly. Board-specific trip
overrides can handle individual cases, but they do not describe the real
hardware property: the limit is selected by SoC fuse state, not by board
identity. Duplicating thermal zones or adding vendor-specific trip
properties would also make the binding harder to share across platforms.

This series adds generic hardware-binned trip point support to the
thermal OF parser, following the same general model as the OPP
framework's opp-supported-hw property. A thermal sensor driver provides
the decoded hardware bin when registering a thermal zone, and the OF
parser uses that information to select the applicable trip data.

Two generic trip-point properties are added:

  - thermal-hw-bin:
      one or more hardware-bin mask groups for which the trip is valid

  - temperature-bin:
      per-bin trip temperatures, selected by the matching
      thermal-hw-bin group

This topic was discussed at the Linux Plumbers Conference Power and
Thermal Management microconference as "Thermal binning support". The
discussion covered how to represent SoCs whose valid junction temperature
limits depend on package/bin characteristics. The approach taken here is
to keep the DT description generic and let the platform thermal driver
provide the hardware-specific fuse decoding.

LPC discussion:
  https://lpc.events/event/19/contributions/2245/

Slides:
  https://lpc.events/event/19/contributions/2245/attachments/1885/4034/LPC2025-Thermal-Microconf-Amit-Tj-Thermal-binning.pdf

Qualcomm TSENS is added as the first user of the generic support. On
SC7280/QCM6490-class platforms, TSENS reads the jtag-id and feat-id
QFPROM cells and maps them to the thermal hardware bin. On
X1E80100-class platforms, TSENS reads the i-temp QFPROM bit. The decoded
bin is passed to the thermal OF registration path before trip points are
parsed.

The DTS patches use the new properties for the affected Kodiak and Hamoa
thermal zones. For the standard bin the passive trip remains at 95C; for
the elevated bin it is selected as 105C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
Changes in v2:
- Format temperature-bin as separate DT cells. (Konrad)
- Add min/max constraints for temperature-bin entries. (Sashiko)
- Drop the post-registration hardware-bin API. (Sashiko)
- Remove CONFIG_THERMAL_BIN and make hardware-bin trip parsing part of
  the thermal OF registration path. (Sashiko)
- Keep hardware-bin selection registration-time only through
  devm_thermal_of_zone_register_with_bin(), because OF trips are parsed
  synchronously during zone registration. (Sashiko)
- Propagate -EPROBE_DEFER when TSENS cannot read the hardware-bin nvmem
  cells yet. (Sashiko)
- Link to v1: https://lore.kernel.org/r/20261002-thermal_bin-v1-0-5a29be7e8ec5@oss.qualcomm.com

---
Amit Kucheria (6):
      dt-bindings: thermal: thermal-zones: add hardware-binning trip properties
      thermal: add hardware-binning trip-point filtering support
      dt-bindings: thermal: qcom-tsens: document qcm6490 tsens
      thermal: qcom: tsens: add hardware-bin trip-point filtering
      arm64: dts: qcom: kodiak: use thermal hw-bin trips
      arm64: dts: qcom: hamoa: add thermal hw-bin support

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   8 +
 .../devicetree/bindings/thermal/thermal-zones.yaml |  57 ++++-
 .../driver-api/thermal/hardware-binning.rst        | 112 +++++++++
 Documentation/driver-api/thermal/index.rst         |   1 +
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts         |  66 ------
 arch/arm64/boot/dts/qcom/hamoa.dtsi                |  42 +++-
 arch/arm64/boot/dts/qcom/kodiak.dtsi               |  58 +++--
 drivers/thermal/qcom/tsens-v2.c                    |  16 ++
 drivers/thermal/qcom/tsens.c                       | 190 +++++++++++++++-
 drivers/thermal/qcom/tsens.h                       |  29 +++
 drivers/thermal/thermal_of.c                       | 253 +++++++++++++++++++--
 include/linux/thermal.h                            |  32 +++
 13 files changed, 751 insertions(+), 114 deletions(-)
---
base-commit: 0d9d0dbf2fddcff5859d623e90ca73c4054276e1
change-id: 20260917-thermal_bin-fe7becdf0e17

Best regards,
-- 
Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

