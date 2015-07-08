From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 2/7] ACPI: Make ACPI processor driver more extensible
Date: Wed, 08 Jul 2015 03:07:15 +0200
Message-ID: <2138469.Io9yItSdst@vostro.rjw.lan>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org> <9e352cbe2feac01158a21511bac5c544dc2f29e2.1434398373.git.ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62886 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753055AbbGHAks (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jul 2015 20:40:48 -0400
In-Reply-To: <9e352cbe2feac01158a21511bac5c544dc2f29e2.1434398373.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: jaswinder.singh@linaro.org, linux-pm@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linux-acpi@vger.kernel.org, viresh.kumar@linaro.org, sudeep.holla@arm.com

On Monday, June 15, 2015 04:09:06 PM Ashwin Chaugule wrote:
> The ACPI processor driver is currently tied too closely
> to the ACPI C-states (CST), P-states (PSS) and other related
> constructs for controlling CPU idle and CPU performance.
> 
> The newer ACPI specification (v5.1 onwards) introduces
> alternative methods to CST and PSS. These new mechanisms
> are described within each ACPI Processor object and so they
> need to be scanned whenever a new Processor object is detected.
> This patch introduces two new Kconfig symbols to allow for
> finer configurability among the various options for controlling
> CPU idle and performance states. There is no change in functionality
> and these options are defaulted to enabled to maintain previous
> behaviour.
> 
> The following patchwork introduces CPPC: A newer method of
> controlling CPU performance. The OS is not expected to support CPPC
> and PSS at runtime. So the kconfig option lets us make these two
> mutually exclusive at compile time.
> 
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Reviewed-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/Kconfig            |  31 +++++++++--
>  drivers/acpi/Makefile           |   7 ++-
>  drivers/acpi/processor_driver.c |  86 ++++++++++++++++++----------
>  drivers/cpufreq/Kconfig         |   2 +-
>  drivers/cpufreq/Kconfig.x86     |   2 +
>  include/acpi/processor.h        | 120 ++++++++++++++++++++++++++++------------
>  6 files changed, 176 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ab2cbb5..5942754 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -166,18 +166,39 @@ config ACPI_DOCK
>  	  This driver supports ACPI-controlled docking stations and removable
>  	  drive bays such as the IBM Ultrabay and the Dell Module Bay.
>  
> -config ACPI_PROCESSOR
> -	tristate "Processor"
> -	select THERMAL
> -	select CPU_IDLE
> +config ACPI_CST
> +	bool "ACPI C states (CST) driver"
> +	depends on ACPI_PROCESSOR
>  	depends on X86 || IA64
> +	select CPU_IDLE
>  	default y
>  	help
>  	  This driver installs ACPI as the idle handler for Linux and uses
>  	  ACPI C2 and C3 processor states to save power on systems that
> -	  support it.  It is required by several flavors of cpufreq
> +	  support it.
> +
> +config ACPI_PSS
> +	bool "ACPI P States (PSS) driver"
> +	depends on ACPI_PROCESSOR
> +	depends on X86 || IA64
> +	select THERMAL
> +	default y
> +	help
> +	  This driver implements ACPI methods for controlling CPU performance
> +	  using PSS methods as described in the ACPI spec. It also enables support
> +	  for ACPI based performance throttling (TSS) and ACPI based thermal
> +	  monitoring. It is required by several flavors of cpufreq
>  	  performance-state drivers.

For starters, I don't like these new Kconfig options.

Isn't there a way to implement what you need without adding them?

Rafael

