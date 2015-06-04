From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] cpufreq: governor: Serialize governor callbacks
Date: Thu, 04 Jun 2015 16:17:08 +0530
Message-ID: <55702CAC.1060308@linux.vnet.ibm.com>
References: <cover.1433326032.git.viresh.kumar@linaro.org> <ddd3ef47ef3ce88674139f9070650939477881ba.1433326032.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e18.ny.us.ibm.com ([129.33.205.208]:59390 "EHLO
	e18.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbbFDKrY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 06:47:24 -0400
Received: from /spool/local
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Thu, 4 Jun 2015 06:47:23 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id EF3526E8040
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2015 06:39:07 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t54AlKfm52822250
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 10:47:20 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t54AlJoN018012
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2015 06:47:20 -0400
In-Reply-To: <ddd3ef47ef3ce88674139f9070650939477881ba.1433326032.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/03/2015 03:57 PM, Viresh Kumar wrote:
> There are several races reported in cpufreq core around governors (only
> ondemand and conservative) by different people.
> 
> There are at least two race scenarios present in governor code:
>  (a) Concurrent access/updates of governor internal structures.
> 
>  It is possible that fields such as 'dbs_data->usage_count', etc.  are
>  accessed simultaneously for different policies using same governor
>  structure (i.e. CPUFREQ_HAVE_GOVERNOR_PER_POLICY flag unset). And
>  because of this we can dereference bad pointers.
> 
>  For example consider a system with two CPUs with separate 'struct
>  cpufreq_policy' instances. CPU0 governor: ondemand and CPU1: powersave.
>  CPU0 switching to powersave and CPU1 to ondemand:
> 	CPU0				CPU1
> 
> 	store*				store*
> 
> 	cpufreq_governor_exit()		cpufreq_governor_init()
> 					dbs_data = cdata->gdbs_data;
> 
> 	if (!--dbs_data->usage_count)
> 		kfree(dbs_data);
> 
> 					dbs_data->usage_count++;
> 					*Bad pointer dereference*
> 
>  There are other races possible between EXIT and START/STOP/LIMIT as
>  well. Its really complicated.
> 
>  (b) Switching governor state in bad sequence:
> 
>  For example trying to switch a governor to START state, when the
>  governor is in EXIT state. There are some checks present in
>  __cpufreq_governor() but they aren't sufficient as they compare events
>  against 'policy->governor_enabled', where as we need to take governor's
>  state into account, which can be used by multiple policies.
> 
> These two issues need to be solved separately and the responsibility
> should be properly divided between cpufreq and governor core.
> 
> The first problem is more about the governor core, as it needs to
> protect its structures properly. And the second problem should be fixed
> in cpufreq core instead of governor, as its all about sequence of
> events.
> 
> This patch is trying to solve only the first problem.
> 
> There are two types of data we need to protect,
> - 'struct common_dbs_data': No matter what, there is going to be a
>   single copy of this per governor.
> - 'struct dbs_data': With CPUFREQ_HAVE_GOVERNOR_PER_POLICY flag set, we
>   will have per-policy copy of this data, otherwise a single copy.
> 
> Because of such complexities, the mutex present in 'struct dbs_data' is
> insufficient to solve our problem. For example we need to protect
> fetching of 'dbs_data' from different structures at the beginning of
> cpufreq_governor_dbs(), to make sure it isn't currently being updated.
> 
> This can be fixed if we can guarantee serialization of event parsing
> code for an individual governor. This is best solved with a mutex per
> governor, and the placeholder for that is 'struct common_dbs_data'.
> 
> And so this patch moves the mutex from 'struct dbs_data' to 'struct
> common_dbs_data' and takes it at the beginning and drops it at the end
> of cpufreq_governor_dbs().
> 
> Tested with and without following configuration options:
> 
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_PI_LIST=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_PROVE_LOCKING=y
> CONFIG_LOCKDEP=y
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

