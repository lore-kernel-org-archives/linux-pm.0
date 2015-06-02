From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] cpufreq/hotplug: Fix cpu-hotplug cpufreq race conditions
Date: Tue, 02 Jun 2015 11:01:22 +0530
Message-ID: <556D3FAA.3080703@linux.vnet.ibm.com>
References: <20150601064031.2972.59208.stgit@perfhull-ltc.austin.ibm.com> <20150601071934.GC4242@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:51251 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbbFBFb3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2015 01:31:29 -0400
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 1 Jun 2015 23:31:28 -0600
In-Reply-To: <20150601071934.GC4242@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, ego@linux.vnet.ibm.com, paulus@samba.org, linux-kernel@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org

On 06/01/2015 12:49 PM, Viresh Kumar wrote:
> On 01-06-15, 01:40, Preeti U Murthy wrote:
> 
> I have to mention that this is somewhat inspired by:
> 
> https://git.linaro.org/people/viresh.kumar/linux.git/commit/1e37f1d6ae12f5896e4e216f986762c3050129a5
> 
> and I was waiting to finish some core-changes to make all this simple.
> 
> I am fine to you trying to finish it though :)
> 
>> The problem showed up when running hotplug operations and changing
>> governors in parallel. The crash would be at:
>>
>> [  174.319645] Unable to handle kernel paging request for data at address 0x00000000
>> [  174.319782] Faulting instruction address: 0xc00000000053b3e0
>> cpu 0x1: Vector: 300 (Data Access) at [c000000003fdb870]
>>     pc: c00000000053b3e0: __bitmap_weight+0x70/0x100
>>     lr: c00000000085a338: need_load_eval+0x38/0xf0
>>     sp: c000000003fdbaf0
>>    msr: 9000000100009033
>>    dar: 0
>>  dsisr: 40000000
>>   current = 0xc000000003151a40
>>   paca    = 0xc000000007da0980	 softe: 0	 irq_happened: 0x01
>>     pid   = 842, comm = kworker/1:2
>> enter ? for help
>> [c000000003fdbb40] c00000000085a338 need_load_eval+0x38/0xf0
>> [c000000003fdbb70] c000000000856a10 od_dbs_timer+0x90/0x1e0
>> [c000000003fdbbe0] c0000000000f489c process_one_work+0x24c/0x910
>> [c000000003fdbc90] c0000000000f50dc worker_thread+0x17c/0x540
>> [c000000003fdbd20] c0000000000fed70 kthread+0x120/0x140
>> [c000000003fdbe30] c000000000009678 ret_from_kernel_thread+0x5c/0x64
>>
>> While debugging the issue, other problems in this area were uncovered,
>> all of them necessitating serialized calls to __cpufreq_governor().  One
>> potential race condition that can happen today is the below:
>>
>> CPU0					CPU1
>>
>> cpufreq_set_policy()
>>
>> __cpufreq_governor
>> (CPUFREQ_GOV_POLICY_EXIT)
>> 				__cpufreq_remove_dev_finish()
>>
>> free(dbs_data)			__cpufreq_governor
>> 				(CPUFRQ_GOV_START)
>>
>> 				dbs_data->mutex <= NULL dereference
>>
>> The issue here is that calls to cpufreq_governor_dbs() is not serialized
>> and they can conflict with each other in numerous ways. One way to sort
>> this out would be to serialize all calls to cpufreq_governor_dbs()
>> by setting the governor busy if a call is in progress and
>> blocking all other calls. But this approach will not cover all loop
>> holes. Take the above scenario: CPU1 will still hit a NULL dereference if
>> care is not taken to check for a NULL dbs_data.
>>
>> To sort such scenarios, we could filter out the sequence of events: A
>> CPUFREQ_GOV_START cannot be called without an INIT, if the previous
>> event was an EXIT. However this results in analysing all possible
>> sequence of events and adding each of them as a filter. This results in
>> unmanagable code. There is high probability of missing out on a race
>> condition. Both the above approaches were tried out earlier [1]
> 
> I agree.
> 
>> Let us therefore look at the heart of the issue.
> 
> Yeah, we should :)
> 
>> It is not really about
>> serializing calls to cpufreq_governor_dbs(), it seems to be about
>> serializing entire sequence of CPUFREQ_GOV* operations. For instance, in
>> cpufreq_set_policy(), we STOP,EXIT the old policy and INIT and START the
>> new policy. Between the EXIT and INIT, there must not be
>> anybody else starting the policy. And between INIT and START, there must
>> be nobody stopping the policy.
> 
> Hmm..
> 
>> A similar argument holds for the CPUFREQ_GOV* operations in
>>  __cpufreq_policy_dev_{prepare|finish} and cpufreq_add_policy(). Hence
>> until each of these functions complete in totality, none of the others
>> should run in parallel. The interleaving of the individual calls to
>> cpufreq_governor_dbs() is resulting in invalid operations. This patch
>> therefore tries to serialize entire cpufreq functions calling CPUFREQ_GOV*
>> operations, with respect to each other.
> 
> We were forced to put band-aids until this time and I am really
> looking into getting this fixed at the root.
> 
> The problem is that we drop policy locks before calling
> __cpufreq_governor() and that's the root cause of all these problems
> we are facing. We did that because we were getting warnings about
> circular locks (955ef4833574 ("cpufreq: Drop rwsem lock around
> CPUFREQ_GOV_POLICY_EXIT"))..
> 
> I have explained that problem here (Never sent this upstream, as I was
> waiting for some other patches to get included first):
> https://git.linaro.org/people/viresh.kumar/linux.git/commit/57714d5b1778f2f610bcc5c74d85b29ba1cc1995
> 
> The actual problem was:
> If we hold any locks, that the attribute operations grab, when
> removing the attribute, then it can result in a ABBA deadlock.
> 
> show()/store() holds the policy->rwsem lock while accessing any sysfs
> attributes under cpu/cpuX/cpufreq/ directory.
> 
> But something like what I have done is the real way to tackle all
> these problems.

How will a policy lock help here at all, when cpus from multiple
policies are calling into __cpufreq_governor() ? How will a policy lock
serialize their entry into cpufreq_governor_dbs() ?

> 
> These band-aid wouldn't take us anywhere.

Why do you say that the approach mentioned in this patch is a bandaid ?
The patch ensures that there are no interruptions in a logical sequence
of calls into cpufreq_governor_dbs(), as it should be.

Regards
Preeti U Murthy
> 

