From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 04/17] PM / OPP: Introduce
 dev_pm_opp_get_max_volt_latency()
Date: Wed, 20 Jan 2016 16:20:32 -0800
Message-ID: <20160121002032.GD12841@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <08691b482198b0709fd258d310a5e6ecda2f1a18.1450777582.git.viresh.kumar@linaro.org>
 <20160112012512.GJ22188@codeaurora.org>
 <20160112051058.GJ1084@ubuntu>
 <20160112194537.GZ22188@codeaurora.org>
 <20160113053447.GB6050@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52692 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbcAUAUe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 19:20:34 -0500
Content-Disposition: inline
In-Reply-To: <20160113053447.GB6050@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 01/13, Viresh Kumar wrote:
> On 12-01-16, 11:45, Stephen Boyd wrote:
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
> 

Ok, first off, I don't understand why the regulator and clock
pointers are in the struct device_opp instead of the struct
device_list_opp. I thought we wanted to make it possible for two
devices to share the same OPP table (device_opp), but have
physically different clocks and regulators (non opp-shared case)?
If we put the clock and regulator handles in the device_opp then
the opp table is limited to one device or a set of devices that
all share the same clock and regulators.

BTW, these structure names confuse me all the time. I have to
rename dev_pm_opp to opp_entry, device_opp to opp_table, and
device_list_opp to opp_device_list in my head for anything to
make sense.

Gripes aside, the clock and regulator pointers should never be
'put' and go away until the device driver that's using the
dev_pm_opp_set_rate() API has called dev_pm_opp_remove(). So any
concerns about that happening during an OPP switch aren't the
concern of the OPP framework, but the concern of the consumer
drivers having the proper locking and tear down sequences.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
