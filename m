From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v5 7/9] arm64: Topology, rename cluster_id
Date: Fri, 15 Dec 2017 10:36:35 -0600
Message-ID: <7bb4e955-f3e5-d22f-4e78-eac97e66a9a6@arm.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-8-jeremy.linton@arm.com>
 <20171213180217.GB4060@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59036 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756717AbdLOQgh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Dec 2017 11:36:37 -0500
In-Reply-To: <20171213180217.GB4060@red-moon>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

Hi,

On 12/13/2017 12:02 PM, Lorenzo Pieralisi wrote:
> [+Morten, Dietmar]
> 
> $SUBJECT should be:
> 
> arm64: topology: rename cluster_id

Sure..

> 
> On Fri, Dec 01, 2017 at 04:23:28PM -0600, Jeremy Linton wrote:
>> Lets match the name of the arm64 topology field
>> to the kernel macro that uses it.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/include/asm/topology.h |  4 ++--
>>   arch/arm64/kernel/topology.c      | 27 ++++++++++++++-------------
>>   2 files changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
>> index c4f2d50491eb..118136268f66 100644
>> --- a/arch/arm64/include/asm/topology.h
>> +++ b/arch/arm64/include/asm/topology.h
>> @@ -7,14 +7,14 @@
>>   struct cpu_topology {
>>   	int thread_id;
>>   	int core_id;
>> -	int cluster_id;
>> +	int physical_id;
> 
> package_id ?

Given the macro is topology_physical_package_id, either makes sense to 
me. <shrug> I will change it in the next set.


> 
> It has been debated before, I know. Should we keep the cluster_id too
> (even if it would be 1:1 mapped to package_id - for now) ?

Well given that this patch replaces the patch that did that at your 
request..

I was hoping someone else would comment here, but my take at this point 
is that it doesn't really matter in a functional sense at the moment.
Like the chiplet discussion it can be the subject of a future patch 
along with the patches which tweak the scheduler to understand the split.

BTW, given that i'm OoO next week, and the following that are the 
holidays, I don't intend to repost this for a couple weeks. I don't 
think there are any issues with this set.

> 
> There is also arch/arm to take into account, again, this patch is
> just renaming (as it should have named since the beginning) a
> topology level but we should consider everything from a legacy
> perspective.
> 
> Lorenzo
> 
>>   	cpumask_t thread_sibling;
>>   	cpumask_t core_sibling;
>>   };
>>   
>>   extern struct cpu_topology cpu_topology[NR_CPUS];
>>   
>> -#define topology_physical_package_id(cpu)	(cpu_topology[cpu].cluster_id)
>> +#define topology_physical_package_id(cpu)	(cpu_topology[cpu].physical_id)
>>   #define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
>>   #define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
>>   #define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
>> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
>> index 8d48b233e6ce..74a8a5173a35 100644
>> --- a/arch/arm64/kernel/topology.c
>> +++ b/arch/arm64/kernel/topology.c
>> @@ -51,7 +51,7 @@ static int __init get_cpu_for_node(struct device_node *node)
>>   	return -1;
>>   }
>>   
>> -static int __init parse_core(struct device_node *core, int cluster_id,
>> +static int __init parse_core(struct device_node *core, int physical_id,
>>   			     int core_id)
>>   {
>>   	char name[10];
>> @@ -67,7 +67,7 @@ static int __init parse_core(struct device_node *core, int cluster_id,
>>   			leaf = false;
>>   			cpu = get_cpu_for_node(t);
>>   			if (cpu >= 0) {
>> -				cpu_topology[cpu].cluster_id = cluster_id;
>> +				cpu_topology[cpu].physical_id = physical_id;
>>   				cpu_topology[cpu].core_id = core_id;
>>   				cpu_topology[cpu].thread_id = i;
>>   			} else {
>> @@ -89,7 +89,7 @@ static int __init parse_core(struct device_node *core, int cluster_id,
>>   			return -EINVAL;
>>   		}
>>   
>> -		cpu_topology[cpu].cluster_id = cluster_id;
>> +		cpu_topology[cpu].physical_id = physical_id;
>>   		cpu_topology[cpu].core_id = core_id;
>>   	} else if (leaf) {
>>   		pr_err("%pOF: Can't get CPU for leaf core\n", core);
>> @@ -105,7 +105,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
>>   	bool leaf = true;
>>   	bool has_cores = false;
>>   	struct device_node *c;
>> -	static int cluster_id __initdata;
>> +	static int physical_id __initdata;
>>   	int core_id = 0;
>>   	int i, ret;
>>   
>> @@ -144,7 +144,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
>>   			}
>>   
>>   			if (leaf) {
>> -				ret = parse_core(c, cluster_id, core_id++);
>> +				ret = parse_core(c, physical_id, core_id++);
>>   			} else {
>>   				pr_err("%pOF: Non-leaf cluster with core %s\n",
>>   				       cluster, name);
>> @@ -162,7 +162,7 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
>>   		pr_warn("%pOF: empty cluster\n", cluster);
>>   
>>   	if (leaf)
>> -		cluster_id++;
>> +		physical_id++;
>>   
>>   	return 0;
>>   }
>> @@ -198,7 +198,7 @@ static int __init parse_dt_topology(void)
>>   	 * only mark cores described in the DT as possible.
>>   	 */
>>   	for_each_possible_cpu(cpu)
>> -		if (cpu_topology[cpu].cluster_id == -1)
>> +		if (cpu_topology[cpu].physical_id == -1)
>>   			ret = -EINVAL;
>>   
>>   out_map:
>> @@ -228,7 +228,7 @@ static void update_siblings_masks(unsigned int cpuid)
>>   	for_each_possible_cpu(cpu) {
>>   		cpu_topo = &cpu_topology[cpu];
>>   
>> -		if (cpuid_topo->cluster_id != cpu_topo->cluster_id)
>> +		if (cpuid_topo->physical_id != cpu_topo->physical_id)
>>   			continue;
>>   
>>   		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
>> @@ -249,7 +249,7 @@ void store_cpu_topology(unsigned int cpuid)
>>   	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
>>   	u64 mpidr;
>>   
>> -	if (cpuid_topo->cluster_id != -1)
>> +	if (cpuid_topo->physical_id != -1)
>>   		goto topology_populated;
>>   
>>   	mpidr = read_cpuid_mpidr();
>> @@ -263,19 +263,19 @@ void store_cpu_topology(unsigned int cpuid)
>>   		/* Multiprocessor system : Multi-threads per core */
>>   		cpuid_topo->thread_id  = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>>   		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 1);
>> -		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 2) |
>> +		cpuid_topo->physical_id = MPIDR_AFFINITY_LEVEL(mpidr, 2) |
>>   					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 8;
>>   	} else {
>>   		/* Multiprocessor system : Single-thread per core */
>>   		cpuid_topo->thread_id  = -1;
>>   		cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 0);
>> -		cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 1) |
>> +		cpuid_topo->physical_id = MPIDR_AFFINITY_LEVEL(mpidr, 1) |
>>   					 MPIDR_AFFINITY_LEVEL(mpidr, 2) << 8 |
>>   					 MPIDR_AFFINITY_LEVEL(mpidr, 3) << 16;
>>   	}
>>   
>>   	pr_debug("CPU%u: cluster %d core %d thread %d mpidr %#016llx\n",
>> -		 cpuid, cpuid_topo->cluster_id, cpuid_topo->core_id,
>> +		 cpuid, cpuid_topo->physical_id, cpuid_topo->core_id,
>>   		 cpuid_topo->thread_id, mpidr);
>>   
>>   topology_populated:
>> @@ -291,7 +291,7 @@ static void __init reset_cpu_topology(void)
>>   
>>   		cpu_topo->thread_id = -1;
>>   		cpu_topo->core_id = 0;
>> -		cpu_topo->cluster_id = -1;
>> +		cpu_topo->physical_id = -1;
>>   
>>   		cpumask_clear(&cpu_topo->core_sibling);
>>   		cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
>> @@ -300,6 +300,7 @@ static void __init reset_cpu_topology(void)
>>   	}
>>   }
>>   
>> +
>>   void __init init_cpu_topology(void)
>>   {
>>   	reset_cpu_topology();
>> -- 
>> 2.13.5
>>
