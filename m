Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690096;
	b=xXbiPx/c0t/quxCoug3C8+6kMtqFDPcfbgM6rnKkMULpJocFo3Liadht9wfCBlQkzrnv
	 58h/Hb9sCCwAwmvmU25VhU2WnrCuA0g5tERLhtqslErUaWUYGSaNbaz80qTuKMkhsFRqd
	 5chLPSlvff4J0Fqo+dU/3LAMBOISQK143BlNGNeP9NGY7kN6Thw5i/S/LXSRVEn9BpnM9
	 KIZ2mI1SwXFDBKbGGtVWliNqxlp3Oylnc1EfnuG2JISc+/rImqdoRAjpJeMGfK6NQkDe/
	 5ARYICZ02/tA4ZzJ9/PENEMJ24JcJo7P2kTH0muhN7cyv87D4aTe1Qc4BaHEoUKquZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690096;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Taq3TN1TspoSEDGf5Bcuf48IU/BFZ1ywMHPrwJaGDAk=;
	b=oMdy4oHHL3/U6GQKJDShbyF9HjTRpkvV3iuRFtTflseuB0Bd5CG9A+2+P6XvlPe+oqgH
	 Fhtq23oG91ctq4MoL+gRLxw1nljlWWTwf6UaCaJ861S/+y+0BjjOyMJGzH3bvsl6r8nPM
	 dThPdI93YNErLV+ourRN+Rz9kDha+BLkUBl5G/1/zzBhPRCRu05/3hN6ohZBfRAY7mL6m
	 tUGcZGq4UyUJf427A3HSP05cI2tDHg8Ok8iw2vOXBEyFWb2E+6UjvF0p+q2cg8UHXF7QR
	 wOK24M3nRhd1oJyhIzLP8/iZODfv8L6ooFEgzM7lQy+oCUdfoKVkYIzosIdScv6xq2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o7KY7mfd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TrZp8kOX;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B28606A32D
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 07:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8B28606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o7KY7mfd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TrZp8kOX
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A32BuFx2106691
	for <linux-pm@vger.kernel.org>; Tue, 3 Nov 2026 07:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Taq3TN1TspoSEDGf5Bcuf48IU/BFZ1ywMHPrwJaGDAk=; b=o7KY7mfdWExlqrsy
	hfRAiBB20+ysutQzW9p+7J4NgJW2oLKpFF3d2+I/UNc7DjjdlNTyXJEP0U8GQy7W
	LncvODbdiu66JA7sc6K3ALEYaE2ByPZL3H1r/gqJJbEZbDMzWAuUnU3jmz35sQAD
	P4cM/TVW0EwXTNfT/UI1luTyuwUYX6JDN8EyMtnyl83ePiQMh8gCUCIRM7gDWD+n
	3GuCYtR9RhJOFDSoK7vKSHwDiSSOvFX9rmHWLV7+OnHAj5LWurCXVr7lRezBBnp/
	/O/NT4T9V3TLjDpSHUSgMjVHei54fYdRrP6Z7/om1XH7RhmvXuoILzgGiCf4YtVP
	XNcaMA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq6m9903u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 07:14:54 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a05b68f851so351395b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 23:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793690094; x=1794294894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Taq3TN1TspoSEDGf5Bcuf48IU/BFZ1ywMHPrwJaGDAk=;
        b=TrZp8kOXONA2HN/zJz7buaC7jkdTJE+iJ9meotTFdZGJnHktulrAASprG7s4nqNgJ4
         8DXIO5iz6ZMQE2skjEu6g1cD0lBJ4jQ93tpkAWrdLYuag+zobSEag2SWTUQZNroyPOHY
         +sEBO8BfDP5upitri2uuVr9jm2yNv7gIVBsLKzCaxeEQPsiCfMDPUFUeZk93dw1d1Ase
         c162vfs12OJlLjiD2F7+KHRoloPKOyBq0uIvQ/kJVpa/IK2SIiXmdVjY8qp3xN9QuBrB
         NrSHLe7awBXT1kwHU/fV4Vq4XwZhNuMipWaeFxGliN+JR3D1UncMxgj5odAsWSbqRcoW
         7B5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690094; x=1794294894;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Taq3TN1TspoSEDGf5Bcuf48IU/BFZ1ywMHPrwJaGDAk=;
        b=fY2WK9zqDpETs5SNeDAyrIukFuzZZCb9x/dyyJrJ1/xm75ViO37goL5C/V4p2go6zL
         nTMaXHtDPDlnDXlc0aJCdkkYih7ihX0Po7qbZ+tdOL3TIZBvANHC/2UEPLuWyry8JVPv
         gI+koDB94qJoelAzl1q12gslI7M14WhagDWUw7VncEgB3oivdjB92nabVLWJKQ68CtuD
         WUO2u1f3hQV9UOsFgl3bPmeQypPuHMuVhkvWVdqk+QYedE98FhWabkjrukY78HN1IP0j
         e0f3rkQXysS9K+UQfeVeQ/n61Zkn41xR155ZnIAb208OqC6TJFNWoOACmb6hzqis0Z6x
         iuRw==
