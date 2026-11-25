Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795610158;
	b=2hwQZyLwn6ARnHWo+j7+ELOkIG4hQlA3LGmRvmb5Q3G1FO5II6wjud7NmvvYp8fn/Yq9
	 2GGwWS4xoYEhvbFxhAeYMM9iHYM1DcAESgMeD6jQrvINtWsYqMa9alcyGg03UFX08DvHP
	 k1HdMbPgToS0P+vsBkzwii3IPbEsPg+uNCWGNg3woeqgJMqnSRdV6g47Qwq5dsjktko/b
	 O+bDIB3cT7VpLuQvxGB/W6mtdixF2DyeJYMTJZqgOHzWXF7Q2we2cSLPaXMTQZhY9m50x
	 w95AC9D5xfbwu7RL2EtYzL04rIYRHywskFXH+VQRzD3YR1EYLUrx7k2OewqkC9KAUlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610158;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+3Wp0nakT6agArNabE9QzN5k/sUhhh9EJvtHBgL7nNM=;
	b=tAhkJQ7lT+uTzAN2Ul1rm7f8P3aYAfki0GyQZBdW0JyHyLfhm9WsNAFmIZ5FbthEE8+1
	 i4aE4+BeS6aFlZH6pyMqp3C4sghkTw+825+DmTqg0iAl0yEHNL3+m4hmf0guK3wyoGEWB
	 /y+nMolVsJGYk67ZonaFu8kRzTW/flQzxJy9Ax3mQOhIZcsQawGygaYVQ7zYRPYU++ncq
	 qBVsVqSPJsK6xGMMACGPemc9BEPjOCqmoT0GDnvM2XfOfGPT4+BKGe8iAJ6ZSy4NRVOEr
	 eKRA5ETctoxxi2CUa1atoozKJoMCqZZ6LbGIZOaj8kXnWqKOy/x06DV8oXvUjOVa88g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LagV5qZU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HzG5QPhC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE2606A327
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82FE2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LagV5qZU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HzG5QPhC
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mNMx555519
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+3Wp0nakT6agArNabE9QzN5k/sUhhh9EJvtHBgL7nNM=; b=LagV5qZUOt2uWP6h
	u81683iqi1UCjTeQxGnUvJ2fBiBtCRMEs3p56yQZvkBc3ZioolvXxbqZ36uXp+wF
	zGbUwFlNFlUYXCtONQs7HCeWVQTs8Xv4pPajs5B9pkloApMnkfUjAySC0Up0pEFn
	AcK/hPz1BoWbDEqBGlHMN4SB+2zjAmGnrnxuEWTLEhim9I6I38LC4q7im90ApWq8
	AyBXxZuLi7BfE/5rKlJDkEj510kmldyFZHE28RP1a3Dhln5p1LD1JYR7HsAnvZhs
	OqW2W1TpNhM+fS11eVw5AEeG9AMgClfvwBF9W29/KZpHJFBC+KIKMpVcNxdvJi3H
	CzxowA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vvnrt6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 12:35:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b3fd219d07so4596348a91.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 04:35:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795610154; cv=none;
        d=google.com; s=arc-20260327;
        b=NYjY8AdYprz5e2Tqo5Txa4PB9dQxTOhz7MdFBIEL0M/BJcoZfTUrb3Jkm0URrK0Xue
         x2brLVM1XWKzKostl1i2fxZmNXQWVEICknkdBxXhMXE5bhzVU9xUiAcfZskqrmmG+Cxh
         bFyFLa6ZKPsQ5CUPDKSG723IGxd00kKuNp34UiwjBFP6AO9jUPReVmmH+AbjAdzZI+1A
         g/fRVkbcxoX2UZ+ZctryjLZPAPK0vpBPaP8zxHNuSoUzqVB1F9IdU03kkEATlGR6peDZ
         cfSmyK8ys7EpHkY4sub5JdZnsOtZvRn1oQSDVy8Z7Q1O5Dm5Hha4zzKMPtSCCDB2fLla
         x1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+3Wp0nakT6agArNabE9QzN5k/sUhhh9EJvtHBgL7nNM=;
        fh=PY6kMT89QkOTKMOryT8XC4pHvGF/3XW2mwgMgXzH6pA=;
        b=ZGQs3viaurpgN02ztENBNTsL3nG5AWKRLe/xEZv3SpU0OVet8wy2R7+woSQVWUv8g+
         Ud96a5ztK/QznZDrmctfcPABPvB2uioNgpIqYTXkHjCp/Cl5xmoHhJG5ynEobASxivmS
         hjTmGtPxxgYhyIdwiAHlE7Cs5RIdiQQUI5alGKRhoCmLasddnH31UKY9adzinz8RfwFP
         FbPMKGOcFIZ1+E5dLYfUV6/Y2yP0PKyRbHjPUYSmVz2l7izenh4j8yov9r3c/p/MVMFQ
         jZygBMebcEpLyzfcPRYVk7VLSOgE7QfaQ82KbVGJqhynUugWb/LxQYzooSTMDqpoayCv
         /MKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795610154; x=1796214954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+3Wp0nakT6agArNabE9QzN5k/sUhhh9EJvtHBgL7nNM=;
        b=HzG5QPhCt1Uh6qJOHwOrpu+F8mxlOOvrIQzSU456yhyUVSvqETieYysI5unaSIbsYp
         UbRRi2IEC9jQEF05HAqsUBOA/csjD7drHvDuPAiVWZi6QwwDCiuGgt+PYGfKLp80yd0o
         eI0fLRuW7vBYPH0F+9/pYPKdSzA/fE9bSWZk3d977r9fgUi0rRImEzok14APxG/xdc4q
         q4ah2jwloAD1AXuM0l2AEBvrBMswherXPwjBwgZSZBDS+tNTfc90AwEbZvipLaiFet1k
         BWXCkKqMhbVdA7Lv/BNYpz5SVqQZ9Q++UWXBrx6DEUsPuLmSJB5mw5Tda1VyHsbmuOEm
         KGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610154; x=1796214954;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3Wp0nakT6agArNabE9QzN5k/sUhhh9EJvtHBgL7nNM=;
        b=kDLAQDD4Sm5cuVfDw1d2sgn+md9oJW7sqTyIqgIQYA+kcg7FH1GI35585xv1b4DbjA
         1E+yprOc8Qyu/6s/ee7+9ShJ+G+6dRl5VPdo+vdTS2mtQLH3Xb5e38TiEDoW65zHsE/p
         Xve9g8H24Dm2e3FpvygR2VsI8ecGAiZwPw57dqz2EdCDDgLMdai8XJ0ClK0vCxmcp9CN
         9BCFLweIS1iAPb2eeu7AWlAehSqsubEnZA/PmOR96IaatS5ukDJa/+CcPtGYEzWvCDZj
         yyBpi6/4ZT3hukwJjOmHuvEWVFudy0cP94hEzWSZpZjKxnE9rr6hYJCzGQbhuAfOvmsa
         v1+A==
