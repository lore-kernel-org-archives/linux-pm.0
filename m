From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v5 8/9] arm64: topology: Enable ACPI/PPTT based CPU
 topology.
Date: Fri, 15 Dec 2017 11:42:05 -0600
Message-ID: <0262564b-807a-84d2-7b0a-a74c971d07b7@arm.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-9-jeremy.linton@arm.com>
 <20171213182219.GC4060@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171213182219.GC4060@red-moon>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 12/13/2017 12:22 PM, Lorenzo Pieralisi wrote:
> Nit: remove the period in $SUBJECT and capitalize with a coherent
> policy for the patches touching the same code.

Ok, thanks.

> 
> On Fri, Dec 01, 2017 at 04:23:29PM -0600, Jeremy Linton wrote:
>> Propagate the topology information from the PPTT tree to the
>> cpu_topology array. We can get the thread id, core_id and
>> cluster_id by assuming certain levels of the PPTT tree correspond
>> to those concepts. The package_id is flagged in the tree and can be
>> found by calling find_acpi_cpu_topology_package() which terminates
>> its search when it finds an ACPI node flagged as the physical
>> package. If the tree doesn't contain enough levels to represent
>> all of the requested levels then the root node will be returned
>> for all subsequent levels.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/kernel/topology.c | 47 +++++++++++++++++++++++++++++++++++++++++++-
>>   include/linux/topology.h     |  2 ++
>>   2 files changed, 48 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index 74a8a5173a35..198714aca9e8 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -11,6 +11,7 @@
>>    * for more details.
>>    */
>>   
>> +#include <linux/acpi.h>
>>   #include <linux/arch_topology.h>
>>   #include <linux/cpu.h>
>>   #include <linux/cpumask.h>
>> @@ -22,6 +23,7 @@
>>   #include <linux/sched.h>
>>   #include <linux/sched/topology.h>
>>   #include <linux/slab.h>
>> +#include <linux/smp.h>
>>   #include <linux/string.h>
>>   
>>   #include <asm/cpu.h>
>> @@ -300,6 +302,47 @@ static void __init reset_cpu_topology(void)
>>   	}
>>   }
>>   
>> +#ifdef CONFIG_ACPI
>> +/*
>> + * Propagate the topology information of the processor_topology_node tree to the
>> + * cpu_topology array.
>> + */
>> +static int __init parse_acpi_topology(void)
>> +{
>> +	u64 is_threaded;
> 
> Nit: a bool would be preferable.
> 
>> +	int cpu;
>> +	int topology_id;
> 
> int cpu, topology_id;
> 
>> +	is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
> 
>> +	for_each_possible_cpu(cpu) {
>> +		topology_id = find_acpi_cpu_topology(cpu, 0);
>> +		if (topology_id < 0)
>> +			return topology_id;
>> +
>> +		if (is_threaded) {
>> +			cpu_topology[cpu].thread_id = topology_id;
>> +			topology_id = find_acpi_cpu_topology(cpu, 1);
>> +			cpu_topology[cpu].core_id   = topology_id;
>> +			topology_id = find_acpi_cpu_topology_package(cpu);
>> +			cpu_topology[cpu].physical_id = topology_id;
>> +		} else {
>> +			cpu_topology[cpu].thread_id  = -1;
>> +			cpu_topology[cpu].core_id    = topology_id;
>> +			topology_id = find_acpi_cpu_topology_package(cpu);
>> +			cpu_topology[cpu].physical_id = topology_id;
>> +		}
>> +	}
> 
> Add a space.
> 
> It is probably my fault so apologies if that's the case. The
> 
> find_acpi_cpu_topology()
> 
> API is a bit strange since it behaves differently according to the
> level passed in.

? In the sense that the id is more directly defined by the firmware for 
level0? Not sure this really matters, particularly if at some future 
point we come up with a way to standardize an id for the sockets/etc (or 
we just renumber the nodes).

AKA, I don't see a problem as we aren't making any guarantees about what 
the return id represents other than its unique for siblings at a given 
level.

> 
> I think it is better to define two calls (it might well have been like
> that in one of the previous series versions):
> 
> - find_acpi_cpu_package_level() (returns: package level if success, <0 on
>    failure)
> - acpi_cpu_topology_id()

So, knowing the absolute level a given flag is set at allows you to 
query a node relative to that level. That is a good idea if you wanted 
to identify say a numa in package level (say package-1). But its 
complicated by that fact that package-1 may be meaningless in a lot of 
cases (maybe package-1 is just a core). The alternative here for finding 
a numa proximity domain is to try to find a PPTT node with a subset of 
cores which happens to match an proximity domain. But given there is 
currently nothing in the specification which requires a 1:1 mapping 
between a given set of PPTT nodes and a proximity domain (given the PPTT 
is focused on cache nodes) I tend to think we want further flags in the 
PPTT and language that makes it clear when this happens. So the 
interface should be more generic find_acpi_cpu_flag_level(cpu, flag). 
That way we avoid the complexity of trying to guess from a relative 
level if a particular topological feature is appropriate.


> 
> It would even be better to lump the two calls together but you do not
> know how many topology levels are there so it becomes a bit complicated
> to handle.

Right, which is basically what the underlying 
find_acpi_cpu_topology_tag() is doing at the moment. My tendency here is 
just to export that call and let the PPTT parsing code wrap the decision 
about what to do if the flag can't be found. Which means the whole 
discussion above about letting the higher level code try to infer 
relative levels is a last resort. I'm more for creating a couple 
additional flags (FLAG_GIVE_ME_LEVEL_WHERE_NUMA_STARTS) and feeding it 
to acpi_cpu_topology_tag() with some additional logic which says 
something to the affect, return the NUMA level in the PPTT described by 
some future standardized flag, otherwise return the socket level, and if 
that doesn't exist return the root node level (or maybe if we get 
desperate a node which seems to match a SRAT proximity domain). That 
keeps the PPTT interface fairly simple, and keeps the level selection 
out of the common topology code.


There are also some other possible future directions which don't fit any 
of these models. So in that regard I think we want to keep the inteface 
as simple as possible, and transform it in the future when we have a 
direct need for it.
	
Thanks,


