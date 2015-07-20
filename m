From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi-cpufreq: Add a miss ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
Date: Mon, 20 Jul 2015 23:47:44 +0200
Message-ID: <14669793.6Q1GnrS1i9@vostro.rjw.lan>
References: <559F5D13.8050104@intel.com> <15297094.Px11LlFYVk@vostro.rjw.lan> <55AC83C1.2080509@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AC83C1.2080509@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>
List-Id: linux-pm@vger.kernel.org

On Monday, July 20, 2015 01:14:41 PM Pan Xinhui wrote:
> hi, Rafael
> 	thanks for your reply :)
> On 2015=E5=B9=B407=E6=9C=8818=E6=97=A5 08:34, Rafael J. Wysocki wrote=
:
> > On Tuesday, July 14, 2015 10:52:35 AM Pan Xinhui wrote:
> >> hi, Rafael,
> >> 	let me do more explanation :)
> >>
> >> On 2015=E5=B9=B407=E6=9C=8814=E6=97=A5 10:09, Pan Xinhui wrote:
> >>> hi, Rafael,
> >>> 	thanks for you reply :)
> >>> On 2015=E5=B9=B407=E6=9C=8814=E6=97=A5 07:26, Rafael J. Wysocki w=
rote:
> >>>> On Monday, July 13, 2015 02:33:08 PM Pan Xinhui wrote:
> >>>>> hi, Rafeal
> >>>>> 	thanks for your reply. :)
> >>>>>
> >>>>> On 2015=E5=B9=B407=E6=9C=8811=E6=97=A5 04:44, Rafael J. Wysocki=
 wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> On Fri, Jul 10, 2015 at 7:50 AM, Pan Xinhui <xinhuix.pan@intel=
=2Ecom> wrote:
> >>>>>>>
> >>>>>>> If CONFIG_X86_ACPI_CPUFREQ_CPB has not been defined, the plac=
eholder for
> >>>>>>> cpb is not needed. Add ifdef around it.
> >>>>>>>
> >>>>>>> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> >>>>>>> ---
> >>>>>>>  drivers/cpufreq/acpi-cpufreq.c | 2 ++
> >>>>>>>  1 file changed, 2 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq=
/acpi-cpufreq.c
> >>>>>>> index e7fcaa6..314a19e 100644
> >>>>>>> --- a/drivers/cpufreq/acpi-cpufreq.c
> >>>>>>> +++ b/drivers/cpufreq/acpi-cpufreq.c
> >>>>>>> @@ -884,7 +884,9 @@ static int acpi_cpufreq_resume(struct cpu=
freq_policy *policy)
> >>>>>>>  static struct freq_attr *acpi_cpufreq_attr[] =3D {
> >>>>>>>         &cpufreq_freq_attr_scaling_available_freqs,
> >>>>>>>         &freqdomain_cpus,
> >>>>>>> +#ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
> >>>>>>>         NULL,   /* this is a placeholder for cpb, do not remo=
ve */
> >>>>>>> +#endif
> >>>>>>
> >>>>>> Adding the ifdef here doesn't change anything, because the nex=
t NULL
> >>>>>> will play the role of the one you've just #ifdefed and the str=
ucture
> >>>>>> will be filled with zeros from that point on anyway.
> >>>>>>
> >>>>> Yes, adding ifdef here does not change any binary codes. But I =
want to make the codes more readable. :)
> >>>>> Patch author has noticed two *NULL* here would confuse people, =
especially who first read this acpi-cpufreq.c file
> >>>>> From code style point, it would be better to have #ifdef around=
 it.=20
> >>>>
> >>>> Not really.
> >>>>
> >>>> Why don't you simply drop *both* NULLs?
> >>>>
> >>> Just like string end with *NULL* :)
> >>>
> >>> 1021 static int cpufreq_add_dev_interface(struct cpufreq_policy *=
policy,
> >>> 1022                      struct device *dev)
> >>> 1023 {
> >>> 1024     struct freq_attr **drv_attr;
> >>> 1025     int ret =3D 0;
> >>> 1026=20
> >>> 1027     /* set up files for this cpu device */
> >>> 1028     drv_attr =3D cpufreq_driver->attr;
> >>> 1029     while (drv_attr && *drv_attr) {
> >>> 1030         ret =3D sysfs_create_file(&policy->kobj, &((*drv_att=
r)->attr));
> >>> 1031         if (ret)
> >>> 1032             return ret;
> >>> 1033         drv_attr++;
> >>> 1034     }
> >>> If struct freq_attr *acpi_cpufreq_attr[] did not end with NULL, l=
ine 1033 will access invalid data area.
> >>> If *drv_attr(the data after struct freq_attr * array[]) happened =
to be not NULL. panic may hit in sysfs_create_file :(
> >>> So at least one *NULL* must be in the end of freq_attr *array[].
> >=20
> > OK, so the array is NULL-terminated and one NULL is needed to mark =
the end of it.
> >=20
> >=20
> >>>
> >>> Actually in acpi-cpufreq.c, in acpi_cpufreq_init function.
> >>>  957         struct freq_attr **iter;
> >>>  958=20
> >>>  959         pr_debug("adding sysfs entry for cpb\n");
> >>>  960=20
> >>>  961         for (iter =3D acpi_cpufreq_attr; *iter !=3D NULL; it=
er++)
> >>>  962             ;
> >>>  963=20
> >>>  964         /* make sure there is a terminator behind it */
> >>>  965         if (iter[1] =3D=3D NULL)
> >>>  966             *iter =3D &cpb;
> >>>  967     }
> >>> line965, check of iter[1] is not needed. Maybe the patch author w=
as afraid of an unexpected remove of first *NULL*.
> >>> It might be a better solution to add ifdef CONFIG_X86_ACPI_CPUFRE=
Q_CPB around that *NULL*, and remove this !iter[1] check.
> >=20
> > Ah, so that is an exceptionally ugly piece of code.
> >=20
> > What about the patch below?
> >=20
> agree, seems a little better than two-NULLs. I just have one minor qu=
estion listed below.
>=20
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c |   21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> >=20
> > Index: linux-pm/drivers/cpufreq/acpi-cpufreq.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/cpufreq/acpi-cpufreq.c
> > +++ linux-pm/drivers/cpufreq/acpi-cpufreq.c
> > @@ -884,7 +884,9 @@ static int acpi_cpufreq_resume(struct cp
> >  static struct freq_attr *acpi_cpufreq_attr[] =3D {
> >  	&cpufreq_freq_attr_scaling_available_freqs,
> >  	&freqdomain_cpus,
> > -	NULL,	/* this is a placeholder for cpb, do not remove */
> > +#ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
> > +	&cpb,
> > +#endif
> >  	NULL,
> >  };
> > =20
> such definition may hide a fact that it might be set to NULL if cpb i=
s not supported.
> So if that happen, other member of this array whose index is large th=
an cpb might not registered.
> for example
>=20
> +#ifdef CONFIG_X86_ACPI_CPUFREQ_CPB
> +	&cpb,
> +#endif
> +#ifdef CONFIG_NEW_XXXXXX
> 	&new_cpufreq_attrs,
> #endif
> 	NULL
> }
> anyway, at that time, people could work out a new solution. if they r=
eally have to add such new cpufreq attr. :)

Well, they just need to put their new stuff above the CPB attribute.

>=20
> it seems good to me. thanks for your patch :)

OK, thanks!


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