X-Forwarded-Encrypted: i=1; AKwUvBynaSKuqYhjvxW6OZK+z6RV6GtimyLfl90+jW34BV25/LGhVd/qb3GaWqaNpxCoTrF2mNhuTMCyUQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8SJfRxCYBG+S4l/lH6EJqKSLzZSqJjuIjvZqcb5l3AftSjzqmD
	Vvb4LCCixQsyAl6lQebj0eycLuXDD5ukNzjC2yRLzOAQjiVOPkFNggwWuZ1QGhiNBY9qGegYJde
	Sm03OExeGmaIs6PmN6sdef53eL6XaMi/hY+E+R7k+/ONsQuG8e70OpN6XC3w9t+tvbZpMHcDN
X-Gm-Gg: AYBFou0F3G+LO7gaEvE20UKt9Dfq7KHsJHFyZH0y2JwIQox8Uq32V1rpUdUQw1TH4/b
	v+W4HLT+nR2osQCTjna2/PMI9g6fKwIz+E8VcZnsn1ulNDQRKIvPSZ8GvuxcG7jla6SEnuI48xk
	JQPXSLgh3o5YQXBRiuk9eMWcg6ndHiY2IVYrpfkV4dyn1980iH5hl0rlPBRi8s4ixE0RslH959B
	klpRL4EuEMZfX1Ew75ACuAJaqX17qSL4xjM/yq7w8b2hgCbI0ASiFDYTK/v3QDz1BU8+9SA/qnI
	Q1Jndkj6g8ffcnOi4ErC6bvyQYHNM06aZo7kvBfTnLZHh8YXDiahinL9WZbiwKgBgkmDKRn0dGo
	rgFeLkKauCD34XnC2aPd9zcBfHoecnkLuQj9HYOrSWE2d4+MHOR0AFuL2VDiZIu7A6Blkpw==
X-Received: by 2002:a05:6a20:2d24:b0:3dd:a196:ffcf with SMTP id adf61e73a8af0-3e9289dc08emr6711088637.31.1793690093797;
        Mon, 02 Nov 2026 23:14:53 -0800 (PST)
X-Received: by 2002:a05:6a20:2d24:b0:3dd:a196:ffcf with SMTP id adf61e73a8af0-3e9289dc08emr6711079637.31.1793690093203;
        Mon, 02 Nov 2026 23:14:53 -0800 (PST)
Received: from [10.64.69.121] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb364480a3sm835913a12.9.2026.11.02.23.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 23:14:52 -0800 (PST)
Message-ID: <adf0462d-2207-4b23-b58d-49610552661b@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 15:14:45 +0800
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
Subject: Re: [PATCH] PM: EM: Rank boost and non-boost frequencies separately
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xin.liu@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, tengfei.fan@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, Pavel Machek <pavel@kernel.org>
References: <20261030-em-rank-boost-separately-v1-1-238a6b2bb888@oss.qualcomm.com>
 <3ed2a68b-d066-4a3a-b3ed-30a5ca00ae38@arm.com>
