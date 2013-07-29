From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: stable 3-10-3: strange output of  "lsmod | grep ^acpi_cpufreq"
Date: Mon, 29 Jul 2013 22:28:36 +0200
Message-ID: <21518755.XU8JxLvZj7@vostro.rjw.lan>
References: <51F40612.2050403@gmx.de> <1459225.4vzj4GkXXt@vostro.rjw.lan> <51F689D8.1050902@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51F689D8.1050902@linux.vnet.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Monday, July 29, 2013 08:57:20 PM Srivatsa S. Bhat wrote:
> On 07/29/2013 05:34 PM, Rafael J. Wysocki wrote:
> > On Monday, July 29, 2013 05:14:25 PM Srivatsa S. Bhat wrote:
> >> On 07/29/2013 05:19 PM, Rafael J. Wysocki wrote:
> >>> On Monday, July 29, 2013 03:11:45 PM Srivatsa S. Bhat wrote:
> >>>> On 07/29/2013 04:50 AM, Rafael J. Wysocki wrote:
> >>>>> On Monday, July 29, 2013 12:43:59 AM Rafael J. Wysocki wrote:
> >>>>>> On Monday, July 29, 2013 12:11:18 AM Rafael J. Wysocki wrote:
> >>>>>>> On Sunday, July 28, 2013 12:21:22 PM Toralf F=C3=B6rster wrot=
e:
> >>>>>>>> On 07/28/2013 01:39 AM, Rafael J. Wysocki wrote:
> >>>>>>>>> On Saturday, July 27, 2013 07:40:34 PM Toralf F=C3=B6rster =
wrote:
> >>>>>>>>>> it gives at a ThinkPad T420:
> >>>>>>>>>>
> >>>>>>>>>> tfoerste@n22 ~/tmp $ lsmod | grep ^acpi_cpufreq
> >>>>>>>>>> acpi_cpufreq           12902  2147483647
> >>>>>>>>>
> >>>>>>>>> That is -1, which indicates some module refcount woes.
> >>>>>>>>
> >>>>>>>> yes, ofc.
> >>>>>>>>
> >>>>>>>> The issue apears after 1 s2ram/resume cycle, before s2ram th=
e refcount is 1.
> >>>>>>>>
> >>>>>>>>> I definitely can't see that with the mainline on my machine=
s.
> >>>>>>>>
> >>>>>>>> It is in mainline too.
> >>>>>>>
> >>>>>>> Does the appended patch help?
> >>>>>>
> >>>>>> Actually, something as simple as this also should help:
> >>>>>>
> >>>>>> ---
> >>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>> Subject: cpufreq: Fix cpufreq driver module refcount balance a=
fter suspend/resume
> >>>>>>
> >>>>>> Since cpufreq_cpu_put() called by __cpufreq_remove_dev() drops=
 the
