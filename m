Received: from smtph3-05.21cn.com (smtph3-05.21cn.com [150.223.194.107])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D7B368D5A;
	Tue, 14 Jul 2026 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.223.194.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024568; cv=none; b=cx+Y/OLJgBOLoaaQ/746Bej9gDxGa6DH5dAfl/K6Jel60X4cAzEGkjmPLGEsJY9ldCAsd6c9TRsQ6RnlDJBWzE5c4nqqnenS2MMWanhHOoI0Y+X75Ccg8IIA5q75qgxN5N3140otdSKxxwYgBR8BaTAu1LIxL/YbRVWP4IzbLew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024568; c=relaxed/simple;
	bh=zl6q5ZEuRi0OnjdjCuDssbOlfqJ02KbPwk1T9edEj0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RqnZjXzIas++njDirzuTpHqF8wiFAtoT1L6oDbrQD0AnCGCKbZPdahQVJvXP8lpMv3EVzkhLTo8nyuZ2M6YMOhLxMLs66RbeWU1ozRQGPQ13+UOqz+ZfCdFNpl1ht1VXmPnuCeWU6+ruNAoTFoEWvzMUTEdtDrk0F+COgCz4coU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=150.223.194.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:172.27.0.98:0.2063770407
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-139.200.108.11 (unknown [172.27.0.98])
	by smtph3-05.21cn.com (HERMES) with SMTP id 5E50A1402FE04;
	Tue, 14 Jul 2026 18:22:34 +0800 (CST)
X-189-SAVE-TO-SEND: +pengqh1@chinatelecom.cn
Received: from  ([139.200.108.11])
	by gateway-ssl-dep-657b8df9db-d66cm with ESMTP id 54a2170d66d54915a5a174c7458700dc for kprateek.nayak@amd.com;
	Tue, 14 Jul 2026 18:22:41 CST
X-Transaction-ID: 54a2170d66d54915a5a174c7458700dc
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
	zhangar@chinatelecom.cn
Subject: Re: [PATCH] cpufreq: amd-pstate-ut: fix null pointer dereference
Date: Tue, 14 Jul 2026 18:22:33 +0800
Message-Id: <1784024553-16448-1-git-send-email-pengqh1@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <b2835252-409f-4188-aea7-195be3c4e69a@amd.com>
References: <b2835252-409f-4188-aea7-195be3c4e69a@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Hello K Prateek,
Thanks for questions.

On 7/14/2026 14:39, K Prateek Nayak wrote:
>On 7/14/2026 1:29 PM, Qianheng Peng wrote:
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
>
>Is this an AMD platform?
No, it's Intel(R) Xeon(R) Gold 5128.

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
>>                 if (!policy)
>>                         continue;
>>                 cpudata = policy->driver_data;
>> +               if (!cpudata) {
>> +                       pr_err("%s driver_data of %s is empty!\n", __func__, policy->kobj.name);
>> +                       return -EINVAL;
>> +               }
>> 
>>                 if (get_shared_mem()) {
>>                         ret = cppc_get_perf_caps(cpu, &cppc_perf);
>> @@ -229,6 +233,10 @@ static int amd_pstate_ut_check_freq(u32 index)
>>                 if (!policy)
>>                         continue;
>>                 cpudata = policy->driver_data;
>> +               if (!cpudata) {
>> +                       pr_err("%s driver_data of %s is empty!\n", __func__, policy->kobj.name);
>> +                       return -EINVAL;
>> +               }
>
>The only time I think this can happen is when the amd-pstate-ut races with a
>the amd_pstate.*_cpu_exit() (probably as a result of concurrent mode switch)
>or if you are running this without running amd-pstate as the cpufreq driver
>(which the ut doesn't check for beforehand)
>
>My setup fails at this exact same point when I have the driver unloaded.
>What is the output of following before you run into this issue:
>
>    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
>    cat /sys/devices/system/cpu/amd_pstate/status
>
>Are you doing any concurrent hotplug / mode switch?
>
>> 
>>                 if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
>>                         (cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
In this machine, I got output as follow:
======================================================================================
[root@ ~]# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
intel_cpufreq
[root@ ~]# cat /sys/devices/system/cpu/amd_pstate/status
cat: /sys/devices/system/cpu/amd_pstate/status: No such file or directory (os error 2)
======================================================================================
Otherwise,I didn't do any concurrent hotplug / mode switch, just modprobe amd_pstate_ut.

-- 
Thanks and Regards,
Qianheng
