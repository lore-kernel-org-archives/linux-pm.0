From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] cpufreq: powernv: Adding fast_switch for schedutil
Date: Mon, 7 Nov 2016 13:02:04 +0530
Message-ID: <d2bbacea-3401-01ab-0933-f9ed628df502@linux.vnet.ibm.com>
References: <1478237255-4258-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20161104063322.GA3414@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20161104063322.GA3414@vireshk-i7>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Thanks Viresh for taking a look at it.

I will make the mentioned changes in the next version of the patch.


Regards

Akshay Adiga


On 11/04/2016 12:03 PM, Viresh Kumar wrote:
> On 04-11-16, 10:57, Akshay Adiga wrote:
>> Adding fast_switch which does light weight operation to
>> set the desired pstate.
>>
>> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
>> ---
>>   drivers/cpufreq/powernv-cpufreq.c | 22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index d3ffde8..09a0496 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -752,9 +752,12 @@ static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>   	spin_lock_init(&gpstates->gpstate_lock);
>>   	ret = cpufreq_table_validate_and_show(policy, powernv_freqs);
>>   
>> -	if (ret < 0)
>> +	if (ret < 0) {
>>   		kfree(policy->driver_data);
>> +		return ret;
>> +	}
>>   
>> +	policy->fast_switch_possible = true;
>>   	return ret;
>>   }
>>   
>> @@ -897,6 +900,22 @@ static void powernv_cpufreq_stop_cpu(struct cpufreq_policy *policy)
>>   	del_timer_sync(&gpstates->timer);
>>   }
>>   
>> +static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
>> +					unsigned int target_freq)
>> +{
>> +	int index;
>> +	struct powernv_smp_call_data freq_data;
>> +
>> +	index = cpufreq_table_find_index_dl(policy, target_freq);
>> +	if (index < 0 || index >= powernv_pstate_info.nr_pstates)
>> +		return CPUFREQ_ENTRY_INVALID;
> I don't think such a check is required at all. It wouldn't happen without a BUG
> in kernel.
>> +	freq_data.pstate_id = powernv_freqs[index].driver_data;
>> +	freq_data.gpstate_id = powernv_freqs[index].driver_data;
>> +	set_pstate(&freq_data);
>> +
>> +	return powernv_freqs[index].frequency;
>> +}
>> +
>>   static struct cpufreq_driver powernv_cpufreq_driver = {
>>   	.name		= "powernv-cpufreq",
>>   	.flags		= CPUFREQ_CONST_LOOPS,
>> @@ -904,6 +923,7 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
>>   	.exit		= powernv_cpufreq_cpu_exit,
>>   	.verify		= cpufreq_generic_frequency_table_verify,
>>   	.target_index	= powernv_cpufreq_target_index,
>> +	.fast_switch	= powernv_fast_switch,
>>   	.get		= powernv_cpufreq_get,
>>   	.stop_cpu	= powernv_cpufreq_stop_cpu,
>>   	.attr		= powernv_cpu_freq_attr,
>> -- 
>> 2.7.4
