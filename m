Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3A3B9DA1
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454601; cv=none; b=tFFIfnfufQy2YHfvS+xLM2NKDTWSSqS8yNlsQMlKAacHdvXgYzTN6g3DoSRQ3a9gFlDWlYgT1Zyqwc02Y1wVKS42nj5DDks+5JwAvjHkdimE01LcG1KgAgWuNh5R3Fowh/G9zeDiuxVp/E7/+xHOH2NoEEO4P3DNN6novyMK2B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454601; c=relaxed/simple;
	bh=1NnJQsLpA6+7KCWjI2WzSalvqCYdpk/3gG3EpaXIfEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bat/nmEJieTueKEyO8hVvZJwZhp3YySpU3NaxFAITYZV68RVn88Kby8TzyCrDJN4l11WecwXU1vC8VeG5DDG038RAeM6YxggkOQp/dAdL59LHle+vXE4+1Fr6vjnG2FuGb50JcFuAStazXGBLgNvztrpmqi2ZA2oZMlWbhHVeg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NluoVTzK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HwuwyoSa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NluoVTzK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HwuwyoSa"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8ps9R1641629
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UxjUtMEcf3guQFZGlMGFmhyqPC1whCDGyI3j3Ls/ksg=; b=NluoVTzKDbY/EWNF
	n0UgMKO7HIAW6YgTUMNXzxE+Dd5xMHpkkUWxf9Wq30kCsiM5cSWq+mFFrrPDDBkQ
	l4zmEoY5YxYZbgfvvrT5GVqRl3NRDarMXN4d/UhgZiwEBJlvRpA3ZBDSTRJQCIFv
	+8jcospOPer1998kmM6HDF2iFUdFo5S1ZmMWYN2/oCGKE5q7ibPPw8hhUcI6tnS2
	mtdnJsplXDmZ7IjQBxillmsjHqVVzmNgoF0yFcqa5cMQZ6ndHnbTROD33mvyviox
	g5WDILuC8OUXAOCacqd+VTMlTvWMRCpaZ3DyufvQnPIDFf7AKaftNgZG0nSUvUm8
	4iMalQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj80te6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:23:18 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56e072ac05bso1080277e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 02:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777454598; x=1778059398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UxjUtMEcf3guQFZGlMGFmhyqPC1whCDGyI3j3Ls/ksg=;
        b=HwuwyoSaVMjI6vVmjdWtm7SN1OhOKRfwIR/JvZiIru5KNyHXo5kbe2qCOJu3J1/Ogz
         4HETRSjoaan1V+iRWTpHYAtqeMqEGkveJnLfxWgVtJKZTd2bnVjE9kDhyNV+SEZuBx6I
         wGuSIbe8oTe+C9o/n0L5BvLU7ixgdc7AQ9v+3HOJAYv5IcEfH5oJrSfWTIAUpYY056vj
         3k4VGo4EXcJNTgxhdyXcpLnvA0/THi+QiUK2wYwoEgiqBS0vtSU+WWBv8Cz4k9dayKm8
         pXpDMse+iRAUJdqZCL5L/nXjv47CqA/muXe5g3hdGtC+AN+urmYC5yeKioHoSLIxpEwJ
         WJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777454598; x=1778059398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxjUtMEcf3guQFZGlMGFmhyqPC1whCDGyI3j3Ls/ksg=;
        b=qTptmApITLK5Jz9fe+2yf6TEGT9awCPtc6hX5yQUCPJTAIDMJgivgOSlarhrWc6sOw
         eSdsuY2gKPMt+EHCZO+YBysNZ2QaILrLGjfqeHdXv5GJZU3nsLBcjUdzSH3lgtHe+SAg
         1meXpnEjrJWEPQE/N1vUDpbPGlgKeYe+FqHZKEfuI6+T4l2n/wsxn4dNhNc/e10WPE5c
         yT+fEsBAN7UiGJurOdIjgLUqVBKkygUCLJSlgpxYq9rDtCvHeXBeJCE9GXn61/IpbLcP
         SuH/okS9BV7Q+l7qdUyjbauUlPv4rPA6lpPdCa50zC/9gxFXIzFP8dPjKl6Vf2bwQviM
         negg==
X-Forwarded-Encrypted: i=1; AFNElJ/0vtkBEuhaijmV4RpcOts38zR/eNae/Cl4Zb+9dSb+ITHf1qD/sSgmW071RaOsjKBNBHBIUf9VTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeNc/Y104j33zRYjJwseuk/LM/4M5sKZxqjP0GRiw4aAyxzavd
	sfbHTqU/exTWzQf9SQi4eh1V/xs4yh2isWJPJJmQq6uyaEtFNQS7OjnlCT/J0R7o8InSGDTFEsb
	gSb98BiInCL88A6wtN7FZm72msgyk5u6x1SKxfwWXMx5Qec85C9xh5Iozl/1BCw==
