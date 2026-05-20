Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206835838A
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264258; cv=none; b=nrdz8x+gHJgAENWzxxNpR9IM0gz30smMQv94UozTbQ5umK3tyOdDvVXcdpqALqkaTyD/wHdBzrW2KmbWf5wXNIfbltctfdTRUJSNfo12XrqqlZ1b2oU3gPn5Ed0XqnyYBVVCLcxVsuUToRVGhnIAHO0wER18egk6uG6YJklSY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264258; c=relaxed/simple;
	bh=O9IZHnHuqykZjjGDn2bKzNALImW5dFNcLjkWFZi7Tqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECMz9JTOweQItgXsvdEAZymkNRHo5ztKe9EV2xVaBbPuqHKQzaowBu2mN7v0RJk3EdcOkMDqdqMK2tuo6CbsHMCCsTgTWjo9ecahLUrn8rJOhX+k05qPOmzK8AGBBswEtMjLRHg6ss4f7tURaRHBZGeyrW+BEZDzSZmJFEYqQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jn6SEvsS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FhSNvYhP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jn6SEvsS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FhSNvYhP"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K72rFD2867847
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 08:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uc7Nk43l2dIGUbmdD6/LYMAf0PAnw6/rOvilHT/UMso=; b=Jn6SEvsSjrePkpWc
	S/nNHhWSjNI/9ENR5zR1RjdUnRrN4u/OY9D8KthajSibK2rN2Awzg4ZCrQVG6FZU
	4xanTL0UY9atr7PRhC6mdbWBAlccI4dI6h3aMGZzAI/bzkGWzLX60d0fmaooa7Zi
	bSPBR3urcE5cA1+1OFt01kzQjU5UExbrBg5VJsP36bDmqESnxLsjJvO6GZJ77tkQ
	Oi8wE8SABq4eEemovsoQU/Sx6hmv+ZTJk1slBtpEPBqqxhZRoX38PpPEthcV+ell
	wyuHBvraeZtnEBEgkAaj4fRTN4HH4C0AavmSXEHUSSxLPg9lRyfuyiNP6YfenCGP
	70SweA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3wbqj6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 08:04:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b9fe2d6793so110903225ad.0
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 01:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779264256; x=1779869056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uc7Nk43l2dIGUbmdD6/LYMAf0PAnw6/rOvilHT/UMso=;
        b=FhSNvYhPn4VHBW3X8LTs21CW8Idg9C0DFwp8WDHUvgamFGbASTTE6jpXj15mjAoRXC
         xIWH1ox+qqvYizBtVaOD9IvvaQMEWDAKSh9DcKkCk+oWGZmd/7GuYJZJABCiZW99a7zy
         tY/JtNyNwNyET4xFxtETIB97Tmf6DRcm7rZm9+wjnBYLEj9krwEmMo2QpBjb04v3fQiR
         fHmv0A3802WR4+oONQxJklrFcvMjtNQKY/jBLOR4G4hKbt4AkkGzT364femsXu4OEIYh
         Pf1FTwI9oopcOt6qeLI7GIMEpHw3hJHuqRV6amivi7JH9E4zv4R7e24DuDuvIUkICra3
         7zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264256; x=1779869056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uc7Nk43l2dIGUbmdD6/LYMAf0PAnw6/rOvilHT/UMso=;
        b=oLjWwrIggcGzGHwwmPfRtD6QZmmqNogdFXpLZcgVv5Nb6x/ZotRbi4nItrCLanQG4t
         gSZQnb89hPjB+i5nwUhJgE+KUBYrwvWdWIC5GuYXYyvQtwJ4OQSviy4eANW0g4c0qRaN
         eIwxmSvnOz7QqwKh6Dml0rq0ubybMzwNCjKneXTWX3iqscZT0P4YXO4GnRfZG0q48Kdm
         Wnein7eg/82NLQJnV6b555rB89RRzZVX42lIPkXnhmY7Wwyi51uTG9k23QLgz23rTOHv
         mJoJIIzxL3GvnIXH7NZ32MtFPq8buRWCYvZe3SVnafjTHf/AtTdT4pm5zKGKc4YCvBTP
         Nb+g==
