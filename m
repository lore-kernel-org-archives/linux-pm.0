Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88BD481AB5
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848703; cv=none; b=iqmA3Uevt70eSdd6vDiegjgM5MZHU2p7h5L1/mTRJFAF0xXEa22OOUprUa387QmQM1rT0CblzAe3O44iMBlMqZ+I1rIxv0TRYGio7Y6TLPRoKJ1BPJiXM1FFlEqK1M988+N29uj2BjVSdwSGf0zqzhPQHYvjwKomitCeSUoWFBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848703; c=relaxed/simple;
	bh=IuLBCG8fwivf7QD/EPSNHEsGg4a/dKCd3dCzYHyww5A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cXb9i8b6ZDQ59bCzl5rMg0WBJX0muxoZFSN9q9QmmtYaNNyl33epiZNJAZPr6RRl0g3jgmiRVDieu2VKwfnn2KGXpcQHNgoOUXD/W0+RN9oImo7qsvemYvwkv18hPzIzJYdNpRDoooMLSijRsxbMROVAvtawM7uNTBwPQHKApHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kFmEosoG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I1+Pud5p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kFmEosoG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I1+Pud5p"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RFbhc7865953
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XgLhebGOrPjpndKIk3O4PW
	v8zb8BOpN1xx0Y0zBAdl4=; b=kFmEosoGmPUGPAYYv7npWKg15PDaL7cveL5kkj
	bnMpS0ABsw0SC/sNknOKLbM0TEtIoMPyIrJZkqBmYcyRY7AtOqlOHwCT4CwwRX77
	c2/ggd3qDZqJTbSk+0uzPpHJ84vSKS1PphjfvvkyXgaGLrOxIiZdflUkYI4oL8z2
	jWdOU5LqcMKJtxAF4+GPLfBVW+Ag+1UUSUb9g+OH6vyUjIfDUq1WV+mLq/SzH3Py
	1AIjIl5+8dmQwFOblKV2CDCL8PBrClq7+pcwRn1ha0dGejvy42hVbfgdCJ5nkPGQ
	ToGhNyR8CTPHO6NqQmZD9lhRL9Qgi7JOo5WxPj6yH9Brg8zg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgv8r8v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 16:38:19 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7f4e98783d1so69177a34.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 09:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787848699; x=1788453499; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XgLhebGOrPjpndKIk3O4PWv8zb8BOpN1xx0Y0zBAdl4=;
        b=I1+Pud5pw5b1vS0v2lK95w61BJ2uEaOAVRILVDUL0x91bHodO8OYbDwkuL88KHM+Ww
         gY2MArQiDzZwueZw3SIaA0ol/pPqA3sb7b10FcAWXDBmKoPxQHc92BvXU9XSQvkBmCfb
         XKAcyd3QQZDzTbHVq/nJ7c2ul7ymuD8d52iLbZUnUkOapwHqaCvSAy5BqDJW2LzBvkUM
         PnFGqDOoWwX9c+tTOiq5LuVMnL+moUYBWLGSsVd2ZWSAgBQYeGFqXPPPUgtsBDI2nrtE
         FoELBX44o+EN6e1s/b9Hoth6BVuYQMC6ZqaIcbc5wvd9g/7oVQvWg2hyt8YKf57lqn9L
         q3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848699; x=1788453499;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XgLhebGOrPjpndKIk3O4PWv8zb8BOpN1xx0Y0zBAdl4=;
        b=MYmOIa7Kg2cPWINk4aN7zd19EDX4+EBDwEHqzeFKgMH2nQnwbTqdmy7kpKAAxPKW9R
         Y2CETSXZIRMJA4vJ1vZ0Dbf2u2nvcvDJEjVb+o/l6Nc4HxqAPNA1IMhTb04R985t6gPK
         dIldYoyPfODkOMryTf9Y9lqz2+7h4Z3TSEC6j6iLY5kKlFv+OlpbJXcBPMLRnhN67MIq
         f008vp6NsApF5ZOeSB4BY0k12Mgq4o0vKFONKjFXtvKskHStPDrvPtyvUk7c4dHrN4MF
         JODn37z6mU0Akgh0jh/qivERlcvVUniPpkrpQM9l94z001+vem5Oy7yGCMrTzdJiGsnV
         Hsjw==
