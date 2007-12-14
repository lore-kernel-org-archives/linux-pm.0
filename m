From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v3] PM: make freezer optional for suspend
Date: Fri, 14 Dec 2007 01:12:37 +0100
Message-ID: <200712140112.37984.rjw@sisk.pl>
References: <1197382756.4037.17.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1197382756.4037.17.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 11 of December 2007, Johannes Berg wrote:
> This patch makes the freezer optional for suspend to allow the
> system to work (or not work) like the original PMU suspend.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

Looks good.

I'm going to push this patch upstream, for 2.6.25.

Thanks,
Rafael


> ---
> In a quick test, playing sound across suspend failed to work,
> it usually works when the freezer is enabled (unless you use
> gstreamer.)
> 
>  arch/powerpc/Kconfig |    4 ++++
>  kernel/power/Kconfig |   11 +++++++++++
>  kernel/power/main.c  |    6 +++---
>  kernel/power/power.h |   22 ++++++++++++++++++++++
>  4 files changed, 40 insertions(+), 3 deletions(-)
> 
> --- everything.orig/kernel/power/main.c	2007-12-11 15:13:05.726937988 +0100
> +++ everything/kernel/power/main.c	2007-12-11 15:16:21.816910590 +0100
> @@ -79,7 +79,7 @@ static int suspend_prepare(void)
>  
>  	pm_prepare_console();
>  
> -	if (freeze_processes()) {
> +	if (suspend_freeze_processes()) {
>  		error = -EAGAIN;
>  		goto Thaw;
>  	}
> @@ -97,7 +97,7 @@ static int suspend_prepare(void)
>  		return 0;
>  
>   Thaw:
> -	thaw_processes();
> +	suspend_thaw_processes();
>  	pm_restore_console();
>   Finish:
>  	pm_notifier_call_chain(PM_POST_SUSPEND);
> @@ -191,7 +191,7 @@ int suspend_devices_and_enter(suspend_st
>   */
>  static void suspend_finish(void)
>  {
> -	thaw_processes();
> +	suspend_thaw_processes();
>  	pm_restore_console();
>  	pm_notifier_call_chain(PM_POST_SUSPEND);
>  }
> --- everything.orig/kernel/power/Kconfig	2007-12-11 15:13:05.856915473 +0100
> +++ everything/kernel/power/Kconfig	2007-12-11 15:13:40.306913303 +0100
> @@ -97,6 +97,17 @@ config SUSPEND
>  	  powered and thus its contents are preserved, such as the
>  	  suspend-to-RAM state (i.e. the ACPI S3 state).
>  
> +config SUSPEND_FREEZER
> +	bool "Enable freezer for suspend to RAM/standby" \
> +		if ARCH_WANTS_FREEZER_CONTROL || BROKEN
> +	depends on SUSPEND
> +	default y
> +	help
> +	  This allows you to turn off the freezer for suspend. If this is
> +	  done, no tasks are frozen for suspend to RAM/standby.
> +
> +	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
> +
>  config HIBERNATION_UP_POSSIBLE
>  	bool
>  	depends on X86 || PPC64_SWSUSP || PPC32
> --- everything.orig/arch/powerpc/Kconfig	2007-12-11 15:13:05.926915907 +0100
> +++ everything/arch/powerpc/Kconfig	2007-12-11 15:13:40.316913954 +0100
> @@ -365,6 +365,10 @@ config CMDLINE
>  	  most cases you will need to specify the root device here.
>  
>  if !44x || BROKEN
> +config ARCH_WANTS_FREEZER_CONTROL
> +	def_bool y
> +	depends on ADB_PMU
> +
>  source kernel/power/Kconfig
>  endif
>  
> --- everything.orig/kernel/power/power.h	2007-12-11 15:14:02.066914117 +0100
> +++ everything/kernel/power/power.h	2007-12-11 15:17:10.136910319 +0100
> @@ -1,5 +1,6 @@
>  #include <linux/suspend.h>
>  #include <linux/utsname.h>
> +#include <linux/freezer.h>
>  
>  struct swsusp_info {
>  	struct new_utsname	uts;
> @@ -211,3 +212,24 @@ static inline int pm_notifier_call_chain
>  	return (blocking_notifier_call_chain(&pm_chain_head, val, NULL)
>  			== NOTIFY_BAD) ? -EINVAL : 0;
>  }
> +
> +#ifdef CONFIG_SUSPEND_FREEZER
> +static inline int suspend_freeze_processes(void)
> +{
> +	return freeze_processes();
> +}
> +
> +static inline void suspend_thaw_processes(void)
> +{
> +	thaw_processes();
> +}
> +#else
> +static inline int suspend_freeze_processes(void)
> +{
> +	return 0;
> +}
> +
> +static inline void suspend_thaw_processes(void)
> +{
> +}
> +#endif
> 
> 
> 
> 



-- 
"Premature optimization is the root of all evil." - Donald Knuth
