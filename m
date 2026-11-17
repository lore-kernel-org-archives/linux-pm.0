Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914158;
	b=q5WeIsO28qDeO+bLxQL0JdjhF7T1HJ4a5vbDx3MZoHpMlT2vvNY0cYxq6LUb4AyIQ3xO
	 hudQ1ynDaAZ1TSwD/fZ7B438gyJcybkLFgUnhuuNtGObCm0QQGW1iPrUwYP9sXcfHKKRV
	 ZSNIzv7BTPOMt64Ciuf3qOEkdrpobJ7EQKpOpUpQzxQYZDgAHb8g1koC6b1FXlc+CWkWi
	 LPfQrEBsFmHHbpo502U0TlPx/wmSxfxsRbc/dvrKT6Fditqfwk6EPPuSiyKFLwmI851Cm
	 2QTMcQO8DnXDBt/QEx6j1jjcpXuhSoRkul62pf8RqvsKjE5pKAQKnLLkEZPc+VsBeSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914158;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:
	 Cc:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HHdHq7Ji7DMycZeH+hVw1u1jAedoxZ+4tveWgOn09GY=;
	b=vnV2JBoeLOcI7zhvZyDA5Va41cGTL7IoEOsN322YXBT4riA1MXhKnTHQNFG2Et4z13um
	 /E0NMWXIlWozIOrbLMcYBIPCrQNRB0f/+o5zukvGfb+YaJgyqQ9TluCYpwV6ManFXTuiD
	 hMjN2YRT1G7Z96zjf261KQlHl/qlSdYrJ881edPjFRuTYtjUCXNb37hRXudYBMq5XP6u/
	 EOw+Y9FjkMvtSYqfdi0a/7+e1g7xLYiR7Uz8H74o/3IYTFXHl7rCUcI/Qf5VQm2jDXlSM
	 rpuIZhr+5j/0tVd7tydfGbpKfbIHuKPaLoFNnDIVbtLOw3tY5pH1PYG53j5oUt+YXvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=evyOwwou;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uf7VORew;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC33606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 11:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFC33606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=evyOwwou;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uf7VORew
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AH8lXiA3624134
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 11:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HHdHq7Ji7DMycZeH+hVw1u1jAedoxZ+4tveWgOn09GY=; b=evyOwwouHddq8d++
	kdjK9QVc+lA4fNHFpTatVInPlr+h5OujuMzH3MgZjqgJnlDmhvyLihal7H1v/Guz
	KK5bQbJL2XUmeFpUB4qyBEn2Gebe7XJ6mu0E5AQ62zAGNuIB6GACCw9X4VhHwMq+
	6evfMAXbtJ2FFk3Ls/cU7532KAi+AygcNVzg9s5FeuyOrz+OoY3NeQ6FicRYq/IR
	47Lvuv6in83CcV4EtJt/zcQWkW8OmHSK8QzEGnTnWdB/TItqwEm01gdw2qt5SLVy
	Ah/IOm6pDuAHc9JlhuqsNMugCI4XLWbPZABcE+08vLY1lhUTGrRsMqPgaL5nCcTA
	kPLWog==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j07rek9x3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 11:15:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e9501034c4so66370795ad.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 03:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794914156; x=1795518956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HHdHq7Ji7DMycZeH+hVw1u1jAedoxZ+4tveWgOn09GY=;
        b=Uf7VOReweuld+nE+bqk/R3JipnqeXuXWPXDNuQSqu7MJM47xj++LFgGjFrmE3yi+SN
         TMu0nSVregMXiirXcyt+d+s74CBGZhGnymK5khG2h5HUNi7/G7cJrUpW6BSQkB6Rwphp
         dJ+PIjkwvATPc1kOXfmiNhOgwRaI4DMwHkq79nyF9X4v2ZmrgMeY5VN32Akm9ifQwbhY
         WYTIjeT+Uz4bR+vbFLaLsmuZllsCnGe6IaIXh6zfD0MewPwQo3wY2X9Dh5sdfaYIKx9C
         VzBzbamoGR2ihz8nQUK/rv03hiGLDMFC1BuYI7jyxt1vj8HZzaAGSm9XkO6abFvpwdBT
         SFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794914156; x=1795518956;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HHdHq7Ji7DMycZeH+hVw1u1jAedoxZ+4tveWgOn09GY=;
        b=r9xuQSEM1MrL4QomqBxt+35C9NxwrRt9vYZxJ/KHQ+HM2Poe4SGAVAOClBBIjbvc/B
         mdv4fibZX694xB1wAJ7TpXQUlEkPOXQz/DnDC67KK/P12sszRwwUgy++mue8T7lpOI/z
         8i8uZVYtoPgb7jzH6QOFdzGR0wP0nmJrnVX486EnLiqXdbos7oobk3GN8vFUQ1pjUCb3
         S0zxW37cePYNRysmo7bZRz8uLDgUoZUCjpA9PmkSyn8r6NNiiFkDxcPljZzkEzVJ0Wp4
         13Yvdxex/s2sHTw8CrqBclHqupWQ8r8KMfzXahlEKMsJP37xj82tq/apy9JI2TrI+KWm
         mZlQ==
