From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 3/5] ARM: tegra: Create tegra20-cpufreq device on
 Tegra30
Date: Wed, 17 Oct 2018 09:49:40 +0100
Message-ID: <9ec51c2d-02f6-0988-0940-0ec31d22f697@nvidia.com>
References: <20180830194356.14059-1-digetx@gmail.com>
 <20180830194356.14059-4-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830194356.14059-4-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 30/08/2018 20:43, Dmitry Osipenko wrote:
> Tegra20-cpufreq driver require a platform device in order to be loaded,
> instantiate a simple platform device for the driver during of the machines
> late initialization. Driver now supports Tegra30 SoC's, hence create the
> device on Tegra30 machines.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/tegra.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
> index 67d8ae60ac67..b559e22eab76 100644
> --- a/arch/arm/mach-tegra/tegra.c
> +++ b/arch/arm/mach-tegra/tegra.c
> @@ -111,6 +111,10 @@ static void __init tegra_dt_init_late(void)
>  	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
>  	    of_machine_is_compatible("nvidia,tegra20"))
>  		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
> +
> +	if (IS_ENABLED(CONFIG_ARCH_TEGRA_3x_SOC) &&
> +	    of_machine_is_compatible("nvidia,tegra30"))
> +		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
>  }
>  
>  static const char * const tegra_dt_board_compat[] = {

Not sure why you would do this if now the driver only works with DT. Am
I missing something?

Cheers
Jon

-- 
nvpublic
