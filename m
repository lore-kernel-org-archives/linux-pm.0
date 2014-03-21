From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
Date: Fri, 21 Mar 2014 16:24:27 +0530
Message-ID: <CAKohpo=JqHOPF_pdcAsvRgc1vENmS=Sg9pS8ZXPGhfMFnA8ZUA@mail.gmail.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
	<1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
	<CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
	<20140321104317.GA2493@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:58424 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760518AbaCUKy2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 06:54:28 -0400
Received: by mail-oa0-f49.google.com with SMTP id h16so2306274oag.36
        for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 03:54:28 -0700 (PDT)
In-Reply-To: <20140321104317.GA2493@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

On 21 March 2014 16:13, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> On Fri, Mar 21, 2014 at 02:11:32PM +0530, Viresh Kumar wrote:

>> > +               pr_debug("PState id %d freq %d MHz\n", id, freq);
>> > +               powernv_freqs[i].driver_data = i;
>>
>> I don't think you are using this field at all and this is the field you can
>> use for driver_data and so you can get rid of powernv_pstate_ids[ ].
>
> Using driver_data to record powernv_pstate_ids won't work since
> powernv_pstate_ids can be negative. So a pstate_id -3 can be confused
> with CPUFREQ_BOOST_FREQ thereby not displaying the frequency
> corresponding to pstate id -3. So for now I think we will be retaining
> powernv_pstate_ids.

As I said earlier, this field is only used by cpufreq drivers and cpufreq core
isn't supposed to touch it. CPUFREQ_BOOST_FREQ and other macros
are there for .frequency field and not this one.


>> > +static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
>> > +{
>> > +       int base, i;
>> > +
>> > +#ifdef CONFIG_SMP
>>
>> What will break if you don't have this ifdef here? Without that as well
>> below code should work?

Missed this one?

>> > +       base = cpu_first_thread_sibling(policy->cpu);
>> > +
>> > +       for (i = 0; i < threads_per_core; i++)
>> > +               cpumask_set_cpu(base + i, policy->cpus);
>> > +#endif
>> > +       policy->cpuinfo.transition_latency = 25000;
>> > +
>> > +       policy->cur = powernv_freqs[0].frequency;
>> > +       cpufreq_frequency_table_get_attr(powernv_freqs, policy->cpu);
>>
>> This doesn't exist anymore.
>
> Didn't get this comment!

cpufreq_frequency_table_get_attr() routine doesn't exist anymore.

>> > +static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>> > +{
>> > +       cpufreq_frequency_table_put_attr(policy->cpu);
>> > +       return 0;
>> > +}
>>
>> You don't need this..
>
> Why not ?

Because cpufreq_frequency_table_get_attr() and
cpufreq_frequency_table_put_attr() don't exist anymore :)

>> > +module_init(powernv_cpufreq_init);
>> > +module_exit(powernv_cpufreq_exit);
>>
>> Place these right after the routines without any blank lines in
> between.
>
> Is this the new convention ?

Don't know I have been following this since long time, probably from the
time I started with Mainline stuff.. I have seen many maintainers advising this
as it make code more readable, specially if these routines are quite big..

Probably it isn't mentioned in coding guidelines but people follow it most of
the times.
