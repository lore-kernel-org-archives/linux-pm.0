From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 4/5] powernv:cpufreq: Export nominal frequency via
 sysfs.
Date: Fri, 21 Mar 2014 15:25:34 +0530
Message-ID: <20140321095534.GF27293@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395317460-14811-5-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x=kLwDGFtHR5sBKhE-9L=3=npV4_i+B+BVm+yBocmmMvzQ@mail.gmail.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:37663 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbaCUJzn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 05:55:43 -0400
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Fri, 21 Mar 2014 03:55:42 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 486A63E4003F
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 03:55:41 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2L9swKg6226398
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 10:54:58 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2L9tei8012399
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 03:55:40 -0600
Content-Disposition: inline
In-Reply-To: <CAOh2x=kLwDGFtHR5sBKhE-9L=3=npV4_i+B+BVm+yBocmmMvzQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>, benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com

On Fri, Mar 21, 2014 at 02:17:28PM +0530, Viresh Kumar wrote:
> > +static ssize_t show_cpuinfo_nominal_freq(struct cpufreq_policy *policy,
> > +                                       char *buf)
> > +{
> > +       int nominal_freq;
> > +       nominal_freq = pstate_id_to_freq(powernv_pstate_info.pstate_nominal_id);
> > +       return sprintf(buf, "%u\n", nominal_freq);
> 
> return sprintf(buf, "%u\n",
> pstate_id_to_freq(powernv_pstate_info.pstate_nominal_id));

Sure. Will fix this. 
> 
> ??
> 
> > +}
> > +
> > +
> 
> remove extra blank line.
> 
> > +struct freq_attr cpufreq_freq_attr_cpuinfo_nominal_freq = {
> > +       .attr = { .name = "cpuinfo_nominal_freq",
> > +                 .mode = 0444,
> > +               },
> 
> Align {}

Probably the use of ATTR_RO(cpuinfo_nominal_freq) and renaming
show_cpuinfo_nominal_freq to cpuinfo_nominal_freq_show() would be even
better. What do you think ?

> 
> > +       .show = show_cpuinfo_nominal_freq,
> > +};
> > +
> > +
> >  static struct freq_attr *powernv_cpu_freq_attr[] = {
> >         &cpufreq_freq_attr_scaling_available_freqs,
> > +       &cpufreq_freq_attr_cpuinfo_nominal_freq,
> >         NULL,
> >  };

This needs to be rewritten to include the entries of cpufreq_generic_attr.
>

Thanks for the review.

--
Regards
gautham. 

