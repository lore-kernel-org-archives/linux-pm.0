From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: stable 3-10-3: strange output of  "lsmod | grep ^acpi_cpufreq"
Date: Mon, 29 Jul 2013 00:11:18 +0200
Message-ID: <2111514.pxW5saG1J3@vostro.rjw.lan>
References: <51F40612.2050403@gmx.de> <4531734.kTFAPunoch@vostro.rjw.lan> <51F4F0A2.1070705@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51F4F0A2.1070705@gmx.de>
Sender: cpufreq-owner@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Sunday, July 28, 2013 12:21:22 PM Toralf F=C3=B6rster wrote:
> On 07/28/2013 01:39 AM, Rafael J. Wysocki wrote:
> > On Saturday, July 27, 2013 07:40:34 PM Toralf F=C3=B6rster wrote:
> >> it gives at a ThinkPad T420:
> >>
> >> tfoerste@n22 ~/tmp $ lsmod | grep ^acpi_cpufreq
> >> acpi_cpufreq           12902  2147483647
> >=20
> > That is -1, which indicates some module refcount woes.
>=20
> yes, ofc.
>=20
> The issue apears after 1 s2ram/resume cycle, before s2ram the refcoun=
t is 1.
>=20
> > I definitely can't see that with the mainline on my machines.
>=20
> It is in mainline too.

Does the appended patch help?

Rafael


---
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: cpufreq: Fix cpufreq driver module refcount balance after susp=
end/resume

Since cpufreq_cpu_put() called by __cpufreq_remove_dev() drops the
driver module refcount, the latter has to bump up that refcount to
start with to balance the drop, or the cpufreq driver refcount will
become negative after a suspend/resume cycle.

Reported-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1016,6 +1016,9 @@ static int __cpufreq_remove_dev(struct d
=20
 	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
=20
+	if (!try_module_get(cpufreq_driver->owner))
+		return -EINVAL;
+
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
=20
 	data =3D per_cpu(cpufreq_cpu_data, cpu);
@@ -1025,7 +1028,8 @@ static int __cpufreq_remove_dev(struct d
=20
 	if (!data) {
 		pr_debug("%s: No cpu_data found\n", __func__);
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto err;
 	}
=20
 	if (cpufreq_driver->target)
@@ -1063,9 +1067,9 @@ static int __cpufreq_remove_dev(struct d
=20
 			unlock_policy_rwsem_write(cpu);
=20
-			ret =3D sysfs_create_link(&cpu_dev->kobj, &data->kobj,
+			sysfs_create_link(&cpu_dev->kobj, &data->kobj,
 					"cpufreq");
-			return -EINVAL;
+			goto err;
 		}
=20
 		WARN_ON(lock_policy_rwsem_write(cpu));
@@ -1110,6 +1114,10 @@ static int __cpufreq_remove_dev(struct d
=20
 	per_cpu(cpufreq_policy_cpu, cpu) =3D -1;
 	return 0;
+
+ err:
+	module_put(cpufreq_driver->owner);
+	return ret;
 }
=20
=20

