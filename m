From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/8] opp: Introduce APIs to remove OPPs
Date: Wed, 26 Nov 2014 23:32:26 +0100
Message-ID: <11530150.5svHxl9OuM@vostro.rjw.lan>
References: <cover.1416910766.git.viresh.kumar@linaro.org> <CAKohponz3MsgZNtm1i-aLx8kRRjJwUJjL=B3RE96EiivwXbF2A@mail.gmail.com> <CAKohpomKym9dqzQDmS-7ipze4jCYDU4_UN4a36VceHuGezoiVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60808 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750770AbaKZWLK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 17:11:10 -0500
In-Reply-To: <CAKohpomKym9dqzQDmS-7ipze4jCYDU4_UN4a36VceHuGezoiVw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>

On Wednesday, November 26, 2014 02:47:47 PM Viresh Kumar wrote:
> On 26 November 2014 at 11:59, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Also it looks like I should use call_srcu() with kfree_rcu() for
> > opp_set_availability() case as well to avoid any corner cases.
> 
> This is the diff I would be adding to this patch:

That should work if I'm not mistaken, but I'm wondering if we could
settle on using one RCU type for this (later, though).

> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index f9d80e6..3f728cd 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -506,7 +506,7 @@ static void kfree_opp_rcu(struct rcu_head *head)
>         struct dev_pm_opp *opp = container_of(head, struct dev_pm_opp,
> rcu_head);
> 
>         pr_info("%s: opp:%p, dynamic:%d\n", __func__, opp, opp->dynamic);
> -       kfree(opp);
> +       kfree_rcu(opp);
>  }
> 
>  static void kfree_device_rcu(struct rcu_head *head)
> @@ -644,7 +644,7 @@ static int opp_set_availability(struct device
> *dev, unsigned long freq,
> 
>         list_replace_rcu(&opp->node, &new_opp->node);
>         mutex_unlock(&dev_opp_list_lock);
> -       kfree_rcu(opp, rcu_head);
> +       call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, kfree_opp_rcu);
> 
>         /* Notify the change of the OPP availability */
>         if (availability_req)

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
