From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 03/10] timers: Rework idle logic
Date: Wed, 19 Apr 2017 08:50:39 +0200
Message-ID: <20170419065039.nhmi5vrhydqy5ftw@hirez.programming.kicks-ass.net>
References: <20170418111102.490432548@linutronix.de>
 <20170418111400.589271247@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51878 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933239AbdDSGu4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 02:50:56 -0400
Content-Disposition: inline
In-Reply-To: <20170418111400.589271247@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

On Tue, Apr 18, 2017 at 01:11:05PM +0200, Thomas Gleixner wrote:
> Storing next event and determining whether the base is idle can be done in
> __next_timer_interrupt(). 
> 
> Preparatory patch for new call sites which need this information as well.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/timer.c |   43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
> 
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1358,8 +1358,11 @@ static int next_pending_bucket(struct ti
>  /*
>   * Search the first expiring timer in the various clock levels. Caller must
>   * hold base->lock.
> + *
> + * Stores the next expiry time in base. The return value indicates whether
> + * the base is empty or not.
>   */
> -static unsigned long __next_timer_interrupt(struct timer_base *base)
> +static bool __next_timer_interrupt(struct timer_base *base)

Can't say I'm a fan of this.. I sort of see where this is going, but the
fact remains that __next_timer_interrupt(), as a function, makes me
expect a return value of time/timer quantity.
