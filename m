From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] cpufreq: governor: Fix potential races
Date: Thu, 04 Jun 2015 11:38:11 +0530
Message-ID: <556FEB4B.1010601@linux.vnet.ibm.com>
References: <cover.1433326032.git.viresh.kumar@linaro.org> <556FDEA8.6090801@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:36645 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbbFDGIn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 02:08:43 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 00:08:43 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 9AD87C90043
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2015 01:59:47 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5468eOv59113696
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 06:08:40 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5468cL4007592
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 02:08:39 -0400
In-Reply-To: <556FDEA8.6090801@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/04/2015 10:44 AM, Preeti U Murthy wrote:
> On 06/03/2015 03:57 PM, Viresh Kumar wrote:
>> Hi Rafael,
>>
>> Preeti recently highlighted [1] some issues in cpufreq core locking with
>> respect to governors. I wanted to solve them after we have simplified
>> the hotplug paths in cpufreq core with my latest patches, but now that
>> she has poked me, I have done some work in that area.
>>
>> I am trying to solve only a part of the bigger problem (in a way that I
>> feel is the right way ahead). The first patches restructures code to
>> make it more readable and the last patch does all the major changes. The
>> logs in that one should be good enough to explain why and what I am
>> doing.
>>
>> The first two shouldn't bring any functional change and so can be
>> applied early if you are confident about them.
>>
>> @Preeti: I would like you to test these patches. These should get rid of
>> the crashes you were facing but may generate a WARN() from line 447 of
>> cpufreq_governor.c, if the sequence is wrong. That has to be fixed
>> separately.
>>
>> Line 447: WARN_ON(!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT))
>>
>> Rebased over: v4.1-rc6
>> Tested-on: ARM dual Cortex -A15 Exynos board.
>>
>> [1] http://marc.info/?i=20150601064031.2972.59208.stgit%40perfhull-ltc.austin.ibm.com
>>
>> Viresh Kumar (3):
>>   cpufreq: governor: register notifier from cs_init()
>>   cpufreq: governor: split cpufreq_governor_dbs()
>>   cpufreq: governor: Serialize governor callbacks
>>
>>  drivers/cpufreq/cpufreq_conservative.c |  28 +--
>>  drivers/cpufreq/cpufreq_governor.c     | 340 ++++++++++++++++++---------------
>>  drivers/cpufreq/cpufreq_governor.h     |  16 +-
>>  drivers/cpufreq/cpufreq_ondemand.c     |   6 +-
>>  4 files changed, 209 insertions(+), 181 deletions(-)
>>
> 
> I did a hotplug test on a single core alongside changing governors
> between ondemand and conservative on the same core. The policy is per
> core on powerpc. Within a second of that run the kernel panics. The
> backtrace is below:
> 
> [  165.981836] Unable to handle kernel paging request for data at
> address 0x00000000
> [  165.981929] Faulting instruction address: 0xc00000000053b3e0
> cpu 0x4: Vector: 300 (Data Access) at [c000000fe0b2b880]
>     pc: c00000000053b3e0: __bitmap_weight+0x70/0x100
>     lr: c00000000085a008: need_load_eval+0x38/0xf0
>     sp: c000000fe0b2bb00
>    msr: 9000000100009033
>    dar: 0
>  dsisr: 40000000
>   current = 0xc000000003e4fc90
>   paca    = 0xc000000007da2600	 softe: 0	 irq_happened: 0x01
>     pid   = 812, comm = kworker/4:2
> enter ? for help
> [c000000fe0b2bb50] c00000000085a008 need_load_eval+0x38/0xf0
> [c000000fe0b2bb80] c00000000085815c cs_dbs_timer+0xdc/0x150
> [c000000fe0b2bbe0] c0000000000f489c process_one_work+0x24c/0x910
> [c000000fe0b2bc90] c0000000000f50dc worker_thread+0x17c/0x540
> [c000000fe0b2bd20] c0000000000fed70 kthread+0x120/0x140
> [c000000fe0b2be30] c000000000009678 ret_from_kernel_thread+0x5c/0x64
> 
> The crash is the same as was reported at
> http://www.gossamer-threads.com/lists/linux/kernel/2186336.
> 
> Regards
> Preeti U Murthy

And a crash at the cpufreq worker thread again due to data access
exception when I change governors in parallel on a single core.

cpu 0x3: Vector: 300 (Data Access) at [c000000fedb538f0]
    pc: c000000000856750: od_dbs_timer+0x60/0x1e0
    lr: c0000000000f489c: process_one_work+0x24c/0x910
    sp: c000000fedb53b70
   msr: 9000000100009033
   dar: 10
 dsisr: 40000000
  current = 0xc000000fe3d128e0
  paca    = 0xc000000007da1c80	 softe: 0	 irq_happened: 0x01
    pid   = 17227, comm = kworker/3:1

With the backtrace being:

[c000000fedb53be0] c0000000000f489c process_one_work+0x24c/0x910
[c000000fedb53c90] c0000000000f50dc worker_thread+0x17c/0x540
[c000000fedb53d20] c0000000000fed70 kthread+0x120/0x140
[c000000fedb53e30] c000000000009678 ret_from_kernel_thread+0x5c/0x64

But the kernel stays sane longer than before with the patchset. The
above crash happens around 15 seconds after the test begins, while
earlier it wouldn't survive 2 seconds even.

Regards
Preeti U Murthy
> 

