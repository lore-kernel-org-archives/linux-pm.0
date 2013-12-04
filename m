From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH] cpufreq: fix garbage kobj on errors during suspend/resume
Date: Wed, 04 Dec 2013 13:08:30 +0100
Message-ID: <87fvq8lsxt.fsf@nemi.mork.no>
References: <1386069272-9250-1-git-send-email-bjorn@mork.no>
	<529F04B2.7050303@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:52264 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663Ab3LDMUu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2013 07:20:50 -0500
In-Reply-To: <529F04B2.7050303@linaro.org> (viresh kumar's message of "Wed, 04
	Dec 2013 16:02:18 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

viresh kumar <viresh.kumar@linaro.org> writes:

> On Tuesday 03 December 2013 04:44 PM, Bj=C3=B8rn Mork wrote:
>> This is effectively a revert of commit 5302c3fb2e62 ("cpufreq: Perfo=
rm
>> light-weight init/teardown during suspend/resume"), which enabled
>> suspend/resume optimizations leaving the sysfs files in place.
>>=20
>> Errors during suspend/resume are not handled properly, leaving
>> dead sysfs attributes in case of failures.  There are are number of
>> functions with special code for the "frozen" case, and all these
>> need to also have special error handling.
>
> Can you try this please if it fixes things for you (with your patch r=
everted):

Yes, that patch looks like it fix the problem, and I cannot spot any
obvious missing cleanups.

But I must say that the whole kobj + free thing makes me feel a bit
uneasy.  I assume there are good reasons why "cpufreq" isn't just a
device with a release method?

And I do hope there is something gained by the special suspend handling=
,
because keeping this partial device looks really messy. If it's all jus=
t
for some file permissions, then there must be better ways?  Isn't
consistent file permissions on device creation really a userspace issue=
?

Anyway, the patch works so you can add

Tested-by: Bj=C3=B8rn Mork <bjorn@mork.no>


BTW, a simple way to test these things is cancelling a userspace
hibernate on an ACPI system.  It will always make the acpi_cpufreq
driver fail because it attemps to call _PPC inbetween
acpi_ec_block_transactions and acpi_ec_unblock_transactions.  There is
no acpi_ec_unblock_transactions_early call in this case.



Bj=C3=B8rn




> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Wed, 4 Dec 2013 15:20:12 +0530
> Subject: [PATCH] cpufreq: remove sysfs files for CPU which failed to =
come
>  back after resume
>
> There are cases where cpufreq_add_dev() may fail for some CPUs during=
 resume.
> With the current code we will still have sysfs cpufreq files for such=
 CPUs, and
> struct cpufreq_policy would be already freed for them. Hence any oper=
ation on
> those sysfs files would result in kernel warnings.
>
> To fix this, lets remove those sysfs files or put the associated kobj=
ect in case
> of such errors. Also, to make it simple lets remove the sysfs links f=
rom all the
> CPUs (except policy->cpu) during suspend as that operation wouldn't r=
esult with a
> loss of sysfs file permissions. And so we will create those links dur=
ing resume
> as well.
>
> Reported-by: Bj=C3=B8rn Mork <bjorn@mork.no>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 61 ++++++++++++++++++++++++-------------=
----------
>  1 file changed, 31 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 606224a..57c80a7 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -849,8 +849,7 @@ static void cpufreq_init_policy(struct cpufreq_po=
licy *policy)
>
>  #ifdef CONFIG_HOTPLUG_CPU
>  static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
> -				  unsigned int cpu, struct device *dev,
> -				  bool frozen)
> +				  unsigned int cpu, struct device *dev)
>  {
>  	int ret =3D 0;
>  	unsigned long flags;
> @@ -881,9 +880,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq_=
policy *policy,
>  		}
>  	}
>
> -	/* Don't touch sysfs links during light-weight init */
> -	if (!frozen)
> -		ret =3D sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
> +	ret =3D sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
>
>  	return ret;
>  }
> @@ -930,6 +927,27 @@ err_free_policy:
>  	return NULL;
>  }
>
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
> @@ -990,7 +1008,7 @@ static int __cpufreq_add_dev(struct device *dev,=
 struct subsys_interface *sif,
>  	list_for_each_entry(tpolicy, &cpufreq_policy_list, policy_list) {
>  		if (cpumask_test_cpu(cpu, tpolicy->related_cpus)) {
>  			read_unlock_irqrestore(&cpufreq_driver_lock, flags);
> -			ret =3D cpufreq_add_policy_cpu(tpolicy, cpu, dev, frozen);
> +			ret =3D cpufreq_add_policy_cpu(tpolicy, cpu, dev);
>  			up_read(&cpufreq_rwsem);
>  			return ret;
>  		}
> @@ -1100,7 +1118,10 @@ err_get_freq:
>  	if (cpufreq_driver->exit)
>  		cpufreq_driver->exit(policy);
>  err_set_policy_cpu:
> +	if (frozen)
> +		cpufreq_policy_put_kobj(policy);
>  	cpufreq_policy_free(policy);
> +
>  nomem_out:
>  	up_read(&cpufreq_rwsem);
>
> @@ -1122,7 +1143,7 @@ static int cpufreq_add_dev(struct device *dev, =
struct subsys_interface *sif)
>  }
>
>  static int cpufreq_nominate_new_policy_cpu(struct cpufreq_policy *po=
licy,
> -					   unsigned int old_cpu, bool frozen)
> +					   unsigned int old_cpu)
>  {
>  	struct device *cpu_dev;
>  	int ret;
> @@ -1130,10 +1151,6 @@ static int cpufreq_nominate_new_policy_cpu(str=
uct cpufreq_policy *policy,
>  	/* first sibling now owns the new sysfs dir */
>  	cpu_dev =3D get_cpu_device(cpumask_any_but(policy->cpus, old_cpu));
>
> -	/* Don't touch sysfs files during light-weight tear-down */
> -	if (frozen)
> -		return cpu_dev->id;
> -
>  	sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
>  	ret =3D kobject_move(&policy->kobj, &cpu_dev->kobj);
>  	if (ret) {
> @@ -1200,7 +1217,7 @@ static int __cpufreq_remove_dev_prepare(struct =
device *dev,
>  		if (!frozen)
>  			sysfs_remove_link(&dev->kobj, "cpufreq");
>  	} else if (cpus > 1) {
> -		new_cpu =3D cpufreq_nominate_new_policy_cpu(policy, cpu, frozen);
> +		new_cpu =3D cpufreq_nominate_new_policy_cpu(policy, cpu);
>  		if (new_cpu >=3D 0) {
>  			update_policy_cpu(policy, new_cpu);
>
> @@ -1222,8 +1239,6 @@ static int __cpufreq_remove_dev_finish(struct d=
evice *dev,
>  	int ret;
>  	unsigned long flags;
>  	struct cpufreq_policy *policy;
> -	struct kobject *kobj;
> -	struct completion *cmp;
>
>  	read_lock_irqsave(&cpufreq_driver_lock, flags);
>  	policy =3D per_cpu(cpufreq_cpu_data, cpu);
> @@ -1253,22 +1268,8 @@ static int __cpufreq_remove_dev_finish(struct =
device *dev,
>  			}
>  		}
>
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
>
>  		/*
>  		 * Perform the ->exit() even during light-weight tear-down,
