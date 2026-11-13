Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559462;
	b=TzuAQEbtWB5bgoQMEuWdftf64easliRV6VzN3v4RTiXPkec7e+yyDLjxGPIexiq6aIzB
	 UMDmPKYpJOohMV96MXr+VJ6h+j5VmfCZ/uNFjKQ1aW8+pOdv3QDuVWNlDiSt+id0xIavh
	 q27IGxoXgPPsTYMVVNrU3mTWIAnF7m4El7T/xxW++CduTFJInmPsI3Cgy0EcWMVdqn0BT
	 HdQFpPjxps3ERxjW9Njve1pxCfDnWcMshyy/OojWQVfm38yDAvu5iRfF1Op6QE5m3FB4o
	 R6m45Kao7G9XGjFlTVtZQi1hUC37yZReta6f7r5jUFJbn9kIwdvgJbfy28tn/ZUFPEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559462;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Cy3AvJDhrlzoEp/i44V1yM1DzmGzaROP4/Q3KSzyLzc=;
	b=oTJ8IQ6/g2DO2CjTdfa6FfNOlL3r+HgKux0HolrAvXs/qOwOU/fWLWjc526o2sKnYJat
	 Q4Ib8I+syeOnMcFd9uLrE12R9SvW1oKDqhNlZGcKEopY5NiG3Q4TnqGO0AoDp7eFtgGPd
	 Di5GOCO6it5nkycnMV1tK9T1gckK/DF5A5mX3KLIJd/JWEHetaPhhR85tYqwyA+h1BUxg
	 N/qMWgzej+olWGHNNtCBfAG5wzZnKD26cdrbBSl/BCQ2HJmy7AUv4tXUm4mm2BEbiBSam
	 0rLWXuuXEAO7KGNzfpfiL9iP5TJqcixx7tUwAusyBfQMj6w209soOcthtpWeNCWEx6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="N/289O58";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NykyNwty;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EECB606A890
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EECB606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N/289O58;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NykyNwty
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8V1gd3826892
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Cy3AvJDhrlzoEp/i44V1yM
	1DzmGzaROP4/Q3KSzyLzc=; b=N/289O58v22oRQmUmNi1VIskBnYuHEhIw5O0KP
	3FCAu4aNG0PMJW8GEHauHuvpMoOIwhq0mlso/soEBv2JfC6rkhcuN5yBxL8SOHnJ
	63nGx/spMt7YLd+wrXMI8yESSbnVwXTjDFLKW3WmgdQVVqcf9DGlrWVNLFhTN99/
	triV72jLM1bhzt+3xCnNcbml5QE5kgISORnXobhjTBk36QQ4xl7wk28ukC2JA1FA
	WuOCYrsbrYc2jFB1RJqpI25zskkdrL7TYBoIGlbfifCNhTWNDqA/GntmsM7D4f/9
	B4NdFixpyforbVkIXnTZHIp0V4anyBO6IzdmFavypLOlGdMg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwv37grr0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:44:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3724667bc16so421253eec.1
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 00:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794559460; x=1795164260; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Cy3AvJDhrlzoEp/i44V1yM1DzmGzaROP4/Q3KSzyLzc=;
        b=NykyNwty68JYM5H1KR3wf6z8KNWptfAxdbiMNl+T3HABMtIVtE7UtQSXXYCJCfEX0I
         HW9FlS2wi+gySrUlm02Xcf6QeX8DmSUsTRc92rWw2fYlqZDLXbgZAuDoqLtt+EDV+rY+
         mAptIB9gBq8HIiCvXcvOxwu+Bx5T99PC4yZclBDv9ozQQT3KFYMYS9DCW4tmYF6b0Z3L
         mOY3QW3LkJLp+12h7z9he0nEND4ycqUnjWF+jR7IT9OeihUKYiL4RRo9GyI2F3D3GzlV
         hD7gLSpPH3QwN4mEyxWq3joV2/2POzb1KKBjVLRAS2HPT7XPtss7c9LnQw7en/BibR0A
         uQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559460; x=1795164260;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Cy3AvJDhrlzoEp/i44V1yM1DzmGzaROP4/Q3KSzyLzc=;
        b=JdCD9JQ80H3pGCMis8uIxb5dBq3bX1I0pNKib10M2vyMzRu5Z1hCXmxPLdBwGQIdyf
         Oor8HzyqbCxd/NaBuqyu1O1wkChulCPYRcINiV8nJ3PS/uKcQf8YYOD4a/ZMUj+etzpH
         Z47Gkh0D5z7CjZwOWAZGI1AvBOSysWIthq7yT7YjFk1mT0O+8LKLypXj4v8yEi/Ww8EL
         W862CBlu1Feo9enyaesdGSNW4me30DERvF8ddCH6mxKi9Mlvgh63HxBSO9PCdtTlH5xn
         jfTSAirPTnEl/K/naPLIOinCyePY0DWvb58fK/D7WSeuIzcMtE3g4ZGHeN0qa7flpnNW
         8Y8A==
X-Gm-Message-State: APuU4Z9xtRfE6yXiHJYJ7LGL/V5PMZZsCj5WGiD+ZPplFlnfXNu72a2g
	tApPpd6MBAHIle+mhyf5pm9YEZWKcnYqGFmHFm4AAkoRa0zzPbogOSs3Vx4ahdy7nPFuGOz0QkG
	PcKVRWp7jSVLQ0Gg79ZCzocDQN1MEJE1Jbpwj3DC+R0it/b4n2wEyvWOI3t6ZYw==
