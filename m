From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC PATCH 1/1] acpi: processor_driver: register cooling device
 per package
Date: Tue, 17 May 2016 10:19:44 -0700
Message-ID: <1463505584.28729.198.camel@linux.intel.com>
References: <1463120370-2553-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18110 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbcEQRSz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 May 2016 13:18:55 -0400
In-Reply-To: <1463120370-2553-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net

On Thu, 2016-05-12 at 23:19 -0700, Eduardo Valentin wrote:
> The current throttling strategy is to apply cooling levels
> on all processors in a package. Therefore, if one cooling
> device is requested to cap the frequency, the same request
> is applied to all sibling processors in the same package.
>=20
> For this reason, this patch removes the redundant cooling
> devices, registering only one cooling device per package.
>=20
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
> Srinivas,
>=20
> This is the outcome of our discussion on the Processor cooling
> device.
> As per your suggestion, I am now attempting to register a single
> cooling device per package.
>=20
> The only thing is about the sysfs links. Now the Processor cooling
> device would look like:
> $ ls /sys/class/thermal/cooling_device0/
> cur_state=C2=A0=C2=A0device.0=C2=A0=C2=A0device.1=C2=A0=C2=A0device.2=
=C2=A0=C2=A0device.3=C2=A0=C2=A0max_state=C2=A0=C2=A0power=C2=A0=C2=A0
> subsystem	type=C2=A0=C2=A0uevent
>=20
> Instead of:
>=20
> $ ls /sys/class/thermal/cooling_device0/
> cur_state=C2=A0=C2=A0device=C2=A0=C2=A0max_state=C2=A0=C2=A0power=C2=A0=
=C2=A0subsystem	type=C2=A0=C2=A0uevent
>=20
> This is obviously to keep a link between the cooling device and
> its affected devices. Would this break userspace?
>=20
Conceptually it is fine and should work. I need to run some tests
before I confirm.
Hopefully I can do in next 2 weeks.

Thanks,
Srinivas
> BR,
>=20
> Eduardo Valentin
>=20
> =C2=A0drivers/acpi/processor_driver.c | 40
> +++++++++++++++++++++++++++++++++++++---
> =C2=A01 file changed, 37 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/acpi/processor_driver.c
> b/drivers/acpi/processor_driver.c
> index 11154a3..e1e17de 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -160,9 +160,29 @@ static struct notifier_block acpi_cpu_notifier =3D
> {
> =C2=A0};
> =C2=A0
> =C2=A0#ifdef CONFIG_ACPI_CPU_FREQ_PSS
> +static struct thermal_cooling_device *
> +acpi_pss_register_cooling(struct acpi_processor *pr, struct
> acpi_device *device)
> +{
> +	int i, cpu =3D pr->id;
> +
> +	for_each_online_cpu(i) {
> +		if (topology_physical_package_id(i) =3D=3D
> +		=C2=A0=C2=A0=C2=A0=C2=A0topology_physical_package_id(cpu)) {
> +			struct acpi_processor *pre =3D
> per_cpu(processors, i);
> +
> +			if (pre->cdev && !IS_ERR(pre->cdev))
> +				return pre->cdev;
> +		}
> +	}
> +
> +	return thermal_cooling_device_register("Processor", device,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&processor_cooling_op
> s);
> +}
> +
> =C2=A0static int acpi_pss_perf_init(struct acpi_processor *pr,
> =C2=A0		struct acpi_device *device)
> =C2=A0{
> +	char cpu_id[15];
> =C2=A0	int result =3D 0;
> =C2=A0
> =C2=A0	acpi_processor_ppc_has_changed(pr, 0);
> @@ -172,8 +192,7 @@ static int acpi_pss_perf_init(struct
> acpi_processor *pr,
> =C2=A0	if (pr->flags.throttling)
> =C2=A0		pr->flags.limit =3D 1;
> =C2=A0
> -	pr->cdev =3D thermal_cooling_device_register("Processor",
> device,
> -						=C2=A0=C2=A0=C2=A0&processor_coolin
> g_ops);
> +	pr->cdev =3D acpi_pss_register_cooling(pr, device);
> =C2=A0	if (IS_ERR(pr->cdev)) {
> =C2=A0		result =3D PTR_ERR(pr->cdev);
> =C2=A0		return result;
> @@ -191,9 +210,10 @@ static int acpi_pss_perf_init(struct
> acpi_processor *pr,
> =C2=A0		goto err_thermal_unregister;
> =C2=A0	}
> =C2=A0
> +	snprintf(cpu_id, sizeof(cpu_id), "device.%d", pr->id);
> =C2=A0	result =3D sysfs_create_link(&pr->cdev->device.kobj,
> =C2=A0				=C2=A0=C2=A0=C2=A0&device->dev.kobj,
> -				=C2=A0=C2=A0=C2=A0"device");
> +				=C2=A0=C2=A0=C2=A0cpu_id);
> =C2=A0	if (result) {
> =C2=A0		dev_err(&pr->cdev->device,
> =C2=A0			"Failed to create sysfs link 'device'\n");
> @@ -213,11 +233,25 @@ static int acpi_pss_perf_init(struct
> acpi_processor *pr,
> =C2=A0static void acpi_pss_perf_exit(struct acpi_processor *pr,
> =C2=A0		struct acpi_device *device)
> =C2=A0{
> +	char cpu_id[15];
> +	int i;
> +
> =C2=A0	if (pr->cdev) {
> =C2=A0		sysfs_remove_link(&device->dev.kobj,
> "thermal_cooling");
> +		snprintf(cpu_id, sizeof(cpu_id), "device.%d", pr-
> >id);
> =C2=A0		sysfs_remove_link(&pr->cdev->device.kobj, "device");
> =C2=A0		thermal_cooling_device_unregister(pr->cdev);
> =C2=A0		pr->cdev =3D NULL;
> +
> +		for_each_online_cpu(i) {
> +			if (topology_physical_package_id(i) =3D=3D
> +			=C2=A0=C2=A0=C2=A0=C2=A0topology_physical_package_id(pr->id)) {
> +				struct acpi_processor *pre;
> +
> +				pre =3D per_cpu(processors, i);
> +				pre->cdev =3D NULL;
> +			}
> +		}
> =C2=A0	}
> =C2=A0}
> =C2=A0#else
