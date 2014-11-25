From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] opp: convert dev_warn() to dev_dbg() for duplicate OPPs
Date: Tue, 25 Nov 2014 02:27:28 +0100
Message-ID: <2464825.iuDYbaTYCE@vostro.rjw.lan>
References: <7017fa592bdaf73c260ad001a2b7abdc8d14f08a.1416211616.git.viresh.kumar@linaro.org> <42965945.ST26GKfzPz@vostro.rjw.lan> <20141124161435.GE5050@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51516 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750830AbaKYBGP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Nov 2014 20:06:15 -0500
In-Reply-To: <20141124161435.GE5050@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Stefan Wahren <stefan.wahren@i2se.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Monday, November 24, 2014 08:14:35 AM Paul E. McKenney wrote:
> On Mon, Nov 24, 2014 at 04:09:54PM +0100, Rafael J. Wysocki wrote:
> > On Monday, November 24, 2014 04:10:00 PM Viresh Kumar wrote:
> > > On 21 November 2014 at 21:28, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > What about @dynamic instead of @from_dt?  That may apply to more use cases if
> > > > need be.
> > > 
> > > @Paul: I am stuck at a point and need help on RCUs :)
> > > 
> > > File: drivers/base/power/opp.c
> > > 
> > > We are trying to remove OPPs created from static data present in DT on
> > > cpufreq driver's removal (when configured as module).
> > > 
> > > opp core uses RCUs internally and it looks like I need to implement:
> > > list_for_each_entry_safe_rcu()
> > > 
> > > But, I am not sure because of these:
> > > http://linux.derkeiler.com/Mailing-Lists/Kernel/2005-10/6280.html
> > > http://patchwork.ozlabs.org/patch/48989/
> > > 
> > > So, wanted to ask you if I really need that or the OPP code is
> > > buggy somewhere.
> > > 
> > > The code removing OPPs is:
> > > 
> > >         list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
> > >                 srcu_notifier_call_chain(&dev_opp->head, OPP_EVENT_REMOVE, opp);
> > >                 list_del_rcu(&opp->node);
> > > 
> > >                 kfree(opp);
> 
> As Rafael says, if opp is reachable by RCU readers, you cannot just
> immediately kfree() it.  Immediately kfree()ing it like this -will-
> cause your RCU readers to see freed memory, which, as you noted, can
> cause crashes.
> 
> > >         }
> > > 
> > > Because we are freeing opp at the end, list_for_each_entry_rcu()
> > > is trying to read the already freed opp to find opp->node.next
> > > and that results in a crash.
> > > 
> > > What am I doing wrong ?
> > 
> > I hope that doesn't happen under rcu_read_lock()?
> > 
> > The modification needs to be done under dev_opp_list_lock in the first place
> > in which case you don't need the _rcu version of list walking, so you simply
> > can use list_for_each_entry_safe() here. The mutex is sufficient for the
> > synchronization with other writers (if any).  The freeing, though, has to be
> > deferred until all readers drop their references to the old entry.  You can
> > use kfree_rcu() for that.
> 
> Except that srcu_notifier_call_chain() involves SRCU readers.  So,
> unless I am confused, you instead need something like this:

Correct, that's SRCU.  Sorry for my confusion.


> static void kfree_opp_rcu(struct rcu_head *rhp)
> {
> 	struct device_opp *opp = container_of(rhp, struct device_opp, opp_list);
> 
> 	kfree(opp);
> }
> 
> Then replace the above kfree() by:
> 
> 	call_srcu(&opp->rcu, kfree_opp_rcu);
> 
> This will require adding the following to struct device_opp:
> 
> 	struct rcu_head rcu;
> 
> And yes, this would be simpler if there was a kfree_srcu().  If a few
> more uses like this show up, I will create one.
> 
> All that said, I do not claim to understand the OPP code, so please take
> the above suggested changes with a grain of salt.  And if you let me know
> where I am confused, I should be able to offer better suggestions.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
