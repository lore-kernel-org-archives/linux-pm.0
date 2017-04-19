From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 08/10] timer: Implement the hierarchical pull model
Date: Wed, 19 Apr 2017 11:52:20 +0200
Message-ID: <20170419095220.wvvkllzbvl4hxkvw@hirez.programming.kicks-ass.net>
References: <20170418111102.490432548@linutronix.de>
 <20170418111401.016420305@linutronix.de>
 <20170419090914.qdiamqwzro34b53d@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.20.1704191136220.1829@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:53688 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761508AbdDSJwa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 05:52:30 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704191136220.1829@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

On Wed, Apr 19, 2017 at 11:43:01AM +0200, Thomas Gleixner wrote:
> On Wed, 19 Apr 2017, Peter Zijlstra wrote:
> > > +done:
> > > +	raw_spin_unlock(&group->lock);
> > > +	return nextevt;
> > > +}
> > 
> > Would it be very onerous to rewrite that into regular loops? That avoids
> > us having to think (and worry) about blowing our stack.
> 
> The issue is that this is walking a hierarchy tree (limited depth) and not
> a list of groups at a particular level.
> 
> In an earlier version we checked the stack usage and it was ~128 bytes per
> nest level. With 32k CPUs this ends up with maximum 5 recursions, i.e. 640
> bytes. I recheck with the current implementation.

The fact that you have to check (and it varies by compiler version) is
the tedious point. If any of those functions grows their stack
footprint over time, this again changes.

I find it easiest to entirely avoid recursion and safe ourselves this
head-ache.
