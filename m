From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Revert "cpufreq: pcc-cpufreq: update default value of
 cpuinfo_transition_latency"
Date: Fri, 22 Jul 2016 08:36:56 -0700
Message-ID: <20160722153656.GR3122@ubuntu>
References: <20160722151411.GB11711@suselix.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160722151411.GB11711@suselix.suse.de>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andreas Herrmann <aherrmann@suse.com>
Cc: Jacob Tanenbaum <jtanenba@redhat.com>, stable@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22-07-16, 17:14, Andreas Herrmann wrote:
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index a7ecb9a..3f0ce2a 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -555,8 +555,6 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	policy->min = policy->cpuinfo.min_freq =
>  		ioread32(&pcch_hdr->minimum_frequency) * 1000;
>  
> -	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
> -
>  	pr_debug("init: policy->max is %d, policy->min is %d\n",
>  		policy->max, policy->min);
>  out:

Hi Rafael,

I am very confused on this, can you help me understand ?

- CPUFREQ_ETERNAL = -1
- unsigned int transition_latency = CPUFREQ_ETERNAL, will set it to UINT_MAX.
- Many drivers do it today

cpufreq.c

	if (policy->governor->max_transition_latency &&
	    policy->cpuinfo.transition_latency >
	    policy->governor->max_transition_latency) {

- And this check will always fail, unless max_transition_latency is zero.

What am I missing ?

-- 
viresh
