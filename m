From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: Use list_is_last() to check last entry of the
 policy list
Date: Wed, 27 Jan 2016 11:27:51 +0530
Message-ID: <20160127055751.GA28238@in.ibm.com>
References: <1453715167-26165-1-git-send-email-ego@linux.vnet.ibm.com>
 <20160125095029.GE3183@vireshk>
 <20160125111824.GH10898@e106622-lin>
 <20160125112215.GB9155@vireshk>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:35334 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbcA0F6B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2016 00:58:01 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Tue, 26 Jan 2016 22:57:59 -0700
Content-Disposition: inline
In-Reply-To: <20160125112215.GB9155@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@arm.com>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

On Mon, Jan 25, 2016 at 04:52:15PM +0530, Viresh Kumar wrote:
> On 25-01-16, 11:18, Juri Lelli wrote:
> > Hi,
> > 
> > On 25/01/16 15:20, Viresh Kumar wrote:
> > > On 25-01-16, 15:16, Gautham R. Shenoy wrote:
> > > > Currently next_policy() explicitly checks if a policy is the last
> > > > policy in the cpufreq_policy_list. Use the standard list_is_last
> > > > primitive instead.
> > > > 
> > > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > > > ---
> > > >  drivers/cpufreq/cpufreq.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index 78b1e2f..b3059a3 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -67,11 +67,11 @@ static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
> > > >  {
> > > >  	lockdep_assert_held(&cpufreq_driver_lock);
> > 
> > Which branch is this patch based on?
> 
> Dude, what's going on here? How come you rebased on Juri's patches ?
> :)

Ah right! I found this issue while reviewing Juri's patches from the
cpufreq-cleanups branch and didn't switch back to pm-next before
making this change. Shall resend the patch.

> 
> -- 
> viresh
> 

--
Thanks and Regards
gautham.

