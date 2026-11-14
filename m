Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794652480;
	b=hmeevmApOJyYLMxICVBVoDtxBvtYTnvSRmyJ3PGKWnDixqFjfNb61DZTaWVqxPa2PxfK
	 HZ2NuLj4t/SXmq7Y/9IlDLrZqOGahKhGKV7MW+KC/jWG+MW0+vlX0lwg5zuAwUpRXNv24
	 MF6P5AhUF8pl+XZXzGS2dxI1Ddk29ugdPydPSluSiLk2HkTuwb//H6lQ/ZD6uMASee6W/
	 7QGWO3oH4buegxPYRqGhcISncd6mFfvWiWlziDn2/eWft6AaJnmdzX62G2WbNRnXKqN0k
	 0fUhus2n7Tb925j6I4KJwVjN/gQ51UXifC4qKGHCHxKuUqv1qq/VPCpajdIaDfn/dtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794652480;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Dh7Colfd+Fpplt6I89BdRicnbNHfXKnIWNbhbS/Qr68=;
	b=vwOY9vBA/ffJNwmHTe1db0y2pBDqUGdl+Vu1SvOL/pL0rrUqjyJaEbL0Judk0EP4Mxvm
	 +p/f2cza1yqN0ZA8qNj7pb0pk8PUkgxNum1jzzqxWFkT77XU7CYGriI4Vc3KT/zOrwO2/
	 iXRP10EuPgnUEtjnkUpFxTXFTWkAlAXWosYr7ilnU11/Nej2TSEvrAF01PoAPBTq/AHoT
	 xJJ8BV5x0HfJt04wuGo0scB88CegJmva8iyXHMSzTcLatPsC3Npuo818VbfeaKE9dKfYG
	 TU5FZD73UAhogRtN5wdhp8CyC2i7yzxCtGb/CRDfAHOWuGXmj6AEsZByaIn363vpa+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gxYcyGch;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="E3+SG/RJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2C606A329
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 10:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CD2C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gxYcyGch;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E3+SG/RJ
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9xKgw175996
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 10:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dh7Colfd+Fpplt6I89BdRicnbNHfXKnIWNbhbS/Qr68=; b=gxYcyGch9+cPb4FH
	n98Ykn7pArnMkE2S4TViKEWtLROj0U6F+5LSs2MypMrJ9piRF6B+uyk9zXP5jDmW
	xotKFL9aJnmtl7IH/urvnpgIsSzbraNwclKh5Z7YlRdTcVdgOfLx/n1Qw9KD/AIj
	ppqANTaaq3U66TUbjDncG51BXDnjOsNfj4TMJoE8ep6l/46nqH2sYjtQyf8eg3VR
	0ns1BP+RrdUeGXjY8Sq3h8RR6pIyLDl7RcBwMM1feabPnWfhA2hXMnzdoaRDljFM
	xB3Ivpy9eD4KqFJ6pfjjlWa/5uuwotNXgxw87TU5+tE8CI6yQrrMcJUd4Ev16GNH
	hJukdQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmagggx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 10:34:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b08364cdc7so1358369a91.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 02:34:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794652478; cv=none;
        d=google.com; s=arc-20260327;
        b=fRRWUe/TFvsd4dsE6me9eE0EVpVLFH9D7Zb0R2xLdyPj9MgEDjR/dIF7JzgKKDynTW
         B9lakcXF1eoSrSKU40sd+Fg30RMWjcXCO9eRbiQOs02B0RUb1OR+8/r5JEpAXEQF2GNo
         RG95NmMAu2uIz+Nj3/T/eZSuVXeGtdvMBG74S6oj+NGCQdhtJaqky/vA2zR/bM4lx+cu
         DEKSIiNiEI1xFiCfdl2A1e+oWNc7B1cXpCEp1Wd8u37cL0Ec5N+9WlzXP2OCBHaWpvPN
         nd+rnD8OXvZORhQ4Zws/QzqlTbVP5Omuvl0UhKJV9dEXRa6pW89Lkm0yA0Onmbk+lwVE
         yLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dh7Colfd+Fpplt6I89BdRicnbNHfXKnIWNbhbS/Qr68=;
        fh=fm86ffncAxrZ5nr5gYMoo+wAd5Q3kMAkMVhaCp/nIOc=;
        b=VB0tTkDkqa73XDORGp/yLmyJDfh1K2cQiN+2n+HZqh4V8cZ6uRlZ860wLiOz7w40Gr
         2ONi0518CL7vxv9SX8fNB7FhukKOYEniM/aWjCZZRRpHUoy7tAqGEEdKRn6SHBlxl3Ug
         rPqjeX5nqdlN2SXOAcGCJlrKPjx14oDqhCoTL719ueg3ybBzazYRqgm6qZyxcdLtYOTV
         XD/v0TXyiBkaOvtFed1SfFAuu5eCWECTWCwom3melIN30KGxRnsirPnH+bDpeHofgKJH
         WgcxxO94u1g84VpZX2l5qxZvzPLf5fToY8/8UXyYRK1s+55NKr8lferDmXxjsjnlrpQ7
         7J5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794652478; x=1795257278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dh7Colfd+Fpplt6I89BdRicnbNHfXKnIWNbhbS/Qr68=;
        b=E3+SG/RJ2JxmlzOHIO12KV2I/S6Ei/aMtTZaHQLrKIBfLF4IJNhHoiRiJVKgcVUxD6
         CHw3OtXcIBFAkT7V4cZ/L7L6//1MyjhstIqWaN0hr+riCXY5OFIjuQ6fFZsGRQCHetg8
         9/CEPH1uiyeSzWqp/6WhBboivlLJG3/LMmnxtzrQ6Kxr9rWU2NEl2mqjLB44Md85OMKV
         HGK8D1Dpp5qT5OVY/wuoAQYdJLyGmJABOp8f3s6EWrTqB7NTEJc1iqhLqRJCEVSgD9AW
         nUbD4MgAB31VM0FL7b6bi+F+pXXuA0/TG1stGLMxsy1nD55CNYVtpUFJ4v54N50lA1g1
         CyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794652478; x=1795257278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dh7Colfd+Fpplt6I89BdRicnbNHfXKnIWNbhbS/Qr68=;
        b=ygIyEiK9CTO76/cQWl2PAhgLOMFC7wk4Y946z8/zrK3rGweMbPCDRm23NSZ+ITtDFu
         wQIB3pnyxCRtH9U1igWPJodIPG02Z6vbKa5Kls1T7Sze3D/pNH3pmXmY/VmdX6Eryfbb
         PtaS5p12s08kZv3EcPAcj6IGYahWeyhg4zFxbBpdYsaDUnmI93a/ai1Pn/rxr+HL7fAy
         qfjAZfG8U0ZwZBNY9PyN2BEmjHtNwPXEkfey96iYtwz9K2HpKY4GxSeEigwfMLBuRRtR
         YuryJsJQjgP/fWLu1Rum6BDRVLUOwj/SSPw3AjzMBdaXTtgwt/cpQ/T8DRp2NsjHu1nU
         gnzA==
