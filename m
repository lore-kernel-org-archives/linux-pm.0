From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] pm: make PM_TRACE more architecture
	independent
Date: Thu, 8 Nov 2007 16:36:25 +0100
Message-ID: <200711081636.25987.rjw@sisk.pl>
References: <1194523015.6294.3.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1194523015.6294.3.camel@johannes.berg>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 8 of November 2007, Johannes Berg wrote:
> When trying to debug a suspend failure I started implementing
> PM_TRACE for powerpc. I then noticed that I'm debugging a suspend
> failure and so PM_TRACE isn't useful at all, but thought that
> nonetheless this could be useful in the future.
> 
> Basically, to support PM_TRACE, you add a Kconfig option that
> selects PM_TRACE and provides the infrastructure as per the
> help text of PM_TRACE.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-pm@lists.linux-foundation.org

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> I don't really care much. I can let this patch collect dust until I
> actually want to implement PM_TRACE for powerpc or another architecture
> but since I had it I wanted to send it out too.
> 
>  drivers/base/power/Makefile |    2 +-
>  kernel/power/Kconfig        |   23 ++++++++++++++++++++++-
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> --- everything.orig/drivers/base/power/Makefile	2007-11-08 12:07:09.843121635 +0100
> +++ everything/drivers/base/power/Makefile	2007-11-08 12:19:23.593081000 +0100
> @@ -1,6 +1,6 @@
>  obj-y			:= shutdown.o
>  obj-$(CONFIG_PM_SLEEP)	+= main.o sysfs.o
> -obj-$(CONFIG_PM_TRACE)	+= trace.o
> +obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
>  
>  ifeq ($(CONFIG_DEBUG_DRIVER),y)
>  EXTRA_CFLAGS += -DDEBUG
> --- everything.orig/kernel/power/Kconfig	2007-11-08 12:04:51.443081271 +0100
> +++ everything/kernel/power/Kconfig	2007-11-08 12:12:53.863072157 +0100
> @@ -44,9 +44,30 @@ config PM_VERBOSE
>  	---help---
>  	This option enables verbose messages from the Power Management code.
>  
> +config CAN_PM_TRACE
> +	def_bool y
> +	depends on PM_DEBUG && PM_SLEEP && EXPERIMENTAL
> +
>  config PM_TRACE
> +	bool
> +	help
> +	  This enables code to save the last PM event point across
> +	  reboot. The architecture needs to support this, x86 for
> +	  example does by saving things in the RTC, see below.
> +
> +	  The architecture specific code must provide the extern
> +	  functions from <linux/resume-trace.h> as well as the
> +	  <asm/resume-trace.h> header with a TRACE_RESUME() macro.
> +
> +	  The way the information is presented is architecture-
> +	  dependent, x86 will print the information during a
> +	  late_initcall.
> +
> +config PM_TRACE_RTC
>  	bool "Suspend/resume event tracing"
> -	depends on PM_DEBUG && X86 && PM_SLEEP && EXPERIMENTAL
> +	depends on CAN_PM_TRACE
> +	depends on X86
> +	select PM_TRACE
>  	default n
>  	---help---
>  	This enables some cheesy code to save the last PM event point in the
> 
> 
> 
> 



-- 
"Premature optimization is the root of all evil." - Donald Knuth
