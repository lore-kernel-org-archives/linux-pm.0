Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636146AF25
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842483; cv=none; b=SYsUf+JsTUoFSzBuXiQiWPuVS1QymbEdv2akxu/72qTIDg4pVm37VpsgurkdsjEM1zGjpLUYJIbvWjXWRS0Itvplknzyj3yCR23ZbAHpeYvKgr8y6+nyvgeR3Wam9hSnRjY6wEH0VnMwr+WftFykzlYfRu3A2yoDohyeOu8eCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842483; c=relaxed/simple;
	bh=PXlklGP/mfWQ/1xEaIjtXHpjJ9Wk3Hd10+lAUTbV5Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnilMCZc6SOOSjVcqZu2tJ2sM+Z60MO+qVmpajzRznxjgJnWredhgvo5i6t7c1LonmNTgJe48zuaugAnwQZGPgAAvfgBN6aVM+w1rklWugDcQ9Zc4M8LYXEO28xfwz1KXnQkURKnBBH0CpZe87BrHDpXma+zoagO6YIJoSlqKZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MFoy1cOX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q2qxSKD+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MFoy1cOX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q2qxSKD+"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5A9em3671116
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lu/ICIRwMvB9Zl2jHO5QRZoifsQ07TW+kX9mhHyrhDY=; b=MFoy1cOXPtGvkye2
	9kaT1rre9BofxaNLweYPIrA9vBgHGpzOgHp+QeS1H9H/CULXiAOoq/taV1LxaIui
	rjWopT1wm/IqSFW+ey1yTHbrdMG1B1ACp9GuGcQ9MDDDcK75znZ6b5vEJeVyB4vN
	6u1EEgRrSl4dY0w4NZSGB4IqRANy3uHNMSBfLd3eT3GBMyj91v1qVJJRL7+Hwjcd
	Nj3QTEP+fWmCx0mX09HHqQnGVLVnLBaFaw5C01IcsEr8nY3KSrPB5puGy4sam64y
	pgPIY6zcbpZgfCxfas/nfrrhryo6gorKwxdw6wre4PX/5vODEtzEheqk9UUumrA3
	ntqqHQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s2ytb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:54:41 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-95cd67d9a7dso371753241.2
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778842480; x=1779447280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lu/ICIRwMvB9Zl2jHO5QRZoifsQ07TW+kX9mhHyrhDY=;
        b=Q2qxSKD++eVD+N4ln7731QIvHTaqrAPdUX3bqLo9KuI5Glhinh7mSpLojMGbZuvE65
         8uuv0/F35BXaXqG98OtC3b03P3oreijfBawtlB6yc0GgDwKhb+Gj6CaVFkczU3E10KQH
         8N9Udh6tquabXluX6SfcGqL45JI1W8kqdosjH16xMTWiigZRPHL24GPkMhTmHrB8QFRK
         VghETNMjh5MrkL9n2LLqSsl9PVsxzXaszUMMIN0tmj/YOCkv0TYQvI0t8WXLrcNVvoLX
         B2/n1buZibiL99KZMGNM17h+PcYFYKtWs/s2CVRP6Vo5W0e+3E6bA8HiL9hReJp3WLx2
         65/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778842480; x=1779447280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lu/ICIRwMvB9Zl2jHO5QRZoifsQ07TW+kX9mhHyrhDY=;
        b=jB9UiYZqSMZCVsEuCG0OIVU3ke5wg31oxMVq1br0+XaKEkPLJk2YspKo8yFJGDv5iJ
         YBlQvOsj0uy81MzV6pEx0r/rLnHI7wiFxsWcJYLoKAsROt6FDM/c6N9fms1fQLhiRNSq
         +kBVKVvZmQi7ppCuPSKbR063QN9bG0EQo3e1cQX0rLY+QlTacOipol4k+RwszjtuzqW+
         QIib415OjojBCgFXcvMBZT44JwaRAOkZsHtyEgR2Wul3mQjH7T5/jLPElBu8/HJ2euyE
         iOn5KkO172tIVMcf9bWLX0uedO22K2RyLHswA52BNwzWoFGgQ7cS8R2rsmyFUOmLIPB7
         3zPg==
X-Forwarded-Encrypted: i=1; AFNElJ+X8CBqGOH+iTJmHezrI7BMfUnbEhMVSDbqo4nClo7h1iV3ToNd8eNcZlfODwXlta+O7O54wYssUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+0JURqmgBwF3skM3C/cZcOeoR7o84Ut7U2HxcAaeXrmuk8jK
	nMJmwDTsw4eZvds7Wkgzx5RseNDN1psfTLqXyjEtE+X6bID4MRgXILox5wq62z1kaVMG7RhcMw0
	ahgJezvH0WcrgY8YGQwYSMlTc/Sc07VNGWeM8/8P3ZEnBXgUX7Wp4NvkU7HNqyoE3yiHCEg==
