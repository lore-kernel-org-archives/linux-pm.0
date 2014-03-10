From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH] cpufreq: Reformat printk() statement
Date: Mon, 10 Mar 2014 09:35:20 -0700
Message-ID: <f29b7db5-e5a2-48d8-ae42-8ec562c4c4f6@CO9EHSMHS025.ehs.local>
References: <1394127279-29871-1-git-send-email-soren.brinkmann@xilinx.com>
 <CAKohpo=E2PAD7XNm4y3tXv6-ArPCj+8RG-WsJLOfvJoZ7EkstQ@mail.gmail.com>
 <1394424432.30791.11.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1394424432.30791.11.camel@joe-AO722>
Sender: cpufreq-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Joe,

On Sun, 2014-03-09 at 09:07PM -0700, Joe Perches wrote:
> On Mon, 2014-03-10 at 11:53 +0800, Viresh Kumar wrote:
> > On 7 March 2014 01:34, Soren Brinkmann <soren.brinkmann@xilinx.com>=
 wrote:
> > > Reformat a printk statement to:
> > >  - use pr_warn
> > >  - bring the whole string into a single line in favor of being ab=
le to
> > >    grep for the message (ignoring the 80 char limit)
> > >
> > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> []
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>=20
> A more comprehensive patch would be to:
>=20
> Add missing newlines
> Coalesce format fragments
> Convert printks to pr_<level>
> Align arguments

I agree. But I didn't want to spend time on "fixing" formatting without
knowing it will be accepted. Also, I was grepping for the message I
ended up changing because on an issue I actually needed to fix.

Do you want me to squash your changes into the patch I submitted? Or do
you wanna pick up mine and submit your patch?

	Thanks,
	S=C3=B6ren

