From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v9 05/10] cpuidle: Return nohz hint from cpuidle_select()
Date: Fri, 6 Apr 2018 16:23:56 +0200
Message-ID: <20180406142355.GD4400@lerouge>
References: <1736751.LdhZHb50jq@aspire.rjw.lan>
 <5818594.T4StF86Hkt@aspire.rjw.lan>
 <20180406024413.GB4400@lerouge>
 <20180406075837.GH4082@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180406075837.GH4082@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 06, 2018 at 09:58:37AM +0200, Peter Zijlstra wrote:
> On Fri, Apr 06, 2018 at 04:44:14AM +0200, Frederic Weisbecker wrote:
> > You can move that to tick_sched_do_timer() to avoid code duplication.
> 
> I expect the reason I didn't was that it didn't have @ts, but that's
> easily fixable.
> 
> > Also these constants are very opaque. And even with proper symbols it wouldn't look
> > right to extend ts->inidle that way.
> > 
> > Perhaps you should add a field such as ts->got_idle_tick under the boolean fields
> > after the below patch:
> 
> > @@ -45,14 +45,17 @@ struct tick_sched {
> >  	struct hrtimer			sched_timer;
> >  	unsigned long			check_clocks;
> >  	enum tick_nohz_mode		nohz_mode;
> > +
> > +	unsigned int			inidle		: 1;
> > +	unsigned int			tick_stopped	: 1;
> > +	unsigned int			idle_active	: 1;
> > +	unsigned int			do_timer_last	: 1;
> 
> That would generate worse code, but yes, the C might be prettier.

Well, not too bad I think. MOV become OR/AND, the rest is just
TESTs...
