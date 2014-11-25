From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/8] opp: Introduce APIs to remove OPPs
Date: Tue, 25 Nov 2014 09:39:43 -0800
Message-ID: <20141125173943.GG5050@linux.vnet.ibm.com>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
 <f815d0855c1bd28d8389554176acd2620e56b3c8.1416910766.git.viresh.kumar@linaro.org>
 <20141125162434.GC5050@linux.vnet.ibm.com>
 <CAKohponBNOm_0_rZqbVKQSoOa81CjnKb8vcfzA6gbm1+Gxn+gg@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:43334 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbaKYRju (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 12:39:50 -0500
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 25 Nov 2014 10:39:49 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 440203E40040
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 10:32:47 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAPHcrCN19267698
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 10:38:53 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id sAPHieFb031553
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 10:44:42 -0700
Content-Disposition: inline
In-Reply-To: <CAKohponBNOm_0_rZqbVKQSoOa81CjnKb8vcfzA6gbm1+Gxn+gg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>

On Tue, Nov 25, 2014 at 10:46:29PM +0530, Viresh Kumar wrote:
> On 25 November 2014 at 21:54, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > If the data is alway accessed under an SRCU read-side critical section,
> > then you do need call_srcu() when freeing it -- as you pointed out,
> > -with- the srcu_struct included.  ;-)
> 
> :)
> 
> > If the data is accessed under both SRCU and RCU, then things get a bit
> > more involved.
> 
> Yes, that is always the case here.
> 
> >> +void __dev_pm_opp_remove(struct device_opp *dev_opp, struct dev_pm_opp *opp)
> >> +{
> >> +     /*
> >> +      * Notify the changes in the availability of the operable
> >> +      * frequency/voltage list.
> >> +      */
> >> +     srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_REMOVE, opp);
> >> +     list_del_rcu(&opp->node);
> >> +     call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, kfree_opp_rcu);
> >
> > I am guessing that opp->node is being removed from the list traversed
> > by srcu_notifier_call_chain()...  (Looks that way below.)
> 
> I couldn't find any code in kernel which is registered for this notifier chain
> yet. And so don't know what that code will do. It may not traverse the list
> or it may :)

I would guess that the srcu_notifier_chain_register() in
devfreq_register_opp_notifier() is adding to the call chain, but I
do not claim to understand this code.  The srcu_notifier_call_chain()
above is traversing it.

> I couldn't understand this comment of yours, sorry: (Looks that way below.)

Well, that comment might or might not be meaningful.  Again, I just took
a quick look at the patch -- I have not gotten my head fully around the
dev-PM code.

> >> +
> >> +     if (list_empty(&dev_opp->opp_list)) {
> >
> > Does the above want to be "if (!list_empty(&dev_opp->opp_list)) {"?
> 
> No. dev_opp contains list of all OPPs. When all OPPs are gone, we don't
> want dev_opp anymore and so freeing it.

OK.

> >> +             list_del_rcu(&dev_opp->node);
> >> +             call_srcu(&dev_opp->srcu_head.srcu, &dev_opp->rcu_head,
> >> +                       kfree_device_rcu);
> >> +     }
> >> +}
> 
> So, I am still not sure what we need to do here as we have readers with
> both rcu and srcu critical regions.

Well, the most straightforward approach from an RCU perspective would
be to make all the readers use the same flavor of RCU.  From Rafael's
earlier note, I am guessing that some of the code paths absolutely
require SRCU.  Of course, if all the readers use SRCU, then you can
simply free using SRCU.

You -can- handle situations having more than one type of reader, but
this requires waiting for all corresponding flavors of grace period.
This turns out to be fairly simple in this case, for example, have your
kfree_opp_rcu() function invoke kfree_rcu() instead of kfree().

But I strongly recommend gaining a full understanding of the code first.
You can dig yourself a really deep hole really quickly by patching code
without understanding it!  And apologies if you really do already fully
understand the code, but your statement above leads me to believe that
you do not yet fully understand it.

	I couldn't find any code in kernel which is registered for this
	notifier chain yet. And so don't know what that code will do. It
	may not traverse the list or it may :)

One thing that can help internalize code (relatively) quickly is to
get a large piece of paper and to draw the relationships of the data
structures first and the relationship of the code later.  When the
drawing gets too messy, start over with a clean sheet of paper.

							Thanx, Paul

