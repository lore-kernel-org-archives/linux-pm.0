Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053563C769D
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778760241; cv=none; b=mycRx/3AcCpeLCeBFwG6YOPH/dzvWNY+aAkl0/qSUxmEfT3CY2FHgy4Uv5tCvia58L+y4x4At+rB1DurKRlvcjUvcOi9x9OfgCSm5D37VFGouw6qIGj2x5aphP+OEXgD4kMWwwsBhJW8HDVSK4Nltv2cblROT9EcevXHpFiUFEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778760241; c=relaxed/simple;
	bh=S8tvciwNb3UxrfHIh4lNV3EW0cewsgPN0q+Ri2zhbRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVrY1ToFGDqRNRNzxWLHmr9YchBGorauic8zgsfM5M9wNMHXaauOPOqKRfkalanbq68i8WzzyBsosGH82gSdzv2jY3jQ6/FTZ5KVfPsX+y3+BBbMVanery0EcjrF1jxKAUoMwXlzi7GCPS/oGVjpTWxEB9vaMAxtEn6hlmBxdeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hiD52Zje; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XbCpxlT1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hiD52Zje";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XbCpxlT1"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBeYRD2238429
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 12:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=reg4qcjdIp6x+0SDJUJ4n8gs
	lWAQb0+Nn0u/viW8k+g=; b=hiD52Zjex97PxmfjXjFNrgr2ZoA8rSNdyWqJv6ZV
	hFKbvC48qnEscoAu0XcvT64ZQXIlclHOtyT7/qYAXTDoQOeMsoiBrRjL+LCdzZAU
	3Ebuen8AU8JBzzbVB+xzji2Y7QmRcMLCqsVfuHuXMWbtNAkNfoFvs+gb4IO58GyG
	iGpOd2ssjDG281Eeb8KbRd/LQ7FlLmXPvHJBXvsMPvhngdEI0TXHgY5DcQVBa12d
	p3+YjkoUbiuCAaM6+rc1Zc4qfXIAFRNFH6zzrhDhNKULVfwxvaVszs0/z0LCIhzy
	cdU0Dsdyhi9lTL7YVN7Qj46ypS59gcvTnw9ODvaJizkd/w==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e566bhnbr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 12:03:58 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6948d83a548so18594305eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 05:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778760238; x=1779365038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=reg4qcjdIp6x+0SDJUJ4n8gslWAQb0+Nn0u/viW8k+g=;
        b=XbCpxlT1q20eSGYgc9CGSEpex5QmTtlAPLqbYllMj0utpqlLIQHoJGplbSUdJcrrRr
         ziiUP/+4cB/aOYKldgnhYtZgPgWarzeSN0xRUdhBDQyy6t1YOu84rA9e0IqqbPw07xVk
         ZZ5C9uEqrV5YvbPULDWp5ZVNXraE9PpTp7kmVnAVHQh6zt21rGNgmohv0gex2u7ZpBPF
         XYOFRYXEEcAeIFHKP5nDXGVBQ94yEeWcRzWO8itAiWmBq6fvCO5ZqhdIZRibUHSNiwAT
         ZKyZkijjVDreA4u9hSB5C7aMT33Ofvtx1K4ID331FNRTuHC3zB18Sn6H9bIHOeQwDLKZ
         wUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778760238; x=1779365038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reg4qcjdIp6x+0SDJUJ4n8gslWAQb0+Nn0u/viW8k+g=;
        b=PaeGqvvrr96VPfekWWEK/2C1QQlDqk0lE3DHJtz0YjXMS4rqJnmzMFF9o4WHbDTRdj
         PFxMO5ig3QPdo7jI0Wg8I8d0QtXipgim4uhxhRKEAONR2gd+4f0wIpxRoMBgF2ZdooMd
         zNy/Ghrce07L1zzxawnDTy93igTlkiAll0cm8zaJkKVS/xwarMbeom03vGrxUxWldVjB
         cjsdy9XRUEN/Wzh3XeU4mfWeoZtBN+uKqis1TTlwenG3FdwqYNvAiqIqqIymx1nlEKvz
         xN0fsYMtmCt10iW36Rg5w6ahQgxV/31+hET2E9Wi+/6cY7r5XAe/lEJlAG3AVBtZ8KrF
         MVWw==
X-Forwarded-Encrypted: i=1; AFNElJ+NucVp6FGzQQiLXh/XiJF565XPp7cS6EFyctU4SbxvdAyp7+3diriCUAZ6x9B8sFfS4qCy9EOsOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIRhMBAiEcy/6xkXzgo9Ulh8MInlgqVwmOkKuAKI20n48hJAqi
	ki0FHTVYVVOHm7sycmnYYR2o+3PsQiiw5P4+nWRJGaz9vpJ5KTg6uFigZyZD1ujS9dLneqeXIpN
	c9kNZtIyGXwwCTY8XX/8XcrW/p+9hL0rvecpoJeRFl6w0mbXgrKe+9bFdp2wFCQ==
