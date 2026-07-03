Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960D6382F31
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077842; cv=none; b=r1Kk8t2zfzasRI6wI1RcAnhrR3nXnkIa/Succef2CVGdcVxHOKgdl6HBSF29fqARjh4QNLJxXXpZfJ6ShbvRZlOD/joxA7jJhAeGRpia5oi6AyeWrWzaK5nFZWisRXT3z3T3D/oB0ltbmAHuEW2jZVI1ZKHGnH5rAmvOLPU8lfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077842; c=relaxed/simple;
	bh=mwnWfpoFX0WoGZt4odfIXDBkd+ff1gg5vvITu9t4j+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfTQyn4AdnrCbkw7LB1hiSO6ErvTp+xuwOV9k+v4y9drkTIfYRpjpBeij12HmHLbkdr4kOGW8mo+UItiI1tiCXOCXrNAKAcP3I1oMCo40W1vhkJdd9QempUCyo9KRJfKDxFpQllwgPPfSG+24yIDj0IPSnOE3x8Ti+dqtsk4XwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LQrmJqkA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aJtoGBe/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LQrmJqkA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aJtoGBe/"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6639Bopt3694367
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 11:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z91LT0SZT2lRw+H7fyjC1nc3O1zsp0mqhLL4IOjJ1IU=; b=LQrmJqkAWzSpq0Qp
	G64DYaCOfFfM9b8YySNWYmHhV0KVzsTovnJoRZbusl8MzHzYpBJ1IdxFhdaL6vjm
	V1dCA94ZgZpP5Pw4CQNedDzPAekk74CsaxrcDQAogQlTcUGhsBGc4do+rNJ+QtH2
	QSxqijLAZixBOIH7qMxX28U7eSiVgcNLQPKV6fJBNbuFoQIPkFfM2fb8UCuL5Oi9
	nYrO8vfinH1nResuE63/RQjP76sIMyYAGKqX4CEoFdwe3x4NHOX9P1FFsqfGRjTo
	uk9/TGAHnFR8OT5AcnhM6sO1uDUU17H5//df98H63v+MPAh28ITvkgmbneQf7Qqr
	GEjkug==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6a848f3x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 11:23:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37d4f23eb37so1098035a91.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 04:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783077829; x=1783682629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z91LT0SZT2lRw+H7fyjC1nc3O1zsp0mqhLL4IOjJ1IU=;
        b=aJtoGBe/BJoEL7GqNR08kweUtbSqnawdlhp00rfL706QTNnOZAGAI62qtQpkRP+ufD
         eh3GcrVnrO6atkZfuc1YPCXQ54zYjXKtlA5eCPlhf2Or3vAxCC0hVSxuePs9thtxVNMj
         FIxgW+GXTUKo3SBknFFAThYR22uMtTBkDOUZJOSsXxxjgDaJY+FRFOJ/ZVYf5vE6mT8M
         EojNjZTzlewn5rMETnI1CM5FOu0pmnAtuWRzkqsR9cJNkXG9UaiIXByTyvoAdFBTUcTa
         lBMe2cV+vssShMqu2954V0Ms8WZfzazQjDKF9T6ae1DJWPE0Ag1YrglPT547Jpl/3XgO
         HitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783077829; x=1783682629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z91LT0SZT2lRw+H7fyjC1nc3O1zsp0mqhLL4IOjJ1IU=;
        b=SybfU5OW67JoSwCbQ1fRTn78xMgcPw2s4KYI52S1n7tfQqX41B7mi2/9Vdapcgg76B
         S2PJOF6pnJDUjTs9qUD23+yyWVn3gXEvVAQKHFrK5FT9SLaZN4DtPL7QmEeLcucYkjn9
         rlN+5HAhRMOxg6ZEO+xpo9s8v7LH9ADqyXKyEY7hzS0Lww8ZB+gcSw89iFaNtuV1w4Gg
         6neYpUSPMuFCCIRc+nz9c2EO6e12KqIC7bkRc77AnMX3jUPSWPzWxSXawCnOYWBe+2L8
         i5PR/OiK4XDz1R5HwzACL+VCsz9miR6PoPghQlvPYLneLQTyZo+tR5WWZ4rxRHvhC/a7
         BwSA==
