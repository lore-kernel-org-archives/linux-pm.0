From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH] PM / suspend: Make cpuidle work in the "freeze" state
Date: Mon, 21 Apr 2014 12:23:54 +0530
Message-ID: <5354C082.6020908@linux.vnet.ibm.com>
References: <4271849.XeOTooWnSN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4271849.XeOTooWnSN@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Aubrey Li <aubrey.li@intel.com>
List-Id: linux-pm@vger.kernel.org

On 04/21/2014 03:13 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The "freeze" system sleep state introduced by commit 7e73c5ae6e79
> (PM: Introduce suspend state PM_SUSPEND_FREEZE) requires cpuidle
> to be functional when freeze_enter() is executed to work correctly
> (that is, to be able to save any more energy than runtime idle),
> but that is impossible after commit 8651f97bd951d (PM / cpuidle:
> System resume hang fix with cpuidle) which caused cpuidle to be
> paused in dpm_suspend_noirq() and resumed in dpm_resume_noirq().
> 
> To avoid that problem, add cpuidle_resume() and cpuidle_pause()
> to the beginning and the end of freeze_enter(), respectively.
> 
> Reported-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/power/suspend.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-pm/kernel/power/suspend.c
> ===================================================================
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -14,6 +14,7 @@
>  #include <linux/init.h>
>  #include <linux/console.h>
>  #include <linux/cpu.h>
> +#include <linux/cpuidle.h>
>  #include <linux/syscalls.h>
>  #include <linux/gfp.h>
>  #include <linux/io.h>
> @@ -53,7 +54,9 @@ static void freeze_begin(void)
> 
>  static void freeze_enter(void)
>  {
> +	cpuidle_resume();
>  	wait_event(suspend_freeze_wait_head, suspend_freeze_wake);
> +	cpuidle_pause();
>  }
> 
>  void freeze_wake(void)
> 
Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
