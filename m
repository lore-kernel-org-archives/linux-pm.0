From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 2/8] ACPI: Split out ACPI PSS from ACPI Processor driver
Date: Sat, 18 Jul 2015 02:01:40 +0200
Message-ID: <3655608.oFpclyKJ6p@vostro.rjw.lan>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org> <09d1b5cf25ed3117b9e1b8feeb40ddf801557039.1436464513.git.ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60647 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752682AbbGQXe7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jul 2015 19:34:59 -0400
In-Reply-To: <09d1b5cf25ed3117b9e1b8feeb40ddf801557039.1436464513.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: jaswinder.singh@linaro.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, sudeep.holla@arm.com

On Thursday, July 09, 2015 02:04:18 PM Ashwin Chaugule wrote:
> The ACPI processor driver is currently tied too closely
> to the ACPI P-states (PSS) and other related constructs
> for controlling CPU performance.
> 
> The newer ACPI specification (v5.1 onwards) introduces
> alternative methods to PSS. These new mechanisms are
> described within each ACPI Processor object and so they
> need to be scanned whenever a new Processor object is detected.
> This patch introduces a new Kconfig symbol to allow for
> finer configurability among the two options for controlling
> performance states. There is no change in functionality and
> the option is auto-selected by the architecture Kconfig files.
> 
> The following patchwork introduces CPPC: A newer method of
> controlling CPU performance. The OS is not expected to support
> CPPC and PSS at runtime. So the kconfig option lets us make
> these two mutually exclusive at compile time.
> 
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  arch/x86/Kconfig                |  1 +
>  drivers/acpi/Kconfig            | 19 ++++++---
>  drivers/acpi/Makefile           |  6 +--
>  drivers/acpi/processor_driver.c | 86 +++++++++++++++++++++++++------------
>  drivers/cpufreq/Kconfig         |  2 +-
>  drivers/cpufreq/Kconfig.x86     |  2 +
>  include/acpi/processor.h        | 94 +++++++++++++++++++++++++++--------------
>  7 files changed, 142 insertions(+), 68 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 226d569..93d150d 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -143,6 +143,7 @@ config X86
>  	select ACPI_LEGACY_TABLES_LOOKUP if ACPI
>  	select X86_FEATURE_NAMES if PROC_FS
>  	select SRCU
> +	select ACPI_CPU_FREQ_PSS if ACPI
>  
>  config INSTRUCTION_DECODER
>  	def_bool y
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ab2cbb5..00748dc 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -166,17 +166,26 @@ config ACPI_DOCK
>  	  This driver supports ACPI-controlled docking stations and removable
>  	  drive bays such as the IBM Ultrabay and the Dell Module Bay.
>  
> +config ACPI_CPU_FREQ_PSS
> +	bool
> +	depends on ACPI_PROCESSOR && CPU_FREQ
> +	select THERMAL
> +	help
> +	  This driver implements ACPI methods for controlling CPU performance
> +	  using PSS methods as described in the ACPI spec. It also enables support
> +	  for ACPI based performance throttling (TSS) and ACPI based thermal
> +	  monitoring. It is required by several flavors of cpufreq
> +	  performance-state drivers.

So are you not agreeing with what I've said for a few times already or are you
just not listening?

This option should *not* be user-selectable.  So please drop the help part
and make it look like ACPI_SLEEP, for example.

Thanks,
Rafael

