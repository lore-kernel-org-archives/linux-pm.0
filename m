From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi-cpufreq: Add a miss ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
Date: Sat, 18 Jul 2015 02:34:52 +0200
Message-ID: <15297094.Px11LlFYVk@vostro.rjw.lan>
References: <559F5D13.8050104@intel.com> <55A46F6B.6030006@intel.com> <55A47973.5080900@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54240 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751725AbbGRAIM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2015 20:08:12 -0400
In-Reply-To: <55A47973.5080900@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

On Tuesday, July 14, 2015 10:52:35 AM Pan Xinhui wrote:
> hi, Rafael,
> 	let me do more explanation :)
>=20
> On 2015=E5=B9=B407=E6=9C=8814=E6=97=A5 10:09, Pan Xinhui wrote:
> > hi, Rafael,
> > 	thanks for you reply :)
> > On 2015=E5=B9=B407=E6=9C=8814=E6=97=A5 07:26, Rafael J. Wysocki wro=
te:
> >> On Monday, July 13, 2015 02:33:08 PM Pan Xinhui wrote:
> >>> hi, Rafeal
> >>> 	thanks for your reply. :)
> >>>
> >>> On 2015=E5=B9=B407=E6=9C=8811=E6=97=A5 04:44, Rafael J. Wysocki w=
rote:
> >>>> Hi,
> >>>>
> >>>> On Fri, Jul 10, 2015 at 7:50 AM, Pan Xinhui <xinhuix.pan@intel.c=
om> wrote:
> >>>>>
> >>>>> If CONFIG_X86_ACPI_CPUFREQ_CPB has not been defined, the placeh=
older for
> >>>>> cpb is not needed. Add ifdef around it.
> >>>>>
> >>>>> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> >>>>> ---
> >>>>>  drivers/cpufreq/acpi-cpufreq.c | 2 ++
> >>>>>  1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/a=
cpi-cpufreq.c
> >>>>> index e7fcaa6..314a19e 100644
> >>>>> --- a/drivers/cpufreq/acpi-cpufreq.c
> >>>>> +++ b/drivers/cpufreq/acpi-cpufreq.c
> >>>>> @@ -884,7 +884,9 @@ static int acpi_cpufreq_resume(struct cpufr=
eq_policy *policy)
> >>>>>  static struct freq_attr *acpi_cpufreq_attr[] =3D {
> >>>>>         &cpufreq_freq_attr_scaling_available_freqs,
> >>>>>         &freqdomain_cpus,
> >>>>> +#ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
> >>>>>         NULL,   /* this is a placeholder for cpb, do not remove=
 */
> >>>>> +#endif
> >>>>
> >>>> Adding the ifdef here doesn't change anything, because the next =
NULL
> >>>> will play the role of the one you've just #ifdefed and the struc=
ture
> >>>> will be filled with zeros from that point on anyway.
> >>>>
> >>> Yes, adding ifdef here does not change any binary codes. But I wa=
nt to make the codes more readable. :)
> >>> Patch author has noticed two *NULL* here would confuse people, es=
pecially who first read this acpi-cpufreq.c file
> >>> From code style point, it would be better to have #ifdef around i=
t.=20
> >>
> >> Not really.
> >>
> >> Why don't you simply drop *both* NULLs?
> >>
> > Just like string end with *NULL* :)
> >=20
> > 1021 static int cpufreq_add_dev_interface(struct cpufreq_policy *po=
licy,
> > 1022                      struct device *dev)
> > 1023 {
> > 1024     struct freq_attr **drv_attr;
> > 1025     int ret =3D 0;
> > 1026=20
> > 1027     /* set up files for this cpu device */
> > 1028     drv_attr =3D cpufreq_driver->attr;
> > 1029     while (drv_attr && *drv_attr) {
> > 1030         ret =3D sysfs_create_file(&policy->kobj, &((*drv_attr)=
->attr));
> > 1031         if (ret)
> > 1032             return ret;
> > 1033         drv_attr++;
> > 1034     }
> > If struct freq_attr *acpi_cpufreq_attr[] did not end with NULL, lin=
e 1033 will access invalid data area.
> > If *drv_attr(the data after struct freq_attr * array[]) happened to=
 be not NULL. panic may hit in sysfs_create_file :(
> > So at least one *NULL* must be in the end of freq_attr *array[].

OK, so the array is NULL-terminated and one NULL is needed to mark the =
end of it.


> >=20
> > Actually in acpi-cpufreq.c, in acpi_cpufreq_init function.
> >  957         struct freq_attr **iter;
> >  958=20
> >  959         pr_debug("adding sysfs entry for cpb\n");
> >  960=20
> >  961         for (iter =3D acpi_cpufreq_attr; *iter !=3D NULL; iter=
++)
> >  962             ;
> >  963=20
> >  964         /* make sure there is a terminator behind it */
> >  965         if (iter[1] =3D=3D NULL)
> >  966             *iter =3D &cpb;
> >  967     }
> > line965, check of iter[1] is not needed. Maybe the patch author was=
 afraid of an unexpected remove of first *NULL*.
> > It might be a better solution to add ifdef CONFIG_X86_ACPI_CPUFREQ_=
CPB around that *NULL*, and remove this !iter[1] check.

Ah, so that is an exceptionally ugly piece of code.

What about the patch below?

---
 drivers/cpufreq/acpi-cpufreq.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
+++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
@@ -884,7 +884,9 @@ static int acpi_cpufreq_resume(struct cp
 static struct freq_attr *acpi_cpufreq_attr[] =3D {
 	&cpufreq_freq_attr_scaling_available_freqs,
 	&freqdomain_cpus,
-	NULL,	/* this is a placeholder for cpb, do not remove */
+#ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
+	&cpb,
+#endif
 	NULL,
 };
=20
@@ -957,17 +959,16 @@ static int __init acpi_cpufreq_init(void
 	 * only if configured. This is considered legacy code, which
 	 * will probably be removed at some point in the future.
 	 */
-	if (check_amd_hwpstate_cpu(0)) {
-		struct freq_attr **iter;
-
-		pr_debug("adding sysfs entry for cpb\n");
+	if (!check_amd_hwpstate_cpu(0)) {
+		struct freq_attr **attr;
=20
-		for (iter =3D acpi_cpufreq_attr; *iter !=3D NULL; iter++)
-			;
+		pr_debug("CPB unsupported, do not expose it\n");
=20
-		/* make sure there is a terminator behind it */
-		if (iter[1] =3D=3D NULL)
-			*iter =3D &cpb;
+		for (attr =3D acpi_cpufreq_attr; *attr; attr++)
+			if (*attr =3D=3D &cpb) {
+				*attr =3D NULL;
+				break;
+			}
 	}
 #endif
 	acpi_cpufreq_boost_init();

