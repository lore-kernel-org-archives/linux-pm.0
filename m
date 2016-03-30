From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 7/7][Resend] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Wed, 30 Mar 2016 09:40:10 +0530
Message-ID: <20160330041010.GD8773@vireshk-i7>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <6666532.7ULg06hQ7e@vostro.rjw.lan>
 <20160328090333.GK32495@vireshk-i7>
 <2253696.9jRPsKRmxz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33344 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbcC3EKO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 00:10:14 -0400
Received: by mail-pf0-f182.google.com with SMTP id 4so31479235pfd.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Mar 2016 21:10:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2253696.9jRPsKRmxz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On 29-03-16, 14:58, Rafael J. Wysocki wrote:
> On Monday, March 28, 2016 02:33:33 PM Viresh Kumar wrote:
> > Its gonna be same for all policies sharing tunables ..
> 
> The value will be the same, but the cacheline won't.

Fair enough. So this information is replicated for each policy for performance
benefits. Would it make sense to add a comment for that? Its not obvious today
why we are keeping this per-policy.

> > > +static ssize_t rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf,
> > > +				   size_t count)
> > > +{
> > > +	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
> > > +	struct sugov_policy *sg_policy;
> > > +	unsigned int rate_limit_us;
> > > +	int ret;
> > > +
> > > +	ret = sscanf(buf, "%u", &rate_limit_us);
> > > +	if (ret != 1)
> > > +		return -EINVAL;
> > > +
> > > +	tunables->rate_limit_us = rate_limit_us;
> > > +
> > > +	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook)
> > > +		sg_policy->freq_update_delay_ns = rate_limit_us * NSEC_PER_USEC;
> > > +
> > > +	return count;
> > > +}
> > > +
> > > +static struct governor_attr rate_limit_us = __ATTR_RW(rate_limit_us);
> > 
> > Why not reuse gov_attr_rw() ?
> 
> Would it work?

Why wouldn't it? I had a look again at that and I couldn't find a reason for it
to not work. Probably I missed something.

> > > +	ret = kobject_init_and_add(&tunables->attr_set.kobj, &sugov_tunables_ktype,
> > > +				   get_governor_parent_kobj(policy), "%s",
> > > +				   schedutil_gov.name);
> > > +	if (!ret)
> > > +		goto out;
> > > +
> > > +	/* Failure, so roll back. */
> > > +	policy->governor_data = NULL;
> > > +	sugov_tunables_free(tunables);
> > > +
> > > + free_sg_policy:
> > > +	pr_err("cpufreq: schedutil governor initialization failed (error %d)\n", ret);
> > > +	sugov_policy_free(sg_policy);
> > 
> > I didn't like the way we have mixed success and failure path here, just to save
> > a single line of code (unlock).
> 
> I don't follow, sorry.  Yes, I can do unlock/return instead of the "goto out",
> but then the goto label is still needed.

Sorry for not being clear earlier, but this what I was suggesting it to look like:

---
static int sugov_init(struct cpufreq_policy *policy)
{
       struct sugov_policy *sg_policy;
       struct sugov_tunables *tunables;
       unsigned int lat;
       int ret = 0;

       /* State should be equivalent to EXIT */
       if (policy->governor_data)
               return -EBUSY;

       sg_policy = sugov_policy_alloc(policy);
       if (!sg_policy)
               return -ENOMEM;

       mutex_lock(&global_tunables_lock);

       if (global_tunables) {
               if (WARN_ON(have_governor_per_policy())) {
                       ret = -EINVAL;
                       goto free_sg_policy;
               }
               policy->governor_data = sg_policy;
               sg_policy->tunables = global_tunables;

               gov_attr_set_get(&global_tunables->attr_set, &sg_policy->tunables_hook);

       	       mutex_unlock(&global_tunables_lock);
       	       return 0;
       }

       tunables = sugov_tunables_alloc(sg_policy);
       if (!tunables) {
               ret = -ENOMEM;
               goto free_sg_policy;
       }

       tunables->rate_limit_us = LATENCY_MULTIPLIER;
       lat = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
       if (lat)
               tunables->rate_limit_us *= lat;

       if (!have_governor_per_policy())
               global_tunables = tunables;

       policy->governor_data = sg_policy;
       sg_policy->tunables = tunables;

       ret = kobject_init_and_add(&tunables->attr_set.kobj, &sugov_tunables_ktype,
                                  get_governor_parent_kobj(policy), "%s",
                                  schedutil_gov.name);
       if (!ret) {
       	       mutex_unlock(&global_tunables_lock);
       	       return 0;
       }

       /* Failure, so roll back. */
       policy->governor_data = NULL;
       sugov_tunables_free(tunables);

 free_sg_policy:
       mutex_unlock(&global_tunables_lock);

       pr_err("cpufreq: schedutil governor initialization failed (error %d)\n", ret);
       sugov_policy_free(sg_policy);

       return ret;

---

> > Over that it does things, that aren't symmetric anymore. For example, we have
> > called sugov_policy_alloc() without locks
> 
> Are you sure?

Yes.

> > and are freeing it from within locks.
> 
> Both are under global_tunables_lock.

No, sugov_policy_alloc() isn't called from within locks.

> > > +static int __init sugov_module_init(void)
> > > +{
> > > +	return cpufreq_register_governor(&schedutil_gov);
> > > +}
> > > +
> > > +static void __exit sugov_module_exit(void)
> > > +{
> > > +	cpufreq_unregister_governor(&schedutil_gov);
> > > +}
> > > +
> > > +MODULE_AUTHOR("Rafael J. Wysocki <rafael.j.wysocki@intel.com>");
> > > +MODULE_DESCRIPTION("Utilization-based CPU frequency selection");
> > > +MODULE_LICENSE("GPL");
> > 
> > Maybe a MODULE_ALIAS as well ?
> 
> Sorry, I don't follow.

Oh, I was just saying that we may also want to add a MODULE_ALIAS() line here
to help auto-loading if it is built as a module?

-- 
viresh
