Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41D44CB8C0
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533491; cv=none; b=aufgb4OgwVR/8BTzBevSKid6uSMh8CMzisHNgffZkjTb9djrjmJp2lKaojDpeiXtZC1vvwWKpeKJbbA8O3xlpZAt1/m/yvZ19nEJ8LwDgACV/bNpCV6/Uf8eldEadt5q8GnSsy5p9w8ZuCNSAr+IGU2tZF3A7o4Zs12e6bpubrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533491; c=relaxed/simple;
	bh=4qlq+WoWDdP3LO/Tt+I6wW3GULvBfoVrK77wA/CFzNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzLZnF2PliCkJGK9cglvCitOSOV1vC3I9BAj0rQzOxFNjy3TphYTTHCUSrtM7STBxzUfAcnjSEdIO3vE8MO2euq+GQ5Lnmg0/nI1COOsgo622ynMcv74qYBzbEuLUWGC3gP3khFcneiefTO2+ImJCCCqe6nrKuxQA0NbeadEawY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PaoyEm9E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h5rhSWxS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PaoyEm9E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h5rhSWxS"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Eifks3329787
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 14:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nmvA54j4qxn+u/O1Um3rgkVyl+esfP5kGwEsz0xU2hI=; b=PaoyEm9E0uHB+pR7
	Cd0yJGOfA0J1lRUzL5Z0dEkcw7nQV5H/K2jR9GiEUeEjLcka76RUaBN5ohYK/Slj
	iM28SLrsfld8lOecTTGHVa8Q2E7bFJMbcdkmq8ssUfOQRPEs38T6WfY9ABe53HF6
	dD7KuHbJO4SWVOdHEOV9KT6L6StrvXkxjA928tI+IHck0fUlpLw0bna/yiPwjoaV
	y+iEiPdyYum/YnSu0CDyqSKsGJQtXfn7byqIvCGymCLq0cOSN6g9W4/VO2WPJCP2
	qWBcQfZMGz4vaPZ8wKViH2Wytnecy7Kh5weCjJtMVMSw+268dObYcMGVLqO30y2Z
	X/TZzA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg00y80wq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 14:51:27 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b3962f71e7so1458798b6e.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788533486; x=1789138286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nmvA54j4qxn+u/O1Um3rgkVyl+esfP5kGwEsz0xU2hI=;
        b=h5rhSWxShTcYs43+shUwkFJAhmmHgCuaWiCqcqx/MAIsMqeR8k3TZhB/02Cx+K/R+b
         JNVBrClRBm67v0UuzPEdVyMCibAoyUDqrxAUhMYdie8fAD+4WDK8ogcGOOQxlUE+1Pok
         KW1J0DMkkU5Wk1siH629MVr9pB3LpFo3MUXNF79LpsDhn8Q1JynG5rgmxI89D/0cutL1
         bQcIAS+G3h+g4wMSN/0FPO+n1jln4KXk1QcsSgrr2oCGIdfzX2XU6EwGkfSfd/BqvHN/
         agE7aLK6MMBPATepaVS8ktFhCGocrzvyi+MffnSgHioTDLb4N/HE/8WG6ZEHn9lOjapq
         2Gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788533486; x=1789138286;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nmvA54j4qxn+u/O1Um3rgkVyl+esfP5kGwEsz0xU2hI=;
        b=Mu9cqHkb+VMMHnz5BtySjj9V/5hKV2uxAEATFEKw5+5rd4R7kv7UOyoFgkCqHZChh8
         /BO3IGKsbPmvnQdYP2icIR2M2vFpU9UY2vgjrBNyF6oYOo/dNqde56oR9ii3ua7egX0w
         byR3nMNTXPZyPvXMHiz/u2n77BsuTmtiSFJKul8fJDNvFtjYYG5l9mCRiaqOTSu7CT8e
         FP7G5uFmst1hAqbW8UYuM/+PztwB0C30Rm4AVQZytVXM/SctOXVgKmcoLcFZDHb+Urz7
         Pny0sXbKc3UNrS/NZeGN5bmueb5CyF6JNWw7X0ayU0sgt1jW3slha8JF/HNNAKWzHQJs
         XCjg==
X-Forwarded-Encrypted: i=1; AKwUvBzLEzoiP0grwmKCXkFcWLJMPEYsIknA+RuPE3oT0MCNZ2MTQe+8cfLeXvaIrsFXMODC/fd6y16UUA==@vger.kernel.org
X-Gm-Message-State: AFuF++l7zB3X7vItu0544zcey0ybr74qjB41T2cEumFyuKvA1Sg6Z0rF
	757J+0eoofS2UTawOaGfZyCwS03Lu/y5V7r2hWWbk5HxJ0Ec/DRsSCBVxj1Q9zv8EYNVfDFOYZB
	GaHiH+8JoPap5IGSYnX0sIIlSWdNsrioCb1m+F4YwQjIPrxI0EmbTdMDS0yyD7A==
