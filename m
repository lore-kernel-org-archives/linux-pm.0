Received: from smtph3-07.21cn.com (smtph3-07.21cn.com [150.223.194.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EB1364E98;
	Tue, 14 Jul 2026 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.223.194.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025043; cv=none; b=OO4UvikmEVy3ymMsRYtiyMq6mkzpcA+ECEjzNA511mx0BmjY2yEdQpG+nf1mUgEVuQRSV1KLC25HtJAmBLqBUqFKMjwcXBD3cSg1H+v7hJi58VHqz/eXPNI49xStXwHaiE8FIjwZ3r5CoTdRvChZC/wxMxaBNjN2F8g+DzRyECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025043; c=relaxed/simple;
	bh=Z5iBKYr70EpuKY3i8PlxSKlMS2ViQ2i7AuG0Y5iGVds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ecR2Hz6yEyN0BGefFUFcIbaoJh7392PS2P2BL1M4lomLKd3VjHZPmA1MMe3AGwwFPUrCbDQpe4AyeJobm+ZAw0HYGw9y0fk+NOgMmzP0lf4kEUuQQBopYpC9UEUP+f4Nn6ia3nxrMi5qg+dRahawXKfbkQBTMzBSYvPk4irOaxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=150.223.194.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:172.27.0.98:0.502763977
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-139.200.108.11 (unknown [172.27.0.98])
	by smtph3-07.21cn.com (HERMES) with SMTP id 7E97D1402E11C;
	Tue, 14 Jul 2026 18:21:11 +0800 (CST)
X-189-SAVE-TO-SEND: +pengqh1@chinatelecom.cn
Received: from  ([139.200.108.11])
	by gateway-ssl-dep-657b8df9db-d66cm with ESMTP id 061489ed37054a598dcbbb4aba4db34a for viresh.kumar@linaro.org;
	Tue, 14 Jul 2026 18:21:21 CST
X-Transaction-ID: 061489ed37054a598dcbbb4aba4db34a
X-Real-From: pengqh1@chinatelecom.cn
X-Receive-IP: 139.200.108.11
X-MEDUSA-Status: 0
Sender: pengqh1@chinatelecom.cn
From: Qianheng Peng <pengqh1@chinatelecom.cn>
To: viresh.kumar@linaro.org
Cc: kprateek.nayak@amd.com,
	li.meng@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mario.limonciello@amd.com,
	pengqh1@chinatelecom.cn,
	perry.yuan@amd.com,
	rafael@kernel.org,
	ray.huang@amd.com,
	skhan@linuxfoundation.org,
	wangxb12@chinatelecom.cn,
	xiongl24@chinatelecom.cn,
	zhangar@chinatelecom.cn
Subject: Re: [PATCH] cpufreq: amd-pstate-ut: fix null pointer dereference
Date: Tue, 14 Jul 2026 18:21:10 +0800
Message-Id: <1784024470-14747-1-git-send-email-pengqh1@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <7fxgevkwbauh26jxm27x6yd3dcmi66znyqh4yud7vhm6cdwe4u@rskv6hd64pcp>
References: <7fxgevkwbauh26jxm27x6yd3dcmi66znyqh4yud7vhm6cdwe4u@rskv6hd64pcp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

On 14-07-26, 01:13:57 (PDT), Viresh Kumar wrote:
>On 14-07-26, 15:59, Qianheng Peng wrote:
>> The crash issue may occur when insmod amd_pstate_ut modules.
>> 
>>    amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
>>    amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
>>    BUG: kernel NULL pointer dereference, address: 0000000000000080
>>    #PF: supervisor read access in kernel mode
>>    #PF: error_code(0x0000) - not-present page
>>    PGD 0 P4D 0
>>    Oops: 0000 [#1] SMP NOPTI
>>    CPU: 0 PID: 20300 Comm: modprobe
>>    Kdump: loaded Tainted: G O 6.6.0-0010.rc1.ctl4.x86_64 #1
>>    Hardware name: FiberHome R2200 V5/Xeon Boards, BIOS 3.1a 02/24/2020
>>    RIP: 0010:amd_pstate_ut_check_perf+0x141/0x280 [amd_pstate_ut]
>>    Call Trace:
>>     <TASK>
>>     amd_pstate_ut_init+0x1b/0xff0 [amd_pstate_ut]
>>     ? __pfx_amd_pstate_ut_init+0x10/0x10 [amd_pstate_ut]
>>     do_one_initcall+0x42/0x2e0
>>     ? kmalloc_trace+0x26/0x90
>>     do_init_module+0x60/0x240
>>     __se_sys_init_module+0x185/0x1c0
>>     do_syscall_64+0x62/0x190
>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>     </TASK>
>> 
>> Add invalidation check of cpudata in amd_pstate_ut_check_perf() and
>> amd_pstate_ut_check_freq() to avoid unpredicated null pointer dereference.
>> 
>> Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
>> Suggested-by: Li Xiong <xiongl24@chinatelecom.cn>
>> Suggested-by: Xibo Wang <wangxb12@chinatelecom.cn>
>> Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
>> ---
>>  drivers/cpufreq/amd-pstate-ut.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
>> index 735b29f..3b24260 100644
>> --- a/drivers/cpufreq/amd-pstate-ut.c
>> +++ b/drivers/cpufreq/amd-pstate-ut.c
>> @@ -157,6 +157,10 @@ static int amd_pstate_ut_check_perf(u32 index)
>>  		if (!policy)
>>  			continue;
>>  		cpudata = policy->driver_data;
>> +		if (!cpudata) {
>> +			pr_err("%s driver_data of %s is empty!\n", __func__, policy->kobj.name);
>
>You can use kobject_name(), but I wonder why print kobj name here ? Other
>drivers just print policy->cpu normally and that is sufficient.
Thanks for review.I will change kobj name to policy->cpu in patch v2.

--
Qianheng
