From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v5 6/9] ACPI/PPTT: Add topology parsing code
Date: Wed, 3 Jan 2018 10:57:51 -0600
Message-ID: <f89c8f07-bef6-c20b-cb2e-eaa2121689b3@arm.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-7-jeremy.linton@arm.com>
 <9009154.M66RGdQJXA@aspire.rjw.lan>
 <fc12696c-15e1-cea4-42bf-db4b5daa45f2@arm.com>
 <20171213173851.GA4060@red-moon>
 <CAJZ5v0hTcC8D6pJuPK+isntWpckNgNmqLHW98iFXL817VYHHdg@mail.gmail.com>
 <6aca3fa0-9099-f283-ae16-0c48aa00d00d@arm.com>
 <CAJZ5v0hBZQ-vYbobOYtKFVg9hAtUo4GU==napcJ-btQhMvn+5g@mail.gmail.com>
 <019601d3846f$c8708550$59518ff0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <019601d3846f$c8708550$59518ff0$@codeaurora.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: vkilari@codeaurora.org
Cc: 'Mark Rutland' <mark.rutland@arm.com>, Jonathan.Zhang@cavium.com, Jayachandran.Nair@cavium.com, 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>, 'Catalin Marinas' <catalin.marinas@arm.com>, jhugo@codeaurora.org, 'Will Deacon' <will.deacon@arm.com>, 'Linux PM' <linux-pm@vger.kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'ACPI Devel Maling List' <linux-acpi@vger.kernel.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Hanjun Guo' <hanjun.guo@linaro.org>, 'Al Stone' <ahs3@redhat.com>, 'Sudeep Holla' <sudeep.holla@arm.com>, austinwc@codeaurora.org, wangxiongfeng2@huawei.com, "'Rafael J. Wysocki'" <rafael@kernel.org>, linux-arm-kernel@lists.infr
List-Id: linux-pm@vger.kernel.org

Hi,

On 01/03/2018 02:49 AM, vkilari@codeaurora.org wrote:
> Hi Jeremy,
> 
>   Sorry, I don't have your previous patch emails to reply on right patch
> context.
> So commenting on top of this patch.
> 
> AFAIU, the PPTT v5 patches still rely on CLIDR_EL1 register to know the type
> of
> Caches enabled/available on the platform. With PPTT, it should not rely on
> architecture
> registers. There can be platforms which can report cache availability in
> PPTT but not in
> architecture registers.
> 
> The following code snippet shows usage of CLIDR_EL1
> 
> In arch/arm64/kernel/cacheinfo.c
> 
> static inline enum cache_type get_cache_type(int level)
> {
>           u64 clidr;
>   
>           if (level > MAX_CACHE_LEVEL)
>                   return CACHE_TYPE_NOCACHE;
>           clidr = read_sysreg(clidr_el1);
>           return CLIDR_CTYPE(clidr, level);
> }
> 
> static int __populate_cache_leaves(unsigned int cpu)
> {
>            unsigned int level, idx;
>            enum cache_type type;
>            struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>            struct cacheinfo *this_leaf = this_cpu_ci->info_list;
>    
>            for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
>                 idx < this_cpu_ci->num_leaves; idx++, level++) {
>                    type = get_cache_type(level);
>                    if (type == CACHE_TYPE_SEPARATE) {
>                            ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
>                            ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
>                    } else {
>                            ci_leaf_init(this_leaf++, type, level);
>                    }
>           }
>            return 0;
>   }
> 
> In populate_cache_leaves() the cache type is read from CLIDR_EL1 register.
> If CLIDR_EL1 reports CACHE_TYPE_NOCACHE for a particular level then sysfs
> entry
> /sys/devices/system/cpu/cpu0/index<n>/type is not created and hence
> userspace tools
> like lstopo will not report this cache level.


This sounds suspiciously like one of things tweaked between v4->v5. If 
you look at update_cache_properties() in patch 2/9, you will see that we 
only update/find NOCACHE nodes and convert them to UNIFIED when all the 
attributes in the node are supplied.

This means that if the node has an incomplete set of attributes we won't 
update it. Can you verify that you have all those attributes set for 
nodes which aren't being described by the hardware?

