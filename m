From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Use list_is_last() to check last entry of the
 policy list
Date: Mon, 25 Jan 2016 16:52:15 +0530
Message-ID: <20160125112215.GB9155@vireshk>
References: <1453715167-26165-1-git-send-email-ego@linux.vnet.ibm.com>
 <20160125095029.GE3183@vireshk>
 <20160125111824.GH10898@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33107 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208AbcAYLWS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2016 06:22:18 -0500
Received: by mail-pf0-f180.google.com with SMTP id e65so81065508pfe.0
        for <linux-pm@vger.kernel.org>; Mon, 25 Jan 2016 03:22:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160125111824.GH10898@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

On 25-01-16, 11:18, Juri Lelli wrote:
> Hi,
> 
> On 25/01/16 15:20, Viresh Kumar wrote:
> > On 25-01-16, 15:16, Gautham R. Shenoy wrote:
> > > Currently next_policy() explicitly checks if a policy is the last
> > > policy in the cpufreq_policy_list. Use the standard list_is_last
> > > primitive instead.
> > > 
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > > ---
> > >  drivers/cpufreq/cpufreq.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 78b1e2f..b3059a3 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -67,11 +67,11 @@ static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
> > >  {
> > >  	lockdep_assert_held(&cpufreq_driver_lock);
> 
> Which branch is this patch based on?

Dude, what's going on here? How come you rebased on Juri's patches ?
:)

-- 
viresh
