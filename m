Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E90306741
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516604; cv=none; b=BzyRcmFMeyLDkDJ8ZYUagXCrk4+gvFTzKDBvXg1dhZHSmmK1iynUewVdfDFEdIUN5+8ZPdMcYzc1IZ8rz2m3V/p4/yeyoNxC4HFqIT+x19yxmRZRwyYOvT0a8TdBn2imV4NHcRysjHsl33An36nUjaPP2FM6yeealdni9FL49pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516604; c=relaxed/simple;
	bh=zJva5cAsyjmzVqBVumTX5Zywhnrx7uMtvJBFxDGeIMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZD4wcH5qPyqsVLO+1Sjdn+lrkbDB225aloRqtfigin/1JqqVOe4RTVsNBucn3p7wGBxHE9aK8h/vEUSuhKyl2bkJDsoc13R80eYArH55t9yVUDpJZptSjosA2oqFMzCwWx/5RxfUbc4Gx35hzoxpF8YbIh+gYMkE2KMku+o/5Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VteuG32F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qt8N7bUJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VteuG32F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qt8N7bUJ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3jcf2759369
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 13:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NXzmEq6LO3fIlF4Ec7BnotwtU4WcSRjzWN/rTY9gyJM=; b=VteuG32FZRLC87er
	yf2b9CrafHqJm1QWxUNNEHbAnav3n71OmWW8m+kxEVDFgkmHT9oPlFEm3BvyHAVX
	sO/0i88dVGTYPWFP/z7MKEDMbrNy3Jjo8n3bfhtxXIGr7DDL7DuENaeMLnR8IaZn
	tPdiTCAYGY9fKEKcORew7h/KBqBMmhP8UboEZ/A6y5qw+oyABiypxIjA1x9vfvHj
	wPV0Sfn0jQBh2nUTOwf/ClmrcYj3Tp5oeVKnnjIQ5IFrD8wEN2VoIXWu2RUiYkIK
	p2cphXlgQuSrQI+DzYVEn79nE2jxp5NFAA6SxS5f03TV5y62EzXTvaRXfr+KcK54
	WRx2wg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95e5vjn4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 13:16:36 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8fe0d9ba59bso1370846d6.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783516596; x=1784121396; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NXzmEq6LO3fIlF4Ec7BnotwtU4WcSRjzWN/rTY9gyJM=;
        b=Qt8N7bUJNZcIbIDxwRphsxGwsnXNTsUApRceNMgqz1ATCULYQjeVQtUwuoXn1dwQXW
         8v8LY13FGMlFLM46EI3uxSJeF2Fkzz9RkFFjm3z/s3d+h62mfhaWDVPyKm/qwg7i8ROC
         SwbQKKi5HocX8tvzv6UzdXM7RHPt9u85UyNHpOacEBYbCED+BNPJSp3/NmweGt8uKYME
         Ihy5kbSqiISg4e/EV92e6neYFxhgKNbe9zkXL08Y9BCqUNlOQRoy3rf5u6hokEPfOyUC
         CCANcdSikwQGc9Ix50/1iRU2kDF3V2tkFc/1grzPpbLWpdvCb1G1ZCkkMeVm54iMHgXA
         CNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783516596; x=1784121396;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NXzmEq6LO3fIlF4Ec7BnotwtU4WcSRjzWN/rTY9gyJM=;
        b=FP/VImfwagNjrBf9O9q0alYP5pobY+oTCXdqWrND7D06fBWHMJn/sobgJ5ucZyj3Ea
         Pj35C1lBdtj4kPsMIZENlOnFPDMGp76UIoUuTopekDh0KYkvwi7iXoU2g1gpQ9CmlvcD
         hARDeQBD/erzEaArzh3I6Ei+dNuPVtOo7aFubV2QnIxTW4BJLe4NQdBNdB9HUd44pC17
         1VpjwOxojV0ZiCVrO3wKI7w0pcTGvFveMuZ5UAgYwofnE0eH2BsYKCCCSC+s+6+7JaMv
         Ne3ZVD/MoPxiJ7a+zfN0tiQdxpy4uUg0CfVT7E8SvksqjPSI66cCzHouEwnn3y011reO
         lq6A==
