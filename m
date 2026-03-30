Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B893B6350
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875344; cv=none; b=BnVr0uvvmoJ2PQFHi4th4vpmd6X8Uyic+1OMHDz1G9c4aeDwEsmH4A8ygP9JZsQC3+CNR7lV7/j0aJ6G7Hd4o9+6mZam/weOMCi5NSMRf/fi0xm9JdR89PvCNpk8zR2iXkHupdDkiw8FpFiclO2SMWlRwFR/zGj0QaUU52vYqcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875344; c=relaxed/simple;
	bh=S6U7UmH0LJexZT2Yg+k8EzJJHGZCrst4uAeg0njQfpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9PBPNStN79kvTtjYTriK41BwefsD+mc4n5/xdXLtFpUYAVATKP8s+9Fuc3cnfWSc7Ed4CO9qY9cn0BAJC2Ytf4TnoRgpVgNW7k+MffE0FV3lfEa5DMH2HsgA0nbuhVJNaIfdE/LEveUk5+UC7ILU0cOtnHzXuOaIEoVvSdHgxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZEBAnid; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j/ZYdf/u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZEBAnid";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j/ZYdf/u"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UBENd21402844
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 12:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jkVV4a/r5iZSHfM+rEJEA/YjWVQZuMXKF/bu/rTzHMw=; b=YZEBAnidEiaeV8o7
	5dbZmr5vF7bTO6jrDPDIUukBAH87L/3jXiSgwfGqGqXKiHSmjYeGgSc4Ru14WccR
	w+I7Bl6k4jeL6XKmfecauIPKBjuIh5ruI3rx83FLMMGKE2I/IGq1Vkcsd+0SVx1M
	DsCnNt4UAIp3KAJ2+pa+NymUTwLRTe05AoQ+x1pVHmeMCEqn7e7LprnWXt5VfZ6W
	la2VoFGqNDd4ooliftBxz9gttWKzlt+2vMOsDH/Uf/jfXJpDjOeCvW6DKrraFyfA
	sw/yCdCq1QTsYqx9rBPgQ4jq4x+EFExrgdXzmvOJaypDX58YH0L5FLDCfhx9S9ut
	ScqS6g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7r4h8g2g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 12:55:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2523e0299so33244765ad.3
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 05:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774875341; x=1775480141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkVV4a/r5iZSHfM+rEJEA/YjWVQZuMXKF/bu/rTzHMw=;
        b=j/ZYdf/uDkIEzjvCPchCtsvFGynyJGy1R7Qo+0lwUbl4XrH0oMH5fP89T4h4mLB9uv
         6lVZm0OCh2EWXGkzKXehd3pmqzlmVwKJ4Dkzx/eYA46yWKjb2GAtMJPl5DW047YnJIS3
         WXPjUcEhkYdW4cTqsacPotXVEKIwHCGDNXnExQV4yFRYe+LBHUjMwHzypX+Tl0DdxL8w
         U3pIjuYsl6EHGZm3yqPUXfiRDLLKXoTabLElcNl6BEkr2czWyvtMvlDJ7Ox1WZQ+iq5X
         EwF1bMZ4/hv9u75cbMDSWuI/27cQnbHlMUD4fvpKRMxyWBcRAs+YsXY8ry9KjrvxkFRg
         uqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774875341; x=1775480141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkVV4a/r5iZSHfM+rEJEA/YjWVQZuMXKF/bu/rTzHMw=;
        b=mkZulkpXqWKPY1f4fEQaxmi6r1ICh1qjCitxoJQ95itY5/7e3FEv4c4seY+qOPz1Ne
         +BQ3yNXOwIvhDdyTag9EClBwzoHixEZQiLT4iQrCqcw30WQPm5y56dr/2De9i587x0Lx
         vfs/bgbCE7D5gemXI6X8plcEyKPwej3hT7dy3T7xUa5dkfDFEsYCKEQm9f+D8DJeUdQn
         48HnvdZUmavGniIGyKQwXzkjeIfQfmxRDsjKXE9lqBpRAX5FC56vT9GrmV+c8oBcbEeh
         6pteeGKFZK0xVX2oMn01+C5lw/Kmhvs84UgBF5R30qONBrQ20cgXnFeNDoEqh0DUzr56
         0tEA==
X-Forwarded-Encrypted: i=1; AJvYcCW6rafQKGUxWbGd/l7cyol7UiXew/zOCfq0sUC8CG7VdZxcpKLNposm3neBtB4FzL7y3LRY6/IASg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIcUbXUiApdNF+mP3yXoVwm20El2gxeVHNbQA/yEQVa1HA79H5
	bWlv66hEqtV2jhWORLCJzB2X0Kr16C/U8czwDHXrEqVDTLz6S9WxLZbocqFP9mxstyRhZFPlwuu
	8ujT5bIBks1xZ7kAdHUJD8jDSP6FCcushLrAmqMJnWwPlr6KOpZMbAxXrvx71KQ==
