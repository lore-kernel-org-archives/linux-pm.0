From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH] cpufreq: Use list_is_last() to check last entry of the
 policy list
Date: Wed, 27 Jan 2016 10:10:20 +0000
Message-ID: <20160127101020.GL10898@e106622-lin>
References: <1453715167-26165-1-git-send-email-ego@linux.vnet.ibm.com>
 <20160125095029.GE3183@vireshk>
 <20160125111824.GH10898@e106622-lin>
 <20160127060923.GB28238@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160127060923.GB28238@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 27/01/16 11:39, Gautham R Shenoy wrote:
> On Mon, Jan 25, 2016 at 11:18:24AM +0000, Juri Lelli wrote:
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
> My bad! This is based on your branch  git://linux-arm.org/linux-jl.git
> upstream/cpufreq_cleanups. I found this issue while reviewing your
> cleanup patches.
> 

No problem, and thanks for reviewing those! Any feedback? :)

Best,

- Juri
