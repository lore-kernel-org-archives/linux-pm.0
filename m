From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get()
 method
Date: Sat, 22 Mar 2014 09:56:30 +1100
Message-ID: <1395442590.3460.85.camel@pasglop>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
	 <1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
	 <CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
	 <20140321110445.GB2493@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:32866 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079AbaCUW5R (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 21 Mar 2014 18:57:17 -0400
In-Reply-To: <20140321110445.GB2493@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ego@linux.vnet.ibm.com
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>, svaidy@linux.vnet.ibm.com

On Fri, 2014-03-21 at 16:34 +0530, Gautham R Shenoy wrote:

> > >
> > > +/*
> > > + * Computes the current frequency on this cpu
> > > + * and stores the result in *ret_freq.
> > > + */
> > > +static void powernv_read_cpu_freq(void *ret_freq)
> > > +{
> > > +       unsigned long pmspr_val;
> > > +       s8 local_pstate_id;
> > > +       int *cur_freq, freq, pstate_id;
> > > +
> > > +       cur_freq = (int *)ret_freq;
> > 
> > You don't need cur_freq variable at all..
> 
> I don't like it either. But the compiler complains without this hack
> :-(

Casting integers into void * is a recipe for disaster... what is that
supposed to be about ? We lose all type checking and get exposed
to endian issues etc... the day somebody uses a different type on both
sides.

Also is "freq" a frequency ? In this case an int isn't big enough.

Cheers,
Ben.


