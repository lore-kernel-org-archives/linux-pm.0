From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
Date: Thu, 27 Mar 2014 15:51:28 +0530
Message-ID: <5333FBA8.1040107@linux.vnet.ibm.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com> <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com> <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com> <20140327093050.GA27777@in.ibm.com> <CAKohponOe9Au+pe5u9FpddW3+f5pegZB953+5fmYBDusE9j0HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:56401 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849AbaC0KVw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Mar 2014 06:21:52 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 27 Mar 2014 15:51:50 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id B5ABD3940048
	for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 15:51:48 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2RALUWd48431118
	for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 15:51:31 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2RALjMh025470
	for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 15:51:45 +0530
In-Reply-To: <CAKohponOe9Au+pe5u9FpddW3+f5pegZB953+5fmYBDusE9j0HA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

On 03/27/2014 03:29 PM, Viresh Kumar wrote:
> On 27 March 2014 15:00, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
>> As of now, I prefer this patch be based on code that is in the -next
>> tree. I'll get rid of the per-core locking once the serialization
>> patch of the core is accepted.
> 
[...] 
>>>> +       pr_debug("cpu %d pmsr %lx pstate_id %d frequency %d kHz \n",
>>>> +               smp_processor_id(), pmspr_val, freq_data->pstate_id,
>>>
>>> s/smp_processor_id/raw_smp_processor_id ?
>>
>> No. This function is called via smp_call_function(). So we have
>> preempt_disable on and it is safe to use smp_processor_id.
> 
> My question wasn't about being safe, but avoiding the complexity
> of debug_smp_processor_id(). raw_smp_processor_id() can execute
> very quickly.
> 

smp_processor_id() maps to debug_smp_processor_id() only if
CONFIG_DEBUG_PREEMPT is set. Otherwise, it is same as raw_smp_processor_id().
So I think its best to keep it as it is.

Regards,
Srivatsa S. Bhat

