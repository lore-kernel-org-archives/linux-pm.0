Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606B35DA42
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 04:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297806; cv=none; b=eywdE2+dJnzgCg+++r4bhu8h7kcasysZkRT5eHjcOq0bmalLPn8rAJ3CmvlJLKsyjE3/iievrNKjB4MlX6ufam3w8TGtEM5Ja/8M3uvvliGu+3sGIWoLUYeIb/oas/8zMCMPCff9OBOWmmfqxO/davqVlu9zT3C9Nt2jCFoYAwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297806; c=relaxed/simple;
	bh=LBr3NTXV2yzRBMXWtpv4voFp79Ly8C77AyFyjo5ZLXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffSH7WeJv9yVAVKtK8Iv9jy3cDU2MTpLzCpoK9uFsTymFy27qvur8hptRfZrFytUIOVrJgHJl+HfsKzqus6V3YfXIWup4vF4O+NqFg8zM8vL6TMXdG/kr4Okj2C316LxT/2ucngsIRa4T9NdXLvyJKb4K+vQ3+o/V2klQrhOyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X38jvpwl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kBhJjQ/6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X38jvpwl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kBhJjQ/6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T1Gw69481766
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 04:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FHWbIXuzL9cc9qmYkbMUa7J+mm16JcP+5CU+h9BwBJw=; b=X38jvpwlqZa8S7V4
	p8TRh/D78I/Rq21eC8E83wUet2XhBqTE8HLatZo+SHukS5U7VgLpDSQ4sMOqElCc
	7L+w/Ipq4CHl80RLNWp+aUCPTTwSV+5A5Kfc0DSi/R3iob0rHWvA9uaa+xygahRP
	nY7SZUj1qX68xORtEj2g4dN1ezOuMuG50bqMWirhbKp2j96e34K0uORi7e5liJtE
	7bD+5ausUh0h+EF7lyAgRioACAH6E+4H5Yks65IAwkIYlwWT56yeBmPtpm+uIUaq
	5ib2wdu6Aoe16ZNuKbBXHLzFN2W5DTX1qQfLcGBlzRcNGIMakq5Z2kKWtumhIFAx
	KdzS/Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fq0q6t33n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 04:03:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce7dff6253so15747275ad.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 21:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785297804; x=1785902604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FHWbIXuzL9cc9qmYkbMUa7J+mm16JcP+5CU+h9BwBJw=;
        b=kBhJjQ/6LOJpkBC4bnQca+gKYs86sBB2cpVOe3N/YGyG/uyY1vEV3ieU2vG7J4/9Xh
         0myYCkzOR+ImJPXkdryYnmTVC5udCFxUSMBJD/XLU7XIYlHveTlPCn5gxInyRaDwvxxy
         klpuWofLaC5Mxs91eMN17ADVXlvylwaUJi8YjLd5zrH062Aqwv4QIlOWMMwPPTGux9ww
         4hnOWOFsmjRWim8dOb0LQBHF1TeipxPFUzYpEK/EfdL70pga+DeHgl80tjY9vmxL8fep
         rjO4i7n7KiKY/TJV8qkuAgE3vhQEaTbhrJyWbQHF67taJQxlQBH7Iw5y3xiShvD+smk6
         Xq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785297804; x=1785902604;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHWbIXuzL9cc9qmYkbMUa7J+mm16JcP+5CU+h9BwBJw=;
        b=JIbJYcgEHMIMoZCR7Y1ivJFxlhlNj4eqjZIe+faZVl89Pz5kTRzWQ1dMrP0PG1Gb5m
         iJRHiAe93Plk9ykkfYez36yq2jkM8PYOIBDeagnUoi2CTq2Y7KeprnKVXvdIDnwOK4Ci
         ZJm4SXyjQjKXiTP3dPcD5JwXQ6mImZM/MnPoaaTE265AcWt/7VQGVeMnOnNEhV98VTcJ
         b80DhSQwDt7KnNLdHXZo+PTNn9NHFbcxhaxwx0VNCdGmZ0ygI6IvI7fZGXz9jxrA+Pfc
         E+Z4gKRsSp88mbOMHfvW4WeOss08fEd34pLOK9xEbXw3hBBkC+vXzaKDGzb57EcaR1Kr
         eXig==
X-Gm-Message-State: AOJu0YyjJOcz3OJE5PlHJKM4s48dh9J8iWQx8NS2PIDbvq4Jv5bggWC9
	8UFNlBVjoN64stz0BZStjfoNBcfAjcROEkYa0ADyI3LNVlsqIGVKFyOsromQMzUbSc9zkS5gSqj
	jTtHhDWXdOspXlLfY1AOydsk/DWZZWGCcQhLkLCcwcTSMcRFn5Vvq0SKpwLqBjg==
X-Gm-Gg: AR+sD10xPJQ47V5jWaRLdzLI07vhPG96G4SJNEKz7aWzH7nMJad/74FwarRSuUpjYK3
	x2OCF5gJjE8HOhDWqPS4fbKGkfSMUSbx0B7yf242YTmhsFJq8lc4go5n/sACHW5ezt2xsusaJAm
	I0hfcAKtH75ZdiH7J1M5u/x/YIu5pmYmU/iQ1FjUQqGLcESC4m9hs+k2nwBLYlgQxuDX25yutB8
	8gQ2XkqVOfEw/o+TfROmBbL4gSVi+F/zZTtfjX3IA3mOvqcB2uzTULdDkySh0hcTPG5dwLlwKvx
	OHsB1EjLN01MJhsEUzbmZ/p6vPofUSZ3TF/yOnADQaO5qhw7XC01mt/AWlvbVm68qthBSHaU3nQ
	PCN8+5FGHgGjm6w3ZUHcHrMq5iYsMS8EBln7PKJ3tCYf0JdouXoCeRKWD+B+/ovHEY2c7ESY=
