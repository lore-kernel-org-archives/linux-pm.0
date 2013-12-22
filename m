From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH Resend] cpufreq: remove sysfs files for CPU which failed to come back after resume
Date: Sun, 22 Dec 2013 02:00:40 +0100
Message-ID: <1651441.C2UQleWVoy@vostro.rjw.lan>
References: <610b63b7594e5cd364c498f60e69b9e174db9257.1387554926.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63394 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756095Ab3LVArR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 Dec 2013 19:47:17 -0500
In-Reply-To: <610b63b7594e5cd364c498f60e69b9e174db9257.1387554926.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, December 20, 2013 09:26:02 PM Viresh Kumar wrote:
> There are cases where cpufreq_add_dev() may fail for some CPUs during=
 resume.
> With the current code we will still have sysfs cpufreq files for such=
 CPUs, and
> struct cpufreq_policy would be already freed for them. Hence any oper=
ation on
> those sysfs files would result in kernel warnings.
>=20
> To fix this, lets remove those sysfs files or put the associated kobj=
ect in case
> of such errors. Also, to make it simple lets remove the sysfs links f=
rom all the
> CPUs (except policy->cpu) during suspend as that operation wouldn't r=
esult with a
> loss of sysfs file permissions. And so we will create those links dur=
ing resume
> as well.
>=20
> Reported-and-tested-by: Bj=C3=B8rn Mork <bjorn@mork.no>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for the next PM pull request, thanks!

Bjorn, can you please check if the pm-cpufreq branch of the linux-pm.gi=
t tree
fixes the problem that you have reported without causing any new breaka=
ge to
happen?

Rafael


> ---
>  drivers/cpufreq/cpufreq.c | 63 +++++++++++++++++++++++--------------=
----------
>  1 file changed, 31 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 02d534d..fab042e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -845,8 +845,7 @@ static void cpufreq_init_policy(struct cpufreq_po=
licy *policy)
> =20
>  #ifdef CONFIG_HOTPLUG_CPU
>  static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
> -				  unsigned int cpu, struct device *dev,
> -				  bool frozen)
> +				  unsigned int cpu, struct device *dev)
>  {
>  	int ret =3D 0;
>  	unsigned long flags;
> @@ -877,11 +876,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq=
_policy *policy,
>  		}
>  	}
> =20
> -	/* Don't touch sysfs links during light-weight init */
> -	if (!frozen)
> -		ret =3D sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
> -
> -	return ret;
> +	return sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
>  }
>  #endif
> =20
> @@ -926,6 +921,27 @@ err_free_policy:
>  	return NULL;
>  }
> =20
> +static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
> +{
> +	struct kobject *kobj;
> +	struct completion *cmp;
> +
> +	down_read(&policy->rwsem);
> +	kobj =3D &policy->kobj;
> +	cmp =3D &policy->kobj_unregister;
> +	up_read(&policy->rwsem);
> +	kobject_put(kobj);
> +
> +	/*
> +	 * We need to make sure that the underlying kobj is
> +	 * actually not referenced anymore by anybody before we
> +	 * proceed with unloading.
> +	 */
> +	pr_debug("waiting for dropping of refcount\n");
> +	wait_for_completion(cmp);
> +	pr_debug("wait complete\n");
> +}
> +
>  static void cpufreq_policy_free(struct cpufreq_policy *policy)
>  {
>  	free_cpumask_var(policy->related_cpus);
> @@ -986,7 +1002,7 @@ static int __cpufreq_add_dev(struct device *dev,=
 struct subsys_interface *sif,
>  	list_for_each_entry(tpolicy, &cpufreq_policy_list, policy_list) {
>  		if (cpumask_test_cpu(cpu, tpolicy->related_cpus)) {
>  			read_unlock_irqrestore(&cpufreq_driver_lock, flags);
> -			ret =3D cpufreq_add_policy_cpu(tpolicy, cpu, dev, frozen);
> +			ret =3D cpufreq_add_policy_cpu(tpolicy, cpu, dev);
>  			up_read(&cpufreq_rwsem);
>  			return ret;
>  		}
> @@ -1096,7 +1112,10 @@ err_get_freq:
>  	if (cpufreq_driver->exit)
>  		cpufreq_driver->exit(policy);
>  err_set_policy_cpu:
> +	if (frozen)
> +		cpufreq_policy_put_kobj(policy);
>  	cpufreq_policy_free(policy);
> +
>  nomem_out:
>  	up_read(&cpufreq_rwsem);
> =20
> @@ -1118,7 +1137,7 @@ static int cpufreq_add_dev(struct device *dev, =
struct subsys_interface *sif)
>  }
> =20
>  static int cpufreq_nominate_new_policy_cpu(struct cpufreq_policy *po=
licy,
> -					   unsigned int old_cpu, bool frozen)
> +					   unsigned int old_cpu)
>  {
>  	struct device *cpu_dev;
>  	int ret;
> @@ -1126,10 +1145,6 @@ static int cpufreq_nominate_new_policy_cpu(str=
uct cpufreq_policy *policy,
>  	/* first sibling now owns the new sysfs dir */
>  	cpu_dev =3D get_cpu_device(cpumask_any_but(policy->cpus, old_cpu));
> =20
> -	/* Don't touch sysfs files during light-weight tear-down */
> -	if (frozen)
> -		return cpu_dev->id;
> -
>  	sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
>  	ret =3D kobject_move(&policy->kobj, &cpu_dev->kobj);
>  	if (ret) {
> @@ -1196,7 +1211,7 @@ static int __cpufreq_remove_dev_prepare(struct =
device *dev,
>  		if (!frozen)
>  			sysfs_remove_link(&dev->kobj, "cpufreq");
>  	} else if (cpus > 1) {
> -		new_cpu =3D cpufreq_nominate_new_policy_cpu(policy, cpu, frozen);
> +		new_cpu =3D cpufreq_nominate_new_policy_cpu(policy, cpu);
>  		if (new_cpu >=3D 0) {
>  			update_policy_cpu(policy, new_cpu);
> =20
> @@ -1218,8 +1233,6 @@ static int __cpufreq_remove_dev_finish(struct d=
evice *dev,
>  	int ret;
>  	unsigned long flags;
>  	struct cpufreq_policy *policy;
> -	struct kobject *kobj;
> -	struct completion *cmp;
> =20
>  	read_lock_irqsave(&cpufreq_driver_lock, flags);
>  	policy =3D per_cpu(cpufreq_cpu_data, cpu);
> @@ -1249,22 +1262,8 @@ static int __cpufreq_remove_dev_finish(struct =
device *dev,
>  			}
>  		}
> =20
> -		if (!frozen) {
> -			down_read(&policy->rwsem);
> -			kobj =3D &policy->kobj;
> -			cmp =3D &policy->kobj_unregister;
> -			up_read(&policy->rwsem);
> -			kobject_put(kobj);
> -
> -			/*
> -			 * We need to make sure that the underlying kobj is
> -			 * actually not referenced anymore by anybody before we
> -			 * proceed with unloading.
> -			 */
> -			pr_debug("waiting for dropping of refcount\n");
> -			wait_for_completion(cmp);
> -			pr_debug("wait complete\n");
> -		}
> +		if (!frozen)
> +			cpufreq_policy_put_kobj(policy);
> =20
>  		/*
>  		 * Perform the ->exit() even during light-weight tear-down,
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
