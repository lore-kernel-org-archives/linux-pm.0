From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/8] opp: Introduce APIs to remove OPPs
Date: Tue, 25 Nov 2014 22:46:29 +0530
Message-ID: <CAKohponBNOm_0_rZqbVKQSoOa81CjnKb8vcfzA6gbm1+Gxn+gg@mail.gmail.com>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
	<f815d0855c1bd28d8389554176acd2620e56b3c8.1416910766.git.viresh.kumar@linaro.org>
	<20141125162434.GC5050@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35504 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbaKYRQa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 12:16:30 -0500
Received: by mail-ob0-f174.google.com with SMTP id m8so784738obr.5
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 09:16:30 -0800 (PST)
In-Reply-To: <20141125162434.GC5050@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>

On 25 November 2014 at 21:54, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> If the data is alway accessed under an SRCU read-side critical section,
> then you do need call_srcu() when freeing it -- as you pointed out,
> -with- the srcu_struct included.  ;-)

:)

> If the data is accessed under both SRCU and RCU, then things get a bit
> more involved.

Yes, that is always the case here.

>> +void __dev_pm_opp_remove(struct device_opp *dev_opp, struct dev_pm_opp *opp)
>> +{
>> +     /*
>> +      * Notify the changes in the availability of the operable
>> +      * frequency/voltage list.
>> +      */
>> +     srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_REMOVE, opp);
>> +     list_del_rcu(&opp->node);
>> +     call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, kfree_opp_rcu);
>
> I am guessing that opp->node is being removed from the list traversed
> by srcu_notifier_call_chain()...  (Looks that way below.)

I couldn't find any code in kernel which is registered for this notifier chain
yet. And so don't know what that code will do. It may not traverse the list
or it may :)

I couldn't understand this comment of yours, sorry: (Looks that way below.)

>> +
>> +     if (list_empty(&dev_opp->opp_list)) {
>
> Does the above want to be "if (!list_empty(&dev_opp->opp_list)) {"?

No. dev_opp contains list of all OPPs. When all OPPs are gone, we don't
want dev_opp anymore and so freeing it.

>> +             list_del_rcu(&dev_opp->node);
>> +             call_srcu(&dev_opp->srcu_head.srcu, &dev_opp->rcu_head,
>> +                       kfree_device_rcu);
>> +     }
>> +}

So, I am still not sure what we need to do here as we have readers with
both rcu and srcu critical regions.
