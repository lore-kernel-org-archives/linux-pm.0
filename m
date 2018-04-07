From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 06/10] time: tick-sched: Split tick_nohz_stop_sched_tick()
Date: Sat, 07 Apr 2018 18:36:34 +0200
Message-ID: <2792573.Q2KagqXIrf@aspire.rjw.lan>
References: <1736751.LdhZHb50jq@aspire.rjw.lan> <4511679.r9V9QramI4@aspire.rjw.lan> <20180407023623.GA16600@lerouge>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180407023623.GA16600@lerouge>
Sender: linux-kernel-owner@vger.kernel.org
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Saturday, April 7, 2018 4:36:25 AM CEST Frederic Weisbecker wrote:
> On Wed, Apr 04, 2018 at 10:41:13AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > In order to address the issue with short idle duration predictions
> > by the idle governor after the scheduler tick has been stopped, split
> > tick_nohz_stop_sched_tick() into two separate routines, one computing
> > the time to the next timer event and the other simply stopping the
> > tick when the time to the next timer event is known.
> > 
> > Prepare these two routines to be called separately, as one of them
> > will be called by the idle governor in the cpuidle_select() code
> > path after subsequent changes.
> > 
> > Update the former callers of tick_nohz_stop_sched_tick() to use
> > the new routines, tick_nohz_next_event() and tick_nohz_stop_tick(),
> > instead of it and move the updates of the sleep_length field in
> > struct tick_sched into __tick_nohz_idle_stop_tick() as it doesn't
> > need to be updated anywhere else.
> > 
> > There should be no intentional visible changes in functionality
> > resulting from this change.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Thanks! And sorry for the slow reviews, the changes are sensitive

Right, very much so.

> and I want to make sure we are not breaking some subtlety.

Thanks a lot for doing that!
