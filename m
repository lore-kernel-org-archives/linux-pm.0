From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH 07/16 v3] Init Workload Consolidation flags in sched_domain
Date: Mon, 09 Jun 2014 18:56:17 +0100
Message-ID: <5395F541.60604@arm.com>
References: <1401431772-14320-1-git-send-email-yuyang.du@intel.com> <1401431772-14320-8-git-send-email-yuyang.du@intel.com> <20140603121416.GH30445@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:39282 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbaFIR4P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jun 2014 13:56:15 -0400
In-Reply-To: <20140603121416.GH30445@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Yuyang Du <yuyang.du@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

... turned out that probably the cc list was too big for lkml. Dropping
all the individual email addresses on CC.

... it seems that this message hasn't made it to the list. Apologies to
everyone on To: and Cc: receiving it again.

On 03/06/14 13:14, Peter Zijlstra wrote:
> On Fri, May 30, 2014 at 02:36:03PM +0800, Yuyang Du wrote:
>> Workload Consolidation can be enabled/disabled on the fly. This patchset
>> enables MC and CPU domain WC by default.
>>
>> To enable CPU WC (SD_WORKLOAD_CONSOLIDATION=0x8000):
>>
>> sysctl -w kernel.sched_domain.cpuX.domainY.flags += 0x8000
>>
>> To disable CPU WC:
>>
>> sysctl -w kernel.sched_domain.cpuX.domainY.flags -= 0x8000
>>
>> Signed-off-by: Yuyang Du <yuyang.du@intel.com>
>> ---
>>  include/linux/topology.h |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/topology.h b/include/linux/topology.h
>> index 7062330..ebc339c3 100644
>> --- a/include/linux/topology.h
>> +++ b/include/linux/topology.h
>> @@ -102,12 +102,14 @@ int arch_update_cpu_topology(void);
>>  				| 0*SD_SERIALIZE			\
>>  				| 0*SD_PREFER_SIBLING			\
>>  				| arch_sd_sibling_asym_packing()	\
>> +				| 0*SD_WORKLOAD_CONSOLIDATION	\
>>  				,					\
>>  	.last_balance		= jiffies,				\
>>  	.balance_interval	= 1,					\
>>  	.smt_gain		= 1178,	/* 15% */			\
>>  	.max_newidle_lb_cost	= 0,					\
>>  	.next_decay_max_lb_cost	= jiffies,				\
>> +	.consolidating_coeff = 0,					\
>>  }
>>  #endif
>>  #endif /* CONFIG_SCHED_SMT */
>> @@ -134,11 +136,13 @@ int arch_update_cpu_topology(void);
>>  				| 0*SD_SHARE_CPUPOWER			\
>>  				| 1*SD_SHARE_PKG_RESOURCES		\
>>  				| 0*SD_SERIALIZE			\
>> +				| 1*SD_WORKLOAD_CONSOLIDATION	\
>>  				,					\
>>  	.last_balance		= jiffies,				\
>>  	.balance_interval	= 1,					\
>>  	.max_newidle_lb_cost	= 0,					\
>>  	.next_decay_max_lb_cost	= jiffies,				\
>> +	.consolidating_coeff = 180,					\
>>  }
>>  #endif
>>  #endif /* CONFIG_SCHED_MC */
>> @@ -167,11 +171,13 @@ int arch_update_cpu_topology(void);
>>  				| 0*SD_SHARE_PKG_RESOURCES		\
>>  				| 0*SD_SERIALIZE			\
>>  				| 1*SD_PREFER_SIBLING			\
>> +				| 1*SD_WORKLOAD_CONSOLIDATION	\
>>  				,					\
>>  	.last_balance		= jiffies,				\
>>  	.balance_interval	= 1,					\
>>  	.max_newidle_lb_cost	= 0,					\
>>  	.next_decay_max_lb_cost	= jiffies,				\
>> +	.consolidating_coeff = 180,					\
>>  }
>>  #endif
> 
> What tree are you working against, non of that exists anymore. Also, you
> cannot unconditionally set this.
> 

Hi Yuyang,

I'm running these patches on my ARM TC2 on top of
kernel/git/torvalds/linux.git (v3.15-rc7-79-gfe45736f4134). There're
considerable changes in the area of sched domain setup since Vincent's
patchset 'rework sched_domain topology description' (destined for v3.16)
which you can find on kernel/git/tip/tip.git .

Why did you make SD_WORKLOAD_CONSOLIDATION controllable via sysctl? All
the other SD flags are set during setup. Your top_flag_domain() function
takes care of figuring out what is the highest sd level this is set on
during load-balance but I can't find any good reason to do it this way
other then for testing purposes?

Setting SD_WORKLOAD_CONSOLIDATION  (which is probably a behavioural flag
rather than a topology description related one) on a certain sd level
requires you to also think about its implications in sd_init() and in sd
degenerate functionality.

-- Dietmar



