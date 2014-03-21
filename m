From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
Date: Fri, 21 Mar 2014 20:24:52 +0530
Message-ID: <20140321145452.GA8755@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
 <20140321104317.GA2493@in.ibm.com>
 <CAKohpo=JqHOPF_pdcAsvRgc1vENmS=Sg9pS8ZXPGhfMFnA8ZUA@mail.gmail.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:55604 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759232AbaCUOzH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 10:55:07 -0400
Received: from /spool/local
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Fri, 21 Mar 2014 08:55:07 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 13D923E4003F
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 08:55:04 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2LEsUpO7537022
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 15:54:30 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2LEt1Nt003151
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 08:55:03 -0600
Content-Disposition: inline
In-Reply-To: <CAKohpo=JqHOPF_pdcAsvRgc1vENmS=Sg9pS8ZXPGhfMFnA8ZUA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

On Fri, Mar 21, 2014 at 04:24:27PM +0530, Viresh Kumar wrote:
> >> > +static int powernv_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >> > +{
> >> > +       int base, i;
> >> > +
> >> > +       base = cpu_first_thread_sibling(policy->cpu);
> >> > +
> >> > +       for (i = 0; i < threads_per_core; i++)
> >> > +               cpumask_set_cpu(base + i, policy->cpus);
> >> > +       policy->cpuinfo.transition_latency = 25000;
> >> > +
> >> > +       policy->cur = powernv_freqs[0].frequency;
> >> > +       cpufreq_frequency_table_get_attr(powernv_freqs, policy->cpu);
> >>
> >> This doesn't exist anymore.

Ok, I guess the right thing to do at this point is call

   cpufreq_table_validate_and_show(policy, powernv_freqs);

Will fix the code to take care of this.
--
Thanks and Regards
gautham.

