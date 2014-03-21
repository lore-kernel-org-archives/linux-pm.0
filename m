From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
Date: Fri, 21 Mar 2014 17:10:11 +0530
Message-ID: <532C251B.1020306@linux.vnet.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com> <1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com> <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com> <20140321104317.GA2493@in.ibm.com> <CAKohpo=JqHOPF_pdcAsvRgc1vENmS=Sg9pS8ZXPGhfMFnA8ZUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:54746 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbaCULkh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 07:40:37 -0400
Received: from /spool/local
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 21 Mar 2014 21:40:35 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id F1B6A2BB0054
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 22:40:32 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2LBKJgR59244740
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 22:20:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2LBeVwv009636
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 22:40:32 +1100
In-Reply-To: <CAKohpo=JqHOPF_pdcAsvRgc1vENmS=Sg9pS8ZXPGhfMFnA8ZUA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, Linux PM list <linux-pm@vger.kernel.org>, linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>

On 03/21/2014 04:24 PM, Viresh Kumar wrote:
> On 21 March 2014 16:13, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
>> On Fri, Mar 21, 2014 at 02:11:32PM +0530, Viresh Kumar wrote:
> 
>>>> +               pr_debug("PState id %d freq %d MHz\n", id, freq);
>>>> +               powernv_freqs[i].driver_data = i;
>>>
[...] 
>>>> +static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>>> +{
>>>> +       int base, i;
>>>> +
>>>> +#ifdef CONFIG_SMP
>>>
>>> What will break if you don't have this ifdef here? Without that as well
>>> below code should work?
> 
> Missed this one?
> 

Nothing will break, its just that the code size will be a tiny bit
lesser on UP configs, that's all :-) Anyway, I think removing the ifdef
improves the readability (and doesn't add any noticeable overhead on UP
kernels), so let's get rid of it.

Regards,
Srivatsa S. Bhat

>>>> +       base = cpu_first_thread_sibling(policy->cpu);
>>>> +
>>>> +       for (i = 0; i < threads_per_core; i++)
>>>> +               cpumask_set_cpu(base + i, policy->cpus);
>>>> +#endif
>>>> +       policy->cpuinfo.transition_latency = 25000;
>>>> +
>>>> +       policy->cur = powernv_freqs[0].frequency;
>>>> +       cpufreq_frequency_table_get_attr(powernv_freqs, policy->cpu);
>>>

