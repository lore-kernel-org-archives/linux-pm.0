From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: stable 3-10-3: strange output of  "lsmod | grep ^acpi_cpufreq"
Date: Mon, 29 Jul 2013 00:43:59 +0200
Message-ID: <18359786.D7glpto546@vostro.rjw.lan>
References: <51F40612.2050403@gmx.de> <51F4F0A2.1070705@gmx.de> <2111514.pxW5saG1J3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2111514.pxW5saG1J3@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Monday, July 29, 2013 12:11:18 AM Rafael J. Wysocki wrote:
> On Sunday, July 28, 2013 12:21:22 PM Toralf F=C3=B6rster wrote:
> > On 07/28/2013 01:39 AM, Rafael J. Wysocki wrote:
> > > On Saturday, July 27, 2013 07:40:34 PM Toralf F=C3=B6rster wrote:
> > >> it gives at a ThinkPad T420:
> > >>
> > >> tfoerste@n22 ~/tmp $ lsmod | grep ^acpi_cpufreq
> > >> acpi_cpufreq           12902  2147483647
> > >=20
> > > That is -1, which indicates some module refcount woes.
> >=20
> > yes, ofc.
> >=20
> > The issue apears after 1 s2ram/resume cycle, before s2ram the refco=
unt is 1.
> >=20
> > > I definitely can't see that with the mainline on my machines.
> >=20
> > It is in mainline too.
>=20
> Does the appended patch help?

Actually, something as simple as this also should help:

---
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: cpufreq: Fix cpufreq driver module refcount balance after susp=
end/resume

Since cpufreq_cpu_put() called by __cpufreq_remove_dev() drops the
driver module refcount, __cpufreq_remove_dev() causes that refcount
to become negative after a suspend/resume cycle, for example.

To prevent this from happening make __cpufreq_remove_dev() put
the policy kobject only instead of calling cpufreq_cpu_put().

Reported-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1181,7 +1181,7 @@ static int __cpufreq_remove_dev(struct d
 		__cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
=20
 	pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
-	cpufreq_cpu_put(data);
+	kobject_put(&data->kobj);
=20
 	/* If cpu is last user of policy, free policy */
 	if (cpus =3D=3D 1) {

