Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A2524A044;
	Wed,  1 Jul 2026 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782890522; cv=none; b=U2Bo2lEBvVxOg2SIWrPma8hyvztCdF+mcUUhNCxyr0ZEx0K8R9CYDw+8YEP8ixskT85VWN1aMDVHOjOE8rjY98/4im/TnezVxDPmBqEOjZgb4OqQhecrA2MUdho+Umw54NR6cnALMCVgXKTHkJvndBuD63Sle+NuT6sLSwo12Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782890522; c=relaxed/simple;
	bh=+cNwgm11FznPrncjQRNZcHw5dsaOhgUFxV8zbLtVkY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLtKxJzwh/5y/o0r0V5V0hF0ZpPN9x0V7yItT+z7dvw4hTQ1B1Ur+4BCeFupLEIUC++HP8onBD997NLX5+QYsbRiS+JJlR5kcZ4Uc/smBKxCFFKRpBaQwAzMk/SZoFfbQrdm1Y/4EDZpTVqnPe+IYS05Osmg0Q58+cQp9Y5iM1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QIhu5f0X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QIhu5f0X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E9A1F000E9;
	Wed,  1 Jul 2026 07:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782890520;
	bh=+A5FeoHPvMoKxGWtjK7lix2wN/9D+Nj3U2MTWDi/HOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QIhu5f0X+BOzRXsbTVauTcUMwj8lIGdIpZJT046yZOCPh4Br4zLHiDTFDL505Ha75
	 JbKsU/X/J+D5+4BZLkP/OiSWwn8M3XR4fwaevGmhKPfew/3aY+kkqdC03XF6j7WJs6
	 hts77ZtUzVOChSfpm1ywlSMEIXF2FfVVnLsnPEec=
Date: Wed, 1 Jul 2026 09:20:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
	tfiga@chromium.org, senozhatsky@chromium.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 2/2] PM: dpm_watchdog: Allow disabling DPM watchdog by
 default
Message-ID: <2026070140-rally-prowling-4d66@gregkh>
References: <20260701045640.3130090-1-tzungbi@kernel.org>
 <20260701045640.3130090-3-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701045640.3130090-3-tzungbi@kernel.org>

On Wed, Jul 01, 2026 at 04:56:40AM +0000, Tzung-Bi Shih wrote:
> Introduce the "dpm_watchdog_enabled" module parameter to allow the DPM
> watchdog to be enabled or disabled at boot time and runtime.

As I say all the time, this isn't the 1990's, please don't add new
module parameters as they are a pain to manage and maintain over time
(as you found out with my rejection of patch 1/2 here...)

> Additionally, introduce the CONFIG_DPM_WATCHDOG_ENABLED Kconfig option
> to set default value of the module parameter at compile time.
> 
> This provides flexibility for systems that want the watchdog code
> compiled in but inactive by default, allowing it to be enabled only when
> needed.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> v5: No changes.
> 
> v4: https://lore.kernel.org/all/20260611021219.2093476-2-tzungbi@kernel.org
> - Rewrite the commit message to indicate the module parameter is the
>   main change in the patch.
> - DPM_WATCHDOG_DEFAULT_ENABLED -> DPM_WATCHDOG_ENABLED.
> 
> v3: https://lore.kernel.org/all/20260608021526.1023248-3-tzungbi@kernel.org
> - Add "PM" tag (was missing).
> - Update the format and specify dependencies in kernel-parameters.txt.
> - Update the help message in Kconfig to reflect that dpm_watchdog_enabled
>   can be set at runtime as well.
> 
> v2: https://lore.kernel.org/all/20260604090756.2884671-3-tzungbi@kernel.org
> - Use module parameter and bool for dpm_watchdog_enabled.
> - Use IS_ENABLED().
> 
> v1: https://lore.kernel.org/all/20260528103215.505795-1-tzungbi@kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
>  drivers/base/power/main.c                       | 11 +++++++++++
>  kernel/power/Kconfig                            | 10 ++++++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b5493a7f8f22..46c20e1b5f05 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -47,6 +47,7 @@
>  	PCI	PCI bus support is enabled.
>  	PCIE	PCI Express support is enabled.
>  	PCMCIA	The PCMCIA subsystem is enabled.
> +	PM	Power Management support is enabled.
>  	PNP	Plug & Play support is enabled.
>  	PPC	PowerPC architecture is enabled.
>  	PPT	Parallel port support is enabled.
> @@ -5354,6 +5355,12 @@ Kernel parameters
>  	pm_debug_messages	[SUSPEND,KNL]
>  			Enable suspend/resume debug messages during boot up.
>  
> +	pm_sleep.dpm_watchdog_enabled=
> +			[PM] Enable or disable the DPM watchdog.  Requires
> +			CONFIG_PM_SLEEP and CONFIG_DPM_WATCHDOG enabled.
> +			Format: <bool>
> +			Default value is set by CONFIG_DPM_WATCHDOG_ENABLED.
> +
>  	pnp.debug=1	[PNP]
>  			Enable PNP debug messages (depends on the
>  			CONFIG_PNP_DEBUG_MESSAGES option).  Change at run-time
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index c6a3300cfb7a..f58945758868 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -535,6 +535,11 @@ module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
>  MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
>  		 "Backtrace all CPUs on DPM watchdog timeout");
>  
> +static bool __read_mostly dpm_watchdog_enabled =
> +				IS_ENABLED(CONFIG_DPM_WATCHDOG_ENABLED);
> +module_param(dpm_watchdog_enabled, bool, 0644);
> +MODULE_PARM_DESC(dpm_watchdog_enabled, "Enable DPM watchdog");
> +
>  static unsigned int __read_mostly dpm_watchdog_timeout = CONFIG_DPM_WATCHDOG_TIMEOUT;
>  static unsigned int __read_mostly dpm_watchdog_warning_timeout =
>  						CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
> @@ -630,6 +635,9 @@ static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
>  {
>  	struct timer_list *timer = &wd->timer;
>  
> +	if (!dpm_watchdog_enabled)
> +		return;
> +
>  	wd->dev = dev;
>  	wd->tsk = current;
>  	wd->fatal = dpm_watchdog_timeout == dpm_watchdog_warning_timeout;
> @@ -648,6 +656,9 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
>  {
>  	struct timer_list *timer = &wd->timer;
>  
> +	if (!dpm_watchdog_enabled)
> +		return;
> +
>  	timer_delete_sync(timer);
>  	timer_destroy_on_stack(timer);
>  }
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 530c897311d4..508ceabc4d2e 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -268,6 +268,16 @@ config DPM_WATCHDOG
>  	  captured in pstore device for inspection in subsequent
>  	  boot session.
>  
> +config DPM_WATCHDOG_ENABLED
> +	bool "Enable DPM watchdog by default"
> +	depends on DPM_WATCHDOG
> +	default y

Only do this if you can not boot without the option enabled, which I do
not think is the case here.

thanks,

greg k-h
