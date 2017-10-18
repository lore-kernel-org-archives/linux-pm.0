From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 2/7] ACPI: Enable PPTT support on ARM64
Date: Wed, 18 Oct 2017 17:47:23 +0100
Message-ID: <20171018164723.GA15924@red-moon>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-3-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171012194856.13844-3-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 12, 2017 at 02:48:51PM -0500, Jeremy Linton wrote:
> Now that we have a PPTT parser, in preparation for its use
> on arm64, lets build it.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/Kconfig         | 1 +
>  drivers/acpi/Makefile      | 1 +
>  drivers/acpi/arm64/Kconfig | 3 +++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0df64a6a56d4..68c9d1289735 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -7,6 +7,7 @@ config ARM64
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>  	select ACPI_MCFG if ACPI
>  	select ACPI_SPCR_TABLE if ACPI
> +	select ACPI_PPTT if ACPI
>  	select ARCH_CLOCKSOURCE_DATA
>  	select ARCH_HAS_DEBUG_VIRTUAL
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 90265ab4437a..c92a0c937551 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>  obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
> +obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
>  
>  # processor has its own "processor." module_param namespace
>  processor-y			:= processor_driver.o
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index 5a6f80fce0d6..74b855a669ea 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -7,3 +7,6 @@ config ACPI_IORT
>  
>  config ACPI_GTDT
>  	bool
> +
> +config ACPI_PPTT
> +	bool
> \ No newline at end of file

I do not understand the logic. Why should we have a Kconfig option
in drivers/acpi/arm64 for code in drivers/acpi ?

AFAIK PPTT is not an ACPI ARM64 specific binding.

Lorenzo
