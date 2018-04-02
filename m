From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v8 03/10] sched: idle: Do not stop the tick before
 cpuidle_idle_call()
Date: Mon, 2 Apr 2018 23:25:09 +0200
Message-ID: <20180402212508.GB19895@lerouge>
References: <40092860.XNQZrLjKDd@aspire.rjw.lan>
 <2094470.21BdEFonBT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2094470.21BdEFonBT@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 29, 2018 at 02:02:24PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make cpuidle_idle_call() decide whether or not to stop the tick.
> 
> First, the cpuidle_enter_s2idle() path deals with the tick (and with
> the entire timekeeping for that matter) by itself and it doesn't need
> the tick to be stopped beforehand.
> 
> Second, to address the issue with short idle duration predictions
> by the idle governor after the tick has been stopped, it will be
> necessary to change the ordering of cpuidle_select() with respect
> to tick_nohz_idle_stop_tick().  To prepare for that, put a
> tick_nohz_idle_stop_tick() call in the same branch in which
> cpuidle_select() is called.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rewiewed-by: Frederic Weisbecker <frederic@kernel.org>
