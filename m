From: Alexey Klimov <alexey.klimov@arm.com>
Subject: Re: [PATCH 1/5] acpi: cppc: Allow build with ACPI_CPU_FREQ_PSS config
Date: Fri, 12 Aug 2016 10:13:37 +0100
Message-ID: <20160812091337.GA7017@arm.com>
References: <1470874646-70570-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1470874646-70570-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470874646-70570-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, pprakash@codeaurora.org, sudeep.holla@arm.com
List-Id: linux-pm@vger.kernel.org


(adding Sudeep and Prashanth in c/c)

On Wed, Aug 10, 2016 at 05:17:22PM -0700, Srinivas Pandruvada wrote:
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
>  	bool
>  	depends on ACPI_PROCESSOR
> -	depends on !ACPI_CPU_FREQ_PSS
>  	select MAILBOX
>  	select PCC
>  	help
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 0553aee..0e0b629 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -245,8 +245,11 @@ static int __acpi_processor_start(struct acpi_device *device)
>  		return 0;
>  
>  	result = acpi_cppc_processor_probe(pr);
> -	if (result)
> +	if (result) {
> +#ifndef CONFIG_ACPI_CPU_FREQ_PSS
>  		return -ENODEV;
> +#endif
> +	}
>  
>  	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
>  		acpi_processor_power_init(pr);

If PSS is not defined and kernel fails to probe CPPC then why we should not
execute acpi_processor_power_init()?

Best regards,
Alexey

