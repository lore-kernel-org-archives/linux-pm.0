From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv platform
Date: Thu, 27 Mar 2014 15:41:37 +0530
Message-ID: <20140327101137.GA8747@dirshya.in.ibm.com>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
 <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
 <CAKohponPb+b=8Pa=te3CkiN6QPAUAukngqLSdG4vxc9pUkD8OQ@mail.gmail.com>
 <20140327093050.GA27777@in.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:40164 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834AbaC0KLt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Mar 2014 06:11:49 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <svaidy@linux.vnet.ibm.com>;
	Thu, 27 Mar 2014 15:41:43 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4C86AE0056
	for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 15:45:42 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2RABlXR45351134
	for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 15:41:47 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2RABdTg012790
	for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 15:41:41 +0530
Content-Disposition: inline
In-Reply-To: <20140327093050.GA27777@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

* Gautham R Shenoy <ego@linux.vnet.ibm.com> [2014-03-27 15:00:50]:

[snip]
 
> > > +       u32 len_ids, len_freqs;
> > > +
> > > +       power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
> > > +       if (!power_mgt) {
> > > +               pr_warn("power-mgt node not found\n");
> > > +               return -ENODEV;
> > > +       }
> > > +
> > > +       if (of_property_read_u32(power_mgt, "ibm,pstate-min", &pstate_min)) {
> > > +               pr_warn("ibm,pstate-min node not found\n");
> > > +               return -ENODEV;
> > > +       }
> > > +
> > > +       if (of_property_read_u32(power_mgt, "ibm,pstate-max", &pstate_max)) {
> > > +               pr_warn("ibm,pstate-max node not found\n");
> > > +               return -ENODEV;
> > > +       }
> > 
> > Why do you need to get these from DT? And not find that yourself here instead?
> >
> 
> Well, I think we can obtain a more accurate value from the DT which
> would have already computed it. But I'll let vaidy answer this.

DT provides the values that we should use.  Ideally these are the
upper and lower limits of the PState table,  however as per the
platform spec, we should use the PState IDs between these limits.  We
would like to parse it and keep it in the driver for debug purposes.

The platform exports this info in the DT to be more explicit and not
have a strong dependency on the PState numbering or PState table
itself.  In the driver we parse it for debug/validation purpose.

--Vaidy

