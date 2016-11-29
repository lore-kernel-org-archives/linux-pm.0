From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v8 4/8] x86/sysctl: Add sysctl for ITMT scheduling
 feature
Date: Tue, 29 Nov 2016 09:30:49 -0800
Message-ID: <1480440649.3064.39.camel@linux.intel.com>
References: <cover.1479844244.git.tim.c.chen@linux.intel.com>
         <07cc62426a28bad57b01ab16bb903a9c84fa5421.1479844244.git.tim.c.chen@linux.intel.com>
         <20161128085608.v7ujy5j2iftn6qs5@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49133 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbcK2Rav (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Nov 2016 12:30:51 -0500
In-Reply-To: <20161128085608.v7ujy5j2iftn6qs5@pd.tnic>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Mon, 2016-11-28 at 09:56 +0100, Borislav Petkov wrote:
> On Tue, Nov 22, 2016 at 12:23:56PM -0800, Tim Chen wrote:
> > 
> > Intel Turbo Boost Max Technology 3.0 (ITMT) feature
> > allows some cores to be boosted to higher turbo
> > frequency than others.
> > 
> > Add /proc/sys/kernel/sched_itmt_enabled so operator
> > can enable/disable scheduling of tasks that favor cores
> > with higher turbo boost frequency potential.
> > 
> > By default, system that is ITMT capable and single
> > socket has this feature turned on.  It is more likely
> > to be lightly loaded and operates in Turbo range.
> > 
> > When there is a change in the ITMT scheduling operation
> > desired, a rebuild of the sched domain is initiated
> > so the scheduler can set up sched domains with appropriate
> > flag to enable/disable ITMT scheduling operations.
> > 
> > Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Co-developed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> >  arch/x86/include/asm/topology.h |   7 ++-
> >  arch/x86/kernel/itmt.c          | 108 +++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 112 insertions(+), 3 deletions(-)
> ...
> 
> > 
> > +/*
> > + * Boolean to control whether we want to move processes to cpu capable
> > + * of higher turbo frequency for cpus supporting Intel Turbo Boost Max
> > + * Technology 3.0.
> > + *
> > + * It can be set via /proc/sys/kernel/sched_itmt_enabled
> > + */sched_autogroup_enabled
> > +unsigned int __read_mostly sysctl_sched_itmt_enabled;
> Err, can we not have the boolean in the name itself?
> 
> I.e., have it called sysctl_sched_itmt and 1 means enabled and 0
> disabled? I.e., the classic thing. :)
> 
> Ditto for the sysctl name?

I am following the convention in /proc/sys/kernel/sched_autogroup_enabled
and sysctl_sched_autogroup_enabled that's also in /proc/sys/kernel.

Thanks.

Tim

