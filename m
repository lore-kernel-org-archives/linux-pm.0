Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610023B0AF8
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 20:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782333846; cv=none; b=BqP6lUHwxd0A51EAM2gJb/i3oqTbj8XhL2wjFBvZVtYC1rB0tVS9rJjpANT1QRkw062pjAoUiHcK44Lg/Vgo4O+ztmG7yP6HLA+3tI6PTdtWW4iQLV87kiMiSB7XBmccY00hBPxx5cU49kRt/bzp9n7nAEvbcwzhExXynLjeEb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782333846; c=relaxed/simple;
	bh=XJ4dGsHJUWAfPP9ACdPgErGt8PvKQcaQELy9+htVawo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STbsDoJiy7DONWR80DV6PLkpdPfiaB6ky7/BAy2YvYX7mOZTS893ZA8S6BQvcCHVdklfmFiRhFkNVtIk+R3mYDuJYCTkrewvQf67oy4QAXDnCw27GEYxKCC10gmvRQNS12s/PgxvuJH7HCc+MFJD4+ryJfVeGeZJ49z/bkmZFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X0RZx3jI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yb5Wu2XC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X0RZx3jI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yb5Wu2XC"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OJjW8X184807
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 20:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pLVeqNMo6k5dNQBE40/GH1tK84dI6CUW/NiULJrSHBc=; b=X0RZx3jIo5BwEFeD
	0+3mtOd5Tc0wJjqGlW7c0bJeWbrzJcA1TdZDexP8cSqmwkaYfMTnPVHieExxFTiq
	tE2ij8nYdRsrVq51Ab0jwcAf8zzWa3JckIchG+lRMbrPAr3PkAGj3lXlc5gtjws8
	o0Qi2Jo0JhRfO2SCicPzUrfF91tmBp7UbJcVGZ3Q+HYQMFcZRQhiNJkbCbi/V6Qa
	ap2ZjSRae0nKtu+CR121aKeLuDQghdmtyP3HHny2JA+Fz08dOsffBYn0i2SAokSt
	ms/A6YVQ5AhjgTiqZSTn7O2or9ORtfaDOwk0rSnzYGh6fjL3GaD5Pdc9YiiVP2/A
	EMi6Eg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05ajm6d6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 20:44:03 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8db3d8c8c0bso39296286d6.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782333843; x=1782938643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLVeqNMo6k5dNQBE40/GH1tK84dI6CUW/NiULJrSHBc=;
        b=Yb5Wu2XCWH4+qzAJE6Qc0OlReon+7DGvSWfIqVlMriLYzUpuLfrMPthn5WpRqdx9Hv
         GRHXVSXdD5oWqA1k61cCe6Gcz8f9YtwOd8GfBoizvVnhFAZ55PVD7t/NU0DTec2XFJtr
         Xjdu/gRJvNg4ZNLMrmOnz5EoB4PPv+ScPSGQ1E4fh0Pn/pDArtVd96m1mc4Z42CaWvM0
         4xEx/TLF4tqVlME2HTE1hUL/cKZ63nt9oZh3Gy5tgJaprsgTfTbte583MtnJQMZnPIuX
         EZgS04Q33KyLMLV7QWRi+JEimSTK6OHLKXYR/YRmoA56eFWWRQTEyG3m+hk5K90LRRVJ
         AyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782333843; x=1782938643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLVeqNMo6k5dNQBE40/GH1tK84dI6CUW/NiULJrSHBc=;
        b=XqkqdU749cUS6HcQt2JOGvO+DERNqU9X77NZPB+ZNEuYwtaAEghrO2eiIrDx6N13UF
         FJcpTJXsDFPF7Y69nsU5l7AvPPm0VMkmIssssEZqaFA+3iy9lg/z+ah6inV8964UyGRO
         7J7gW/1Ea1MGAzr+SUb9ncKbeKY9KW1ln4RfLfoMWzpEuiNkh4m6iZmc75NKiHiBHwJ9
         6FLw8qiKANn5+4qGABpThViXRiTM+wqWrEMgzJiIwfQrob6H6vmLcJ4rwGod57xoQIaz
         pQ9gfesJ4fVsx8HIMjaYZKO0T41eNATFRUcwxPUzqZwlk9luZD+vfFDRUkbEDTiuDn6a
         LTlw==
X-Forwarded-Encrypted: i=1; AFNElJ+FldwHiR68kcXFc/cXB1rG3Ee2jl3/EY1nfKUBy6/n7TPMA5LYK+RpIus478QyqjpO88ToE2Rurw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwvWbYHxXt7vLFkXud/TjV3/CyEXUbrrmfYqYdA3k2EMNAMOVkB
	lJC1+Tr2Y+B/Esp8TKMT6k7gPAgoatqpIB9qiyl1atdsrOYRSDcPiH+fqiWskCjVnV8e0KdPqMs
	9PKg0sZma1Ik28m2wvOkUAZ5PJm7OIyggYuy/dmw61fRH8ynGfTsrSOiekKZNYpvGbhzYeA==
X-Gm-Gg: AfdE7cm8AHr+ZpPxYe4GV5TL3vHVmnoMbj5/m0QZwXELsxKUnb8kgI/RkkUXKorxT+z
	kL+N7acCxyLeAGy8qTbHaAsTaqYUnBMMmqeK0xwQlm1fADSCN+AO0a9wgoHoRuZe7765FC/upTp
	5cvM3X9OzGK6mQr/Hkr8c8MXcXaIIzgEBmkMmlrPVsnCmjFWy5bBXu6y/5lRqDfn4XHtzJWtW2W
	uaii5h2LRu6OadX59TzhaZILChSDyQVDEW36hDNghcT7UgXey59boVHs3mE1n9YQ/91LATJ9wTn
	FMGOBimrVdEzoCmo/ZECFys55nCUgIgU/uWJEowBL/D0srCY/WBOAPerfnuvrLuTFhcmKdgzoFz
	IzwSZS0S8iV6rLo3DwTvlOEItM2+Kz2tGTBwK1dyxkTgxIMqxJzPZzqbYYdGuysoOc3s8390=
