From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] ACPI / PM: Combine two identical device resume routines
Date: Wed, 11 Oct 2017 09:44:28 +0200
Message-ID: <CAPDyKFoF=Z-TtqBqXBDf7qOdBby=n8fwZcYTWv2zd5jg2u-DCw@mail.gmail.com>
References: <2891336.c3ZLTR7XFW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2891336.c3ZLTR7XFW@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 10 October 2017 at 18:49, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Notice that acpi_dev_runtime_resume() and acpi_dev_resume_early() are
> actually literally identical after some more-or-less recent changes,
> so rename acpi_dev_runtime_resume() to acpi_dev_resume(), use it
> everywhere instead of acpi_dev_resume_early() and drop the latter.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/acpi/acpi_lpss.c |    6 +++---
>  drivers/acpi/device_pm.c |   35 ++++++-----------------------------
>  include/linux/acpi.h     |    3 +--
>  3 files changed, 10 insertions(+), 34 deletions(-)
>
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -882,14 +882,13 @@ int acpi_dev_runtime_suspend(struct devi
>  EXPORT_SYMBOL_GPL(acpi_dev_runtime_suspend);
>
>  /**
> - * acpi_dev_runtime_resume - Put device into the full-power state using ACPI.
> + * acpi_dev_resume - Put device into the full-power state using ACPI.
>   * @dev: Device to put into the full-power state.
>   *
>   * Put the given device into the full-power state using the standard ACPI
> - * mechanism at run time.  Set the power state of the device to ACPI D0 and
> - * disable remote wakeup.
> + * mechanism.  Set the power state of the device to ACPI D0 and disable wakeup.
>   */
> -int acpi_dev_runtime_resume(struct device *dev)
> +int acpi_dev_resume(struct device *dev)
>  {
>         struct acpi_device *adev = ACPI_COMPANION(dev);
>         int error;
> @@ -901,7 +900,7 @@ int acpi_dev_runtime_resume(struct devic
>         acpi_device_wakeup_disable(adev);
>         return error;
>  }
> -EXPORT_SYMBOL_GPL(acpi_dev_runtime_resume);
> +EXPORT_SYMBOL_GPL(acpi_dev_resume);
>
>  /**
>   * acpi_subsys_runtime_suspend - Suspend device using ACPI.
> @@ -926,7 +925,7 @@ EXPORT_SYMBOL_GPL(acpi_subsys_runtime_su
>   */
>  int acpi_subsys_runtime_resume(struct device *dev)
>  {
> -       int ret = acpi_dev_runtime_resume(dev);
> +       int ret = acpi_dev_resume(dev);
>         return ret ? ret : pm_generic_runtime_resume(dev);
>  }
>  EXPORT_SYMBOL_GPL(acpi_subsys_runtime_resume);
> @@ -967,28 +966,6 @@ int acpi_dev_suspend_late(struct device
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_suspend_late);
>
> -/**
> - * acpi_dev_resume_early - Put device into the full-power state using ACPI.
> - * @dev: Device to put into the full-power state.
> - *
> - * Put the given device into the full-power state using the standard ACPI
> - * mechanism during system transition to the working state.  Set the power
> - * state of the device to ACPI D0 and disable remote wakeup.
> - */
> -int acpi_dev_resume_early(struct device *dev)
> -{
> -       struct acpi_device *adev = ACPI_COMPANION(dev);
> -       int error;
> -
> -       if (!adev)
> -               return 0;
> -
> -       error = acpi_dev_pm_full_power(adev);
> -       acpi_device_wakeup_disable(adev);
> -       return error;
> -}
> -EXPORT_SYMBOL_GPL(acpi_dev_resume_early);
> -
>  static bool acpi_dev_needs_resume(struct device *dev, struct acpi_device *adev)
>  {
>         u32 sys_target = acpi_target_system_state();
> @@ -1091,7 +1068,7 @@ EXPORT_SYMBOL_GPL(acpi_subsys_suspend_la
>   */
>  int acpi_subsys_resume_early(struct device *dev)
>  {
> -       int ret = acpi_dev_resume_early(dev);
> +       int ret = acpi_dev_resume(dev);
>         return ret ? ret : pm_generic_resume_early(dev);
>  }
>  EXPORT_SYMBOL_GPL(acpi_subsys_resume_early);
> Index: linux-pm/drivers/acpi/acpi_lpss.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_lpss.c
> +++ linux-pm/drivers/acpi/acpi_lpss.c
> @@ -693,7 +693,7 @@ static int acpi_lpss_activate(struct dev
>         struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>         int ret;
>
> -       ret = acpi_dev_runtime_resume(dev);
> +       ret = acpi_dev_resume(dev);
>         if (ret)
>                 return ret;
>
> @@ -737,7 +737,7 @@ static int acpi_lpss_resume_early(struct
>         struct lpss_private_data *pdata = acpi_driver_data(ACPI_COMPANION(dev));
>         int ret;
>
> -       ret = acpi_dev_resume_early(dev);
> +       ret = acpi_dev_resume(dev);
>         if (ret)
>                 return ret;
>
> @@ -872,7 +872,7 @@ static int acpi_lpss_runtime_resume(stru
>         if (lpss_quirks & LPSS_QUIRK_ALWAYS_POWER_ON && iosf_mbi_available())
>                 lpss_iosf_exit_d3_state();
>
> -       ret = acpi_dev_runtime_resume(dev);
> +       ret = acpi_dev_resume(dev);
>         if (ret)
>                 return ret;
>
> Index: linux-pm/include/linux/acpi.h
> ===================================================================
> --- linux-pm.orig/include/linux/acpi.h
> +++ linux-pm/include/linux/acpi.h
> @@ -865,7 +865,7 @@ static inline void arch_reserve_mem_area
>
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
>  int acpi_dev_runtime_suspend(struct device *dev);
> -int acpi_dev_runtime_resume(struct device *dev);
> +int acpi_dev_resume(struct device *dev);
>  int acpi_subsys_runtime_suspend(struct device *dev);
>  int acpi_subsys_runtime_resume(struct device *dev);
>  struct acpi_device *acpi_dev_pm_get_node(struct device *dev);
> @@ -887,7 +887,6 @@ static inline int acpi_dev_pm_attach(str
>
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
>  int acpi_dev_suspend_late(struct device *dev);
> -int acpi_dev_resume_early(struct device *dev);
>  int acpi_subsys_prepare(struct device *dev);
>  void acpi_subsys_complete(struct device *dev);
>  int acpi_subsys_suspend_late(struct device *dev);
>
