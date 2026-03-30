Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634502580CF
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 04:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774843236; cv=none; b=KIXoIBHDErrHcE1lqndMs3gE4JdOsMd1VLwSg711T+s0LZooRK7oltr5uPeiavLAM0DPWQSXGemD9aT3y0T6BLKZboctw6YNSWexhjZj4V+06qHLJanzzea0qm2bs/3coYOjLdZkKmn4yDeVhs+Kxzca8sqskv0EnqUaAJ3jYVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774843236; c=relaxed/simple;
	bh=IQ4Hv7CmFJDeTRg3ksKaW7dAb8F2JaANB1UcQ0r6UHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mglCf1kT7MX+RwXogWCL2yrin4tse0xv2m5fNJrZbg8kphiho+qJUaRzbL/n/kjMjMAS67Y+Qd+k5kCOxJakVfO+oLWpqel9yJd2xGXKZsQHwe6ifMZwmVxoTXUreiy+OuwNYXDlx8beMhlmle/0uczzg9q9XfjnZkRty7f4Bzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=daHPCWMY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QpxcW04/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="daHPCWMY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QpxcW04/"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TAhZRX201416
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 04:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nsc1vnHePPh/q8rVFB3VpPaeFGpcpTqB5sVGBQPhgwc=; b=daHPCWMYK39cOcxE
	Tmw5+Nb97BSKaX483K3b5PomPURPt+P5VRKgwoQc1MURo1+EXqC55YMGVb6BQPZd
	b3UiiKrJGQp5QPLRO74h97y9IkC6jHzsCldj7TzW8l6koxEvrPFNJ1NZ5mmRQmEf
	dJptLluXwc2yXykRn3e7juHP5P1XUTTR18xw1bNR8hsCM6zBY53+vWSVrkoPldA5
	tL+vr3ks3cM3QXD8v+D2WiPwY/E1zCroR4Y5B/ZAuMgSI4SFx8enijTOHx7i5MZt
	UKiFfnqot0czktnts28Q4EG9dvfEPhBDMxlqkgTSFRYVFaJKQDNLyRzNZ3gMKtJD
	w4RAAQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d66jwmcvd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 04:00:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35d92f8408cso1781475a91.3
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 21:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774843233; x=1775448033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsc1vnHePPh/q8rVFB3VpPaeFGpcpTqB5sVGBQPhgwc=;
        b=QpxcW04/q35UrIJ+G/i65CnQde+ngeMFJIY+4krVNyuGwyPE258q4+46asiNzQWc2j
         XHo/+rrwrnpD6WP1Fo5E7O0p6qvvOYucDTxWNhvj2ARelpTz2pvVMgqL7ckMY3n/bBMm
         2N3DixXw31X0ieZKUck9AkV/RCeELQFd//nzuA5hvAkJusBNUxUmtGWzSGgvAdhkDc2R
         Fv5i0QFx4kp+slLbWPsVVv4Eery1VJ8aBk4L0+HxLeorxw0LqI+YMz5Xm1vv6TZaFZLy
         6eUeOhIj19IWvJC3nE4hGNv6MHlOB6kf5y9VyIevLrYelEJTmX2RMnBe882CnJ2PQGMy
         aQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774843233; x=1775448033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsc1vnHePPh/q8rVFB3VpPaeFGpcpTqB5sVGBQPhgwc=;
        b=m0600udD7f+zy25yzZjZl5VAmGT/U6upxRgrSc2qIJoOMl2X0zkhLGFfFFLP7/jaS/
         rv5+Bv7mGcEKJtaanRy2HtxL9/9nadkMTwKZEiF2kYm0oP6cnB34K3II6OzbMmDnOYTC
         WOKTMr2LFnss6FYcg2wmeR05ITVdz5+I9g91lxbGx49ImpBjmqjOsfAm3qPZQDbzXBge
         2Wqa3WXrMzGfyOAU9KpEGHS6F1VmbFl4VsURxqESHLuT9krICa6tVtpz7xwA+2E3Vd8A
         yTWulG9ln8CZyUHWe0UBHbbPMrxDe2GlPNHYT/JujColYafJqpXHuwcS9p+hHVdci7EQ
         9y8g==
