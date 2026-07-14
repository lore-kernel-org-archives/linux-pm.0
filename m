Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7137DAA3
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027324; cv=none; b=e/8lZM2KdQGSsJWU1j7wm3LfwbWBFSSKStLl22Ii0ocZAXMgdMvHwS2VEZNnRaHAEPW/mR1RwN45p9/sm6n6v3pBrA/hpmY13XSu0J+vcwURlX/Clmptx+duUxpJQFQkCa8pYm5WXujDlIiTQyR8c2UVSl41IVyH7ji7YnBYMsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027324; c=relaxed/simple;
	bh=w7ra1oZoLsoSUtZm1rl35A/GKCnTGB1TkkeeRr1zxQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFbHOXEPt6y+fgfeG88EtvoTJA9brptoosZdlSg9rJJDNUJFfB30kRg6KNEb/fOAiSKOZBcYPaCAK8GENo577UmsXO5o6VcG4jnISx12KWIAnbPs2liY0sVda3wkFVDiHj5JmxGT+lzwdf/Ck1fzYpo3L77XD/TQ2b8yAvOmGhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bYNJCJhG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LBqM0GYy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bYNJCJhG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBqM0GYy"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6ST5c3743651
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 11:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OOV3Jx708g/F9ZxMn2phCG4uyQ912gSuTvQXRh31bc8=; b=bYNJCJhGvyTYhsjQ
	1SNBQmlWoOnnCleso1MB3Le/RIuHFhygtaRwYuSresQHpziCoxumQ32k0rjx1/wn
	umpZ7O0AY67V09m43W6A+mg99pJSdHDXkNIh8wm+3foYc+qG/FVPC4pmaVtHY300
	pQ3XXP3xY3hqNfUZSBZRthu3RhC4O4dcUsNoPSgubVw696U8W+P494cmCQHeQCXd
	X57fIRG2jW9mCnleXjh62OkSV+At37QVFr64+rEMU/RayruHLsKkR55Eu4Xnch3T
	SBq6Te9xMNT51PFIOsek8DUqS0cXmxAddG3euT84l0BUQXbx7AQAwX1z8wCwYWXK
	OwRW7g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44p3bdc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 11:08:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cceabd70f5so19089935ad.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 04:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784027321; x=1784632121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OOV3Jx708g/F9ZxMn2phCG4uyQ912gSuTvQXRh31bc8=;
        b=LBqM0GYyw9KXUZd3kjA06yA4gyL+CaBoV4FsPu4tGQ4PcuJafQnp40vI5Zaus6E+gw
         8Slq4knmroxI5QXm93FdFa5CmLyv17zsNn+laTvgcoPSIyPpMHcI8/CU0b4JilMB1jgC
         U56DKRc7VVGpx+m+QiZH74ex7EMbMD73yTKNx84WdpXILF2/yebdiG6Xm/bQR5hlU695
         WGuRDVLGNvfi8wJk7OYKTTjfdv37hhO3SSgNmoTgG04iCQVuiE5KdGkfY+/ff+S8sGjx
         QtY1k8MHFnQr9o4MVnDKr0sJ9djIVpBktU8aE1UwhMN6N/6bCYqa82XaVQUJaEdIK2ZA
         4Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784027321; x=1784632121;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OOV3Jx708g/F9ZxMn2phCG4uyQ912gSuTvQXRh31bc8=;
        b=bBzoRGjhlgutsXPBg0GkV+HtW5LeCBvB0tBcgw4pZ9PJJUCX7EGUnjZCfkuj1zMeYD
         9c0x8ClyVOL1sFEeszqTmiMwbntYV++iXih2Rrv7gt4+JYrTB561CpTLzFCRTGhRCvfW
         6g13sqDjLjY7Qwbq6EZbmUxZ54o8w/Hp2KcKgUeAN2Q8IY91xMoQyvUEXq10HtU0ifuY
         ggxYy0LyWIYtrqy6r52U/6GR6VKnLxm7HQtcEFKBPmMxm4W99rKdNKa0ieWRJC0hCkqi
         hjc5ILGCnBiPQZMpQllbNX1rWDEfwFnrAnNyP19s/KVykVUELRHFawTq1Od14uxFC9tF
         fxOA==
X-Forwarded-Encrypted: i=1; AHgh+Rp63filc6YhNa7xWx24BsuY8jbIXds6JzV4A2oO+kUCHkxI8sbvaCJwY1TRt6eHntJESh7rGPxvhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMC3rtE8oQXWKxAJOZMjQuwrKgGN1dOlpTdg/fvZH3zhZFowfv
	l0jU3F1P0ux29QbmK+LDLSv6Qc1DC3TZEWE6iXDJt3eF3nfdbUwDYT7Yu7jqWUm/aD+CB1EkYMn
	FCy3pg4ZhZ7XMZsGYJZKXyuq1wcSYv4ad8GaiSG6xaAUB5gEn3Pis51izW1uX2g==
