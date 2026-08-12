Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEA430F924
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543161; cv=none; b=eOCc8spbLH6lRxiX5eRdsO8/JOf2HxI2SwI5S3UG19xczjsaQ0MdEFII2H9z5QSN/flrXmlmJlRI+Vt/zMJzma2RGZi8TeNkztPgJH6xYx5yBbGusoio2Hn36PeZFtBYXTqJiUWHWvwVqdEojYTEqPDvg5GwCBCufxYCxFKV4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543161; c=relaxed/simple;
	bh=gIAaw7usTtpVY8l8jWXkfYlYYV8k+zoiz8TnUUqZLo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=qTfNytdwZAiK5OoYE70i3ohT8Mwy+sFO2hciaK7nbhUnTyVbCzDXNeLEBOQ8aJjDpqoqGJitOUz0wO77N7Ge0tFtRQeTb8L+bBJe6L4f0tUK6Kg1WHD+wCqzeLUVrZdvRry+HbXHnlZZltX3AUsBhFrIjkdiA+JepTzZwh99qaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mll+P9or; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z8r3RkuV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mll+P9or";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z8r3RkuV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDbbHE3641654
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 13:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5yGE3vDlilzN6eWX5sTduRrhbOKoDy5+ytcaqrJmAAM=; b=Mll+P9ortUz3Ol61
	Y+ajbBh4z14GMfTFwnKCvWF8IST16ImgtI6ftnMGgeMmmXQUuS/1y0PrVnKCBIS8
	11p0XAt9o3yo2noJxo+WGts/W5IummEaFQJqNd7pmqe4aYg9KaDzVj5kodKcu3DF
	xTOgmWps80UIdCDARchDx6/EXAr7WovbAXSDMB6Q0ee525sC42fhWKe0d8rmiOFc
	crNWU5yIZo4RRexT9bW8FZAbfwEVao0JMMY28aFqcjpr7Vg4ZcakcBMkCuAdIFqS
	4Z+tjPk8RLBsWjvGBJhHZYJxfdSzFyfHHKHAl2oI5Hum96C+BapTqEdiU6UMNIs2
	yKtjbQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0p3d11df-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 13:59:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cacd6d37edso16346755ad.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786543158; x=1787147958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5yGE3vDlilzN6eWX5sTduRrhbOKoDy5+ytcaqrJmAAM=;
        b=Z8r3RkuVJULyt3IG889zC/DpvWVlZXvPw5w7T43seoU0fjBYQVbTbpk6L+IOslvK9i
         tTZiH64qSRd2KdjliaGgq+neFuJ18zeq96+Uv4Ovjc//ye0VC5d81WYBmq2uoXKKpo5H
         pzb/WwbOIrxzhTRFDW0h8YvtEQHq/ifrPPz+hyBpg3rDWkrr9pCwt6SL22vSeWIlCZtm
         124MbAFE1WljvzdpipB0nUufXr7vFXeh7F1cCs8Fbwucbd9MXbzm9iv1Am/8eQ0sgaFx
         vXnu7thJchlZR1+fzNEsRddJiDrsGTqfKHYGxRsJHNoMQ6ZJR+K7cCfinXj7xQ9q2OdB
         gHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786543158; x=1787147958;
        h=content-transfer-encoding:content-type:in-reply-to:cc:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5yGE3vDlilzN6eWX5sTduRrhbOKoDy5+ytcaqrJmAAM=;
        b=Q/4m271L9NebkEgntaF+sWauHG+v3/EG5qOGu6DSOySWeiQsE2riOp/O4e9JI8qDK5
         qp2VI854msb1InPLxpJqrzSjEA/b5Sqlao/3mqnks1mjeOcLrw7f7zs3hNmiYBKfTmIl
         TUQIGFycHCU1jNT3ysF7U+im2j8lVh0Rm5186veUnuOwy8D84yOAaxxvBvFczJjtjsiD
         bZVSqVfGGKyMZmBXqNsAnnOZu7F0VN6sVbbcrs8xPBE7Shprtv3DnNHViVclllIQRR1+
         +ylqdrTlJzcaOh/rpE9iOAy56rj+bXnE3fKGxYR8P10B1puwLKbivyNAdL3bxQq6u6KA
         myXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rog79/SCVoDil7tg5567jNLw8q1CGFnVsPwy3zkpQAcPfwCmviClFYltARMxZUXjEyEgIgWVMRmYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx4Ybvh8ARG0zicR1V9AKWtqEyoXFzVRc1KoefoSeZCOkYtwyO
	gfpSEN1lmLocBxmCgkMxnC6HeQ4/FFpvKsisFAXJJmihyOjVoXIeGbj4ZPa4zXs6tt2kdmG87IG
	LDNMU4D56wSg5FNOl/G7XREAUDXoa+6OYiS/MFfaQGGu0yBiYmuDgyWuTLB5Jer/hKyceYg==