X-Forwarded-Encrypted: i=1; AJvYcCWlV0DpevTljA53XZelEJN4ru3nHXMiyUYkMPe/XMHhuCNvO9AaFs1QFH+m7jgWu0vAqH65+cCKOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yybz8eH7ZBVtxkDAzCFDWt4zGtVPxjalwpRpwse7fiB8+TC0/xQ
	MUgyNyMXAg9anoyW7Oz5N8P06WDIfYjo0QRDhowUbk05+Xn1VwPQGLzN04M87IyiBQWKSiIveSA
	5wIQ7Q9SgV2NcagI3MkAQ3hgYfC0X3A0Ncf2pUwC4M76ZPN4eXq1y0XmODLTSpw==
X-Gm-Gg: ATEYQzxErz3dRZV7UUvtu26VkZfcRwv3GRNAvDJhH99zeS2Lvniaucvg7LdRjFCjUoK
	o8cUebFScZaM53B9lRlLftC9dZXqp246BZf6sCTU8eWwcHP7Bm9lreVCQZsWwirSwkmHaunuyfz
	QOGtC9Bvl1tYbVY9AT+Z63KU0TMCG3zysBitXtyt0VHGhefQPDLHqSb477FlkTnDwnJnZSk9Gzt
	SX5AycbkYy6BRRoT2D+ptbfKZZCVN5gdW8yJVxHpzcN8brZZkEphewKZ6pAvFuQpywdQj5TGLPq
	9TjO53kAU445LT3FeTvmOKgLDtuQFQygHT9ATvcWInTJPd5Gn2flTUOnOwbjdzHyGJi1crbaW5h
	abbkouW18OkzFMVaIK6XgbPCil+UypIHttPfe0kHjHmw9WUjPfykWHZ1/N3sL1wgAgp5IY/SYso
	79yf4Mhek6snfkkXs=
X-Received: by 2002:a17:903:2f82:b0:2b2:497e:3f6d with SMTP id d9443c01a7336-2b2497e4b68mr52426585ad.8.1774843228212;
        Sun, 29 Mar 2026 21:00:28 -0700 (PDT)
X-Received: by 2002:a17:903:2f82:b0:2b2:497e:3f6d with SMTP id d9443c01a7336-2b2497e4b68mr52421765ad.8.1774843222826;
        Sun, 29 Mar 2026 21:00:22 -0700 (PDT)
Received: from [10.133.33.66] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24265aa9fsm61399435ad.20.2026.03.29.21.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 21:00:22 -0700 (PDT)
Message-ID: <6eff4517-cc4b-4f2f-8e39-6cfe8b18c4dc@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 12:00:17 +0800
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
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <f61f81ff-7e42-414e-a196-d20f8717f5f7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I8dohdgg c=1 sm=1 tr=0 ts=69c9f562 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=LmuV2tqYhPxcIh0MdAwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: znhyZ7LTlbGHrqqM_gAAouS--v1tfnFd
X-Proofpoint-ORIG-GUID: znhyZ7LTlbGHrqqM_gAAouS--v1tfnFd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDAyNyBTYWx0ZWRfXz2XxRKx7IhpA
 Za7c5/0bjRGlf2f1o3Ct4uPPNvgmYC98qUC9A6jFr+w2elmKmj7WGmkevcUbRus+yvLS9521lbz
 RYJ8LH4yTGJKaP+ajSNJ7DxctQMtySwRwmCkZS+70mUmQRd7X6hHY2B7Qab2LB1FVoH9Ua9AmMJ
 O9YSREbxn1AWRLxZPjMu0p89aZ9PZGfIMqZTTduT9hSjflUGNNHGJUMSqlsoj9H2A5pF5mgrPUy
 k7gd9y7j5/Cdd0J06avWnG3uVW83E/h/meuq1nhQwIVwoU84aXZxhkyYtqSssmO2/rG/iIPyj0W
 Dr2NrkVgPcE90BeS+CmrUwQErkD9NuDEh5kGHnfXukETrAhkF0PXrAwQgfo8QDFIkub1L0ZVRwS
 qW+xVMcH4eXMuQJUHuhjlV+LvxtY6PbID/ZGM0YbRXNhg6zeb6vuLu2f4YSF9aVUFWVpDFtPPhk
 4NR5nHtEJvZQdXsax0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300027