> ---
>  drivers/cpufreq/cpufreq.c | 85 ++++++++++++++++++++++---------------=
----------
>  1 file changed, 40 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 56b7b1b..c2d06e9 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -181,8 +181,8 @@ unsigned int cpufreq_generic_get(unsigned int cpu=
)
>  	struct cpufreq_policy *policy =3D per_cpu(cpufreq_cpu_data, cpu);
> =20
>  	if (!policy || IS_ERR(policy->clk)) {
> -		pr_err("%s: No %s associated to cpu: %d\n", __func__,
> -				policy ? "clk" : "policy", cpu);
> +		pr_err("%s: No %s associated to cpu: %d\n",
> +		       __func__, policy ? "clk" : "policy", cpu);
>  		return 0;
>  	}
> =20
> @@ -254,15 +254,15 @@ static void adjust_jiffies(unsigned long val, s=
truct cpufreq_freqs *ci)
>  	if (!l_p_j_ref_freq) {
>  		l_p_j_ref =3D loops_per_jiffy;
>  		l_p_j_ref_freq =3D ci->old;
> -		pr_debug("saving %lu as reference value for loops_per_jiffy; "
> -			"freq is %u kHz\n", l_p_j_ref, l_p_j_ref_freq);
> +		pr_debug("saving %lu as reference value for loops_per_jiffy; freq =
is %u kHz\n",
> +			 l_p_j_ref, l_p_j_ref_freq);
>  	}
>  	if ((val =3D=3D CPUFREQ_POSTCHANGE && ci->old !=3D ci->new) ||
>  	    (val =3D=3D CPUFREQ_RESUMECHANGE || val =3D=3D CPUFREQ_SUSPENDC=
HANGE)) {
>  		loops_per_jiffy =3D cpufreq_scale(l_p_j_ref, l_p_j_ref_freq,
>  								ci->new);
> -		pr_debug("scaling loops_per_jiffy to %lu "
> -			"for frequency %u kHz\n", loops_per_jiffy, ci->new);
> +		pr_debug("scaling loops_per_jiffy to %lu for frequency %u kHz\n",
> +			 loops_per_jiffy, ci->new);
>  	}
>  }
>  #else
> @@ -282,7 +282,7 @@ static void __cpufreq_notify_transition(struct cp=
ufreq_policy *policy,
> =20
>  	freqs->flags =3D cpufreq_driver->flags;
>  	pr_debug("notification %u of frequency transition to %u kHz\n",
> -		state, freqs->new);
> +		 state, freqs->new);
> =20
>  	switch (state) {
> =20
> @@ -294,9 +294,8 @@ static void __cpufreq_notify_transition(struct cp=
ufreq_policy *policy,
>  		if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
>  			if ((policy) && (policy->cpu =3D=3D freqs->cpu) &&
>  			    (policy->cur) && (policy->cur !=3D freqs->old)) {
> -				pr_debug("Warning: CPU frequency is"
> -					" %u, cpufreq assumed %u kHz.\n",
> -					freqs->old, policy->cur);
> +				pr_debug("Warning: CPU frequency is %u, cpufreq assumed %u kHz\n=
",
> +					 freqs->old, policy->cur);
>  				freqs->old =3D policy->cur;
>  			}
>  		}
> @@ -307,8 +306,8 @@ static void __cpufreq_notify_transition(struct cp=
ufreq_policy *policy,
> =20
>  	case CPUFREQ_POSTCHANGE:
>  		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
> -		pr_debug("FREQ: %lu - CPU: %lu", (unsigned long)freqs->new,
> -			(unsigned long)freqs->cpu);
> +		pr_debug("FREQ: %lu - CPU: %lu\n",
> +			 (unsigned long)freqs->new, (unsigned long)freqs->cpu);
>  		trace_cpu_frequency(freqs->new, freqs->cpu);
>  		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
>  				CPUFREQ_POSTCHANGE, freqs);
> @@ -368,13 +367,13 @@ static ssize_t store_boost(struct kobject *kobj=
, struct attribute *attr,
>  		return -EINVAL;
> =20
>  	if (cpufreq_boost_trigger_state(enable)) {
> -		pr_err("%s: Cannot %s BOOST!\n", __func__,
> -		       enable ? "enable" : "disable");
> +		pr_err("%s: Cannot %s BOOST!\n",
> +		       __func__, enable ? "enable" : "disable");
>  		return -EINVAL;
>  	}
> =20
> -	pr_debug("%s: cpufreq BOOST %s\n", __func__,
> -		 enable ? "enabled" : "disabled");
> +	pr_debug("%s: cpufreq BOOST %s\n",
> +		 __func__, enable ? "enabled" : "disabled");
> =20
>  	return count;
>  }
> @@ -1184,7 +1183,7 @@ static int __cpufreq_add_dev(struct device *dev=
, struct subsys_interface *sif,
>  	if (gov) {
>  		policy->governor =3D gov;
>  		pr_debug("Restoring governor %s for cpu %d\n",
> -		       policy->governor->name, cpu);
> +			 policy->governor->name, cpu);
>  	}
>  #endif
> =20
> @@ -1263,7 +1262,7 @@ static int cpufreq_nominate_new_policy_cpu(stru=
ct cpufreq_policy *policy,
>  	sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
>  	ret =3D kobject_move(&policy->kobj, &cpu_dev->kobj);
>  	if (ret) {
> -		pr_err("%s: Failed to move kobj: %d", __func__, ret);
> +		pr_err("%s: Failed to move kobj: %d\n", __func__, ret);
> =20
>  		down_write(&policy->rwsem);
>  		cpumask_set_cpu(old_cpu, policy->cpus);
> @@ -1331,7 +1330,7 @@ static int __cpufreq_remove_dev_prepare(struct =
device *dev,
> =20
>  			if (!frozen) {
>  				pr_debug("%s: policy Kobject moved to cpu: %d from: %d\n",
> -						__func__, new_cpu, cpu);
> +					 __func__, new_cpu, cpu);
>  			}
>  		}
>  	}
> @@ -1371,7 +1370,7 @@ static int __cpufreq_remove_dev_finish(struct d=
evice *dev,
>  					CPUFREQ_GOV_POLICY_EXIT);
>  			if (ret) {
>  				pr_err("%s: Failed to exit governor\n",
> -						__func__);
> +				       __func__);
>  				return ret;
>  			}
>  		}
> @@ -1399,7 +1398,7 @@ static int __cpufreq_remove_dev_finish(struct d=
evice *dev,
>  			if ((ret =3D __cpufreq_governor(policy, CPUFREQ_GOV_START)) ||
>  					(ret =3D __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS))) {
>  				pr_err("%s: Failed to start governor\n",
> -						__func__);
> +				       __func__);
>  				return ret;
>  			}
>  		}
> @@ -1456,8 +1455,8 @@ static void cpufreq_out_of_sync(unsigned int cp=
u, unsigned int old_freq,
>  	struct cpufreq_freqs freqs;
>  	unsigned long flags;
> =20
> -	pr_debug("Warning: CPU frequency out of sync: cpufreq and timing "
> -	       "core thinks of %u, is %u kHz.\n", old_freq, new_freq);
> +	pr_debug("Warning: CPU frequency out of sync: cpufreq and timing co=
re thinks of %u, is %u kHz\n",
> +		 old_freq, new_freq);
> =20
>  	freqs.old =3D old_freq;
>  	freqs.new =3D new_freq;
> @@ -1598,8 +1597,8 @@ static int cpufreq_bp_suspend(void)
>  	if (cpufreq_driver->suspend) {
>  		ret =3D cpufreq_driver->suspend(policy);
>  		if (ret)
> -			printk(KERN_ERR "cpufreq: suspend failed in ->suspend "
> -					"step on CPU %u\n", policy->cpu);
> +			pr_err("suspend failed in ->suspend step on CPU %u\n",
> +			       policy->cpu);
>  	}
> =20
>  	cpufreq_cpu_put(policy);
> @@ -1636,8 +1635,8 @@ static void cpufreq_bp_resume(void)
>  	if (cpufreq_driver->resume) {
>  		ret =3D cpufreq_driver->resume(policy);
>  		if (ret) {
> -			printk(KERN_ERR "cpufreq: resume failed in ->resume "
> -					"step on CPU %u\n", policy->cpu);
> +			pr_err("resume failed in ->resume step on CPU %u\n",
> +			       policy->cpu);
>  			goto fail;
>  		}
>  	}
> @@ -1767,7 +1766,7 @@ int __cpufreq_driver_target(struct cpufreq_poli=
cy *policy,
>  		target_freq =3D policy->min;
> =20
>  	pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kHz\=
n",
> -			policy->cpu, target_freq, relation, old_target_freq);
> +		 policy->cpu, target_freq, relation, old_target_freq);
> =20
>  	/*
>  	 * This might look like a redundant call as we are checking it agai=
n
> @@ -1812,8 +1811,7 @@ int __cpufreq_driver_target(struct cpufreq_poli=
cy *policy,
>  			freqs.flags =3D 0;
> =20
>  			pr_debug("%s: cpu: %d, oldfreq: %u, new freq: %u\n",
> -					__func__, policy->cpu, freqs.old,
> -					freqs.new);
> +				 __func__, policy->cpu, freqs.old, freqs.new);
> =20
>  			cpufreq_notify_transition(policy, &freqs,
>  					CPUFREQ_PRECHANGE);
> @@ -1822,7 +1820,7 @@ int __cpufreq_driver_target(struct cpufreq_poli=
cy *policy,
>  		retval =3D cpufreq_driver->target_index(policy, index);
>  		if (retval)
>  			pr_err("%s: Failed to change cpu frequency: %d\n",
> -					__func__, retval);
> +			       __func__, retval);
> =20
>  		if (notify)
>  			cpufreq_notify_post_transition(policy, &freqs, retval);
> @@ -1874,11 +1872,8 @@ static int __cpufreq_governor(struct cpufreq_p=
olicy *policy,
>  		if (!gov)
>  			return -EINVAL;
>  		else {
> -			printk(KERN_WARNING "%s governor failed, too long"
> -			       " transition latency of HW, fallback"
> -			       " to %s governor\n",
> -			       policy->governor->name,
> -			       gov->name);
> +			pr_warn("%s governor failed, too long transition latency of HW, f=
allback to %s governor\n",
> +				policy->governor->name, gov->name);
>  			policy->governor =3D gov;
>  		}
>  	}
> @@ -1888,7 +1883,7 @@ static int __cpufreq_governor(struct cpufreq_po=
licy *policy,
>  			return -EINVAL;
> =20
>  	pr_debug("__cpufreq_governor for CPU %u, event %u\n",
> -						policy->cpu, event);
> +		 policy->cpu, event);
> =20
>  	mutex_lock(&cpufreq_governor_lock);
>  	if ((policy->governor_enabled && event =3D=3D CPUFREQ_GOV_START)
> @@ -2020,8 +2015,8 @@ static int cpufreq_set_policy(struct cpufreq_po=
licy *policy,
>  	struct cpufreq_governor *old_gov;
>  	int ret;
> =20
> -	pr_debug("setting new policy for CPU %u: %u - %u kHz\n", new_policy=
->cpu,
> -		new_policy->min, new_policy->max);
> +	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
> +		 new_policy->cpu, new_policy->min, new_policy->max);
> =20
>  	memcpy(&new_policy->cpuinfo, &policy->cpuinfo, sizeof(policy->cpuin=
fo));
> =20
> @@ -2057,7 +2052,7 @@ static int cpufreq_set_policy(struct cpufreq_po=
licy *policy,
>  	policy->max =3D new_policy->max;
> =20
>  	pr_debug("new min and max freqs are %u - %u kHz\n",
> -					policy->min, policy->max);
> +		 policy->min, policy->max);
> =20
>  	if (cpufreq_driver->setpolicy) {
>  		policy->policy =3D new_policy->policy;
> @@ -2145,7 +2140,7 @@ int cpufreq_update_policy(unsigned int cpu)
>  		}
> =20
>  		if (!policy->cur) {
> -			pr_debug("Driver did not initialize current freq");
> +			pr_debug("Driver did not initialize current freq\n");
>  			policy->cur =3D new_policy.cur;
>  		} else {
>  			if (policy->cur !=3D new_policy.cur && has_target())
> @@ -2247,8 +2242,8 @@ int cpufreq_boost_trigger_state(int state)
>  		cpufreq_driver->boost_enabled =3D !state;
>  		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> =20
> -		pr_err("%s: Cannot %s BOOST\n", __func__,
> -		       state ? "enable" : "disable");
> +		pr_err("%s: Cannot %s BOOST\n",
> +		       __func__, state ? "enable" : "disable");
>  	}
> =20
>  	return ret;
> @@ -2320,7 +2315,7 @@ int cpufreq_register_driver(struct cpufreq_driv=
er *driver_data)
>  		ret =3D cpufreq_sysfs_create_file(&boost.attr);
>  		if (ret) {
>  			pr_err("%s: cannot register global BOOST sysfs file\n",
> -				__func__);
> +			       __func__);
>  			goto err_null_driver;
>  		}
>  	}
> @@ -2343,7 +2338,7 @@ int cpufreq_register_driver(struct cpufreq_driv=
er *driver_data)
>  		/* if all ->init() calls failed, unregister */
>  		if (ret) {
>  			pr_debug("no CPU initialized for driver %s\n",
> -							driver_data->name);
> +				 driver_data->name);
>  			goto err_if_unreg;
>  		}
>  	}
>=20
>=20
>=20