X-Gm-Gg: ATEYQzyu7XBir8IqAHHrOqelGA7tIr2P+IScDY4fgeRiHEk1avZF1mLMyUGP4L19+c8
	SpaRxUmw2A1aMTXmkDBusQYwZAXf/UzmR1eEC3h9DErnQNeNTtQtaJ2012TiRf41NdZEaACbbrL
	UisXWXBZLwIF9XGGKjlSW0Xfma28wcgJh0qq8sxOQgVZyPU9MaNOlphEqNqAvtxZoTg8qCaGbFo
	Azaqf93ih95OJsGvdweJrI9sX5dcJykh81VKkXI0tURf7BjMej9POxb2qFJFiIQhZrLgQVYdGXp
	hOBe5trro8/WjDsnJh0+X8Z9umitITFdrChHjXC5m4OhHHrupj4TQs7/b+9eJAJfWDsHVtYuHx3
	c3xgMGl8TRdYWiNUNxbz4bn63kllZcL6LfhqySe6Z2Va7nUHHVkeJf9CvImShIuL53GucGVxNVl
	YZOlbm8TiF1CizVeMy
X-Received: by 2002:a17:902:ef44:b0:2b2:50e1:f104 with SMTP id d9443c01a7336-2b250e1f694mr45155255ad.3.1774875340859;
        Mon, 30 Mar 2026 05:55:40 -0700 (PDT)
X-Received: by 2002:a17:902:ef44:b0:2b2:50e1:f104 with SMTP id d9443c01a7336-2b250e1f694mr45154865ad.3.1774875340335;
        Mon, 30 Mar 2026 05:55:40 -0700 (PDT)
Received: from [10.133.33.66] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c5f5bsm83321615ad.82.2026.03.30.05.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 05:55:39 -0700 (PDT)
Message-ID: <779ebbd4-d495-426e-bce1-020686c3f946@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 20:55:35 +0800
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
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <5syn6lnv4vfd3gapmlczkpkfob4oxrvfu3sozet2fog22mj5mw@mfyspzeruph6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEwMSBTYWx0ZWRfX67V/kAGjCjgY
 hqfe002P9JojhKOjIk7iRFAVbwJSKPPQO0hcqCHy3G7dB3Fz0fnGGwbyORCEOe0PuIJJdNzHkTH
 NiVvM6MwIiM4/I0+PKZ50Kee6f6bO2ex33DilBlCZAxxIdujlhQeLmfevgQ93gFer1PDXBOYkMQ
 HF/1P46fTJGXstimORtmfUAEDjvxIouR2jd4QsGOFXd0CCCS03oVfG/1zAOLPvGpcqtKLnZqR1n
 Ewx8cNeRUWWMLHZjpiaaLZqx9kbgsyaCkf4kUxrQvSYAujppjnaYulHI6n6Y5tQ4L4n9kEaztig
 QrQ+qnt/mZW7dM3ULGnL4vIh4RundaflSjyOIeNkX009fM466mfeflEkqTZgL+gRbWxkxiFWIdc
 bf3aXR9EtXlrbfr4V5xKIX+uUREt3Uh5XHL3FWYZOV6qmU2QgfRj0Ka64txkqBDndpp4CSxmSEE
 DloCKmkSQNSuKjS9p+g==
X-Proofpoint-ORIG-GUID: om6zUjP0U45Y3GXd81e-83VoWdESaK1k
X-Authority-Analysis: v=2.4 cv=PI0COPqC c=1 sm=1 tr=0 ts=69ca72cd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pypvI07QOi-ZmVI6jLsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: om6zUjP0U45Y3GXd81e-83VoWdESaK1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300101

On 3/30/2026 1:20 PM, Viresh Kumar wrote:
> On 29-03-26, 17:00, Zhongqiu Han wrote:
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
> 
> Nice catch.
> 
> The right solution to this I guess is to do kfree and setting min_freq_req to
> NULL if boost_freq_req fails (just like what happens in min_freq_req failure
> now) and then for later failures, don't do kfree at all but just set the failed
> qos feature to NULL (like what is done for max_freq_req now).
> 


Thanks Viresh — agreed, that approach makes sense.
I sketched a small example along those lines for discussion only if
needed: add boost_freq_req early when boost_supported, free the shared
allocation if that add fails, and on later failures just unwind without
freeing the block.


+ count = policy->boost_supported ? 3 : 2;
+ policy->min_freq_req = kzalloc(count * sizeof(*policy->min_freq_req),
                                  GFP_KERNEL);
   if (!policy->min_freq_req) {
           ret = -ENOMEM;
           goto out_destroy_policy;
   }

+ if (policy->boost_supported) {
+         policy->boost_freq_req = policy->min_freq_req + 2;
+
+         ret = freq_qos_add_request(&policy->constraints,
+                                    policy->boost_freq_req,
+                                    FREQ_QOS_MAX,
+                                    policy->cpuinfo.max_freq);
+         if (ret < 0) {
+                 policy->boost_freq_req = NULL;
+                 kfree(policy->min_freq_req);
+                 policy->min_freq_req = NULL;
+                 goto out_destroy_policy;
+         }
+ }
+
   ret = freq_qos_add_request(&policy->constraints,
                              policy->min_freq_req, FREQ_QOS_MIN,
                              FREQ_QOS_MIN_DEFAULT_VALUE);
   if (ret < 0) {
-         /*
-          * So we don't call freq_qos_remove_request() for an
-          * uninitialized request.
-          */
+         if (policy->boost_freq_req) {
+                 freq_qos_remove_request(policy->boost_freq_req);
+                 policy->boost_freq_req = NULL;
+         }
           kfree(policy->min_freq_req);
           policy->min_freq_req = NULL;
           goto out_destroy_policy;



-- 
Thx and BRs,
Zhongqiu Han
