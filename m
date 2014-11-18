From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] cpufreq: Remove architecture specific menu entries
Date: Wed, 19 Nov 2014 00:31:27 +0100
Message-ID: <1469681.jS4gM4LGBu@vostro.rjw.lan>
References: <5fa0e88cfecffe8ae45f2bde0aceb96cd65407e7.1416021588.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54892 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932532AbaKRXKW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Nov 2014 18:10:22 -0500
In-Reply-To: <5fa0e88cfecffe8ae45f2bde0aceb96cd65407e7.1416021588.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, scottwood@freescale.com, Yuantian.Tang@freescale.com

On Saturday, November 15, 2014 08:50:44 AM Viresh Kumar wrote:
> CPUFreq driver's Kconfig entries are added in Kconfig.<arch> files and they are
> all included from the main Kconfig file using a menu entry. This creates another
> level of (unnecessary) hierarchy within the menuconfig entries.
> 
> The problem occurs when there are drivers usable across architectures. Either
> their config entry is duplicated in all the supported architectures or is put
> into the main Kconfig entry. With the later one, we have menuconfig entries for
> drivers at two levels then.
> 
> Fix these issues by getting rid of another level of menuconfig hierarchy and
> populate all drivers within the main cpufreq menu. To clearly distinguish where
> the drivers start from, also add a comment that will appear in menuconfig.
> 
> Reported-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Suggested-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for 3.19-rc1, thanks!

> ---
> V2: Add: comment "CPU frequency scaling drivers"
> 
>  drivers/cpufreq/Kconfig | 50 +++++++++++++++++++------------------------------
>  1 file changed, 19 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 3489f8f..230a912 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -183,6 +183,8 @@ config CPU_FREQ_GOV_CONSERVATIVE
>  
>  	  If in doubt, say N.
>  
> +comment "CPU frequency scaling drivers"
> +
>  config CPUFREQ_DT
>  	tristate "Generic DT based cpufreq driver"
>  	depends on HAVE_CLK && OF
> @@ -196,19 +198,19 @@ config CPUFREQ_DT
>  
>  	  If in doubt, say N.
>  
> -menu "x86 CPU frequency scaling drivers"
> -depends on X86
> +if X86
>  source "drivers/cpufreq/Kconfig.x86"
> -endmenu
> +endif
>  
> -menu "ARM CPU frequency scaling drivers"
> -depends on ARM || ARM64
> +if ARM || ARM64
>  source "drivers/cpufreq/Kconfig.arm"
> -endmenu
> +endif
>  
> -menu "AVR32 CPU frequency scaling drivers"
> -depends on AVR32
> +if PPC32 || PPC64
> +source "drivers/cpufreq/Kconfig.powerpc"
> +endif
>  
> +if AVR32
>  config AVR32_AT32AP_CPUFREQ
>  	bool "CPU frequency driver for AT32AP"
>  	depends on PLATFORM_AT32AP
> @@ -216,12 +218,9 @@ config AVR32_AT32AP_CPUFREQ
>  	help
>  	  This enables the CPU frequency driver for AT32AP processors.
>  	  If in doubt, say N.
> +endif
>  
> -endmenu
> -
> -menu "CPUFreq processor drivers"
> -depends on IA64
> -
> +if IA64
>  config IA64_ACPI_CPUFREQ
>  	tristate "ACPI Processor P-States driver"
>  	depends on ACPI_PROCESSOR
> @@ -232,12 +231,9 @@ config IA64_ACPI_CPUFREQ
>  	For details, take a look at <file:Documentation/cpu-freq/>.
>  
>  	If in doubt, say N.
> +endif
>  
> -endmenu
> -
> -menu "MIPS CPUFreq processor drivers"
> -depends on MIPS
> -
> +if MIPS
>  config LOONGSON2_CPUFREQ
>  	tristate "Loongson2 CPUFreq Driver"
>  	help
> @@ -249,16 +245,9 @@ config LOONGSON2_CPUFREQ
>  	  For details, take a look at <file:Documentation/cpu-freq/>.
>  
>  	  If in doubt, say N.
> +endif
>  
> -endmenu
> -
> -menu "PowerPC CPU frequency scaling drivers"
> -depends on PPC32 || PPC64
> -source "drivers/cpufreq/Kconfig.powerpc"
> -endmenu
> -
> -menu "SPARC CPU frequency scaling drivers"
> -depends on SPARC64
> +if SPARC64
>  config SPARC_US3_CPUFREQ
>  	tristate "UltraSPARC-III CPU Frequency driver"
>  	help
> @@ -276,10 +265,9 @@ config SPARC_US2E_CPUFREQ
>  	  For details, take a look at <file:Documentation/cpu-freq>.
>  
>  	  If in doubt, say N.
> -endmenu
> +endif
>  
> -menu "SH CPU Frequency scaling"
> -depends on SUPERH
> +if SUPERH
>  config SH_CPU_FREQ
>  	tristate "SuperH CPU Frequency driver"
>  	help
> @@ -293,7 +281,7 @@ config SH_CPU_FREQ
>  	  For details, take a look at <file:Documentation/cpu-freq>.
>  
>  	  If unsure, say N.
> -endmenu
> +endif
>  
>  endif
>  endmenu
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