X-Gm-Gg: AYBFou1KzTeKHlcEuFL8meM7sDqUqttT4+314Q871hcsHl+Fuy+X7oI4DF3wJtWdjyf
	mFrxrL8lQp/hfgQPAfHtlug2SZNV5/njV14+bjrgLgBgLpiNW3vfgXCK2YmsUoGJTXeIjviE7ru
	OxZW5b4QhdqUQfyk0kXVbCnD/0RCdrzBKHud0YmiKUmMsoJgoDtRrh61G+I3VgWuU3PN89C8uTU
	ICu9jqvcQyzCYVl9WpwpjDe6G2biX94p3AmBJfxUjtGOFUuPVI9Uta7aBqKYywLWB9MrXXv0fuV
	ogKwUqRNYGbGv4Wr5axsl8suvKIoq6mxn+fvfm8Y2GQMS6ZLTulOlNMMwaFPvCDPw+/JQXYTu9n
	9Kb7uZaPiJZx05nfJNap9sO0iB/CeMokANrjU38fhqh/IsxiNlME/DE7uTO667S6Ug/A2zZyn4w
	yaOBg=
X-Received: by 2002:a05:693c:60d2:b0:362:2e2f:c261 with SMTP id 5a478bee46e88-377e1cebaffmr4662545eec.27.1794559459548;
        Fri, 13 Nov 2026 00:44:19 -0800 (PST)
X-Received: by 2002:a05:693c:60d2:b0:362:2e2f:c261 with SMTP id 5a478bee46e88-377e1cebaffmr4662461eec.27.1794559457406;
        Fri, 13 Nov 2026 00:44:17 -0800 (PST)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563df84fsm9662357eec.20.2026.11.13.00.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:44:16 -0800 (PST)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: [PATCH v3 0/6] thermal: Add hardware-binned trip point support
Date: Fri, 13 Nov 2026 14:13:43 +0530
Message-Id: <20261113-thermal_bin-v3-0-878df6eef8bc@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAMDN9moC/23M0QqDIBTG8VcJr2eoUdau9h5jDNPjOlDZtMlG9
 O6zrhbs5sD/wPdbSACPEMg5W4iHiAHdmKI4ZUR3anwARZOaCCYq1nBJ5w78oPp7iyO1IFvQxjL
 gkqTF5MHie9eut9Qdhtn5z45Hvn13hzMmDk7klNFSiaYFCTXo8uJCyJ8v1Ws3DHk6ZOOi+CEKf
 iREIoysrGGyUNDUf4h1Xb/WdNvM8AAAAA==
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
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794559450; l=5075;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=v+B7zag628LCa5QlWMrOOUPqcaxGK5K9/TVhWhfCj2s=;
 b=fPA7n9pK9SH7LHcZWJtAY5nxkjvpnLEikRoSDiB5Q+VoSksczQ4d8KWxk9VjsRJehSKbBJ1k0
 SujInmItuBiAbdnApZgOu2ZpepKcAdxzLMCNpG/mgxGJ+qoIZq3iZ4x
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX1x14rRoJ5Kkt
 VVYQ0G8iMb1yrwp/y1woDEIPHPBhW9JEQyoWDZrB8KbxrE2/hFZd4pRr0O4NSGoTM9xkCkTXEoa
 vgawc+oAhQLL7RQw7cxtDYz+4zWkDN8=
X-Proofpoint-ORIG-GUID: Mu0w7_Dn_aOYlF9ZylCop2VAt4AFNu2b
X-Proofpoint-GUID: Mu0w7_Dn_aOYlF9ZylCop2VAt4AFNu2b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX/tXtahtT+4Fq
 O3x0Sb0vthAOzt3k4qhbxN9RmG7TprqpuV0yhtjD/VntDMHEP5VSUJKMC/srJ0rDT1+/U+czl6Q
 CE9VcYBwVjwHE+gXo29JrWYDSNoSh9L6wxABFR9Fg/x8KTB+iwtcZtQzMtBcCqNKBWHKWY3eTAv
 RLJk4BwVufjK7nXip2Y1AML6oUAtCMoyauqkn46NsI4jecms7JMpSg5SVtftW9+hHO1EcxIg44q
 V3zwM7Q6GCJIED3+utdJPQKjmcHuhN97sbpuhDO95bAedGt2Zh1XiqtvxB5Vunblpw5gjgGYv3K
 q9T2vkS6WHm9ZJoIl6TjsOG5aG8Th7BZzbsAUiazGw2RYrNmON/RthvTc3jAvUVoqOkyeD8DOwo
 ch7VqPvwCpK28Y8E7O7OVIAt+cWbG4ZU1709HoPD8cBZ05598zu3OqQh221kHFMY50sS6KCpGeK
 GHDr3cIeC1pzCXXX9Ng==
X-Authority-Analysis: v=2.4 cv=ZeeIpcVA c=1 sm=1 tr=0 ts=6af6cde4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=OGjWj8McAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Hd7cryhKw5KO45NzTFkA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=UYjydHh6ynBBc6_pBLvz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130034

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
Changes in v3:
- Add minItems/maxItems constraints for thermal-hw-bin. (Krzysztof)
- Return -EINVAL for invalid trip types so -ENODEV remains reserved for
  skipped hw-bin trips. (Sashiko)
- Add Reviewed-by from Krzysztof for the qcom-tsens binding patch.
- Link to v2: https://lore.kernel.org/r/20261031-thermal_bin-v2-0-d76fd073ae98@oss.qualcomm.com

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
 .../devicetree/bindings/thermal/thermal-zones.yaml |  60 ++++-
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
 13 files changed, 754 insertions(+), 114 deletions(-)
---
base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
change-id: 20260917-thermal_bin-fe7becdf0e17

Best regards,
-- 
Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