X-Gm-Gg: AeBDietg74drIBqpmuxDfvtFB8CHXuj2M+iSRjWDOCulOphjwmmsug1igsJtNGmMB6O
	i+Y7yYiFs3U+n/NQBW7LjyWILqPtCUXNXD6SbIhlpLSZpPHsm3vgX816VW02a1QdpfkTpDEOPI9
	Tui7v4EMYVnAGIsI5OA+XIVlgmryRYfG/chxSIXyEAty5a4j7hpZfxNupVFH0Z421yaCpWYbEfu
	n7goVbXnRsgGz6BDiK7ZKGkARYYP4ANPDM81euPisluZWPqIU7CLq9zpldpyGzM4WBCAOcRnJUu
	bTRALuoM7NRYHtgR2+V/DA1LL4wnnYkODvz4GvwidQWluT04rfjQzpvaKtubla4+1s9HncbCKLc
	P17V8F2Ea4d8wv+CaCewkkWdWhS9eNdne9PwHTEHfgrw3wpSTfgMshRlq1LIa5w5Ta6BdH80dpq
	QFJz55AuxM3SAXhQ==
X-Received: by 2002:ac5:c8b7:0:b0:56d:a70d:7f06 with SMTP id 71dfb90a1353d-573a2942f1dmr1298096e0c.0.1777454598152;
        Wed, 29 Apr 2026 02:23:18 -0700 (PDT)
X-Received: by 2002:ac5:c8b7:0:b0:56d:a70d:7f06 with SMTP id 71dfb90a1353d-573a2942f1dmr1298090e0c.0.1777454597661;
        Wed, 29 Apr 2026 02:23:17 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb9854393c2sm65350766b.36.2026.04.29.02.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:23:16 -0700 (PDT)
Message-ID: <bb02291a-1579-4069-b6b1-757a0b5fb7e6@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 11:23:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] interconnect: qcom: Make important drivers default
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20260428-interconnect-qcom-clean-arm64-v1-0-e6bc3f7832db@oss.qualcomm.com>
 <20260428-interconnect-qcom-clean-arm64-v1-3-e6bc3f7832db@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-interconnect-qcom-clean-arm64-v1-3-e6bc3f7832db@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Q4V6xry7iyJfx-AXbxlMHgiSHWIvRONz
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f1ce06 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=V2NSo1CrvwOFa_RsOSoA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: Q4V6xry7iyJfx-AXbxlMHgiSHWIvRONz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA5MyBTYWx0ZWRfX87Hrsz9Be4FN
 CxisSpdgzJecjUcFrbwOn8wJHYO4On6GJ9baNeeJDCEtLvveARyNU6GtPc7UfDOmV8uqLM7JsbG
 jlEKz2Cb3pkZcBFXN3pHNHuHe45CAzmL5Ujaik0L9WaDkpB7MBo+GUK2fTxKj915LM3ZwryDWpv
 u1RRD+lUvYoblV5ScUBp5jJjnTil9NuDcO5PK+fY280fMr63pmm/+EzKOPftz4FoX1ubSQyX0Q3
 fq/OO3X4UW+pBYT+8uVmPuq0uDBKtoyeYyjHklnlcuTVjFF2PpJ2wImIdYtS+NeGE+AbsvkPH3N
 4i6oJZsFJjTCg5GLuOgXe6IlHFQvuvxcF8isS7O3sCxPdDHXeaKZKjN2wUZYSCtGT30sKm7ia12
 Rh0r8fLRKtpAHN82vnQrcVSw8oDRgBl5tRCL3PATV+OndtUuiszgzaT/NCxE0YpiU73WGZs/9hg
 B1zJ0+tTDoYC8u+IU5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290093

On 4/28/26 7:32 PM, Krzysztof Kozlowski wrote:
> The interconnect drivers for Qualcomm SoC Network-on-Chip are covering a
> basic or fundamental SoC feature: bandwidth management between internal
> SoC blocks.  SoC can boot without these, but power management or
> performance will be affected.  These drivers do not represent any sort
> of buses visible to the board designers/configurators, thus they should
> be always enabled, regardless how SoC is used in the final board.
> 
> Kernel configuration should not ask users choice of drivers when that
> choice is obvious and known to the developers that answer should be
> 'yes' or 'module'.

I'd say let's make them all `default ARCH_QCOM` - all of these drivers
are required to boot (minus the OSM_L3 driver which is "only" highly
desired, so that your CPU's bus isn't heavily bottlenecked)

Konrad
