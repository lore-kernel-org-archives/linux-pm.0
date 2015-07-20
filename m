From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: Re: [PATCH 1/2] ACPI / processor: Drop an unused argument of a cleanup
 routine
Date: Mon, 20 Jul 2015 09:45:30 +0800
Message-ID: <55AC52BA.8070205@intel.com>
References: <10273534.kyzK8rhvUz@vostro.rjw.lan> <15976638.8lfDjd5ol2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <15976638.8lfDjd5ol2@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

hi, Rafael
	thanks for your nice work :)
On 2015=E5=B9=B407=E6=9C=8818=E6=97=A5 09:14, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> acpi_processor_unregister_performance() actually doesn't use its
> first argument, so drop it and update the callers accordingly.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/processor_perflib.c    |    4 +---
>  drivers/cpufreq/acpi-cpufreq.c      |    5 ++---
>  drivers/cpufreq/e_powersaver.c      |    2 +-
>  drivers/cpufreq/ia64-acpi-cpufreq.c |    5 ++---
>  drivers/cpufreq/powernow-k7.c       |    4 ++--
>  drivers/cpufreq/powernow-k8.c       |    5 ++---
>  drivers/xen/xen-acpi-processor.c    |    4 ++--
>  include/acpi/processor.h            |    5 +----
>  8 files changed, 13 insertions(+), 21 deletions(-)
>=20

I wish I can test this patch. However I only have x86 hardware, not all=
 codes can be tested on my side.

> Index: linux-pm/drivers/xen/xen-acpi-processor.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/xen/xen-acpi-processor.c
> +++ linux-pm/drivers/xen/xen-acpi-processor.c
> @@ -563,7 +563,7 @@ err_unregister:
>  	for_each_possible_cpu(i) {
>  		struct acpi_processor_performance *perf;
>  		perf =3D per_cpu_ptr(acpi_perf_data, i);
> -		acpi_processor_unregister_performance(perf, i);
> +		acpi_processor_unregister_performance(i);
>  	}
>  err_out:
>  	/* Freeing a NULL pointer is OK: alloc_percpu zeroes. */
> @@ -582,7 +582,7 @@ static void __exit xen_acpi_processor_ex
>  	for_each_possible_cpu(i) {
>  		struct acpi_processor_performance *perf;
>  		perf =3D per_cpu_ptr(acpi_perf_data, i);
> -		acpi_processor_unregister_performance(perf, i);
> +		acpi_processor_unregister_performance(i);


>  	}
>  	free_acpi_perf_data();
>  }
>=20

After a simple review, in functions above *perf* is not used anymore, c=
an we just change the codes like below
	@@ -580,9 +580,7 @@ static void __exit xen_acpi_processor_exit(void)
        kfree(acpi_id_present);
        kfree(acpi_id_cst_present);
        for_each_possible_cpu(i) {
-               struct acpi_processor_performance *perf;
-               perf =3D per_cpu_ptr(acpi_perf_data, i);
-               acpi_processor_unregister_performance(perf, i);
+               acpi_processor_unregister_performance(i);
        }
        free_acpi_perf_data();

thanks
xinhui
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
