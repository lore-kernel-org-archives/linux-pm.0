From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] ACPI / processor: Drop an unused argument of a cleanup routine
Date: Mon, 20 Jul 2015 23:49:56 +0200
Message-ID: <2302038.j7LN5nT5iO@vostro.rjw.lan>
References: <10273534.kyzK8rhvUz@vostro.rjw.lan> <15976638.8lfDjd5ol2@vostro.rjw.lan> <55AC52BA.8070205@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59800 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754048AbbGTVXL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2015 17:23:11 -0400
In-Reply-To: <55AC52BA.8070205@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

On Monday, July 20, 2015 09:45:30 AM Pan Xinhui wrote:
> hi, Rafael
> 	thanks for your nice work :)
> On 2015=E5=B9=B407=E6=9C=8818=E6=97=A5 09:14, Rafael J. Wysocki wrote=
:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >=20
> > acpi_processor_unregister_performance() actually doesn't use its
> > first argument, so drop it and update the callers accordingly.
> >=20
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/processor_perflib.c    |    4 +---
> >  drivers/cpufreq/acpi-cpufreq.c      |    5 ++---
> >  drivers/cpufreq/e_powersaver.c      |    2 +-
> >  drivers/cpufreq/ia64-acpi-cpufreq.c |    5 ++---
> >  drivers/cpufreq/powernow-k7.c       |    4 ++--
> >  drivers/cpufreq/powernow-k8.c       |    5 ++---
> >  drivers/xen/xen-acpi-processor.c    |    4 ++--
> >  include/acpi/processor.h            |    5 +----
> >  8 files changed, 13 insertions(+), 21 deletions(-)
> >=20
>=20
> I wish I can test this patch. However I only have x86 hardware, not a=
ll
> codes can be tested on my side.

Possible build errors should be sorted out by the 0-day testing and the
functional part will be OK if the name of the remaining argument is not
changed in any spot.


> > Index: linux-pm/drivers/xen/xen-acpi-processor.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/xen/xen-acpi-processor.c
> > +++ linux-pm/drivers/xen/xen-acpi-processor.c
> > @@ -563,7 +563,7 @@ err_unregister:
> >  	for_each_possible_cpu(i) {
> >  		struct acpi_processor_performance *perf;
> >  		perf =3D per_cpu_ptr(acpi_perf_data, i);
> > -		acpi_processor_unregister_performance(perf, i);
> > +		acpi_processor_unregister_performance(i);
> >  	}
> >  err_out:
> >  	/* Freeing a NULL pointer is OK: alloc_percpu zeroes. */
> > @@ -582,7 +582,7 @@ static void __exit xen_acpi_processor_ex
> >  	for_each_possible_cpu(i) {
> >  		struct acpi_processor_performance *perf;
> >  		perf =3D per_cpu_ptr(acpi_perf_data, i);
> > -		acpi_processor_unregister_performance(perf, i);
> > +		acpi_processor_unregister_performance(i);
>=20
>=20
> >  	}
> >  	free_acpi_perf_data();
> >  }
> >=20
>=20
> After a simple review, in functions above *perf* is not used anymore,=
 can we just change the codes like below
> 	@@ -580,9 +580,7 @@ static void __exit xen_acpi_processor_exit(void)
>         kfree(acpi_id_present);
>         kfree(acpi_id_cst_present);
>         for_each_possible_cpu(i) {
> -               struct acpi_processor_performance *perf;
> -               perf =3D per_cpu_ptr(acpi_perf_data, i);
> -               acpi_processor_unregister_performance(perf, i);
> +               acpi_processor_unregister_performance(i);
>         }
>         free_acpi_perf_data();

You're right, thanks!

I'll send an update shortly.


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
