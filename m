From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: Re: [PATCH -next] Thermal: x86_pkg_temp: fix krealloc() misuse in in pkg_temp_thermal_device_add()
Date: Fri, 21 Jun 2013 16:49:38 +0800
Message-ID: <CAPgLHd_T+ez7_fifC9sY33EKcuAa_A+P6w6gK72nn=4hjzp87Q@mail.gmail.com>
References: <CAPgLHd_d5DHn==OFdBsLi_Kkekd5h44Cx6m9Hj5EM_yOGJXKPQ@mail.gmail.com>
	<1371802062.2170.6.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:41660 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758010Ab3FUItj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jun 2013 04:49:39 -0400
Received: by mail-bk0-f47.google.com with SMTP id jg1so3219688bkc.6
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2013 01:49:38 -0700 (PDT)
In-Reply-To: <1371802062.2170.6.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: eduardo.valentin@ti.com, yongjun_wei@trendmicro.com.cn, linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com

On 06/21/2013 04:07 PM, Zhang Rui wrote:
> On Tue, 2013-06-18 at 21:09 +0800, Wei Yongjun wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> If krealloc() returns NULL, it doesn't free the original. So any code
>> of the form 'foo = krealloc(foo, ...);' is almost certainly a bug.
>>
> you mean this would probably cause a memory leak, right?

Yes.

>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> ---
>>  drivers/thermal/x86_pkg_temp_thermal.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
>> index 5de56f6..b90e84b 100644
>> --- a/drivers/thermal/x86_pkg_temp_thermal.c
>> +++ b/drivers/thermal/x86_pkg_temp_thermal.c
>> @@ -394,6 +394,7 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
>>  	char buffer[30];
>>  	int thres_count;
>>  	u32 eax, ebx, ecx, edx;
>> +	u8 *temp;
>>  
>>  	cpuid(6, &eax, &ebx, &ecx, &edx);
>>  	thres_count = ebx & 0x07;
>> @@ -417,13 +418,14 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
>>  	spin_lock(&pkg_work_lock);
>>  	if (topology_physical_package_id(cpu) > max_phy_id)
>>  		max_phy_id = topology_physical_package_id(cpu);
>> -	pkg_work_scheduled = krealloc(pkg_work_scheduled,
>> -				(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
>> -	if (!pkg_work_scheduled) {
>> +	temp = krealloc(pkg_work_scheduled,
>> +			(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
>> +	if (!temp) {
> without this patch, this function will quite if krealloc returns NULL,
> but with the previous pkg_work_scheduled unfreed, right?

Yes, without patch, previous pkg_work_scheduled will unfreed if krealloc
return NULL.

>
> thanks,
> rui
>>  		spin_unlock(&pkg_work_lock);
>>  		err = -ENOMEM;
>>  		goto err_ret_free;
>>  	}
>> +	pkg_work_scheduled = temp;
>>  	pkg_work_scheduled[topology_physical_package_id(cpu)] = 0;
>>  	spin_unlock(&pkg_work_lock);
>>  
>>
>
>
>