On 3/30/2026 10:10 AM, zhenglifeng (A) wrote:
> On 3/29/2026 5:00 PM, Zhongqiu Han wrote:
>>> @@ -1377,6 +1386,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>>        }
>>>          freq_qos_remove_request(policy->min_freq_req);
>>> +    freq_qos_remove_request(policy->boost_freq_req);
>>>        kfree(policy->min_freq_req);
>>>          cpufreq_policy_put_kobj(policy);
>>> @@ -1445,26 +1455,38 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>>>        cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>>>          if (new_policy) {
>>> +        unsigned int count;
>>> +
>>>            for_each_cpu(j, policy->related_cpus) {
>>>                per_cpu(cpufreq_cpu_data, j) = policy;
>>>                add_cpu_dev_symlink(policy, j, get_cpu_device(j));
>>>            }
>>>    -        policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
>>> +        count = policy->boost_supported ? 3 : 2;
>>> +        policy->min_freq_req = kzalloc(count * sizeof(*policy->min_freq_req),
>>>                               GFP_KERNEL);
>>>            if (!policy->min_freq_req) {
>>>                ret = -ENOMEM;
>>>                goto out_destroy_policy;
>>>            }
>>>    +        if (policy->boost_supported) {
>>> +            policy->boost_freq_req = policy->min_freq_req + 2;
>>> +
>>> +            ret = freq_qos_add_request(&policy->constraints,
>>> +                           policy->boost_freq_req,
>>> +                           FREQ_QOS_MAX,
>>> +                           policy->cpuinfo.max_freq);
>>> +            if (ret < 0) {
>>> +                policy->boost_freq_req = NULL;
>>> +                goto out_destroy_policy;
>>> +            }
>>> +        }
>>> +
>>>            ret = freq_qos_add_request(&policy->constraints,
>>>                           policy->min_freq_req, FREQ_QOS_MIN,
>>>                           FREQ_QOS_MIN_DEFAULT_VALUE);
>>>            if (ret < 0) {
>>> -            /*
>>> -             * So we don't call freq_qos_remove_request() for an
>>> -             * uninitialized request.
>>> -             */
>>>                kfree(policy->min_freq_req);
>>>                policy->min_freq_req = NULL;
>>>                goto out_destroy_policy;
>>
>> Hi Pierre, Viresh,
>>
>> Sorry for the late follow-up on v8. While re-reading the patch, I
>> noticed a potential UAF issue on an error path — I might be missing
>> something, so I'd appreciate a double-check.
>>
>> min_freq_req, max_freq_req and boost_freq_req all point into the same
>> contiguous kzalloc'd block:
>>
>> slot0 (min_freq_req + 0) -> min_freq_req
>> slot1 (min_freq_req + 1) -> max_freq_req
>> slot2 (min_freq_req + 2) -> boost_freq_req
>>
>> If boost_freq_req is successfully added to the QoS constraints list, but
>> the subsequent freq_qos_add_request() for min_freq_req fails, the error
>> path does:
>>
>> kfree(policy->min_freq_req); /* frees the entire block, including slot2
>> */
>> policy->min_freq_req = NULL;
>> goto out_destroy_policy;
>>
>> policy->boost_freq_req is not set to NULL here, so it becomes a dangling
>> pointer into freed memory.
>> cpufreq_policy_free() is then called from cpufreq_online() and does:
>>
>> freq_qos_remove_request(policy->boost_freq_req); /* UAF */
>> or this boost qos req will leak.
>>
> 
> Good catch!
> 
> How about remove the kfree() here and just leave it to
> cpufreq_policy_free()?
> 

Thanks for the suggestion — this is another fix approach we can
explore, but there seems to be a small caveat.

Some additional changes would still be needed; otherwise, removing the
kfree() here and deferring it to cpufreq_policy_free() can lead to a
warning.

The reason is that we neither free policy->min_freq_req nor set policy
->min_freq_req = NULL. As a result, when cpufreq_policy_free() later
calls freq_qos_remove_request(policy->min_freq_req), it hits the
following warning:

if (WARN(!freq_qos_request_active(req),
	"%s() called for unknown object\n", __func__))
	return -EINVAL;




-- 
Thx and BRs,
Zhongqiu Han
