From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] PM / s2idle: Rename PM_SUSPEND_FREEZE to
 PM_SUSPEND_S2IDLE
Date: Mon, 7 Aug 2017 10:49:56 +0200
Message-ID: <20170807084956.4kxkb2y7yxxi4ivw@hirez.programming.kicks-ass.net>
References: <1912685.WjJGzNPQ5e@aspire.rjw.lan>
 <3267088.f3JVtvJoiF@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3267088.f3JVtvJoiF@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Aug 05, 2017 at 02:56:43PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> To make it clear that the symbol in question refers to
> suspend-to-idle, rename it from PM_SUSPEND_FREEZE to
> PM_SUSPEND_S2IDLE.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/sleep.c             |    2 -
>  drivers/regulator/of_regulator.c |    2 -
>  include/linux/suspend.h          |    4 +--
>  kernel/power/suspend.c           |   44 +++++++++++++++++++--------------------
>  kernel/power/suspend_test.c      |    4 +--
>  5 files changed, 28 insertions(+), 28 deletions(-)
> 
> Index: linux-pm/include/linux/suspend.h
> ===================================================================
> --- linux-pm.orig/include/linux/suspend.h
> +++ linux-pm/include/linux/suspend.h
> @@ -33,10 +33,10 @@ static inline void pm_restore_console(vo
>  typedef int __bitwise suspend_state_t;
>  
>  #define PM_SUSPEND_ON		((__force suspend_state_t) 0)
> -#define PM_SUSPEND_FREEZE	((__force suspend_state_t) 1)
> +#define PM_SUSPEND_S2IDLE	((__force suspend_state_t) 1)
>  #define PM_SUSPEND_STANDBY	((__force suspend_state_t) 2)
>  #define PM_SUSPEND_MEM		((__force suspend_state_t) 3)

I feel something like PM_SUSPEND_IDLE is more consistent with the
existing PM_SUSPEND_MEM. Also the proposed PM_SUSPEND_S2IDLE has
'SUSPEND' in it twice, so at the very least it should be
PM_SUSPEND_2IDLE :-)


> -#define PM_SUSPEND_MIN		PM_SUSPEND_FREEZE
> +#define PM_SUSPEND_MIN		PM_SUSPEND_S2IDLE
>  #define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
