From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] opp: convert dev_warn() to dev_dbg() for duplicate OPPs
Date: Tue, 25 Nov 2014 08:25:22 -0800
Message-ID: <20141125162522.GD5050@linux.vnet.ibm.com>
References: <7017fa592bdaf73c260ad001a2b7abdc8d14f08a.1416211616.git.viresh.kumar@linaro.org>
 <5171628.FRGslOuEb6@vostro.rjw.lan>
 <CAKohpomz_UiRErSsDPLWcmU4e7ocXZZu7bwCF8TvoSJupikd7A@mail.gmail.com>
 <42965945.ST26GKfzPz@vostro.rjw.lan>
 <20141124161435.GE5050@linux.vnet.ibm.com>
 <CAKohpo=dDTAV=B0CvCqD1H-QGuQ+i2w5Lfr3egpWzrvRYVNWmw@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:58918 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaKYQZ1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 11:25:27 -0500
Received: from /spool/local
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 25 Nov 2014 09:25:27 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C2FD93E4003B
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 09:18:20 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sAPGPOSM54853674
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 09:25:24 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id sAPGUJ8n003743
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 09:30:19 -0700
Content-Disposition: inline
In-Reply-To: <CAKohpo=dDTAV=B0CvCqD1H-QGuQ+i2w5Lfr3egpWzrvRYVNWmw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stefan Wahren <stefan.wahren@i2se.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Nov 25, 2014 at 04:07:35PM +0530, Viresh Kumar wrote:
> On 24 November 2014 at 21:44, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > As Rafael says, if opp is reachable by RCU readers, you cannot just
> > immediately kfree() it.  Immediately kfree()ing it like this -will-
> > cause your RCU readers to see freed memory, which, as you noted, can
> > cause crashes.
> 
> In order to reply you at some level, I tried going through RCU documentation
> today before replying anymore. And yes I understood this part.
> 
> > Except that srcu_notifier_call_chain() involves SRCU readers.  So,
> > unless I am confused, you instead need something like this:
> >
> > static void kfree_opp_rcu(struct rcu_head *rhp)
> > {
> >         struct device_opp *opp = container_of(rhp, struct device_opp, opp_list);
> >
> >         kfree(opp);
> > }
> >
> > Then replace the above kfree() by:
> >
> >         call_srcu(&opp->rcu, kfree_opp_rcu);
> 
> Correct. But you missed the srcu which should be the first argument here :)

Indeed I did!  ;-)

> > This will require adding the following to struct device_opp:
> >
> >         struct rcu_head rcu;
> 
> We were freeing struct dev_pm_opp, and so I believe you
> wanted me to add it there? Its already there.

Fair enough!

> > All that said, I do not claim to understand the OPP code, so please take
> > the above suggested changes with a grain of salt.  And if you let me know
> > where I am confused, I should be able to offer better suggestions.
> 
> Thanks for your suggestions. I have sent the patch to list and cc'd you on
> the relevant ones. Would be great if you can review the rcu part there.

Done!

							Thanx, Paul