X-Forwarded-Encrypted: i=1; AL+hErE2Bzu+Ht9d7cFt5XUuc1OLaMi2cKJhz3BFN/oPttRH+1zGKvQ0V8xIPpdcx1OM6TiotQyQP5dMyg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9uQu2MlfURhfSf74kzrPlEo1roYa+8gOuW/gQ2DHNdwK5hxiMq
	k1UIvx7r9ISx87+7lXd1udvwnFgiixoxnWheAA2VtAq00xXp1/vgzRlXEU+siJ1+0VmkL0nv3IG
	h7AykMkWnZunJLB4efoSZlqpdiUJoV1aND7aZuxbPWf1GE71JjZsFDQtq61oRlgLpiClMDUaPMg
	/KaCxIwSpe8ko8miI5RhrJf3kwdlRSOlcsXzXr
X-Gm-Gg: AYBFou3GDM/HiDG6fsvP6mLo1vEfroe5j5KgaKMkRg438Qs2Rhe7wEBUeygBlDWhN+p
	gsxspaNUnZtlOL6t0vOau48pOwb9Aiy80tksBLqJw4+iNSRM+cdrQ/lkciIQvufiGiPUsWUWfZa
	G+toSDUMBq+vHWVddcWk2dp/wkInpLA7PL25/D6DC2PJxJu8wSbfIUjp515A==
X-Received: by 2002:a17:90b:3ec4:b0:3a0:4668:4cb0 with SMTP id 98e67ed59e1d1-3b1b0b83494mr5437876a91.47.1794652477770;
        Sat, 14 Nov 2026 02:34:37 -0800 (PST)
