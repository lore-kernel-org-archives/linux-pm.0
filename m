From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 3/4] sched: scheduler-driven cpu frequency selection
Date: Fri, 26 Jun 2015 19:47:03 -0500
Message-ID: <20150627004703.GA19347@saruman.tx.rr.com>
References: <1435362824-26734-1-git-send-email-mturquette@linaro.org>
 <1435362824-26734-4-git-send-email-mturquette@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44290 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbbF0Arx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 26 Jun 2015 20:47:53 -0400
Content-Disposition: inline
In-Reply-To: <1435362824-26734-4-git-send-email-mturquette@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, amit.kucheria@linaro.org, juri.lelli@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, alex.shi@linaro.org, linux-pm@vger.kernel.org, abelvesa@gmail.com, pebolle@tiscali.nl

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 26, 2015 at 04:53:43PM -0700, Michael Turquette wrote:
> diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
> new file mode 100644
> index 0000000..5020f24
> --- /dev/null
> +++ b/kernel/sched/cpufreq_sched.c
> @@ -0,0 +1,308 @@
> +/*
> + *  Copyright (C)  2015 Michael Turquette <mturquette@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/module.h>
> +#include <linux/kthread.h>
> +#include <linux/percpu.h>
> +#include <linux/irq_work.h>
> +
> +#include "sched.h"
> +
> +#define THROTTLE_NSEC		50000000 /* 50ms default */
> +
> +static DEFINE_PER_CPU(unsigned long, pcpu_capacity);
> +static DEFINE_PER_CPU(struct cpufreq_policy *, pcpu_policy);
> +
> +/**
> + * gov_data - per-policy data internal to the governor
> + * @throttle: next throttling period expiry. Derived from throttle_nsec
> + * @throttle_nsec: throttle period length in nanoseconds
> + * @task: worker thread for dvfs transition that may block/sleep
> + * @irq_work: callback used to wake up worker thread
> + * @freq: new frequency stored in *_sched_update_cpu and used in *_sched=
_thread
> + *
> + * struct gov_data is the per-policy cpufreq_sched-specific data structu=
re. A
> + * per-policy instance of it is created when the cpufreq_sched governor =
receives
> + * the CPUFREQ_GOV_START condition and a pointer to it exists in the gov=
_data
> + * member of struct cpufreq_policy.
> + *
> + * Readers of this data must call down_read(policy->rwsem). Writers must
> + * call down_write(policy->rwsem).
> + */
> +struct gov_data {
> +	ktime_t throttle;
> +	unsigned int throttle_nsec;
> +	struct task_struct *task;
> +	struct irq_work irq_work;
> +	struct cpufreq_policy *policy;
> +	unsigned int freq;
> +};
> +
> +static void cpufreq_sched_try_driver_target(struct cpufreq_policy *polic=
y, unsigned int freq)
> +{
> +	struct gov_data *gd =3D policy->governor_data;
> +
> +	/* avoid race with cpufreq_sched_stop */
> +	if (!down_write_trylock(&policy->rwsem))
> +		return;
> +
> +	__cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
> +
> +	gd->throttle =3D ktime_add_ns(ktime_get(), gd->throttle_nsec);
> +	up_write(&policy->rwsem);
> +}
> +
> +/*
> + * we pass in struct cpufreq_policy. This is safe because changing out t=
he
> + * policy requires a call to __cpufreq_governor(policy, CPUFREQ_GOV_STOP=
),
> + * which tears down all of the data structures and __cpufreq_governor(po=
licy,
> + * CPUFREQ_GOV_START) will do a full rebuild, including this kthread wit=
h the
> + * new policy pointer
> + */
> +static int cpufreq_sched_thread(void *data)
> +{
> +	struct sched_param param;
> +	struct cpufreq_policy *policy;
> +	struct gov_data *gd;
> +	int ret;
> +
> +	policy =3D (struct cpufreq_policy *) data;

unnecessary cast.

> +	if (!policy) {

Is this even possible ? I'd just let it oops since it would be a really
odd case.

> +		pr_warn("%s: missing policy\n", __func__);
> +		do_exit(-EINVAL);
> +	}
> +
> +	gd =3D policy->governor_data;
> +	if (!gd) {

likewise.

> +		pr_warn("%s: missing governor data\n", __func__);
> +		do_exit(-EINVAL);
> +	}
> +
> +	param.sched_priority =3D 50;
> +	ret =3D sched_setscheduler_nocheck(gd->task, SCHED_FIFO, &param);
> +	if (ret) {
> +		pr_warn("%s: failed to set SCHED_FIFO\n", __func__);
> +		do_exit(-EINVAL);
> +	} else {

else is unnecessary here, but no strong feelings.

> +		pr_debug("%s: kthread (%d) set to SCHED_FIFO\n",
> +				__func__, gd->task->pid);
> +	}
> +
> +	ret =3D set_cpus_allowed_ptr(gd->task, policy->related_cpus);
> +	if (ret) {
> +		pr_warn("%s: failed to set allowed ptr\n", __func__);
> +		do_exit(-EINVAL);
> +	}
> +
> +	/* main loop of the per-policy kthread */
> +	do {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule();
> +		if (kthread_should_stop())
> +			break;
> +
> +		cpufreq_sched_try_driver_target(policy, gd->freq);
> +	} while (!kthread_should_stop());

looks like this would be simpler with a plain while() instead of do
{} while:

	while (!kthread_should_stop()) {
		set_current_state(TASK_INTERRUPTIBLE);
		schedule();
		cpufreq_sched_try_driver_target(policy, gd->freq);
	}

> +	do_exit(0);
> +}
> +
> +static void cpufreq_sched_irq_work(struct irq_work *irq_work)
> +{
> +	struct gov_data *gd;
> +
> +	gd =3D container_of(irq_work, struct gov_data, irq_work);

if irq_work is the first member in struct gov_data, this gets optimized
to a cast.

> +	if (!gd) {

unnecessary parens.

> +		return;
> +	}
> +
> +	wake_up_process(gd->task);
> +}
> +
> +/**
> + * cpufreq_sched_set_capacity - interface to scheduler for changing capa=
city values
> + * @cpu: cpu whose capacity utilization has recently changed
> + * @capacity: the new capacity requested by cpu
> + *
> + * cpufreq_sched_sched_capacity is an interface exposed to the scheduler=
 so
> + * that the scheduler may inform the governor of updates to capacity
> + * utilization and make changes to cpu frequency. Currently this interfa=
ce is
> + * designed around PELT values in CFS. It can be expanded to other sched=
uling
> + * classes in the future if needed.
> + *
> + * cpufreq_sched_set_capacity raises an IPI. The irq_work handler for th=
at IPI
> + * wakes up the thread that does the actual work, cpufreq_sched_thread.
> + *
> + * This functions bails out early if either condition is true:
> + * 1) this cpu did not the new maximum capacity for its frequency domain
> + * 2) no change in cpu frequency is necessary to meet the new capacity r=
equest
> + */
> +void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
> +{
> +	unsigned int freq_new, cpu_tmp;
> +	struct cpufreq_policy *policy;
> +	struct gov_data *gd;
> +	unsigned long capacity_max =3D 0;
> +
> +	/* update per-cpu capacity request */
> +	__this_cpu_write(pcpu_capacity, capacity);
> +
> +	policy =3D cpufreq_cpu_get(cpu);
> +	if (IS_ERR_OR_NULL(policy)) {

can this really be ERR_PTR ? Also, unnecessary parens

> +		return;
> +	}
> +
> +	if (!policy->governor_data)
> +		goto out;
> +
> +	gd =3D policy->governor_data;
> +
> +	/* bail early if we are throttled */
> +	if (ktime_before(ktime_get(), gd->throttle))
> +		goto out;
> +
> +	/* find max capacity requested by cpus in this policy */
> +	for_each_cpu(cpu_tmp, policy->cpus)
> +		capacity_max =3D max(capacity_max, per_cpu(pcpu_capacity, cpu_tmp));
> +
> +	/*
> +	 * We only change frequency if this cpu's capacity request represents a
> +	 * new max. If another cpu has requested a capacity greater than the
> +	 * previous max then we rely on that cpu to hit this code path and make
> +	 * the change. IOW, the cpu with the new max capacity is responsible
> +	 * for setting the new capacity/frequency.
> +	 *
> +	 * If this cpu is not the new maximum then bail
> +	 */
> +	if (capacity_max > capacity)
> +		goto out;
> +
> +	/* Convert the new maximum capacity request into a cpu frequency */
> +	freq_new =3D capacity * policy->max >> SCHED_CAPACITY_SHIFT;
> +
> +	/* No change in frequency? Bail and return current capacity. */
> +	if (freq_new =3D=3D policy->cur)
> +		goto out;
> +
> +	/* store the new frequency and perform the transition */
> +	gd->freq =3D freq_new;
> +
> +	if (cpufreq_driver_might_sleep())
> +		irq_work_queue_on(&gd->irq_work, cpu);
> +	else
> +		cpufreq_sched_try_driver_target(policy, freq_new);
> +
> +out:
> +	cpufreq_cpu_put(policy);
> +	return;

unnecessary return

> +}
> +
> +static int cpufreq_sched_start(struct cpufreq_policy *policy)
> +{
> +	struct gov_data *gd;
> +	int cpu;
> +
> +	/* prepare per-policy private data */
> +	gd =3D kzalloc(sizeof(*gd), GFP_KERNEL);
> +	if (!gd) {
> +		pr_debug("%s: failed to allocate private data\n", __func__);

unnecessary OOM message, that will render curly braces unnecessary too.

> +		return -ENOMEM;
> +	}
> +
> +	/* initialize per-cpu data */
> +	for_each_cpu(cpu, policy->cpus) {
> +		per_cpu(pcpu_capacity, cpu) =3D 0;
> +		per_cpu(pcpu_policy, cpu) =3D policy;
> +	}
> +
> +	/*
> +	 * Don't ask for freq changes at an higher rate than what

s/an higher/a higher

> +	 * the driver advertises as transition latency.
> +	 */
> +	gd->throttle_nsec =3D policy->cpuinfo.transition_latency ?
> +			    policy->cpuinfo.transition_latency :
> +			    THROTTLE_NSEC;
> +	pr_debug("%s: throttle threshold =3D %u [ns]\n",
> +		  __func__, gd->throttle_nsec);
> +
> +	if (cpufreq_driver_might_sleep()) {
> +		/* init per-policy kthread */
> +		gd->task =3D kthread_run(cpufreq_sched_thread, policy, "kcpufreq_sched=
_task");
> +		if (IS_ERR_OR_NULL(gd->task)) {

kthread_run() doesn't return NULL.

> +			pr_err("%s: failed to create kcpufreq_sched_task thread\n", __func__);
> +			goto err;
> +		}
> +		init_irq_work(&gd->irq_work, cpufreq_sched_irq_work);
> +	}
> +
> +	policy->governor_data =3D gd;
> +	gd->policy =3D policy;
> +	return 0;
> +
> +err:
> +	kfree(gd);
> +	return -ENOMEM;

why don't you pass along errors returned by any other function you call ?

> +}
> +
> +static int cpufreq_sched_stop(struct cpufreq_policy *policy)
> +{
> +	struct gov_data *gd =3D policy->governor_data;
> +
> +	if (cpufreq_driver_might_sleep()) {

unnecessary curly braces.

> +		kthread_stop(gd->task);

should you switch back to some default OPP when this is removed ? Some
SoCs can't run at certain OPPs forever (thermal limitations, or whatever
else), might be good to switch to something considered safe.

> +	}
> +
> +	policy->governor_data =3D NULL;
> +
> +	/* FIXME replace with devm counterparts? */
> +	kfree(gd);
> +	return 0;
> +}
> +
> +static int cpufreq_sched_setup(struct cpufreq_policy *policy, unsigned i=
nt event)
> +{
> +	switch (event) {
> +		case CPUFREQ_GOV_START:
> +			/* Start managing the frequency */
> +			return cpufreq_sched_start(policy);
> +
> +		case CPUFREQ_GOV_STOP:
> +			return cpufreq_sched_stop(policy);
> +
> +		case CPUFREQ_GOV_LIMITS:	/* unused */
> +		case CPUFREQ_GOV_POLICY_INIT:	/* unused */
> +		case CPUFREQ_GOV_POLICY_EXIT:	/* unused */
> +			break;

indentation

> +	}
> +	return 0;
> +}
> +
> +#ifndef CONFIG_CPU_FREQ_DEFAULT_GOV_SCHED
> +static
> +#endif
> +struct cpufreq_governor cpufreq_gov_sched =3D {
> +	.name			=3D "sched",
> +	.governor		=3D cpufreq_sched_setup,
> +	.owner			=3D THIS_MODULE,
> +};
> +
> +static int __init cpufreq_sched_init(void)
> +{
> +	return cpufreq_register_governor(&cpufreq_gov_sched);
> +}
> +
> +static void __exit cpufreq_sched_exit(void)
> +{
> +	cpufreq_unregister_governor(&cpufreq_gov_sched);
> +}
> +
> +/* Try to make this the default governor */
> +fs_initcall(cpufreq_sched_init);

