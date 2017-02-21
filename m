From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC][PATCH] cpufreq: User/admin documentation update and
 consolidation
Date: Tue, 21 Feb 2017 10:30:10 +0530
Message-ID: <20170221050010.GW21911@vireshk-i7>
References: <6949552.t0rZsBY3Lp@aspire.rjw.lan>
 <20170220095608.GS21911@vireshk-i7>
 <4488503.27M9KJWnWE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4488503.27M9KJWnWE@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 20-02-17, 14:58, Rafael J. Wysocki wrote:
> Yes, it is called for new and inactive policies.
> 
> For new policies it has to populate policy->cpus (because otherwise the core
> doesn't know what CPUs should be there), which quite arguably doesn't have
> to (or even doesn't need to) be done for inactive policies (because they already
> have policy->real_cpus and policy->related_cpus populated).
 
> I would even argue that ->init() should not update policy->cpus for inactive
> (but not new) policies.

I agree, but I am not aware of any platforms that we have today which
does any similar checks in ->init(). And I wouldn't encourage drivers
to have such special handling at all. Why make it complex?

The way you have written it earlier suggests that the drivers should
check if the policy is active or not (by looking at related_cpus mask)
and set the cpus mask only for new policies. I was just worried that
new driver authors will actually try to write special code in init()
for that and if we really want that to be the case.

-- 
viresh