X-Forwarded-Encrypted: i=1; AHgh+Roh5tLU77BgaVTsOHTwEgIeXaS1CQNUa0dWk01nE7FgNzV2FzdIjDB3BqAYAx9a6DXiwDlQTtFnEQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kYrQRiZdI9Vrx59SaCQ5/xuEkyLz5w/pti3YB2xXG/Z700wFQj
	sOCLuzodhAR2Rrgp7sgb/QsSGjFzLbjIXnmi0ll654jfDlf6s2JzKDFrbHAkkYTvIlC/bUexzqj
	fN+gptNxom53vRgwHhEDdKqLalbEIzS+o8JmGfyaOeWf0I+vU4OYEdRONHOWryg==
X-Gm-Gg: AR+sD122fPQs3sXVNoNh9ezDlCqEQvVF0Gppr0jPegQDpYPGQdySXc2Q1lWNC3xagDv
	bZIe5EZT8zFsWrFwc69yoB0Aa7VPvINxc9Mz2Vm8XOgsfUpXEk+vfYZghVx4Kq99ooaW3V90kYe
	dr+qh6UKb1I/1+xc/S6tN8Yl05VHP5Zb4RaIPbUf4fMUFba4grgpU5P+SBuvcCoreRkeX6/gaTN
	wrOI+Ox5bwQVRnYg/BW5JP2vzYpsSwzdpbbuLnGF0/fmomAfXI0GJ39TnrqyowZV2fx6haPXJNW
	CjxdrywVFT2yRwnCGhj0jFpmVv/Xiwd2QZ5+Mv46FWvupbmVbSATtEdz8CcTJDdrGY6NVFceLBA
	8UsymHNcz4R6cz5adSmBaQJ4HbKq3h+vZrg12CKTHHCiC93RIOeoZIwO2wMzkdNmsu+flgG5qBg
	Dt5T2tiwzjttq4zvnHKo+ORT4=
X-Received: by 2002:a05:6820:1c9e:b0:6b1:c1b5:7f96 with SMTP id 006d021491bc7-6b1c1b58a27mr263730eaf.14.1787848699037;
        Thu, 27 Aug 2026 09:38:19 -0700 (PDT)
X-Received: by 2002:a05:6820:1c9e:b0:6b1:c1b5:7f96 with SMTP id 006d021491bc7-6b1c1b58a27mr263650eaf.14.1787848698450;
        Thu, 27 Aug 2026 09:38:18 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b1a24bce78sm4253171eaf.3.2026.08.27.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:38:17 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Subject: [PATCH v4 00/15] Add initial support for Qualcomm Kuno SoC
Date: Thu, 27 Aug 2026 22:08:01 +0530
Message-Id: <20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOlnkGoC/33NQQ6CMBAF0KuYri2ZtljAlfcwLqAMWhWKHSAaw
 t0tuHGBbib5yZ/3R0boLRLbb0bmcbBkXRNCvN0wc8mbM3JbhswkSA0pZPzWN46TM5z6tnW+46L
 Mi1TqEqGoWHhrPVb2uZDH0ydTX1zRdLMzNy6WOudfy+Yg5t4ffhAc+A4BS4xzMIk8OKLo0ed34
 +o6CofNK4P8ckS84sjgKEiyJIsrqBL1w1FfjhQrjgqOyDTKQoFWOl1xpml6A56YQ1FZAQAA
