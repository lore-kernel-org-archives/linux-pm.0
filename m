From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: stable 3-10-3: strange output of  "lsmod | grep ^acpi_cpufreq"
Date: Mon, 29 Jul 2013 14:04:20 +0200
Message-ID: <1459225.4vzj4GkXXt@vostro.rjw.lan>
References: <51F40612.2050403@gmx.de> <10771278.LGR8ezfsZF@vostro.rjw.lan> <51F65599.6050209@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51F65599.6050209@linux.vnet.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Monday, July 29, 2013 05:14:25 PM Srivatsa S. Bhat wrote:
> On 07/29/2013 05:19 PM, Rafael J. Wysocki wrote:
> > On Monday, July 29, 2013 03:11:45 PM Srivatsa S. Bhat wrote:
> >> On 07/29/2013 04:50 AM, Rafael J. Wysocki wrote:
> >>> On Monday, July 29, 2013 12:43:59 AM Rafael J. Wysocki wrote:
> >>>> On Monday, July 29, 2013 12:11:18 AM Rafael J. Wysocki wrote:
> >>>>> On Sunday, July 28, 2013 12:21:22 PM Toralf F=C3=B6rster wrote:
> >>>>>> On 07/28/2013 01:39 AM, Rafael J. Wysocki wrote:
> >>>>>>> On Saturday, July 27, 2013 07:40:34 PM Toralf F=C3=B6rster wr=
ote:
> >>>>>>>> it gives at a ThinkPad T420:
> >>>>>>>>
> >>>>>>>> tfoerste@n22 ~/tmp $ lsmod | grep ^acpi_cpufreq
> >>>>>>>> acpi_cpufreq           12902  2147483647
> >>>>>>>
> >>>>>>> That is -1, which indicates some module refcount woes.
> >>>>>>
> >>>>>> yes, ofc.
> >>>>>>
> >>>>>> The issue apears after 1 s2ram/resume cycle, before s2ram the =
refcount is 1.
> >>>>>>
> >>>>>>> I definitely can't see that with the mainline on my machines.
> >>>>>>
> >>>>>> It is in mainline too.
> >>>>>
> >>>>> Does the appended patch help?
> >>>>
> >>>> Actually, something as simple as this also should help:
> >>>>
> >>>> ---
> >>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>> Subject: cpufreq: Fix cpufreq driver module refcount balance aft=
er suspend/resume
> >>>>
> >>>> Since cpufreq_cpu_put() called by __cpufreq_remove_dev() drops t=
he
> >>>> driver module refcount, __cpufreq_remove_dev() causes that refco=
unt
> >>>> to become negative after a suspend/resume cycle, for example.
> >>>>
> >>>> To prevent this from happening make __cpufreq_remove_dev() put
> >>>> the policy kobject only instead of calling cpufreq_cpu_put().
> >>>
> >>> Having a deeper look at it, though, I see that in fact the whole
> >>> cpufreq_cpu_put() is needed if the CPU is not the last one for th=
e given
> >>> policy and is not needed at all otherwise (as described in the ch=
angelog
> >>> of the patch below).
> >>>
> >>> Srivatsa, does this make sense to you?
> >>>
> >>
> >> Code-wise, your patch looks good to me. But one thing in the exist=
ing code
> >> struck me as a little strange.
> >>
> >> I'm assuming that the module_get() is used in the cpufreq core to =
ensure that
> >> until the cpufreq core is managing (atleast one) CPU(s), the cpufr=
eq backend
> >> driver module (eg: acpi-cpufreq) can't be removed.
> >=20
> > Quite frankly, I'm not sure about that.  If that were the case,
> > cpufreq_add_dev() would not call module_put() which it does.
> >=20
> > That may be a bug, I agree, but that's not for the present release =
cycle.  For
> > now, we need to ensure that the reference counts are *balanced* .
> >=20
>=20
> Sure, in that case, I agree that your patch is the right fix at this =
point,
> since it resolves the immediate problem that we have with the refcoun=
ts.
>=20
> Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Great, thanks!

Does your patchset avoiding the creation/removal of sysfs directories o=
ver
suspend/resume need to be modified to take this patch into account?

Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
