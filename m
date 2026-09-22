Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0EA423A72
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084397; cv=none; b=HBdW0DdUjlKxYT8WncWwL7jy91WGVBmnpIOUIwv6qU9b370t1bZLapD4QqNZk5One85q45c+gFjc2VDGff33b3lBASAVv0RZpJULEIEng71GBT+mfBoE4o2H/bu0EEgNc75+5xYojzd2rNfCZXSP/7CafLVyY+ib3jIAcNnhTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084397; c=relaxed/simple;
	bh=7QHutKGaN9i99xihPm4cE0w+hK9skWSFtV7wIltN2hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCTx+SfOwhpDbQ9G6oVThEtyOeWHtRMeRc4P8wiEBV6OKmUCzPrWWjK8O7o9x5MobFRePp6aYn01pPhVWrM9R+vJeuymKc+izTspbiplpv888K8ThGqTx8oYgUqfB6iAxbCgHyIOBNxf7T2qW8EKTEmrYoMIdXN6irn3dUY91Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wd8kCYiE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b7xgU29O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wd8kCYiE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b7xgU29O"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBPVSZ269122
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 13:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+n557K+DZqVRpFdTKZE18fW896KFDQSu6kLWIm5rBnQ=; b=Wd8kCYiEqJZM3jNc
	wzCzWbEduiUWF5Bf4A3gXNPM2MR4eQAy258UCXkq0dbjCrA1BmiPYd8/p1/ysx+s
	lZ7fhXLSAM86XeXEgFWfDj7vqE7eSWz7t1I8KhzI9y3qVWb9Yhn89R1nUEmQl875
	aIU67kpo1Z255jLS8QAZi+/uGje0nIuy0po7Asj4L9GwYiX/frCHOGfRj0k40GCy
	ryH+ymyrcP82ndiOcSYOnq6IkG7ZXaQsoLcMU+z7GtF/nwLjBBiyWgluHt9rtjLv
	sSxcuPFjLtC4m41yrSxb+jdJp4Xzp/rYqEXyTo/SMWcxWISFHlt9pWMNXOkCfbID
	EGLZ2g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufbatyk9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 13:39:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39af92138f9so1154829a91.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790084393; x=1790689193; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+n557K+DZqVRpFdTKZE18fW896KFDQSu6kLWIm5rBnQ=;
        b=b7xgU29OJ0nKDF4IZ9q0qsUy4Dc5t3CadLlxGhQ8mC9Og5keP5JxSFOxTH0bQmaQI0
         B0L/RTDlftQ+ti3pgBAUD8dlHcR1LnmSrdnZ2sEVhlU9vC5/n01mYbguGwahFoVXTT59
         jtGBh3x3WcEzxu+YatnbEoxCrKaijOP5tYJMNQdli2w0+5F3IRg0W+kQ/xsmxsjW2FUo
         sPmMgrqHwnaEHslz81YH7QvZnJ3/bD0ZLv/QQrPj+TjSu0Dj8uE1Dr38uku1mzYtge7y
         dqBArfZE/piX7GtqJ97Cjmvd8H9dIZLJG1xVBqGw3SYnNMLfEcA+paZ1+phAtodzyQ0L
         NtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790084393; x=1790689193;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+n557K+DZqVRpFdTKZE18fW896KFDQSu6kLWIm5rBnQ=;
        b=KPmAvxHOXpq82Bq9awZIpp4L0yysNUxiEn2LGZ1of7/JvslVgzjGctoFkYdBbe3QgV
         pIU4Cpmkq28NQxtghSgCkMuUO1PafAABHTGjO8rH7yX9VcXV/SVjDlma8cnHwFYCYGwB
         lQgpZa+vlnzqXn+nC5DPQqzG2pAfvolcFUUQQRJMY1x84mzR26yKPHo/1jLTPnJhmRee
         P3MiLLsAveqcj/JKguVB8kArCyGbB5eNs6NkzkXmLLtaGb/bnJ7wS+KOz8JAZGyYoaGH
         Dzpy8gBi/BN4xxnYgq1LgbC6MXr7EiqHcXkOLhqFlGxU+x5m1YYJNcXJH7PS089LAZcS
         5vJg==
