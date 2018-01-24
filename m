From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH 4/8] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
Date: Wed, 24 Jan 2018 16:34:41 +0000
Message-ID: <20180124163441.7sqq7qny66d6sqrz@oak.lan>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-5-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516721671-16360-5-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 23, 2018 at 04:34:27PM +0100, Daniel Lezcano wrote:
> The next changes will add new way to cool down a CPU. In order to
> sanitize and make the overall cpu cooling code consistent and robust
> we must prevent the cpu cooling devices to co-exists with the same
> purpose at the same time in the kernel.
> 
> Make the CPU cooling device a choice in the Kconfig, so only one CPU
> cooling strategy can be chosen.

I puzzled by the role of Kconfig here.

IIUC a distro kernel will always be forced to select the combo strategy 
otherwise it will never be able to cool systems that don't have cpufreq
(I hope the combo strategy treats such system as a special case with
only one OPP).

This raises the question what the other options (cpufreq-only
idle-injection-only) are for? Are they just for petrol heads who want to
save a few bytes of code or is idle-injection undesirable for some
users.

If the later, how can a distro kernel mitigate the undesired effects
whilst still selecting the combo strategy.


Daniel.


> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Kconfig | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 315ae29..925e73b 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -142,17 +142,31 @@ config THERMAL_GOV_POWER_ALLOCATOR
>  	  allocating and limiting power to devices.
>  
>  config CPU_THERMAL
> -	bool "generic cpu cooling support"
> -	depends on CPU_FREQ
> +	bool "Generic cpu cooling support"
>  	depends on THERMAL_OF
>  	help
> +	  Enable the CPU cooling features. If the system has no active
> +	  cooling device available, this option allows to use the CPU
> +	  as a cooling device.
> +
> +choice
> +	prompt "CPU cooling strategies"
> +	depends on CPU_THERMAL
> +	default CPU_FREQ_THERMAL
> +	help
> +	  Select the CPU cooling strategy.
> +
> +config CPU_FREQ_THERMAL
> +        bool "CPU frequency cooling strategy"
> +	depends on CPU_FREQ
> +	help
>  	  This implements the generic cpu cooling mechanism through frequency
>  	  reduction. An ACPI version of this already exists
>  	  (drivers/acpi/processor_thermal.c).
>  	  This will be useful for platforms using the generic thermal interface
>  	  and not the ACPI interface.
>  
> -	  If you want this support, you should say Y here.

... this may not be great advice... if you think you want this support
then you *probably* actually want the comboappears to be terrible advice.

This cooling strategies should only be selected by petrolheads making a 
device specific *and* are obsessive about code size.

The 
> +endchoice
>  
>  config CLOCK_THERMAL
>  	bool "Generic clock cooling support"
> -- 
> 2.7.4
> 