Content-Language: en-US
From: Guo Chen <guo.chen@oss.qualcomm.com>
In-Reply-To: <3ed2a68b-d066-4a3a-b3ed-30a5ca00ae38@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2BJzhRYBaMAfnTQkFL_8xJWcowZ04AJV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyOCBTYWx0ZWRfXzl/AUZOsU3Vs
 tVW5Ogb6XtMqr21/IAEY/QUxdY2hC57TbqOwbrx4ulqm+UT6F599LAAREo3KeZuAUrSlODvAmaI
 vvBx4NNvMAfUwQMML/8NFr/3g3UxEII=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyOCBTYWx0ZWRfX0Y+uxZGTkRIb
 6Z/DS0ZM7Luj4WQL5YCd4HP3mT+aVBcN/nAfwa6KCuCsGi0eIL6ytorMSAwSBhcnCKYPXcEMLnD
 ybrH54r1BS2lIBDBHoqROqdJFZvg6VPcmSNdKBwNNRXTTvrBdBcUumKTRzec1YGkFUR9FtRdcLy
 QOMYUhiGd8q8wxoYzWbacU4MxuTdqsvRasX/WQTjY03wR+sUy1m/t0nk8vrqaciknU5gDGAoqEh
 eya1zZ9UQVlRmH6VTRHEodYuJF7338igMfr+SwbX186ZHRo34BJKQO154jt7virmgW86Z3l1wYS
 D0S8RhATSFvFPAcWkdEZi3E0flGKY1VePRuCsGC2GYUnNWsSIuFivcnjYf+PPNwNl3b5I/fcwlI
 zCdWPKL1vP+GK56HkffZXz+AhxM3H8ebrUb17kOVPEPPbjqSCsImYjxJWuFOYxLTJA5g51zdz7K
 h+9PuxC02IqK2qJk81A==
X-Authority-Analysis: v=2.4 cv=C7B8WgP+ c=1 sm=1 tr=0 ts=6ae989ee cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=mce2Jbv03V5EqRZ6POQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 2BJzhRYBaMAfnTQkFL_8xJWcowZ04AJV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030028


