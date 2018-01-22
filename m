From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v6 07/12] drivers: base cacheinfo: Add support for ACPI
 based firmware tables
Date: Mon, 22 Jan 2018 15:14:37 -0600
Message-ID: <1485ab78-4b43-b703-ca48-4e2cb2059e51@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-8-jeremy.linton@arm.com>
 <20180122155022.GA7714@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180122155022.GA7714@kroah.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

Hi,

Thanks for taking a look at this.

On 01/22/2018 09:50 AM, Greg KH wrote:
> On Fri, Jan 12, 2018 at 06:59:15PM -0600, Jeremy Linton wrote:
>> Add a entry to to struct cacheinfo to maintain a reference to the PPTT
>> node which can be used to match identical caches across cores. Also
>> stub out cache_setup_acpi() so that individual architectures can
>> enable ACPI topology parsing.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/acpi/pptt.c       |  1 +
>>   drivers/base/cacheinfo.c  | 20 +++++++++++++-------
>>   include/linux/cacheinfo.h |  9 +++++++++
>>   3 files changed, 23 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 2c4b3ed862a8..4f5ab19c3a08 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -329,6 +329,7 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>>   {
>>   	int valid_flags = 0;
>>   
>> +	this_leaf->fw_unique = cpu_node;
>>   	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID) {
>>   		this_leaf->size = found_cache->size;
>>   		valid_flags++;
>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
>> index 217aa90fb036..ee51e33cc37c 100644
>> --- a/drivers/base/cacheinfo.c
>> +++ b/drivers/base/cacheinfo.c
>> @@ -208,16 +208,16 @@ static int cache_setup_of_node(unsigned int cpu)
>>   
>>   	if (index != cache_leaves(cpu)) /* not all OF nodes populated */
>>   		return -ENOENT;
>> -
>>   	return 0;
>>   }
>> +
> 
> Whitespace changes not needed for this patch :(

Sure.

> 
> 
>>   #else
>>   static inline int cache_setup_of_node(unsigned int cpu) { return 0; }
>>   static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
>>   					   struct cacheinfo *sib_leaf)
>>   {
>>   	/*
>> -	 * For non-DT systems, assume unique level 1 cache, system-wide
>> +	 * For non-DT/ACPI systems, assume unique level 1 caches, system-wide
>>   	 * shared caches for all other levels. This will be used only if
>>   	 * arch specific code has not populated shared_cpu_map
>>   	 */
>> @@ -225,6 +225,11 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
>>   }
>>   #endif
>>   
>> +int __weak cache_setup_acpi(unsigned int cpu)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>>   static int cache_shared_cpu_map_setup(unsigned int cpu)
>>   {
>>   	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>> @@ -235,11 +240,11 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
>>   	if (this_cpu_ci->cpu_map_populated)
>>   		return 0;
>>   
>> -	if (of_have_populated_dt())
>> +	if (!acpi_disabled)
>> +		ret = cache_setup_acpi(cpu);
> 
> Why does acpi go first?  :)

This sounds like a joke i heard...

OTOH, given that we have machines with both ACPI and DT tables, it 
seemed a little clearer and a little more robust to code that so that if 
ACPI is enabled to prefer it over DT information. As long as the 
routines which set of of_root are protected by if (acpi_disabled) checks 
it should be safe to do it either way.


> 
>> +	else if (of_have_populated_dt())
>>   		ret = cache_setup_of_node(cpu);
>> -	else if (!acpi_disabled)
>> -		/* No cache property/hierarchy support yet in ACPI */
>> -		ret = -ENOTSUPP;
>> +
>>   	if (ret)
>>   		return ret;
>>   
>> +int acpi_find_last_cache_level(unsigned int cpu)
>> +{
>> +	/*ACPI kernels should be built with PPTT support*/
> 
> Here are some extra ' ' characters, you need them...

Oh ok, thanks! :)


