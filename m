From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/5] cpufreq: Use cpumask_copy instead of cpumask_or to
 copy a mask
Date: Tue, 13 Oct 2015 08:53:01 +0530
Message-ID: <20151013032301.GL5386@linux>
References: <cover.1444583718.git.viresh.kumar@linaro.org>
 <b8dc587ec7767b89b1d24f1348acd1a341e54a4a.1444583718.git.viresh.kumar@linaro.org>
 <561C0638.8060105@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <561C0638.8060105@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12-10-15, 12:12, Saravana Kannan wrote:
> >  	if (new_policy) {
> >  		/* related_cpus should at least include policy->cpus. */
> >-		cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
> >+		cpumask_copy(policy->related_cpus, policy->cpus);
> 
> Again, why? It actually seems wrong. A 4 core cluster could come up
> with just 2 cores when the policy is added. But the related CPUs
> would be 4 CPUs.

Firstly, the patch hasn't changed anything at all. related_cpus was
empty until this point, and orring or setting it with ->cpus will
result in the same output.

Secondly, this is what we always wanted. related_cpus should contain
the mask of all possible CPUs for that cluster.

-- 
viresh
