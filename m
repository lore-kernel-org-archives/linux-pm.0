From: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v3 1/7] ACPI/PPTT: Add Processor Properties Topology Table
 parsing
Date: Fri, 13 Oct 2017 10:56:12 +0100
Message-ID: <0adcff12-760b-eef3-3186-34cbb46d5497@arm.com>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-2-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171012194856.13844-2-jeremy.linton@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
Cc: mark.rutland@arm.com, Jonathan.Zhang@cavium.com, Jayachandran.Nair@cavium.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, jhugo@codeaurora.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ahs3@redhat.com, viresh.kumar@linaro.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, austinwc@codeaurora.org, wangxiongfeng2@huawei.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Jeremy,

Please see below some suggestions.

On 12/10/17 20:48, Jeremy Linton wrote:
> ACPI 6.2 adds a new table, which describes how processing units
> are related to each other in tree like fashion. Caches are
> also sprinkled throughout the tree and describe the properties
> of the caches in relation to other caches and processing units.
> 
> Add the code to parse the cache hierarchy and report the total
> number of levels of cache for a given core using
> acpi_find_last_cache_level() as well as fill out the individual
> cores cache information with cache_setup_acpi() once the
> cpu_cacheinfo structure has been populated by the arch specific
> code.
> 
> Further, report peers in the topology using setup_acpi_cpu_topology()
> to report a unique ID for each processing unit at a given level
> in the tree. These unique id's can then be used to match related
> processing units which exist as threads, COD (clusters
> on die), within a given package, etc.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   drivers/acpi/pptt.c | 485 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 485 insertions(+)
>   create mode 100644 drivers/acpi/pptt.c
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> new file mode 100644
> index 000000000000..c86715fed4a7
> --- /dev/null
> +++ b/drivers/acpi/pptt.c
> @@ -0,1 +1,485 @@
> +/*
> + * Copyright (C) 2017, ARM
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * This file implements parsing of Processor Properties Topology Table (PPTT)
> + * which is optionally used to describe the processor and cache topology.
> + * Due to the relative pointers used throughout the table, this doesn't
> + * leverage the existing subtable parsing in the kernel.
> + */
> +#define pr_fmt(fmt) "ACPI PPTT: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/cacheinfo.h>
> +#include <acpi/processor.h>
> +
> +/*
> + * Given the PPTT table, find and verify that the subtable entry
> + * is located within the table
> + */
> +static struct acpi_subtable_header *fetch_pptt_subtable(
> +	struct acpi_table_header *table_hdr, u32 pptt_ref)
> +{
> +	struct acpi_subtable_header *entry;
> +
> +	/* there isn't a subtable at reference 0 */
> +	if (!pptt_ref)
> +		return NULL;

Seeing the usage of pptt_ref to retrieve the subtable, would the 
following be a more accurate check?

	if (pptt_ref < sizeof(struct acpi_table_header))
		return NULL;

> +
> +	if (pptt_ref + sizeof(struct acpi_subtable_header) > table_hdr->length)
> +		return NULL;
> +
> +	entry = (struct acpi_subtable_header *)((u8 *)table_hdr + pptt_ref);
> +
> +	if (pptt_ref + entry->length > table_hdr->length)
> +		return NULL;
> +
> +	return entry;
> +}
> +
> +static struct acpi_pptt_processor *fetch_pptt_node(
> +	struct acpi_table_header *table_hdr, u32 pptt_ref)
> +{
> +	return (struct acpi_pptt_processor *)fetch_pptt_subtable(table_hdr, pptt_ref);
> +}
> +
> +static struct acpi_pptt_cache *fetch_pptt_cache(
> +	struct acpi_table_header *table_hdr, u32 pptt_ref)
> +{
> +	return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr, pptt_ref);
> +}
> +
> +static struct acpi_subtable_header *acpi_get_pptt_resource(
> +	struct acpi_table_header *table_hdr,
> +	struct acpi_pptt_processor *node, int resource)
> +{
> +	u32 ref;
> +
> +	if (resource >= node->number_of_priv_resources)
> +		return NULL;
> +
> +	ref = *(u32 *)((u8 *)node + sizeof(struct acpi_pptt_processor) +
> +		      sizeof(u32) * resource);
> +

I think this can be simplified as:

	ref = *((u32 *)(node + 1) + resource);

> +	return fetch_pptt_subtable(table_hdr, ref);
> +}
> +
> +/*
> + * given a pptt resource, verify that it is a cache node, then walk
> + * down each level of caches, counting how many levels are found
> + * as well as checking the cache type (icache, dcache, unified). If a
> + * level & type match, then we set found, and continue the search.
> + * Once the entire cache branch has been walked return its max
> + * depth.
> + */
> +static int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
> +				int local_level,
> +				struct acpi_subtable_header *res,
> +				struct acpi_pptt_cache **found,
> +				int level, int type)
> +{
> +	struct acpi_pptt_cache *cache;
> +
> +	if (res->type != ACPI_PPTT_TYPE_CACHE)
> +		return 0;
> +
> +	cache = (struct acpi_pptt_cache *) res;
> +	while (cache) {
> +		local_level++;
> +
> +		if ((local_level == level) &&
> +		    (cache->flags & ACPI_PPTT_CACHE_TYPE_VALID) &&
> +		    ((cache->attributes & ACPI_PPTT_MASK_CACHE_TYPE) == type)) {
> +			if (*found != NULL)
> +				pr_err("Found duplicate cache level/type unable to determine uniqueness\n");
> +
> +			pr_debug("Found cache @ level %d\n", level);
> +			*found = cache;
> +			/*
> +			 * continue looking at this node's resource list
> +			 * to verify that we don't find a duplicate
> +			 * cache node.
> +			 */
> +		}
> +		cache = fetch_pptt_cache(table_hdr, cache->next_level_of_cache);
> +	}
> +	return local_level;
> +}
> +
> +/*
> + * Given a CPU node look for cache levels that exist at this level, and then
> + * for each cache node, count how many levels exist below (logically above) it.
> + * If a level and type are specified, and we find that level/type, abort
> + * processing and return the acpi_pptt_cache structure.
> + */
> +static struct acpi_pptt_cache *acpi_find_cache_level(
> +	struct acpi_table_header *table_hdr,
> +	struct acpi_pptt_processor *cpu_node,
> +	int *starting_level, int level, int type)
> +{
> +	struct acpi_subtable_header *res;
> +	int number_of_levels = *starting_level;
> +	int resource = 0;
> +	struct acpi_pptt_cache *ret = NULL;
> +	int local_level;
> +
> +	/* walk down from the processor node */
> +	while ((res = acpi_get_pptt_resource(table_hdr, cpu_node, resource))) {
> +		resource++;
> +
> +		local_level = acpi_pptt_walk_cache(table_hdr, *starting_level,
> +						   res, &ret, level, type);
> +		/*
> +		 * we are looking for the max depth. Since its potentially
> +		 * possible for a given node to have resources with differing
> +		 * depths verify that the depth we have found is the largest.
> +		 */
> +		if (number_of_levels < local_level)
> +			number_of_levels = local_level;
> +	}
> +	if (number_of_levels > *starting_level)
> +		*starting_level = number_of_levels;
> +
> +	return ret;
> +}
> +
> +/*
> + * given a processor node containing a processing unit, walk into it and count
> + * how many levels exist solely for it, and then walk up each level until we hit
> + * the root node (ignore the package level because it may be possible to have
> + * caches that exist across packages). Count the number of cache levels that
> + * exist at each level on the way up.
> + */
> +static int acpi_process_node(struct acpi_table_header *table_hdr,
> +			     struct acpi_pptt_processor *cpu_node)
> +{
> +	int total_levels = 0;
> +
> +	do {
> +		acpi_find_cache_level(table_hdr, cpu_node, &total_levels, 0, 0);
> +		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
> +	} while (cpu_node);
> +
> +	return total_levels;
> +}
> +
> +/* determine if the given node is a leaf node */
> +static int acpi_pptt_leaf_node(struct acpi_table_header *table_hdr,
> +			       struct acpi_pptt_processor *node)
> +{
> +	struct acpi_subtable_header *entry;
> +	unsigned long table_end;
> +	u32 node_entry;
> +	struct acpi_pptt_processor *cpu_node;

Can cpu_node be defined inside the loop? It isn't used outside.

> +
> +	table_end = (unsigned long)table_hdr + table_hdr->length;
> +	node_entry = (u32)((u8 *)node - (u8 *)table_hdr);
> +	entry = (struct acpi_subtable_header *)((u8 *)table_hdr +
> +						sizeof(struct acpi_table_pptt));
> +
> +	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) < table_end) {

	while ((unsigned long) (entry + 1) < table_end) {

> +		cpu_node = (struct acpi_pptt_processor *)entry;
> +		if ((entry->type == ACPI_PPTT_TYPE_PROCESSOR) &&
> +		    (cpu_node->parent == node_entry))
> +			return 0;
> +		entry = (struct acpi_subtable_header *)((u8 *)entry + entry->length);
> +	}
> +	return 1;
> +}
> +
> +/*
> + * Find the subtable entry describing the provided processor
> + */
> +static struct acpi_pptt_processor *acpi_find_processor_node(
> +	struct acpi_table_header *table_hdr,
> +	u32 acpi_cpu_id)
> +{
> +	struct acpi_subtable_header *entry;
> +	unsigned long table_end;
> +	struct acpi_pptt_processor *cpu_node;
> +
> +	table_end = (unsigned long)table_hdr + table_hdr->length;
> +	entry = (struct acpi_subtable_header *)((u8 *)table_hdr +
> +						sizeof(struct acpi_table_pptt));

Can I suggest having two inline functions for this and the above function?

static inline unsigned long acpi_get_table_end(const struct 
acpi_table_header *);

static inline struct acpi_subtable_header *acpi_get_first_entry(const 
struct acpi_table_header *);

(Feel free to adapt the names of course)

> +
> +	/* find the processor structure associated with this cpuid */
> +	while (((unsigned long)entry) + sizeof(struct acpi_subtable_header) < table_end) {

Same as above -> (unsigned long) (entry + 1).


> +		cpu_node = (struct acpi_pptt_processor *)entry;
> +
> +		if ((entry->type == ACPI_PPTT_TYPE_PROCESSOR) &&
> +		    acpi_pptt_leaf_node(table_hdr, cpu_node)) {
> +			pr_debug("checking phy_cpu_id %d against acpi id %d\n",
> +				 acpi_cpu_id, cpu_node->acpi_processor_id);
> +			if (acpi_cpu_id == cpu_node->acpi_processor_id) {
> +				/* found the correct entry */
> +				pr_debug("match found!\n");
> +				return (struct acpi_pptt_processor *)entry;
> +			}
> +		}
> +
> +		if (entry->length == 0) {
> +			pr_err("Invalid zero length subtable\n");
> +			break;
> +		}
> +		entry = (struct acpi_subtable_header *)
> +			((u8 *)entry + entry->length);


I also think it would be nicer to have an inline function for this:

static struct acpi_subtable_header *acpi_get_next_entry(const struct 
acpi_subtable_header *);


> +	}
> +
> +	return NULL;
> +}
> +
> +/*
> + * Given a acpi_pptt_processor node, walk up until we identify the
> + * package that the node is associated with or we run out of levels
> + * to request.
> + */
> +static struct acpi_pptt_processor *acpi_find_processor_package_id(
> +	struct acpi_table_header *table_hdr,
> +	struct acpi_pptt_processor *cpu,
> +	int level)
> +{
> +	struct acpi_pptt_processor *prev_node;
> +
> +	while (cpu && level && !(cpu->flags & ACPI_PPTT_PHYSICAL_PACKAGE)) {
> +		pr_debug("level %d\n", level);
> +		prev_node = fetch_pptt_node(table_hdr, cpu->parent);
> +		if (prev_node == NULL)
> +			break;
> +		cpu = prev_node;
> +		level--;
> +	}
> +	return cpu;
> +}
> +
> +static int acpi_parse_pptt(struct acpi_table_header *table_hdr, u32 acpi_cpu_id)
> +{
> +	int number_of_levels = 0;
> +	struct acpi_pptt_processor *cpu;
> +
> +	cpu = acpi_find_processor_node(table_hdr, acpi_cpu_id);
> +	if (cpu)
> +		number_of_levels = acpi_process_node(table_hdr, cpu);
> +
> +	return number_of_levels;
> +}
> +
> +#define ACPI_6_2_CACHE_TYPE_DATA		      (0x0)
> +#define ACPI_6_2_CACHE_TYPE_INSTR		      (1<<2)
> +#define ACPI_6_2_CACHE_TYPE_UNIFIED		      (1<<3)
> +#define ACPI_6_2_CACHE_POLICY_WB		      (0x0)
> +#define ACPI_6_2_CACHE_POLICY_WT		      (1<<4)
> +#define ACPI_6_2_CACHE_READ_ALLOCATE		      (0x0)
> +#define ACPI_6_2_CACHE_WRITE_ALLOCATE		      (0x01)
> +#define ACPI_6_2_CACHE_RW_ALLOCATE		      (0x02)
> +
> +static u8 acpi_cache_type(enum cache_type type)
> +{
> +	switch (type) {
> +	case CACHE_TYPE_DATA:
> +		pr_debug("Looking for data cache\n");
> +		return ACPI_6_2_CACHE_TYPE_DATA;
> +	case CACHE_TYPE_INST:
> +		pr_debug("Looking for instruction cache\n");
> +		return ACPI_6_2_CACHE_TYPE_INSTR;
> +	default:
> +		pr_debug("Unknown cache type, assume unified\n");
> +	case CACHE_TYPE_UNIFIED:
> +		pr_debug("Looking for unified cache\n");
> +		return ACPI_6_2_CACHE_TYPE_UNIFIED;
> +	}
> +}
> +
> +/* find the ACPI node describing the cache type/level for the given CPU */
> +static struct acpi_pptt_cache *acpi_find_cache_node(
> +	struct acpi_table_header *table_hdr, u32 acpi_cpu_id,
> +	enum cache_type type, unsigned int level,
> +	struct acpi_pptt_processor **node)
> +{
> +	int total_levels = 0;
> +	struct acpi_pptt_cache *found = NULL;
> +	struct acpi_pptt_processor *cpu_node;
> +	u8 acpi_type = acpi_cache_type(type);
> +
> +	pr_debug("Looking for CPU %d's level %d cache type %d\n",
> +		 acpi_cpu_id, level, acpi_type);
> +
> +	cpu_node = acpi_find_processor_node(table_hdr, acpi_cpu_id);
> +	if (!cpu_node)
> +		return NULL;
> +
> +	do {
> +		found = acpi_find_cache_level(table_hdr, cpu_node, &total_levels, level, acpi_type);
> +		*node = cpu_node;
> +		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
> +	} while ((cpu_node) && (!found));

Why not combine the do...while loop and the pevious check in a simple 
while loop? The same condion should work as such for a while loop.

Cheers,

-- 
Julien Thierry
