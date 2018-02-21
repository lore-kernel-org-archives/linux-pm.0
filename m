From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] cpufreq: powernv: Check negative value returned by
 cpufreq_table_find_index_dl()
Date: Wed, 21 Feb 2018 16:39:54 +1100
Message-ID: <874lmasxxx.fsf@concordia.ellerman.id.au>
References: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180212102900.GU28462@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20180212102900.GU28462@vireshk-i7>
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
To: Viresh Kumar <viresh.kumar@linaro.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 12-02-18, 15:51, Shilpasri G Bhat wrote:
>> This patch fixes the below Coverity warning:
>> 
>> *** CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
>> /drivers/cpufreq/powernv-cpufreq.c: 1008 in powernv_fast_switch()
>> 1002     					unsigned int target_freq)
>> 1003     {
>> 1004     	int index;
>> 1005     	struct powernv_smp_call_data freq_data;
>> 1006
>> 1007     	index = cpufreq_table_find_index_dl(policy, target_freq);
>> >>>     CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
>> >>>     Using variable "index" as an index to array "powernv_freqs".
>> 1008     	freq_data.pstate_id = powernv_freqs[index].driver_data;
>> 1009     	freq_data.gpstate_id = powernv_freqs[index].driver_data;
>> 1010     	set_pstate(&freq_data);
>> 1011
>> 1012     	return powernv_freqs[index].frequency;
>> 1013     }
>> 
>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> ---
>>  drivers/cpufreq/powernv-cpufreq.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index 29cdec1..69edfe9 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -1005,6 +1005,9 @@ static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
>>  	struct powernv_smp_call_data freq_data;
>>  
>>  	index = cpufreq_table_find_index_dl(policy, target_freq);
>> +	if (unlikely(index < 0))
>> +		index = get_nominal_index();
>> +
>
> AFAICT, you will get -1 here only if the freq table had no valid
> frequencies (or the freq table is empty). Why would that happen ?

Bugs?

Or if you ask for a target_freq that is higher than anything in the
table.

Or the API changes, and we forget to update this call site.

If you're saying that cpufreq_table_find_index_dl() can NEVER fail, then
write it so that it can never fail and change it to return unsigned int.

Having it potentially return -1, which is then used to index an array
and not handling that is just asking for bugs to happen.

cheers
