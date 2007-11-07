From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH (2.6.25) 1/2] hibernation: clean up Kconfig
Date: Wed, 7 Nov 2007 23:18:32 +0100
Message-ID: <200711072318.33384.rjw__28006.5691484653$1194473024$gmane$org@sisk.pl>
References: <20071107135758.100171000@sipsolutions.net>
	<20071107135848.417344000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071107135848.417344000@sipsolutions.net>
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
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 7 of November 2007, Johannes Berg wrote:
> This cleans up the hibernation Kconfig and removes the need to
> declare centrally which architectures support hibernation. All
> architectures that currently support hibernation are modified
> accordingly.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> Cc: linuxppc-dev@ozlabs.org
> Cc: linux-pm@lists.linux-foundation.org
> 
> ---
>  arch/i386/Kconfig    |    4 ++++
>  arch/powerpc/Kconfig |   14 ++++++++++++--
>  arch/x86_64/Kconfig  |    3 +++
>  kernel/power/Kconfig |   18 +++---------------
>  4 files changed, 22 insertions(+), 17 deletions(-)
> 
> --- everything.orig/arch/powerpc/Kconfig	2007-11-07 13:52:14.641523382 +0100
> +++ everything/arch/powerpc/Kconfig	2007-11-07 14:29:17.251530543 +0100
> @@ -140,9 +140,19 @@ config DEFAULT_UIMAGE
>  	  Used to allow a board to specify it wants a uImage built by default
>  	default n
>  
> -config PPC64_SWSUSP
> +config HIBERNATE_32
>  	bool
> -	depends on PPC64 && (BROKEN || (PPC_PMAC64 && EXPERIMENTAL))
> +	depends on (PPC_PMAC && !SMP) || BROKEN
> +	default y
> +
> +config HIBERNATE_64
> +	bool
> +	depends on BROKEN || (PPC_PMAC64 && EXPERIMENTAL)
> +	default y
> +
> +config ARCH_HIBERNATION_POSSIBLE
> +	bool
> +	depends on (PPC64 && HIBERNATE_64) || (PPC32 && HIBERNATE_32)
>  	default y
>  
>  config PPC_DCR_NATIVE
> --- everything.orig/kernel/power/Kconfig	2007-11-07 13:52:14.731524087 +0100
> +++ everything/kernel/power/Kconfig	2007-11-07 14:29:17.351531628 +0100
> @@ -63,7 +63,8 @@ config PM_TRACE
>  
>  config PM_SLEEP_SMP
>  	bool
> -	depends on SUSPEND_SMP_POSSIBLE || HIBERNATION_SMP_POSSIBLE
> +	depends on SMP
> +	depends on SUSPEND_SMP_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
>  	depends on PM_SLEEP
>  	select HOTPLUG_CPU
>  	default y
> @@ -97,22 +98,9 @@ config SUSPEND
>  	  powered and thus its contents are preserved, such as the
>  	  suspend-to-RAM state (i.e. the ACPI S3 state).
>  
> -config HIBERNATION_UP_POSSIBLE
> -	bool
> -	depends on X86 || PPC64_SWSUSP || PPC32
> -	depends on !SMP
> -	default y
> -
> -config HIBERNATION_SMP_POSSIBLE
> -	bool
> -	depends on (X86 && !X86_VOYAGER) || PPC64_SWSUSP
> -	depends on SMP
> -	default y
> -
>  config HIBERNATION
>  	bool "Hibernation (aka 'suspend to disk')"
> -	depends on PM && SWAP
> -	depends on HIBERNATION_UP_POSSIBLE || HIBERNATION_SMP_POSSIBLE
> +	depends on PM && SWAP && ARCH_HIBERNATION_POSSIBLE
>  	---help---
>  	  Enable the suspend to disk (STD) functionality, which is usually
>  	  called "hibernation" in user interfaces.  STD checkpoints the
> --- everything.orig/arch/i386/Kconfig	2007-11-07 13:54:07.811521157 +0100
> +++ everything/arch/i386/Kconfig	2007-11-07 14:29:16.631526474 +0100
> @@ -1319,3 +1319,7 @@ config X86_TRAMPOLINE
>  config KTIME_SCALAR
>  	bool
>  	default y
> +
> +config ARCH_HIBERNATION_POSSIBLE
> +	def_bool y
> +	depends on !SMP || !X86_VOYAGER
> --- everything.orig/arch/x86_64/Kconfig	2007-11-07 13:57:35.091520777 +0100
> +++ everything/arch/x86_64/Kconfig	2007-11-07 14:29:16.721529458 +0100
> @@ -716,6 +716,9 @@ menu "Power management options"
>  
>  source kernel/power/Kconfig
>  
> +config ARCH_HIBERNATION_POSSIBLE
> +	def_bool y
> +
>  config ARCH_HIBERNATION_HEADER
>  	bool
>  	depends on HIBERNATION
> 



-- 
"Premature optimization is the root of all evil." - Donald Knuth
