Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2DE47ACF6
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328556; cv=none; b=HvYErx6jz+cLf7LCkSdRjneYmG1GpmgL/kpaQOpb4Y3wE2T9EzqS0U+jlBNCH/s3N36673mn6g/Ngd+I51+7xAjYTM5OfvQFnd0f1P7PyJQb7azo9Ujy0houV21jtJdTLi/jiqHlP2c77ez09XdfM2QU7eCpV9+pJT8vuffAgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328556; c=relaxed/simple;
	bh=jxLA9VmqlASnr9fzzhm9WsTas9antlNxLiShCgjTI60=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TEZ7G1qnK4Sf0g8ckPykCDuUbc3esuMhXpJ0PF74yPXt8tbXstdzeJMjZOCrUeMJGRho3EGrmLm9/UIECrCZlzlUBG5vRsrtMYdT/Nvu1xpvi0/EuhmYEArABYH14czsUbS9r9fOtnLAiaabfXk9MEEvD3u4RTSJYiO8MN4ZWk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AwtJ3m/T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MtJZ2PAx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AwtJ3m/T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MtJZ2PAx"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LFmAuw2645417
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WsL4jvS+Ga31ijLrJHkZmB
	bw/qA5cEWR9eTI/qq/0YU=; b=AwtJ3m/TyJp+TmYHfMaDN5nxIh9Ip6mEqguaCK
	eb58fRKb+czLKDDBeJP+3J87Ci44GUX2hLbHX5F6IRGfpJBjpW8AdOrIAvnuCi+z
	IzB/wCF5kaiMfutPG8LXWqGCGZU0jbzzxivo+PwIe/2pLKavxgQ1AaVzkTfDCj04
	OhapEGqqkYyxT8W6nca4RUaLus633Iea0IXLMfzRwgztIkU+tMndWIJy3M/M81IF
	ceCwCR7di09dZy1DivZUeu/bbYs8ROycYKTeD57G6GD8XQf03b0DQE27ADQ2o9VN
	a2mc3BvedW9PDnb7wOHhFjKsW+/AvBUkSmOJOJJ5pLK25cyw==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6ecbascu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:09:12 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4959c49e054so1101344b6e.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787328551; x=1787933351; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WsL4jvS+Ga31ijLrJHkZmBbw/qA5cEWR9eTI/qq/0YU=;
        b=MtJZ2PAxp11YhM+F3nIJEbZJQ0vxZ+8TKnWxj812En+fJ1826qwl+RrutX4sMYBC8F
         /wdam6FxOY6gPibVrIEdO4Pdfr36Rw8emcyxuM0wos6T5aBFY5vtR+SoU6M0asY3KXYl
         kXT+S3T2i6jAwUduZ3gi1nrRYxw0Z0rnJWymhRUDg4M3P7gVwthDAgIpPRk5pjcEnnOk
         hDU5oUS1sTDV+0dpfufWvXLjgX1WcE88lz0ELDVKA5ihsRa8thMRXLceQ3bpXPJ5V7mF
         7+j8LDqBFc1S5/uSsXmALNaqxDNZhxRbgQH0Y4c5aL15IaFeP7WHJBCHC9426XCTLU2x
         FLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328551; x=1787933351;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WsL4jvS+Ga31ijLrJHkZmBbw/qA5cEWR9eTI/qq/0YU=;
        b=Pusse0TfoqkGIbndM6/137Pjq3GkaHY0SIDBE5x+e2y1Hq8A1mm3sxfRkUV6Zw2vEc
         wS3MyBILHZdTXkBCzE+DfOK8+1VCl6cNfAbKIaKVq3+qTOQjraFrpWX4hmG12V7f1vjR
         LeiI9u6GZJubL8LzMS7gsHJkxj8CA9hPTIWWkvB9y3aB021wXcxGYMOJw2VmJZXO7njn
         pSuMRoKdPQMhMEL5soz/BnKPRNbL5lBxbqNeuIwEraLp4zVZqIn6jeVTO4brhB6ovPly
         IrM+6lmp10ypsD5XswvecLgS8yVSSDZGlIhFlOq4JK2G9U6f/1qzm38zDbW9+OO0XfC4
         j1iA==
