Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795791588;
	b=OjO5uyz93SnZp54/BhjplVmqvkBSE1o4vuzuiVDJK0jgJvL0JrtMCJBOhtYfdkP6ZaZ2
	 cAFZlja60ZUM0xtN6eqbEGy7qcii/iuGur4aHH/OiIh4dIlnmU+zLlD8IwuHXCmCFEOKN
	 ra92r/YGJD5S139Ef4ZcR01+nxNZNHgrU/o/AUJgo7ZtgW34BwQzOGmMgMQjBxcBLdgHf
	 6SQ5a8JoDoAvD8/h7Kx3v3nh0D6skWZnHImNKeSCu8EvsMXo2ioKyYemI3YQH/XevYwCw
	 rGWN5ZhX9zrcckWbBhOst7rXTE0xg1cQnXTYHY0hgHxlI/ic7KmCeLlplrvl+cf1WaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791588;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=QRXaT7m33FfxGbFmgr3v0S/RlKQdbib0fZkTMdO5Vqo=;
	b=sK0fuPqr7c53dpIS/yWVHvTJG6pNb8R5sg+DJhHRFiSHrxNJL9SwjkB2NAtLmTRIklpj
	 g2Kw4FTf3R4smMKLhvDwlQl7CQQ/Kok/4PZxYNeqwJzuh4IheZhNZ+TMKI+6QDdXX8CPO
	 zeTCeperrhIffcjEBS4a+vLxEBJag8ofs76MVxbCw1G35kJbphhssQNUB+a4GD+uKj36p
	 62W5ebeCB/r2Y5bPvBLbLb+P/kQ+yGQh36mUIRoLDMRQRDvk8RBm8wBBQueTosUF7zFAW
	 o5sgT78QhmfP+IMHd2ejZSDOSPpJ6rpB4eoF/4CnyAKT2Z6zj9clYiXP68fiNyvN1YA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VxWSobvw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UxddjEa5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB39606A321
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFB39606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VxWSobvw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UxddjEa5
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1cDY1971428
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QRXaT7m33FfxGbFmgr3v0S/R
	lKQdbib0fZkTMdO5Vqo=; b=VxWSobvwbr9r3+aw63q5pAStU6sdeAmRgkcLZe6u
	mEj7o5+sWw0ncbbTC2bruORIS2h/QGsNmJOANfQD5fCr4HxCXRKJjxjAMNBxBifI
	vgMlyt/6LyMIMHk85o1uFkalIEG/7S9TGp+hTiHq227fgTEiYdAlhF5noKOQQsTv
	MpsfOpHpy1pzNvHUx4o+69gWdArpu6tuLwhC2cyK1+g4bZBGiU652Lj3lIBxUPpL
	fgJjZt7iDXLsylKCrHU1HrhBZIgzMpauaJvUdixi0oqIhr65mLfoc/BCRZlsaIhg
	ULw97GEHUMqKsiwbo9XCh69JPBHu0Eoe9z4WQl8mVJzlMw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u55ufgg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:59:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3adeba76cadso5488267a91.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 06:59:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795791585; cv=none;
        d=google.com; s=arc-20260327;
        b=jl04kihwseFuSO/+kWLy2fWlGG4gQIK5f8h9UETvBfBb2s36GksPIY1veGLA581np6
         IEQfRoqY1ezOxr3y3oKQOPBHWmwxiS3YIaaHRSI7DJp4DVIgx9EWgonQsEFx1/stKo/O
         FcsyQwD5CbiJEN057t5hd2h/0dtvRAQXUCNz0fhLukXOgicbcEUE0BrjixfgfM+TL1kD
         AjVrNNnVWrU3YTAJllgQUT1Idosm+j2Q8ta6dDHpNY8f27QyjDHwrLixwch77F9ZY4bs
         Cw/GGxbq5nZvabtZ5HvG2t5OSSofKW4EhzMOzhCw1hDyvcxeSPp6sXAabwHs/gnl7o2y
         LYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QRXaT7m33FfxGbFmgr3v0S/RlKQdbib0fZkTMdO5Vqo=;
        fh=ertX0JpYeARZwW7fkOky+WwFa2ectmS4HY6gHGrUNzU=;
        b=PYeLbl638BIzjVN6bTvC0lWbw+1jqjKOTeuNuAcJxszwc5uT2cxU19c3jv+fdaB9GM
         xlPBZEVCg/g0NBP1ZHcaWjkHjn/WGPHryIhu8/SjKVtYXA559/3ySoTIlvCi6oO1lzrC
         5Q82joX7OoNesMA/2QU0L+Ii6aE446Jtm7wUetKU38uGzgp+iCmYecdPSK4P4vFZBD+h
         kVtspXZCdjDszkuHP6aMwUmFVB1tgCF5XeY0CqMu+yBeriKSj/L4FzVEc5rTyjhXBMN4
         NrMxG3lcvdyW3ycTXhqZ2cB5n/c0nppzeDeOgnEdcYfeCzzrb1TIdXu8O3UKETeDWhHg
         5JdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795791585; x=1796396385; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRXaT7m33FfxGbFmgr3v0S/RlKQdbib0fZkTMdO5Vqo=;
        b=UxddjEa5jYzNMewcNlvylBj6w9DhJI1wb/6rkjaSxtdfZJDL/rvnRJvmC9fNvHNqSW
         HYBv6mYelqGZBmMOK7o+8leY65zLd975a/zU0sizyw+FLBxTZ+2Cd45MeneKpZHruI5Q
         CdCnyVftNaFMDA5vIqFyGwyPMD+QSN49sl/L7AUKTaOnIgW3HNyYKx8q1D+VCTIxckx8
         muRpRd0BLPZ0kmVFoAyMr63Owfe25upAQWCjpnIGR8PuCBPd97g1tSNWshODaX1iRSrS
         QSVDd+hiJMkFEVsAaNvJ7+wR0WmKqBOOHANnLTXQMoM3Aoy21+jEdI2HMatw3JhI80mH
         LFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795791585; x=1796396385;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QRXaT7m33FfxGbFmgr3v0S/RlKQdbib0fZkTMdO5Vqo=;
        b=vyN0NE2R5tYL/6JlTls85K6pb5DUXNIczcVthLTql9dP5k8z89rG99YMMHRKzT0ecP
         oqMmMB+mh8cFozTz6IKAYsHMlHbHwp1Mg8DXa9dRcetEqxBNOR9GUpnpVicDq04Ud45u
         M0ZXlUOV1HttWgjhLgPZ11AOTcZOSeimfwSRQm3IQ3NDUbWxFx/Oyve1splUgbEfDe1a
         3bEt2ww4VW4+D3X6RWTG5389oewpG0dg5AC9Hl8jcEN2sB227Ca9l+BZskx6nNDZdC1u
         LodV2adLlrKtOIEgg7WWUSCOyQ2hvqeJ7BIob3tTeLTyewymlMGpR/dB1Jtese9sYeJ0
         N01w==
