From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] ACPI / LPSS: Avoid PM quirks on suspend and resume from
 S3
Date: Tue, 24 Jul 2018 16:46:09 +0800
Message-ID: <ABABA247-9C33-4311-ADA5-D0D00B810C6C@canonical.com>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com>
 <2505591.oRh3ktjo9V@aspire.rjw.lan>
 <A05971DC-4453-4615-9AE9-8C4608569427@canonical.com>
 <1568228.RgPNub1osy@aspire.rjw.lan>
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568228.RgPNub1osy@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, P HeLiOn <perryhelionsemail@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

> On Jun 13, 2018, at 7:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It is reported that commit a192aa923b66a (ACPI / LPSS: Consolidate
> runtime PM and system sleep handling) introduced a system suspend
> regression on some machines, but the only functional change made by
> it was to cause the PM quirks in the LPSS to also be used during
> system suspend and resume.  While that should always work for
> suspend-to-idle, it turns out to be problematic for S3
> (suspend-to-RAM).
>
> To address that issue restore the previous S3 suspend and resume
> behavior of the LPSS to avoid applying PM quirks then.

The users reported that this patch does fix the S3 issue, but the S4 still  
fails.

Please refer to [1] for more for user's testing result.

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1774950/comments/60

Kai-Heng

>
> Fixes: a192aa923b66a (ACPI / LPSS: Consolidate runtime PM and system  
> sleep handling)
> Link: https://bugs.launchpad.net/bugs/1774950
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpi_lpss.c |   18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> Index: linux-pm/drivers/acpi/acpi_lpss.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_lpss.c
> +++ linux-pm/drivers/acpi/acpi_lpss.c
> @@ -22,6 +22,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pwm.h>
> +#include <linux/suspend.h>
>  #include <linux/delay.h>
>
>  #include "internal.h"
> @@ -940,9 +941,10 @@ static void lpss_iosf_exit_d3_state(void
>  	mutex_unlock(&lpss_iosf_mutex);
>  }
>
> -static int acpi_lpss_suspend(struct device *dev, bool wakeup)
> +static int acpi_lpss_suspend(struct device *dev, bool runtime)
>  {
>  	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
> +	bool wakeup = runtime || device_may_wakeup(dev);
>  	int ret;
>
>  	if (pdata->dev_desc->flags & LPSS_SAVE_CTX)
> @@ -955,13 +957,14 @@ static int acpi_lpss_suspend(struct devi
>  	 * wrong status for devices being about to be powered off. See
>  	 * lpss_iosf_enter_d3_state() for further information.
>  	 */
> -	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
> +	if ((runtime || !pm_suspend_via_firmware()) &&
> +	    lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
>  		lpss_iosf_enter_d3_state();
>
>  	return ret;
>  }
>
> -static int acpi_lpss_resume(struct device *dev)
> +static int acpi_lpss_resume(struct device *dev, bool runtime)
>  {
>  	struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>  	int ret;
> @@ -970,7 +973,8 @@ static int acpi_lpss_resume(struct devic
>  	 * This call is kept first to be in symmetry with
>  	 * acpi_lpss_runtime_suspend() one.
>  	 */
> -	if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
> +	if ((runtime || !pm_resume_via_firmware()) &&
> +	    lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
>  		lpss_iosf_exit_d3_state();
>
>  	ret = acpi_dev_resume(dev);
> @@ -994,12 +998,12 @@ static int acpi_lpss_suspend_late(struct
>  		return 0;
>
>  	ret = pm_generic_suspend_late(dev);
> -	return ret ? ret : acpi_lpss_suspend(dev, device_may_wakeup(dev));
> +	return ret ? ret : acpi_lpss_suspend(dev, false);
>  }
>
>  static int acpi_lpss_resume_early(struct device *dev)
>  {
> -	int ret = acpi_lpss_resume(dev);
> +	int ret = acpi_lpss_resume(dev, false);
>
>  	return ret ? ret : pm_generic_resume_early(dev);
>  }
> @@ -1014,7 +1018,7 @@ static int acpi_lpss_runtime_suspend(str
>
>  static int acpi_lpss_runtime_resume(struct device *dev)
>  {
> -	int ret = acpi_lpss_resume(dev);
> +	int ret = acpi_lpss_resume(dev, true);
>
>  	return ret ? ret : pm_generic_runtime_resume(dev);
>  }
