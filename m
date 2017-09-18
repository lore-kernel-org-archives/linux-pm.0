From: Suniel Mahesh <sunil.m@techveda.org>
Subject: Re: [PATCH] drivers: cpufreq: Fix sysfs duplicate filename creation
 for platform-device
Date: Mon, 18 Sep 2017 22:29:33 +0530
Message-ID: <280ef985-ddb5-bbd5-fb10-d9998225e288@techveda.org>
References: <1505586894-20823-1-git-send-email-sunil.m@techveda.org>
 <20170918011503.GA17030@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170918011503.GA17030@ubuntu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, karthik@techveda.org
List-Id: linux-pm@vger.kernel.org

On Monday 18 September 2017 06:45 AM, Viresh Kumar wrote:
> On 17-09-17, 00:04, sunil.m@techveda.org wrote:
>> From: Suniel Mahesh <sunil.m@techveda.org>
>>
>> ti-cpufreq.c and cpufreq-dt-platdev.c are registering
>> platform device with same name "cpufreq-dt" using
>> platform_device_register_*() routines.
>> This is leading to build warnings appended below.
>>
>> This patch does the following:
>> (a) Remove platform-device registration routine from
>> ti-cpufreq.c, it appears unnecessary as per CPUfreq framework
>> kernel Documentation. The ti-cpufreq driver main task is to use
>> revision and an efuse value from the SoC and provide the OPP
>> framework with supported hardware information.
>> Platform-device creation is taken care by cpufreq-dt-platdev.c.
>> (b) In case if OPP-v2 is not supported just return without
>> registering the platorm-device.
>> (c) Rename the goto label
>>
>> [    2.370167] ------------[ cut here ]------------
>> [    2.375087] WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x58/0x78
>> [    2.383112] sysfs: cannot create duplicate filename '/devices/platform/cpufreq-dt'
>> [    2.391219] Modules linked in:
>> [    2.394506] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.13.0-next-20170912 #1
>> [    2.402006] Hardware name: Generic AM33XX (Flattened Device Tree)
>> [    2.408437] [<c0110a28>] (unwind_backtrace) from [<c010ca84>] (show_stack+0x10/0x14)
>> [    2.416568] [<c010ca84>] (show_stack) from [<c0827d64>] (dump_stack+0xac/0xe0)
>> [    2.424165] [<c0827d64>] (dump_stack) from [<c0137470>] (__warn+0xd8/0x104)
>> [    2.431488] [<c0137470>] (__warn) from [<c01374d0>] (warn_slowpath_fmt+0x34/0x44)
>> [    2.439351] [<c01374d0>] (warn_slowpath_fmt) from [<c03459d0>] (sysfs_warn_dup+0x58/0x78)
>> [    2.447938] [<c03459d0>] (sysfs_warn_dup) from [<c0345ab8>] (sysfs_create_dir_ns+0x80/0x98)
>> [    2.456719] [<c0345ab8>] (sysfs_create_dir_ns) from [<c082c554>] (kobject_add_internal+0x9c/0x2d4)
>> [    2.466124] [<c082c554>] (kobject_add_internal) from [<c082c7d8>] (kobject_add+0x4c/0x9c)
>> [    2.474712] [<c082c7d8>] (kobject_add) from [<c05803e4>] (device_add+0xcc/0x57c)
>> [    2.482489] [<c05803e4>] (device_add) from [<c0584b74>] (platform_device_add+0x100/0x220)
>> [    2.491085] [<c0584b74>] (platform_device_add) from [<c05855a8>] (platform_device_register_full+0xf4/0x118)
>> [    2.501305] [<c05855a8>] (platform_device_register_full) from [<c067023c>] (ti_cpufreq_init+0x150/0x22c)
>> [    2.511253] [<c067023c>] (ti_cpufreq_init) from [<c0101df4>] (do_one_initcall+0x3c/0x170)
>> [    2.519838] [<c0101df4>] (do_one_initcall) from [<c0c00eb4>] (kernel_init_freeable+0x1fc/0x2c4)
>> [    2.528974] [<c0c00eb4>] (kernel_init_freeable) from [<c083bcac>] (kernel_init+0x8/0x110)
>> [    2.537565] [<c083bcac>] (kernel_init) from [<c0107d18>] (ret_from_fork+0x14/0x3c)
>> [    2.545981] ---[ end trace 2fc00e213c13ab20 ]---
>> [    2.551051] ------------[ cut here ]------------
>> [    2.555931] WARNING: CPU: 0 PID: 1 at lib/kobject.c:240 kobject_add_internal+0x254/0x2d4
>> [    2.564578] kobject_add_internal failed for cpufreq-dt with -EEXIST, don't try to register
>> things with the same name in the same directory.
>> [    2.577977] Modules linked in:
>> [    2.581261] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W       4.13.0-next-20170912 #1
>> [    2.590013] Hardware name: Generic AM33XX (Flattened Device Tree)
>> [    2.596437] [<c0110a28>] (unwind_backtrace) from [<c010ca84>] (show_stack+0x10/0x14)
>> [    2.604573] [<c010ca84>] (show_stack) from [<c0827d64>] (dump_stack+0xac/0xe0)
>> [    2.612172] [<c0827d64>] (dump_stack) from [<c0137470>] (__warn+0xd8/0x104)
>> [    2.619494] [<c0137470>] (__warn) from [<c01374d0>] (warn_slowpath_fmt+0x34/0x44)
>> [    2.627362] [<c01374d0>] (warn_slowpath_fmt) from [<c082c70c>] (kobject_add_internal+0x254/0x2d4)
>> [    2.636666] [<c082c70c>] (kobject_add_internal) from [<c082c7d8>] (kobject_add+0x4c/0x9c)
>> [    2.645255] [<c082c7d8>] (kobject_add) from [<c05803e4>] (device_add+0xcc/0x57c)
>> [    2.653027] [<c05803e4>] (device_add) from [<c0584b74>] (platform_device_add+0x100/0x220)
>> [    2.661615] [<c0584b74>] (platform_device_add) from [<c05855a8>] (platform_device_register_full+0xf4/0x118)
>> [    2.671833] [<c05855a8>] (platform_device_register_full) from [<c067023c>] (ti_cpufreq_init+0x150/0x22c)
>> [    2.681779] [<c067023c>] (ti_cpufreq_init) from [<c0101df4>] (do_one_initcall+0x3c/0x170)
>> [    2.690377] [<c0101df4>] (do_one_initcall) from [<c0c00eb4>] (kernel_init_freeable+0x1fc/0x2c4)
>> [    2.699510] [<c0c00eb4>] (kernel_init_freeable) from [<c083bcac>] (kernel_init+0x8/0x110)
>> [    2.708106] [<c083bcac>] (kernel_init) from [<c0107d18>] (ret_from_fork+0x14/0x3c)
>> [    2.716217] ---[ end trace 2fc00e213c13ab21 ]---
>>
>> Signed-off-by: Suniel Mahesh <sunil.m@techveda.org>
>> Tested-by: Suniel Mahesh <sunil.m@techveda.org>
> 
> You don't need a Tested-by from yourself as it is already assumed after the
> Signed-off by.

