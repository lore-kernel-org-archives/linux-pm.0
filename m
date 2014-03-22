From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get()
 method
Date: Sat, 22 Mar 2014 13:23:56 +0530
Message-ID: <20140322075356.GA3857@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
 <20140321110445.GB2493@in.ibm.com>
 <1395442590.3460.85.camel@pasglop>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:35160 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbaCVHyH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 22 Mar 2014 03:54:07 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Sat, 22 Mar 2014 01:54:06 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 5810F1FF003B
	for <linux-pm@vger.kernel.org>; Sat, 22 Mar 2014 01:54:04 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2M5pDaU8651016
	for <linux-pm@vger.kernel.org>; Sat, 22 Mar 2014 06:51:13 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2M7s3EF002767
	for <linux-pm@vger.kernel.org>; Sat, 22 Mar 2014 01:54:04 -0600
Content-Disposition: inline
In-Reply-To: <1395442590.3460.85.camel@pasglop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ego@linux.vnet.ibm.com, Viresh Kumar <viresh.kumar@linaro.org>, linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>, svaidy@linux.vnet.ibm.com

Hi Ben,

On Sat, Mar 22, 2014 at 09:56:30AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2014-03-21 at 16:34 +0530, Gautham R Shenoy wrote:
> 
> > > >
> > > > +/*
> > > > + * Computes the current frequency on this cpu
> > > > + * and stores the result in *ret_freq.
> > > > + */
> > > > +static void powernv_read_cpu_freq(void *ret_freq)
> > > > +{
> > > > +       unsigned long pmspr_val;
> > > > +       s8 local_pstate_id;
> > > > +       int *cur_freq, freq, pstate_id;
> > > > +
> > > > +       cur_freq = (int *)ret_freq;
> > > 
> > > You don't need cur_freq variable at all..
> > 
> > I don't like it either. But the compiler complains without this hack
> > :-(
> 
> Casting integers into void * is a recipe for disaster... what is that
> supposed to be about ?

Like I mentioned elsewhere on this thread, we're calling
powernv_read_cpu_freq via an smp_call_function(). We use this to
obtain the frequency on the cpu where powernv_read_cpu_freq
executes and return it to the caller of smp_call_function.

> We lose all type checking and get exposed
> to endian issues etc... the day somebody uses a different type on both
> sides.
> 
Yes, I understand the problem now. I'll think of a safer way to pass
the return value.

> Also is "freq" a frequency ? In this case an int isn't big enough.

freq is the frequency stored in the cpufreq_table. The value is in
kHz. So, int should be big enough.

> Cheers,
> Ben.
> 
>

--
Thanks and Regards
gautham. 

