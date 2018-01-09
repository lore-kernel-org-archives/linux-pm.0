From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] drivers: psci: remove cluster terminology and
 dependency on physical_package_id
Date: Tue, 9 Jan 2018 18:42:04 +0000
Message-ID: <308ce839-5427-0f75-9c99-d40dcb9340c5@arm.com>
References: <1515516568-31359-1-git-send-email-sudeep.holla@arm.com>
 <1515516568-31359-2-git-send-email-sudeep.holla@arm.com>
 <20180109173451.GB17222@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751493AbeAISmR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jan 2018 13:42:17 -0500
In-Reply-To: <20180109173451.GB17222@red-moon>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Mark Rutland <mark.rutland@arm.com>

Hi Lorenzo,

On 09/01/18 17:34, Lorenzo Pieralisi wrote:
> On Tue, Jan 09, 2018 at 04:49:27PM +0000, Sudeep Holla wrote:
>> Since the definition of the term "cluster" is not well defined in the
>> architecture, we should avoid using it. Also the physical package id
>> is currently mapped to so called "clusters" in ARM/ARM64 platforms which
>> is already argumentative.
> 
> I think we should describe why the PSCI checker uses the physical
> package id (ie because it is likely that power domains map to "clusters"
> - so physical package id *current* boundaries, it is trying to test
> "cluster" idle states) but I can easily rework the log before sending it
> upstream.
> 

I agree. If I need to resend 2/2 based on review I will update the log
accordingly with acked-by tag. Otherwise, you can pick it up and update
the log.

> I will send it upstream for the next cycle along with patch (2), or
> if you prefer to send it yourself:
> 
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Thanks for putting it together,
> Lorenzo
> 
>> This patch removes the dependency on physical_package_id from the topology
>> in this PSCI checker. Also it replaces all the occurences of clusters to
>> cpu_groups which is derived from core_sibling_mask and may not directly
>> map to physical "cluster".
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/firmware/psci_checker.c | 46 ++++++++++++++++++++---------------------
>>  1 file changed, 22 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/firmware/psci_checker.c b/drivers/firmware/psci_checker.c
>> index f3f4f810e5df..bb1c068bff19 100644
>> --- a/drivers/firmware/psci_checker.c
>> +++ b/drivers/firmware/psci_checker.c
>> @@ -77,8 +77,8 @@ static int psci_ops_check(void)
>>  	return 0;
>>  }
>>  
>> -static int find_clusters(const struct cpumask *cpus,
>> -			 const struct cpumask **clusters)
>> +static int find_cpu_groups(const struct cpumask *cpus,
>> +			   const struct cpumask **cpu_groups)
>>  {
>>  	unsigned int nb = 0;
>>  	cpumask_var_t tmp;
>> @@ -88,11 +88,11 @@ static int find_clusters(const struct cpumask *cpus,
>>  	cpumask_copy(tmp, cpus);
>>  
>>  	while (!cpumask_empty(tmp)) {
>> -		const struct cpumask *cluster =
>> +		const struct cpumask *cpu_group =
>>  			topology_core_cpumask(cpumask_any(tmp));
>>  
>> -		clusters[nb++] = cluster;
>> -		cpumask_andnot(tmp, tmp, cluster);
>> +		cpu_groups[nb++] = cpu_group;
>> +		cpumask_andnot(tmp, tmp, cpu_group);
>>  	}
>>  
>>  	free_cpumask_var(tmp);
>> @@ -170,24 +170,24 @@ static int hotplug_tests(void)
>>  {
>>  	int err;
>>  	cpumask_var_t offlined_cpus;
>> -	int i, nb_cluster;
>> -	const struct cpumask **clusters;
>> +	int i, nb_cpu_group;
>> +	const struct cpumask **cpu_groups;
>>  	char *page_buf;
>>  
>>  	err = -ENOMEM;
>>  	if (!alloc_cpumask_var(&offlined_cpus, GFP_KERNEL))
>>  		return err;
>> -	/* We may have up to nb_available_cpus clusters. */
>> -	clusters = kmalloc_array(nb_available_cpus, sizeof(*clusters),
>> -				 GFP_KERNEL);
>> -	if (!clusters)
>> +	/* We may have up to nb_available_cpus cpu_groups. */
>> +	cpu_groups = kmalloc_array(nb_available_cpus, sizeof(*cpu_groups),
>> +				   GFP_KERNEL);
>> +	if (!cpu_groups)
>>  		goto out_free_cpus;
>>  	page_buf = (char *)__get_free_page(GFP_KERNEL);
>>  	if (!page_buf)
>> -		goto out_free_clusters;
>> +		goto out_free_cpu_groups;
>>  
>>  	err = 0;
>> -	nb_cluster = find_clusters(cpu_online_mask, clusters);
>> +	nb_cpu_group = find_cpu_groups(cpu_online_mask, cpu_groups);
>>  
>>  	/*
>>  	 * Of course the last CPU cannot be powered down and cpu_down() should
>> @@ -197,24 +197,22 @@ static int hotplug_tests(void)
>>  	err += down_and_up_cpus(cpu_online_mask, offlined_cpus);
>>  
>>  	/*
>> -	 * Take down CPUs by cluster this time. When the last CPU is turned
>> -	 * off, the cluster itself should shut down.
>> +	 * Take down CPUs by cpu group this time. When the last CPU is turned
>> +	 * off, the cpu group itself should shut down.
>>  	 */
>> -	for (i = 0; i < nb_cluster; ++i) {
>> -		int cluster_id =
>> -			topology_physical_package_id(cpumask_any(clusters[i]));
>> +	for (i = 0; i < nb_cpu_group; ++i) {
>>  		ssize_t len = cpumap_print_to_pagebuf(true, page_buf,
>> -						      clusters[i]);
>> +						      cpu_groups[i]);
>>  		/* Remove trailing newline. */
>>  		page_buf[len - 1] = '\0';
>> -		pr_info("Trying to turn off and on again cluster %d "
>> -			"(CPUs %s)\n", cluster_id, page_buf);
>> -		err += down_and_up_cpus(clusters[i], offlined_cpus);
>> +		pr_info("Trying to turn off and on again group %d (CPUs %s)\n",
>> +			i, page_buf);
>> +		err += down_and_up_cpus(cpu_groups[i], offlined_cpus);
>>  	}
>>  
>>  	free_page((unsigned long)page_buf);
>> -out_free_clusters:
>> -	kfree(clusters);
>> +out_free_cpu_groups:
>> +	kfree(cpu_groups);
>>  out_free_cpus:
>>  	free_cpumask_var(offlined_cpus);
>>  	return err;
>> -- 
>> 2.7.4
>>

-- 
Regards,
Sudeep

-- 
Regards,
Sudeep
