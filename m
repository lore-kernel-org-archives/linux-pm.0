From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: Re: [PATCH v2 1/6] ACPI/PPTT: Add Processor Properties Topology Table
 parsing
Date: Fri, 22 Sep 2017 09:15:21 +0800
Message-ID: <f1752bf4-b62e-e41a-bd58-783c15bba868@huawei.com>
References: <20170919184751.25110-1-jeremy.linton@arm.com>
 <20170919184751.25110-2-jeremy.linton@arm.com>
 <4c9cfa18-507b-01c4-7464-ff2b149fbb68@huawei.com>
 <03912538-f7bf-f235-c87f-3ba275502db0@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <03912538-f7bf-f235-c87f-3ba275502db0@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@codeaurora.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, Jonathan.Zhang@cavium.com, ahs3@redhat.com
List-Id: linux-pm@vger.kernel.org

Hi Jeremy,

On 2017/9/22 2:48, Jeremy Linton wrote:
> Hi,
> 
> On 09/20/2017 02:15 AM, Xiongfeng Wang wrote:
>> Hi Jeremy,
>>
>> On 2017/9/20 2:47, Jeremy Linton wrote:
>>> ACPI 6.2 adds a new table, which describes how processing units
>>> are related to each other in tree like fashion. Caches are
>>> also sprinkled throughout the tree and describe the properties
>>> of the caches in relation to other caches and processing units.
>>>
>>> Add the code to parse the cache hierarchy and report the total
>>> number of levels of cache for a given core using
>>> acpi_find_last_cache_level() as well as fill out the individual
>>> cores cache information with cache_setup_acpi() once the
>>> cpu_cacheinfo structure has been populated by the arch specific
>>> code.
>>>
>>> Further, report peers in the topology using setup_acpi_cpu_topology()
>>> to report a unique ID for each processing unit at a given level
>>> in the tree. These unique id's can then be used to match related
>>> processing units which exist as threads, COD (clusters
>>> on die), within a given package, etc.
>>>
>>> +
>>> +static int topology_setup_acpi_cpu(struct acpi_table_header *table,
>>> +                    unsigned int cpu, int level)
>>> +{
>>> +    struct acpi_pptt_processor *cpu_node;
>>> +    u32 acpi_cpu_id = acpi_cpu_get_madt_gicc(cpu)->uid;
>>> +
>>> +    cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>>> +    if (cpu_node) {
>>> +        cpu_node = acpi_find_processor_package_id(table, cpu_node, level);
>>> +        return (int)((u8 *)cpu_node - (u8 *)table);
>>> +    }
>>> +    pr_err_once("PPTT table found, but unable to locate core for %d\n",
>>> +            cpu);
>>> +    return -ENOENT;
>>
>> Can we return -1 when PPTT doesn't exist? So that we can still get topo info from MPIDR.
>> 'store_cpu_topology()' determine whether cpu topology has been populated by checking
>> whether cluster_id is -1. If cluster_id is not -1, it won't read cpu topo info from MPIDR.
>> Or maybe we can change 'store_cpu_topology()' as well. If cluster_id is less than zero,
>> we read cpu topo info from MPIDR.
> 
> ? I will retest this, but any negative return from setup_acpi_topology() for the initial node (subsequent requests should minimally duplicate the cpu node rather than failing) request, should result in a call to reset_cpu_topology(), and the information being sourced from the MPIDR in store_cpu_topology(). There are various ways the tree could be "damaged" but if all the system cpus have matching valid acpi_id/cpu nodes, then that reflects a valid topology and there really isn't enough information to decide if its damaged. The one case where this isn't accurate is missing socket identifiers, but the code actually handles this as well as the lack of missing cluster/thread ids (which don't exist in the standard).
> 
Yes, you are right. I didn't notice the function reset_cpu_topology() before. Thanks for your explanation.
>>
>>> +}
>>> +
>>> +/*
>>> + * simply assign a ACPI cache entry to each known CPU cache entry
>>> + * determining which entries are shared is done later.
>>> + */
>>> +int cache_setup_acpi(unsigned int cpu)
>>> +{
>>> +    struct acpi_table_header *table;
>>> +    acpi_status status;
>>> +
>>> +    pr_debug("Cache Setup ACPI cpu %d\n", cpu);
>>> +
>>> +    status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
>>> +    if (ACPI_FAILURE(status)) {
>>> +        pr_err_once("No PPTT table found, cache topology may be inaccurate\n");
>>> +        return -ENOENT;
>>> +    }
>>> +
>>> +    cache_setup_acpi_cpu(table, cpu);
>>> +    acpi_put_table(table);
>>> +
>>> +    return status;
>>> +}
>>> +
>>> +/*
>>> + * Determine a topology unique ID for each thread/core/cluster/socket/etc.
>>> + * This ID can then be used to group peers.
>>> + */
>>> +int setup_acpi_cpu_topology(unsigned int cpu, int level)
>>> +{
>>> +    struct acpi_table_header *table;
>>> +    acpi_status status;
>>> +    int retval;
>>
>> Can we add a static int array to record already assigned id for each level?
>> So that we can count the id starting from zero. And also the id can be successive.
> 
> I don't like the idea of a node<->generated_id array/map in this module, although I've considered a number of ways to create more normalized values. Particularly, the one area that might be useful is utilizing the acpi id for the cores, which is problematic in the MT case. One of my other alternative ideas was to plug a unique node id into a reserved field in the table as the node is traversed. That idea is a little evil, and really should be part of the ACPI standard so the firmware is providing the ID's rather than dependent on the traversal order of the tree.
> 
> If it turns out that these ID's need to be zero based, or some other limitation I would prefer just renumbering them in update_siblings_mask() or parse_acpi_topology(). I hacked together a patch to renumber the package_id yesterday, but i'm pretty sure I've seen (non arm) machines with odd package/core ids in the past, and I don't really see anything in the ABI the dictating this. Let me clean it up a bit and I can post it as an additional patch on top of the PPTT patches.
> 
Yes, I agree. Renumbering the IDs in parse_acpi_topology() is better.

> So, is this an actual use case/problem, or its just an "appearance" type of thing?
> 
It is not an actual use problem, just an "appearance".


Thanks,
Xiongfeng Wang