X-Gm-Gg: Acq92OGdGo2vyaZeZFC1RvzGSL/bbGn7//qQMNSwJlbK3j24h4eSuz0qzp8oTbi93N3
	w68Q4EAr9LKUkjENLmh8FV13uCNaj/SRNeGL1sQtqjzIJ+rUFQbHeD7tc+pilOySc6zhClyzweJ
	Fb+oPBUPuAUbvNV68i6k0mezWRL6dBKxftoB3un6qllesNteq6iFj7g2vBGLDrl4F0NBX60Et7H
	/hkaPUal7YQBnX7t7wK0sF1LwcwcCni6lU9abZztsbQgjC5JiKdroeAH0/tRcgarFLWpQF9ph1X
	cDzeq2nuNKfz0ZcwZOemZKFfpHFEyNhfP19/LHY0F9L0F0uXDTgUHGVpvXpxKr6Jex1uFNjfi2y
	MFsNCtylbZGyjn/vPFmxoJqRJG3xN6D0wxzRt1+M5Gpm5uEO3UPDxDcXhHqauBSgEJtM3lZTnUp
	GQc58Y23Yw/y3Sng==
X-Received: by 2002:a67:f109:0:b0:612:13af:f5de with SMTP id ada2fe7eead31-63a3ec8bb31mr438167137.3.1778842480179;
        Fri, 15 May 2026 03:54:40 -0700 (PDT)
X-Received: by 2002:a67:f109:0:b0:612:13af:f5de with SMTP id ada2fe7eead31-63a3ec8bb31mr438163137.3.1778842479785;
        Fri, 15 May 2026 03:54:39 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c23feasm212857866b.14.2026.05.15.03.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 03:54:38 -0700 (PDT)
Message-ID: <02578386-a492-4342-95aa-9cfb00c8bacd@oss.qualcomm.com>
Date: Fri, 15 May 2026 12:54:37 +0200
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
 <bb02291a-1579-4069-b6b1-757a0b5fb7e6@oss.qualcomm.com>
 <ca6c656c-07a1-466c-9c1f-a2efbf1498d0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ca6c656c-07a1-466c-9c1f-a2efbf1498d0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExMCBTYWx0ZWRfX6fxKEkAlMo2u
 z642DzNkO2vXnCtGZo2pDYPYF7P4MBriPiFPFTwW1uV+HcKLLxzIcQXghDMDnpECOYM3Dd48t8D
 o/GlPwbJ4Xcgn3rpSDVWopz8aUvc7rl25VuXipZlCV/csId8YvbALMf3zVXgt5d0YE54Z/z0Yom
 yoPCoqgQaGYm1QuMtDoVO6KbAN8NL5yuY4is9CS2h0yfxKw5mgGX2Qpswy6sw14d7Ej3/TbWMjn
 GLYJdr8LFkbXGVgR8ClfdAi6EdFnc3tOY6ImJY3ge/LHNd/H5a6HmAw1aSmQS7dPEAbgk6LAbCc
 F5KuQ4biwqP0AgkdKx+VhpKcyu24fWgP9mwvePFJNJVBK2OvudH4o29Oo2gRx4fgiHvO/9eh1Wv
 LdR4zzQSJ6ZU9ApD8hJdGhg0uIs7be1EbhSDoOlW6QOUTaDDvpjBpLZjHgZ3rM/2XnY4ftimfyk
 QddALJ8UiEXlEfbj/rA==
X-Authority-Analysis: v=2.4 cv=Md5cfZ/f c=1 sm=1 tr=0 ts=6a06fb71 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=HltSbr2RFzsJciUvgNYA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: 83M-N7ZNv2aIX6BR_JVUuf49odPG2Up6
X-Proofpoint-ORIG-GUID: 83M-N7ZNv2aIX6BR_JVUuf49odPG2Up6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150110

On 4/29/26 5:09 PM, Krzysztof Kozlowski wrote:
> On 29/04/2026 11:23, Konrad Dybcio wrote:
>> On 4/28/26 7:32 PM, Krzysztof Kozlowski wrote:
>>> The interconnect drivers for Qualcomm SoC Network-on-Chip are covering a
>>> basic or fundamental SoC feature: bandwidth management between internal
>>> SoC blocks.  SoC can boot without these, but power management or
>>> performance will be affected.  These drivers do not represent any sort
>>> of buses visible to the board designers/configurators, thus they should
>>> be always enabled, regardless how SoC is used in the final board.
>>>
>>> Kernel configuration should not ask users choice of drivers when that
>>> choice is obvious and known to the developers that answer should be
>>> 'yes' or 'module'.
>>
>> I'd say let's make them all `default ARCH_QCOM` - all of these drivers
>> are required to boot (minus the OSM_L3 driver which is "only" highly
>> desired, so that your CPU's bus isn't heavily bottlenecked)
> 
> So the few of them should not be a module? That's what you want to say?

I'm saying that if you only want to shoot yourself in the foot and not
in the face, you can make them modules

But the L3 driver is required to make the caches run at a reasonable
speed, so that they don't bottleneck the rest of the system's mem
bandwidth

Konrad