X-Forwarded-Encrypted: i=1; AFNElJ9wKxL7jxoX5YKlIKXUC71A3Qr+C0WNXR1TFOWld87ETapZDPWBVfzMqNUtXIDFYiRnyhSHojhe9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB9mDsGqSh/m2SachSRZCRgL1qg+DbkLo3TrZD06REZGV/9BNO
	OFsXozimWcxg0ZrN2rKecTjhhYqUUWmfxmv7sSDBnVE8ik5HCLI4GCnqqr2ss0IBtfpvMC8j1oS
	P7CS0e9E0BlPwk4EPAUN6FYBDkOBRz3C68gOx0ZkhF2VEb06oxJZylWYvpf5bUQ==
X-Gm-Gg: Acq92OG8oPxKxVPsTmatLoQ3qQEqkR0tUeCkXN/7W5ebSmCTWXr8SQss4mPKRnAuYHC
	CIzTZa/VWZ5A22GFnAEb/RZrsZeBOlkcSgK/nPrBnAyfkAwG1MLP8ReMpGR5oAfd/vbZbzb62/S
	oUZaql3aVYXavm6wYN4LlUhiHHrNbt+liBGmK2kXLbQ3v+GnotPySDKLqVE4qEmdIOsTsUqQWGB
	+VmLDdDJ/qA5qMLjJ04c5x6jdAEE622gqLZKOLBGNVCnmnCPNp3JqcweqrnycvnC+d5+NRYd9fp
	liSEeAnAV23sGLebOwJlGbGXTyk2Bgxa5H/6RTzj4kvuhr1YS+pqj5vOZbewE1bMHODT/adgDQ6
	XWmHM6B+afXolAIfVI2+UtgUors4moXfdwhAlKIkbKfv7aZGB5bzbdrIpGr1GMVpKP6M6mbVOtn
	a2tN1nXitZpw9P3zNCGw==
X-Received: by 2002:a17:902:b090:b0:2b4:5cea:f61c with SMTP id d9443c01a7336-2bd7e77a4ccmr179096695ad.4.1779264255784;
        Wed, 20 May 2026 01:04:15 -0700 (PDT)
X-Received: by 2002:a17:902:b090:b0:2b4:5cea:f61c with SMTP id d9443c01a7336-2bd7e77a4ccmr179096385ad.4.1779264255222;
        Wed, 20 May 2026 01:04:15 -0700 (PDT)
