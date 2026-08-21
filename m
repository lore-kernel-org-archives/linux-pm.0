Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E8A3F7873
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302453; cv=none; b=PR/MPu/+4C/of7+lPxdnZuFjWxVqIYEMvtm7aeq7mwzFBdbhBY5eprBJ/81U9OdfkJpgpOHZ3XBun1qKSGOrC3Q+Tw33Skj5sBXfAOAC7p4oB30DdUjfq0TBc+gcBGRhe70/qjDJB+fzYVjkqc3gNlCUEXbgqFbZmZfg1ePk+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302453; c=relaxed/simple;
	bh=YoxTsBu/fJRi+jVK2pRw9v3Av+hAI9x69B6UIBkZg90=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ChiSOS9VTkDndbf/KTkSVPa1YZG9rIQiXYvRZOxlqMREBynMum9lUsZBPyKrl99slugXzx9Ujkg5nQBuCtur6bW5UXhB65iF88TuvDIoZ7K7CIIowsQh/LYVF0ao/t8S1wkf8bFUtoO5jY0IhY5myzfWNLoSdK0VN8tdHpbJv2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Du65s8YI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bVdnKUtb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Du65s8YI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bVdnKUtb"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L8WtgB2215287
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aVzm8sO0NG4UUDGzojl/Qyf2ZqcZXs17qL4O2s8RJ54=; b=Du65s8YIGo7zKonb
	OH10HrIgoNej1BmTDOzWBqKBC5qc3GqosATs3L0xGfsYk7FmXwGUgoEK9AoeYlFz
	fEQzuqfKhRYq23N42Dj7zk9BpiLjeGq5J8eNGHJqTmmibVh3+XSyPHutWY5H1jGm
	wR1gFQ7uACpI3uSAh9/uvwViJCRWikE++EZRprXm579gVgiISGanqRtgiBAg2gQA
	0mg7SZUz6unmtdjFAf96jP+bBYgocarpHPUgPuA3KOGtOLbdEuBrrjakKb5087kM
	gHcP4Vg8KsIx+zuCUHDhrUDrMVlzi2nT0glDauudc4Nht2d1ByWW1Pl8d95rld8b
	Z5kMrg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdf0rng-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:54:10 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb5cc1e139bso561531a12.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 01:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787302449; x=1787907249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aVzm8sO0NG4UUDGzojl/Qyf2ZqcZXs17qL4O2s8RJ54=;
        b=bVdnKUtbvtVO7YucitczM2caRo2rPc0EJGeuQiFZm8DHQQArd7tqcI9daSEAve/vev
         PIsqkKuu9kYVOtg5dBjEH4gGQpPaGvGZ8JbgtrLFT3SosoaL1+c2CBlv5bMo09kfqCgP
         6nWsw76UpA4EMGdu5a1A84SlzkhTqMYtDDF2hnl3oipBJGXJlI2qYPCtNd+vj0TMq6Tc
         gWHScHnETyceU+FkounklfDiumiC6FZy4c0G19l+PC9KrzLPei4L7gNmTDMXwnc0Yb/c
         sF3FGDdr6ccwZb1Tx+d3imH37dhEMdqIbzTvEMMHuP+JdOuv2YCKZP0KopvKLEw4C1r7
         hQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302449; x=1787907249;
        h=content-transfer-encoding:content-type:in-reply-to:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aVzm8sO0NG4UUDGzojl/Qyf2ZqcZXs17qL4O2s8RJ54=;
        b=dOJlYDfd00LEHAJ9AeoOJGWdqjTW1lT8P5bNqBabCl7Ets4lk5CHipd4lMQDTBBWud
         vve2ex/7McN4irVK03KnTTbbKE1yyxzDNh3HMWHVhEzUq1ba8ZuiXfq3a1hMUuh/kNZj
         4vpGwvxjqujntPi2M/tR2noLbgJ6TUdHb2eBogX+54uVVJW5p5ur8xcaFPuIj53nk8Hb
         L0L89m7lvP5HAgT38DkAGY5jBsOQVakXJGFwInWze9nwKE5VcgUJdaP1tAglG9auDDPV
         oGgFG+pDMKjZAKh7gKEQ5D3KzXbQsssz1nyQDnB7zw60lTKuHEMqZ+eK96cYd12M4pwC
         0Rog==
