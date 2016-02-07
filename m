From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: governor: Rearrange governor data structures
Date: Sun, 7 Feb 2016 21:24:53 +0530
Message-ID: <20160207155452.GI3808@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <2998470.K7oslgfuja@vostro.rjw.lan>
 <2710262.Af7Ngczbqf@vostro.rjw.lan>
 <20160207154556.GG3808@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160207154556.GG3808@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 07-02-16, 21:15, Viresh Kumar wrote:
> On 07-02-16, 16:24, Rafael J. Wysocki wrote:
> >  static int cpufreq_governor_exit(struct cpufreq_policy *policy)
> >  {
> >  	struct dbs_governor *gov = dbs_governor_of(policy);
> > -	struct dbs_data *dbs_data = policy->governor_data;
> > -	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
> > +	struct policy_dbs_info *policy_dbs = policy->governor_data;
> > +	struct dbs_data *dbs_data = policy_dbs->dbs_data;
> >  
> >  	/* State should be equivalent to INIT */
> > -	if (!cdbs->policy_dbs || cdbs->policy_dbs->policy)
> > +	if (policy_dbs->policy)
> >  		return -EBUSY;
> 
> We can crash here if policy_dbs is NULL, which can happen if EXIT is called
> twice (due to the lock-dropping thing in cpufreq-core). So we really need to
> keep these checks for now atleast.

Well no, things have changed now a bit with your recent changes and so this
wouldn't be an issue here. Sorry for the noise.

-- 
viresh