Received: from [10.133.33.109] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe7270sm207228825ad.50.2026.05.20.01.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 01:04:14 -0700 (PDT)
Message-ID: <ddcad9ad-eb49-4e32-8b48-56a611758cde@oss.qualcomm.com>
Date: Wed, 20 May 2026 16:04:08 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, rafael@kernel.org,
        stratosk@semaphore.gr, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com,
        zhangpengjie2@huawei.com, wangzhi12@huawei.com,
        linhongye@h-partners.com, zhongqiu.han@oss.qualcomm.com
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
 <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com>
 <b6d995f7-91c0-4f87-82e7-87cc50faa43d@huawei.com>
 <aoo2k2uzi6zg6owrmi7qgcgjryxzk7l7f2mdo6vtjjdd576hpn@rg6zyqgn7grr>
 <80d32bdb-f661-44cb-b529-3d5ce2142af0@oss.qualcomm.com>
 <pr25udlbea4vwtx27gfzlnqzv3lmmphkjx5xj2ggzdegmd4ntn@kiytfovoifi3>
 <a028421a-de24-43cd-ac80-17de9b2fc523@oss.qualcomm.com>
 <5ivkhopr53lsrnlu62ucdn5yfyeh42nwq3knfifp4ihgv6kpzy@sd6eekl2r45a>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <5ivkhopr53lsrnlu62ucdn5yfyeh42nwq3knfifp4ihgv6kpzy@sd6eekl2r45a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA3NiBTYWx0ZWRfXwUQP0rIXptdh
 utxCPYOzGVuYuskN4FPWdf7P3xwaPVG2NSRKjR4t2hF1Q987r1x+HFKeUx8pWxKyb8rvH/CM58J
 2nFIJh7HNVv5jxaojVShdA3guyipngFViEFsjrUpcpn57dk3a1yTmEwhR7jQSk1sBRrXfbHeSO7
 lbAZfLPpKbien71GDNo15Lmspd26cGiBoP1EH2tTOJozNIRQFJt6iGJHUjJt7Oda2KRk+aBb/HC
 edtyLZj1NJslnftMlUZfgIeDBz5yj6tRNiXxuHHfODtmxUEeX45mjHA/bQT0vkJ5dqFCbAcVQ8M
 VFDbsk4YCDoigWWGw9hs6zgjsRnjWyzD/fYexblngux33c6cESaAxevaYMxjsJTroVpZyco84BK
 ofBIDxVffKIhIZI96US12EB/GGT3ppm5NFlomB7SrbdwdE2VL9XddbUvcwrisXBx6PORntYjfxw
 T3lsdjO1FdsBPJ5lVrA==
X-Authority-Analysis: v=2.4 cv=Q/viJY2a c=1 sm=1 tr=0 ts=6a0d6b00 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=ZatVsnkQGjJaE5PWG9sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: PnfLzchMaZ2jGpdZkup8YnKzMXGQp0Bx
X-Proofpoint-ORIG-GUID: PnfLzchMaZ2jGpdZkup8YnKzMXGQp0Bx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200076

On 5/20/2026 3:48 PM, Viresh Kumar wrote:
> On 11-05-26, 12:03, Zhongqiu Han wrote:
>> Just one small concern is that requested_freq may underflow as an
>> unsigned value; perhaps this could be improved by:
>>
>> -		if (requested_freq > freq_step)
>> +		if (requested_freq > policy->min + freq_step)
>>   			requested_freq -= freq_step;
>>   		else
>>   			requested_freq = policy->min;
> 
> Looks fine.
> 
>> or use min() func?
>>
>> Additionally, it seems that dropping the early‑exit checks also appears
>> to be a nice side effect fix for CPUFREQ_NEED_UPDATE_LIMITS drivers when
>> updating internal upper and lower frequency boundaries.
>>
>> As designed in commit 1c534352f47f ("cpufreq: Introduce
>> CPUFREQ_NEED_UPDATE_LIMITS driver flag"), a cpufreq driver may need to
>> update its internal frequency limits when policy min or max changes for
>> drivers setting CPUFREQ_NEED_UPDATE_LIMITS.
>>
>> However, the early‑exit in cs_dbs_update() can prevent
>> __cpufreq_driver_target() from ever being called.
>>
>> For example, when policy->min rises from 200 to 400 kHz while policy
>> ->cur is already at 400 kHz, under low load:
>>
>>    cpufreq_policy_apply_limits():
>>      policy->min(400) > policy->cur(400) ?  NO -> driver not called
>>
>>    cs_limits():
>>      dbs_info->requested_freq = policy->cur = 400
>>
>>    [next sampling period, low load]
>>    cs_dbs_update():
>>      requested_freq = 400
>>      if (requested_freq == policy->min)  /* 400 == 400 -> true */
>>          goto out;  /* __cpufreq_driver_target() never called */
>>
>> With the early‑exit removed, __cpufreq_driver_target() is called with
>> target == policy->cur, and CPUFREQ_NEED_UPDATE_LIMITS ensures the driver
>> is invoked to update its internal performance boundaries.
> 
> I think we are all in agreement on this now ?
> 


This approach looks good to me.



-- 
Thx and BRs,
Zhongqiu Han
