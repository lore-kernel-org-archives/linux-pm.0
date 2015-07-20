From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: Re: [PATCH] cpufreq: ia64: Fix a memory leak in acpi_cpufreq_cpu_exit
Date: Mon, 20 Jul 2015 16:13:40 +0800
Message-ID: <55ACADB4.60102@intel.com>
References: <55AC9424.1070304@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25857 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755280AbbGTIQY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 20 Jul 2015 04:16:24 -0400
In-Reply-To: <55AC9424.1070304@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>, "mnipxh@163.com" <mnipxh@163.com>

hi, all
	ia64-acpi-cpufreq has similar issues with acpi-cpufreq. Maybe we need =
make other two patches.
Replace struct cpufreq_acpi_io *acpi_io_data[NR_CPUS] with policy->driv=
er_data, and Fix an acpi perf unregister issue.

As two patches
[1/2] Drop the unused first argument of acpi_processor_unregister_perfo=
rmance().
[2/2] Drop the now redundant acpi_data pointer from acpi_cpufreq_data.
are going into the kernel tree, If I send my patches to you now, there =
will be some conflicts.

So I may wait for a couple of days until all previous patches merged in=
to kernel tree.

thanks
xinhui

On 2015=E5=B9=B407=E6=9C=8820=E6=97=A5 14:24, Pan Xinhui wrote:
> From: Pan Xinhui <xinhuix.pan@intel.com>
>=20
> freq_table should be alloced in ->init and freed in ->exit. However i=
t
> does not be freed. Fix this memory leak in acpi_cpufreq_cpu_exit.
>=20
> Signed-off-by: Pan Xinhui <xinhuix.pan@intel.com>
> ---
>  drivers/cpufreq/ia64-acpi-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia=
64-acpi-cpufreq.c
> index 27cef0c..e02bd15 100644
> --- a/drivers/cpufreq/ia64-acpi-cpufreq.c
> +++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
> @@ -334,6 +334,7 @@ acpi_cpufreq_cpu_exit (
>  		acpi_io_data[policy->cpu] =3D NULL;
>  		acpi_processor_unregister_performance(&data->acpi_data,
>  		                                      policy->cpu);
> +		kfree(policy->freq_table);
>  		kfree(data);
>  	}
> =20
>=20