X-Received: by 2002:a17:902:da8a:b0:2cf:bbdb:425d with SMTP id d9443c01a7336-2d0267423e5mr7837965ad.18.1785297804220;
        Tue, 28 Jul 2026 21:03:24 -0700 (PDT)
X-Received: by 2002:a17:902:da8a:b0:2cf:bbdb:425d with SMTP id d9443c01a7336-2d0267423e5mr7837035ad.18.1785297802623;
        Tue, 28 Jul 2026 21:03:22 -0700 (PDT)
Received: from [10.133.33.87] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a15199sm4667385ad.17.2026.07.28.21.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 21:03:22 -0700 (PDT)
Message-ID: <1c655514-4595-4d3e-bc87-09e4f8415f3f@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 12:03:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: Gate desired performance getter on ACPI <6.6
To: Christian Loehle <christian.loehle@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        Jie Zhan <zhanjie9@hisilicon.com>,
        Lifeng Zheng <zhenglifeng1@huawei.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sumit Gupta <sumitg@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        zhongqiu.han@oss.qualcomm.com
References: <20260728160538.2574100-1-christian.loehle@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260728160538.2574100-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1E6w1oz8z9e1igsB3OeQhWxyNOsPb7Mf
X-Authority-Analysis: v=2.4 cv=DqpmPm/+ c=1 sm=1 tr=0 ts=6a697b8c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=-CsNd9vw6T3jYN4hrYMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 1E6w1oz8z9e1igsB3OeQhWxyNOsPb7Mf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDAyOSBTYWx0ZWRfXzkMdZ+lBy3gH
 +OQxTZUT6f1BManLKo5KZxzX5EiA1KBCdQ7J8QPYd0xh3hs75rlxDA+buVxOK/a1EceA+uf2eWb
 9sqypsgQNhOSeYXBbmn2VLSiR/k5GQc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDAyOSBTYWx0ZWRfX9tq6hfVb6GKe
 qS2uZ/rpfMTJM7unXH2KhvDqhcnXLsLwb8TxxIWQkybzn1TFr5vVXZcntxXsxUdUEwodwRaJrlT
 P6+d/rnPljni07xMB6Od7i2YWoxReC22XPG9t7hs53vQQzmrLtwhtzYtDsG9AqlSJRkuoCQ013X
 vmXS4U+Obz8JNonfsTIi3vfAAF4wDFFD7Li8C0YRpZCYiKv/fzZQqG1PVNHeKX++AZYU9DjzyzG
 AkBPNwMFJNJo67CqOnQABgVA720Na1I0N9vfOhgN1nJQgBa2hyvoMdbMGMPBxy4ZIPHZog16xdB
 Is4lcl8H67LqEW/DFPU+iH8vsxPjAmcDfYCTVWWH3t0DBvlkAM7wbaeHZAkDUn5KHaqodZhuYfP
 NBr7R42TlHyQN21CluRtHKnUs2cluBMotjTJDfS2Lmm5e12XKtf1zfgvcu9d1x5xDdkM38zuEZa
 prYcHZFIadTrm6N5Tww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_01,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290029

Hello Christian,
Thanks for the patch.

On 7/29/2026 12:05 AM, Christian Loehle wrote:
> When CPPC feedback counters cannot provide a usable sample, cppc-cpufreq
> calls cppc_get_desired_perf() because some platforms repurpose Desired
> Performance to report actual delivered performance.
> 
> ACPI 6.6 changed the register's Optional Attribute from Read/Write to
> Write. The existing cppc-cpufreq error path now falls back to its
> cached OSPM request on ACPI >=6.6.
> The original (and existing) workaround was for a specific HiSilicon
> platform which isn't expected to report >=6.6.
> 
> Fixes: c47195631960 ("cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged")

missing S-o-b? 🙂

> ---
>   drivers/acpi/cppc_acpi.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 53d09ca98f06..218fdea09c1c 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1321,10 +1321,17 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
>    * @cpunum: CPU from which to get desired performance.
>    * @desired_perf: Return address.
>    *
> - * Return: 0 for success, -EIO otherwise.
> + * Return: 0 for success, -EOPNOTSUPP for ACPI 6.6 or later, and a negative
> + * errno otherwise.
>    */
>   int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>   {
> +	/* ACPI 6.6 no longer specifies Desired Performance as readable. */
> +	if (acpi_gbl_FADT.header.revision > 6 ||
> +	    (acpi_gbl_FADT.header.revision == 6 &&
> +	     acpi_gbl_FADT.minor_revision >= 6))
> +		return -EOPNOTSUPP;
> +

Just for context, a separate topic: it seems that cppc_get_perf() also
performs such a read. However, the value is subsequently overwritten in
cppc_cpufreq_cpu_init(). Since this all takes place during
initialization, it should be harmless. But It might be worth cleaning
this up as well, in case reading a write-only register leads to
potential undefined behavior?

>   	return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
>   }
>   EXPORT_SYMBOL_GPL(cppc_get_desired_perf);


-- 
Thx and BRs,
Zhongqiu Han