X-Forwarded-Encrypted: i=1; AL+hErGNTiOlj/M0iTQlFnZBf0QU3fD2r+WTDVtgsL6z5o6wCYzV6sr1oFXjZcLyLp7qjf+ON008Lcf8ww==@vger.kernel.org
X-Gm-Message-State: APuU4Z8OEBTJHMR/h10TAVDGC0V3ZEjlDK8QUyrzwSqpZFLlUPgch3D6
	J2TTtb8bLQiJaiUNO9CXgBtaQypx9EBt4QrfDA7OehuLAPQ49XtX3KVk3ItrsTWtgDlyYMtscZb
	G9LyLVGqsOMlMunc0UkQrJJcQ+ty2KeXYqctq3RxXkfrL+rn9iHunXSb1FSL/1w==
X-Gm-Gg: AZFdTZd9RA0aRVNyAVN1+dYP6zQMrN6G3bQ0qVMh3SgAvNa1YRWSGEoSVuO4os21zJj
	qVjEwxNNczCvtSV8wHlBRvi4D50gCdBj+rvKEgjJJvSlQe8CWnNH/EXvUp1cb5+LOdpy9acn+re
	pznIGK39lvzUngQc9K4sklngrKpIY4baEg3GHi986ct35SgxRYSLPY4V1s2T/QAnh8rsB+766nL
	dFOVHCUVYkS9tiNm/EG5wvpQyu9CVTcB9TKudE2LT+vC7F26xq/niDVBznbJgqszADz7uqQHdjs
	f+4wgYQHiHzvtIWRltuxBHhKIbE/68jRMJVO9tT/3Ia0q4DrIE/lEJ8HGIgK9BOg8cs8EAMXHqH
	Dg/YZ4FcpluaYmfifEmcb+esmr96GIAM+uzQYkYuXEAJG8Th+2nPBpICJ19cFsGgBpPkAC/2QhY
	JSUzUCffHieybB6NlmcKPPRa3Zn0/0JqpTvi4k3bMSzL50
X-Received: by 2002:a17:902:c406:b0:2e9:3dd0:c8d with SMTP id d9443c01a7336-2ee0dd2c328mr136470445ad.14.1794914156375;
        Tue, 17 Nov 2026 03:15:56 -0800 (PST)
X-Received: by 2002:a17:902:c406:b0:2e9:3dd0:c8d with SMTP id d9443c01a7336-2ee0dd2c328mr136470195ad.14.1794914155885;
        Tue, 17 Nov 2026 03:15:55 -0800 (PST)
Received: from [10.133.33.107] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a58337sm13631735ad.45.2026.11.17.03.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 03:15:55 -0800 (PST)
Message-ID: <d77a8540-b1ef-476c-b03c-97e4483f71c9@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 19:15:52 +0800
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] cpufreq: acpi-cpufreq: report filtered-out
 P-states in extract_msr()
To: lirongqing <lirongqing@baidu.com>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261114140724.2336-1-lirongqing@baidu.com>
 <20261114140724.2336-3-lirongqing@baidu.com>
Content-Language: en-US
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261114140724.2336-3-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA0NCBTYWx0ZWRfX5PYYuqoLl1om
 ckAg0LQEQ0Ry5qz1EZldxEXq4473bbjdR9UM2Y2WqBb+eeehzHW2/EWkP0J/u4f9wrbCxvhBz8o
 gcN9Z+NOjz5K9APZPiMxfAr6mvZ8bBw=
X-Proofpoint-ORIG-GUID: 1UKqWZxoQd-JfcRcBADRH7UCBGzhio6j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA0NCBTYWx0ZWRfXzopBQUYN1ykw
 sN03h6kJcg1x13inm6ztTogmm0vcIT1GP/nyTImV2m1KtRoNt6lsUaf5NZxr/x4n+SK42dIrtmV
 prKR6WJqTRDPYQU+B+bwu5jkrPrQ5cxtjl2scxzXKne3RyBDsSTj8TF5RJfORDJyXV916naz6BY
 q6zgjXkirMnLHNwf2U/M15gR/UktLA8PQTFesIQfWM2O8oJolXObGX3sq+k+lVgSgGeCPN+TKHn
 MuPsJvicWxuDb5f7n1Zf/kj1u91gqqFUcj2Ynkn0IMiRpMZAJB1qSZAv1AGxfP5UCtXB9MbOOm0
 vyDXIeK/K7N8qJKBlZ3/LwvCrMnjwXg3RQfnKAN16gayMVoPip9eTioVMcXt/0K9QIvRT1V4l90
 jKo1J1SSVajZuQFdLbnVbRywRJZGoKdth5INN+N4ByYJYFAtlDdspVLtC+7IS7TKi7BHCOH2rfa
 q01wi8TU9WCwFdxGK/Q==