X-Forwarded-Encrypted: i=1; AL+hErF5NL0D/BbpNBOVFWUzWKHIeS381jSoC+SfL/bpf2Ux00WsNEMe1nKXcxXhCuS8eISjUCRoglr9nA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8SwAcj97BwaEOrlNt9KIW11d6JtvDSRSmpapgj+VEJTrgkKVEQ
	T5niuKrYY3s2XdXxcGlrpkW6XIElF2G+ZUiQtvo2eSx0WMSfxjF14bIORtSvI7HI2FzVMTsVWO7
	5s9dRgSnnsuhJ1ZgijugpGtCErgeroRLCVMFTTL0qIWDmbapJ67IPVlj1izdZKXcJSXQ1xSBaHW
	LWi+uyYNuRi2Vz4OxWxadXkfjs4XqaM2hB3xGh
X-Gm-Gg: AZFdTZcetyDjD1IEqK8snu9CpU2flzc3juTN6fZVatGimcWQ0Hn4uq5sfG2nIKZtRHu
	Qafg1txeW5Kl3zlG/ecFihG56TTdGuAfHyM1kEyHaB60z6XyVbAkdLZSLpp1jXn6hPI4yv4m11C
	vwRu3/kDIjUtSiwunydwXDMEaQq+d1Wf24zVsqVB1Hk+deuzJmRpteisQb9Q==
X-Received: by 2002:a17:90b:2cce:b0:3a4:967c:6947 with SMTP id 98e67ed59e1d1-3b41c909001mr16588213a91.21.1795610154196;
        Wed, 25 Nov 2026 04:35:54 -0800 (PST)
