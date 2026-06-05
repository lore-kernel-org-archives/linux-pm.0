Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF32D368D75;
	Fri,  5 Jun 2026 04:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780635195; cv=none; b=FNsWdPsza54cc0Lp12keMCk5rtwt5UbzNcrGI8shhiEXCVOhk8ZSXIZam3dzWHmTbhhxCCi9NzmoYeeLAxgaMWgVmehMYE2MEWVUENmZhYNollI7hoBYTV6MedilIeWcHIwn6TgTblR9twWQUvAGH/hrUfQrDtljFtAtD3GiYUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780635195; c=relaxed/simple;
	bh=CLvg2uy4UzL2Ky0Kq5T+JVLnh3GvVbzAkwFSuFuYMmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5QTT9mRFZ6O6VVxJIedt05fNHHd0jo88EeXGotFnrygHOGI/HotE9fKprjSfNC9QOcRT3wZIdgpZTdLHtB/M5pOYOgumw0qNh2pC0QhiKaI9+dpFLdpq42HJuKBM8CYQfJmpV+jnog/tRQaAAR/0bYGnxzPcx7omQ6gh7jTKLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oV6D0wZF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oV6D0wZF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=AVjMntonTKwkpZPMAQhk4yRR4MgCRMTSSg9MmjTAhOM=; b=oV6D0wZF0u4O1FlGzAyjSVnSVv
	xyOwQxUl3s2aA7EM82tq/ah//8guYXte7gBCwCRTwCU+O39wgssG9TagYtZo6lhnk7tD5GPYUulYy
	eylN4EtZjLGC7+db9BiQQsUaaAawOa8Rph9/wtDRK93GTGxKPDNmH2BClDQNP0M2ucyA5bJ8lz0+g
	EbRORcB/URnLXeDFFZFRryW0fFX/mB/brB7XcoB5UUhb+7hyY2jqtOM4QCZQdSDnZ39g0FohvseIE
	WlAijI+A/fBCJzSfsZkM+Otdm8CNWAdEzFPDgoLaD9Imb0ummEy/Pb71h96mRXY5MVo1H3cE1fKUn
	db/uQL/Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVMYT-000000005AZ-1Ke3;
	Fri, 05 Jun 2026 04:53:13 +0000
Message-ID: <32fda49e-f246-4fae-9e4e-05c12fdb3ea6@infradead.org>
Date: Thu, 4 Jun 2026 21:53:11 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PM: dpm_watchdog: Allow disabling DPM watchdog by
 default
To: Tzung-Bi Shih <tzungbi@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, tfiga@chromium.org, senozhatsky@chromium.org
References: <20260604090756.2884671-1-tzungbi@kernel.org>
 <20260604090756.2884671-3-tzungbi@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260604090756.2884671-3-tzungbi@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 6/4/26 2:07 AM, Tzung-Bi Shih wrote:
> Introduce the CONFIG_DPM_WATCHDOG_DEFAULT_ENABLED Kconfig option to
> allow the device suspend/resume watchdog (DPM watchdog) to be disabled
> by default at compile time.
> 
> Additionally, introduce the "dpm_watchdog_enabled" module parameter to
> allow the watchdog to be enabled or disabled at boot time (via
> "power.dpm_watchdog_enabled") and at runtime (via sysfs).
> 
> This provides flexibility for systems that want the watchdog code
> compiled in but inactive by default, allowing it to be enabled only when
> needed.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
> v2:
> - Use module parameter and bool for dpm_watchdog_enabled.
> - Use IS_ENABLED().
> 
> v1: https://lore.kernel.org/all/20260528103215.505795-1-tzungbi@kernel.org
> 
>  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
>  drivers/base/power/main.c                       | 11 +++++++++++
>  kernel/power/Kconfig                            |  9 +++++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 00375193bd26..0a0d5340b0c7 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5399,6 +5399,14 @@ Kernel parameters
>  			function to NULL. On Idle the CPU just reduces
>  			execution priority.
>  
> +	power.dpm_watchdog_enabled=
> +			[KNL] Enable or disable the device suspend/resume

I think that [KNL] isn't very useful here (nor in many of its uses in
kernel-parameters.txt).
What is required to use this option are:
  CONFIG_PM_SLEEP, CONFIG_DPM_WATCHDOG
You should convey that information somehow.

Also, in kernel-parameters.txt, "pm_async=" is only valid when [PM]
is enabled, but "PM" is not defined/described anywhere.
That should be added near the beginning of kernel-parameters.txt (in
alphabetical order).


> +			watchdog (DPM watchdog).
> +			Format: {"0" | "1"}
> +			0: disable
> +			1: enable
> +			Default value is set by CONFIG_DPM_WATCHDOG_DEFAULT_ENABLED.
> +
>  	ppc_strict_facility_enable
>  			[PPC,ENABLE] This option catches any kernel floating point,
>  			Altivec, VSX and SPE outside of regions specifically
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index cd864f3a2799..7822c29b7c8d 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -534,6 +534,11 @@ module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
>  MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
>  		 "Backtrace all CPUs on DPM watchdog timeout");
>  
> +static bool __read_mostly dpm_watchdog_enabled =
> +				IS_ENABLED(CONFIG_DPM_WATCHDOG_DEFAULT_ENABLED);
> +module_param(dpm_watchdog_enabled, bool, 0644);
> +MODULE_PARM_DESC(dpm_watchdog_enabled, "Enable DPM watchdog");
> +
>  /**
>   * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
>   * @t: The timer that PM watchdog depends on.
> @@ -577,6 +582,9 @@ static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
>  {
>  	struct timer_list *timer = &wd->timer;
>  
> +	if (!dpm_watchdog_enabled)
> +		return;
> +
>  	wd->dev = dev;
>  	wd->tsk = current;
>  	wd->fatal = CONFIG_DPM_WATCHDOG_TIMEOUT == CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
> @@ -595,6 +603,9 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
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
> index 530c897311d4..12a4a66d48d4 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -268,6 +268,15 @@ config DPM_WATCHDOG
>  	  captured in pstore device for inspection in subsequent
>  	  boot session.
>  
> +config DPM_WATCHDOG_DEFAULT_ENABLED
> +	bool "Enable DPM watchdog by default"
> +	depends on DPM_WATCHDOG
> +	default y
> +	help
> +	  If you say Y here, the DPM watchdog will be enabled by default.
> +	  If you say N, it will be compiled in but disabled, requiring a
> +	  boot parameter to activate.
> +
>  config DPM_WATCHDOG_TIMEOUT
>  	int "Watchdog timeout to panic in seconds"
>  	range 1 120

-- 
~Randy

