From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v6 05/12] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
Date: Tue, 16 Jan 2018 14:22:22 -0600
Message-ID: <096cdff0-d160-68ba-4cd2-0691dd04eac6@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-6-jeremy.linton@arm.com>
 <20180115154813.GB17664@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180115154813.GB17664@e107155-lin>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, morten.rasmussen@arm.com
List-Id: linux-pm@vger.kernel.org

Hi,

On 01/15/2018 09:48 AM, Sudeep Holla wrote:
> On Fri, Jan 12, 2018 at 06:59:13PM -0600, Jeremy Linton wrote:
>> ACPI 6.2 adds a new table, which describes how processing units
>> are related to each other in tree like fashion. Caches are
>> also sprinkled throughout the tree and describe the properties
>> of the caches in relation to other caches and processing units.
>>
>> Add the code to parse the cache hierarchy and report the total
>> number of levels of cache for a given core using
>> acpi_find_last_cache_level() as well as fill out the individual
>> cores cache information with cache_setup_acpi() once the
>> cpu_cacheinfo structure has been populated by the arch specific
>> code.
>>
>> An additional patch later in the set adds the ability to report
>> peers in the topology using find_acpi_cpu_topology()
>> to report a unique ID for each processing unit at a given level
>> in the tree. These unique id's can then be used to match related
>> processing units which exist as threads, COD (clusters
>> on die), within a given package, etc.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/acpi/pptt.c | 476 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 476 insertions(+)
>>   create mode 100644 drivers/acpi/pptt.c
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> new file mode 100644
>> index 000000000000..2c4b3ed862a8
>> --- /dev/null
>> +++ b/drivers/acpi/pptt.c
>> @@ -0,0 +1,476 @@
>> +/*
>> + * Copyright (C) 2018, ARM
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * This file implements parsing of Processor Properties Topology Table (PPTT)
>> + * which is optionally used to describe the processor and cache topology.
>> + * Due to the relative pointers used throughout the table, this doesn't
>> + * leverage the existing subtable parsing in the kernel.
>> + *
>> + * The PPTT structure is an inverted tree, with each node potentially
>> + * holding one or two inverted tree data structures describing
>> + * the caches available at that level. Each cache structure optionally
>> + * contains properties describing the cache at a given level which can be
>> + * used to override hardware probed values.
>> + */
>> +#define pr_fmt(fmt) "ACPI PPTT: " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/cacheinfo.h>
>> +#include <acpi/processor.h>
>> +
>> +/* total number of attributes checked by the properties code */
>> +#define PPTT_CHECKED_ATTRIBUTES 6
>> +
>> +/*
>> + * Given the PPTT table, find and verify that the subtable entry
>> + * is located within the table
>> + */
>> +static struct acpi_subtable_header *fetch_pptt_subtable(
>> +	struct acpi_table_header *table_hdr, u32 pptt_ref)
>> +{
>> +	struct acpi_subtable_header *entry;
>> +
>> +	/* there isn't a subtable at reference 0 */
>> +	if (pptt_ref < sizeof(struct acpi_subtable_header))
>> +		return NULL;
>> +
>> +	if (pptt_ref + sizeof(struct acpi_subtable_header) > table_hdr->length)
>> +		return NULL;
>> +
>> +	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr, pptt_ref);
>> +
>> +	if (pptt_ref + entry->length > table_hdr->length)
>> +		return NULL;
>> +
>> +	return entry;
>> +}
>> +
>> +static struct acpi_pptt_processor *fetch_pptt_node(
>> +	struct acpi_table_header *table_hdr, u32 pptt_ref)
>> +{
>> +	return (struct acpi_pptt_processor *)fetch_pptt_subtable(table_hdr,
>> +								 pptt_ref);
>> +}
>> +
>> +static struct acpi_pptt_cache *fetch_pptt_cache(
>> +	struct acpi_table_header *table_hdr, u32 pptt_ref)
>> +{
>> +	return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr,
>> +							     pptt_ref);
>> +}
>> +
>> +static struct acpi_subtable_header *acpi_get_pptt_resource(
>> +	struct acpi_table_header *table_hdr,
>> +	struct acpi_pptt_processor *node, int resource)
>> +{
>> +	u32 *ref;
>> +
>> +	if (resource >= node->number_of_priv_resources)
>> +		return NULL;
>> +
>> +	ref = ACPI_ADD_PTR(u32, node, sizeof(struct acpi_pptt_processor));
>> +	ref += resource;
>> +
>> +	return fetch_pptt_subtable(table_hdr, *ref);
>> +}
>> +
>> +/*
>> + * Attempt to find a given cache level, while counting the max number
>> + * of cache levels for the cache node.
>> + *
>> + * Given a pptt resource, verify that it is a cache node, then walk
>> + * down each level of caches, counting how many levels are found
>> + * as well as checking the cache type (icache, dcache, unified). If a
>> + * level & type match, then we set found, and continue the search.
>> + * Once the entire cache branch has been walked return its max
>> + * depth.
>> + */
>> +static int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>> +				int local_level,
>> +				struct acpi_subtable_header *res,
>> +				struct acpi_pptt_cache **found,
>> +				int level, int type)
>> +{
>> +	struct acpi_pptt_cache *cache;
>> +
>> +	if (res->type != ACPI_PPTT_TYPE_CACHE)
>> +		return 0;
>> +
>> +	cache = (struct acpi_pptt_cache *) res;
>> +	while (cache) {
>> +		local_level++;
>> +
>> +		if ((local_level == level) &&
>> +		    (cache->flags & ACPI_PPTT_CACHE_TYPE_VALID) &&
>> +		    ((cache->attributes & ACPI_PPTT_MASK_CACHE_TYPE) == type)) {
>> +			if ((*found != NULL) && (cache != *found))
> 
> I forgot to mention this earlier, I see you have used parentheses too
> liberally at quite some place in this file like the above 4 line.
> Please drop those unnecessary parentheses.

Yes, those tend to get leftover when I remove code, I realized not long 
after posting this that in one of the previous patches I actually added 
a pair where there wasn't one because I first shuffled something into 
the if condition, then a few revisions later dropped it, and when I 
squashed it before posting the result was some pointless churn.

I will rescan the whole set for this.