X-Received: by 2002:a17:90b:2cce:b0:3a4:967c:6947 with SMTP id
 98e67ed59e1d1-3b41c909001mr16588198a91.21.1795610153699; Wed, 25 Nov 2026
 04:35:53 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104135604.907283-1-patrick.delaunay@foss.st.com>
 <20261104145502.2.I59b2ea87f07947037b772c49c277092c887f4310@changeid>
 <CAPx+jO8_gCHgkeTB4aQDRjs1xwvXCB=zFjFBHB_UwqeOWSUEZQ@mail.gmail.com> <cc9c816f-eebe-4f29-a8b1-32c967c27722@foss.st.com>
In-Reply-To: <cc9c816f-eebe-4f29-a8b1-32c967c27722@foss.st.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 13:35:42 +0100
X-Gm-Features: Aa3M54ofjiIlywJjaTlNlnZrdM2sYCijlbq0js0DVsDfwYEcKAT0z4AyXuoBXvk
Message-ID: <CAPx+jO8d58tCoEL52baYMzjJ9VzyfpVNhruKAhrHrnEwuOoJig@mail.gmail.com>
Subject: Re: [PATCH 2/7] pmdomain: st: add STM32MP power domain
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>, Ulf Hansson <ulfh@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linux STM32 <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0OSBTYWx0ZWRfX6QAgqKAnxdvV
 55OpvNs0Lgbfpvp+2uxzYmI7KnMnmyyv7dk7EmwNos0Q331/9lP3bI4MnZH+fVles2rLB8BomIp
 /e4Ff2kqsf6GVT21aWHaUc0idO8CJ1FTOutjXkEbiOxLYhxYGPzKkOaUCH9zaAB5sTSD91jVIfH
 C+LHOK4pqnS7INMIa3pZhNTY8J0ttOJDWhzI1PBsvG5+QawLRQax0t7cc8jkLGoQIYgIu0H+PFY
 q6qZMO3qc5K3tPBeKpLhNTzLvoLELfMiDajpLODkNlAbv/9RPw4aujXkQigCQ2SxTLc71mz0czm
 /Q4NMHRJMk7ypRxzbOs0nd7J0C67cvnEQVZRM8gOXa5UNfFVkM7l5Zq8r90fwpwHG8s4cSo3rc6
 YkiskvKDNDdUrqb1b5EzvILk4YseRs/GaWSljwUWYFcSVX1RGRgFC+uRClp60yO7g/xcXqpFr0Z
 hiVfn73/kWed7JewzJA==
X-Proofpoint-ORIG-GUID: Hrx-tewRCzKRvGTDniQniuyL-Ip9-mm5
X-Proofpoint-GUID: Hrx-tewRCzKRvGTDniQniuyL-Ip9-mm5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0OSBTYWx0ZWRfX/7qh/Xx+VnAk
 RuIF7gxFnELSuULDoj7I/fCmSsT63RLx55KaAVEroQDPgw0G6CL6ZgExNvEM8/eEYezXRzX5BuU
 29jvYMMUhrm2WXP+kkZSud24iG5GENA=
X-Authority-Analysis: v=2.4 cv=R4mWitRX c=1 sm=1 tr=0 ts=6b06d62c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=8b9GpE9nAAAA:8 a=rfZIK_W7AAAA:20 a=NEAV23lmAAAA:8
 a=YQXNl9ZGkXhj2O3QN9AA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=T3LWEMljR5ZiDmsYVIUa:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250049

