From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 2/3] cpufreq: Remove unused function __cpufreq_driver_getavg
Date: Tue, 4 Jun 2013 10:49:06 +0530
Message-ID: <CAKohpomTRdHdKN3QUf0ba+gFXrEr=PbD4cJc8NSyNPmxfnUsMQ@mail.gmail.com>
References: <51ACF2F1.1050600@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:61099 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab3FDFTH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2013 01:19:07 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so1571743oag.29
        for <linux-pm@vger.kernel.org>; Mon, 03 Jun 2013 22:19:06 -0700 (PDT)
In-Reply-To: <51ACF2F1.1050600@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org

On 4 June 2013 01:18, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> Calculation of frequency target in ondemand governor changed and it is

s/frequency target/target frequency

> independent from measured average frequency.
>
> Remove unused__cpufreq_driver_getavg function and getavg member from
> cpufreq_driver struct. Also, remove the callback getavg in
> acpi_cpufreq_driver.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/Makefile       |  2 +-
>  drivers/cpufreq/acpi-cpufreq.c |  5 -----
>  drivers/cpufreq/cpufreq.c      | 12 ------------
>  include/linux/cpufreq.h        |  6 ------
>  4 files changed, 1 insertion(+), 24 deletions(-)
>
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 6ad0b91..aebd4ef 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -23,7 +23,7 @@ obj-$(CONFIG_GENERIC_CPUFREQ_CPU0)    += cpufreq-cpu0.o
>  # powernow-k8 can load then. ACPI is preferred to all other hardware-specific drivers.
>  # speedstep-* is preferred over p4-clockmod.
>
> -obj-$(CONFIG_X86_ACPI_CPUFREQ)         += acpi-cpufreq.o mperf.o

Should this be done in 3/3 ?
