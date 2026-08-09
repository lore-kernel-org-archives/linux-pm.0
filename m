Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775BA3A8724
	for <linux-pm@vger.kernel.org>; Sun,  9 Aug 2026 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786260446; cv=none; b=NwDSjlI9E5Q6SqTRNrhM3POjLiRpAqH5p2muqvdWX48R2htqf+x3YdSbe6zTRrtcIXiiQADx7sAnhFB3U+myz1TBHM2BC0ySn51OvvYj7xeUyQQ4lOip+3Ise6RE7nkGjyD1pNeS4Tl2ZTthq6NDxSJO2rl/MqpflQ8v6kF2BgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786260446; c=relaxed/simple;
	bh=/Jsp7P44tLtJOlnHOneqYC259MeEKBIH/k/fg6ZZKBA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LHN2sHkrsuh08hZwdcf0vU8u8FEG9oH4jmDLKBsW/JqWY5riFYpEcJvo4uylbDYrT+p6SNcc1oeDotR8JvG1rQYbyo2nWHvJDoixObRdfBbNkuhgr4aX5620f/KTAUpwFVBdNrBLUI2aGPKph9EgVMQDhMqNkdF68PnZKPuxIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WjJfu6rT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eP0somao; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WjJfu6rT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eP0somao"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6796wLE92011883
	for <linux-pm@vger.kernel.org>; Sun, 9 Aug 2026 07:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cBZ+eLbW1mlGqL9Ak7/OeV
	MlOtNX8lTY6pwi+siJQYQ=; b=WjJfu6rT3IfIim8qPqnRzM8pRgViPU4Pv7Puld
	noOhmsy1OYzKVqpNNOlCWXuQf5tZKPJhGd3MHqp7wWColXJc0f3+m4DJ1nx8bvfk
	6+bBTr1LUrDINesgm8qQN5RgFPNGwR4F/kkVAGq7BTQSSTdUFSpaeiKzhEjr2zKh
	ZtnJyU14mei15W8jZb+Lgod7mDEt0Wm1dJ/oxcm55RsV5l2d6hNPhXAwdE4KxiTG
	goCeGDtz9uaAmlS2eZGNSrMyCmUD2w4/KbZxD9EB+Qp6ssWP27esXkGr2O4STeLS
	wZSFN4yGEc1IkoJiOUJQBB5jAZGDfNj14A4KAB7VdtR+Civg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwush2j2e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 07:27:22 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e6d253330so1059739a91.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2026 00:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786260442; x=1786865242; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cBZ+eLbW1mlGqL9Ak7/OeVMlOtNX8lTY6pwi+siJQYQ=;
        b=eP0somaolbhMK123TXir2vmlyQtAxmHM05Fx6qvZQdaNU51yck+gRuJ5guuNk6tFeh
         ufzb3Tcjt3/jMQQa8I9zdWOhA2BjwZL5fLyfD+l+hl3lve4WdJstEB7bC7D6dNbaEH2p
         NaIHai8mWwHUeIu4oaSJROSdBrNtqHF9Cne4jJu9URacdCRaUh37o7ntRHCVv0SstRD+
         uxSbFVM4dW9eja6kLWYytVSEmP5aUOBhR0ycA5dZVGIdxSC7wT40zGZACQwAUTgbMs0w
         lYVP+aUbt4Puf82I2+loKrcH5MxYTwN/j6ns6lb4G0D7Se/VU31x6nWwUx0x+0D8OD8A
         /FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786260442; x=1786865242;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cBZ+eLbW1mlGqL9Ak7/OeVMlOtNX8lTY6pwi+siJQYQ=;
        b=okXhWyVwimcDGy7zpHK1bTkDKzakWdvxBRdekzAIxROKpeYgmcrNJv4exHo06F8hBt
         bk3ADBEc6p6geWCnsEmoTf9jnv4h7VGzt8ewh6hmZTNfhZ8Z62fQtWfib+a7ueHRE+Mm
         oO5F2ZjqhK80df+bkZS4FiYE0/arz711gC0AeMcUyvzsFnGUtd24ZHb5VQVWc22c8D9d
         4OmeLkG0XW0EjxCkDr3R9MiehZht4eag9/c/nynW0FZFWBKWRPPtfie7BGhXeYFaRcUi
         +9WzbVRExiAY5pZJh+/Mf/gsLIECKGJLZcEH7rMWyZypEBUx3MR0kdH1gGGB/UNuYrdd
         GnQQ==
X-Forwarded-Encrypted: i=1; AHgh+RqSMGOBp/Wn9Kig3Y9ebQLppwhm5rHIHGuRFP0dQgIOaLwrMlqegzgzogdO8s6HiIftSJOTaTa74Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXU9Eu+BkkrQorNFPFRcBuKBQfGqprwNCMVSxPa9FFIZdO/Gka
	INBb9aMoqbyCpgAzuVKbp/l0q9KKfJccMUVsyQ+7N6Lp4NIjLllj8NTFEHacqvUX/uBhD27ERuF
	2thuEJ0WwX9u6oq+/0osorGmI5MzvmXwnTWzpy+qUfZm9zLqAa8Q9N8gVuq3Zlg==
