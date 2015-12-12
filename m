From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH] cpufreq: tegra: add regulator dependency for T124
Date: Sat, 12 Dec 2015 03:26:57 +0100
Message-ID: <1834718.KShzbrV9CD@vostro.rjw.lan>
References: <2194927.eV2s2QmZs0@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2194927.eV2s2QmZs0@wuerfel>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, December 08, 2015 10:52:45 PM Arnd Bergmann wrote:
> This driver is the only one that calls regulator_sync_voltage(), but it
> can currently be built with CONFIG_REGULATOR disabled, producing
> this build error:
> 
> drivers/cpufreq/tegra124-cpufreq.c: In function 'tegra124_cpu_switch_to_pllx':
> drivers/cpufreq/tegra124-cpufreq.c:68:2: error: implicit declaration of function 'regulator_sync_voltage' [-Werror=implicit-function-declaration]
>   regulator_sync_voltage(priv->vdd_cpu_reg);
> 
> My first attempt was to implement a helper for this function
> for regulator_sync_voltage, but Mark Brown explained:
> 
>    We don't do this for *all* regulator API functions - there's some where
>    using them strongly suggests that there is actually a dependency on
>    the regulator API.  This does seem like it might be falling into the
>    specialist category [...]
>    Looking at the code I'm pretty unclear on what the authors think the
>    use of _sync_voltage() is doing in the first place so it may be even
>    better to just remove the call.  It seems to have been included in the
>    first commit so there's not changelog explaining things and there's
>    no comment either.  I'd *expect* it to be a noop as far as I can see.
> 
> This adds the dependency to make the driver always build successfully
> or not be enabled at all. Alternatively, we could investigate if the
> driver should stop calling regulator_sync_voltage instead.
> 
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

Applied, thanks!

Rafael
