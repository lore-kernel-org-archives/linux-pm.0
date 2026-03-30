Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746113C9EDF
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875720; cv=none; b=uyGMlrFnC28wjDEVahJ2QxNr3/HxUjvzH2DxEzD+W87pk1LnzQEhNiETXCC7gQWeAdPVRT6pUbFrTJoriLeIOXDDhGCfrUfU6c4PsYJ9XVQVIjX5BMwTsi8clEavpci/1xEEszzRfirZOB4XCJoWXlOTsq4W5qqpQpG9QCjv6z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875720; c=relaxed/simple;
	bh=bkkBveKjAHydjdwm5B2c0Qxu0aJ1KW2dBLPWw+hE4Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=McyO2D7z6eSqDamqsgaGYLyeCh7bP0vUq20OuF+rLL/WLofLJClLUd2ny6M7qp+MMREUdJJVsveV/h75Tl/pc7kEK+3i0GqVykZfU2YWG+BrXXfePt1OeqdZy3gzXrkjV1liq7rtqVzidcDjbujR2pEZ0qHqRORBBkW45X5diRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PvnhmnFT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dg6QvmGp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PvnhmnFT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dg6QvmGp"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UBEG4S1402790
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 13:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QIa3nEBOIri1zV4QwKaiohs9t4fLtqXdWwCFyzd67oQ=; b=PvnhmnFTI8iaNZyW
	zBr6hG7YIhDgMtPekjaFP+anhoM2hn7hnTxnCmO9Ytwxlor8dlAc4XQlm+51Smmm
	oVhl6dR6GvAwPNYQaKhn4aloLtUBW7Ua4SWM1rzV1fTxj50hoyyJQlRVtT2AwhNC
	co9VkGbwflz2U9qe3LMvTMu+//nd/E9PJA5jmSk1hX2sbIIuQpGNMJdPL63D2wKC
	AznYDVyLML8r7R6Gu13SE/Y0JfnMkGFhb8E6An9HukfivY+3/KoKo8/TU2SoRHU7
	m2k8Gv7gb9/E9JYg4Npq3841F5zuFAwDDlt6V2MN88IbQauh2+0NjHj2iDQ/Lzew
	MnZJUw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7r4h8gq9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 13:01:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35da97f6a6dso1071054a91.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774875715; x=1775480515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIa3nEBOIri1zV4QwKaiohs9t4fLtqXdWwCFyzd67oQ=;
        b=dg6QvmGpKm+3gK5UWIQVTq2oCn2Cj9WQ8OiaAwjXO3Jp4jmWf4nigC3vIMKnhZv7SQ
         O38RTAtgapLdHSfXNH4OKVp0V/ymgV0yJ4dOdmnp+M9gB5stxImH/y+/fWddkIYy2I+K
         Qu6tabtnkbr7QUsn+0Vq3pcEtsxOYhJlSrpH8vxVac8oPYM65EzM7YlHAnsQjBRGTEdF
         c5gQhodYGoUIAqsO/SmtLNCR5sfeaWYwiWEKBhJhRQwe0pObbSChUTlAyDTCP/iDB9S2
         id7h2jJWMt1cpM/zB0QEmhuVlCuv4sin/m8JfpgHJij2TON1j8qkzl1CLfj182Qg5cQW
         G4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774875715; x=1775480515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIa3nEBOIri1zV4QwKaiohs9t4fLtqXdWwCFyzd67oQ=;
        b=LIjkLmjf04nC+hgrtklMeLqY/1LCc26Fc0LpPbhn4szvm5tatbzYqJSVIp+4+LsBcs
         XgMw+ox4UMHO394kAOofx1y9GprZNyyAsc1aS3bwrS9iVaw3WJcawUjpeHapdLq/Be8H
         BX6m9x7A98eyAG4NMZZk++aRQil1npi+vRI9GPuz4/sn+6/SdexYb4QenCF1UiwMzxq8
         fHV6Alm+mArN2Ah0rGDVe3tjdLgDQIkk+Yhus8gqx7MnN2NP7scfG2uyuDFklCx3Pnwb
         yADLMMZy5Yme1r/UUe7SJz3uSKbLLMD1X1y5aLd7/xYrcziU3mnxWfCHxWb0rZ+kv25Z
         vADA==
X-Forwarded-Encrypted: i=1; AJvYcCVC2feJQI+MtKpWdaM9VcdmIZEI1M25FJAG7E4riS7FYugcySNPAX8AMiZXO+Yjw4fNLRW+oYwPvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YykJqt6Gz9wQ482KBfVgIqY/oj1oXqqQuSdTyWl2N/ikNeKL9UO
	DBWMUi5mCLZ77TVxgHvQ1Mj9VrX3oO7vsBBfI1J7VwTYgZ8Gcueb6ucOFSEqmLaQif0ZhaVG4iQ
	yzbUgnvTFYG1PzNZReJsm0ECYKpv4AtmmGx/txZX/x9RE5zJRhXq2X5+xDGuTMQ==
