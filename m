From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: enable ARM drivers on arm64
Date: Sun, 02 Mar 2014 01:03:25 +0100
Message-ID: <1789818.fd7lIbF9Ps@vostro.rjw.lan>
References: <1393208877-15797-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1393208877-15797-1-git-send-email-broonie@kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Monday, February 24, 2014 11:27:57 AM Mark Brown wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Enable cpufreq and power kconfig menus on arm64 along with arm cpufreq
> drivers. The power menu is needed for OPP support. At least on Calxeda
> systems, the same cpufreq driver is used for arm and arm64 based
> systems.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Mark Brown <broonie@linaro.org>

Queued up for 3.15, thanks!

> ---
>  arch/arm64/Kconfig      | 8 ++++++++
>  drivers/cpufreq/Kconfig | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fea7b47..939e95a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -327,6 +327,14 @@ source "drivers/cpuidle/Kconfig"
>  
>  endmenu
>  
> +menu "Power management options"
> +
> +source "kernel/power/Kconfig"
> +
> +source "drivers/cpufreq/Kconfig"
> +
> +endmenu
> +
>  source "net/Kconfig"
>  
>  source "drivers/Kconfig"
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 4b029c0..1fbe11f 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -200,7 +200,7 @@ source "drivers/cpufreq/Kconfig.x86"
>  endmenu
>  
>  menu "ARM CPU frequency scaling drivers"
> -depends on ARM
> +depends on ARM || ARM64
>  source "drivers/cpufreq/Kconfig.arm"
>  endmenu
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
