From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/6] cpufreq: intel_p_state: Fix limiting turbo sub states
Date: Wed, 07 Oct 2015 01:22:58 +0200
Message-ID: <4304798.l7TM85pp3T@vostro.rjw.lan>
References: <1443567248-27134-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1444092185.17895.99.camel@spandruv-desk3.jf.intel.com> <1444151263.17895.114.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60110 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753040AbbJFWy1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2015 18:54:27 -0400
In-Reply-To: <1444151263.17895.114.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>

On Tuesday, October 06, 2015 05:08:14 PM Pandruvada, Srinivas wrote:
> On Mon, 2015-10-05 at 17:43 -0700, Srinivas Pandruvada wrote:
> > On Tue, 2015-10-06 at 00:56 +0200, Rafael J. Wysocki wrote:
> [..]
> > >  struct vid_data {
> > > @@ -132,6 +133,8 @@ struct pstate_funcs {
> > >     int (*get_scaling)(void);
> > >     void (*set)(struct cpudata*, int pstate);
> > >     void (*get_vid)(struct cpudata *);
> > > +   u64 (*get_turbo_ratio_limit)(struct cpudata *);
> > > +   int (*set_turbo_ratio_limit)(struct cpudata *, u64, u64);

I've started to wonder about the value of having the second new callback at all.

The guys who need it will always have pstate.turbo_ratio_limit different
from zero, so we can use this check to decide whether or not to write to
the register.

> > 
> > An int is always passed as the last arg to this, so why is the arg
> u64?
> > 
> It can be int as we care only about low byte which is max turbo ratio.

Hmm.

> > >  };
> [..]
> > >  Instead of shifting def_ratio and new_ratio in each
> > > step, I'd shift max_ratio and the mask:
> > > 
> > > 	u64 mask = 0xff;
> > > 	u64 max_ratio = new_ratio & mask;
> > > 
> > > 	while (mask) {
> > > 		if (def_ratio & mask) {
> > > 			u64 ratio;
> > > 
> > > 			if (new_ratio & mask) {

So why do we need this?

If we only care about the lowest byte only, we should discard all of the upper
bytes in new_ration here, shouldn't we?

> > > 				ratio = new_ratio & mask;
> > > 			} else {
> > > 				ratio = def_ratio & mask;
> > > 				if (ratio > max_ratio)
> > > 					ratio = max_ratio;
> > > 			}
> > > 			out_ratio |= ratio;
> > > 		}
> > > 		max_ratio <<= 8;
> > > 		mask <<= 8;
> > > 	}
> > > 
> > I will experiment with your algorithm and check.
> > 
> Your algorithm works, so will change to this.
> 
> [..]
> 
> > > > +	if (pstate_funcs.get_turbo_ratio_limit &&
> > > > +	    !cpu->pstate.turbo_ratio_limit)
> > > > +		cpu->pstate.turbo_ratio_limit =
> > > > +			pstate_funcs.get_turbo_ratio_limit(cpu);
> > > 
> > > So we read MSR_NHM_TURBO_RATIO_LIMIT and store it into pstate.turbo_ratio_limit
> > > unless alread populated.  This means we do it only once during initialization.
> > > 
> > > What if the value we have in there is stale after, say, system suspend-resume?
> > > 
> > Did I mess up here? You mean data stored in a variable
> > cpu->pstate.turbo_ratio_limit is corrupted after suspend/resume. This is
> > a vzalloc memory.. 
> > all_cpu_data = vzalloc(sizeof(void *) * num_possible_cpus()) one time
> > during __init intel_pstate_init
> Also 	all_cpu_data[cpunum] is allocated only once during first cpufreq
> callback for init and not freed
> 	if (!all_cpu_data[cpunum])
> 		all_cpu_data[cpunum] = kzalloc(sizeof(struct cpudata),
> 					       GFP_KERNEL);
> Did STR tests, didn't see issue. Not sure how else corruption can happen
> unless slab memory is corrupted. Can you tell how it will be stale?

I was concerned about the BIOS changing the value in the register in which
case we probably should restore what we wrote to it last time or users
may be confused.

Thanks,
Rafael

