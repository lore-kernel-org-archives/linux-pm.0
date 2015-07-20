From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 7/8] CPPC: Probe for CPPC tables for each ACPI Processor
 object
Date: Mon, 20 Jul 2015 15:22:25 +0100
Message-ID: <55AD0421.2090206@arm.com>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org> <f9947988ad2e8787da4bec32b71a59a65ce45074.1436464513.git.ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <f9947988ad2e8787da4bec32b71a59a65ce45074.1436464513.git.ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org



On 09/07/15 19:04, Ashwin Chaugule wrote:
> For each detected ACPI Processor object (ACPI0007), search its
> device handle for CPPC specific tables (i.e. _CPC) and extract
> CPU specific performance capabilities.
>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Reviewed-by: Al Stone <al.stone@linaro.org>
> ---
>   arch/arm64/Kconfig              | 1 +
>   drivers/acpi/Kconfig            | 2 +-
>   drivers/acpi/processor_driver.c | 4 ++++
>   include/acpi/processor.h        | 9 +++++++++
>   4 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7796af4..feff114 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -83,6 +83,7 @@ config ARM64
>   	select SPARSE_IRQ
>   	select SYSCTL_EXCEPTION_TRACE
>   	select HAVE_CONTEXT_TRACKING
> +	select ACPI_CPPC_LIB if ACPI

This could be separate patch. It's doesn't match with $subject
and usually better to keep arm64 specific changes separate.

>   	help
>   	  ARM 64-bit (AArch64) Linux support.
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 54d73bb..097c02a 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -198,7 +198,7 @@ config ACPI_CPPC_LIB
>   config ACPI_PROCESSOR
>   	tristate "Processor"
>   	select CPU_IDLE if ACPI_PROCESSOR_IDLE
> -	depends on X86 || IA64
> +	depends on X86 || IA64 || ARM64

Ditto

Regards,
Sudeep
