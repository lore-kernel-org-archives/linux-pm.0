From: Tomasz Nowicki <tnowicki@caviumnetworks.com>
Subject: Re: [PATCH v3 1/7] ACPI/PPTT: Add Processor Properties Topology Table
 parsing
Date: Wed, 18 Oct 2017 12:24:35 +0200
Message-ID: <ed7f2e82-1e9b-9f46-89af-4e638275355d@caviumnetworks.com>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-2-jeremy.linton@arm.com>
 <38c63cfd-4c13-9461-0d4a-74b0943be0fd@semihalf.com>
 <2ce92b90-fc2c-3fff-a3e3-b9517057ab2c@arm.com>
 <4ee4af4d-d987-33f9-4d55-67bfede3ebfa@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4ee4af4d-d987-33f9-4d55-67bfede3ebfa@caviumnetworks.com>
Content-Language: en-GB
Sender: linux-acpi-owner@vger.kernel.org
To: Tomasz Nowicki <tnowicki@caviumnetworks.com>, Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
Cc: mark.rutland@arm.com, Jonathan.Zhang@cavium.com, Jayachandran.Nair@cavium.com, lorenzo.pieralisi@arm.com, austinwc@codeaurora.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, gregkh@linuxfoundation.org, sudeep.holla@arm.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, will.deacon@arm.com, wangxiongfeng2@huawei.com, viresh.kumar@linaro.org, hanjun.guo@linaro.org, catalin.marinas@arm.com, ahs3@redhat.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 18.10.2017 07:39, Tomasz Nowicki wrote:
> Hi,
> 
> On 17.10.2017 17:22, Jeremy Linton wrote:
>> Hi,
>>
>> On 10/17/2017 08:25 AM, Tomasz Nowicki wrote:
>>> Hi Jeremy,
>>>
>>> I did second round of review and have some more comments, please see 
>>> below:
>>>
>>> On 12.10.2017 21:48, Jeremy Linton wrote:
>>>> ACPI 6.2 adds a new table, which describes how processing units
>>>> are related to each other in tree like fashion. Caches are
>>>> also sprinkled throughout the tree and describe the properties
>>>> of the caches in relation to other caches and processing units.
>>>>
>>>> Add the code to parse the cache hierarchy and report the total
>>>> number of levels of cache for a given core using
>>>> acpi_find_last_cache_level() as well as fill out the individual
>>>> cores cache information with cache_setup_acpi() once the
>>>> cpu_cacheinfo structure has been populated by the arch specific
>>>> code.
>>>>
>>>> Further, report peers in the topology using setup_acpi_cpu_topology()
>>>> to report a unique ID for each processing unit at a given level
>>>> in the tree. These unique id's can then be used to match related
>>>> processing units which exist as threads, COD (clusters
>>>> on die), within a given package, etc.
>>>>
>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>> ---
>>>>   drivers/acpi/pptt.c | 485 
>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 485 insertions(+)
>>>>   create mode 100644 drivers/acpi/pptt.c
>>>>
>>>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>>>> new file mode 100644
>>>> index 000000000000..c86715fed4a7
>>>> --- /dev/null
>>>> +++ b/drivers/acpi/pptt.c
>>>> @@ -0,1 +1,485 @@
>>>> +/*
>>>> + * Copyright (C) 2017, ARM
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or 
>>>> modify it
>>>> + * under the terms and conditions of the GNU General Public License,
>>>> + * version 2, as published by the Free Software Foundation.
>>>> + *
>>>> + * This program is distributed in the hope it will be useful, but 
>>>> WITHOUT
>>>> + * ANY WARRANTY; without even the implied warranty of 
>>>> MERCHANTABILITY or
>>>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public 
>>>> License for
>>>> + * more details.
>>>> + *
>>>> + * This file implements parsing of Processor Properties Topology 
>>>> Table (PPTT)
>>>> + * which is optionally used to describe the processor and cache 
>>>> topology.
>>>> + * Due to the relative pointers used throughout the table, this 
>>>> doesn't
>>>> + * leverage the existing subtable parsing in the kernel.
>>>> + */
>>>> +#define pr_fmt(fmt) "ACPI PPTT: " fmt
>>>> +
>>>> +#include <linux/acpi.h>
>>>> +#include <linux/cacheinfo.h>
>>>> +#include <acpi/processor.h>
>>>> +
>>>> +/*
>>>> + * Given the PPTT table, find and verify that the subtable entry
>>>> + * is located within the table
>>>> + */
>>>> +static struct acpi_subtable_header *fetch_pptt_subtable(
>>>> +    struct acpi_table_header *table_hdr, u32 pptt_ref)
>>>> +{
>>>> +    struct acpi_subtable_header *entry;
>>>> +
>>>> +    /* there isn't a subtable at reference 0 */
>>>> +    if (!pptt_ref)
>>>> +        return NULL;
>>>> +
>>>> +    if (pptt_ref + sizeof(struct acpi_subtable_header) > 
>>>> table_hdr->length)
>>>> +        return NULL;
>>>> +
>>>> +    entry = (struct acpi_subtable_header *)((u8 *)table_hdr + 
>>>> pptt_ref);
>>>> +
>>>> +    if (pptt_ref + entry->length > table_hdr->length)
>>>> +        return NULL;
>>>> +
>>>> +    return entry;
>>>> +}
>>>> +
>>>> +static struct acpi_pptt_processor *fetch_pptt_node(
>>>> +    struct acpi_table_header *table_hdr, u32 pptt_ref)
>>>> +{
>>>> +    return (struct acpi_pptt_processor 
>>>> *)fetch_pptt_subtable(table_hdr, pptt_ref);
>>>> +}
>>>> +
>>>> +static struct acpi_pptt_cache *fetch_pptt_cache(
>>>> +    struct acpi_table_header *table_hdr, u32 pptt_ref)
>>>> +{
>>>> +    return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr, 
>>>> pptt_ref);
>>>> +}
>>>> +
>>>> +static struct acpi_subtable_header *acpi_get_pptt_resource(
>>>> +    struct acpi_table_header *table_hdr,
>>>> +    struct acpi_pptt_processor *node, int resource)
>>>> +{
>>>> +    u32 ref;
>>>> +
>>>> +    if (resource >= node->number_of_priv_resources)
>>>> +        return NULL;
>>>> +
>>>> +    ref = *(u32 *)((u8 *)node + sizeof(struct acpi_pptt_processor) +
>>>> +              sizeof(u32) * resource);
>>>> +
>>>> +    return fetch_pptt_subtable(table_hdr, ref);
>>>> +}
>>>> +
>>>> +/*
>>>> + * given a pptt resource, verify that it is a cache node, then walk
>>>> + * down each level of caches, counting how many levels are found
>>>> + * as well as checking the cache type (icache, dcache, unified). If a
>>>> + * level & type match, then we set found, and continue the search.
>>>> + * Once the entire cache branch has been walked return its max
>>>> + * depth.
>>>> + */
>>>> +static int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>>>> +                int local_level,
>>>> +                struct acpi_subtable_header *res,
>>>> +                struct acpi_pptt_cache **found,
>>>> +                int level, int type)
>>>> +{
>>>> +    struct acpi_pptt_cache *cache;
>>>> +
>>>> +    if (res->type != ACPI_PPTT_TYPE_CACHE)
>>>> +        return 0;
>>>> +
>>>> +    cache = (struct acpi_pptt_cache *) res;
>>>> +    while (cache) {
>>>> +        local_level++;
>>>> +
>>>> +        if ((local_level == level) &&
>>>> +            (cache->flags & ACPI_PPTT_CACHE_TYPE_VALID) &&
>>>> +            ((cache->attributes & ACPI_PPTT_MASK_CACHE_TYPE) == 
>>>> type)) {
>>>
>>> Attributes have to be shifted:
>>>
>>> (cache->attributes & ACPI_PPTT_MASK_CACHE_TYPE) >> 2
>>
>> Hmmm, I'm not sure that is true, the top level function in this 
>> routine convert the "linux" constant to the ACPI version of that 
>> constant. In that case the "type" field is pre-shifted, so that it 
>> matches the result of just anding against the field... That is unless 
>> I messed something up, which I don't see at the moment (and the code 
>> of course has been tested with PPTT's from multiple people at this 
>> point).
> 
> For ThunderX2 I got lots of errors in dmesg:
> Found duplicate cache level/type unable to determine uniqueness
> 
> So I fixed "type" macros definitions (without shifting) and shift it 
> here which fixes the issue. As you said, it can be pre-shifted as well.
> 
>>
>>
>>>
>>>> +            if (*found != NULL)
>>>> +                pr_err("Found duplicate cache level/type unable to 
>>>> determine uniqueness\n");

Actually I still see this error messages in my dmesg. It is because the 
following ThunderX2 per-core L1 and L2 cache hierarchy:

Core
  ------------------
|                  |
| L1i -----        |
|         |        |
|          ----L2  |
|         |        |
| L1d -----        |
|                  |
  ------------------

In this case we have two paths which lead to L2 cache and hit above 
case. Is it really error case?

Thanks,
Tomasz
