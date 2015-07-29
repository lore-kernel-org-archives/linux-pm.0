From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Add scaling frequency range support
Date: Wed, 29 Jul 2015 16:31:46 +0530
Message-ID: <20150729110146.GB5100@linux>
References: <55B6F7C3.8040405@intel.com>
 <20150728042945.GE1229@linux>
 <55B70ACD.9010402@intel.com>
 <15808229.KgKF05ecju@vostro.rjw.lan>
 <55B8A3F2.8030809@intel.com>
 <55B8A548.4060104@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55B8A548.4060104@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 29-07-15, 18:04, Pan Xinhui wrote:
> > @@ -622,21 +630,20 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >  static ssize_t store_##file_name                                       \
> >  (struct cpufreq_policy *policy, const char *buf, size_t count)         \
> >  {                                                                      \
> > -       int ret, temp;                                                  \
> > +       int ret;                                                        \
> >         struct cpufreq_policy new_policy;                               \
> >                                                                         \
> >         ret = cpufreq_get_policy(&new_policy, policy->cpu);             \
> >         if (ret)                                                        \
> >                 return -EINVAL;                                         \
> >                                                                         \
> > +       cpufreq_get_user_policy_freq(&policy->user_policy, &new_policy);\
> >         ret = sscanf(buf, "%u", &new_policy.object);                    \
> >         if (ret != 1)                                                   \
> >                 return -EINVAL;                                         \
> >                                                                         \
> > -       temp = new_policy.object;                                       \
> > -       ret = cpufreq_set_policy(policy, &new_policy);          \
> > -       if (!ret)                                                       \
> > -               policy->user_policy.object = temp;                      \
> > +       policy->user_policy.object = policy->object;                    \
> should be 
> +	policy->user_policy.object = new_policy.object;		\
> sorry for that.
> > +       ret = cpufreq_set_policy(policy, &new_policy);                  \

This is wrong because we save user-preference, even when we failed. So that's
surely bad.

-- 
viresh
