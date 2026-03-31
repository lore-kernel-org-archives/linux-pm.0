Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A79188CC9
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774926897; cv=none; b=FTdf8DFB7wdnskRbpojjSls+oI50L9z6Xf5+/M00lpSCjthzfdvbKxGZ6SFe57yZl1VPiQPAp8b2I7fyP28oeGwl3zbTDcc6SA05Kmnu1UVJRFhz++f9J5l+4cJfVNw/4LUyNH2RoVuN8YRimRjeND1mi78zC0uQ+Yr0DKghfZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774926897; c=relaxed/simple;
	bh=gE47v/jlHal8waidCaJkjK71jljw8L8MHVqczw4Xkxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9gH9j+YVMxfwi3ZxWX1v9LffzmTsrNmZGG3H4O/cxoatj+E5YOlF02DLq5jmHEhizIHsupSHgfQNtH1bkKhV0qLaK2anBdlrX5jotoUXnxfvykmNuyfYKdLFOJQXdhggbU1tYuVq/Sn/JtumMxO2Br4ImiGCIvor/8gjt+qgWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dxK9Hedi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LG3wMw0Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dxK9Hedi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LG3wMw0Q"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UKgnlT1090270
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 03:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6GErhsTIXO11av0MrDBgwSI3DUYnGPzRbBpUnD6PnJg=; b=dxK9HediLYwjoeu7
	DeS5SOLeQZS9/d1DAM8kkOCZwWvPtZy6dvKU0IUrAL2YdrwOBzT0xxSoLmHV/A2R
	K7XIbamq+vAZ1QE2pxw8lFfB3ZLc26eD/ghf/IlRAdXlqA0z81YSj4S2GegIi2vt
	eYyyjH1SG/3ikeV9TThj52S43LQUyQSwUXnTua4Kj6KSGA6Jmi5QLWAaVyEuEqpw
	unFuoDQAWSnvmZAhe6qnUx28evUkUEB6mMNfPp2ahvEfF+gkd13Tjw7co1A43Tw9
	0kAo816Lm0OZK5fjXasmmycft9ILAP9ZTeKSs0vCCGtyc/dOMEkpTDFLsVyPl+ug
	Mp1gnw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7trd2jme-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 03:14:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82c8768a633so8910503b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 20:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774926895; x=1775531695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GErhsTIXO11av0MrDBgwSI3DUYnGPzRbBpUnD6PnJg=;
        b=LG3wMw0Q0RZvqD6cUoNsminMJ9G2TtbFU8y+PuL7knhYdBbY1RTT/FPlyPXM8MESZj
         yXZ1KHG4W2mi03rAxRRumubvndtQZEatmlqWDPtZ60N4W5DRctSbFUeoRRtRuRUB3wDf
         HSlqmspcAf44YJhLaPrjVwFjg2785E3rMI8WSL62AbdmO3LwwBxmMajOTBptZ4eKZHdI
         XFkU2+o5qRemmEQmdG8WHNh8jpoPyHR3ztHWs5PaUMJz7CQ9xFh4aypv9bkcPE2YFM8k
         gsW3wMVGjMi0CXpJPXjYCMibjvzZHBx94bFVfp29fQr6ZPXYIgMRuWhEzfUXtYAS4YXW
         OGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774926895; x=1775531695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GErhsTIXO11av0MrDBgwSI3DUYnGPzRbBpUnD6PnJg=;
        b=D1LhtKQ0L47Il1qkZ0RrnqogBN3Pox7R9UH0cNteBrZJi1EYRfdV5bFFP14qnnCRIN
         GcFntZK4TdiDFx6jScRiYKT+8rnMT/jpDy2Lmm9MGYemRTVAdH2cZjUul79bFPjuhHQT
         A+bW8Fj9zEMr/Lw8aAEeriwL8yiK0Du5MZhNiF1khE5Dw+PAgArLVpCcLd7+oqCViIGV
         gboNYdVrZdKkA9vKWpkJepmxbFfxJFhvQynhfawxYmDuzIw/pQ0v/mz7Fiqr+lZ94pd8
         uxrtL1GVSgDd5y4C+Ja3IBhpSz8SUxmvkRTODLDbPklAg0/uSyQ0nlET5sXiCQyo6wNQ
         a7Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWnvi5aC1hqIr3WNN/4TOBdr5fijbSZ9BqJJtiSjUsjmX6kcJ5UNwySZZjGU4HvBwLOiSOdJyBOSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUBKakUpkmM3RxLIxlg0AZsTmi0+cAtLQv0gyrhQ1HPE7XhF5
	mZXq1KbuyHbYIq5eae2cA5BpXepEOT5WqWdGK1Le0IxQBMoIwtS367EYA/UbB2dt4GMBj5wal7A
	Zx/XYvF9j5Jv/qI7mbQ5Zb73s9fZeKYCNavgNbHBeSHFNBCr6y+OsRbj5dzEwtA==
