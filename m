From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] powercap/rapl: reduce ipi calls
Date: Wed, 17 Feb 2016 17:04:41 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602171652010.19512@nanos>
References: <1452884653-10560-1-git-send-email-jacob.jun.pan@linux.intel.com> <4100978.ozoN0XeYQl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44697 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030319AbcBQQF5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2016 11:05:57 -0500
In-Reply-To: <4100978.ozoN0XeYQl@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Tue, 16 Feb 2016, Rafael J. Wysocki wrote:
> On Friday, January 15, 2016 11:04:13 AM Jacob Pan wrote:
> > Reduce remote CPU calls for MSR access by combining read
> > modify write into one function. Also optimize search for active CPU on
> > package such that remote CPU is not used if the current CPU is already
> > on the target package.
> > 
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> I'm wondering if there are any comments on this one?

Yes.
 
> > ---
> >  drivers/powercap/intel_rapl.c | 122 ++++++++++++++++++++++++++++++------------
> >  1 file changed, 87 insertions(+), 35 deletions(-)
> > 
> > diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> > index 48747c2..2dcd95f 100644
> > --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -133,6 +133,12 @@ struct rapl_domain_data {
> >  	unsigned long timestamp;
> >  };
> >  
> > +struct msrl_action {
> > +	u32 msr_no;
> > +	u64 clear_mask;
> > +	u64 set_mask;
> > +	int err;
> > +};
> >  
> >  #define	DOMAIN_STATE_INACTIVE           BIT(0)
> >  #define	DOMAIN_STATE_POWER_LIMIT_SET    BIT(1)
> > @@ -263,7 +269,11 @@ static struct rapl_package *find_package_by_id(int id)
> >  /* caller to ensure CPU hotplug lock is held */
> >  static int find_active_cpu_on_package(int package_id)
> >  {
> > -	int i;
> > +	/* try to avoid remote cpu call, use raw since we are preemptible */
> > +	int i = raw_smp_processor_id();
> > +
> > +	if (topology_physical_package_id(i) == package_id)
> > +		return i;
> >  
> >  	for_each_online_cpu(i) {
> >  		if (topology_physical_package_id(i) == package_id)

This is still crap. We really want a proper handling for that which does
not require these silly for_each_cpu() loops.

That code already has a hotplug notifier, so you can track one online cpu in
the package like we do in cqm and other facilities.

The first online cpu of a package sets itself as 'owner'. On unplug it looks
up:

	rpl->cpu = cpumask_any_but(topology_core_cpumask(cpu), cpu);

So if this is the last cpu then rpl->cpu becomes nr_cpu_ids.

So that whole nonsense can be avoided completely.

Thanks,

	tglx






