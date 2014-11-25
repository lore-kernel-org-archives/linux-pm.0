From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] opp: convert dev_warn() to dev_dbg() for duplicate OPPs
Date: Tue, 25 Nov 2014 16:07:35 +0530
Message-ID: <CAKohpo=dDTAV=B0CvCqD1H-QGuQ+i2w5Lfr3egpWzrvRYVNWmw@mail.gmail.com>
References: <7017fa592bdaf73c260ad001a2b7abdc8d14f08a.1416211616.git.viresh.kumar@linaro.org>
	<5171628.FRGslOuEb6@vostro.rjw.lan>
	<CAKohpomz_UiRErSsDPLWcmU4e7ocXZZu7bwCF8TvoSJupikd7A@mail.gmail.com>
	<42965945.ST26GKfzPz@vostro.rjw.lan>
	<20141124161435.GE5050@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:47204 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbaKYKhg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 05:37:36 -0500
Received: by mail-oi0-f54.google.com with SMTP id u20so192170oif.27
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2014 02:37:35 -0800 (PST)
In-Reply-To: <20141124161435.GE5050@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stefan Wahren <stefan.wahren@i2se.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 24 November 2014 at 21:44, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> As Rafael says, if opp is reachable by RCU readers, you cannot just
> immediately kfree() it.  Immediately kfree()ing it like this -will-
> cause your RCU readers to see freed memory, which, as you noted, can
> cause crashes.

In order to reply you at some level, I tried going through RCU documentation
today before replying anymore. And yes I understood this part.

> Except that srcu_notifier_call_chain() involves SRCU readers.  So,
> unless I am confused, you instead need something like this:
>
> static void kfree_opp_rcu(struct rcu_head *rhp)
> {
>         struct device_opp *opp = container_of(rhp, struct device_opp, opp_list);
>
>         kfree(opp);
> }
>
> Then replace the above kfree() by:
>
>         call_srcu(&opp->rcu, kfree_opp_rcu);

Correct. But you missed the srcu which should be the first argument here :)

> This will require adding the following to struct device_opp:
>
>         struct rcu_head rcu;

We were freeing struct dev_pm_opp, and so I believe you
wanted me to add it there? Its already there.

> All that said, I do not claim to understand the OPP code, so please take
> the above suggested changes with a grain of salt.  And if you let me know
> where I am confused, I should be able to offer better suggestions.

Thanks for your suggestions. I have sent the patch to list and cc'd you on
the relevant ones. Would be great if you can review the rcu part there.

--
viresh