X-Forwarded-Encrypted: i=1; AL+hErHY6UOVjoJGDERVmJKd4bmcQYIbo2YXaKOUcOcn4d03GHVMURI73WMLxLX7bGSuT7XW49MeQ112Aw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+4M1M/iySjKfoRoU4UpvdFnbkO+kgd3G0+JnncnXgZDu9agOVO
	ah2xkl+qkgaQ2C4gi2hKYutWQZbJqP6Cv4CC9C1fZ+0/KlPWffGfoVKyzKu+TBjE+ift97pMGje
	3lG1/svq4yn2KLfeyY4edFD0Z+kXxQzb/ybx5eEeNyy/gnYv8B041hNMFpIDaEm4i63/0nUkSWG
	lwu977BWqqCRfi0bWKrh6xo6TZvSILu4LnXBhw
X-Gm-Gg: AZFdTZdiKpsvF396+57KKNV++H1Ai++JupckUeKuYt029mrXJvZ3sibcIM5axFtGfpo
	Bg/pr1lvL4tNb6tKESLt2ytNdgQtGwnAeYxeMmICFAYPxyc43HnKQAlAYz98U7TAIsHdZ6txQLb
	UtW7MQEQVZrjVUYYnynbgurm/HbgQvcSvhdIK9Y6l7jYNdbXzDTrxkuab2vQ==
X-Received: by 2002:a17:90a:d2cf:b0:3b3:b595:2473 with SMTP id 98e67ed59e1d1-3b41c906b61mr22660403a91.24.1795791585492;
        Fri, 27 Nov 2026 06:59:45 -0800 (PST)
X-Received: by 2002:a17:90a:d2cf:b0:3b3:b595:2473 with SMTP id
 98e67ed59e1d1-3b41c906b61mr22660369a91.24.1795791585008; Fri, 27 Nov 2026
 06:59:45 -0800 (PST)
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
 <CAPx+jO8_gCHgkeTB4aQDRjs1xwvXCB=zFjFBHB_UwqeOWSUEZQ@mail.gmail.com>
 <cc9c816f-eebe-4f29-a8b1-32c967c27722@foss.st.com> <CAPx+jO8d58tCoEL52baYMzjJ9VzyfpVNhruKAhrHrnEwuOoJig@mail.gmail.com>
 <47a78147-8504-4186-8e68-2d20d3832541@foss.st.com> <CAPx+jO-XcHTyAxdZTDQ6skJxdYRa8z9T5Nz2+naL8ZqC6pakag@mail.gmail.com>
 <900d21bb-f87b-40f0-80be-d21ce96ec202@foss.st.com>