X-Gm-Gg: ATEYQzyDVcaMNSiLXsAWmtWYo+JfWCp1D1vsfa4767fmVTpLR/QoUunFwiCcukcj3Sf
	hAw+OOz7aPAk4T5G0StBYmzyj0OXf1gEGRYR7kHt0CecUMNBXEGdsSmF2mzznt0N5dKTKvaJenj
	7Ub1WjxSSqwwf3PKwHmhfOhFDB6L/p+FUOc6hMI3cggnGSushD6f4DxOa6B4vl+KNO/isENOQc7
	gOiOmAQ/z2eqrviHORiMSsNa9MIcFqCV2GrSwjMUdmixsZBFxPDJNo/CXnTn0WEIvulxgYLt1Sc
	eoMZHL2bDzp8+GrBeCoHyMFlFyyQ0dS/v+BEY7cXc8n/9qP+tSiUhhKceHMMBvhZxVvWOzxSmRa
	RbU2go22Fio8NoNs+AdUp3vrnC4AHIA0j8dJBJuwAc4Z4hFmxFT6vJAwCm9xHayUBY/KB46uAt6
	wysVkXGqctlLATmWWg
X-Received: by 2002:a05:6a00:17a7:b0:81b:1a87:9eb9 with SMTP id d2e1a72fcca58-82c95e4d400mr15094035b3a.25.1774926894622;
        Mon, 30 Mar 2026 20:14:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a7:b0:81b:1a87:9eb9 with SMTP id d2e1a72fcca58-82c95e4d400mr15094010b3a.25.1774926894163;
        Mon, 30 Mar 2026 20:14:54 -0700 (PDT)
Received: from [10.133.33.66] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caf5408efsm7835482b3a.2.2026.03.30.20.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 20:14:53 -0700 (PDT)
Message-ID: <bc3d5279-5bba-49c4-a268-f05b1151ab01@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 11:14:48 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] cpufreq: Add boost_freq_req QoS request
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
        Lifeng Zheng <zhenglifeng1@huawei.com>, Huang Rui <ray.huang@amd.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <perry.yuan@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260326204404.1401849-1-pierre.gondois@arm.com>
 <20260326204404.1401849-3-pierre.gondois@arm.com>
 <8261d970-ccaa-494c-91c7-6ebecce010ac@oss.qualcomm.com>
 <5syn6lnv4vfd3gapmlczkpkfob4oxrvfu3sozet2fog22mj5mw@mfyspzeruph6>
 <779ebbd4-d495-426e-bce1-020686c3f946@oss.qualcomm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <779ebbd4-d495-426e-bce1-020686c3f946@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9RIg7WUUsMP43PwIIsceEr5-AHEtZHwI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAyOSBTYWx0ZWRfX1bb/ojjH+QJ7
 pubaDvQ9+CBowljcPXiwlid6g3r2xKJ/We+5SZ+a4SqY5rlE9/JCmwMMRmYT6tZUZ8OM+9ZDPsI
 Jr9wTjK3yiahqM0x9tAXhXwDTCqArGW67gWbLk6Mf3Yo8uhByz1hz4zBxyeG872l6r7pjhFZYeC
 jm171c/o4+KN+yX6JLA7NqL6aJz5KfhOjJD/h1MaqO5n6gnPsEsw77rdgx92gkviauhMh5Puag3
 2bzN7zxsiO0PxEte1Cnm8n1s2FfzXqNCF5UaUU9ukD+hoDcuST4xWozB3GRJBc/1UylpDA+t/hq
 tHd8BIXiguRTkY8m+pKFexTt+PGhHd4uNGhm8qBeDBANWQuuVths3m452vg9zzPGMxzSzMX61dI
 Z9qO7o6lqt5TgzMp7NSxTGNC0QQYhwJQhS5Bj7proQJ5aacJnLVY+EGtbZXkaDdz3YJlfxHWRL+
 pORxE7mmxhASyBbwECA==
