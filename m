From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] cpufreq: governor: Fix potential races
Date: Thu, 04 Jun 2015 12:06:49 +0530
Message-ID: <556FF201.8080100@linux.vnet.ibm.com>
References: <cover.1433326032.git.viresh.kumar@linaro.org> <556FDEA8.6090801@linux.vnet.ibm.com> <556FEB4B.1010601@linux.vnet.ibm.com> <20150604061128.GF11325@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e19.ny.us.ibm.com ([129.33.205.209]:59841 "EHLO
	e19.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbbFDGhI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 02:37:08 -0400
Received: from /spool/local
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 02:37:07 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 13EC36E8040
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2015 02:28:52 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t546b4Se57868416
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 06:37:04 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t546b3OW020617
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 02:37:04 -0400
In-Reply-To: <20150604061128.GF11325@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/04/2015 11:41 AM, Viresh Kumar wrote:
> On 04-06-15, 11:38, Preeti U Murthy wrote:
>> And a crash at the cpufreq worker thread again due to data access
>> exception when I change governors in parallel on a single core.
>>
>> cpu 0x3: Vector: 300 (Data Access) at [c000000fedb538f0]
>>     pc: c000000000856750: od_dbs_timer+0x60/0x1e0
>>     lr: c0000000000f489c: process_one_work+0x24c/0x910
>>     sp: c000000fedb53b70
>>    msr: 9000000100009033
>>    dar: 10
>>  dsisr: 40000000
>>   current = 0xc000000fe3d128e0
>>   paca    = 0xc000000007da1c80	 softe: 0	 irq_happened: 0x01
>>     pid   = 17227, comm = kworker/3:1
>>
>> With the backtrace being:
>>
>> [c000000fedb53be0] c0000000000f489c process_one_work+0x24c/0x910
>> [c000000fedb53c90] c0000000000f50dc worker_thread+0x17c/0x540
>> [c000000fedb53d20] c0000000000fed70 kthread+0x120/0x140
>> [c000000fedb53e30] c000000000009678 ret_from_kernel_thread+0x5c/0x64
>>
>> But the kernel stays sane longer than before with the patchset. The
>> above crash happens around 15 seconds after the test begins, while
>> earlier it wouldn't survive 2 seconds even.
> 
> I haven't attempted to solve the race between the worker threads and
> governor-callbacks yet. What I have tried to solve is the race between
> different callbacks. And you shouldn't see a race there for now. For
> example a race between INIT/EXIT/START/STOP/LIMITS.

Your fix may not be complete and here is why. The reason we see the crash
is because we have *only* attempted to serialize calls to cpufreq_governor_dbs()
and not attempted to serialize *entire logical sequence of operations*. Let's
take a look at what is happening as a consequence.

CPU0                                          CPU1
store_scaling_governor()                   __cpufreq_remove_dev_finish()
 __cpufreq_governor(CPUFREQ_GOV_STOP)       __cpufreq_governor(CPUFREQ_GOV_START)
   policy->governor_enabled = false                    
   cpufreq_governor_dbs()                     policy->governor_enabled = true
    mutex_lock()
     gov_cancel_work()                        cpufreq_governor_dbs()
                                               wait on lock

      may call gov_queue_work()
       if (!policy->enabled) : fails
         and we end up queuing work

    mutex_unlock()                              
                                              mutex_lock()
                                              gov_queue_work()
                                              mutex_unlock()
 
__cpufreq_governor(CPUFREQ_GOV_POLICY_EXIT)
  mutex_lock()
    cpufreq_governor_dbs()
        kfree(dbs_data)
                                           
                                               timer fires and od_dbs_timer/cs_dbs_timer() runs
                                               References governor data structures which are freed                                          

The issue as I see it is one set of operations must be allowed to run *completely* 
before another begins. When store_scaling_governor() says STOP, all governor operations
must be stopped, till the time store_scaling_governor() itself gives permission
to restart. Somebody else, in this case __cpufreq_remove_dev_finish() cannot overrule
this if it arrives late. This is what is happening above.

So if store_scaling_governor() arrives first, STOP|EXIT|START|LIMIT must complete before
START|LIMIT of __cpufreq_remove_dev_finish() is allowed to run. So it is just not about
serializing, its about *what needs to be serialized*.

Regards
Preeti U Murthy
                                       
> 