X-Received: by 2002:a05:620a:4406:b0:915:ab83:6963 with SMTP id af79cd13be357-9277c5ca1c8mr822959585a.15.1782333842544;
        Wed, 24 Jun 2026 13:44:02 -0700 (PDT)
X-Received: by 2002:a05:620a:4406:b0:915:ab83:6963 with SMTP id af79cd13be357-9277c5ca1c8mr822952085a.15.1782333841973;
        Wed, 24 Jun 2026 13:44:01 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:fce5:aedd:3ea4:36f? ([2a05:6e02:1041:c10:fce5:aedd:3ea4:36f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492640332a8sm17146845e9.9.2026.06.24.13.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 13:44:01 -0700 (PDT)
Message-ID: <f623e4c2-0007-4dca-a263-04f258e4f207@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 22:44:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] powercap: dtpm_cpu: Guard em_cpu_get() against
 NULL return in sysfs callbacks
To: sivany32@gmail.com, linux-pm@vger.kernel.org
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, linux-kernel@vger.kernel.org,
        elazarl@gmail.com
References: <20260611204658.47987-1-elazarl@gmail.com>
 <20260624203147.67528-1-sivany32@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260624203147.67528-1-sivany32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE3MyBTYWx0ZWRfX9RT87jra4AZl
 dc9znNkCvIOhelWToJ06o14pKIPmNtvh+ao2+60BIT2PwgRXVcCnk/+6tx+6NRbeLEp5L8c/eJ6
 qRZ5kxFcIoYhgx4oIeuX7oQVTb8hWto=
X-Proofpoint-GUID: aHPUwLhmKGPVGC9OEfijMQXiQn_EQ96J
X-Proofpoint-ORIG-GUID: aHPUwLhmKGPVGC9OEfijMQXiQn_EQ96J
X-Authority-Analysis: v=2.4 cv=DbUnbPtW c=1 sm=1 tr=0 ts=6a3c4193 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=K0DscR3ZS1O8UFz_HAoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE3MyBTYWx0ZWRfXwiTY7U60Ddp1
 nLyniq65UxdpIvSQtZUK323mcCIPIVIx53sv8TolRWpk9SpV+gMENeDmrjwFK5yj49f1QD/r99C
 ASulh/D2G5dCaj2P9anvslJ7m2jZO2W46H6826kysAtgoQ5eD7lTPYlYL6m/mHgbr0fnmvyS0XQ
 PZ6Ms4i7tuWFxZnaHo0RFtbo96AT4w+Rb99TlBwk+Dov1v3n7np32qcNkYlBtUILXXDhA3mrjLO
 XSP+k45De0qXbWjoH+4Jr1IJLbnV0qQ+LRY3TLmmXb11W6OOpq7tz7xn0FtCejns50EtM6yB9Mb
 VdptcZ2Lot+VHoCqpMDOlu5nSrgK1jj8NyxvCPBpRxBBssEANNUBpKCBHseXDX6/4bj8Jzb0vuf
 AXwAm4VNTNUjRf63wDZl/WmHGpfLe2tpodjBPPiIB0oyed25ZmTJobYw7LquDAEEPIG4+g+A92f
 oVGeht1/yOteai3cBJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240173

On 6/24/26 22:31, sivany32@gmail.com wrote:
> From: Sivan Zohar-Kotzer <sivany32@gmail.com>
> 
> em_cpu_get() can return NULL when a CPU becomes impossible. Two call
> sites miss the NULL test:
> 
> 1. set_pd_power_limit() — reachable from sysfs via the powercap
>     constraint power_limit_uw store path. If the CPU has become
>     impossible then pd will be NULL, return the current power limit
>     unchanged (no-op) instead of crashing.

Can you provide a script or a recipe spotting these issues ?

> 2. update_pd_power_uw() — called from CPU hotplug handlers via
>     dtpm_update_power(). While reaching this with a NULL em may be
>     technically impossible today, the check is kept for defense in
>     depth against future refactoring or subtle races.
> 
> The other sysfs-reachable path, get_pd_power_uw(), already has a NULL
> guard returning 0.
> 
> Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
> Signed-off-by: Sivan Zohar-Kotzer <sivany32@gmail.com>
> Co-developed-by: Elazar Leibovich <elazarl@gmail.com>
> Signed-off-by: Elazar Leibovich <elazarl@gmail.com>
> ---
>   drivers/powercap/dtpm_cpu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 21355db64..886cbe922 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -47,6 +47,9 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
>   	u64 power;
>   	int i, nr_cpus;
>   
> +	if (!pd)
> +		return dtpm->power_limit;
> +
>   	nr_cpus = cpumask_weight_and(cpu_online_mask, to_cpumask(pd->cpus));
>   
>   	rcu_read_lock();
> @@ -125,6 +128,9 @@ static int update_pd_power_uw(struct dtpm *dtpm)
>   	struct em_perf_state *table;
>   	int nr_cpus;
>   
> +	if (!em)
> +		return -EINVAL;
> +
>   	nr_cpus = cpumask_weight_and(cpu_online_mask, to_cpumask(em->cpus));
>   
>   	rcu_read_lock();