X-Proofpoint-ORIG-GUID: 9RIg7WUUsMP43PwIIsceEr5-AHEtZHwI
X-Authority-Analysis: v=2.4 cv=H8/WAuYi c=1 sm=1 tr=0 ts=69cb3c2f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=halu61jMk3QCD0Qrv40A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310029

On 3/30/2026 8:55 PM, Zhongqiu Han wrote:
> On 3/30/2026 1:20 PM, Viresh Kumar wrote:
>> On 29-03-26, 17:00, Zhongqiu Han wrote:
>>> Sorry for the late follow-up on v8. While re-reading the patch, I
>>> noticed a potential UAF issue on an error path — I might be missing
>>> something, so I'd appreciate a double-check.
>>>
>>> min_freq_req, max_freq_req and boost_freq_req all point into the same
>>> contiguous kzalloc'd block:
>>>
>>> slot0 (min_freq_req + 0) -> min_freq_req
>>> slot1 (min_freq_req + 1) -> max_freq_req
>>> slot2 (min_freq_req + 2) -> boost_freq_req
>>>
>>> If boost_freq_req is successfully added to the QoS constraints list, but
>>> the subsequent freq_qos_add_request() for min_freq_req fails, the error
>>> path does:
>>>
>>> kfree(policy->min_freq_req); /* frees the entire block, including slot2
>>> */
>>> policy->min_freq_req = NULL;
>>> goto out_destroy_policy;
>>>
>>> policy->boost_freq_req is not set to NULL here, so it becomes a dangling
>>> pointer into freed memory.
>>
>> Nice catch.
>>
>> The right solution to this I guess is to do kfree and setting 
>> min_freq_req to
>> NULL if boost_freq_req fails (just like what happens in min_freq_req 
>> failure
>> now) and then for later failures, don't do kfree at all but just set 
>> the failed
>> qos feature to NULL (like what is done for max_freq_req now).
>>
> 
> 
> Thanks Viresh — agreed, that approach makes sense.
> I sketched a small example along those lines for discussion only if
> needed: add boost_freq_req early when boost_supported, free the shared
> allocation if that add fails, and on later failures just unwind without
> freeing the block.
> 
> 
> + count = policy->boost_supported ? 3 : 2;
> + policy->min_freq_req = kzalloc(count * sizeof(*policy->min_freq_req),
>                                   GFP_KERNEL);
>    if (!policy->min_freq_req) {
>            ret = -ENOMEM;
>            goto out_destroy_policy;
>    }
> 
> + if (policy->boost_supported) {
> +         policy->boost_freq_req = policy->min_freq_req + 2;
> +
> +         ret = freq_qos_add_request(&policy->constraints,
> +                                    policy->boost_freq_req,
> +                                    FREQ_QOS_MAX,
> +                                    policy->cpuinfo.max_freq);
> +         if (ret < 0) {
> +                 policy->boost_freq_req = NULL;
> +                 kfree(policy->min_freq_req);
> +                 policy->min_freq_req = NULL;
> +                 goto out_destroy_policy;
> +         }
> + }
> +
>    ret = freq_qos_add_request(&policy->constraints,
>                               policy->min_freq_req, FREQ_QOS_MIN,
>                               FREQ_QOS_MIN_DEFAULT_VALUE);
>    if (ret < 0) {
> -         /*
> -          * So we don't call freq_qos_remove_request() for an
> -          * uninitialized request.
> -          */
> +         if (policy->boost_freq_req) {
> +                 freq_qos_remove_request(policy->boost_freq_req);
> +                 policy->boost_freq_req = NULL;
> +         }
>            kfree(policy->min_freq_req);
>            policy->min_freq_req = NULL;
>            goto out_destroy_policy;
> 
> 
> 

Now that the patch has been picked on queue, if the approach in the
current draft looks reasonable, I'm happy to send it out as a proper
fixup.

-- 
Thx and BRs,
Zhongqiu Han
