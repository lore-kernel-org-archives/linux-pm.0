From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 02/12] PM / OPP: Add 'struct kref' to OPP table
Date: Tue, 10 Jan 2017 09:53:12 +0530
Message-ID: <20170110042312.GB6332@vireshk-i7>
References: <cover.1481106919.git.viresh.kumar@linaro.org>
 <3f23949c92492ea74a7a55cd04bcd41a37592ed5.1481106919.git.viresh.kumar@linaro.org>
 <20170109233627.GU17126@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34086 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936167AbdAJEXP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Jan 2017 23:23:15 -0500
Received: by mail-pf0-f177.google.com with SMTP id 127so39635442pfg.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Jan 2017 20:23:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170109233627.GU17126@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 09-01-17, 15:36, Stephen Boyd wrote:
> On 12/07, Viresh Kumar wrote:
> > @@ -894,8 +895,36 @@ static void _kfree_device_rcu(struct rcu_head *head)
> >  	kfree_rcu(opp_table, rcu_head);
> >  }
> >  
> > -static void _free_opp_table(struct opp_table *opp_table)
> > +void _get_opp_table_kref(struct opp_table *opp_table)
> >  {
> > +	kref_get(&opp_table->kref);
> > +}
> > +
> > +struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
> > +{
> > +	struct opp_table *opp_table;
> > +
> > +	/* Hold our table modification lock here */
> > +	mutex_lock(&opp_table_lock);
> > +
> > +	opp_table = _find_opp_table(dev);
> > +	if (!IS_ERR(opp_table)) {
> > +		_get_opp_table_kref(opp_table);
> 
> It seems odd to have _get_opp_table_kref() take a pointer to
> increment a kref on.

This function is provided for better readability and passing opp_table to it is
the only option I had :)

> It would be better to have _find_opp_table()
> return the pointer with the reference already taken so that we
> don't have to update callers with reference grabbing calls.
> Typically if a function returns a reference counted pointer the
> reference counting has already been done.

Absolutely, but that happens with later patches in the series. I couldn't have
done it now, as something or the other would have broken.

-- 
viresh
