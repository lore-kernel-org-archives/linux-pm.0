From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
Date: Fri, 21 Mar 2014 18:53:26 +0530
Message-ID: <20140321132326.GE2493@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
 <20140321104317.GA2493@in.ibm.com>
 <CAKohpo=JqHOPF_pdcAsvRgc1vENmS=Sg9pS8ZXPGhfMFnA8ZUA@mail.gmail.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:38571 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965502AbaCUNXg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 09:23:36 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Fri, 21 Mar 2014 07:23:36 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 1D6FC3E40045
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 07:23:33 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2LDNX3W62259256
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 14:23:33 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2LDNV7A031926
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 07:23:32 -0600
Content-Disposition: inline
In-Reply-To: <CAKohpo=JqHOPF_pdcAsvRgc1vENmS=Sg9pS8ZXPGhfMFnA8ZUA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

Hi Viresh,

On Fri, Mar 21, 2014 at 04:24:27PM +0530, Viresh Kumar wrote:
> On 21 March 2014 16:13, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> > On Fri, Mar 21, 2014 at 02:11:32PM +0530, Viresh Kumar wrote:
> 
> >> > +               pr_debug("PState id %d freq %d MHz\n", id, freq);
> >> > +               powernv_freqs[i].driver_data = i;
> >>
> >> I don't think you are using this field at all and this is the field you can
> >> use for driver_data and so you can get rid of powernv_pstate_ids[ ].
> >
> > Using driver_data to record powernv_pstate_ids won't work since
> > powernv_pstate_ids can be negative. So a pstate_id -3 can be confused
> > with CPUFREQ_BOOST_FREQ thereby not displaying the frequency
> > corresponding to pstate id -3. So for now I think we will be retaining
> > powernv_pstate_ids.
> 
> As I said earlier, this field is only used by cpufreq drivers and cpufreq core
> isn't supposed to touch it. CPUFREQ_BOOST_FREQ and other macros
> are there for .frequency field and not this one.
> 

Ok, I had based my code on linus's git tree. I checked the 'pm-cpufreq'
branch of Rafael's 'linux-pm' tree and freq_table.c contains the
following code snippet in show_available_frequencies:

	if (show_boost ^ (table[i].driver_data == CPUFREQ_BOOST_FREQ))
			continue;

I suspect we're talking about different code bases. So could you
please tell me which one should I be looking at ?

> 
> >> > +static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >> > +{
> >> > +       int base, i;
> >> > +
> >> > +#ifdef CONFIG_SMP
> >>
> >> What will break if you don't have this ifdef here? Without that as well
> >> below code should work?
> 
> Missed this one?
> 
> >> > +       base = cpu_first_thread_sibling(policy->cpu);
> >> > +
> >> > +       for (i = 0; i < threads_per_core; i++)
> >> > +               cpumask_set_cpu(base + i, policy->cpus);
> >> > +#endif
> >> > +       policy->cpuinfo.transition_latency = 25000;
> >> > +
> >> > +       policy->cur = powernv_freqs[0].frequency;
> >> > +       cpufreq_frequency_table_get_attr(powernv_freqs, policy->cpu);
> >>
> >> This doesn't exist anymore.
> >
> > Didn't get this comment!
> 
> cpufreq_frequency_table_get_attr() routine doesn't exist anymore.
> 
> >> > +static int powernv_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> >> > +{
> >> > +       cpufreq_frequency_table_put_attr(policy->cpu);
> >> > +       return 0;
> >> > +}
> >>
> >> You don't need this..
> >
> > Why not ?
> 
> Because cpufreq_frequency_table_get_attr() and
> cpufreq_frequency_table_put_attr() don't exist anymore :)

Well, it does in the codebases that I was looking at. May be I've been
looking at the wrong place.

> 
> >> > +module_init(powernv_cpufreq_init);
> >> > +module_exit(powernv_cpufreq_exit);
> >>
> >> Place these right after the routines without any blank lines in
> > between.
> >
> > Is this the new convention ?
> 
> Don't know I have been following this since long time, probably from the
> time I started with Mainline stuff.. I have seen many maintainers advising this
> as it make code more readable, specially if these routines are quite big..
> 
> Probably it isn't mentioned in coding guidelines but people follow it most of
> the times.

Ok. I was not aware of this. Good to know :-)
> 

--
Thanks and Regards
gautham.

