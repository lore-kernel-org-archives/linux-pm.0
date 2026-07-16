Received: from smtpnm6-03.21cn.com (smtpnm6-03.21cn.com [182.42.153.190])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B87B1A6828;
	Thu, 16 Jul 2026 04:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.153.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784174453; cv=none; b=rC+VwkMxwf3dE6f0cdIG2JtQVYvaYwQKfLxOz8JppmwUWoxvVZYy7KBLrwbH0ptpEsmiNYXSpG0/sfMuMskDt275jHtuTaZ23mRTr7xjqoAG02cuBoo6jlgNbo9DFHEFmuODm5a7JDYCLW+I5pPE27ePi9/is1R14xNDsFvhoNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784174453; c=relaxed/simple;
	bh=SBDM/h/GJ4zEgPmRAEdO3OW0zxm5iJDBhfXdtnodVTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clylLOKwX/YQT3g/hfifj58YJy5v/7YfUmQtYX8qS5T2AUsqx+ej6tUQxJfFHV922hol0CATOjHp+HiXVM+yupSGRtGIRxEl+jCkAW9HJqZz5JozGwMU16CKkPlqOIhEwT6G9+gvV6dWvGt7QCyv3JeFslIlrmJddn9DML3CTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.153.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:172.27.0.101:0.1442045292
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-139.200.108.11 (unknown [172.27.0.101])
	by smtpnm6-03.21cn.com (HERMES) with SMTP id 65689C02099C;
	Thu, 16 Jul 2026 11:52:22 +0800 (CST)
X-189-SAVE-TO-SEND: +pengqh1@chinatelecom.cn
Received: from  ([139.200.108.11])
	by gateway-ssl-dep-657b8df9db-xsh6f with ESMTP id 930635a2917d48349cb7d6736a9f402c for kprateek.nayak@amd.com;
	Thu, 16 Jul 2026 11:52:35 CST
X-Transaction-ID: 930635a2917d48349cb7d6736a9f402c
X-Real-From: pengqh1@chinatelecom.cn
X-Receive-IP: 139.200.108.11
X-MEDUSA-Status: 0
Sender: pengqh1@chinatelecom.cn
From: Qianheng Peng <pengqh1@chinatelecom.cn>
To: kprateek.nayak@amd.com
Cc: li.meng@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mario.limonciello@amd.com,
	pengqh1@chinatelecom.cn,
	perry.yuan@amd.com,
	rafael@kernel.org,
	ray.huang@amd.com,
	skhan@linuxfoundation.org,
	viresh.kumar@linaro.org,
	wangxb12@chinatelecom.cn,
	xiongl24@chinatelecom.cn,
	zhangar@chinatelecom.cn,
	zhongqiu.han@oss.qualcomm.com
Subject: Re: [PATCH v2] cpufreq: amd-pstate-ut: fix null pointer dereference
Date: Thu, 16 Jul 2026 11:52:21 +0800
Message-Id: <1784173941-13565-1-git-send-email-pengqh1@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <ed6781c7-8f10-4580-a3f3-c8819428d845@amd.com>
References: <ed6781c7-8f10-4580-a3f3-c8819428d845@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Hello Prateek, Zhongqiu,
Thank you both for the awesome analyses.

