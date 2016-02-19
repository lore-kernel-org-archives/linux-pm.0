From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 2/2] powercap/rapl: reduce ipi calls
Date: Fri, 19 Feb 2016 23:01:59 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602192301250.2477@nanos>
References: <1455914253-18138-1-git-send-email-jacob.jun.pan@linux.intel.com> <1455914253-18138-3-git-send-email-jacob.jun.pan@linux.intel.com> <alpine.DEB.2.11.1602192246070.2477@nanos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56302 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422968AbcBSWDR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Feb 2016 17:03:17 -0500
In-Reply-To: <alpine.DEB.2.11.1602192246070.2477@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>



On Fri, 19 Feb 2016, Thomas Gleixner wrote:

> On Fri, 19 Feb 2016, Jacob Pan wrote:
> > @@ -1380,6 +1375,7 @@ static int rapl_detect_topology(void)
> >  	int i;
> >  	int phy_package_id;
> >  	struct rapl_package *new_package, *rp;
> > +	int lead_cpu;
> >  
> >  	for_each_online_cpu(i) {
> >  		phy_package_id = topology_physical_package_id(i);
> > @@ -1392,7 +1388,11 @@ static int rapl_detect_topology(void)
> >  			/* add the new package to the list */
> >  			new_package->id = phy_package_id;
> >  			new_package->nr_cpus = 1;
> > -
> > +			/* find the first active cpu of the package */
> > +			lead_cpu = cpumask_any_and(topology_core_cpumask(i),
> > +						cpumask_of(i));
> 
> Yuck. Why any_and? The result is i, simply because i is online otherwise you
> would not be there. 
> 
> > +			if (lead_cpu < nr_cpu_ids)
> > +				new_package->lead_cpu = lead_cpu;
> 
> So the above is identical to 
> 
> 			new_package->lead_cpu = lead_cpu;

			new_package->lead_cpu = i;

Copy and paste sucks :)

> Hmm?
> 
> > @@ -1500,6 +1503,15 @@ static int rapl_cpu_callback(struct notifier_block *nfb,
> >  			break;
> >  		if (--rp->nr_cpus == 0)
> >  			rapl_remove_package(rp);
> > +		else if (cpu == rp->lead_cpu) {
> > +			/* choose another active cpu in the package */
> > +			lead_cpu = cpumask_any_but(topology_core_cpumask(cpu), cpu);
> 
> This part is correct.
> 
> Thanks,
> 
> 	tglx
> 