X-Gm-Gg: ATEYQzwk2NhBI+8eKoY5PA4Vz3BRBQH+ZrDWNJmR15dIf+PVK3iK/t0GcAziVksr3am
	gnUaHgp2u+JAYeijFaT2N02T/7QdEtbNDTiAP6t41hIwn7myr2O3YXYEWw6pPOTmdLGCDrZ+EPX
	b0gt9OBzA057NM0Dgij05jtzX4hscZf+VO6X1eL7dIjIefTFYXf3bDIfB3YlFZysAruZsPC5nmJ
	6kTdhUAaxdJ4wkXJHRLQPdchrJ8YTOUhHzqJCFFteCfjhCu39XJxTvintVnu1V4Pk3xmi/P91Ok
	ZiHt1q2nR/MfAi/MZNkCuWkhQzZxBQp94O3m3x0VM/RrxEB/vEiRcMRubpByEhM0GZNiZxmEkbq
	IotS2RmRsWb6DnDuA3AwGxZww2scnnqXN3bb7KGINfn1y88bOCALMEGax7MyBHwFvFXtNVH8n9k
	uVI+2TEqETC0dHmia8
X-Received: by 2002:a17:90b:3d06:b0:35a:189b:43db with SMTP id 98e67ed59e1d1-35c2ffa80ccmr11171844a91.4.1774875715299;
        Mon, 30 Mar 2026 06:01:55 -0700 (PDT)
X-Received: by 2002:a17:90b:3d06:b0:35a:189b:43db with SMTP id 98e67ed59e1d1-35c2ffa80ccmr11171786a91.4.1774875714415;
        Mon, 30 Mar 2026 06:01:54 -0700 (PDT)
Received: from [10.133.33.66] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d94d3039csm8842008a91.6.2026.03.30.06.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 06:01:54 -0700 (PDT)
Message-ID: <e2e0fb30-ac9c-4881-abbc-e064dbf5b8b8@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 21:01:49 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] cpufreq: Add boost_freq_req QoS request
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>,
        Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
Cc: Huang Rui <ray.huang@amd.com>,
        "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <perry.yuan@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260326204404.1401849-1-pierre.gondois@arm.com>
 <20260326204404.1401849-3-pierre.gondois@arm.com>
 <8261d970-ccaa-494c-91c7-6ebecce010ac@oss.qualcomm.com>
 <f61f81ff-7e42-414e-a196-d20f8717f5f7@huawei.com>
 <6eff4517-cc4b-4f2f-8e39-6cfe8b18c4dc@oss.qualcomm.com>
 <6cd973e4-5df5-47b0-86d5-1552f8ba8d2e@huawei.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <6cd973e4-5df5-47b0-86d5-1552f8ba8d2e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEwMSBTYWx0ZWRfX6fNj7/r7RPeF
 kLY9JpnDP8dxDHNGArC6MYYUtZC3VFZYFy9YuQNfpAClY3cdBN807NdJ0mkwRrvALj1KVvv1lHZ
 SQR3kSXHY3yit9QfbFaSJ04a6zLplnzf4S/x+DlVfFLLBuIeL41WygRdHeUmVCe4DVQtc5uL2Wt
 aqb6ZbaTO8/9dak9u50krbH9iusSuVgZifGHyAzF53n+sdthoOh4vK8drfPYhySJD1LK2IFVrw3
 mnvWhFBaYCexniD09B9U0MnFpSLPxrfyQa9XZD1Qea+hEe+fRQMbhgfLqSiKv2H5kgPlb5hDev1
 CaBge2qorbJRaPXugYWZjhqrHskCy8VyNWkcn+CYru5wJj3U3thp4QkFmjgryr2cOvh1uc1qP7Y
 DNEf9uScxP94mwa1P13qWah1Pp56tg==
X-Proofpoint-ORIG-GUID: BoHl52Gfrded_cYeUgGreVLucW9hhUos
X-Authority-Analysis: v=2.4 cv=PI0COPqC c=1 sm=1 tr=0 ts=69ca7444 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=J7N9wpLcb6RgLkOmlGQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: BoHl52Gfrded_cYeUgGreVLucW9hhUos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2603050001 definitions=main-2603300101

