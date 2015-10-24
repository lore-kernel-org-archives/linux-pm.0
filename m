From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] ACPI: Using correct irq when uninstalling acpi irq handler
Date: Sat, 24 Oct 2015 15:31:41 +0200
Message-ID: <2653711.REifFj4Vt2@vostro.rjw.lan>
References: <1445515388-31251-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1445515388-31251-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: lenb@kernel.org, rui.zhang@intel.com, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, October 22, 2015 08:03:08 PM Chen Yu wrote:
> Currently when system is trying to uninstall the acpi irq
> handler, it uses the acpi_gbl_FADT.sci_interrupt directly.
> But acpi irq handler is actually installed by mapped irq
> in acpi_os_install_interrupt_handler, so this patch fixes
> this problem by using the mapped irq returned from acpi_gsi_to_irq.
> 
> Cc: <stable@vger.kernel.org> # 2.6.39+
> Acked-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/acpi/osl.c   | 10 +++++++---
>  include/linux/acpi.h |  3 +++
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 739a4a6..2e9eccf 100644
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
> -acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
> +acpi_status acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler handler)
>  {
> -	if (irq != acpi_gbl_FADT.sci_interrupt)
> +	if ((gsi != acpi_gbl_FADT.sci_interrupt) ||
> +			IS_INVALID_ACPI_IRQ(acpi_sci_irq))

The white space doesn't follow the kernel coding style, should be something
like

	if ((gsi != acpi_gbl_FADT.sci_interrupt) ||
	    IS_INVALID_ACPI_IRQ(acpi_sci_irq))

(spaces instead of the second tab).

Another minor nit is that this probably is the only place you check the
IS_INVALID_ACPI_IRQ(acpi_sci_irq) thing without logical negation and you
only pass acpi_sci_irq to IS_INVALID_ACPI_IRQ() AFAICS.

It would be more straightforward to define something like acpi_sci_irq_valid()
instead (see below) IMO.

>  		return AE_BAD_PARAMETER;
>  
> -	free_irq(irq, acpi_irq);
> +	free_irq(acpi_sci_irq, acpi_irq);
>  	acpi_irq_handler = NULL;
> +	acpi_sci_irq = INVALID_ACPI_IRQ;
>  
>  	return AE_OK;
>  }
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 43856d1..bad159c 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -193,6 +193,9 @@ int acpi_ioapic_registered(acpi_handle handle, u32 gsi_base);
>  void acpi_irq_stats_init(void);
>  extern u32 acpi_irq_handled;
>  extern u32 acpi_irq_not_handled;
> +extern unsigned int acpi_sci_irq;
> +#define INVALID_ACPI_IRQ ((unsigned)-1)

#define INVALID_ACPI_IRQ	((unsigned int)-1)

> +#define IS_INVALID_ACPI_IRQ(x) unlikely((x) == INVALID_ACPI_IRQ)

Maybe something like:

	static inline bool acpi_sci_irq_valid(void)
	{
		return acpi_sci_irq != INVALID_ACPI_IRQ;
	}

>  
>  extern int sbf_port;
>  extern unsigned long acpi_realmode_flags;
> 

Thanks,
Rafael