X-Forwarded-Encrypted: i=1; AHgh+RpValV79/ZNeqADgktpjiqA7YfDLVCjGfa6ycyU4KZSdCMNfs0iaNf359n1ii/+RYw5WytyY4mc0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YycymOVLHArsrI82OIK/uc2H2dM/dO/kGug9lAeegQ8poxYVwpR
	r0YFRp7xpdomwMi0GKcdJ3FqbvkARFnp9UmLlgsXF4eFCQ/SjhN96uPTDG2dhjWTzbzxMH9MXl8
	gXDjicfEzD3FiZBE5MuGzU5l6k11gYKLdqgjhFS2kFhakWoZY7QK99GH5siostw==
X-Gm-Gg: AfdE7cnUmnozltTMRQ4a0M4lAqVIj4HKV+72plrkkESbEOYekh59WQxtwpbA2/mlQ07
	aSaeA5hnn8o2giBKzqOyLyHgAh0fQ04LRDbuNTOn69HsvXBFTlxDSzKJXuiLU7opsiIT51fISuP
	YbBUS3SS/TgbfrT4ivXIetP4P7xAUXlQHoBKBdA2s3LQYPvqAbABA1BkxkuBVFTO21i3KBn1JnZ
	Ret/PzC63H/n9ilaOXg8/jUaJLwsjiqBlFOZbCtlT7xjSGGSwVqQBtOYMNksgOLp3Venz+UrT17
	l0QvUUtBmOUrXhD/Zw6dHmxZm0STB/kkFC1ciGyOgkoSRMcDO49LNAPIGgYc2EsaQlOEUY4Pvyf
	ZfYkubX0gB1wJQiOvyasBQ1ajFwFWgFceKC90VSw=
X-Received: by 2002:a17:90b:48d2:b0:381:21ea:913a with SMTP id 98e67ed59e1d1-38121ea9b72mr3025210a91.22.1783077829556;
        Fri, 03 Jul 2026 04:23:49 -0700 (PDT)
X-Received: by 2002:a17:90b:48d2:b0:381:21ea:913a with SMTP id 98e67ed59e1d1-38121ea9b72mr3025177a91.22.1783077829052;
        Fri, 03 Jul 2026 04:23:49 -0700 (PDT)
Received: from [10.218.15.172] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd221bsm20485342eec.22.2026.07.03.04.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 04:23:48 -0700 (PDT)
Message-ID: <c26de7fb-30da-4f7a-a3a9-413e6c0f028d@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 16:53:43 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel/cpu: Disallow offlining boot CPU based on config
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Thomas Gleixner <tglx@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260605-disable_boot_cpu_offline-v1-1-4c68fe1a6cf8@oss.qualcomm.com>
 <9b5ea951-6880-4ce8-8764-fd6bf2bd57a0@oss.qualcomm.com>
Content-Language: en-US
From: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
In-Reply-To: <9b5ea951-6880-4ce8-8764-fd6bf2bd57a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uI99_pthwxI8uX2wh0Ky_ElfO5A8r9zL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDExMSBTYWx0ZWRfX5RGGEc690joF
 I1c9PS6FOFMS6TDEcQ0cfT+QnqAMavuNqqfUeUd3F5tJmJHQO/ljuTRbRmhcjIvLe2op4DsX3qe
 gcopCU5oMSkFplG+D48AfipvcArqCts=
