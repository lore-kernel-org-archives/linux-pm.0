From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 04/17] PM / OPP: Introduce
 dev_pm_opp_get_max_volt_latency()
Date: Mon, 18 Jan 2016 12:53:37 +0530
Message-ID: <20160118072337.GA21107@vireshk>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <08691b482198b0709fd258d310a5e6ecda2f1a18.1450777582.git.viresh.kumar@linaro.org>
 <20160112012512.GJ22188@codeaurora.org>
 <20160112051058.GJ1084@ubuntu>
 <20160112194537.GZ22188@codeaurora.org>
 <20160113053447.GB6050@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32849 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbcARHXl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2016 02:23:41 -0500
Received: by mail-pa0-f41.google.com with SMTP id cy9so429744639pac.0
        for <linux-pm@vger.kernel.org>; Sun, 17 Jan 2016 23:23:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160113053447.GB6050@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 13-01-16, 11:04, Viresh Kumar wrote:
> On 12-01-16, 11:45, Stephen Boyd wrote:
> > > + * Locking: This function takes rcu_read_lock().
> > 
> > False.
> 
> Yeah, I realized it and fixed it right after sending it:
> 
> + * Locking: This function internally uses mutex locks to keep the integrity of
> + * the internal data structures. Callers should ensure that this function is
> + * *NOT* called under RCU protection or in contexts where mutex cannot be
> + * locked.
> 
> > > +	/*
> > > +	 * Hold our list modification lock here as regulator_set_voltage_time()
> > > +	 * can possibly take another mutex, which isn't allowed within rcu
> > > +	 * locks.
> > > +	 */
> > > +	mutex_lock(&dev_opp_list_lock);
> > 
> > So now we take the list modification mutex. Why can't we
> > rcu_read_lock(), find the min and max voltage, and then release
> > the read lock and ask regulator framework for the voltage time?
> 
> That was possible before this series came in..
> 
> > From what I can tell we're just trying to make sure that the list
> > is stable when iterating through it to find the min/max voltage.
> 
> Hmm, we have pointer to regulator within the dev-opp struct. If we
> drop the lock, the dev-opp struct can get freed and regulator will be
> put just before that. So, we may be using an already freed resource.
> 
> How do you suggest we fix it ?

Ping..

-- 
viresh
