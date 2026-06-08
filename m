Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E435295C
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910502; cv=none; b=aywjyS1AQGsioF6N53fCiMBVSNlRahqj8qN5ZepX0BbVSnIuwV9pIx+pJvYDClDYJKPYwHNXLTPk+4Vmav5bnpq5SnNnzGH1XohuxJuf7JT8evFPNzElOM/dT5QCHGKEFu/vckRsyjjbvxKerhEFKsUrKTiY2cdmJoNWrbH710w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910502; c=relaxed/simple;
	bh=/bF39d1NIuczfJ3IZUCdW7MiQjF0yS3eUlRvpoHWi94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=li+pUuTjtjQooEieAHfcoy8/f+hstUB3PvUNShRFQu7YSjUdjY9dkJNkqckI8csx7iuYKHsjuPx4fMFKpIztfKm761dzE/1DcaVwaDz3iKtsznYVAN4YdrLdKK9vIs76+Latu3Wgw0EawJbFhhFshchZ7aixYpDoxKn0H4ETvQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TkWkBUxQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cTIYM050; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TkWkBUxQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cTIYM050"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65892Ea92677592
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 09:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c3Qo/8d4aE/Bw4GAlPbSk79wc0v9MrjJB8silbnrFxA=; b=TkWkBUxQel2vcd/5
	t4JgxiOvkIZyvRHdd2w8RhIbIWb/euyIcdrjprZpWBMHUIUyZH67IADt+yyWdoKG
	h0vO67PhllfDR8JUV/9uWR+uxNj6SZFYWK95H07ODfGlpAc9js73W36Ce1bTgj7P
	/UJeBw1pO1YnvJTaO1qXBRdxJOx+U23YCvymKqrzCYdE/ieT3ZftAFBpXi4aaEZ6
	/Q3aJAWce4rRG9fJCj0kbP6BO0OKQPxo4gnoxFEZMc1kiFN8oCN7rFpJK1BejuiF
	7WTza2TTAYG74Nur0ww8ItPRZuwURG8WRU09j+EehdEmP3Y1ZY/0mP7iGTY4zbvw
	f9KKmA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entrkr332-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 09:21:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-915a547f4b3so105002085a.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 02:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780910500; x=1781515300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c3Qo/8d4aE/Bw4GAlPbSk79wc0v9MrjJB8silbnrFxA=;
        b=cTIYM050nkYQN8pS3NEkpIaS4ZIsuXMjR17J2dpcRa/fdGVqe5hltqhLklxF3WppxB
         +4wsHRFFTABKSFgpDlsGNb27JH9bdIWuMvfn4dyl7Du7x0wuv7fBPAQsloGOd9JheV2s
         A2I16Sy+BBjJOciws6h9Y77n+50T4r4XVVpQD1LK8rcnruAnSSI6Cc+x+njGghGivRs4
         KrrlX/blURfpUueiGt7Kf1ICLJee/YaVFep5lL7ZPm53zBDO++kLB/QlT8sHV1jvy3iw
         Nhg51QH+vc26rn2iTq6sExQbYprWVWIzKzYvyqhuBtd8uMUPQabNuNTvarNoVjpNkY8p
         vuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780910500; x=1781515300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3Qo/8d4aE/Bw4GAlPbSk79wc0v9MrjJB8silbnrFxA=;
        b=s2AVnx1CSmu6pX7eia7UTro00jsLKjDXj/iUFLSjIl4zTcuyby0sjX2mtQH2VOUeRz
         TzBBwU4hLML9ttFrE1vW+HM1kZPYbVZbx80oqxbn6x3UmenHjffFAgZwUnmFSOszhCZ9
         pLDrwvSxzScOswVnt03rdND9baEcY+Afhx3OzKzY07oIWn16MceKfuBiOGH4usDqryAO
         3G6Uj0gnSdpL1yAC/6w6WM6+pRqgI3msArA2XYOlrQTx+pL1F+RxoYl+hppr8MLrC1/S
         8KlmPkvc/FRBW/9EvnTPPTc4g1YWtYM1ixrgwUYhFUzhb+/S0/ABWz9xe3ypYazsuzr5
         6+IA==
X-Forwarded-Encrypted: i=1; AFNElJ/T2huhU7tFp7s6YuGE7wp+TKgP8CB4+mtxme758JMwS/Wpw5p3ZMOFi4xlKG6aMzwnkg0K2G/glQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnKWi2d/7ROur0b7fcdv9enVu1QuTr4Viqj2drM+flZb1IXa5m
	1F0UlDQSlg3IwXol/Y0faEFufg9V+lNoksV1iy9jci6h24JSscdFC8RRpvugYE93sC6dkGlfVjZ
	7A9zfJTfW5QS57R74a8EYwgqXuZH0wBwm3VTNtIY+iuHqiqYw78rlD4j8qQBd1Q==