X-Gm-Gg: AYBFou0DbCq75vZztxsiUV5FSvITmK41ys8+uwzadUrk+ojf0AjTCzrF94K4nLoYFaA
	nFrB+MFeq1eNgOjgA7GZV5ZwU5vdIJcHSVrQohvPd7ohBnNOXaDD9jaJcInDs+DCSqmO4ZALRW1
	BJVzN7Tj1eDZTSVE5tbuLZMhp7AYqZWKNaTS5g3pg1fBz6ybJvhAgu8RPZhRMn93W5Wm1EmnxGn
	UZkfCX5rYNtYyOX1oSIQVngkVspoK/4EXeYxgAvYdrCQzFYt5NE2VF4y0WgaieaXT3LS25AGdaj
	EXjnfgohkKIlJt74m9UjYiS/NB8MMlzHC0f7SpXAIOVqJ/f8HjcI/KYfimkjNabCrn6NM67k32O
	OibUKBtfVWNKq2Alxd4y7bcWt+8U0PkIX
X-Received: by 2002:a05:6808:199c:b0:4b3:1e40:640b with SMTP id 5614622812f47-4b95fc5bbe0mr5026810b6e.6.1788533486070;
        Fri, 04 Sep 2026 07:51:26 -0700 (PDT)
X-Received: by 2002:a05:6808:199c:b0:4b3:1e40:640b with SMTP id 5614622812f47-4b95fc5bbe0mr5026747b6e.6.1788533485428;
        Fri, 04 Sep 2026 07:51:25 -0700 (PDT)
Received: from [192.168.1.6] ([122.171.23.238])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971c98e07sm2181070b6e.18.2026.09.04.07.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 07:51:24 -0700 (PDT)
Message-ID: <8b2eda64-3556-4cc6-9e46-f3e0eb0efc88@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 20:21:13 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/15] Add initial support for Qualcomm Kuno SoC
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
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
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b4AJHmB-rwLqs-6AAMyEQIGNlG0ZABQE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEzNSBTYWx0ZWRfXx6n92A8n0Qsc
 fdBhWhTeMzFRubQMNCOmd0YQ0X08Kypo9nPF+F3uY0LYFh+F2x9MUNDd9wOkM2MZYz2SGworV3d
 4wle9sw/UeiK+8EKeORFRvm/kzS1cSnYrHHdXL/zHwkKSzUI5EvAv2xXlm48vJhM0dAGiIu382i
 dsxkNZhTCgj+ksD/KRwXmH66KzYAj+aTSTiYScif1I4avbzjP3Vqh+DIWbFUWIzrjqy2WZbIU+5
 eqNtLKsnKp2F1phIDlLbw4mJUsVTKn2oKGdKl18dFBerDcNXsLwPVx9hivQ7RahTguatWFtHm4T
 HGSq05zeBx165Ln2SRidQNmNRwgH1xtu6Y+mhzFCAA8jngcXQK2K1reSZNKzzJIwelVCXKOLp7l
 NtdOzic8fUbHsYfuVfi3ha3ejHPjMFNvzXGA3zptNUgpKhZlExL9Gu5+oXkMJ8N1VCeIL/mkH3M
 ZVBI0f1lNS9j+eTJ7Rg==
X-Authority-Analysis: v=2.4 cv=TsPWQjXh c=1 sm=1 tr=0 ts=6a9adaef cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=yuUgUKvUcBqN/nS51auinw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Sism7-CWozsur6xqZRkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=pF_qn-MSjDawc0seGVz6:22
 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEzNSBTYWx0ZWRfX0GYwQImWQYbF
 3E6YwiP1tc+gGxZbyS3jGPTUkYYWRZFFqyiwGjsQO9gM2mCE88vpHHWbF/7wn7Y+eqWu8jVJ38V
 qjSmgi8ahSTlxirYn4v4jPtcyhanbo4=
X-Proofpoint-GUID: b4AJHmB-rwLqs-6AAMyEQIGNlG0ZABQE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040135