X-Authority-Analysis: v=2.4 cv=a6QAM0SF c=1 sm=1 tr=0 ts=6a479bc6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=JzDM9ypL2hb05KE4TY4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDExMSBTYWx0ZWRfXwXcdVgPKqQAR
 vZ5pVldJHtmIVACCw653/TZBToCAAXOgT9JYxv+kGfIpA9aIg6DWSkUKMKuM6A2xOiKrwtrmGqu
 NFQ27ND9FgILUccgJF6h2whS0rB1q9ns49cr1G2HpAV94mIbY9VG+mxomMvudJkeJbkkfmfpRqW
 y2M8qxphwRFLdRfdJZX8l2OmCC58B//NoWqNFiVyllOyToRn53Ka+ETVYAr4XGgwzi8PNW8Udzv
 pNpBPDWXNCAKbnMs2TFh0/PZjGh0OX9xSkAtBL4gg2kiC8SgATHnqS0guM9m4AWOnh07jkHzH9p
 5pHDYyd1NLoMpRA1wcuXNL3A1gp+n4Js8zf4+BN+6G6DxRBEOA+FTIhvVu7UsfdwgiYZZ8PzyZn
 qXlAxWOF++QjOHGIRO3J++MigpQBcfCxn5bfBo1GJG6JC85i357SDmykvph6dezt6vDTOJPgrVM
 v3LWvHCi/7O2FqMB8FQ==
X-Proofpoint-ORIG-GUID: uI99_pthwxI8uX2wh0Ky_ElfO5A8r9zL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030111



On 23-Jun-26 5:10 PM, Daniel Lezcano wrote:
> 
> Hi Sned,
> 
> On 6/5/26 12:30, Sneh Mankad wrote:
>> The Qualcomm SoCs like LeMans, Monaco support suspend to ram which leads
>> the SoC to ACPI S3 similar state where SoC is turned off and DDR is
>> retained.
>> The hardware design on these SoCs forces a constraint to suspend and
>> resume the system on boot CPU / CPU0.
>>
>> If CPU0 is already offline before starting suspend to ram the
>> freeze_secondary_cpus() picks alternate CPU as primary / last CPU and
>> proceed further to invoke PSCI SYSTEM_SUSPEND.
>> This leads to a system crash.
>>
>> In order to prevent such an issue introduce PM_SLEEP_SMP_CPU_ZERO_STRICT
>> config and when enabled prohibit the CPU0 to be offline.
> 
> What is the status of this change ? Are you planning to send a new version with the check inside arch_cpu_is_hotpluggable() ?

Yes Daniel, I am sending v2 with adding the check in arm64 specific file.

Thanks,
Sneh
> 
>> Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
>> ---
>>   kernel/cpu.c         | 4 ++++
>>   kernel/power/Kconfig | 8 ++++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index bc4f7a9ba64e62d76fbb2b362f243c918defe5bc..1c878db1d9cb6df0e31cb55343851aab4e38a3a0 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -1478,6 +1478,10 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
>>        */
>>       if (cpu_hotplug_offline_disabled)
>>           return -EOPNOTSUPP;
>> +#ifdef CONFIG_PM_SLEEP_SMP_CPU_ZERO_STRICT
>> +    if (cpu == get_boot_cpu_id())
>> +        return -EPERM;
>> +#endif
>>       if (cpu_hotplug_disabled)
>>           return -EBUSY;
>>       return _cpu_down(cpu, 0, target);
>> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
>> index 05337f437cca29da57864583166d7f9abd526507..0b342b3a4a5650a1927dc4805d1515e1d9e067c6 100644
>> --- a/kernel/power/Kconfig
>> +++ b/kernel/power/Kconfig
>> @@ -401,3 +401,11 @@ config ENERGY_MODEL
>>         The exact usage of the energy model is subsystem-dependent.
>>           If in doubt, say N.
>> +
>> +config PM_SLEEP_SMP_CPU_ZERO_STRICT
>> +    bool "Disallow boot CPU (CPU0) offline"
>> +    depends on HOTPLUG_CPU
>> +    depends on SUSPEND
>> +    help
>> +      Disallow boot CPU (CPU0) offline when the suspend_ops->enter()
>> +      has to be executed by boot CPU.
>>
>> ---
>> base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
>> change-id: 20260603-disable_boot_cpu_offline-eb4f55ac96f2
>>
>> Best regards,
> 

