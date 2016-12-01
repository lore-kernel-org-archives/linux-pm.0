From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V5] PM / OPP: Pass opp_table to dev_pm_opp_put_regulator()
Date: Thu, 01 Dec 2016 15:28:53 +0100
Message-ID: <2821348.smmieO54J1@aspire.rjw.lan>
References: <480ae6e161788d338fb1637aa2615a75588ac3c6.1480478081.git.viresh.kumar@linaro.org> <20161130220019.GK6095@codeaurora.org> <20161201002548.GO3288@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61803 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753456AbcLAOc2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Dec 2016 09:32:28 -0500
In-Reply-To: <20161201002548.GO3288@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, jy0922.shim@samsung.com, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "# v4 . 4+" <stable@vger.kernel.org>

On Thursday, December 01, 2016 05:55:48 AM Viresh Kumar wrote:
> On 30-11-16, 14:00, Stephen Boyd wrote:
> > On 11/30, Viresh Kumar wrote:
> > > From: Stephen Boyd <sboyd@codeaurora.org>
> > > 
> > > Joonyoung Shim reported an interesting problem on his ARM octa-core
> > > Odoroid-XU3 platform. During system suspend, dev_pm_opp_put_regulator()
> > > was failing for a struct device for which dev_pm_opp_set_regulator() is
> > > called earlier.
> > > 
> > > This happened because an earlier call to
> > > dev_pm_opp_of_cpumask_remove_table() function (from cpufreq-dt.c file)
> > > removed all the entries from opp_table->dev_list apart from the last CPU
> > > device in the cpumask of CPUs sharing the OPP.
> > > 
> > > But both dev_pm_opp_set_regulator() and dev_pm_opp_put_regulator()
> > > routines get CPU device for the first CPU in the cpumask. And so the OPP
> > > core failed to find the OPP table for the struct device.
> > > 
> > > This patch attempts to fix this problem by returning a pointer to the
> > > opp_table from dev_pm_opp_set_regulator() and using that as the
> > > parameter to dev_pm_opp_put_regulator(). This ensures that the
> > > dev_pm_opp_put_regulator() doesn't fail to find the opp table.
> > > 
> > > Note that similar design problem also exists with other
> > > dev_pm_opp_put_*() APIs, but those aren't used currently by anyone and
> > > so we don't need to update them for now.
> > > 
> > > [Viresh]: Written commit log and tested on exynos 5250.
> > > 
> > > Cc: # v4.4+ <stable@vger.kernel.org>
> > > Reported-by: Joonyoung Shim <jy0922.shim@samsung.com>
> > > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > 
> > You should have asked for my Signed-off-by instead of just adding
> > it.
> 
> I was worried about the 24 hrs that gets wasted because of 12 hrs
> difference in our time zones and so added you as the author and added
> your sob. :)
> 
> > Here it is to make things explicit and recorded:

Applied.

Thanks,
Rafael