X-Proofpoint-GUID: 1UKqWZxoQd-JfcRcBADRH7UCBGzhio6j
X-Authority-Analysis: v=2.4 cv=R9uWitRX c=1 sm=1 tr=0 ts=6afc376d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=Tau1HEJIAAAA:20 a=zuLzuavZAAAA:8 a=4OL0lGWpue6yjT7UbLsA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170044

On 11/14/2026 10:07 PM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> ---
>   drivers/cpufreq/acpi-cpufreq.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 2d7d147..3dc7ee4 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -210,8 +210,8 @@ static unsigned extract_io(struct cpufreq_policy *policy, u32 value)
>   static unsigned extract_msr(struct cpufreq_policy *policy, u32 msr)
>   {
>   	struct acpi_cpufreq_data *data = policy->driver_data;
> -	struct cpufreq_frequency_table *pos;
>   	struct acpi_processor_performance *perf;
> +	unsigned int i;
>   
>   	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>   		msr &= AMD_MSR_RANGE;
> @@ -222,9 +222,9 @@ static unsigned extract_msr(struct cpufreq_policy *policy, u32 msr)
>   
>   	perf = to_perf_data(data);
>   
> -	cpufreq_for_each_entry(pos, policy->freq_table)
> -		if (msr == perf->states[pos->driver_data].status)
> -			return pos->frequency;
> +	for (i = 0; i < perf->state_count; i++)
> +		if (msr == perf->states[i].status)
> +			return perf->states[i].core_frequency * 1000;
>   	return policy->freq_table[0].frequency;
>   }
>   

Walking all of perf->states[] may make ->get() report _PSS entries that
acpi_cpufreq_cpu_init() deliberately dropped from freq_table[]. Such
entries do exist in real tables, e.g. Lenovo Legion Y9000X IAH7 in
linuxhw/ACPI [1][3]:


   2600 MHz  ctl 0x1a00  kept
   2300 MHz  ctl 0x1700  kept
   2400 MHz  ctl 0x1800  dropped
   2200 MHz  ...         kept

If the CPU can end up in such an entry, there are two problems:

1) ->get() can return an unlisted frequency (2400 MHz on the Legion).
    At policy creation this leaves cpufreq_stats permanently stuck.

2) A dropped entry sharing its status with a later retained one is
    matched first, so the retained state is misreported (theoretical).

I wonder if we can keep the existing loop and only fall back to the
dropped entries, restricted to listed frequencies:

```diff
@@ static unsigned extract_msr(struct cpufreq_policy *policy, u32 msr)
  	struct acpi_cpufreq_data *data = policy->driver_data;
  	struct cpufreq_frequency_table *pos;
  	struct acpi_processor_performance *perf;
+	unsigned int i, freq;
  ...
  	cpufreq_for_each_entry(pos, policy->freq_table)
  		if (msr == perf->states[pos->driver_data].status)
  			return pos->frequency;

+	for (i = 0; i < perf->state_count; i++) {
+		if (msr != perf->states[i].status)
+			continue;
+
+		freq = perf->states[i].core_frequency * 1000;
+		if (cpufreq_frequency_table_get_index(policy, freq) >= 0)
+			return freq;
+	}
+
  	return policy->freq_table[0].frequency;
```

The first loop is unchanged, so retained entries behave exactly as
before (2). The second loop only runs where the current code falls back
to freq_table[0], and never returns an unlisted frequency (1).

Note that what the second loop can find is then a same-frequency twin,
like P1 on the X370[2]:

   3775 MHz  4590 mW  ctl 0x0  kept
   3775 MHz  4050 mW  ctl 0x1  dropped
   2200 MHz  1980 mW  ctl 0x2  kept

There the reported frequency is right (as is today's freq_table[0]
fallback), but the twin may run at a different voltage, and since the
frequency matches policy->cur the control register is not rewritten.


Hi Rafael,
May I ask what you think about this? And please feel free to correct me.


[1] https://github.com/linuxhw/ACPI
[2] 
https://github.com/linuxhw/ACPI/blob/master/Desktop/ASUSTek%20Computer/PRIME/PRIME%20X370-PRO/22F59A67504C#L11328
[3] 
https://github.com/linuxhw/ACPI/blob/master/Notebook/Lenovo/Legion/Legion%20Y9000X%20IAH7%2082TF/CB118A4005F6#L135790


-- 
Thx and BRs,
Zhongqiu Han
