From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 08/10] timer: Implement the hierarchical pull model
Date: Wed, 19 Apr 2017 11:43:01 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1704191136220.1829@nanos>
References: <20170418111102.490432548@linutronix.de> <20170418111401.016420305@linutronix.de> <20170419090914.qdiamqwzro34b53d@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:55785 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761859AbdDSJnG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 05:43:06 -0400
In-Reply-To: <20170419090914.qdiamqwzro34b53d@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

On Wed, 19 Apr 2017, Peter Zijlstra wrote:
> > +done:
> > +	raw_spin_unlock(&group->lock);
> > +	return nextevt;
> > +}
> 
> Would it be very onerous to rewrite that into regular loops? That avoids
> us having to think (and worry) about blowing our stack.

The issue is that this is walking a hierarchy tree (limited depth) and not
a list of groups at a particular level.

In an earlier version we checked the stack usage and it was ~128 bytes per
nest level. With 32k CPUs this ends up with maximum 5 recursions, i.e. 640
bytes. I recheck with the current implementation.

Thanks,

	tglx