X-Gm-Gg: Acq92OHuGcIQPkAuVBnfbmmA14hTcUxi4eyY8zewET0xCeueHFMgmQfFk0iw7wjdbWd
	KEM6tiEkgATg5DoCTttIxNW/CaAdow1KLPIvHSV8W4UNkXoqCl+QxWg1eC4cdfbOz1mKy32IpGq
	/QG7NeRUnGCaOICu7PXXltAHEP0SKIOl+4o47DSj0vxFv9VgFkoC4jPM22+FKP4xY6iwSGq9HQv
	U/nC/L6rKjEFOLCgtd1hyAZ0nPWgVpgcd9YyaEJ+Is0PuyLcqwNt0Dqj+dkI1pn4+rl2EqeiX0z
	i69UX415iE8ZfxYYFhkWf+EAGjqLEtHGJN0OOgKr/b9acrFF39z8aCnIZY1CBEQirvI2/z40WdI
	5dIH4G+FVqb+KF7kCYSPtVmpsBHkk/UF9IqwV
X-Received: by 2002:a05:6820:4cc3:b0:67b:b8d0:a7d5 with SMTP id 006d021491bc7-69b7abc298bmr3724778eaf.53.1778760238272;
        Thu, 14 May 2026 05:03:58 -0700 (PDT)
X-Received: by 2002:a05:6820:4cc3:b0:67b:b8d0:a7d5 with SMTP id 006d021491bc7-69b7abc298bmr3724706eaf.53.1778760237645;
        Thu, 14 May 2026 05:03:57 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm5900114f8f.26.2026.05.14.05.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:03:56 -0700 (PDT)
Date: Thu, 14 May 2026 15:03:55 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom,eliza-rpmh: Add
 SDCC1 slave
Message-ID: <fexo26osrsj2t3777m6fag4nzqxgvmpvmcxcihnwffc4ehjwzl@77ynlnp2gh53>
References: <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-0-b1edf81bac3b@oss.qualcomm.com>
 <20260512-eliza-interconnect-add-missing-sdcc1-slave-node-v1-1-b1edf81bac3b@oss.qualcomm.com>
 <5c615bdc-3a19-4f07-a38d-16d45f318411@oss.qualcomm.com>
 <fnasmnyh7rf4wtyrv77lunx7spilgjxji3ejflvufouqrdep6n@uu7pkkfwkxyi>
 <66b3840a-390e-4135-9118-b1ca52d40026@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b3840a-390e-4135-9118-b1ca52d40026@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: TBvAp1annJCpAQQlkW8V2YIMuX89RAtP
X-Authority-Analysis: v=2.4 cv=WsMb99fv c=1 sm=1 tr=0 ts=6a05ba2f cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=NtgjAHhJo3Q0P2g9Zl9R/g==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=CVkctuRbRQ7OC4GNKrAA:9 a=CjuIK1q_8ugA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEyMCBTYWx0ZWRfXw+8K4LhyCV6t
 mzQlfJvI/76YcymZEsNQfo6dnFmUr7Hi5grnLaedQGUezxGNocDMD2UREuZIqr4do4K0UC99fgF
 a06j8mzRSzrxFQ3B+gxIY/MK50MyH1OzUk8mXDkULppIiAiUybQgBExueyw6PhsoJmqsbObs7W5
 7BcwB3LKqmGQag/TEA7mvSolPglrViOT67AO1kqG71PV6aJzitwYm1ccX94fNnD2UgMhyPPO+H7
 oPFEHfp32PMmOvoEZw7Hi/FtJV6yKMGFR7j7uVv9Tzp2JgC5QAwCbq6eA05MqALAIjOPOaCCUBu
 /L3oWkJxd+PQyu90fIpFIv0aGpT3KviXspcIB3tqc/H8r5SuFVGkbsqAixFJcky5QfR2kx93t1h
 nudGJG36tvWDgcFcIsyQE2ZjR/Vb8iVEtCtvmxuIuGtYgqzM/S6Mz4unRJVh1G4ErKrdkYP9rFU
 hQWxWzL8/rVnvPggngQ==
X-Proofpoint-GUID: TBvAp1annJCpAQQlkW8V2YIMuX89RAtP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140120

On 26-05-14 13:44:59, Krzysztof Kozlowski wrote:
> On 14/05/2026 12:46, Abel Vesa wrote:
> > On 26-05-14 07:44:12, Krzysztof Kozlowski wrote:
> >> On 12/05/2026 14:18, Abel Vesa wrote:
> >>> The Eliza RPMh interconnect binding is missing the SDCC1 CNOC CFG
> >>> slave ID. Add it so SDCC1 consumer can describe the corresponding
> >>> interconnect path.
> >>>
> >>> Append the new ID to preserve the existing ABI values.
> >>>
> >>> Fixes: 8300438dc424 ("dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Eliza SoC")
> >>
> >> No bug here to be fixed. Incomplete first posting is not buggy just
> >> because it is incomplete. Otherwise please provide more details about
> >> the bug in commit msg - why initial posting could not even work
> >> (although it did work...).
> > 
> > The reason the fixes tag is added is because we want this to be
> > backported, as the id should've been there from the beginning.
> 
> We do not add Fixes or stable tags just because we want something to be
> backported. We add them because something SHOULD be backported according
> to stable kernel rules.

That was not my point, but I have no strong enough argument for backporting, I
guess.

So will respin without fixes tags, as I said.
