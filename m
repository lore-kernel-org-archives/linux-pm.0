Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890901;
	b=owVGO7cBNLgjy+ioFLMvzVy57bByevc5ND2dGeWPkYSCszxuwUUjsSSbS0mjH3iUUF23
	 HTH4KkhfbhleeJY1NcYZNz8f9AXinFlyDL7+YpDiA+CV0p4cUVB9CyS56mvl/6oVWj4Z8
	 KxKftNTZ+o9MuHe34mftSHWpTzPMGudpC/UgnIL8cpl+ZAoh92FAOhzBBIVijUNuaVBdv
	 sajvYzg5i76bYrV6UdVfqzDVH5VaknvnmDiYS4OIx4S60LbGB2zUVMOAaj1ChXdpGSFTm
	 JtUJ+hWBPtWIOdRairb1UzkChCVGOWIH8aRWQ/A2H67qCYWwwEotdLOQMtPeBPW/+3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890901;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BlHDPlEpvTz11MD3jRqdyLcBMjXBE0jtvt8v3OddGFo=;
	b=cMbHjsfHIpWlYvswZrQEWI+gnHY+hXfIx2Khb5UO1lXnDMjW9Xq5LkX4CaIATN3zhJrL
	 jHfvEvmt+PG22+6c8N0KnAu6AAJ8S6sJ5nmBZaieUGN+vFjnKxflkiA7+b+nY86aVCkGk
	 qngA6199stq2EodNCWVtF7/e0FbrdaKXMsdbzcP/chTBHi6omJfoNy84TO0gqeiVRuZhp
	 Ite+gHOVRReQXEAWTvTwsSHLE6X3dgQs1rzGwUVoNHJjYkD4sxJtTjmDqeE2bTrrbmTUg
	 IYkGKMY3lO6sKHGj+rc+Gl+SJGqWVqWFHt5Vdx+ws895vvprcbDzN+2VOO0ulybE/Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QEdU06t5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PVrZvMik;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ADD606A31B
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54ADD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QEdU06t5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PVrZvMik
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EQFUR2004485
	for <linux-pm@vger.kernel.org>; Thu, 5 Nov 2026 15:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BlHDPlEpvTz11MD3jRqdyLcBMjXBE0jtvt8v3OddGFo=; b=QEdU06t5mEtyrM2J
	ERlC8FGtVeONyCQFYjxlDNWPhEb+JYPIE3SUg8xPztDcWCZxRhn4wob13J/Zlr1g
	oOc3VsnF3IreT3f1A6hOYbH7ZEBjNlz7A7GhHGbmy+ADKK20apjSXbiYv0jHyVyZ
	lo/qjGdpvZWd/KnhurhvUVOFJSLu4jQv+a1e5sY8wmgzmSJEqykNDYcaBRpWFHn5
	dwYjuufESK1Jbmd062zUJ3bGKxte0mxIqpm2aQ071saJge7MgGueoTnqtl4NZ4Cq
	hmEmpr/7I7CsMTJM2MkQQFuJtQOBFOTkM/KY/2vP+zl7OHGxK+352N9b3Bvhjw0b
	Qtyeyg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqpd187s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 15:01:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ac0ae43900so2306601a91.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 07:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793890900; x=1794495700; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BlHDPlEpvTz11MD3jRqdyLcBMjXBE0jtvt8v3OddGFo=;
        b=PVrZvMikTc220iBfhzCeHXLAANp4sgoXvO4+DZtC5DBXWZoPLqCRk26d3TvjiJVi4l
         hNvyU8sG2KBq1U58VctEA8Wd0hikApkAPghGmJaGtlzifAPyDe8ms7yk99FTlwIN817e
         VA0uCRRUIpLkVkHI+aW2Xz5/TGIqVO2vF905MveB22hRidm3r6bryyzAilWc7rHF0h3y
         yfD7sxxyMzimqKKjtHXRfxOSaQSmUkVU7Wb54PsPMjpsCxkuS4MoRGXLPJCYzgJcPfAA
         6FXLGHDe/k3U6OLc5mBtvOCV7I+Ik/2K6KU965LyxfVpTKUcW3GpRSMMyVwrjoox1Dd4
         21Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890900; x=1794495700;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BlHDPlEpvTz11MD3jRqdyLcBMjXBE0jtvt8v3OddGFo=;
        b=S2KzeB3ZxM3Vz57DFE0li0CDrFjCIONUiRcoauqRW83CNvgwZtXA37BXCMf4lguIEU
         fapdRQAbR945FhUnD6eZRNA0DNy2UJpHvlAdS1nZPBtlblY5NpIpbLvO0CQiQHKc+Kpd
         j0pFOlnocXqvz7U7lhwXgyoTwECI1hJWwlUAvcP2OtQz7bgnAVM/8YHm4VXF60OK3AZJ
         C5k/eRTZXZv3wx93jl3zsE/V+TGVQiPdjrGIxFyDOgTJc/Um0Y9g/rOtTsn61CECzFnE
         6axRYf9QRnzYQJZ7Oo7XDSff5rdf8LfCriNviH/8eYv0MkqxZMwVPJClZjniyd9j7dqq
         fKWQ==