why fs_initcall() ? Why can't this be in module_init() ?

--=20
balbi

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVjfKHAAoJEIaOsuA1yqREFDUP/RwmZHyQETAQgZ1Ygde6LmgM
wrqxILK8M92iIBL05ZLa4gzR2FOvgrGDS/Nm06adb6PgD6oJKkTSZkz6wWhjoZiZ
WJBtoNU0/ztTScozxZRsdhuGKGM4cbXmj8qYuyzNV8Atxkx3ShMvB4vFhknsKe+h
QyRlMP79JwfFnNJPZyrIivJziXBPGJXcVyjMj+J+n7cD49bSC4gJBCXyUODWd7KC
ICxXmwTcMqq2Lu9juqWelD+7fV6uAbkAnj+WJ2CRPvBKWqGPcA7fwqkEQPxo/uHE
+c81GIWnVSOQBVhQCapUN2nBSYGWyQ19uQ3PQfgbjaYVidwgImwzZcdCvfQbKDvW
CiBVrbBQWVDj1HVnwSS/PPdZ+gmQcIHkzLS2hKYsdgXCXOtG1EqiFhACuFK9Lb6Q
QwwtWYW6Xes+kXjyH4kmF8QaswDlhrWIp/g4VfOQTyWPYjKaZU5tBzOoKeM0U+PM
7d/99Zcs/0nayMQczcxvFCgmg6qB8rXBMxFaxPUOvaEvWI7sk39lm+RloK3Wr1oM
JycmMww94jmQLzq0X6cN4T+6crOEOZ25uh5wo9VDrwRz1xXDFTBXG8/EREZ3xxok
4QH6UtK8zDiOJ7AngruKy0TCXubjc+L8EHamRUHxLGb3xo7Yi70+1rN00VtuhBNj
/IhtcdQ12IBWDggseHxR
=ZrY2
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
