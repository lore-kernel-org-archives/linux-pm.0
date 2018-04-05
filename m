From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v9 09/10] cpuidle: menu: Refine idle state selection for
 running tick
Date: Thu, 5 Apr 2018 15:52:22 +0200
Message-ID: <CAJZ5v0hHafjXS_erX_mRda_ZNj5LHXVQPthOO2F5zpBDAoQXsA@mail.gmail.com>
References: <1736751.LdhZHb50jq@aspire.rjw.lan> <5752796.zf5UeYB95r@aspire.rjw.lan>
 <20180405123219.GP4082@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180405123219.GP4082@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, Mike Galbraith <mgalbraith@suse.de>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 5, 2018 at 2:32 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Apr 04, 2018 at 10:49:34AM +0200, Rafael J. Wysocki wrote:
>> +     data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
>> +             unsigned int delta_next_us = ktime_to_us(delta_next);
>
> We really should be looking at removing all that us nonsense from the
> idle code, but that'll be another series.

Right.
