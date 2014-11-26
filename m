From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/8] opp: Introduce APIs to remove OPPs
Date: Wed, 26 Nov 2014 11:59:43 +0530
Message-ID: <CAKohponz3MsgZNtm1i-aLx8kRRjJwUJjL=B3RE96EiivwXbF2A@mail.gmail.com>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
	<f815d0855c1bd28d8389554176acd2620e56b3c8.1416910766.git.viresh.kumar@linaro.org>
	<20141125162434.GC5050@linux.vnet.ibm.com>
	<CAKohponBNOm_0_rZqbVKQSoOa81CjnKb8vcfzA6gbm1+Gxn+gg@mail.gmail.com>
	<20141125173943.GG5050@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:64131 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbaKZG3o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 01:29:44 -0500
Received: by mail-oi0-f51.google.com with SMTP id e131so1578131oig.24
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 22:29:43 -0800 (PST)
In-Reply-To: <20141125173943.GG5050@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>

On 25 November 2014 at 23:09, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Tue, Nov 25, 2014 at 10:46:29PM +0530, Viresh Kumar wrote:

>> I couldn't find any code in kernel which is registered for this notifier chain
>> yet. And so don't know what that code will do. It may not traverse the list
>> or it may :)
>
> I would guess that the srcu_notifier_chain_register() in
> devfreq_register_opp_notifier() is adding to the call chain, but I
> do not claim to understand this code.  The srcu_notifier_call_chain()
> above is traversing it.

Actually I searched for who is calling devfreq_register_opp_notifier() and
couldn't notice any callers. But there was one from within devfreq.c and
that was called from exynos code..

So yes, it is used and I was wrong. Ultimately update_devfreq() would
be called from the notifier chain and that may try to change the freq and
so is sleep-able.

>> So, I am still not sure what we need to do here as we have readers with
>> both rcu and srcu critical regions.
>
> Well, the most straightforward approach from an RCU perspective would
> be to make all the readers use the same flavor of RCU.  From Rafael's
> earlier note, I am guessing that some of the code paths absolutely
> require SRCU.  Of course, if all the readers use SRCU, then you can
> simply free using SRCU.

Yeah, so the update_devfreq() call surely requires SRCU.

> You -can- handle situations having more than one type of reader, but
> this requires waiting for all corresponding flavors of grace period.
> This turns out to be fairly simple in this case, for example, have your
> kfree_opp_rcu() function invoke kfree_rcu() instead of kfree().

Hmm, I see.

> But I strongly recommend gaining a full understanding of the code first.
> You can dig yourself a really deep hole really quickly by patching code
> without understanding it!  And apologies if you really do already fully
> understand the code, but your statement above leads me to believe that
> you do not yet fully understand it.

I wouldn't claim to know every part of these frameworks (OPP, Devfreq),
but the maintenance of the nodes/lists is what I understand well.

But yeah, I understand you are worried about. Pushing more bugs for
solving one.

>         I couldn't find any code in kernel which is registered for this
>         notifier chain yet. And so don't know what that code will do. It
>         may not traverse the list or it may :)
>
> One thing that can help internalize code (relatively) quickly is to
> get a large piece of paper and to draw the relationships of the data
> structures first and the relationship of the code later.  When the
> drawing gets too messy, start over with a clean sheet of paper.

Thanks for your suggestions Paul. I was able to do it without a pen
and paper this time as it wasn't that complex. But yes this pen-paper
things really works while working on complex stuff. I found a memory
leak Bug in scheduling domains creation code earlier that way :)

Also it looks like I should use call_srcu() with kfree_rcu() for
opp_set_availability() case as well to avoid any corner cases.

Thanks for your time and help. Really appreciate that :)

--
viresh
