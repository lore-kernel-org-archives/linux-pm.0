Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C523F23D0
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938032; cv=none; b=UBO90CLfU5xHs7ZOq4IjPLhAetJqTfBnGRgfyroadk5WD8qYWbfRkh0A8cyFcwYr1cwmX2ZvSQ5vxiPDEx3bXVcM/jriU60urNZhbx9tQbKCfSVKEjYiAm/4gyT/pKaWoThmyHEXH9krpyNQyQ9BtZs36w5ZxcGf3GXMii3PG0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938032; c=relaxed/simple;
	bh=fJuyOlM65Puw9W+i4xPVFMT6DCKmSXyYGLqjNJ8Ifc0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oronSX1gzs/1N2fyXwgBphHR48pS/bSnoj7VC6qYLYpYpmtsoOCGWbZFVGSaUzPr07cHzBjEmWxjb2zPESy9586Zj9qWf8n5O8/nyTAlxUrPViljxNoZTS7EdOuZ0tBvzqiVbPJ4xQlTloERMKdbSst2Kc2AAuhsp19y0W8zd+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mN993v6K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BP/gW8Kc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mN993v6K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BP/gW8Kc"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6929nShZ344050
	for <linux-pm@vger.kernel.org>; Fri, 2 Oct 2026 10:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kPlUe31+cjaI3wZHq0lO0F
	0PLbebowSPB4XnFjSdqx0=; b=mN993v6K+n1vpR7JEBc+HxKGDiV328tzGECCw3
	9AUEPQnaAlnF2XICB8BEKW2bfbhioimHsYYk9rur0cjjwzJdp67PuRKv26sAhl1m
	jq1yBQy/NreFdN6woDPoLkNnmep0x3wnlNWpUkfE2CbXG9ZjwYSh30V2ImibiHLr
	5Sfzljdf6xoS5PCKgApJATB/lrDINYV8fO94cVwO7sAyeozU+F7vXTMHx/JUu/Mu
	ZzzYvwe9zyQlZ3N4PWftLZa4q0hR2v5ig+lKZ/LFElNgIalkPRwTF/utihGQz1/N
	1ALPAK9MGR6VsCXn4QK4UCRnxyysIH+0S1CzKXrxkTyOXZ9w==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1rvqc6mq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 10:47:10 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14a62326b51so5184824c88.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 03:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790938030; x=1791542830; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kPlUe31+cjaI3wZHq0lO0F0PLbebowSPB4XnFjSdqx0=;
        b=BP/gW8KcWCqflZlUnSmXG+G34aiF5qB+tTW97qV9UWUAOqvreigDtAIlaIqGIyL2xs
         rLFYijG1d+Ki4CeW4e4vjuJuF+7+use86NgpTbmNWzGshZb/tEuPMabVsD2pEpNi8slh
         U4hNowkouavz172vbEONOxxQ1YK4uDirE+tWYBLXn1hk1Y4tnbRVbKzbepddr7kuo5ZJ
         LEPLmSGadtFSxiiM2cfJ3tkM091TzbNA0orxQlhuvky21BTpElkZvKXQy44Kafe5pvk1
         lMqHNJKy42BObW4ANqV+174QlenCvQPRJV0xa5o+Jhe40UyWtOS1FliHmog4sVCXW0Yq
         JuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938030; x=1791542830;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kPlUe31+cjaI3wZHq0lO0F0PLbebowSPB4XnFjSdqx0=;
        b=TV43sxk6GPNrgunpkZ2vYgvVCrims1AeUbl0rU4VgaXDAK9VxHzEUnyhVr1if7izyK
         jH83qmyIMKPZj1ex/7yql+1SJd9Xz1toak20qlokNhJxqKcyy8bxyjSVUTpSanSeyk1L
         pftM75LqkvWV/wJMYbixBIcJCZOrgAJW4cDcYk9TUgD13C8zZWLPHCHYhUGpdzGT5Tu1
         6YBma70jU5YbEMvP3m6Wuu/Q/Kfk8Oy4F+jqpyj9IsJc5ES1VJdtm7tvjnkaT2u1eCn5
         n1yWCAkXmH/b8XkQ38pLPrhfyzJEq273R3Ds9vPgdr1L3ieqC9wywkvEkXibIHHHMX7n
         o6+w==
X-Gm-Message-State: AFuF++mQ/Y7W3vIaLmue+xDSYTUIbRjYSNTsSCZJgDJNweruRd+TUYMz
	IPEpz03M6ug/2ILlaNDDJCj0WdvPR2EBh8ceuDkl1rTZhsyCcdiRsylUcTnOblyZfRTjj+1Nan3
	P4FTzeKE1D1Gk4Wv6u8FFu5H61hjA78OQqP1c3BzPXH0q1DTcV+eKG+Eh9kMvcQ==
X-Gm-Gg: AYBFou0mxYa36yCu2mnEXkH27N6HTX4x7P8RHj+Kb+p6zwX3f9U6sDlkN6O58umpYoV
	aH/1G2fk/ACUVg4mRsGKx0d7WHEfv6bmDnCgxLTvlHmPDc0admfRxjbyqOi50SKMFHfmgYdh+qL
	TT1YYjdkYwaedFivhvWP24M46BSznoveJ6SIQWfUBbKYT0ZtdM/Moo+hdnZbLsGXwwvE0Zf3qNY
	HMR7I244JGSJDwRcPaP7k3aytFqOvvVfmFK3PUHJhCni8OamMq7uKl8oX/uKJzRaV/N6DkV6dXP
	sp1DNPBt72BbQt5Q05/0Pq69O5gthuKAqM6piX2PC2gxFvcw6mrSBkg8eg9b71eSu3Qj5O4460D
	hxH5MtuBh9kIhfwsNIvRmXP8ZfFMo