X-Gm-Gg: Acq92OFripf+bd6mdBdtsKTVqLC4E+IVaoJmCS1Q9dDMZtMme+991X/G45v1Nlhv5M9
	XndMC1mwOKjTPAi/4dT9LAN6Xqstoyc+etI3IwEMuF5ZHuVbCcJDygSUssl5Qe33nLT1BHx972y
	jkP1/7fou550wxgMxLJ2fUEo967O4z/ogrpMNMvosAcQ18TiJu10ylT5syqcCLF7fvY4zqrJIB0
	Sw6ykWDJ8vMFwtT0MuiWoYcR1uZXoKLj2vE98fWiBcvY8y3nPHab+yfG/ya+5pUecwzlocDFkQn
	YLO9l7ReRMGpoAJlLeDEvvHh2dVIm6yZTgP3oQjeQVwz79nF/2gqgzVoxxovYkPDr1V4HgqZfnC
	OPvyDWIPZ17dWEGXZ8Xp9kyYiNfqf0C/gh+p7nhy70Px86phuoVAw8dB/
X-Received: by 2002:a05:620a:4153:b0:915:7dd2:f855 with SMTP id af79cd13be357-915a9e16827mr1242566285a.7.1780910499604;
        Mon, 08 Jun 2026 02:21:39 -0700 (PDT)
X-Received: by 2002:a05:620a:4153:b0:915:7dd2:f855 with SMTP id af79cd13be357-915a9e16827mr1242563685a.7.1780910499171;
        Mon, 08 Jun 2026 02:21:39 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64c2f34asm7139892a12.4.2026.06.08.02.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 02:21:38 -0700 (PDT)
Message-ID: <1ab6db68-3347-4555-8ce4-108c4ac01438@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 11:21:36 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] clk: qcom: gdsc: add RPM_ALWAYS_ON flag
To: Herman van Hazendonk <github.com@herrie.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260606-submit-clk-gdsc-msm8x60-legacy-v2-0-187a32d2f015@herrie.org>
 <20260606-submit-clk-gdsc-msm8x60-legacy-v2-2-187a32d2f015@herrie.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260606-submit-clk-gdsc-msm8x60-legacy-v2-2-187a32d2f015@herrie.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ZtcOL8bzDCsYRP3hG9AcF8ozazdF19H2
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a2689a4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=1DhR-0cvEugVRngfOrQA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: ZtcOL8bzDCsYRP3hG9AcF8ozazdF19H2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NiBTYWx0ZWRfX/Z3NDQTBAsxR
 63tCdNnzBrwZ5H3S9KxSLOiS2hDA4IhJ7ny97vuRFXfAuC1+zUm0vHwH34YryhDtieGOT+JX+rm
 Wbd2UtaggqhQU+ISz7187bV0VLyJJGW7foGFiPsMApCxLrYLQMySbNcHxgDF2MwCPCB8vNRN3eP
 s17zGWawy0D6okuO1aEyo9iWrNfxQFiYXdomTVH/BQ6v0zrXP6uM0L78LDgsvIB36WWjv6zBdt1
 ym1WMPiGO4rD1mjmYDBhTLYdsGLaJhw/XBkZhU63oN/mnBviIIFuxdpJyEp0CSMas/frlrTStSu
 P5FB03kJM2Q/0yK4id6/rZI9jWZg7zil/jmSmhlhrXIddkcwvP6uaYCqTpYYgFQMiXdUDnIc4PV
 mSWSTE1R859kC6ZyUKRNCTtfj3+Igo4l4tjtLq8Uj+2wMkMVRmW8pQaM7W0/8UCtW6HqhGowS4h
 9FSYAjrqOUuMDsTh32Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080086

On 6/6/26 2:34 PM, Herman van Hazendonk wrote:
> Some power domains need to stay powered across runtime PM even though
> their clocks may still gate, and only collapse on full system suspend.
> Add an RPM_ALWAYS_ON flag that maps to the existing
> GENPD_FLAG_RPM_ALWAYS_ON on the underlying generic_pm_domain.
> 
> This is distinct from the existing ALWAYS_ON flag (which keeps the
> domain permanently enabled and prevents collapse even during system
> suspend) and from leaving the flag unset (which allows the domain to
> collapse on every runtime-idle transition).
> 
> GENPD_FLAG_RPM_ALWAYS_ON, like GENPD_FLAG_ALWAYS_ON, requires the
> underlying genpd to be in the ON state at pm_genpd_init() time --
> the framework rejects registration otherwise. Fold RPM_ALWAYS_ON
> into the gdsc_init() block that already force-enables ALWAYS_ON
> GDSCs found powered down at sync time so the flag combination is
> honoured consistently.
> 
> The first user is the upcoming MSM8x60 MMCC driver, which needs
> RPM_ALWAYS_ON on the a2xx (Adreno 220) GFX3D footswitch: cold-cycling
> the GPU rail on every runtime idle forces an a2xx_hw_init microcode
> reload whose MMIO burst can stall the shared MMSS AXI fabric when it
> coincides with an MDP display client-switch underrun, hard-hanging
> the SoC. Letting the rail stay up during runtime PM (clocks still
> gate, idle power is still saved) and only collapsing on system
> suspend avoids the corner case while still allowing full power-down
> during deep sleep.

Is this something that downstream works around, or is that observed
behavior with upstream?

Konrad