On 3/30/2026 3:16 PM, zhenglifeng (A) wrote:
> On 3/30/2026 12:00 PM, Zhongqiu Han wrote:
>> On 3/30/2026 10:10 AM, zhenglifeng (A) wrote:
>>> On 3/29/2026 5:00 PM, Zhongqiu Han wrote:
>>>>> @@ -1377,6 +1386,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>>>>         }
>>>>>           freq_qos_remove_request(policy->min_freq_req);
>>>>> +    freq_qos_remove_request(policy->boost_freq_req);
>>>>>         kfree(policy->min_freq_req);
>>>>>           cpufreq_policy_put_kobj(policy);
>>>>> @@ -1445,26 +1455,38 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>>>>         cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>>>>>           if (new_policy) {
>>>>> +        unsigned int count;
>>>>> +
>>>>>             for_each_cpu(j, policy->related_cpus) {
>>>>>                 per_cpu(cpufreq_cpu_data, j) = policy;
>>>>>                 add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>>>>>             }
>>>>>     -        policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
>>>>> +        count = policy->boost_supported ? 3 : 2;
>>>>> +        policy->min_freq_req = kzalloc(count * sizeof(*policy->min_freq_req),
>>>>>                                GFP_KERNEL);
>>>>>             if (!policy->min_freq_req) {
>>>>>                 ret = -ENOMEM;
>>>>>                 goto out_destroy_policy;
>>>>>             }
>>>>>     +        if (policy->boost_supported) {
>>>>> +            policy->boost_freq_req = policy->min_freq_req + 2;
>>>>> +
>>>>> +            ret = freq_qos_add_request(&policy->constraints,
>>>>> +                           policy->boost_freq_req,
>>>>> +                           FREQ_QOS_MAX,
>>>>> +                           policy->cpuinfo.max_freq);
>>>>> +            if (ret < 0) {
>>>>> +                policy->boost_freq_req = NULL;
>>>>> +                goto out_destroy_policy;
>>>>> +            }
>>>>> +        }
>>>>> +
>>>>>             ret = freq_qos_add_request(&policy->constraints,
>>>>>                            policy->min_freq_req, FREQ_QOS_MIN,
>>>>>                            FREQ_QOS_MIN_DEFAULT_VALUE);
>>>>>             if (ret < 0) {
>>>>> -            /*
>>>>> -             * So we don't call freq_qos_remove_request() for an
>>>>> -             * uninitialized request.
>>>>> -             */
>>>>>                 kfree(policy->min_freq_req);
>>>>>                 policy->min_freq_req = NULL;
>>>>>                 goto out_destroy_policy;
>>>>
>>>> Hi Pierre, Viresh,
>>>>
>>>> Sorry for the late follow-up on v8. While re-reading the patch, I
>>>> noticed a potential UAF issue on an error path — I might be missing
>>>> something, so I'd appreciate a double-check.
>>>>
>>>> min_freq_req, max_freq_req and boost_freq_req all point into the same
>>>> contiguous kzalloc'd block:
>>>>
>>>> slot0 (min_freq_req + 0) -> min_freq_req
>>>> slot1 (min_freq_req + 1) -> max_freq_req
>>>> slot2 (min_freq_req + 2) -> boost_freq_req
>>>>
>>>> If boost_freq_req is successfully added to the QoS constraints list, but
>>>> the subsequent freq_qos_add_request() for min_freq_req fails, the error
>>>> path does:
>>>>
>>>> kfree(policy->min_freq_req); /* frees the entire block, including slot2
>>>> */
>>>> policy->min_freq_req = NULL;
>>>> goto out_destroy_policy;
>>>>
>>>> policy->boost_freq_req is not set to NULL here, so it becomes a dangling
>>>> pointer into freed memory.
>>>> cpufreq_policy_free() is then called from cpufreq_online() and does:
>>>>
>>>> freq_qos_remove_request(policy->boost_freq_req); /* UAF */
>>>> or this boost qos req will leak.
>>>>
>>>
>>> Good catch!
>>>
>>> How about remove the kfree() here and just leave it to
>>> cpufreq_policy_free()?
>>>
>>
>> Thanks for the suggestion — this is another fix approach we can
>> explore, but there seems to be a small caveat.
>>
>> Some additional changes would still be needed; otherwise, removing the
>> kfree() here and deferring it to cpufreq_policy_free() can lead to a
>> warning.
>>
>> The reason is that we neither free policy->min_freq_req nor set policy
>> ->min_freq_req = NULL. As a result, when cpufreq_policy_free() later
>> calls freq_qos_remove_request(policy->min_freq_req), it hits the
>> following warning:
>>
>> if (WARN(!freq_qos_request_active(req),
>>      "%s() called for unknown object\n", __func__))
>>      return -EINVAL;
>>
> 
> Therefore, it seems the only option is to allocate memory separately for
> boost_freq_req.
> 

Thanks Lifeng. Allocating memory separately could also be a direction we
can explore. I also sketched another small example in a separate mail
thread for discussion.


-- 
Thx and BRs,
Zhongqiu Han