X-Received: by 2002:a05:701a:c909:b0:148:4d6c:2016 with SMTP id a92af1059eb24-14f5ba072bcmr2406003c88.24.1790938029484;
        Fri, 02 Oct 2026 03:47:09 -0700 (PDT)
X-Received: by 2002:a05:701a:c909:b0:148:4d6c:2016 with SMTP id a92af1059eb24-14f5ba072bcmr2405968c88.24.1790938028780;
        Fri, 02 Oct 2026 03:47:08 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f45fedd43sm10645191c88.4.2026.10.02.03.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:47:07 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: [PATCH 0/6] thermal: Add hardware-binned trip point support
Date: Fri, 02 Oct 2026 16:16:55 +0530
Message-Id: <20261002-thermal_bin-v1-0-5a29be7e8ec5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ+Lv2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0Nz3ZKM1KLcxJz4pMw83bRU86TU5JQ0g1RDcyWgjoKi1LTMCrBp0bG
 1tQCc4ayGXQAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790938020; l=4331;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=fJuyOlM65Puw9W+i4xPVFMT6DCKmSXyYGLqjNJ8Ifc0=;
 b=J34gI2MrrIl9/GCmK30WCnc+dn9+ND6gC3X+ADXlOwJbYVx0dSHdhb94leGBHcHLq/iNgN5rY
 o20Hkl1q3UfCEaIthfY01TxicXLvGg3XERkadj2UR5gsMdz3pFekppa
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA0MiBTYWx0ZWRfX4in2wZX2CSFb
 NN7SMoXVe1JiNtf4AcNNbbp4dUXZF5NlJErFo3PAWU9o0Duk5+P18FQDkA8QuDwFgZc6URiWPuB
 5PUJZ31GpZLtwxAIf/RDJbEPOBe5x/A4BAI/PAlkZylLrjfh9OryxaTvpQR1auACTZWcqgI37Sa
 aQ2a93JD3UGYd/OpA494Ff6vDHdz+4GiMgE2EMFqkhUlzyfHpzMA+ZTu1Wh0vRCj7PW0DasYrjd
 5dxgO2aXmxZycXA5zDahEi5qWbbze/Gtp3XnKlroJ2uJeCIm4rs+UN6EIGAt+iY8bw5lQzqJzbX
 FC+CS4TqDSKME05/Xo7LcnpIBq8A7w1tvw5tph/hczJ+jPjAYnaC+Q2+mYrYSuEsIy6rsI5zCIM
 4sRdflegrCb9XjBubt1wQAKjuPeENwrAXImOROrLZR89skzhr95LDAUxt3L3zhXpyPf9cg07Trz
 1NoaPAhvo45mXoJX5PA==
X-Authority-Analysis: v=2.4 cv=JIauIMKb c=1 sm=1 tr=0 ts=6abf8bae cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=OGjWj8McAAAA:8 a=EUspDBNiAAAA:8 a=cnS6JDR7V26kcJ3wsKUA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=UYjydHh6ynBBc6_pBLvz:22
X-Proofpoint-GUID: g61J0_H6r_aUI0uuZ2SAy_OTL8umy4sA
X-Proofpoint-ORIG-GUID: g61J0_H6r_aUI0uuZ2SAy_OTL8umy4sA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA0MiBTYWx0ZWRfX+5eiR2+9yBHX
 CDeVO/m6qgBeCsFup+saYfRITdt5h1g0dtYcFM0BmrYxLLmwo8vETpO71ifaSdBvMDZ4OgzFRs8
 LndLkVqMbTt3ik+lI7rVQeBiEkWe9GU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020042

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
Amit Kucheria (6):
      dt-bindings: thermal: thermal-zones: add hardware-binning trip properties
      thermal: add hardware-binning trip-point filtering support
      dt-bindings: thermal: qcom-tsens: document qcm6490 tsens
      thermal: qcom: tsens: add hardware-bin trip-point filtering
      arm64: dts: qcom: kodiak: use thermal hw-bin trips
      arm64: dts: qcom: hamoa: add thermal hw-bin support

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   8 +
 .../devicetree/bindings/thermal/thermal-zones.yaml |  53 ++++-
 .../driver-api/thermal/hardware-binning.rst        | 151 ++++++++++++
 Documentation/driver-api/thermal/index.rst         |   1 +
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts         |  66 ------
 arch/arm64/boot/dts/qcom/hamoa.dtsi                |  41 +++-
 arch/arm64/boot/dts/qcom/kodiak.dtsi               |  56 +++--
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/qcom/Kconfig                       |   1 +
 drivers/thermal/qcom/tsens-v2.c                    |  16 ++
 drivers/thermal/qcom/tsens.c                       | 189 ++++++++++++++-
 drivers/thermal/qcom/tsens.h                       |  29 +++
 drivers/thermal/thermal_bin.c                      | 135 +++++++++++
 drivers/thermal/thermal_core.h                     |   5 +
 drivers/thermal/thermal_of.c                       | 253 +++++++++++++++++++--
 include/linux/thermal.h                            |  77 +++++++
 18 files changed, 980 insertions(+), 114 deletions(-)
---
base-commit: 0d9d0dbf2fddcff5859d623e90ca73c4054276e1
change-id: 20260917-thermal_bin-fe7becdf0e17

Best regards,
-- 
Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