X-Forwarded-Encrypted: i=1; AHgh+Rru6AEmmiZbQiW1iUDZ14/4UTIreOtHHTvC9GUYlPZJ0Y9vYOINyQ+pu8rsaw5KfOkyo+1Jmx/8hQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l6GfLEIWIaI9nQRDE2TGGfup8910zY85Do8gA4MJaaKNE3WL4a
	9levIpj+U4+HxXUlOkz5lux1SzE3g9Rmw6hmjBCxhZZ7lqhYhzkx28HF1+3/eGDohBooqo8OOn9
	mhjs4oH9D9FBGgEhQUaYpopNwZyF3Xon7FNLbEvNVujauV9H2YMpp38lJzGjMMw==
X-Gm-Gg: AR+sD13WMc17UFkhxOa7UBTt3zW5CQP32ipHX3xO6I8npAbFMXZwuMrr/piAe+xJltJ
	G+rJ6iIRgPOJX8R2IqUKNCt+lFl5X04lpw67I2IQ6ynHjuA0Ct5/ve+8OURgdxDktfMgTOftNRX
	VNDFA+/m6sLoJMfX5LLCOl9I5YYuHQTBB5BAY2f6W11PiNv5H2kE4uoC/tzaxQa/ofU3lltdcqO
	kvBSNIqjn+DNjqtp4L0LO+3Nrpy2Hsl596Puouur2aX3NKKtfgZxm9s+l7iDjhPygeqzEfnzT6G
	zZtJb+STsSUm2rwehcMcjVHmrY1HnskxCW/XUeMLA4THwl2BTNrMl8gIxozQTaKsrEuS0mbRU2f
	LhIw464mP4gymvc4siuXizJ32G+rSW5hMVjKmVGsROqSQnCet2HbfhSk5wW5cEWI0tdz1uQ0=
X-Received: by 2002:a05:6a00:1c86:b0:846:de21:3da4 with SMTP id d2e1a72fcca58-851f9cc6dfemr8284604b3a.3.1787302449207;
        Fri, 21 Aug 2026 01:54:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c86:b0:846:de21:3da4 with SMTP id d2e1a72fcca58-851f9cc6dfemr8284540b3a.3.1787302448740;
        Fri, 21 Aug 2026 01:54:08 -0700 (PDT)
Received: from [10.133.33.51] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3362cf8sm2755115b3a.4.2026.08.21.01.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 01:54:08 -0700 (PDT)
Message-ID: <ac9f1882-614c-4750-9096-8ea88d494c85@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 16:54:05 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: acpi-cpufreq: fix P-state index mismatch
 in get_cur_freq_on_cpu()
To: lirongqing <lirongqing@baidu.com>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260820020715.2344-1-lirongqing@baidu.com>
 <20260820020715.2344-3-lirongqing@baidu.com>
Content-Language: en-US
Cc: zhongqiu.han@oss.qualcomm.com
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260820020715.2344-3-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CsqPtH4D c=1 sm=1 tr=0 ts=6a881232 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=zuLzuavZAAAA:8 a=EUspDBNiAAAA:8 a=X-4reRNKfApO1qCbSG0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2NCBTYWx0ZWRfXwz3U+w8qtFOH
 zX2Ypo/fAXDIVuw6FE3j4xJJVTqPRhKEKP+pM0cJ51NHU0lYP13ebFUWilc9G9og4kiqgwt9C0d
 DTLENJPDzi2RTbdt9B3bSvfkMXcGQROsaZX6V9rjJEN7yPeAMvDfeaBvDBgMWbbljQtsEyfkyQp
 c/lRYwy05+7GI3y4NNHGl7p42diBDuq4twFyVXS2RHAU8h6GI7p71wGQKrIyFARJGIs6lXvkTsX
 C9yOwSTVo7GwCwPaFQTEtzyehr5WiYZ7YGUEMj9O1JfEMZCiPGxd9MhpNE+aXu2L31cQ3vtV+s1
 vovvDh6WZDSWul2bszMIvuF0DW3wvms3i1aWx3F4Y60jfpQZ4N9W7YMJA/bSZUR4vcy2ZpsqTD2
 RYi6kg6/VjcqjyauPFqbOX4VPBQNVp2XRVyC5IKH+X2Vl073K00luLYrFsHMQ8aCcXfEFfli6+E
 auwuFQAJB0rT4sLX0uA==
