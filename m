From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [resend] cpuidle: ACPI processor idle regression
Date: Thu, 30 May 2013 18:56:59 +0200
Message-ID: <51A784DB.9040805@linaro.org>
References: <51A75830.30007@linaro.org> <41543089.RHFiQpfZdy@vostro.rjw.lan> <2514002.nHT3FtHL0W@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35028 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144Ab3E3Q5G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2013 12:57:06 -0400
Received: by mail-wi0-f176.google.com with SMTP id hr14so4768919wib.9
        for <linux-pm@vger.kernel.org>; Thu, 30 May 2013 09:57:03 -0700 (PDT)
In-Reply-To: <2514002.nHT3FtHL0W@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, toshi.kani@hp.com, linux-pm@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 05/30/2013 06:35 PM, Rafael J. Wysocki wrote:
> On Thursday, May 30, 2013 04:56:18 PM Rafael J. Wysocki wrote:
>> On Thursday, May 30, 2013 03:46:24 PM Daniel Lezcano wrote:
>>>
>>> Sorry, a bad copy/paste address for Rafael.
>>>
>>> ----
>>>
>>> Hi all,
>>>
>>> while testing the processor_idle for ACPI, I noticed the states usa=
ge is
>>> not used for cpuidle in sysfs.
>>>
>>> Reproduced on Lenovo x230, with a i7-3520M CPU @ 2.90GHz without th=
e
>>> intel_idle driver.
>>>
>>> After git-bisecting, the commit where this regression occurs is:
>>
>> Reproduced and investigating that.
>=20
> The appended patch fixes this for me.  Can you please verify?

Yes, verified. It fixes the issue for me too.

Thanks !

> ---
>  drivers/acpi/acpi_processor.c   |    5 +++++
>  drivers/acpi/processor_driver.c |    3 ---
>  2 files changed, 5 insertions(+), 3 deletions(-)
>=20
> Index: linux-pm/drivers/acpi/processor_driver.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/processor_driver.c
> +++ linux-pm/drivers/acpi/processor_driver.c
> @@ -78,9 +78,6 @@ static struct device_driver acpi_process
>  	.remove =3D acpi_processor_stop,
>  };
> =20
> -DEFINE_PER_CPU(struct acpi_processor *, processors);
> -EXPORT_PER_CPU_SYMBOL(processors);
> -
>  static void acpi_processor_notify(acpi_handle handle, u32 event, voi=
d *data)
>  {
>  	struct acpi_device *device =3D data;
> Index: linux-pm/drivers/acpi/acpi_processor.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/acpi_processor.c
> +++ linux-pm/drivers/acpi/acpi_processor.c
> @@ -29,6 +29,9 @@
> =20
>  ACPI_MODULE_NAME("processor");
> =20
> +DEFINE_PER_CPU(struct acpi_processor *, processors);
> +EXPORT_PER_CPU_SYMBOL(processors);
> +
>  /* -----------------------------------------------------------------=
---------
>                                  Errata Handling
>     -----------------------------------------------------------------=
--------- */
> @@ -387,6 +390,7 @@ static int __cpuinit acpi_processor_add(
>  	 * checks.
>  	 */
>  	per_cpu(processor_device_array, pr->id) =3D device;
> +	per_cpu(processors, pr->id) =3D pr;
> =20
>  	dev =3D get_cpu_device(pr->id);
>  	result =3D acpi_bind_one(dev, pr->handle);
> @@ -406,6 +410,7 @@ static int __cpuinit acpi_processor_add(
>   err:
>  	free_cpumask_var(pr->throttling.shared_cpu_map);
>  	device->driver_data =3D NULL;
> +	per_cpu(processors, pr->id) =3D NULL;
>   err_free_pr:
>  	kfree(pr);
>  	return result;
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

