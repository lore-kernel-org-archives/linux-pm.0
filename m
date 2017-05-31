From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 2/3] RTC: rtc-cmos: Fix wakeup from suspend-to-idle
Date: Wed, 31 May 2017 11:21:55 +0200
Message-ID: <20170531092155.ofhimzxatz4kqbul@piout.net>
References: <2169867.RZcCZmJK9B@aspire.rjw.lan>
 <31830983.Z4sGoD3BOE@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <31830983.Z4sGoD3BOE@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Box <david.e.box@linux.intel.com>, Alessandro Zummo <a.zummo@towertech.it>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 14/05/2017 at 01:55:32 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from
> suspend-to-idle) modified the core suspend-to-idle code to filter
> out spurious SCI interrupts received while suspended, which requires
> ACPI event source handlers to report wakeup events in a way that
> will trigger a wakeup from suspend to idle (or abort system suspends
> in progress, which is equivalent).
> 
> That needs to be done in the rtc-cmos driver too, which was overlooked
> by the above commit, so do that now.
> 
> Fixes: eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle)
> Reported-by: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/rtc/rtc-cmos.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/rtc/rtc-cmos.c
> ===================================================================
> --- linux-pm.orig/drivers/rtc/rtc-cmos.c
> +++ linux-pm/drivers/rtc/rtc-cmos.c
> @@ -1085,7 +1085,7 @@ static u32 rtc_handler(void *context)
>  	}
>  	spin_unlock_irqrestore(&rtc_lock, flags);
>  
> -	pm_wakeup_event(dev, 0);
> +	pm_wakeup_hard_event(dev);
>  	acpi_clear_event(ACPI_EVENT_RTC);
>  	acpi_disable_event(ACPI_EVENT_RTC, 0);
>  	return ACPI_INTERRUPT_HANDLED;
> 

This seems good to me, do you expect it to go through my tree?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