On Mon, Nov 16, 2026 at 4:11=E2=80=AFPM Patrick DELAUNAY
<patrick.delaunay@foss.st.com> wrote:
>
> Hi,
>
> On 11/14/26 11:40, Ulf Hansson wrote:
> > On Wed, Nov 4, 2026 at 3:02=E2=80=AFPM Patrick Delaunay
> > <patrick.delaunay@foss.st.com> wrote:
> >> Add a generic PM domain for the STM32MP D1 domain, using the PM
> >> framework to manage attached devices.
> >>
> >> Make D1 a subdomain of the PSCI cluster domain, so active devices keep
> >> the Cortex-A35 cluster in Run1. Do not set GENPD_FLAG_ACTIVE_WAKEUP on
> >> D1: system wakeups are handled by EXTI1 through the RET_PD PSCI domain=
.
> > Would you mind elaborating on the system wakeups a bit more?
> >
> > The devices that get attached to the D1 PM domain do they have another
> > PM domain as well, to support the system wakeups?
>
>
> Each device in D1 domain use
>
> - D1 domain to allow any low power mode  (Stop1) when they are suspended
>
> - EXTI1 interruption to manage wake-up patch
>
> For example for UART:
>
>              usart2: serial@400e0000 {
>                  compatible =3D "st,stm32h7-uart";
>                  reg =3D <0x400e0000 0x400>;
> -                interrupts =3D <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
> +                interrupts-extended =3D <&exti1 27 IRQ_TYPE_LEVEL_HIGH>;
> ...
>                  power-domains =3D <&d1_pd>;
> +                wakeup-source;
>
>                  status =3D "disabled";
>              };
>
>
> Then the system wake up for S2Idle  is managed by EXTI1 device wake-up st=
ate
>
>   when interruptions are activated.
>
>
> Moreover LPLV-Stop1 is not allowed when EXTI is "active" for OSI, i.e
> when at least
>
>   one interruption of Group2 activated.
>
>
> To explain deeper, when  OSI is fully activated  [1], i.e with full
> upstream for STM32MP25
>
>
> - the PSCI power domain Cluster Domain allows "Stop1" and "LP-Stop1" low
> power mode as CpuIdle mode
>
>     - D1 is part of Cluster =3D> the device is D1 domain allow low power
> mode when they are suspended
>
>                                            =3D> active Wake-Up for device
> in D1 domain device is compatible with Stop1/LP-Stop1
>                                                  the wake-up path is NOT
> propagated to parent domain
>
>
> - the PSCI Retention Domain allows "LPLV-Stop1"
>
>      EXTI is part of this domain (not yet upstreamed) [2] :
>
>
>          exti1: interrupt-controller@44220000 {
>              compatible =3D "st,stm32mp1-exti";
>              interrupt-controller;
>              #interrupt-cells =3D <2>;
> +            power-domains =3D <&ret_pd>;
>              ....
>
>          }
>
> the Group2 wake up sources are handled by EXTI1 and but they are not
> functional when the LPLV mode is performed.
>
> We handled this restriction by EXTI patches no yet upstreamed [3]
>
>      - activating the wake-up path in EXTI1 device when at least one
> interruption of group2 is activated  for S2DIle mode
>
>      - with EXTI1 pm_runtime state for OSI mode
>
>
> So the "ret_pd" domain can't be deactivated when EXTI1 interrupts are
> activated for runtime (OSI) or
>
> part of the wake-up patch for S2IDLE
>
>
> [1]
> https://wiki.st.com/stm32mpu/wiki/Power_overview#STM32MP2_series_power_do=
mains
>
>
> [2]
> https://github.com/STMicroelectronics/linux/blob/v6.18-stm32mp/arch/arm64=
/boot/dts/st/stm32mp251.dtsi
>
>   https://github.com/STMicroelectronics/linux/commit/d216f8439d14e0a11475=
495cf5445e05cc4a9da9
>
>
> [3]
> https://github.com/STMicroelectronics/linux/blob/v6.18-stm32mp/drivers/ir=
qchip/irq-stm32mp-exti.c
>
> irqchip: stm32mp-exti: Add support of pm runtime
>
> https://github.com/STMicroelectronics/linux/commit/4a4a20f5c5aae461a7a14c=
98efeddbc9cd08c672
>
>       irqchip: stm32mp-exti: Add support of wake-up path for S2Idle
>
>   https://github.com/STMicroelectronics/linux/commit/1d3b854e7b95318b67af=
d2dc16b8ff5fc060443a
>
>
> >
> > Just trying to make sure this gets modeled correctly.
>
>
> I hope that follow the genPD model...
>
> and if it is the case , do you need update in the commit message to
> clarify it ?

Okay, thanks for sharing and elaborating. Even if it's not entirely
straightforward to me, it looks fine to me, to model the HW like this.
Although, in the end you need to convince DT maintainers to accept the
updated bindings.

However, there is a fallback option as well. I think it should be
possible to drop the D1 PM domain altogether and instead hook up
"usart2" (and similar devices) directly to the cluster PM domain. To
allow deeper states for the cluster PM domain even if there is a
system wakeup configured for the usart2 device, the corresponding
driver can call device_set_out_band_wakeup(). This informs genpd that
it's perfectly fine to do a power off during system suspend, see also
genpd_finish_suspend().

[...]

Kind regards
Uffe
