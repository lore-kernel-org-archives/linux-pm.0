From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH][v3] ACPI / PM: Fix incorrect wakeup irq setting before
 suspend-to-idle
Date: Fri, 9 Oct 2015 08:32:57 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BAC6884@SHSMSX101.ccr.corp.intel.com>
References: <1444378813-17857-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48569 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbbJIIdA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2015 04:33:00 -0400
In-Reply-To: <1444378813-17857-1-git-send-email-yu.c.chen@intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Yu

> From: Chen, Yu C
> Sent: Friday, October 09, 2015 4:20 PM
> 
> For ACPI compatible system, SCI(ACPI System Control
> Interrupt) is used to wake system up from suspend-to-idle.
> Once CPU is woken up by SCI, interrupt handler will
> firstly checks if current interrupt is legal to wake up
> the whole system, thus irq_pm_check_wakeup is invoked
> to validate the irq number. However, before suspend-to-idle,
> acpi_gbl_FADT.sci_interrupt is marked rather than actual
> irq number in acpi_freeze_prepare, this might lead to unable
> to wake up the system.
> 
> This patch fixes this problem by marking the irq number
> return by acpi_gsi_to_irq as IRQD_WAKEUP_STATE, rather than
> marking the acpi_gbl_FADT.sci_interrupt. Meanwhile this patch
> fixes the same problems inside acpi_os_remove_interrupt_handler
> and acpi_os_wait_events_complete respectively.
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v3:
>  - 1.Rename acpi_inuse_irq to acpi_sci_irq for better understanding.
>    2.If the irq handler is not registered, skip the synchronize_hardirq
>      in acpi_os_wait_events_complete and return immediately in
>      acpi_os_remove_interrupt_handler.
>    3.For acpi_freeze_prepare and acpi_freeze_restore, if the acpi irq
>      handler is not properly registered, we do not leverage acpi irq
>      to wake up the system, but expect other peripherals(such as PCI devices
>      and USB devices)to invoke enable_irq_wake for us.
> v2:
>  - 1.Define a global acpi_inuse_irq variable, store irq in it
>      and access it directly from acpi_freeze_prepare(), and it
>      doesn't have to depend on CONFIG_SUSPEND as it is just the
>      IRQ number actually used by ACPI.
>    2.Also fix the same problems inside acpi_os_remove_interrupt_handler,
>      acpi_os_wait_events_complete.
> ---
>  drivers/acpi/osl.c   | 12 ++++++++----
>  drivers/acpi/sleep.c |  6 ++++--
>  include/linux/acpi.h |  3 +++
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 739a4a6..8e1a5d3 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -81,6 +81,7 @@ static struct workqueue_struct *kacpid_wq;
>  static struct workqueue_struct *kacpi_notify_wq;
>  static struct workqueue_struct *kacpi_hotplug_wq;
>  static bool acpi_os_initialized;
> +unsigned int acpi_sci_irq = INVALID_ACPI_IRQ;
> 
>  /*
>   * This list of permanent mappings is for memory that may be accessed from
> @@ -856,17 +857,20 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
>  		acpi_irq_handler = NULL;
>  		return AE_NOT_ACQUIRED;
>  	}
> +	acpi_sci_irq = irq;
> 
>  	return AE_OK;
>  }
> 
>  acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)

Why don't you rename irq here to gsi to improve the readability?
The false naming and the wrong example written for this function are probably the root causes of all other bad code.
So if we want to stop people making future mistakes, we need to cleanup ourselves.

Thanks and best regards
-Lv

>  {
> -	if (irq != acpi_gbl_FADT.sci_interrupt)
> +	if ((irq != acpi_gbl_FADT.sci_interrupt) ||
> +			IS_INVALID_ACPI_IRQ(acpi_sci_irq))
>  		return AE_BAD_PARAMETER;
> 
> -	free_irq(irq, acpi_irq);
> +	free_irq(acpi_sci_irq, acpi_irq);
>  	acpi_irq_handler = NULL;
> +	acpi_sci_irq = INVALID_ACPI_IRQ;
> 
>  	return AE_OK;
>  }
> @@ -1180,8 +1184,8 @@ void acpi_os_wait_events_complete(void)
>  	 * Make sure the GPE handler or the fixed event handler is not used
>  	 * on another CPU after removal.
>  	 */
> -	if (acpi_irq_handler)
> -		synchronize_hardirq(acpi_gbl_FADT.sci_interrupt);
> +	if (!IS_INVALID_ACPI_IRQ(acpi_sci_irq))
> +		synchronize_hardirq(acpi_sci_irq);
>  	flush_workqueue(kacpid_wq);
>  	flush_workqueue(kacpi_notify_wq);
>  }
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 2f0d4db..1704595 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -632,14 +632,16 @@ static int acpi_freeze_prepare(void)
>  	acpi_enable_wakeup_devices(ACPI_STATE_S0);
>  	acpi_enable_all_wakeup_gpes();
>  	acpi_os_wait_events_complete();
> -	enable_irq_wake(acpi_gbl_FADT.sci_interrupt);
> +	if (!IS_INVALID_ACPI_IRQ(acpi_sci_irq))
> +		enable_irq_wake(acpi_sci_irq);
>  	return 0;
>  }
> 
>  static void acpi_freeze_restore(void)
>  {
>  	acpi_disable_wakeup_devices(ACPI_STATE_S0);
> -	disable_irq_wake(acpi_gbl_FADT.sci_interrupt);
> +	if (!IS_INVALID_ACPI_IRQ(acpi_sci_irq))
> +		disable_irq_wake(acpi_sci_irq);
>  	acpi_enable_all_runtime_gpes();
>  }
> 
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 43856d1..2f05dc0 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -193,6 +193,9 @@ int acpi_ioapic_registered(acpi_handle handle, u32 gsi_base);
>  void acpi_irq_stats_init(void);
>  extern u32 acpi_irq_handled;
>  extern u32 acpi_irq_not_handled;
> +extern unsigned int acpi_sci_irq;
> +#define INVALID_ACPI_IRQ  ((unsigned)-1)
> +#define IS_INVALID_ACPI_IRQ(x) unlikely((x) == INVALID_ACPI_IRQ)
> 
>  extern int sbf_port;
>  extern unsigned long acpi_realmode_flags;
> --
> 1.8.4.2