X-Gm-Gg: AfdE7ckH3koFBTUd0/Hi6qq62azYjWQm0NIsw/fImZ2BkxEaAo9JDpq7ZodkZemTg8z
	JmMJrG/7YueZvVoE1bHEWsufCVHEgrv0oDACptEnTW1XXY7sib7jSZTcxg/BaTD8wIYntX1gLD+
	YGR1OW85ezDm9BGlB4lTjXRDt7HhdVSkDqxeCDMsQXSMJeD2G0OSpG5R/FS9El4680Q31eNOq8c
	Y5bG+Ld82Y8RDfYgfVS7LedoA3OcEeIaIxZ6RgFqiu/12XMnioMsOxxrc3574LVI8O1mAe0jpU5
	s/z1I2+8dsSibnFc97+fsZXgRRFEZ7P1utRIPKB/2aEiFJXOogIh77/5UFUdanUpEgZNshNFsYN
	5rv5nLOgFsH2LQOQq7xHOzg9jHQUO9fWMUskT6gIe1sVjyleSZ5zCUhb9Czwe+IYqZ7SCkmFsIe
	UuEthKSA==
X-Received: by 2002:a17:903:4b2d:b0:2c9:ceb9:865b with SMTP id d9443c01a7336-2ce9eab3aeemr110971975ad.21.1784027320702;
        Tue, 14 Jul 2026 04:08:40 -0700 (PDT)
X-Received: by 2002:a17:903:4b2d:b0:2c9:ceb9:865b with SMTP id d9443c01a7336-2ce9eab3aeemr110971565ad.21.1784027320167;
        Tue, 14 Jul 2026 04:08:40 -0700 (PDT)
Received: from [10.133.33.88] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc99cc5aasm114996965ad.0.2026.07.14.04.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 04:08:39 -0700 (PDT)
Message-ID: <21f0957d-a8de-4262-a353-0e19fdac5481@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 19:08:34 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: amd-pstate-ut: fix null pointer dereference
To: Qianheng Peng <pengqh1@chinatelecom.cn>, kprateek.nayak@amd.com
Cc: li.meng@amd.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mario.limonciello@amd.com, perry.yuan@amd.com, rafael@kernel.org,
        ray.huang@amd.com, skhan@linuxfoundation.org, viresh.kumar@linaro.org,
        wangxb12@chinatelecom.cn, xiongl24@chinatelecom.cn,
        zhangar@chinatelecom.cn, zhongqiu.han@oss.qualcomm.com
References: <b2835252-409f-4188-aea7-195be3c4e69a@amd.com>
 <1784024553-16448-1-git-send-email-pengqh1@chinatelecom.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <1784024553-16448-1-git-send-email-pengqh1@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDExNSBTYWx0ZWRfX1hI2R0dKOcHc
 9Z9rL6x4odG7sqvfvgunSBTSUJHL8+VDIx6mVPohv0XbAi3VQXvz9Sc1Pany3bVV9J29v2vmGxt
 hc5qkwELMem1EZsgnfBShLQJViUYZuo=
X-Proofpoint-GUID: cYSgfppWvw8KMGPfV41dJTW-jQ9yBOlv
X-Proofpoint-ORIG-GUID: cYSgfppWvw8KMGPfV41dJTW-jQ9yBOlv
X-Authority-Analysis: v=2.4 cv=BZroFLt2 c=1 sm=1 tr=0 ts=6a5618b9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=tzYFbmKReUxiKNdrr1oA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDExNSBTYWx0ZWRfX4Ri0Umsjseef
 5DYZvzGFdOfSMO4iXF+UWFaXpiajIOJCmDA2/dAhSVIqsZUCs0oRwrf9Elyu5ylIw4bKrGeEDNp
 Dxh8v1Y73FkgGS8Im9U/FE3KHq5dBlC0Y2L3e03cynUHlPvkhpW+Vky6y/cbzMv9Bl68xXZHQ0X
 ELiDrr3Z27FWnEzrrxJ2LlbGfxdlMQt3yovia7np07Ak8c1Wq05W4iv+kQX2SFCyTMCB0SSs3nt
 OXTVb73ZIdMLbC1usN784/2Yzg5jUVHET/efZLHexlFBVl+8y3VKNq9VNq7VoAMrIY5o9QgQO+a
 ERPGXHHPbmNby2voLf9sCm8LdCwB+fa0bdawhNrvtf4WmaR4xRwdVdg+fjsR0vwpP4niKsI2CGj
 8u7ceiliWmH9QGa60+CVDoITUPSiw6j4mnb2FlfYFoLwZ/ow1TpaLZ06MxRM2+tuYSdjJumbBrh
 dgjXWk/ZoPiZ5ts1amA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140115