> >>>>>> driver module refcount, __cpufreq_remove_dev() causes that ref=
count
> >>>>>> to become negative after a suspend/resume cycle, for example.
> >>>>>>
> >>>>>> To prevent this from happening make __cpufreq_remove_dev() put
> >>>>>> the policy kobject only instead of calling cpufreq_cpu_put().
> >>>>>
> >>>>> Having a deeper look at it, though, I see that in fact the whol=
e
> >>>>> cpufreq_cpu_put() is needed if the CPU is not the last one for =
the given
> >>>>> policy and is not needed at all otherwise (as described in the =
changelog
> >>>>> of the patch below).
> >>>>>
> >>>>> Srivatsa, does this make sense to you?
> >>>>>
> >>>>
> >>>> Code-wise, your patch looks good to me. But one thing in the exi=
sting code
> >>>> struck me as a little strange.
> >>>>
> >>>> I'm assuming that the module_get() is used in the cpufreq core t=
o ensure that
> >>>> until the cpufreq core is managing (atleast one) CPU(s), the cpu=
freq backend
> >>>> driver module (eg: acpi-cpufreq) can't be removed.
> >>>
> >>> Quite frankly, I'm not sure about that.  If that were the case,
> >>> cpufreq_add_dev() would not call module_put() which it does.
> >>>
> >>> That may be a bug, I agree, but that's not for the present releas=
e cycle.  For
> >>> now, we need to ensure that the reference counts are *balanced* .
> >>>
> >>
> >> Sure, in that case, I agree that your patch is the right fix at th=
is point,
> >> since it resolves the immediate problem that we have with the refc=
ounts.
> >>
> >> Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> >=20
> > Great, thanks!
> >=20
> > Does your patchset avoiding the creation/removal of sysfs directori=
es over
> > suspend/resume need to be modified to take this patch into account?
> >=20
>=20
> There will be some trivial conflicts, but looking a bit closer at my =
patchset,
> I believe it has a subtle refcounting bug, relating to patches 6 and =
7.
>=20
> Patch 6: http://marc.info/?l=3Dlinux-kernel&m=3D137358141628042&w=3D2
> Patch 7: http://marc.info/?l=3Dlinux-pm&m=3D137358124527993&w=3D2
>=20
>=20
> Patch 6 modifies cpufreq_add_policy_cpu() to return 0 if frozen =3D=3D=
 true.
> But by that time, it would have already done a cpufreq_cpu_get().
>=20
> In patch 7, under __cpufreq_remove_dev(), we avoid dropping refcounts
> for *any* CPU when frozen =3D=3D true.
>=20
> In the general case, this is fine (like myself and Viresh had discuss=
ed
> earlier in that thread), because __cpufreq_add_dev() doesn't incremen=
t the
> refcount in the frozen case.
>=20
> But we overlooked a rather subtle scenario: say, CPU 'X' went through
> cpufreq_add_dev in the resume path, and restored its policy structure=
=2E
> Since this was fresh, no refcount was taken. And then CPU 'Y' came al=
ong,
> but it was related to CPU 'X', so it will take this path:
>=20
> 1018         /* Check if this cpu was hot-unplugged earlier and has s=
iblings */
> 1019         read_lock_irqsave(&cpufreq_driver_lock, flags);
> 1020         for_each_online_cpu(sibling) {
> 1021                 struct cpufreq_policy *cp =3D per_cpu(cpufreq_cp=
u_data, sibling);
> 1022                 if (cp && cpumask_test_cpu(cpu, cp->related_cpus=
)) {
> 1023                         read_unlock_irqrestore(&cpufreq_driver_l=
ock, flags);
> 1024                         return cpufreq_add_policy_cpu(cpu, sibli=
ng, dev,
> 1025                                                       frozen);
> 1026                 }
> 1027         }
>=20
> This time, cp won't be NULL for CPU 'X', because its policy was resto=
red
> in the previous call. So we end up calling cpufreq_add_policy_cpu() f=
or
> CPU 'Y'. And that function takes a new refcount, as mentioned above.
>=20
> So we need to have this extra hunk in cpufreq_add_policy_cpu() to ens=
ure
> we don't take any additional refcounts during suspend/resume:
>=20
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c7f59e8..9681c01 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -932,8 +932,11 @@ static int cpufreq_add_policy_cpu(unsigned int c=
pu, unsigned int sibling,
>  	}
> =20
>  	/* Don't touch sysfs links during light-weight init */
> -	if (frozen)
> +	if (frozen) {
> +		/* Drop the extra refcount that we took above */
> +		cpufreq_cpu_put(policy);
>  		return 0;
> +	}
> =20
>  	ret =3D sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
>  	if (ret)
>=20
>=20
> I can respin my entire patchset with this fix included, on top of you=
r
> patch. Please let me know if you'd prefer some other method for resol=
ving
> this.

Please respin the patchset with the fix folded in.

My patch is in the bleeding-edge branch of linux-pm.git, so please reba=
se the
new version on that if that's not a problem.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