On 11/2/2026 11:28 PM, Lukasz Luba wrote:
>
>
> On 10/30/26 08:10, Guo Chen wrote:
>> em_compute_costs() ranks all the frequencies of the table, boost ones
>> included. A non-boost frequency can be marked inefficient only because
>> a faster boost frequency has a lower or equal cost, e.g.
>>
>>    3.9 GHz  4.0 GHz (cost C)  4.1 GHz (boost, cost C)
>>
>> With boost disabled 4.1 GHz cannot be selected, but 4.0 GHz is still
>> skipped by governors rounding down to efficient frequencies (e.g.
>> ondemand with CPUFREQ_RELATION_HE), which land on 3.9 GHz instead of
>> the best selectable frequency. Several frequencies can be affected.
>>
>> Rank boost and non-boost frequencies separately in em_compute_costs(),
>> using the highest non-boost frequency of the CPUFreq table, returned by
>> the new helper cpufreq_table_max_nonboost_freq(), as the boundary.
>>
>> Fixes: c8ed99533dbc ("PM: EM: Mark inefficient states")
>> Signed-off-by: Guo Chen <guo.chen@oss.qualcomm.com>
>> ---
>>   include/linux/cpufreq.h     | 24 ++++++++++++++++++++++++
>>   kernel/power/energy_model.c | 15 +++++++++++++++
>>   2 files changed, 39 insertions(+)
>>
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index d3d0d9d02aa4..c93316141a11 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -1155,6 +1155,24 @@ cpufreq_table_set_inefficient(struct 
>> cpufreq_policy *policy,
>>       return -EINVAL;
>>   }
>>   +static inline unsigned int
>> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
>> +{
>> +    struct cpufreq_frequency_table *pos;
>> +    unsigned int max = 0;
>> +
>> +    if (!policy->freq_table)
>> +        return 0;
>> +
>> +    /* The table may be unsorted, scan all of it for the highest 
>> one. */
>> +    cpufreq_for_each_valid_entry(pos, policy->freq_table) {
>> +        if (!(pos->flags & CPUFREQ_BOOST_FREQ) && pos->frequency > max)
>> +            max = pos->frequency;
>> +    }
>> +
>> +    return max;
>> +}
>> +
>>   static inline int parse_perf_domain(int cpu, const char *list_name,
>>                       const char *cell_name,
>>                       struct of_phandle_args *args)
>> @@ -1219,6 +1237,12 @@ cpufreq_table_set_inefficient(struct 
>> cpufreq_policy *policy,
>>       return -EINVAL;
>>   }
>>   +static inline unsigned int
>> +cpufreq_table_max_nonboost_freq(struct cpufreq_policy *policy)
>> +{
>> +    return 0;
>> +}
>> +
>>   static inline int of_perf_domain_get_sharing_cpumask(int pcpu, 
>> const char *list_name,
>>                                const char *cell_name, struct cpumask 
>> *cpumask,
>>                                struct of_phandle_args *pargs)
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index d19a65461ae8..253c53ca6a74 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -255,15 +255,30 @@ static int em_compute_costs(struct device *dev, 
>> struct em_perf_state *table,
>>                   unsigned long flags)
>>   {
>>       unsigned long prev_cost = ULONG_MAX;
>> +    struct cpufreq_policy *policy;
>> +    unsigned int max_nonboost = 0;
>> +    bool prev_boost = false;
>>       int i, ret;
>>         /* This is needed only for CPUs and EAS skip other devices */
>>       if (!_is_cpu_device(dev))
>>           return 0;
>>   +    policy = cpufreq_cpu_get(dev->id);
>> +    if (policy) {
>> +        max_nonboost = cpufreq_table_max_nonboost_freq(policy);
>> +        cpufreq_cpu_put(policy);
>> +    }
>> +
>>       /* Compute the cost of each performance state. */
>>       for (i = nr_states - 1; i >= 0; i--) {
>>           unsigned long power_res, cost;
>> +        bool boost = table[i].frequency > max_nonboost;
>> +
>> +        if (boost != prev_boost) {
>
> We expect in EM fwk that the frequencies are sorted ascending
> and we return error during setup if the driver callback fails
> to provide that.
> Therefore, in this code we don't have to deal with random
> 'boost' labels with gaps between.
>
Hi Lukasz,

Thanks for the review.

You are right. The boundary is derived from the highest non-boost
frequency, so with an ascending table the boost states always form a
contiguous top segment, and prev_boost is redundant.

> Let's make all OPPs which are 'boost' equally possible
> to reach (at least in theory), so label them as
> 'efficient'. I think this is fair in 'boosting' case scenario
> and energy has not that importance in it.
>
> So simply something like, would be enough IMHO:
>
> if (boost)
>     prev_cost = ULONG_MAX;
>
Agreed, this is simpler and gives the same result for the non-boost
states. Boost states are no longer compared with each other, which is
also a sensible semantic. I will drop prev_boost and use the above in v2.

Thanks,
Guo
>
>> +            prev_boost = boost;
>> +            prev_cost = ULONG_MAX;
>> +        }
>>             if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) {
>>               ret = cb->get_cost(dev, table[i].frequency, &cost);
>>
>> ---
>> base-commit: f1ac44c32cba88ad65dcecd4a279661d14e93651
>> base-tree: 
>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
>> change-id: 20261029-em-rank-boost-separately-a7e7c7d78058
>>
>> Best regards,
>> -- 
>> Guo Chen <guo.chen@oss.qualcomm.com>
>
