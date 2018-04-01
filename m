From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v8 01/10] time: tick-sched: Reorganize idle tick
 management code
Date: Sun, 1 Apr 2018 03:50:28 +0200
Message-ID: <20180401015027.GA28019@lerouge>
References: <40092860.XNQZrLjKDd@aspire.rjw.lan>
 <6322298.N2JNOlAanx@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6322298.N2JNOlAanx@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 29, 2018 at 02:00:01PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Prepare the scheduler tick code for reworking the idle loop to
> avoid stopping the tick in some cases.
> 
> The idea is to split the nohz idle entry call to decouple the idle
> time stats accounting and preparatory work from the actual tick stop
> code, in order to later be able to delay the tick stop once we reach
> more power-knowledgeable callers.
> 
> Move away the tick_nohz_start_idle() invocation from
> __tick_nohz_idle_enter(), rename the latter to
> __tick_nohz_idle_stop_tick() and define tick_nohz_idle_stop_tick()
> as a wrapper around it for calling it from the outside.
> 
> Make tick_nohz_idle_enter() only call tick_nohz_start_idle() instead
> of calling the entire __tick_nohz_idle_enter(), add another wrapper
> disabling and enabling interrupts around tick_nohz_idle_stop_tick()
> and make the current callers of tick_nohz_idle_enter() call it too
> to retain their current functionality.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