got it, thanks for making me understand in which cases we need to use it.

> 
>> ---
>> Note:
>> - Patch was compile tested and built(ARCH=arm) on next-20170915.
>> - Patch was hardware tested on AM335x SOC based board.
>> - cpufreq-dt.c driver got probed and entries related to Dynamic Voltage
>>   and Frequency scaling were created in
>>   sysfs @ sys/devices/system/cpu/cpu0/cpufreq.
>> - No build/run-time issues reported.
>> ---
>>  drivers/cpufreq/ti-cpufreq.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
>> index b29cd33..97c086a 100644
>> --- a/drivers/cpufreq/ti-cpufreq.c
>> +++ b/drivers/cpufreq/ti-cpufreq.c
>> @@ -224,7 +224,7 @@ static int ti_cpufreq_init(void)
>>  	if (!opp_data->opp_node) {
>>  		dev_info(opp_data->cpu_dev,
>>  			 "OPP-v2 not supported, cpufreq-dt will attempt to use legacy tables.\n");
>> -		goto register_cpufreq_dt;
>> +		goto ti_cpufreq_exit;
>>  	}
>>  
>>  	ret = ti_cpufreq_setup_syscon_register(opp_data);
>> @@ -255,9 +255,7 @@ static int ti_cpufreq_init(void)
>>  
>>  	of_node_put(opp_data->opp_node);
>>  
>> -register_cpufreq_dt:
>> -	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
>> -
> 
> NACK.
> 
> It was done this way to make sure ti-cpufreq.c does all the platform specific
> stuff before the cpufreq-dt driver comes into place.

got it, thanks for the explanation.

> 
> If both ti-cpufreq and cpufreq-dt-platform are creating the device, then there
> is something else wrong. Did it start failing recently only? Then it might be
> due to one of the patches I posted for cpufreq-dt-platdev. 

Yes, it's happening for the latest mainline rc kernel and next trees because of
this commit:
"edeec420de24 (cpufreq: dt-platdev: Automatically create cpufreq device with OPP v2)"

You need to add that
> patch in the fixes tag and add TI SoCs in the blacklist of devices (with opp-v2)
> in cpufreq-dt-platform.c.
> 

working on it, thanks for the inputs.

Regards
Suniel