Hi Qianheng,

On 7/14/2026 6:22 PM, Qianheng Peng wrote:
> Hello K Prateek,
> Thanks for questions.
> 
> On 7/14/2026 14:39, K Prateek Nayak wrote:
>> On 7/14/2026 1:29 PM, Qianheng Peng wrote:
>>> The crash issue may occur when insmod amd_pstate_ut modules.
>>>
>>>     amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
>>>     amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
>>>     BUG: kernel NULL pointer dereference, address: 0000000000000080
>>>     #PF: supervisor read access in kernel mode
>>>     #PF: error_code(0x0000) - not-present page
>>>     PGD 0 P4D 0
>>>     Oops: 0000 [#1] SMP NOPTI
>>>     CPU: 0 PID: 20300 Comm: modprobe
>>>     Kdump: loaded Tainted: G O 6.6.0-0010.rc1.ctl4.x86_64 #1
>>>     Hardware name: FiberHome R2200 V5/Xeon Boards, BIOS 3.1a 02/24/2020
>>
>> Is this an AMD platform?
> No, it's Intel(R) Xeon(R) Gold 5128.
> 
>>>     RIP: 0010:amd_pstate_ut_check_perf+0x141/0x280 [amd_pstate_ut]
>>>     Call Trace:
>>>      <TASK>
>>>      amd_pstate_ut_init+0x1b/0xff0 [amd_pstate_ut]
>>>      ? __pfx_amd_pstate_ut_init+0x10/0x10 [amd_pstate_ut]
>>>      do_one_initcall+0x42/0x2e0
>>>      ? kmalloc_trace+0x26/0x90
>>>      do_init_module+0x60/0x240
>>>      __se_sys_init_module+0x185/0x1c0
>>>      do_syscall_64+0x62/0x190
>>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>      </TASK>
>>>
>>> Add invalidation check of cpudata in amd_pstate_ut_check_perf() and
>>> amd_pstate_ut_check_freq() to avoid unpredicated null pointer dereference.
>>>
>>> Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
>>> Suggested-by: Li Xiong <xiongl24@chinatelecom.cn>
>>> Suggested-by: Xibo Wang <wangxb12@chinatelecom.cn>
>>> Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
>>> ---
>>>   drivers/cpufreq/amd-pstate-ut.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
>>> index 735b29f..3b24260 100644
>>> --- a/drivers/cpufreq/amd-pstate-ut.c
>>> +++ b/drivers/cpufreq/amd-pstate-ut.c
>>> @@ -157,6 +157,10 @@ static int amd_pstate_ut_check_perf(u32 index)
>>>                  if (!policy)
>>>                          continue;
>>>                  cpudata = policy->driver_data;
>>> +               if (!cpudata) {
>>> +                       pr_err("%s driver_data of %s is empty!\n", __func__, policy->kobj.name);
>>> +                       return -EINVAL;
>>> +               }
>>>
>>>                  if (get_shared_mem()) {
>>>                          ret = cppc_get_perf_caps(cpu, &cppc_perf);
>>> @@ -229,6 +233,10 @@ static int amd_pstate_ut_check_freq(u32 index)
>>>                  if (!policy)
>>>                          continue;
>>>                  cpudata = policy->driver_data;
>>> +               if (!cpudata) {
>>> +                       pr_err("%s driver_data of %s is empty!\n", __func__, policy->kobj.name);
>>> +                       return -EINVAL;
>>> +               }
>>
>> The only time I think this can happen is when the amd-pstate-ut races with a
>> the amd_pstate.*_cpu_exit() (probably as a result of concurrent mode switch)
>> or if you are running this without running amd-pstate as the cpufreq driver
>> (which the ut doesn't check for beforehand)
>>
>> My setup fails at this exact same point when I have the driver unloaded.
>> What is the output of following before you run into this issue:
>>
>>     cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
>>     cat /sys/devices/system/cpu/amd_pstate/status
>>
>> Are you doing any concurrent hotplug / mode switch?
>>
>>>
>>>                  if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
>>>                          (cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> In this machine, I got output as follow:
> ======================================================================================
> [root@ ~]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
> intel_cpufreq
> [root@ ~]# cat /sys/devices/system/cpu/amd_pstate/status
> cat: /sys/devices/system/cpu/amd_pstate/status: No such file or directory (os error 2)
> ======================================================================================
> Otherwise,I didn't do any concurrent hotplug / mode switch, just modprobe amd_pstate_ut.
> 

It may be worth adding driver name detection to this ut driver, for
example via cpufreq_get_current_driver().


-- 
Thx and BRs,
Zhongqiu Han
