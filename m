From: Hoan Tran <hotran@apm.com>
Subject: Re: [PATCH 1/5] acpi: cppc: Allow build with ACPI_CPU_FREQ_PSS config
Date: Fri, 12 Aug 2016 09:35:09 -0700
Message-ID: <CAFHUOYx55WhrwaqpB7Jh8V_fnR1xVW=RWf9ZsCnJZFJt_JbpBw@mail.gmail.com>
References: <1470874646-70570-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1470874646-70570-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:33605 "EHLO
	mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbcHLQlG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Aug 2016 12:41:06 -0400
Received: by mail-ua0-f181.google.com with SMTP id 74so50522091uau.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Aug 2016 09:41:06 -0700 (PDT)
In-Reply-To: <1470874646-70570-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org, linux acpi <linux-acpi@vger.kernel.org>, linux-pm@vger.kernel.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

Hi Srinivas,

On Wed, Aug 10, 2016 at 5:17 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> Some newer x86 platforms have support for both _CPC and _PSS object. So
> kernel config can have both ACPI_CPU_FREQ_PSS and ACPI_CPPC_LIB. So remove
> restriction for ACPI_CPPC_LIB to build only when ACPI_CPU_FREQ_PSS is not
> defined.
> Also for legacy systems with only _PSS, we shouldn't bail out if
> acpi_cppc_processor_probe() fails, if ACPI_CPU_FREQ_PSS is also defined.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/acpi/Kconfig            | 1 -
>  drivers/acpi/processor_driver.c | 5 ++++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 445ce28..c6bb6aa 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -227,7 +227,6 @@ config ACPI_MCFG
>  config ACPI_CPPC_LIB
>         bool
>         depends on ACPI_PROCESSOR
> -       depends on !ACPI_CPU_FREQ_PSS

>From ACPI 6.1 spec, if _CPC is present, its use supersedes the use of
PSS. So I think, config ACPI_CPU_FREQ_PSS should depend on
!ACPI_CPPC_LIB.

Thanks
Hoan

>         select MAILBOX
>         select PCC
>         help
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 0553aee..0e0b629 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -245,8 +245,11 @@ static int __acpi_processor_start(struct acpi_device *device)
>                 return 0;
>
>         result = acpi_cppc_processor_probe(pr);
> -       if (result)
> +       if (result) {
> +#ifndef CONFIG_ACPI_CPU_FREQ_PSS
>                 return -ENODEV;
> +#endif
> +       }
>
>         if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
>                 acpi_processor_power_init(pr);
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