X-Forwarded-Encrypted: i=1; AHgh+RoLqUcLUlaGmFR2QdNWANhka3XpS1EU7r0t53axFwmPgIDE8mrNcOYnb6L8kJtGlhthtru/2Xhv1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCcWrNL46+uhG+XdnfClRug4WghRgiDJRRpRF4Y4mbZcC14tc
	8RYI7mEEXkGGQedhvqnViMi8vFxQAnuC5Ksge2WaK7MEQY0iuKaBXvA7u+L7SeilIMy7DdAaJwQ
	OsEOvT31IxtJjU2rtLjBNRVz+0j6CeQdBtNCNkelLAVf7C4IB0jxypB0cRdl08A==
X-Gm-Gg: AfdE7cktPggm470H1PTwYNmPbLcn0+L3mmpBR8pblK2snYhWKpUaGO6/5GKP3qPzJGy
	/2f5kXubfQlQjSzRtv1ypg4I+3Cv8J79IZLZFOvy8rXU14TVNbSjMSW1M+lM/SnPjf0dIBig5nC
	MElDf99TOf/cyi+gnJlXLAOpa5RrzL42FXxVA6qDrZdt57+qC8kCQthvndxeFwjCCtlxh0TlYDM
	381xJMqi1TtIidu1tWAGKNlyVIYsoe9+g1wdKm42ud3vfDxl5b86TGBVKBf7RaILjfVUkTGFpaE
	gragSlXXE2ExjraAQYMCcInROHOZEAh2KRmATCGsgKIxaS7z4P1I0/KEhjmKXdrVjkbwthe13TP
	++bf13hj1aIc/MANZuBdRYPNBcg2GC1RggzA=
X-Received: by 2002:a0c:f405:0:b0:8f0:24d9:364b with SMTP id 6a1803df08f44-8fec3bfbae8mr18446796d6.7.1783516595483;
        Wed, 08 Jul 2026 06:16:35 -0700 (PDT)
X-Received: by 2002:a0c:f405:0:b0:8f0:24d9:364b with SMTP id 6a1803df08f44-8fec3bfbae8mr18446606d6.7.1783516595095;
        Wed, 08 Jul 2026 06:16:35 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a3652a02asm7016471a12.11.2026.07.08.06.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 06:16:34 -0700 (PDT)
Message-ID: <5bfb3aea-4836-488b-aaa9-ad770baa9c95@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 15:16:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
 <20260708-eliza_evk-v2-2-c599246ceba1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260708-eliza_evk-v2-2-c599246ceba1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: MsyNq7PkMPXSrxsVhKavMiIKP8Ek4RDY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEyOSBTYWx0ZWRfXzUyqEdFaHgaA
 /nR09cO16VdFW1HWKCiBk2LC1vXIB8Onfrj2JvhrTI7RZ1c8OonbVZ1e+i3yVIqhkfCwvzGmyvR
 FRvOuBaGhLjjCPX6KkwdWjzWw7SZ5o0=
X-Authority-Analysis: v=2.4 cv=CNoamxrD c=1 sm=1 tr=0 ts=6a4e4db4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=6pHcnep46kEejBPVP2gA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: MsyNq7PkMPXSrxsVhKavMiIKP8Ek4RDY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEyOSBTYWx0ZWRfXzxYzq+jQ5fDV
 prMQQE3wm7a1M/90a7U/u+hOK7jCdFnVW2uOVAECBb+zym6fYSLHVaXkyWrrFxOyyfe8GS7UoAC
 5pkb7aYm5zBh1kn29FXxhjDd/6jcd/YFN6eaKNjNBf2dhOfxD0L3U4YkkocrT7hpopKqNTB+mtL
 gzWyX8Xfnjl1QnrBug0dygfpb4dabHwlRxtOBQRLJ2gqPDV1Ac6s7bFsIPMzdCAgkwYSL10VOXk
 wNh311CFuHEXr+jPFmopVHSOzVBZFniCjpK/w15JYbYWuIEr0EcZosoOr2VnddFPspQOXnF1t/R
 iqJNTWTWeyEZrV0bIYrO30gIwSeCvDn/fzZmhJdlTiIx/z7Jbg7Hp3jyckq0qpnYd8r1sm6B/WL
 25hDFlYRV9/n6V8gVyt+ZgrI2mFZowdVUccsoCemF7J97cP45U3XDsmbxTxQLA4hnGkQfRoP308
 qqm6CmlckhjTxDtY1Vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080129

On 7/8/26 8:17 AM, Krishna Chaitanya Chundru wrote:
> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
> 
> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
> 
> Override the base iommu-map with the expanded set covering all the
> switch's downstream ports (0x1400-0x1408 SID range).
> 
> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
> from the PCIe controller.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
