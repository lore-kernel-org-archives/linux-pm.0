From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 05/10] timer: Retrieve next expiry of pinned/non-pinned
 timers seperately
Date: Wed, 19 Apr 2017 11:56:19 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1704191154200.1829@nanos>
References: <20170418111102.490432548@linutronix.de> <20170418111400.778021491@linutronix.de> <20170419070558.eq3rdqyesvstuq4r@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:55895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760347AbdDSJ4W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 05:56:22 -0400
In-Reply-To: <20170419070558.eq3rdqyesvstuq4r@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>, Richard Cochran <rcochran@linutronix.de>

On Wed, 19 Apr 2017, Peter Zijlstra wrote:
> On Tue, Apr 18, 2017 at 01:11:07PM +0200, Thomas Gleixner wrote:
> > +
> > +	/*
> > +	 * If the local queue expires first, there is no requirement for
> > +	 * queuing the CPU in the global expiry mechanism.
> 
> The comment doesn't make sense... (maybe at this stage)

Yeah, it's only useful once the real magic is in place.

> > +	 */
> > +	if (!local_first && !global_empty)
> > +		*global_evt = basem + (nextevt_global - basej) * TICK_NSEC;
> 
> I was initially thinking !local_first would have to imply !global_empty,
> but after going back and reading the previous patches again, I found
> this was not so. Still slightly surprising.

Indeed, that's confusing.

Thanks,

	tglx