X-Forwarded-Encrypted: i=1; AKwUvBzRUzHJERwE0wKtpCNSEDJTw0x3DxrHBmuEI7oaMSDe1FqZXgp/y9VC8bX6EG7CIl72sRZIEj3uKw==@vger.kernel.org
X-Gm-Message-State: AFuF++n7XQbN4jJVhefwYvy+d/My7a1fzjM2nydNX9CtmDCQ56vdrHmK
	7XysH8RJWbEobDHJ/MtoH3ITS/+fjejBEwMKbaKZGt767/NMGI3/QhsMK45PI/MKnKQs5AfagVC
	lC7fcNT/boPwvtDE5H5ZiRAvQfyD5/A5nBPniqyBLnZr7uO7xa2hJXJU3zFRwBg==
X-Gm-Gg: AYBFou0G3V+22KEVEXKt3p0JnD5iHsksyHA5fk5hAwO3niiT7lGsCsseR6VakXGVllg
	y3+BRRqsedKTOCCARX1Ai4HSD42XMj/RLdtMYCyHMS/GYsiToP4aZkU98HFkfavrrWMdraN3MiS
	emmDID+GFl1PO7wWXzQ7Zh4tRD81dGslv9dgvaOCHid5QnoHWDzlWQq67ftm8L7MHg/q+9vbWnL
	495ymNYjSLh6gOTRoAAOT8rovLVGUY3xgiAvCmMDX5YdEh+cbioZf0DgBkRkA4vG3D7zHGJNq7I
	AJXTJ6KtqIyKk8w21NvV4t1gMWnGQQzOYVhE/AS5YuacOdQ5EoyN6zmwfR3rdp+ZrOLL91dCaqd
	TTkaSAX6muMrE7g+JbA48ReGH2UqSiCnp1fMDJiSnNJHCX9TA5EZFQ2wYp38CmaJXoHPzSWo=
X-Received: by 2002:a17:90b:3d8d:b0:39e:6c68:fd8c with SMTP id 98e67ed59e1d1-3a0736b0193mr789240a91.33.1790084393143;
        Tue, 22 Sep 2026 06:39:53 -0700 (PDT)
X-Received: by 2002:a17:90b:3d8d:b0:39e:6c68:fd8c with SMTP id 98e67ed59e1d1-3a0736b0193mr789219a91.33.1790084392633;
        Tue, 22 Sep 2026 06:39:52 -0700 (PDT)
Received: from [10.133.33.241] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a067409854sm4883133a91.7.2026.09.22.06.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:39:52 -0700 (PDT)
Message-ID: <4f0915c0-5950-4e45-a72b-0db2942f00b5@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 21:39:47 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq: fix schedutil not returning to non-boost
 freq when boost is disabled
To: Ananthu C V <ananthu.cv@oss.qualcomm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        zhongqiu.han@oss.qualcomm.com
References: <20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com>
 <20260908-schedutil-boost-frequency-handling-v2-2-25312a713699@oss.qualcomm.com>
 <05c00750-7fc2-49d4-9336-7beb33fd9380@oss.qualcomm.com>
 <arEIKD11YRH6YoHz@hu-anancv-blr.qualcomm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <arEIKD11YRH6YoHz@hu-anancv-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE5OCBTYWx0ZWRfX78jXMd3lCPSG
 hpkSoqNpKifr1pR/nTbXTBl71MXS2MRgWnteEOWEtE8RH6iEFYSMbMBG10lSGnm4Jk8B28vi/mi
 lbkt1FDLX0Svzl+iqpWeY+co0Jjizk5X/sBzJcQINSdhxyT1+B1nv/yjjfUiNjylMlAQ5gD0dXy
 Ouy9knd4/KX051aEq+rUA86RuwEZzDhgKbqzyMMB9UwFGNLQGFBUU6WFRNPhkO/u6X0446MMOi+
 jOHSlJ/p94osEL+ny5uVOzYyJtp9b8tjruoX647/A11RgMvv25VGLOoUvrqiuVUGIfShfaFR4Q9
 PG94ozUd/BsZbJS6bIoYTdwjv24Kc0dIGate3g/70EOBD54CsExE553Ry/epOfx4Wc/zJVO2NIJ
 mfuDf15GEMK4jpF5ECFiqW8ZdExPdTV/uFYB5s8Fp/PeoT/pnNHCVYlpiwDnyH54rO3yAPo8nOi
 KKo7opx6oxvNBwv+y2g==