X-Gm-Message-State: APuU4Z8VknbEDEOrzVfQVxlseRb8vJaURotb/7Am6xQfec2w8dGAyAbV
	m940CvOHdRLs/w4zrn/A6ytzBnEmFofgI+uFZvx6S1qBow68Ije93BoiUJYfTvzUME4rSZGtnTL
	yftRd0CjfV8CUCt7kYQUjcvwx58rfzQx/cBKdAz7WBuU6mvAm5Nkgqlvro4b/4A==
X-Gm-Gg: AYBFou3rIWYNwhJ0p4C1k6RvsplyKRcXYec90dmBdpT9GCZkIss2gQVpEMjnYQ+SnUh
	YLhCzVULR55vCB4fCRvshuc61jCkKaUuju+fRTtvVBOtiCNoPPMl10+rb7zWm/97CSSEsB893XH
	2YBcJneX2s2Js+plpMKh+pGuRRE6Mk2rK7Bq2ks4G/nx5BDP41utyivyyyPwpEq/VnRBuZlIOfT
	xIJkgQiD4+crjufR6FrAwf4D/dcMiIw6pZo9hpS8vkt5nDlAHvQ66H4R9c79Qtz04ANd9APAit6
	638TBJuqr5CGioJt/msdZs+g+PVioO0cZvoaLmGEfyi7EbIudtcQ488pDDZOxrIMzZM2kEEFWYg
	UCybsQQLe76GkWp7XZujrKhW5mPaxoGw+N3XKMYqommNEEzfyAC1AVO5HH4rmk5B0y5hUnakpWl
	55ES9Nd3t6tFoGsrDNNiG86CAeptC9/2Sb0G1FVZffoRox
X-Received: by 2002:a17:90b:356:b0:3b0:9183:23ef with SMTP id 98e67ed59e1d1-3b09183279fmr3992260a91.3.1793890899481;
        Thu, 05 Nov 2026 07:01:39 -0800 (PST)
X-Received: by 2002:a17:90b:356:b0:3b0:9183:23ef with SMTP id 98e67ed59e1d1-3b09183279fmr3992031a91.3.1793890894198;
        Thu, 05 Nov 2026 07:01:34 -0800 (PST)