X-Gm-Gg: AR+sD13lR2Nof5FTzwm5/VmwFrYXNN4EatUN/1tRx7FUKM6j0+matBrHwNzeFvktfGT
	B809768Vy8VFbsrljorPEzPFYwk9f+JthDwkyaKC6qlI0QggoQfAJSBDQM9NwDZWEAkjGWX+bOA
	/e7J+2nNfdQNjm2dUKh1VRS4OE3GorCJG/RavWb3Qc4n6vbW+ZK4Mm74lYQsud3IQXZSUKH3YpY
	vk+XJpkAw6PU70Fp10axFpfc/m8Ny57XX7C2VmXrfx6fTZirbWNIlr/ACRDeJ2kiEqlmo6bRQNe
	hYLpM7xa6AUc29Pa/2Z9QYkoj4cXDGmMriFZRehch2mCJYZ2uvNAcoi0Mr49RcosWftPE6PbKG6
	vtuUdSerVMQa5bF+a9JkmyfjbACkaYQKoV8N47+9cd81Jm8AGksR9fRBHsv2a5wmAVBpHZw==
X-Received: by 2002:a17:902:d582:b0:2d3:2b8a:5007 with SMTP id d9443c01a7336-2d34569a059mr64153145ad.15.1786543157546;
        Wed, 12 Aug 2026 06:59:17 -0700 (PDT)
X-Received: by 2002:a17:902:d582:b0:2d3:2b8a:5007 with SMTP id d9443c01a7336-2d34569a059mr64152315ad.15.1786543156904;
        Wed, 12 Aug 2026 06:59:16 -0700 (PDT)
Received: from [10.133.33.48] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d350fb0701sm7221715ad.15.2026.08.12.06.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 06:59:16 -0700 (PDT)
Message-ID: <b375a4bb-2df2-4b9b-ba28-6ef153a89c70@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 21:59:13 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: acpi-cpufreq: Using cpufreq_for_each_entry() to
 iterate in extract_io()
To: lirongqing <lirongqing@baidu.com>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
References: <20260810061045.2397-1-lirongqing@baidu.com>
 <20260810061045.2397-3-lirongqing@baidu.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: zhongqiu.han@oss.qualcomm.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20260810061045.2397-3-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7qlkOHRsj8OX-fWRoK-vX5-HeZSPdM9b
