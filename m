From: "Cihula, Joseph" <joseph.cihula@intel.com>
Subject: Re: [PATCH 2/7] x86, acpi,
 tboot: Have a ACPI sleep override instead of calling tboot_sleep.
Date: Wed, 7 Sep 2011 04:20:17 +0000
Message-ID: <9F57BF860713DF4BA3EFA4F8C6DFEDAC16F3F524__32265.8568890349$1315369334$gmane$org@ORSMSX101.amr.corp.intel.com>
References: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
	<1314815484-4668-3-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314815484-4668-3-git-send-email-konrad.wilk@oracle.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, tboot-devel@lists.sourceforge.net
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: linux-pm@vger.kernel.org

> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> Sent: Wednesday, August 31, 2011 11:31 AM
> 
> The ACPI suspend path makes a call to tboot_sleep right before it writes the PM1A, PM1B values. We
> replace the direct call to tboot via an registration callback similar to __acpi_register_gsi.
> 
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: x86@kernel.org
> CC: Len Brown <len.brown@intel.com>
> CC: Joseph Cihula <joseph.cihula@intel.com>
> CC: Shane Wang <shane.wang@intel.com>
> CC: xen-devel@lists.xensource.com
> CC: linux-pm@lists.linux-foundation.org
> CC: tboot-devel@lists.sourceforge.net
> CC: linux-acpi@vger.kernel.org
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/include/asm/acpi.h   |    3 +++
>  arch/x86/kernel/acpi/boot.c   |    3 +++
>  arch/x86/kernel/tboot.c       |   13 +++++++++----
>  drivers/acpi/acpica/hwsleep.c |   12 ++++++++++--
>  include/linux/tboot.h         |    3 ++-
>  5 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h index 610001d..49864a1
> 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -98,6 +98,9 @@ void acpi_pic_sci_set_trigger(unsigned int, u16);  extern int
> (*__acpi_register_gsi)(struct device *dev, u32 gsi,
>  				  int trigger, int polarity);
> 
> +extern int (*__acpi_override_sleep)(u8 sleep_state, u32 pm1a_ctrl,
> +				    u32 pm1b_ctrl, bool *skip_rest);
> +
>  static inline void disable_acpi(void)
>  {
>  	acpi_disabled = 1;
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c index 4558f0d..d191b4c
> 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -552,6 +552,9 @@ static int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,  int
> (*__acpi_register_gsi)(struct device *dev, u32 gsi,
>  			   int trigger, int polarity) = acpi_register_gsi_pic;
> 
> +int (*__acpi_override_sleep)(u8 sleep_state, u32 pm1a_ctrl,
> +			     u32 pm1b_ctrl, bool *skip_rest) = NULL;
> +
>  /*
>   * success: return IRQ number (>=0)
>   * failure: return < 0
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c index 30ac65d..a18070c 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -41,7 +41,7 @@
>  #include <asm/setup.h>
>  #include <asm/e820.h>
>  #include <asm/io.h>
> -
> +#include <linux/acpi.h>
>  #include "acpi/realmode/wakeup.h"
> 
>  /* Global pointer to shared data; NULL means no measured launch. */ @@ -270,7 +270,8 @@ static
> void tboot_copy_fadt(const struct acpi_table_fadt *fadt)
>  		offsetof(struct acpi_table_facs, firmware_waking_vector);  }
> 
> -void tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
> +int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control,
> +		 bool *skip_rest)

Don't you need to use the 'unused' attrib on skip_rest in order to prevent compiler warnings?

>  {
>  	static u32 acpi_shutdown_map[ACPI_S_STATE_COUNT] = {
>  		/* S0,1,2: */ -1, -1, -1,
> @@ -279,7 +280,7 @@ void tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
>  		/* S5: */ TB_SHUTDOWN_S5 };
> 
>  	if (!tboot_enabled())
> -		return;
> +		return AE_OK;
> 
>  	tboot_copy_fadt(&acpi_gbl_FADT);
>  	tboot->acpi_sinfo.pm1a_cnt_val = pm1a_control; @@ -290,10 +291,12 @@ void tboot_sleep(u8
> sleep_state, u32 pm1a_control, u32 pm1b_control)
>  	if (sleep_state >= ACPI_S_STATE_COUNT ||
>  	    acpi_shutdown_map[sleep_state] == -1) {
>  		pr_warning("unsupported sleep state 0x%x\n", sleep_state);
> -		return;
> +		return AE_ERROR;
>  	}
> 
>  	tboot_shutdown(acpi_shutdown_map[sleep_state]);
> +
> +	return AE_OK;
>  }
> 
>  static atomic_t ap_wfs_count;
> @@ -343,6 +346,8 @@ static __init int tboot_late_init(void)
> 
>  	atomic_set(&ap_wfs_count, 0);
>  	register_hotcpu_notifier(&tboot_cpu_notifier);
> +
> +	__acpi_override_sleep = tboot_sleep;
>  	return 0;
>  }
> 
> diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c index 2ac28bb..31d1198
> 100644
> --- a/drivers/acpi/acpica/hwsleep.c
> +++ b/drivers/acpi/acpica/hwsleep.c
> @@ -45,7 +45,6 @@
>  #include <acpi/acpi.h>
>  #include "accommon.h"
>  #include "actables.h"
> -#include <linux/tboot.h>
> 
>  #define _COMPONENT          ACPI_HARDWARE
>  ACPI_MODULE_NAME("hwsleep")
> @@ -343,8 +342,17 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
> 
>  	ACPI_FLUSH_CPU_CACHE();
> 
> -	tboot_sleep(sleep_state, pm1a_control, pm1b_control);
> +	if (__acpi_override_sleep) {
> +		bool skip_rest = false;
> 
> +		status = __acpi_override_sleep(sleep_state, pm1a_control,
> +					       pm1b_control, &skip_rest);
> +
> +		if (ACPI_FAILURE(status))
> +			return_ACPI_STATUS(status);
> +		if (skip_rest)
> +			return_ACPI_STATUS(AE_OK);
> +	}
>  	/* Write #2: Write both SLP_TYP + SLP_EN */
> 
>  	status = acpi_hw_write_pm1_control(pm1a_control, pm1b_control); diff --git
> a/include/linux/tboot.h b/include/linux/tboot.h index 1dba6ee..19badbd 100644
> --- a/include/linux/tboot.h
> +++ b/include/linux/tboot.h
> @@ -143,7 +143,8 @@ static inline int tboot_enabled(void)
> 
>  extern void tboot_probe(void);
>  extern void tboot_shutdown(u32 shutdown_type); -extern void tboot_sleep(u8 sleep_state, u32
> pm1a_control, u32 pm1b_control);
> +extern int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control,
> +		       bool *skip);
>  extern struct acpi_table_header *tboot_get_dmar_table(
>  				      struct acpi_table_header *dmar_tbl);  extern int
> tboot_force_iommu(void);
> --
> 1.7.4.1