X-Forwarded-Encrypted: i=1; AHgh+RpShFcC/QAEOURB9yBv5dm7LP6D4vVhBZuXTBPDtMYTf/4G0IEu5S7wmeXFoZraPkTpkSYZzdN0gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKUs2cpY7uUYsrA2XuNZsdAYuu5+SsS2oH9OuFmfpcbF3C0p6+
	GgaT5l5cBXkq/bq1fscUZXablFJwNd1tYGbBTHHlTcwBCD5Z3O4vdQafcVsgG0ZZZ3+/EAqz+5v
	kUAGObxXtVGw0zJJwJgF1mZS386SCVg9j/+KQN1e4h2qsxebJvUJIeeMMqjcg+Q==
X-Gm-Gg: AR+sD11ne7ntalDzVFoyOeLcgyjCshbdyWUeu+hYDUzVxQ+PAeCFLK6/FAQQIBTenWQ
	q7695lmKVEBAXYtv0DoCehsGva+BXKdpqACTT5Fxcw3UFqYmiJv4604Oaqx+4Y1338UJoc/pJBB
	kt17k2LF6Q9jdWng65nqoomw9baa4N6+IkVMqHlPIkXIbUPF7GClQje+0itRDWN8TBPtWSshG8+
	odO00VD3XNPUOFZarDbEh4Rb7Hm+Omh3WrLUaJpSPgUcPRVY/i5vTlFTmJ45UXio2cFJ9KWc31T
	KVes0rwDVtD40AKn8/hY5lvnV7M9kkzU2XHusBzGQQeiYK01CmdH0L7LpsKO6h6LE1wHNI7mYEY
	BKvl1H5sdvZZJfk5K77uzs3sixgJcdTt1qagx7o6PIM4GHJvVv71zZRBfropjChR7q3oHAmlj61
	9M0xkahObzierzK+sQf+cutNk=
X-Received: by 2002:a05:6808:508d:b0:486:45c7:34c5 with SMTP id 5614622812f47-4b2ef40e01fmr8568538b6e.17.1787328551336;
        Fri, 21 Aug 2026 09:09:11 -0700 (PDT)
X-Received: by 2002:a05:6808:508d:b0:486:45c7:34c5 with SMTP id 5614622812f47-4b2ef40e01fmr8568402b6e.17.1787328550692;
        Fri, 21 Aug 2026 09:09:10 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6d34c8esm4804321b6e.13.2026.08.21.09.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 09:09:10 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Subject: [PATCH v3 00/15] Add initial support for Qualcomm Kuno SoC
Date: Fri, 21 Aug 2026 21:38:53 +0530
Message-Id: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABV4iGoC/33NQQ6CMBAF0KuYri0ZClJw5T2MCyhTqQrFDhAN4
 e62uHFB3Ezykz/vz4zQGSR23M3M4WTI2M6HZL9jqim7K3JT+8wEiAxyKPh97CwnqziNfW/dwOO
 6rHKR1QiVZv6td6jNayXPl2+msbqhGoITGo2hwbr3ujnFofeHn2IO/ICANaYlKClOlih6juVD2
 baN/GFhZRI/TpxuOMI7CchCFqkGLZMNZ1mWD53Xd1URAQAA