X-Proofpoint-GUID: 7qlkOHRsj8OX-fWRoK-vX5-HeZSPdM9b
X-Authority-Analysis: v=2.4 cv=UfNhjqSN c=1 sm=1 tr=0 ts=6a7c7c36 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=zuLzuavZAAAA:8 a=VwQbUJbxAAAA:8 a=0a-dqdBBcCSYx8TJZcQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExNCBTYWx0ZWRfXy88vvxf5rWh0
 Oiqq1TQ9k3LcDcFC0qlrh/97wMn2a3+DRH8tu4EiwJrYDKBS3Onb5IC8nnGTqN8NAcudT0e+agL
 MJ9XIQlyQjsvmEFoJKr4PvfW9fOs/omPtx4V/oIEsACvCjQluOZcyxctRgAiNlp7bM/l+69KZIq
 Dowpb0Or1a9DBClvvBlmyy6CLdS+LpNH4xqplwRiYb34h7+GLB8IaA9Br1jxW6/LMAr+I0VtbEb
 rji3QVWpMADPrhVIWO0N0CGkAVq7wMuuFWln1GLu6TAe6nSZpqaBjt7PnwUBmzsFH9LZjCtWBSh
 xZ0e1boulOEY8pwz4wrS2xHaJYZLwfXKFwmhtf2r26IDSpx2mb2U2f5MOEy0HMp+Hk50CN9378j
 s74lzfLu7YwNqavQXQixFtY71xD8HxTxhtpzA2uWC4vF1N1Mnv+0t36D16ygr2LkLP0QW8/UawI
 gCNk38MqNAksvJd/kLQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExNCBTYWx0ZWRfX6a80T4Kvqnit
 oeYLoilUelJDfgaUY2pbuE6/uztjaxu/0d76waw1/BkojqKdOZJ1G2elUQSHJBkBQjQor3PUXlt
 wjWIFAphTLm3VO+PI0b80zk4IvkwN+A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120114

On 8/10/2026 2:10 PM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> In extract_io(), the loop iterates up to perf->state_count. However,
> when building policy->freq_table in acpi_cpufreq_cpu_init(), duplicate
> frequency entries are skipped, making freq_table smaller than
> perf->state_count.
> 
> Iterating perf->state_count times directly over policy->freq_table[i] can
> result in out-of-bounds array reads. Furthermore, policy->freq_table[i]

There is no out-of-bounds access. The array has "state_count + 1"
elements, so every index in "[0, state_count)" is inside the allocation.
right? The changelog looks like a memory-safety fix, which it is not,
and that wording alone would get the patch (mis)routed to stable and to
CVE bots.

> does not necessarily correspond to perf->states[i], as the original P-state
> index is stored in freq_table[entry].driver_data.

Yes, the real defect is the index space mismatch.

Might be good to note the side effects of it, AFAICT

freq_table[i] is not perf->states[i] once any _PSS entry has been
skipped. The function can therefore return a frequency belonging to a
different P-state, or 0 (zeroed tail entries), or CPUFREQ_TABLE_END
(~1u) when "i == valid_states", i.e. 0xfffffffe kHz reported
as a frequency. That last one is worth spelling out.

> 
> Fix this by using cpufreq_for_each_entry() to iterate over
> policy->freq_table, similar to extract_msr().
> 

Please add one Fixes tag here as well.

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>   drivers/cpufreq/acpi-cpufreq.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 21639d9..87e4923 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -196,15 +196,14 @@ static int check_amd_hwpstate_cpu(unsigned int cpuid)
>   static unsigned extract_io(struct cpufreq_policy *policy, u32 value)
>   {
>   	struct acpi_cpufreq_data *data = policy->driver_data;
> +	struct cpufreq_frequency_table *pos;
>   	struct acpi_processor_performance *perf;
> -	int i;
>   
>   	perf = to_perf_data(data);
>   
> -	for (i = 0; i < perf->state_count; i++) {
> -		if (value == perf->states[i].status)
> -			return policy->freq_table[i].frequency;
> -	}
> +	cpufreq_for_each_entry(pos, policy->freq_table)
> +		if (value == perf->states[pos->driver_data].status)
> +			return pos->frequency;
>   	return 0;
>   }

One more potential same issue is in func get_cur_freq_on_cpu()

cached_freq = policy->freq_table[to_perf_data(data)->state].frequency;

It is better to fix it as well.

For v2, please use ./scripts/get_maintainer.pl to generate the CC list
so linux-kernel@vger.kernel.org doesn't get missed. Thanks


>   


-- 
Thx and BRs,
Zhongqiu Han
