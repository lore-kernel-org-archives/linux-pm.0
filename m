From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
Subject: Re: [PATCH v2] cpufreq: cppc_cpufreq: Initialize shared cpu's perf
 capabilities
Date: Fri, 6 Apr 2018 01:21:05 +0000
Message-ID: <1522977662.9269.2.camel@hxt-semitech.com>
References: <1522833380-18438-1-git-send-email-shunyong.yang@hxt-semitech.com>
         <20180404103600.GJ3572@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180404103600.GJ3572@vireshk-i7>
Content-Language: en-US
Content-ID: <F506D0A0E171724EAF0F80231DBE0920@hxt-semitech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zheng, Joey" <yu.zheng@hxt-semitech.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

Hi, Kumar,

On Wed, 2018-04-04 at 16:06 +0530, Viresh Kumar wrote:
> On 04-04-18, 17:16, Shunyong Yang wrote:
> > 
> > When multiple cpus are related in one cpufreq policy, the first
> > online
> > cpu will be chosen by default to handle cpufreq operations. Let's
> > take
> > cpu0 and cpu1 as an example.
> > 
> > When cpu0 is offline, policy->cpu will be shifted to cpu1. Cpu1's
> > perf
> > capabilities should be initialized. Otherwise, perf capabilities
> > are 0s
> > and speed change can not take effect.
> > 
> > This patch copies perf capabilities of the first online cpu to
> > other
> > shared cpus when policy shared type is CPUFREQ_SHARED_TYPE_ANY.
> > 
> > Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
> > Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> > ---
> > 
> > Changes in v2:
> >   -Add unlikely in cpu comparison per Kumar's comments.
> >   -Fix coding style per Kumar's comments.
> > 
> > Changes in v1:
> >   -Drop RFC tag,
> >      The original RFC link,
> >      https://patchwork.kernel.org/patch/10299055/.
> > 
> >      This patch solves same issue as RFC above.
> > 
> >      Patch name is changed as code is too much different with RFC
> > above.
> > 
> >   -Remove extra init() per Viresh Kumar's comments and only handle
> >    CPPC CPUFREQ_SHARED_TYPE_ANY case.
> > 
> > ---
> >  drivers/cpufreq/cppc_cpufreq.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cppc_cpufreq.c
> > b/drivers/cpufreq/cppc_cpufreq.c
> > index 8f7b21a4d537..679e43b9c980 100644
> > --- a/drivers/cpufreq/cppc_cpufreq.c
> > +++ b/drivers/cpufreq/cppc_cpufreq.c
> > @@ -164,9 +164,20 @@ static int cppc_cpufreq_cpu_init(struct
> > cpufreq_policy *policy)
> >  	policy->cpuinfo.transition_latency =
> > cppc_get_transition_latency(cpu_num);
> >  	policy->shared_type = cpu->shared_type;
> >  
> > -	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
> > +	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
> > +		int i;
> > +
> >  		cpumask_copy(policy->cpus, cpu->shared_cpu_map);
> > -	else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
> > +
> > +		for_each_cpu(i, policy->cpus) {
> > +			if (unlikely(i == policy->cpu))
> > +				continue;
> > +
> > +			memcpy(&all_cpu_data[i]->perf_caps,
> > +			       &cpu->perf_caps,
> > +			       sizeof(cpu->perf_caps));
> I think this can be written in two lines without violating the 80
> columns rule.

I think you mean change like following?

     memcpy(&all_cpu_data[i]->perf_caps, &cpu->perf_caps,
            sizeof(cpu->perf_caps));

I will send v3 to change this.

Thanks.
Shunyong.

> 
> > 
> > +		}
> > +	} else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL)
> > {
> >  		/* Support only SW_ANY for now. */
> >  		pr_debug("Unsupported CPU co-ord type\n");
> >  		return -EFAULT;
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