X-Change-ID: 20260809-kuno-soc-support-1dab826de0bf
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787328540; l=6010;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=jxLA9VmqlASnr9fzzhm9WsTas9antlNxLiShCgjTI60=;
 b=MDYrLP7FcQ+j9/6vo1UFppH0IwWdS86/8og5HAAgIs471fU06m2GCKJ4hbqwj3pUYTH0IYKP5
 Eyv8HwzJtLKCk7AXx93uQ9sX7aXIV7h8HAYjrLM+2imb4FkDcnRF8Cd
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfX85YxpnzY2k7v
 Ohgnkssucg0i/RpYlFxX8Jws71H/wyJputRHgeEpTrBdhqlls71pqcbqd4XtK5LLcy472UCb/eA
 iVqxbb/fvjIwgVBA1sdMxWIgFHgOxfyYGLhe/5zK951aMRag+zHHrqTwf4aS1rPAjQi3+yFablY
 bN8f3a6qCdog2fvq24OqlkTQ7RjrstVYGlU956eiSqh/pBRzOKRK7qHDsHEbvDy2mTtnHF1HBgC
 VElz0KHEySCh0/OaL6Chix2Ml1P+hGiXPg6pbt28cxesDld0dLgb0Hom/lkiPRwwS8fB0p6Ahgn
 8W0Jfywq/Cw6/RzasJK8Js6qCSAU2L0eTRv/zYRSonTHITozltmLWncY5IMzBroYMZCvhnkiWEf
 vWDwVKKFxjGIT7X60ZXRJ4HqIk6UJk0w0gCoduFgSp9rk0iiPbyL+1/n0CZdBV2kjmesR65caXa
 r2OrXj5+/UtjlRvCsoA==
X-Authority-Analysis: v=2.4 cv=e/s2j6p/ c=1 sm=1 tr=0 ts=6a887828 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wcjD13wQ9fZUy7fWwpUA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: OBkMyzBaxjPTkzd2lhleS-xhpfbUdmyr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfX8gnLc7E90Wef
 R/+danz+tYkXwQ9cZ21qPLJj1IT3K1Lz73+7lLsCFfVvzGKon4kvSlCi5imtkvJlGYQwBFMLBUQ
 2sZWfmeSuVpvZbI6G1Mbk869hgp6Tvc=
X-Proofpoint-ORIG-GUID: OBkMyzBaxjPTkzd2lhleS-xhpfbUdmyr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210126

This series adds initial support for the Qualcomm Kuno SoC and the Kuno
IDP reference board.

Kuno is a 32-bit ARM (Cortex-A7) Qualcomm platform. This series brings up
the essential SoC infrastructure required to boot to a serial console:

  - Global Clock Controller (GCC) and RPMh clock controller
  - RPMh power domains
  - Interconnect (NoC) provider
  - TLMM pin controller
  - PDC interrupt controller and SCM firmware interface
  - Devicetree for the SoC and the Kuno IDP board

The soc: qcom: geni-se patch allows the GENI serial engine driver to be
selected on 32-bit ARM Qualcomm SoCs, which the debug UART console
depends on.

Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
Changes in v3:
- Addressed v2 review feedback:
  - Reworked the interconnect binding clocks: dropped clock-names and
    replaced the flexible min/maxItems list with fixed per-compatible
    clocks (aggre-noc: 2, system-noc: 1), required where present and
    disallowed otherwise, matching the sdx75/glymur shape.
  - Made #power-domain-cells required on the Kuno GCC binding and
    declared it on the SoC gcc node, since the Kuno GCC hosts GDSCs and
    is a power-domain provider (following qcom,sdx75-gcc); the driver's
    GDSC support will follow separately.
  - Made the GPIO65/66 QDSS CTI trig1 funcsel-3 route selectable: added
    a distinct qdss_cti_trig1_mire pin function (and allowed it in the
    TLMM binding enum), as the duplicate funcsel-2/3 entry left
    funcsel-3 unreachable.
  - Collected Acked-by / Reviewed-by tags from v2.
- Link to v2: https://lore.kernel.org/all/20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com/