On 8/27/2026 11:21 PM, Hardeep Sharma wrote:
> This series adds initial support for the Qualcomm Kuno SoC and the Kuno
> IDP reference board.
>
> Kuno is a 32-bit ARM (Cortex-A7) Qualcomm platform. This series brings up
> the essential SoC infrastructure required to boot to a serial console:
>
>    - Global Clock Controller (GCC) and RPMh clock controller
>    - RPMh power domains
>    - Interconnect (NoC) provider
>    - TLMM pin controller
>    - PDC interrupt controller and SCM firmware interface
>    - Devicetree for the SoC and the Kuno IDP board
>
> The soc: qcom: geni-se patch allows the GENI serial engine driver to be
> selected on 32-bit ARM Qualcomm SoCs, which the debug UART console
> depends on.
>
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
> ---
> Changes in v5:
> - Selected QCOM_GDSC from the Kuno GCC config. The driver registers GDSCs
>    (added in v4), so like the other Qualcomm GCC drivers it must select
>    QCOM_GDSC; otherwise, in a configuration where nothing else enables it
>    (e.g. COMPILE_TEST or a minimal Kuno-only build), gdsc_register() returns
>    -ENOSYS and the clock controller fails to probe.
> - Link to v4: https://lore.kernel.org/all/20260827-kuno-soc-support-v4-0-dd34f235fc1a@oss.qualcomm.com/
>
> Changes in v4:
> - Addressed v3 review feedback:
>    - Registered the interconnect NoC provider from an explicit
>      core_initcall() instead of module_platform_driver(), matching the
>      established qcom interconnect driver convention.
>    - Replaced the NA mux-slot placeholder with _ across the pinctrl
>      PINGROUP table, matching the upstream qcom pinctrl convention.
>    - Added minItems: 1 to the interconnect binding clocks property so a
>      single clock is valid (system-noc), and aligned the binding
>      examples with the sdx75 labelled-node style.
>    - Added GDSC power-domain support to the Kuno GCC: the binding now
>      defines GDSC macros and the driver registers the EMAC0, PCIe and
>      USB20 GDSCs, so #power-domain-cells has real backing providers.
>    - Split the cpu-idle-states phandle list so each phandle is on its
>      own line.
>    - Collected Acked-by / Reviewed-by tags from v3.
> - Link to v3: https://lore.kernel.org/all/20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com/
>
> Changes in v3:
> - Addressed v2 review feedback:
>    - Reworked the interconnect binding clocks: dropped clock-names and
>      replaced the flexible min/maxItems list with fixed per-compatible
>      clocks (aggre-noc: 2, system-noc: 1), required where present and
>      disallowed otherwise, matching the sdx75/glymur shape.
>    - Made #power-domain-cells required on the Kuno GCC binding and
>      declared it on the SoC gcc node, since the Kuno GCC hosts GDSCs and
>      is a power-domain provider (following qcom,sdx75-gcc); the driver's
>      GDSC support will follow separately.
>    - Made the GPIO65/66 QDSS CTI trig1 funcsel-3 route selectable: added
>      a distinct qdss_cti_trig1_mire pin function (and allowed it in the
>      TLMM binding enum), as the duplicate funcsel-2/3 entry left
>      funcsel-3 unreachable.
>    - Collected Acked-by / Reviewed-by tags from v2.
> - Link to v2: https://lore.kernel.org/all/20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com/
>
> Changes in v2:
> - Addressed v1 review feedback:
>    - Reworked soc: qcom: geni-se commit message; dropped the Fixes: tag.
>    - Reworded dt-bindings commit messages to the "Document X for the
>      Qualcomm Kuno SoC" one-liner form.
>    - Canonicalized copyright headers on interconnect binding / driver /
>      NoC ID header to the single-line Qualcomm Technologies form.
>    - Dropped unused <linux/mod_devicetable.h> from the interconnect
>      driver.
>    - Fixed MODULE_DESCRIPTION casing "KUNO" -> "Kuno" in the interconnect
>      driver.
>    - Extended interconnect binding to optionally allow up to four QoS AHB
>      clocks (matches sdx75/glymur shape).
>    - Cleaned up brace/space style in gcc-kuno.c to match peer clock
>      drivers.
>    - Reworked initial DTS: moved idle-states / domain-idle-states inside
>      cpus{}, wrapped fixed clocks in a clocks{} container with peer node
>      names (xo-board, sleep-clk), dropped the pcie_pipe_clk fixed-clock
>      stub (the GCC 4th clock now uses <0> in DTS to match the sdx75
>      idiom; the YAML example uses a named placeholder), dropped the
>      RPMHPD_CX power-domain reference on GCC (Kuno GCC has no GDSCs /
>      no corner votes / no pm_runtime, so the reference was inert), and
>      added a bootloader hand-off comment on the memory node.
>    - Collected Acked-by / Reviewed-by tags from v1.
> - Link to v1: https://lore.kernel.org/all/20260809-kuno-soc-support-v1-0-5e0ede4a0c72@oss.qualcomm.com/
>
> ---
> Hardeep Sharma (15):
>        soc: qcom: geni-se: allow selection on 32-bit ARM Qualcomm SoCs
>        dt-bindings: power: rpmpd: Document Kuno RPMh power domains
>        pmdomain: qcom: rpmhpd: Add power domains for Kuno
>        dt-bindings: clock: qcom,rpmhcc: Add Kuno RPMh clock controller
>        clk: qcom: clk-rpmh: Add support for Kuno RPMh clocks
>        dt-bindings: interconnect: Add Qualcomm Kuno NoC
>        interconnect: qcom: Add Kuno interconnect provider driver
>        dt-bindings: pinctrl: qcom: Add Kuno TLMM
>        pinctrl: qcom: Add Kuno pinctrl driver
>        dt-bindings: clock: qcom: Add Kuno Global Clock Controller
>        clk: qcom: Add Global Clock Controller driver for Kuno
>        dt-bindings: interrupt-controller: qcom,pdc: Add Kuno compatible string
>        dt-bindings: firmware: qcom,scm: Document SCM on Kuno SoC
>        dt-bindings: arm: qcom: Document Kuno IDP board
>        ARM: dts: qcom: Add initial device tree for Kuno SoC
>
>   .../devicetree/bindings/arm/qcom-soc.yaml          |    4 +-
>   Documentation/devicetree/bindings/arm/qcom.yaml    |    5 +
>   .../devicetree/bindings/clock/qcom,kuno-gcc.yaml   |   52 +
>   .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
>   .../devicetree/bindings/firmware/qcom,scm.yaml     |    1 +
>   .../bindings/interconnect/qcom,kuno-rpmh.yaml      |  118 ++
>   .../bindings/interrupt-controller/qcom,pdc.yaml    |    1 +
>   .../bindings/pinctrl/qcom,kuno-tlmm.yaml           |  110 ++
>   .../devicetree/bindings/power/qcom,rpmpd.yaml      |    1 +
>   arch/arm/boot/dts/qcom/Makefile                    |    1 +
>   arch/arm/boot/dts/qcom/qcom-kuno-idp.dts           |   25 +
>   arch/arm/boot/dts/qcom/qcom-kuno.dtsi              |  423 ++++++
>   drivers/clk/qcom/Kconfig                           |   11 +
>   drivers/clk/qcom/Makefile                          |    1 +
>   drivers/clk/qcom/clk-rpmh.c                        |   15 +
>   drivers/clk/qcom/gcc-kuno.c                        | 1483 ++++++++++++++++++++
>   drivers/interconnect/qcom/Kconfig                  |   13 +
>   drivers/interconnect/qcom/Makefile                 |    2 +
>   drivers/interconnect/qcom/kuno.c                   |  988 +++++++++++++
>   drivers/pinctrl/qcom/Kconfig.msm                   |   11 +
>   drivers/pinctrl/qcom/Makefile                      |    1 +
>   drivers/pinctrl/qcom/pinctrl-kuno.c                |  801 +++++++++++
>   drivers/pmdomain/qcom/rpmhpd.c                     |   16 +
>   drivers/soc/qcom/Kconfig                           |    1 -
>   include/dt-bindings/clock/qcom,kuno-gcc.h          |  100 ++
>   include/dt-bindings/interconnect/qcom,kuno.h       |   89 ++
>   26 files changed, 4271 insertions(+), 3 deletions(-)
> ---
> base-commit: f82a5da2f04960df9fb57489992d03dd5e64ec6f
> change-id: 20260809-kuno-soc-support-1dab826de0bf
>
> Best regards,
> --
> Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>

Hello All,

Several patches from the series have already been picked up and applied 
through their respective subsystem trees.

The remaining patches listed below are ready to be picked up as well:

     [PATCH v5 06/15] dt-bindings: interconnect: Add Qualcomm Kuno NoC
     [PATCH v5 07/15] interconnect: qcom: Add Kuno interconnect provider 
driver
     [PATCH v5 12/15] dt-bindings: interrupt-controller: qcom,pdc: Add 
Kuno compatible string
     [PATCH v5 14/15] dt-bindings: arm: qcom: Document Kuno IDP board

Since the majority of the series has already been merged, I would 
appreciate it if the remaining patches could also be considered for 
inclusion.

Please let me know if there are any outstanding concerns or additional 
changes required from my side.

Thank you for your time and review.

Best Wishes,
Hardeep Sharma