X-Proofpoint-ORIG-GUID: 0jP9HUCmaGholmjtoeCqIY6MN6zr7Yc6
X-Proofpoint-GUID: 0jP9HUCmaGholmjtoeCqIY6MN6zr7Yc6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2NCBTYWx0ZWRfX0V/MH0Y1OJiq
 QpEx3ZaB6S9VKe4Y9yjRoy8CJWWxdip8ZuMJGz8BUddl/56aDQcdEH60LNT1LOeCV0xX1HyNKBZ
 qhpBNQOQOgn/rwpq2VTzhqu0xRBRDwM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210064

On 8/20/2026 10:07 AM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> get_cur_freq_on_cpu() uses perf->state, which is an index into
> perf->states[], to index policy->freq_table[]. However, freq_table[]
> is built by filtering _PSS entries with duplicate frequencies, so its

To be precise for applying if needed.

"However, freq_table[] is built by filtering _PSS entries with duplicate
frequencies"

-->

"However, freq_table[] is built by filtering _PSS entries that are not
lower in frequency than the previous one."

> index space no longer matches perf->states[]. The original P-state
> index for each remaining freq_table entry is stored in driver_data.
> 
> Once an entry has been skipped, using perf->state as an index into
> freq_table[] can therefore select the frequency of a different
> P-state.
> 
> The reported current frequency itself remains correct because it is
> obtained from extract_freq(). The mismatch only affects the cached
> frequency used by get_cur_freq_on_cpu() to detect a firmware frequency
> change behind our back, through data->resume.

Just for applying if needed， deleting "through data->resume."


> 
> If the wrong table entry contains a frequency different from the one
> the CPU is actually running at, the check falsely detects a frequency
> change and sets data->resume. The next ->target() call then performs a
> redundant control-register write even if the requested P-state is
> already the current P-state.
> 
> Conversely, if the wrong table entry happens to contain the frequency
> to which firmware has changed the CPU, the frequency change is missed
> and data->resume remains clear. A subsequent ->target() call for the
> P-state that the cpufreq core believes to be current can then
> short-circuit without rewriting the control register, leaving the CPU
> at the firmware-selected frequency until a different P-state is
> requested.
> 
> Fix this by taking the cached frequency directly from
> perf->states[perf->state].core_frequency. perf->state and
> perf->states[] use the same P-state index space, and converting
> core_frequency to kHz yields the same value stored in the corresponding
> freq_table entry during initialization.
> 
> Fixes: e56a727b023d ("[CPUFREQ] Make acpi-cpufreq more robust against BIOS freq changes behind our back.")
> Reported-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Suggested-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   drivers/cpufreq/acpi-cpufreq.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index a797bb2..3313c74 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -353,6 +353,7 @@ static u32 get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *dat
>   
>   static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>   {
> +	struct acpi_processor_performance *perf;
>   	struct acpi_cpufreq_data *data;
>   	struct cpufreq_policy *policy;
>   	unsigned int freq;
> @@ -368,7 +369,9 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>   	if (unlikely(!data || !policy->freq_table))
>   		return 0;
>   
> -	cached_freq = policy->freq_table[to_perf_data(data)->state].frequency;
> +	perf = to_perf_data(data);
> +	cached_freq = perf->states[perf->state].core_frequency * 1000;
> +
>   	freq = extract_freq(policy, get_cur_val(cpumask_of(cpu), data));
>   	if (freq != cached_freq) {
>   		/*


-- 
Thx and BRs,
Zhongqiu Han
