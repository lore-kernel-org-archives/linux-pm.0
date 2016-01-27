From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RESEND] cpufreq: Use list_is_last() to check last entry of the policy list
Date: Wed, 27 Jan 2016 23:55:37 +0100
Message-ID: <3098333.ng4zWfoJhM@vostro.rjw.lan>
References: <1453715167-26165-1-git-send-email-ego@linux.vnet.ibm.com> <1453876346-21869-1-git-send-email-ego@linux.vnet.ibm.com> <20160127063611.GM3322@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160127063611.GM3322@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Juri Lelli <Lelli" <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 27, 2016 12:06:11 PM Viresh Kumar wrote:
> On 27-01-16, 12:02, Gautham R. Shenoy wrote:
> > Currently next_policy() explicitly checks if a policy is the last
> > policy in the cpufreq_policy_list. Use the standard list_is_last
> > primitive instead.
> > 
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> > The earlier version one was based on an Juri's experimental branch. 
> > I have based this one on linux-pm.git linux-next branch.
> > 
> >  drivers/cpufreq/cpufreq.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index c35e7da..e979ec7 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -48,11 +48,11 @@ static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
> >  					  bool active)
> >  {
> >  	do {
> > -		policy = list_next_entry(policy, policy_list);
> > -
> >  		/* No more policies in the list */
> > -		if (&policy->policy_list == &cpufreq_policy_list)
> > +		if (list_is_last(&policy->policy_list, &cpufreq_policy_list))
> >  			return NULL;
> > +
> > +		policy = list_next_entry(policy, policy_list);
> >  	} while (!suitable_policy(policy, active));
> >  
> >  	return policy;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

Rafael