In-Reply-To: <900d21bb-f87b-40f0-80be-d21ce96ec202@foss.st.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:59:34 +0100
X-Gm-Features: Aa3M54pJa8nqckNkm0XhArNlPAOWnvyOaTRiqd_KD6wsN-IfEnqLCmj_JS1jLo8
Message-ID: <CAPx+jO_pj+T7ZY9-9+vm3S0EHXTsBY1L+O1y8wOWU0_t6r4=YQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] pmdomain: st: add STM32MP power domain
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>, Ulf Hansson <ulfh@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linux STM32 <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OSBTYWx0ZWRfX0M7DzB0hxRMT
 3uCfVrBqRwwm7xN6gvpEvzeJM+43ff9919eMj44xnT0gZ+ynjUA/OI8sW1r0riY0M1pt+0A2ViK
 8/cgRc2l6/7rgtlpkYB5jZ/rQYCWmuU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OSBTYWx0ZWRfXzq3jV6DomH0g
 PJH+ydotQ0Keo/ndBEOmSg3j/LYUVbEjxFnYcgyTp/rnDJSoCrOBvM8MnahE5J63gaARlOcdeqA
 kAxygZYvoag+HOC78zEHnqAtjUy+k2hgNCj2NCx9rj47Le24jdc7+zk7HSpJqFV3MneMtXXrNM3
 Pjf8S75v6NdzzkN0rlwKvzQ4J6NFv5E2rP50KtvV1x1MXBr48CO5CVpPlSRPrXW3h6fuvaXDu3k
 V4vcG4obRTl5FiE7/w3xISZxA+BXsDNdzb3UtyJRwLqmhotDIDr4dHH19jLTHBJHGA1sI5eWNmG
 e8pkU31vlcvYb4vZIZa8wWnjyrUCbX//DIRt5Qq60rixqp6sPWrITUirRQFC89JzqQtGA8CfjGj
 TTtRA90Kz8zPGnkaP9HCvnXi8K9VXgSLBFtGCvFt0W3umEghvc/A/uK4/38KPmL3WbLoUJjqXh/
 KFiIvwi4WMeHfldIGiA==
X-Proofpoint-ORIG-GUID: 83MIlQsDdabNECRiOLkvhL-af9fwk5-f
X-Authority-Analysis: v=2.4 cv=Z795j3RA c=1 sm=1 tr=0 ts=6b099ae2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=R-Zjbl0nVnF-b6xtWdUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 83MIlQsDdabNECRiOLkvhL-af9fwk5-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270059

[...]

> >
> >>> However, there is a fallback option as well. I think it should be
> >>> possible to drop the D1 PM domain altogether and instead hook up
> >>> "usart2" (and similar devices) directly to the cluster PM domain. To
> >>> allow deeper states for the cluster PM domain even if there is a
> >>> system wakeup configured for the usart2 device, the corresponding
> >>> driver can call device_set_out_band_wakeup(). This informs genpd that
> >>> it's perfectly fine to do a power off during system suspend, see also
> >>> genpd_finish_suspend().
> >>
> >> If the device are move in cluster power domain, it is OK for S2Idle but
> >> it is not valid for CpuIdle
> >>
> >> For example when UART/SDCARD is not suspended, the domain cluster will
> >> be powerered-off
> > No it will not. If UART is active from a runtime PM point of view,
> > that will prevent the cluster from being turned off.
>
>
> Sorry, I misunderstood your earlier point. I have now looked at
> device_set_out_band_wakeup(), added in v6.19, and I understand
> your suggestion better.
>
> For devices whose system-wakeup signal is routed through EXTI1, this
> API could let genpd power off the relevant domain during system
> suspend. It seems straightforward for STM32-specific drivers,
> but may be less suitable for generic drivers such as EHCI and OHCI
> if they also need changes.

Right, good point!

So we may need to add corresponding dt property to allow us to
describe an "out-band" wakeup. Maybe something already exists, I don't
know at this point.

>
> My reason for keeping the D1 domain was to describe the SoC-specific
> power-domain topology in DT, rather than requiring individual drivers
> to know about this hardware restriction.

Yep, as I said, I am perfectly fine with this approach.

>
> Nevertheless, I will use this API if the D1 power-domain binding is
> not acceptable and the devices are attached directly to the PSCI
> cluster domain.
>

Makes sense!

Kind regards
Uffe
