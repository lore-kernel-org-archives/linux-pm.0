From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 08/10] timer: Implement the hierarchical pull model
Date: Wed, 19 Apr 2017 10:36:40 +0200
Message-ID: <20170419083640.hpybu2lard6qnj5s@hirez.programming.kicks-ass.net>
References: <20170418111102.490432548@linutronix.de>
 <20170418111401.016420305@linutronix.de>
 <20170419081116.GA3029@worktop.programming.kicks-ass.net>
 <alpine.DEB.2.20.1704191028230.1829@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:53260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760952AbdDSIgr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 04:36:47 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704191028230.1829@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

On Wed, Apr 19, 2017 at 10:31:08AM +0200, Thomas Gleixner wrote:
> On Wed, 19 Apr 2017, Peter Zijlstra wrote:
> > On Tue, Apr 18, 2017 at 01:11:10PM +0200, Thomas Gleixner wrote:

> > > +	}
> > > +	/* Allocate and set up a new group */
> > > +	group = kzalloc_node(sizeof(*group), GFP_KERNEL, node);
> > > +	if (!group)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	if (!zalloc_cpumask_var_node(&group->cpus, GFP_KERNEL, node)) {
> > > +		kfree(group);
> > > +		return ERR_PTR(-ENOMEM);
> > > +	}
> > 
> > So if you place that cpumask last, you can do:
> > 
> > 	group = kzalloc_node(sizeof(*group) + cpumask_size(),
> > 	                     GFP_KERNEL, node);
> 
> Hrm, that would allocate extra space for CPUMASK_OFF_STACK=n. I'll have a
> look.
> 

How so? Remember your structure will look like:

struct group {
	/* ... */
	unsigned long cpumask[0];
};

Which, even for the CPUMASK_OFF_STACK=n case, is exactly 0 bytes of
total storage.