X-Gm-Gg: AR+sD11YFp7XE0+p8/KluVgUaNYDNofyuTYTaRdD98sDjWPFzfdSzW+8nY05VtQpP3P
	2/M1XJAjzU4f+yRkh8QufpoQB8LRTvzESL/kDMbFhxghws7hw4E83F4hIwz29oyQWg13hpDbjEW
	ddbMUMI/tmHXA8UjgqlmUyKFXyMtdp+Lbkmb/DR96MI8+ckSZsKjmxN9axEB+ud3VDC0mjSw/Yu
	EA1Q3ZM4g5mHp2xUha/2ZmOawS9Cd1wyQo9DuDhU1+trluONa2rb5+1+WmxwvRb8f4Q1FfFy4Vu
	phsRbY4kKupd1iAQmjI9Z2R+H/xURQTijkXqiXiPzQPiZ4fJMcI3OiZKQvX4d4bO1m/7c+k+Pyq
	CiZcWSmO4ljrUinaoSDa1czmgFxfcBnc7TNW4mK6EnesWp/IRQ4eK/ZlXBqcpIVRmdUBtK23J0Z
	/mPCrEubYRvDxYAs2gcDEXp6U=
X-Received: by 2002:a17:90b:3985:b0:38e:4f31:8412 with SMTP id 98e67ed59e1d1-3928470124amr4899569a91.11.1786260441907;
        Sun, 09 Aug 2026 00:27:21 -0700 (PDT)
X-Received: by 2002:a17:90b:3985:b0:38e:4f31:8412 with SMTP id 98e67ed59e1d1-3928470124amr4899539a91.11.1786260441422;
        Sun, 09 Aug 2026 00:27:21 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4eabsm22655630c88.6.2026.08.09.00.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:27:20 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Subject: [PATCH 00/15] Add initial support for Qualcomm Kuno SoC
Date: Sun, 09 Aug 2026 12:56:59 +0530
Message-Id: <20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMMreGoC/yXMQQ6DIBBA0auQWXcSZGGoV2m6EBh1agKEEdPEe
 PeiXb7F/wcIFSaBQR1QaGfhFBu6hwK/jHEm5NAMRpteW/3EtcaEkjxKzTmVDbswOmv6QNpN0LJ
 caOLvvXy9/5bqPuS36wPn+QOs+sUOdAAAAA==
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
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786260433; l=3517;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=/Jsp7P44tLtJOlnHOneqYC259MeEKBIH/k/fg6ZZKBA=;
 b=h5JXYnqQMhEtl8w3fxLi36MDFjd8N4CmajKqzBnD/JHcQsYqMPf/iQ1b5wxO7rVJTTO9inXI5
 CfO4Ma0JMXIApHJk0v98xzk2/Hh8dgwC3L/u9byvG5t0RSKl1u4Ffj/
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-GUID: VLtBjwfj1TAjGCGYEfpUkunaxp-tfXXb
X-Authority-Analysis: v=2.4 cv=GvpyPE1C c=1 sm=1 tr=0 ts=6a782bda cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=o20KKycpbvKjA6q8TgsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: VLtBjwfj1TAjGCGYEfpUkunaxp-tfXXb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfX1DS/ZUB6JEZX
 mB/0zuHRn6TVhERC8+QhEOeTqO1KGceL5EtxymahgwYULFs6yxvOpRuB6f0YARDLN1B4RuB+8H5
 o3WoK18qFmoFy2mVDddwfhDCui2alAneRK4q0ut3J/SQTiw74E3XPxT2EIY4dOp4o3uBjIObgQ9
 W2OuB/NGT2geJFJ/l9UvpCnyHn8JoPgkD8EvPBWSuLnJ4ddnhvBY1tXLFzEI9q9bquYFAVcZL7s
 9veVgg9ZDspfpFD+6uqjHGJ4hGh8JNragGiOeMj/ZY7Vsbmyvjnnm7JYwOjWMs4oxmev/af8Xeq
 shhPS0nA/iyUyE44m55ICpHawoNJpQeyUgy0PJrm46MuXMPAAYUsei02FfsAKtkdY9SlwSexp9e
 drJ/gDSXQ9lpgfHJM7ztPDKjrEjuHDIXCx+uXl4sCj8+aZ8KL7nKIAFaG+7+6ffgMRfITlrLpM+
 0n3Qjdg63ae7B6ZE/+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA2MyBTYWx0ZWRfX+eR+DL6Lujom
 p06ZIwaqdNBzsRzNmwsxLa0rtHzyf7UYfIBC35T/VOr7HxG8vBy/EbQHn7biwNDu6qLZGlndWwV
 s2LBrweIO6KVUkz/lyY4UMaLX472EJQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090063

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

 Documentation/devicetree/bindings/arm/qcom.yaml    |    6 +
 .../devicetree/bindings/clock/qcom,kuno-gcc.yaml   |   56 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    1 +
 .../bindings/interconnect/qcom,kuno-rpmh.yaml      |   72 +
 .../bindings/interrupt-controller/qcom,pdc.yaml    |    1 +
 .../bindings/pinctrl/qcom,kuno-tlmm.yaml           |  109 ++
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |    1 +
 arch/arm/boot/dts/qcom/Makefile                    |    1 +
 arch/arm/boot/dts/qcom/qcom-kuno-idp.dts           |   25 +
 arch/arm/boot/dts/qcom/qcom-kuno.dtsi              |  423 ++++++
 drivers/clk/qcom/Kconfig                           |   10 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-rpmh.c                        |   15 +
 drivers/clk/qcom/gcc-kuno.c                        | 1438 ++++++++++++++++++++
 drivers/interconnect/qcom/Kconfig                  |   13 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/kuno.c                   |  978 +++++++++++++
 drivers/pinctrl/qcom/Kconfig.msm                   |   11 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-kuno.c                |  796 +++++++++++
 drivers/pmdomain/qcom/rpmhpd.c                     |   16 +
 drivers/soc/qcom/Kconfig                           |    1 -
 include/dt-bindings/clock/qcom,kuno-gcc.h          |   95 ++
 include/dt-bindings/interconnect/qcom,kuno.h       |   89 ++
 25 files changed, 4161 insertions(+), 1 deletion(-)
---
base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
change-id: 20260809-kuno-soc-support-1dab826de0bf

Best regards,
--  
Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>

