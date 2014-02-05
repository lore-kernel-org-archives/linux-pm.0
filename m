From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] cpuidle/governors: Fix logic in selection of idle
 states
Date: Wed, 05 Feb 2014 09:30:51 +0530
Message-ID: <52F1B773.6050901@linux.vnet.ibm.com>
References: <20140204083531.24802.63370.stgit@preeti.in.ibm.com> <52F0FE9F.501@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52F0FE9F.501@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, len.brown@intel.com, benh@kernel.crashing.org, daniel.lezcano@linaro.org, srivatsa.bhat@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

Hi Arjan,

On 02/04/2014 08:22 PM, Arjan van de Ven wrote:
> On 2/4/2014 12:35 AM, Preeti U Murthy wrote:
>> The cpuidle governors today are not handling scenarios where no idle
>> state
>> can be chosen. Such scenarios coud arise if the user has disabled all the
>> idle states at runtime or the latency requirement from the cpus is
>> very strict.
>>
>> The menu governor returns 0th index of the idle state table when no other
>> idle state is suitable. This is even when the idle state corresponding
>> to this
>> index is disabled or the latency requirement is strict and the
>> exit_latency
>> of the lowest idle state is also not acceptable. Hence this patch
>> fixes this logic in the menu governor by defaulting to an idle state
>> index
>>  of -1 unless any other state is suitable.
> 
> state 0 is defined as polling, and polling ALWAYS should be ok

Hmm.. you are right. This is convincing. There is no need for this patch.

Thanks

Regards
Preeti U Murthy
> 