Thanks,


> 
> Regards
> Vijay
> 
>> -----Original Message-----
>> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces@lists.infradead.org]
>> On Behalf Of Rafael J. Wysocki
>> Sent: Thursday, December 14, 2017 4:40 AM
>> To: Jeremy Linton <jeremy.linton@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>; Jonathan.Zhang@cavium.com;
>> Jayachandran.Nair@cavium.com; Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com>; Catalin Marinas <catalin.marinas@arm.com>;
>> Rafael J. Wysocki <rafael@kernel.org>; jhugo@codeaurora.org; Will Deacon
>> <will.deacon@arm.com>; Linux PM <linux-pm@vger.kernel.org>; Rafael J.
>> Wysocki <rjw@rjwysocki.net>; Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>; Linux Kernel Mailing List <linux-
>> kernel@vger.kernel.org>; ACPI Devel Maling List
> <linux-acpi@vger.kernel.org>;
>> Viresh Kumar <viresh.kumar@linaro.org>; Hanjun Guo
>> <hanjun.guo@linaro.org>; Al Stone <ahs3@redhat.com>; Sudeep Holla
>> <sudeep.holla@arm.com>; austinwc@codeaurora.org;
>> wangxiongfeng2@huawei.com; linux-arm-kernel@lists.infradead.org; Len
>> Brown <lenb@kernel.org>
>> Subject: Re: [PATCH v5 6/9] ACPI/PPTT: Add topology parsing code
>>
>> On Thu, Dec 14, 2017 at 12:06 AM, Jeremy Linton <jeremy.linton@arm.com>
>> wrote:
>>> Hi,
>>>
>>>
>>> On 12/13/2017 04:28 PM, Rafael J. Wysocki wrote:
>>>>
>>>> On Wed, Dec 13, 2017 at 6:38 PM, Lorenzo Pieralisi
>>>> <lorenzo.pieralisi@arm.com> wrote:
>>>>>
>>>>> On Tue, Dec 12, 2017 at 10:13:08AM -0600, Jeremy Linton wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> First, thanks for taking a look at this.
>>>>>>
>>>>>> On 12/11/2017 07:12 PM, Rafael J. Wysocki wrote:
>>>>>>>
>>>>>>> On Friday, December 1, 2017 11:23:27 PM CET Jeremy Linton wrote:
>>>>>>>>
>>>>>>>> The PPTT can be used to determine the groupings of CPU's at given
>>>>>>>> levels in the system. Lets add a few routines to the PPTT parsing
>>>>>>>> code to return a unique id for each unique level in the processor
>>>>>>>> hierarchy. This can then be matched to build
>>>>>>>> thread/core/cluster/die/package/etc mappings for each processing
>>>>>>>> element in the system.
>>>>>>>>
>>>>>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>>>>>
>>>>>>>
>>>>>>> Why can't this be folded into patch [2/9]?
>>>>>>
>>>>>>
>>>>>> It can, and I will be happy squash it.
>>>>>>
>>>>>> It was requested that the topology portion of the parser be split
>>>>>> out back in v3.
>>>>>>
>>>>>> https://www.spinics.net/lists/linux-acpi/msg78487.html
>>>>>
>>>>>
>>>>> I asked to split cache/topology since I am not familiar with cache
>>>>> code and Sudeep - who looks after the cache code - won't be able to
>>>>> review this series in time for v4.16.
>>>>
>>>>
>>>> OK, so why do we need it in 4.16?
>>>
>>>
>>> I think its more case of as soon as possible. That is because there
>>> are machines where the topology is completely incorrect due to
>>> assumptions the kernel makes based on registers that aren't defined
>>> for that purpose (say describing which cores are in a physical socket,
>>> or LLC's attached to interconnects or memory controllers).
>>>
>>> This incorrect topology information is reported to things like the
>>> kernel scheduler, which then makes poor scheduling decisions resulting
>>> in sub-optimal system performance.
>>>
>>> This patchset (and ACPI 6.2) clears up a lot of those problems.
>>
>> As long as the ACPI tables are as expected that is, I suppose?
>>
>> Anyway, fair enough, but I don't want to rush it in.
>>
>> Thanks,
>> Rafael
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