Changes in v2:
- Addressed v1 review feedback:
  - Reworked soc: qcom: geni-se commit message; dropped the Fixes: tag.
  - Reworded dt-bindings commit messages to the "Document X for the
    Qualcomm Kuno SoC" one-liner form.
  - Canonicalized copyright headers on interconnect binding / driver /
    NoC ID header to the single-line Qualcomm Technologies form.
  - Dropped unused <linux/mod_devicetable.h> from the interconnect
    driver.
  - Fixed MODULE_DESCRIPTION casing "KUNO" -> "Kuno" in the interconnect
    driver.
  - Extended interconnect binding to optionally allow up to four QoS AHB
    clocks (matches sdx75/glymur shape).
  - Cleaned up brace/space style in gcc-kuno.c to match peer clock
    drivers.
  - Reworked initial DTS: moved idle-states / domain-idle-states inside
    cpus{}, wrapped fixed clocks in a clocks{} container with peer node
    names (xo-board, sleep-clk), dropped the pcie_pipe_clk fixed-clock
    stub (the GCC 4th clock now uses <0> in DTS to match the sdx75
    idiom; the YAML example uses a named placeholder), dropped the
    RPMHPD_CX power-domain reference on GCC (Kuno GCC has no GDSCs /
    no corner votes / no pm_runtime, so the reference was inert), and
    added a bootloader hand-off comment on the memory node.
  - Collected Acked-by / Reviewed-by tags from v1.
- Link to v1: https://lore.kernel.org/all/20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com/

---
Hardeep Sharma (15):
      soc: qcom: geni-se: allow selection on 32-bit ARM Qualcomm SoCs
      dt-bindings: power: rpmpd: Document Kuno RPMh power domains
      pmdomain: qcom: rpmhpd: Add power domains for Kuno
      dt-bindings: clock: qcom,rpmhcc: Add Kuno RPMh clock controller
      clk: qcom: clk-rpmh: Add support for Kuno RPMh clocks
      dt-bindings: interconnect: Add Qualcomm Kuno NoC
      interconnect: qcom: Add Kuno interconnect provider driver
      dt-bindings: pinctrl: qcom: Add Kuno TLMM
      pinctrl: qcom: Add Kuno pinctrl driver
      dt-bindings: clock: qcom: Add Kuno Global Clock Controller
      clk: qcom: Add Global Clock Controller driver for Kuno
      dt-bindings: interrupt-controller: qcom,pdc: Add Kuno compatible string
      dt-bindings: firmware: qcom,scm: Document SCM on Kuno SoC
      dt-bindings: arm: qcom: Document Kuno IDP board
      ARM: dts: qcom: Add initial device tree for Kuno SoC

 .../devicetree/bindings/arm/qcom-soc.yaml          |    4 +-
 Documentation/devicetree/bindings/arm/qcom.yaml    |    5 +
 .../devicetree/bindings/clock/qcom,kuno-gcc.yaml   |   52 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    1 +
 .../bindings/interconnect/qcom,kuno-rpmh.yaml      |  117 ++
 .../bindings/interrupt-controller/qcom,pdc.yaml    |    1 +
 .../bindings/pinctrl/qcom,kuno-tlmm.yaml           |  110 ++
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |    1 +
 arch/arm/boot/dts/qcom/Makefile                    |    1 +
 arch/arm/boot/dts/qcom/qcom-kuno-idp.dts           |   25 +
 arch/arm/boot/dts/qcom/qcom-kuno.dtsi              |  422 ++++++
 drivers/clk/qcom/Kconfig                           |   10 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-rpmh.c                        |   15 +
 drivers/clk/qcom/gcc-kuno.c                        | 1438 ++++++++++++++++++++
 drivers/interconnect/qcom/Kconfig                  |   13 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/kuno.c                   |  977 +++++++++++++
 drivers/pinctrl/qcom/Kconfig.msm                   |   11 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-kuno.c                |  801 +++++++++++
 drivers/pmdomain/qcom/rpmhpd.c                     |   16 +
 drivers/soc/qcom/Kconfig                           |    1 -
 include/dt-bindings/clock/qcom,kuno-gcc.h          |   95 ++
 include/dt-bindings/interconnect/qcom,kuno.h       |   89 ++
 26 files changed, 4207 insertions(+), 3 deletions(-)
---
base-commit: 28d012efb4327f9c75d5e042a7c91e9a542efa98
change-id: 20260809-kuno-soc-support-1dab826de0bf

Best regards,
--  
Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>

