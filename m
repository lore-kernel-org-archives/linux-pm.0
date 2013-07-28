From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: stable 3-10-3: strange output of  "lsmod | grep ^acpi_cpufreq"
Date: Mon, 29 Jul 2013 01:20:41 +0200
Message-ID: <2368277.VjYrsHUseA@vostro.rjw.lan>
References: <51F40612.2050403@gmx.de> <2111514.pxW5saG1J3@vostro.rjw.lan> <18359786.D7glpto546@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <18359786.D7glpto546@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, July 29, 2013 12:43:59 AM Rafael J. Wysocki wrote:
> On Monday, July 29, 2013 12:11:18 AM Rafael J. Wysocki wrote:
> > On Sunday, July 28, 2013 12:21:22 PM Toralf F=C3=B6rster wrote:
> > > On 07/28/2013 01:39 AM, Rafael J. Wysocki wrote:
> > > > On Saturday, July 27, 2013 07:40:34 PM Toralf F=C3=B6rster wrot=
e:
> > > >> it gives at a ThinkPad T420:
> > > >>
> > > >> tfoerste@n22 ~/tmp $ lsmod | grep ^acpi_cpufreq
> > > >> acpi_cpufreq           12902  2147483647
> > > >=20
> > > > That is -1, which indicates some module refcount woes.
> > >=20
> > > yes, ofc.
> > >=20
> > > The issue apears after 1 s2ram/resume cycle, before s2ram the ref=
count is 1.
> > >=20
> > > > I definitely can't see that with the mainline on my machines.
> > >=20
> > > It is in mainline too.
> >=20
> > Does the appended patch help?
>=20
> Actually, something as simple as this also should help:
>=20
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: cpufreq: Fix cpufreq driver module refcount balance after su=
spend/resume
>=20
> Since cpufreq_cpu_put() called by __cpufreq_remove_dev() drops the
> driver module refcount, __cpufreq_remove_dev() causes that refcount
> to become negative after a suspend/resume cycle, for example.
>=20
> To prevent this from happening make __cpufreq_remove_dev() put
> the policy kobject only instead of calling cpufreq_cpu_put().

Having a deeper look at it, though, I see that in fact the whole
cpufreq_cpu_put() is needed if the CPU is not the last one for the give=
n
policy and is not needed at all otherwise (as described in the changelo=
g
of the patch below).

Srivatsa, does this make sense to you?

Rafael


---
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: cpufreq: Fix cpufreq driver module refcount balance after susp=
end/resume

Since cpufreq_cpu_put() called by __cpufreq_remove_dev() drops the
driver module refcount, __cpufreq_remove_dev() causes that refcount
to become negative for the acpi-cpufreq driver after a suspend/resume
cycle.

This is not the only bad thing that happens there, however, because
kobject_put() should only be called for the policy kobject at this
point if the CPU is not the last one for that policy.

Namely, if the given CPU is the last one for that policy, the
policy kobject's refcount should be 1 at this point, as set by
cpufreq_add_dev_interface(), and only needs to be dropped once for
the kobject to go away.  This actually happens under the cpu =3D=3D 1
check, so it need not be done before by cpufreq_cpu_put().

On the other hand, if the given CPU is not the last one for that
policy, this means that cpufreq_add_policy_cpu() has been called
at least once for that policy and cpufreq_cpu_get() has been
called for it too.  To balance that cpufreq_cpu_get(), we need to
call pufreq_cpu_put() in that case.

Thus, to fix the described problem and keep the reference
counters balanced in both cases, move the cpufreq_cpu_get() call
in __cpufreq_remove_dev() to the code path executed only for
CPUs that share the policy with other CPUs.

Reported-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1181,7 +1181,6 @@ static int __cpufreq_remove_dev(struct d
 		__cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
=20
 	pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
-	cpufreq_cpu_put(data);
=20
 	/* If cpu is last user of policy, free policy */
 	if (cpus =3D=3D 1) {
@@ -1205,9 +1204,12 @@ static int __cpufreq_remove_dev(struct d
 		free_cpumask_var(data->related_cpus);
 		free_cpumask_var(data->cpus);
 		kfree(data);
-	} else if (cpufreq_driver->target) {
-		__cpufreq_governor(data, CPUFREQ_GOV_START);
-		__cpufreq_governor(data, CPUFREQ_GOV_LIMITS);
+	} else {
+		cpufreq_cpu_put(data);
+		if (cpufreq_driver->target) {
+			__cpufreq_governor(data, CPUFREQ_GOV_START);
+			__cpufreq_governor(data, CPUFREQ_GOV_LIMITS);
+		}
 	}
=20
 	per_cpu(cpufreq_policy_cpu, cpu) =3D -1;