Received: from [10.133.33.108] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0969b35c7sm4179157a91.3.2026.11.05.07.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 07:01:31 -0800 (PST)
Message-ID: <4606b154-e372-4d41-95ce-57b17f0f1d4a@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 23:01:24 +0800
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
Subject: Re: [PATCH v2 2/2] cpufreq: Serialize global boost updates
To: Sumit Gupta <sumitg@nvidia.com>,
        Christian Loehle <christian.loehle@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhanjie9@hisilicon.com, superm1@kernel.org, zhangpengjie2@huawei.com,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261105090311.1026648-1-christian.loehle@arm.com>
 <20261105090311.1026648-3-christian.loehle@arm.com>
 <fd2b81d0-df9c-4a07-bc47-a2a6460304f0@nvidia.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <fd2b81d0-df9c-4a07-bc47-a2a6460304f0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1OSBTYWx0ZWRfX9tVhb2vMa8Z/
 P3bS+bq1q51CmmFrwicK7ywyCji0uhkKsxgcOKAm+pvrrgLWF18dPQOcagTmz0iPDF1qQHTMbfq
 ZwOg9jkdWTIW/Ya9j6x9qAhVXxwlGqQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1OSBTYWx0ZWRfXxUf8Xno+M16l
 TnZGzATpvzWUqnQW9EGYolAenYYc58lIo3CEyQzs6pR33u16WDmngfnTCNUV5G38u0Qu/Ijtv0v
 cmZ+OqquvyPGpTgaNflHl61G0Oe0Rt5FCQXodrWOft7cz1pZbc+k+focWEdrklt6T3u4v/PeYxy
 xDZUyKs65MXo4oXlceEwXncChRWNIePr+/494V5c7jVQPxRhTipTeDVQbhyQRKcLiIho+Z+Dbi1
 dOn8OsQ7bK3gcSRFCldDinQHVPhphvPeqdN/pqKvTuDJruGdFvaS6wBIQKEIasvIn6wYShhEgx5
 HyuXhK2dFyhhQvowwlx8rsz39aZCABlc2bSClDBBLBds+02aQ7/1FM32fNcc5DrrpSC8+tl9ob6
 Ye3uMg/Bdxba6EIPj8nacpI/qkaS4HGxstBC4Vce3Q5zZQJiBrOB5irGrkcJVDS/C3v/BNyIF7D
 YMjX6l0avYkSpk3/L6A==
X-Proofpoint-ORIG-GUID: od0OR3UEOkGH4sy8rXtNKh8fdVTz47M4
X-Proofpoint-GUID: od0OR3UEOkGH4sy8rXtNKh8fdVTz47M4
X-Authority-Analysis: v=2.4 cv=Y5JtIReN c=1 sm=1 tr=0 ts=6aec9a54 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=i0EeH86SAAAA:8 a=Ikd4Dj_1AAAA:8
 a=doKhQEW8VQ38Gr0XSBMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050059

On 11/5/2026 10:41 PM, Sumit Gupta wrote:
> 
> 
> On 05/11/26 14:33, Christian Loehle wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Serialize concurrent global boost sysfs writes with a mutex.
>>
>> Fixes: 6f19efc0a1ca ("cpufreq: Add boost frequency support in core")
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> Reviewed-by: Pengjie Zhang <zhangpengjie2@huawei.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 23a77f5524df..d95c849f79c5 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -2810,6 +2810,8 @@ int cpufreq_boost_set_sw(struct cpufreq_policy 
>> *policy, int state)
>>   }
>>   EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
>>
>> +static DEFINE_MUTEX(cpufreq_boost_mutex);
>> +
>>   static int cpufreq_boost_trigger_state(int state)
>>   {
>>          struct cpufreq_policy *policy;
>> @@ -2817,6 +2819,8 @@ static int cpufreq_boost_trigger_state(int state)
>>          bool boost_enabled;
>>          int ret = -EOPNOTSUPP;
>>
>> +       guard(mutex)(&cpufreq_boost_mutex);
>> +
> 
> 
> The policy->rwsem case from [1] seems to be still open. The per-policy
> boost attribute calls policy_set_boost() with policy->rwsem held, but
> cpufreq_boost_trigger_state() and cpufreq_online() don't, so they can
> race with per-policy writers like ospm_nominal_freq in [1].
> 
> Could cpufreq_boost_trigger_state() take the policy lock, as
> cpufreq_suspend() does?
> 
>    scoped_guard(cpufreq_policy_write, policy)
>        ret = policy_set_boost(policy, state);
> 
> [1] https://lore.kernel.org/lkml/20261030172745.2045743-4- 
> sumitg@nvidia.com/
> 

Hi Sumit,

Could you please check whether the following patch addresses the issue
you mentioned?

https://lore.kernel.org/all/be3739f8-e668-4711-912c-91459d77ed35@arm.com/



> Thanks,
> Sumit
> 
> 


-- 
Thx and BRs,
Zhongqiu Han