X-Received: by 2002:a17:90b:3ec4:b0:3a0:4668:4cb0 with SMTP id
 98e67ed59e1d1-3b1b0b83494mr5437854a91.47.1794652477282; Sat, 14 Nov 2026
 02:34:37 -0800 (PST)
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
In-Reply-To: <20261104135604.907283-1-patrick.delaunay@foss.st.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 11:34:25 +0100
X-Gm-Features: AclHuK94u1eOHPpWE8nBMTRpf4tqar4SIHPxdb5PqkdOcIBUQwLxrM5M47Vzypo
Message-ID: <CAPx+jO8ByMju7HofLyZywRQRW4W7_15LoRVDn4K5oM+vsmrSrg@mail.gmail.com>
Subject: Re: [PATCH 0/7] arm64: dts: st: add STM32MP2 power domains
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Linux STM32 <linux-stm32@st-md-mailman.stormreply.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: AUELJ_BLy89XLLaYeCEd0KVtAqKsNnCV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0MSBTYWx0ZWRfXzQcEH6TYsOyb
 ooCPDboCsz8T69Htuu/JaAGPgUyc6WynuAJB7P5NSwFYzkTpglTSUD6IGOgFbLhatIb5wolzKKe
 vJzTGk9rBBbBByh7r0iV+/kpNHALdRxHALHKvBFxEnRm2IJjlFdoLpNWBUhiZIzn/twBTQxAWXN
 TTAcRDCrQ7n48JdIF59AJIQs4XS8adE/yON/cU5s8ErWlBzqIiyB7NxPyTwJ3roMUzz/cb8Z6OL
 jNwFzn2l8G/9jUgnmAnQfUdDp5D2VtQXTbe6d+C0sq/XVXTOw0V6oKrlelwmFwqLFZ1D+TxtIzN
 YxNaNSMEry0vy467tJcoD9qcAk38RwcaDA5F5LNErSKphNPd4Yz75NLhBOdPF9SW3zfCUh4CSwg
 cLlxFDL3TWsfdDUaGRgLc1OOJzDKuWsk8VVu8wtdENqChts8QgCRuiSDGuXoqtuMwXx5eQo7bpb
 w5RbT88rP2dLQWVLOIQ==
X-Authority-Analysis: v=2.4 cv=NdhzRGD4 c=1 sm=1 tr=0 ts=6af8393e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=8b9GpE9nAAAA:8 a=UgPYzwtURW4JLmgtzPsA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: AUELJ_BLy89XLLaYeCEd0KVtAqKsNnCV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0MSBTYWx0ZWRfX5BzqWytWaiKU
 WOs3pLeO+BTMtjW33ulQemfLRtTGMugR7IcYqvao8cAS/Kk/kG+xjhp+she+ZkyFNjJ0b7mUzvS
 DhfJLVQcdAhvXGMciTnfRXwCajsC/xE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140041

On Wed, Nov 4, 2026 at 3:02=E2=80=AFPM Patrick Delaunay
<patrick.delaunay@foss.st.com> wrote:
>
>
> Hello,
>
> This series adds support for the D1 power domain used by the STM32MP2
> families.
>
> The new power-domain driver uses runtime PM and the clock framework to
> keep the Cortex-A35 cluster in Run1 for devices that require it, while
> S2Idle wake-up is handled through EXTI1 and retention PSCI power domain
> (RET_PD).
>
> The power sub-domain D1 without GENPD_FLAG_ACTIVE_WAKEUP is required
> because PSCI domains manage the wake-up path since the commit
> bfd5859709ee ("cpuidle: psci: Activate GENPD_FLAG_ACTIVE_WAKEUP with
> OSI").
>
> This patch is a preliminary step to support PSCI OSI in STM32MP2
> platform and the same power domain will be used also in STM32MP1
> series.
>
> The first 3 patches introduce the new power domain drivers.
>
> The next patches add this power domain in device tree for each STM32MP2
> SoCs: STM32MP25, STM32MP23 and STM32MP21.
>
> Regards,
> Patrick
>
>
> Patrick Delaunay (7):
>   dt-bindings: power: st: add STM32MP PM domain binding
>   pmdomain: st: add STM32MP power domain
>   MAINTAINERS: add entry for ST STM32 power domain driver
>   arm64: dts: st: add D1 domain for STM32MP25 family
>   arm64: dts: st: fix power-domain labels DT coding style in STM32MP25
>   arm64: dts: st: add D1 domain for STM32MP23 family
>   arm64: dts: st: add power domains for STM32MP21 family
>
>  .../bindings/power/st,stm32mp-pm-domain.yaml  |  46 +++++++
>  MAINTAINERS                                   |   7 +
>  arch/arm64/boot/dts/st/stm32mp211.dtsi        |  37 +++++
>  arch/arm64/boot/dts/st/stm32mp231.dtsi        |  54 +++++---
>  arch/arm64/boot/dts/st/stm32mp233.dtsi        |   1 +
>  arch/arm64/boot/dts/st/stm32mp235.dtsi        |   2 +-
>  arch/arm64/boot/dts/st/stm32mp251.dtsi        | 126 ++++++++++-------
>  arch/arm64/boot/dts/st/stm32mp253.dtsi        |   9 +-
>  arch/arm64/boot/dts/st/stm32mp255.dtsi        |   2 +-
>  drivers/pmdomain/st/Kconfig                   |  14 ++
>  drivers/pmdomain/st/Makefile                  |   1 +
>  drivers/pmdomain/st/stm32mp-pm-domain.c       | 128 ++++++++++++++++++
>  12 files changed, 353 insertions(+), 74 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/st,stm32mp-pm=
-domain.yaml
>  create mode 100644 drivers/pmdomain/st/stm32mp-pm-domain.c
>
> ---
> base-commit: 7b3f3e772d5107c3a59b9f2278e9aeab227b26db
> branch: master
>
> --
> 2.43.0
>

Please re-submit this so all patches are sent to me and linx-pm,
including the dt patches.

Kind regards
Uffe