X-Change-ID: 20260809-kuno-soc-support-1dab826de0bf
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787848688; l=7023;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=IuLBCG8fwivf7QD/EPSNHEsGg4a/dKCd3dCzYHyww5A=;
 b=6B8BxUlMPUMsylsRHyitMa2Od5NzIDaznMlx51zPqCnskxQq1AOXN9Rq2cA5EasT28/SZXnyU
 iIQVr+Htp39AP7H9U2SQA67oKpJF9KYlSBsxh3K6AjTcRH4PqFrofAH
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-ORIG-GUID: AYQkiSriy_lN-UFFdv7DP5YCcwp5u0V3
X-Proofpoint-GUID: AYQkiSriy_lN-UFFdv7DP5YCcwp5u0V3
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a9067fc cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8riaqLHWwNYsoh2d4OYA:9 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfX0Yw8KnzSxJgL
 vx8wDqhU4+SGvFBNx2ZYM2yOXZfw5iBerG09ep0BqxzN9H9lNwE1JWrD4rNFrb8raVbV8oN+EFl
 1kXavfvhqFuBcRBYapI543wYt7HWBR/oIjgpkIXYwrWqojsFQTJk+fdLwpE7eJcN8zcS2rMIM2w
 L4T/r1tA2TgSF63PYunLF6xiwHV40joKaFu3H9XvjpmIeMmKwnCRUOLa020ENCLfvSHOsCLsLEk
 Uf0bVBqGwEqixa81G8ZmMTqSaVJpaaQi+C2I1AUCLNAu26kkyKoNzsFV4mkyq4Xjsjl3k0nXyXZ
 Q1YTST9YZmxXtOb6YUWVACojh6RgHGJDJIYFDUkclEBfRm/toiZBMsV0KEWIkKgfu0eyI1x6TAN
 EZDeB6jv+TERw5ZVOBQ3QW0kterj+GQUHXgcQM8s98FzaPFwBv/idqH26jowdnx+BUt/ArI0x4Y
 f+MkmYwJrX93Tclcgwg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfX9V4iu7W+u7HU
 JSrJ0SsINAVHfx2O8yJ6JPx9bHwrXhmW1y+q+NuUQ0nX93tfU34jF5FubDJ4ZiGaB7rWcGYHJNN
 ArE6pirtKW2GUQ/7uZlEcWw20MI10lY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270140

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
Changes in v4:
- Addressed v3 review feedback:
  - Registered the interconnect NoC provider from an explicit
    core_initcall() instead of module_platform_driver(), matching the
    established qcom interconnect driver convention.
  - Replaced the NA mux-slot placeholder with _ across the pinctrl
    PINGROUP table, matching the upstream qcom pinctrl convention.
  - Added minItems: 1 to the interconnect binding clocks property so a
    single clock is valid (system-noc), and aligned the binding
    examples with the sdx75 labelled-node style.
  - Added GDSC power-domain support to the Kuno GCC: the binding now
    defines GDSC macros and the driver registers the EMAC0, PCIe and
    USB20 GDSCs, so #power-domain-cells has real backing providers.
  - Split the cpu-idle-states phandle list so each phandle is on its
    own line.
  - Collected Acked-by / Reviewed-by tags from v3.
- Link to v3: https://lore.kernel.org/all/20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com/

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
 .../bindings/interconnect/qcom,kuno-rpmh.yaml      |  118 ++
 .../bindings/interrupt-controller/qcom,pdc.yaml    |    1 +
 .../bindings/pinctrl/qcom,kuno-tlmm.yaml           |  110 ++
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |    1 +
 arch/arm/boot/dts/qcom/Makefile                    |    1 +
 arch/arm/boot/dts/qcom/qcom-kuno-idp.dts           |   25 +
 arch/arm/boot/dts/qcom/qcom-kuno.dtsi              |  423 ++++++
 drivers/clk/qcom/Kconfig                           |   10 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-rpmh.c                        |   15 +
 drivers/clk/qcom/gcc-kuno.c                        | 1483 ++++++++++++++++++++
 drivers/interconnect/qcom/Kconfig                  |   13 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/kuno.c                   |  988 +++++++++++++
 drivers/pinctrl/qcom/Kconfig.msm                   |   11 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-kuno.c                |  801 +++++++++++
 drivers/pmdomain/qcom/rpmhpd.c                     |   16 +
 drivers/soc/qcom/Kconfig                           |    1 -
 include/dt-bindings/clock/qcom,kuno-gcc.h          |  100 ++
 include/dt-bindings/interconnect/qcom,kuno.h       |   89 ++
 26 files changed, 4270 insertions(+), 3 deletions(-)
---
base-commit: f82a5da2f04960df9fb57489992d03dd5e64ec6f
change-id: 20260809-kuno-soc-support-1dab826de0bf

Best regards,
--  
Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>