On 7/15/2026 20:21:34, K Prateek Nayak wrote:
>Hello Zhongqiu, Qianheng,
>
>Thank you both for taking a look at this!
>
>On 7/15/2026 7:30 PM, Zhongqiu Han wrote:
>> Hi Qianheng,
>> 
>> On 7/15/2026 5:35 PM, Qianheng Peng wrote:
>>> The crash issue may occur when insmod amd_pstate_ut module on intel platform.
>>>
>>>     amd_pstate_ut: 1    amd_pstate_ut_acpi_cpc_valid  success!
>>>     amd_pstate_ut: 2    amd_pstate_ut_check_enabled   success!
>>>     BUG: kernel NULL pointer dereference, address: 0000000000000080
>>>     #PF: supervisor read access in kernel mode
>>>     #PF: error_code(0x0000) - not-present page
>>>     PGD 0 P4D 0
>>>     Oops: 0000 [#1] SMP NOPTI
>>>     CPU: 0 PID: 20300 Comm: modprobe
>>>     Kdump: loaded Tainted: G O 6.6.0-0010.rc1.ctl4.x86_64 #1
>>>     Hardware name: FiberHome R2200 V5/Xeon Boards, BIOS 3.1a 02/24/2020
>>>     RIP: 0010:amd_pstate_ut_check_perf+0x141/0x280 [amd_pstate_ut]
>>>     Call Trace:
>>>      <TASK>
>>>      amd_pstate_ut_init+0x1b/0xff0 [amd_pstate_ut]
>>>      ? __pfx_amd_pstate_ut_init+0x10/0x10 [amd_pstate_ut]
>>>      do_one_initcall+0x42/0x2e0
>>>      ? kmalloc_trace+0x26/0x90
>>>      do_init_module+0x60/0x240
>>>      __se_sys_init_module+0x185/0x1c0
>>>      do_syscall_64+0x62/0x190
>>>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>      </TASK>
>>>
>>> Add invalidation check of cpudata in amd_pstate_ut_check_perf() and
>>> amd_pstate_ut_check_freq() to avoid unpredicated null pointer dereference.
>>> Otherwise, add driver name detection for amd_pstate_ut driver to prevent it
>> 
>> The driver-name check in amd_pstate_ut_init() is the actual fix: it
>> prevents this module from running its test cases on non-AMD platforms.
>> 
>> The NULL check should not be necessary. On an already-registered amd
>> pstate driver, policy->driver_data is set only after a successful
>> ->init() and is cleared only in ->exit(), so it is never legitimately
>> NULL for a live policy:
>> 
>> 1. Hotplug offline path: a normal CPU hotplug offline does not hit
>> ->exit(). The driver's .offline callback makes __cpufreq_offline() take
>> the light-weight teardown path and return early, so ->exit() (and the
>> kfree) is not invoked and cpudata stays valid. The full teardown only
>> happens on driver unregister / device unbind.
>> 
>> 2. Driver exit path: the NULL check does not close the theoretical UAF
>> window here, since the test does not hold policy->rwsem: cpudata can be
>> kfree()'d between the check and the subsequent dereference. Worse, the
>> passive amd_pstate_cpu_exit() frees cpudata but does not reset policy
>> ->driver_data to NULL, so the check would pass and then dereference a
>> dangling pointer. This is a pre-existing issue and out of scope for this
>> fix.
>> 
>> so it is better to drop the "NULL check of cpudata" commit msg and code.
>> 
>> (Others may have more context here, so please free free correct me if
>> I'm wrong.)
>
>Ack! amd-pstate-ut was intended to be run in isolation without any
>other concurrent driver operation as a sanity check for developers.
>Races with hotplug / any user initiated changes during the test run
>can cause issues.
>
Yes, I agree that dropping NULL check of cpudata is reasonable
for the real user cases.
>> 
>> 
>> 
>>> from testing cpufreq driver on non-amd platform.
>>>
>>> Fixes: 14eb1c96e3a3 ("cpufreq: amd-pstate: Add test module for amd-pstate driver")
>>> Suggested-by: Li Xiong <xiongl24@chinatelecom.cn>
>>> Suggested-by: Xibo Wang <wangxb12@chinatelecom.cn>
>>> Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
>>>
>>> ---
>>> v2:
>>>    - Print policy->cpu instead of policy->kboj.name
>>>    - Add cpufreq driver name detection to amd_pstate_ut
>>>
>>> v1: https://lore.kernel.org/all/1784015941-26535-1-git-send-email-pengqh1@chinatelecom.cn
>>> ---
>>>   drivers/cpufreq/amd-pstate-ut.c | 17 +++++++++++++++++
>>>   1 file changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
>>> index 735b29f..5d71315 100644
>>> --- a/drivers/cpufreq/amd-pstate-ut.c
>>> +++ b/drivers/cpufreq/amd-pstate-ut.c
>>> @@ -157,6 +157,10 @@ static int amd_pstate_ut_check_perf(u32 index)
>>>           if (!policy)
>>>               continue;
>>>           cpudata = policy->driver_data;
>>> +        if (!cpudata) {
>>> +            pr_err("%s empty driver_data on cpu %d\n", __func__, policy->cpu);
>>> +            return -EINVAL;
>> 
>> Strictly speaking, it should be %u, right? Since policy->cpu is an
>> unsigned int, using %d is a format-specifier type mismatch.
>> 
>>> +        }
>>>             if (get_shared_mem()) {
>>>               ret = cppc_get_perf_caps(cpu, &cppc_perf);
>>> @@ -229,6 +233,10 @@ static int amd_pstate_ut_check_freq(u32 index)
>>>           if (!policy)
>>>               continue;
>>>           cpudata = policy->driver_data;
>>> +        if (!cpudata) {
>>> +            pr_err("%s empty driver_data on cpu %d\n", __func__, policy->cpu);
>>> +            return -EINVAL;
>>> +        }
>>>             if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
>>>               (cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
>>> @@ -560,6 +568,15 @@ static int amd_pstate_ut_check_freq_attrs(u32 index)
>>>   static int __init amd_pstate_ut_init(void)
>>>   {
>>>       u32 i = 0, arr_size = ARRAY_SIZE(amd_pstate_ut_cases);
>>> +    const char *driver_name = NULL;
>>> +
>>> +    driver_name = cpufreq_get_current_driver();
>>> +    if (!driver_name)
>>> +        return -ENOENT;
>>> +    /* don't test if non-amd cpufreq_driver exists */
>>> +    else if (strcmp(driver_name, "amd-pstate") &&
>> 
>> Nit: Redundant else after a return: since the previous branch already
>> returns, control can never reach the else if, so it is better to drop
>> the else and use a separate if.
>
>A simpler check would be:
>
>  enum amd_pstate_mode mode = amd_pstate_get_status();
>
>  if (mode == AMD_PSTATE_UNDEFINED || mode == AMD_PSTATE_DISABLE) 
>           return -ENOENT;
>
>Status always starts out as undefined and if the driver doesn't
>load, it stays that way. If user has disabled the driver for any
>reason, the unit test should bail out too.
>
>> 
>>> +         strcmp(driver_name, "amd-pstate-epp"))
>>> +        return -EEXIST;
>> 
>> How about -EOPNOTSUPP or -ENODEV? And it would be helpful to log
>> error info here.
>> 
>> 
>>>         for (i = 0; i < arr_size; i++) {
>>>           int ret;
>> 
>> 
The simple check is honestly graceful, I will send it in patch v3.
And I also think -EOPNOTSUPP is better for telling current error.

--
Thanks and Regards,
Qianheng