X-Authority-Analysis: v=2.4 cv=IYYSymqa c=1 sm=1 tr=0 ts=6ab2852a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=WZsD97d4U260xpjQMLoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE5OCBTYWx0ZWRfX90VEwe3bhg0Q
 R2s1gtEjfQZsTAZEvv1QsNdqL9BgKLlwJ07A+KKiLY7nXT85GOqOTTd6lvfWscPZt4dWgjw9FUm
 SUsIC7FHeFQ9oA/7fkBWfoH7EOsj4LU=
X-Proofpoint-ORIG-GUID: UZGEQ7bX8aW-UE_LzFVsOekQ1pc0omer
X-Proofpoint-GUID: UZGEQ7bX8aW-UE_LzFVsOekQ1pc0omer
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220198

Hi Ananthu,

On 9/21/2026 6:34 PM, Ananthu C V wrote:
> Hi Zhongqiu,
> 
> On Fri, Sep 18, 2026 at 05:15:07PM +0800, Zhongqiu Han wrote:
>> Hi Ananthu,
>>
>> On 9/8/2026 4:30 PM, Ananthu C V wrote:
>>> Commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly if
>>> max boost is known") introduced a guard for cpuinfo max updates to only
>>> increase, to preserve driver-set values above the freq table maximum,
>>> causing cpuinfo max to be stuck at boost frequency even when boost is
>>> disabled.
>>>
>>> Unconditionally track the highest non-boost frequency (max_base_freq)
>>> in the freq table. When a freq table is available, use max_table_freq/
>>> max_base_freq instead of cpuinfo->max_freq to control boost values, so
>>> the value can decrease again when boost is disabled.
>>
>> This issue does not appear to be limited to schedutil, so the subject
>> seems too restrictive.
> 
> That makes sense, I'll update it on the next run.
> 
>>>
>>> Fixes: 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly if max boost is known")
>>
>> I already commented on the Fixes: tag in v1.
>> https://lore.kernel.org/all/3a20b69e-b072-4723-925f-514d8162e259@oss.qualcomm.com/#t
>>
>> IMO it should be: 6e39ba4e5a82 ("cpufreq: Add boost_freq_req QoS
>> request")
>>
>> Could you please comment on this?
> 
> The specific issue we are trying to fix is that once boost is disabled the
> frequency is not able to come down to a non boost value, which was introduced
> by the upward guard added in 538b0188da46. Consequently, if that guard is removed,
> the issue does not exist. So it makes sense to add a fixes for that specific
> commit.

I just did some testing with the SCMI driver on the SM8850 platform, and
the results matched my previous v1 comments[1]:

02/15/2021  538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly
if max boost is known") ---> Not reproduced

03/26/2026  6e39ba4e5a82 ("cpufreq: Add boost_freq_req QoS request")
---> Not reproduced

03/28/2026  db80ad776cd2 ("cpufreq: Remove driver default policy->min
/max init")  ---> Reproduced the issue

[1]: 
https://lore.kernel.org/all/3a20b69e-b072-4723-925f-514d8162e259@oss.qualcomm.com/#t

538b0188da46 made cpuinfo.max_freq increase-only, so it stays pinned at
the boost frequency once boost has been enabled. This stayed harmless
because cpufreq_frequency_table_cpuinfo() also assigned policy->max =
max_freq; directly, recomputed per boost state on every call.

6e39ba4e5a82 moved the boost QoS update to the dirty cpuinfo.max_freq,
but since that value is unchanged on disable, freq_qos_update_request()
bails out early, cpufreq_set_policy() is never invoked and the directly
written policy->max survives, so the bug remained invisible.

db80ad776cd2 then deleted policy->max = max_freq;, leaving nothing to
bring policy->max back down from the boost value that
cpufreq_set_policy() had installed when boost was enabled.

Correcting myself: from the point of view of where the issue first
becomes reproducible, the Fixes tag can be:

Fixes: db80ad776cd2 ("cpufreq: Remove driver default policy->min/max
init")


Comments are welcome.

> 
>>> Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>
>>> ---
>>>    drivers/cpufreq/cpufreq.c    | 14 +++++++++++++-
>>>    drivers/cpufreq/freq_table.c |  5 +++++
>>>    include/linux/cpufreq.h      |  1 +
>>>    3 files changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index 0d0df986fa3d..a13e72711597 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -574,6 +574,7 @@ static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
>>>    static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
>>>    {
>>> +	unsigned int max_freq;
>>>    	int ret;
>>>    	if (policy->boost_enabled == enable)
>>> @@ -587,7 +588,18 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
>>>    		return ret;
>>>    	}
>>> -	ret = freq_qos_update_request(&policy->boost_freq_req, policy->cpuinfo.max_freq);
>>> +	if (policy->freq_table) {
>>
>> acpi-cpufreq has a freq table but never sets CPUFREQ_BOOST_FREQ, so
>> max_table_freq == max_base_freq == _PSS P0 here, and the real boost
>> ceiling kept in cpuinfo.max_freq is lost. It seems that the condition
>> needs to be "does the freq table list boost frequencies" rather than "is
>> there a freq table" — e.g. recorded during the table scan, the same way
>> boost_supported is derived from the flags in
>> cpufreq_table_validate_and_sort(). And then:
>>
>> if (policy->cpuinfo.boost_in_table) {
>>      xxx;
>> }
> 
> That makes sense. I think the best thing to do here will be to export/move
> policy_has_boost_freq from freq_table.c and reuse it. Comments on this are
> welcome.
> 
>>> +		max_freq = enable ? policy->cpuinfo.max_table_freq :
>>> +				    policy->cpuinfo.max_base_freq;
>>> +
>>> +		if (!max_freq)
>>> +			/* when the freq table contains only boost frequencies */
>>> +			max_freq = policy->cpuinfo.max_table_freq;
>>> +	} else {
>>> +		max_freq = policy->cpuinfo.max_freq;
>>> +	}
>>> +
>>> +	ret = freq_qos_update_request(&policy->boost_freq_req, max_freq);
>>>    	if (ret < 0) {
>>>    		policy->boost_enabled = !policy->boost_enabled;
>>>    		cpufreq_driver->set_boost(policy, policy->boost_enabled);
>>> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
>>> index 4984142dc08a..7e183e16162d 100644
>>> --- a/drivers/cpufreq/freq_table.c
>>> +++ b/drivers/cpufreq/freq_table.c
>>> @@ -34,6 +34,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
>>>    	unsigned int min_freq = ~0;
>>>    	unsigned int max_freq = 0;
>>>    	unsigned int max_table_freq = 0;
>>> +	unsigned int max_base_freq = 0;
>>>    	unsigned int freq, i;
>>>    	cpufreq_for_each_valid_entry_idx(pos, table, i) {
>>> @@ -42,6 +43,9 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
>>>    		if (freq > max_table_freq)
>>>    			max_table_freq = freq;
>>> +		if (!(pos->flags & CPUFREQ_BOOST_FREQ) && freq > max_base_freq)
>>> +			max_base_freq = freq;
>>> +
>>>    		if ((!cpufreq_boost_enabled() || !policy->boost_enabled)
>>>    		    && (pos->flags & CPUFREQ_BOOST_FREQ))
>>>    			continue;
>>> @@ -62,6 +66,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
>>>    		policy->cpuinfo.max_freq = max_freq;
>>>    	policy->cpuinfo.max_table_freq = max_table_freq;
>>> +	policy->cpuinfo.max_base_freq = max_base_freq;
>>>    	if (min_freq == ~0)
>>>    		return -EINVAL;
>>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>>> index 3f3b1380251a..419c71ccff7c 100644
>>> --- a/include/linux/cpufreq.h
>>> +++ b/include/linux/cpufreq.h
>>> @@ -46,6 +46,7 @@ struct cpufreq_cpuinfo {
>>>    	unsigned int		max_freq;
>>>    	unsigned int		min_freq;
>>>    	unsigned int		max_table_freq; /* Highest valid frequency in the table */
>>> +	unsigned int		max_base_freq; /* Highest non-boost frequency in the table */
>>>    	/* in 10^(-9) s = nanoseconds */
>>>    	unsigned int		transition_latency;
>>>
>>
>>
>> -- 
>> Thx and BRs,
>> Zhongqiu Han
> 
> Best,
> Ananthu


-- 
Thx and BRs,
Zhongqiu Han
