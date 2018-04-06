From: Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v9 05/10] cpuidle: Return nohz hint from cpuidle_select()
Date: Fri, 6 Apr 2018 17:28:45 +0200
Message-ID: <20180406152844.GF4400@lerouge>
References: <1736751.LdhZHb50jq@aspire.rjw.lan>
 <20180406024413.GB4400@lerouge>
 <6471749.luEdDuCiOl@aspire.rjw.lan>
 <34634950.bjF6TWOVDx@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <34634950.bjF6TWOVDx@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 06, 2018 at 02:56:36PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] nohz: Avoid duplication of code related to got_idle_tick
> 
> Move the code setting ts->got_idle_tick into tick_sched_do_timer() to
> avoid code duplication.
> 
> No intentional changes in functionality.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
