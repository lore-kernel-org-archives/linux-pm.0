From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 09/10] cpuidle: menu: Refine idle state selection for
 running tick
Date: Thu, 5 Apr 2018 14:32:19 +0200
Message-ID: <20180405123219.GP4082@hirez.programming.kicks-ass.net>
References: <1736751.LdhZHb50jq@aspire.rjw.lan>
 <5752796.zf5UeYB95r@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5752796.zf5UeYB95r@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 04, 2018 at 10:49:34AM +0200, Rafael J. Wysocki wrote:
> +	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
> +		unsigned int delta_next_us = ktime_to_us(delta_next);

We really should be looking at removing all that us nonsense from the
idle code, but that'll be another series.
