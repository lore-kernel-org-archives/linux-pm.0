From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] powercap/rapl: reduce ipi calls
Date: Wed, 17 Feb 2016 19:22:25 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602171920240.19512@nanos>
References: <1452884653-10560-1-git-send-email-jacob.jun.pan@linux.intel.com> <4100978.ozoN0XeYQl@vostro.rjw.lan> <alpine.DEB.2.11.1602171652010.19512@nanos> <20160217100404.5a59649a@icelake>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45354 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161290AbcBQSXl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2016 13:23:41 -0500
In-Reply-To: <20160217100404.5a59649a@icelake>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Wed, 17 Feb 2016, Jacob Pan wrote:
> On Wed, 17 Feb 2016 17:04:41 +0100 (CET)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > > >  
> > > >  	for_each_online_cpu(i) {
> > > >  		if (topology_physical_package_id(i) ==
> > > > package_id)  
> > 
> > This is still crap. We really want a proper handling for that which
> > does not require these silly for_each_cpu() loops.
> > 
> > That code already has a hotplug notifier, so you can track one online
> > cpu in the package like we do in cqm and other facilities.
> > 
> > The first online cpu of a package sets itself as 'owner'. On unplug
> > it looks up:
> > 
> > 	rpl->cpu = cpumask_any_but(topology_core_cpumask(cpu), cpu);
> > 
> > So if this is the last cpu then rpl->cpu becomes nr_cpu_ids.
> > 
> > So that whole nonsense can be avoided completely.
> ok, that would work nicely, similar to cqm_pick_event_reader().
> thanks for the tip. just fyi, unlike perf cqm, rapl runtime change is
> expected to be low frequency.

That still does not justify crap like this. And please use the version of pick
reader which I posted a couple of hours ago.

       http://marc.info/?l=linux-kernel&m=145572542221627&w=2

Thanks,

	tglx

