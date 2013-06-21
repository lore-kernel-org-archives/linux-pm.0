From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH -next] Thermal: x86_pkg_temp: fix krealloc() misuse in
 in pkg_temp_thermal_device_add()
Date: Fri, 21 Jun 2013 09:36:47 -0700
Message-ID: <51C4811F.9070904@linux.intel.com>
References: <CAPgLHd_d5DHn==OFdBsLi_Kkekd5h44Cx6m9Hj5EM_yOGJXKPQ@mail.gmail.com> <1371802062.2170.6.camel@rzhang1-mobl4> <CAPgLHd_T+ez7_fifC9sY33EKcuAa_A+P6w6gK72nn=4hjzp87Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47978 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423018Ab3FUQaT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 21 Jun 2013 12:30:19 -0400
In-Reply-To: <CAPgLHd_T+ez7_fifC9sY33EKcuAa_A+P6w6gK72nn=4hjzp87Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: rui.zhang@intel.com, eduardo.valentin@ti.com, yongjun_wei@trendmicro.com.cn, linux-pm@vger.kernel.org

On 06/21/2013 01:49 AM, Wei Yongjun wrote:
> On 06/21/2013 04:07 PM, Zhang Rui wrote:
>> On Tue, 2013-06-18 at 21:09 +0800, Wei Yongjun wrote:
>>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>>
>>> If krealloc() returns NULL, it doesn't free the original. So any code
>>> of the form 'foo = krealloc(foo, ...);' is almost certainly a bug.
>>>
>> you mean this would probably cause a memory leak, right?
Agree. But whether system will really function it can't allocate few 
bytes (=number CPU  packages). It will crash somewhere anyway.
> Yes.
>
>>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>> ---
>>>   drivers/thermal/x86_pkg_temp_thermal.c | 8 +++++---
>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
>>> index 5de56f6..b90e84b 100644
>>> --- a/drivers/thermal/x86_pkg_temp_thermal.c
>>> +++ b/drivers/thermal/x86_pkg_temp_thermal.c
>>> @@ -394,6 +394,7 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
>>>   	char buffer[30];
>>>   	int thres_count;
>>>   	u32 eax, ebx, ecx, edx;
>>> +	u8 *temp;
>>>   
>>>   	cpuid(6, &eax, &ebx, &ecx, &edx);
>>>   	thres_count = ebx & 0x07;
>>> @@ -417,13 +418,14 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
>>>   	spin_lock(&pkg_work_lock);
>>>   	if (topology_physical_package_id(cpu) > max_phy_id)
>>>   		max_phy_id = topology_physical_package_id(cpu);
>>> -	pkg_work_scheduled = krealloc(pkg_work_scheduled,
>>> -				(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
>>> -	if (!pkg_work_scheduled) {
>>> +	temp = krealloc(pkg_work_scheduled,
>>> +			(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
>>> +	if (!temp) {
>> without this patch, this function will quite if krealloc returns NULL,
>> but with the previous pkg_work_scheduled unfreed, right?
> Yes, without patch, previous pkg_work_scheduled will unfreed if krealloc
> return NULL.
>
>> thanks,
>> rui
>>>   		spin_unlock(&pkg_work_lock);
>>>   		err = -ENOMEM;
>>>   		goto err_ret_free;
>>>   	}
>>> +	pkg_work_scheduled = temp;
>>>   	pkg_work_scheduled[topology_physical_package_id(cpu)] = 0;
>>>   	spin_unlock(&pkg_work_lock);
>>>   
>>>
>>
>>
>
>

