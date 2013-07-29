From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: stable 3-10-3: strange output of "lsmod | grep ^acpi_cpufreq"
Date: Mon, 29 Jul 2013 22:19:02 +0200
Message-ID: <1734246.5vsq0SBKqr@vostro.rjw.lan>
References: <51F40612.2050403@gmx.de> <1462209.u176D8q1Fr@vostro.rjw.lan> <51F6A517.8060502@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:46414 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754133Ab3G2UIx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2013 16:08:53 -0400
In-Reply-To: <51F6A517.8060502@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Monday, July 29, 2013 07:23:35 PM Toralf F=C3=B6rster wrote:
> On 07/29/2013 01:54 PM, Rafael J. Wysocki wrote:
> > On Monday, July 29, 2013 04:52:39 PM Viresh Kumar wrote:
> >> On Mon, Jul 29, 2013 at 3:11 PM, Srivatsa S. Bhat
> >> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> >>> I'm assuming that the module_get() is used in the cpufreq core to=
 ensure that
> >>> until the cpufreq core is managing (atleast one) CPU(s), the cpuf=
req backend
> >>> driver module (eg: acpi-cpufreq) can't be removed.
> >>
> >> I missed this simple stuff in my email.. :(
> >>
> >>> But the cpufreq_add_dev() function does a module *put* at the end=
 of
> >>> initializing a fresh CPU.
> >>>
> >>> 1057         kobject_uevent(&policy->kobj, KOBJ_ADD);
> >>> 1058         module_put(cpufreq_driver->owner);
> >>> 1059         pr_debug("initialization complete\n");
> >>> 1060
> >>> 1061         return 0;
> >>
> >> That actually looks wrong. And shoud be fixed.
> >=20
> > OK
> >=20
> >>> So, I wonder if it would be a good idea to instead allow that CPU=
 to take a
> >>> module refcount as well. That way, the problem that Toralf report=
ed would go
> >>> away, and at the same time, we can ensure that as long as the cpu=
freq core is
> >>> managing CPUs, the cpufreq-backend-driver module refcount never d=
rops to zero.
> >>>
> >>> Something like this:
> >>>
> >>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.=
c
> >>> index a4ad733..ecfbc52 100644
> >>> --- a/drivers/cpufreq/cpufreq.c
> >>> +++ b/drivers/cpufreq/cpufreq.c
> >>> @@ -878,9 +878,14 @@ static int cpufreq_add_dev_interface(unsigne=
d int cpu,
> >>>         }
> >>>         write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> >>>
> >>> +       /* Bump up the refcount for this CPU */
> >>> +       policy =3D cpufreq_cpu_get(cpu);
> >>> +
> >>>         ret =3D cpufreq_add_dev_symlink(cpu, policy);
> >>> -       if (ret)
> >>> +       if (ret) {
> >>> +               cpufreq_cpu_put(policy);
> >>>                 goto err_out_kobj_put;
> >>> +       }
> >>
> >> That will do an extra kobject_get() which we don't require.. Only =
removing what
> >> I mentioned earlier should be good enough, I believe.
> >>
> >> Over that, I think below code in __cpufreq_governor() is also wron=
g.
> >>
> >> 	/* we keep one module reference alive for
> >> 			each CPU governed by this CPU */
> >> 	if ((event !=3D CPUFREQ_GOV_START) || ret)
> >> 		module_put(policy->governor->owner);
> >> 	if ((event =3D=3D CPUFREQ_GOV_STOP) && !ret)
> >> 		module_put(policy->governor->owner);
> >>
> >> The second if is sensible as it puts count when governor is stoppe=
d.
> >> But the first one decrements the count when we failed for anything
> >> other than START..
> >>
> >> But this routine is called for other stuff too:
> >> - INIT/Exit
> >> - LIMITS,
> >>
> >> And so, count must be incremented for a passed INIT call and
> >> decremented for a passed EXIT call, otherwise shouldn't be
> >> touched.
> >=20
> > That sounds good, but I don't want to make those changes for 3.11 a=
nd at the
> > same time I *do* want the reference count issue to go away.
> >=20
> > So the patch below is the one I'd like to apply for the time being =
and
> > we can work on more improvements on top of that.
> >=20
> > Any objections?
> >=20
> > Toralf, please test this patch in the meantime.
>=20
> works - tested on top of 3.10.4

Great, thanks for the confirmation!

Rafael


> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: cpufreq: Fix cpufreq driver module refcount balance after =
suspend/resume
> >=20
> > Since cpufreq_cpu_put() called by __cpufreq_remove_dev() drops the
> > driver module refcount, __cpufreq_remove_dev() causes that refcount
> > to become negative for the cpufreq driver after a suspend/resume
> > cycle.
> >=20
> > This is not the only bad thing that happens there, however, because
> > kobject_put() should only be called for the policy kobject at this
> > point if the CPU is not the last one for that policy.
> >=20
> > Namely, if the given CPU is the last one for that policy, the
> > policy kobject's refcount should be 1 at this point, as set by
> > cpufreq_add_dev_interface(), and only needs to be dropped once for
> > the kobject to go away.  This actually happens under the cpu =3D=3D=
 1
> > check, so it need not be done before by cpufreq_cpu_put().
> >=20
> > On the other hand, if the given CPU is not the last one for that
> > policy, this means that cpufreq_add_policy_cpu() has been called
> > at least once for that policy and cpufreq_cpu_get() has been
> > called for it too.  To balance that cpufreq_cpu_get(), we need to
> > call cpufreq_cpu_put() in that case.
> >=20
> > Thus, to fix the described problem and keep the reference
> > counters balanced in both cases, move the cpufreq_cpu_get() call
> > in __cpufreq_remove_dev() to the code path executed only for
> > CPUs that share the policy with other CPUs.
> >=20
> > Reported-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq.c |   19 ++++++++++---------
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> >=20
> > Index: linux-pm/drivers/cpufreq/cpufreq.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> > +++ linux-pm/drivers/cpufreq/cpufreq.c
> > @@ -1177,14 +1177,11 @@ static int __cpufreq_remove_dev(struct d
> >  				__func__, cpu_dev->id, cpu);
> >  	}
> > =20
> > -	if ((cpus =3D=3D 1) && (cpufreq_driver->target))
> > -		__cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
> > -
> > -	pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
> > -	cpufreq_cpu_put(data);
> > -
> >  	/* If cpu is last user of policy, free policy */
> >  	if (cpus =3D=3D 1) {
> > +		if (cpufreq_driver->target)
> > +			__cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
> > +
> >  		lock_policy_rwsem_read(cpu);
> >  		kobj =3D &data->kobj;
> >  		cmp =3D &data->kobj_unregister;
> > @@ -1205,9 +1202,13 @@ static int __cpufreq_remove_dev(struct d
> >  		free_cpumask_var(data->related_cpus);
> >  		free_cpumask_var(data->cpus);
> >  		kfree(data);
> > -	} else if (cpufreq_driver->target) {
> > -		__cpufreq_governor(data, CPUFREQ_GOV_START);
> > -		__cpufreq_governor(data, CPUFREQ_GOV_LIMITS);
> > +	} else {
> > +		pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
> > +		cpufreq_cpu_put(data);
> > +		if (cpufreq_driver->target) {
> > +			__cpufreq_governor(data, CPUFREQ_GOV_START);
> > +			__cpufreq_governor(data, CPUFREQ_GOV_LIMITS);
> > +		}
> >  	}
> > =20
> >  	per_cpu(cpufreq_policy_cpu, cpu) =3D -1;
> >=20
> >=20
>=20
>=20
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
