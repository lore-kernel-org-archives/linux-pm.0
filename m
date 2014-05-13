From: "edubezval@gmail.com" <edubezval@gmail.com>
Subject: Re: [RFC PATCH 2/5] thermal: let cooling devices operate on other
 units other than state
Date: Tue, 13 May 2014 12:22:38 -0300
Message-ID: <CAC-25o-V1oSZM_P7zQqDy3b1rGoeMNy9wLnnPT8L-XtgHH320Q@mail.gmail.com>
References: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
	<1399377998-14870-3-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:52561 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbaEMPWj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 May 2014 11:22:39 -0400
Received: by mail-vc0-f182.google.com with SMTP id la4so669781vcb.27
        for <linux-pm@vger.kernel.org>; Tue, 13 May 2014 08:22:38 -0700 (PDT)
In-Reply-To: <1399377998-14870-3-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, Punit Agrawal <Punit.Agrawal@arm.com>, Zhang Rui <rui.zhang@intel.com>

Hello Javi,

On Tue, May 06, 2014 at 01:06:35PM +0100, Javi Merino wrote:
> Currently, cooling devices operate on state, even though some (like
> the cpufreq cooling device) have exported functions to convert
> frequency to state.  Generalize this interface so that governors can
> operate on other units (e.g. frequency, power,...).
>
> Suggested-by: Eduardo Valentin <edubezval@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
>  drivers/acpi/fan.c                  |   22 ++++++++++++++------
>  drivers/acpi/processor_thermal.c    |   23 +++++++++++++++------
>  drivers/acpi/video.c                |   22 ++++++++++++++------
>  drivers/platform/x86/acerhdf.c      |   24 ++++++++++++++++------
>  drivers/platform/x86/intel_menlow.c |   26 +++++++++++++++++-------
>  drivers/power/power_supply_core.c   |   24 ++++++++++++++++------
>  drivers/thermal/cpu_cooling.c       |   38 ++++++++++++++++++++++++++---------
>  drivers/thermal/db8500_thermal.c    |    2 +-
>  drivers/thermal/fair_share.c        |    2 +-
>  drivers/thermal/intel_powerclamp.c  |   24 ++++++++++++++++------
>  drivers/thermal/step_wise.c         |    2 +-
>  drivers/thermal/thermal_core.c      |   13 ++++++------
>  include/linux/thermal.h             |   13 +++++++++---
>  13 files changed, 169 insertions(+), 66 deletions(-)
>

This change must be reflected under Documentation/thermal/sysfs-api.txt
too.


> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index 8acf53e62966..55346deb8202 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -79,20 +79,26 @@ static struct acpi_driver acpi_fan_driver = {
>
>  /* thermal cooling device callbacks */
>  static int fan_get_max_state(struct thermal_cooling_device *cdev, unsigned long
> -     *state)
> +     *state, enum thermal_cooling_unit unit)
>  {
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   /* ACPI fan device only support two states: ON/OFF */
>   *state = 1;
>   return 0;
>  }
>
>  static int fan_get_cur_state(struct thermal_cooling_device *cdev, unsigned long
> -     *state)
> +     *state, enum thermal_cooling_unit unit)
>  {
>   struct acpi_device *device = cdev->devdata;
>   int result;
>   int acpi_state = ACPI_STATE_D0;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   if (!device)
>   return -EINVAL;
>
> @@ -106,11 +112,15 @@ static int fan_get_cur_state(struct thermal_cooling_device *cdev, unsigned long
>  }
>
>  static int
> -fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
> +fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state,
> +  enum thermal_cooling_unit unit)
>  {
>   struct acpi_device *device = cdev->devdata;
>   int result;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   if (!device || (state != 0 && state != 1))
>   return -EINVAL;
>
> @@ -121,9 +131,9 @@ fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
>  }
>
>  static const struct thermal_cooling_device_ops fan_cooling_ops = {
> - .get_max_state = fan_get_max_state,
> - .get_cur_state = fan_get_cur_state,
> - .set_cur_state = fan_set_cur_state,
> + .get_max = fan_get_max_state,
> + .get_cur = fan_get_cur_state,
> + .set_cur = fan_set_cur_state,
>  };
>
>  /* --------------------------------------------------------------------------
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> index e003663b2f8e..48179ed9afe5 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -200,11 +200,15 @@ static int acpi_processor_max_state(struct acpi_processor *pr)
>  }
>  static int
>  processor_get_max_state(struct thermal_cooling_device *cdev,
> - unsigned long *state)
> + unsigned long *state,
> + enum thermal_cooling_unit unit)
>  {
>   struct acpi_device *device = cdev->devdata;
>   struct acpi_processor *pr;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   if (!device)
>   return -EINVAL;
>
> @@ -218,11 +222,15 @@ processor_get_max_state(struct thermal_cooling_device *cdev,
>
>  static int
>  processor_get_cur_state(struct thermal_cooling_device *cdev,
> - unsigned long *cur_state)
> + unsigned long *cur_state,
> + enum thermal_cooling_unit unit)
>  {
>   struct acpi_device *device = cdev->devdata;
>   struct acpi_processor *pr;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   if (!device)
>   return -EINVAL;
>
> @@ -238,13 +246,16 @@ processor_get_cur_state(struct thermal_cooling_device *cdev,
>
>  static int
>  processor_set_cur_state(struct thermal_cooling_device *cdev,
> - unsigned long state)
> + unsigned long state, enum thermal_cooling_unit unit)
>  {
>   struct acpi_device *device = cdev->devdata;
>   struct acpi_processor *pr;
>   int result = 0;
>   int max_pstate;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   if (!device)
>   return -EINVAL;
>
> @@ -270,7 +281,7 @@ processor_set_cur_state(struct thermal_cooling_device *cdev,
>  }
>
>  const struct thermal_cooling_device_ops processor_cooling_ops = {
> - .get_max_state = processor_get_max_state,
> - .get_cur_state = processor_get_cur_state,
> - .set_cur_state = processor_set_cur_state,
> + .get_max = processor_get_max_state,
> + .get_cur = processor_get_cur_state,
> + .set_cur = processor_set_cur_state,
>  };
> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
> index 8b6990e417ec..f0aeb4d1ba91 100644
> --- a/drivers/acpi/video.c
> +++ b/drivers/acpi/video.c
> @@ -282,23 +282,29 @@ static const struct backlight_ops acpi_backlight_ops = {
>
>  /* thermal cooling device callbacks */
>  static int video_get_max_state(struct thermal_cooling_device *cooling_dev, unsigned
> -       long *state)
> +       long *state, enum thermal_cooling_unit unit)
>  {
>   struct acpi_device *device = cooling_dev->devdata;
>   struct acpi_video_device *video = acpi_driver_data(device);
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   *state = video->brightness->count - 3;
>   return 0;
>  }
>
>  static int video_get_cur_state(struct thermal_cooling_device *cooling_dev, unsigned
> -       long *state)
> +       long *state, enum thermal_cooling_unit unit)
>  {
>   struct acpi_device *device = cooling_dev->devdata;
>   struct acpi_video_device *video = acpi_driver_data(device);
>   unsigned long long level;
>   int offset;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   if (acpi_video_device_lcd_get_level_current(video, &level, false))
>   return -EINVAL;
>   for (offset = 2; offset < video->brightness->count; offset++)
> @@ -311,12 +317,16 @@ static int video_get_cur_state(struct thermal_cooling_device *cooling_dev, unsig
>  }
>
>  static int
> -video_set_cur_state(struct thermal_cooling_device *cooling_dev, unsigned long state)
> +video_set_cur_state(struct thermal_cooling_device *cooling_dev,
> + unsigned long state, enum thermal_cooling_unit unit)
>  {
>   struct acpi_device *device = cooling_dev->devdata;
>   struct acpi_video_device *video = acpi_driver_data(device);
>   int level;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   if (state >= video->brightness->count - 2)
>   return -EINVAL;
>
> @@ -326,9 +336,9 @@ video_set_cur_state(struct thermal_cooling_device *cooling_dev, unsigned long st
>  }
>
>  static const struct thermal_cooling_device_ops video_cooling_ops = {
> - .get_max_state = video_get_max_state,
> - .get_cur_state = video_get_cur_state,
> - .set_cur_state = video_set_cur_state,
> + .get_max = video_get_max_state,
> + .get_cur = video_get_cur_state,
> + .set_cur = video_set_cur_state,
>  };
>
>  /*
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index f94467c05225..0bb85e240d93 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -439,18 +439,26 @@ static struct thermal_zone_device_ops acerhdf_dev_ops = {
>   * get maximal fan cooling state
>   */
>  static int acerhdf_get_max_state(struct thermal_cooling_device *cdev,
> - unsigned long *state)
> + unsigned long *state,
> + enum thermal_cooling_unit unit)
>  {
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   *state = 1;
>
>   return 0;
>  }
>
>  static int acerhdf_get_cur_state(struct thermal_cooling_device *cdev,
> - unsigned long *state)
> + unsigned long *state,
> + enum thermal_cooling_unit unit)
>  {
>   int err = 0, tmp;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   err = acerhdf_get_fanstate(&tmp);
>   if (err)
>   return err;
> @@ -461,10 +469,14 @@ static int acerhdf_get_cur_state(struct thermal_cooling_device *cdev,
>
>  /* change current fan state - is overwritten when running in kernel mode */
>  static int acerhdf_set_cur_state(struct thermal_cooling_device *cdev,
> - unsigned long state)
> + unsigned long state,
> + enum thermal_cooling_unit unit)
>  {
>   int cur_temp, cur_state, err = 0;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   if (!kernelmode)
>   return 0;
>
> @@ -498,9 +510,9 @@ err_out:
>
>  /* bind fan callbacks to fan device */
>  static struct thermal_cooling_device_ops acerhdf_cooling_ops = {
> - .get_max_state = acerhdf_get_max_state,
> - .get_cur_state = acerhdf_get_cur_state,
> - .set_cur_state = acerhdf_set_cur_state,
> + .get_max = acerhdf_get_max_state,
> + .get_cur = acerhdf_get_cur_state,
> + .set_cur = acerhdf_set_cur_state,
>  };
>
>  /* suspend / resume functionality */
> diff --git a/drivers/platform/x86/intel_menlow.c b/drivers/platform/x86/intel_menlow.c
> index e8b46d2c468c..9792da407c46 100644
> --- a/drivers/platform/x86/intel_menlow.c
> +++ b/drivers/platform/x86/intel_menlow.c
> @@ -61,7 +61,8 @@ static void intel_menlow_unregister_sensor(void);
>   * GTHS returning '0' would mean that no bandwidth control states are supported
>   */
>  static int memory_get_max_bandwidth(struct thermal_cooling_device *cdev,
> -    unsigned long *max_state)
> + unsigned long *max_state,
> + enum thermal_cooling_unit unit)
>  {
>   struct acpi_device *device = cdev->devdata;
>   acpi_handle handle = device->handle;
> @@ -70,6 +71,9 @@ static int memory_get_max_bandwidth(struct thermal_cooling_device *cdev,
>   union acpi_object arg;
>   acpi_status status = AE_OK;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   arg_list.count = 1;
>   arg_list.pointer = &arg;
>   arg.type = ACPI_TYPE_INTEGER;
> @@ -87,7 +91,8 @@ static int memory_get_max_bandwidth(struct thermal_cooling_device *cdev,
>  }
>
>  static int memory_get_cur_bandwidth(struct thermal_cooling_device *cdev,
> -    unsigned long *value)
> +    unsigned long *value,
> +    enum thermal_cooling_unit unit)
>  {
>   struct acpi_device *device = cdev->devdata;
>   acpi_handle handle = device->handle;
> @@ -96,6 +101,9 @@ static int memory_get_cur_bandwidth(struct thermal_cooling_device *cdev,
>   union acpi_object arg;
>   acpi_status status = AE_OK;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   arg_list.count = 1;
>   arg_list.pointer = &arg;
>   arg.type = ACPI_TYPE_INTEGER;
> @@ -110,7 +118,8 @@ static int memory_get_cur_bandwidth(struct thermal_cooling_device *cdev,
>  }
>
>  static int memory_set_cur_bandwidth(struct thermal_cooling_device *cdev,
> -    unsigned long state)
> +    unsigned long state,
> +    enum thermal_cooling_unit unit)
>  {
>   struct acpi_device *device = cdev->devdata;
>   acpi_handle handle = device->handle;
> @@ -120,7 +129,10 @@ static int memory_set_cur_bandwidth(struct thermal_cooling_device *cdev,
>   unsigned long long temp;
>   unsigned long max_state;
>
> - if (memory_get_max_bandwidth(cdev, &max_state))
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
> + if (memory_get_max_bandwidth(cdev, &max_state, THERMAL_UNIT_STATE))
>   return -EFAULT;
>
>   if (state > max_state)
> @@ -143,9 +155,9 @@ static int memory_set_cur_bandwidth(struct thermal_cooling_device *cdev,
>  }
>
>  static struct thermal_cooling_device_ops memory_cooling_ops = {
> - .get_max_state = memory_get_max_bandwidth,
> - .get_cur_state = memory_get_cur_bandwidth,
> - .set_cur_state = memory_set_cur_bandwidth,
> + .get_max = memory_get_max_bandwidth,
> + .get_cur = memory_get_cur_bandwidth,
> + .set_cur = memory_set_cur_bandwidth,
>  };
>
>  /*
> diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
> index 26606641fe44..69dc2901a788 100644
> --- a/drivers/power/power_supply_core.c
> +++ b/drivers/power/power_supply_core.c
> @@ -440,12 +440,16 @@ static void psy_unregister_thermal(struct power_supply *psy)
>
>  /* thermal cooling device callbacks */
>  static int ps_get_max_charge_cntl_limit(struct thermal_cooling_device *tcd,
> - unsigned long *state)
> + unsigned long *state,
> + enum thermal_cooling_unit unit)
>  {
>   struct power_supply *psy;
>   union power_supply_propval val;
>   int ret;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   psy = tcd->devdata;
>   ret = psy->get_property(psy,
>   POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX, &val);
> @@ -456,12 +460,16 @@ static int ps_get_max_charge_cntl_limit(struct thermal_cooling_device *tcd,
>  }
>
>  static int ps_get_cur_chrage_cntl_limit(struct thermal_cooling_device *tcd,
> - unsigned long *state)
> + unsigned long *state,
> + enum thermal_cooling_unit unit)
>  {
>   struct power_supply *psy;
>   union power_supply_propval val;
>   int ret;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   psy = tcd->devdata;
>   ret = psy->get_property(psy,
>   POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT, &val);
> @@ -472,12 +480,16 @@ static int ps_get_cur_chrage_cntl_limit(struct thermal_cooling_device *tcd,
>  }
>
>  static int ps_set_cur_charge_cntl_limit(struct thermal_cooling_device *tcd,
> - unsigned long state)
> + unsigned long state,
> + enum thermal_cooling_unit unit)
>  {
>   struct power_supply *psy;
>   union power_supply_propval val;
>   int ret;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   psy = tcd->devdata;
>   val.intval = state;
>   ret = psy->set_property(psy,
> @@ -487,9 +499,9 @@ static int ps_set_cur_charge_cntl_limit(struct thermal_cooling_device *tcd,
>  }
>
>  static struct thermal_cooling_device_ops psy_tcd_ops = {
> - .get_max_state = ps_get_max_charge_cntl_limit,
> - .get_cur_state = ps_get_cur_chrage_cntl_limit,
> - .set_cur_state = ps_set_cur_charge_cntl_limit,
> + .get_max = ps_get_max_charge_cntl_limit,
> + .get_cur = ps_get_cur_chrage_cntl_limit,
> + .set_cur = ps_set_cur_charge_cntl_limit,
>  };
>
>  static int psy_register_cooler(struct power_supply *psy)
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 4246262c4bd2..f3f4e6b5798e 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -348,14 +348,17 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
>   * cpufreq_get_max_state - callback function to get the max cooling state.
>   * @cdev: thermal cooling device pointer.
>   * @state: fill this variable with the max cooling state.
> + * @unit: the units in which @state should be in.
>   *
> - * Callback for the thermal cooling device to return the cpufreq
> - * max cooling state.
> + * Callback for the thermal cooling device to return the cpufreq max
> + * cooling state.  Currently only THERMAL_UNIT_STATE is valid for
> + * @unit.
>   *
>   * Return: 0 on success, an error code otherwise.
>   */
>  static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
> - unsigned long *state)
> + unsigned long *state,
> + enum thermal_cooling_unit unit)
>  {
>   struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
>   struct cpumask *mask = &cpufreq_device->allowed_cpus;
> @@ -363,6 +366,9 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
>   unsigned int count = 0;
>   int ret;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   cpu = cpumask_any(mask);
>
>   ret = get_property(cpu, 0, &count, GET_MAXL);
> @@ -377,17 +383,23 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
>   * cpufreq_get_cur_state - callback function to get the current cooling state.
>   * @cdev: thermal cooling device pointer.
>   * @state: fill this variable with the current cooling state.
> + * @unit: the units in which state should be in
>   *
>   * Callback for the thermal cooling device to return the cpufreq
> - * current cooling state.
> + * current cooling state.  Currently only THERMAL_UNIT_STATE is valid
> + * for @unit.
>   *
>   * Return: 0 on success, an error code otherwise.
>   */
>  static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
> - unsigned long *state)
> + unsigned long *state,
> + enum thermal_cooling_unit unit)
>  {
>   struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   *state = cpufreq_device->cpufreq_state;
>
>   return 0;
> @@ -397,25 +409,31 @@ static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
>   * cpufreq_set_cur_state - callback function to set the current cooling state.
>   * @cdev: thermal cooling device pointer.
>   * @state: set this variable to the current cooling state.
> + * @unit: the units in which @state should be in.
>   *
>   * Callback for the thermal cooling device to change the cpufreq
> - * current cooling state.
> + * current cooling state.  Currently only THERMAL_UNIT_STATE is valid for
> + * @unit.
>   *
>   * Return: 0 on success, an error code otherwise.
>   */
>  static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
> - unsigned long state)
> + unsigned long state,
> + enum thermal_cooling_unit unit)
>  {
>   struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   return cpufreq_apply_cooling(cpufreq_device, state);
>  }
>
>  /* Bind cpufreq callbacks to thermal cooling device ops */
>  static struct thermal_cooling_device_ops const cpufreq_cooling_ops = {
> - .get_max_state = cpufreq_get_max_state,
> - .get_cur_state = cpufreq_get_cur_state,
> - .set_cur_state = cpufreq_set_cur_state,
> + .get_max = cpufreq_get_max_state,
> + .get_cur = cpufreq_get_cur_state,
> + .set_cur = cpufreq_set_cur_state,
>  };
>
>  /* Notifier for cpufreq policy change */
> diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
> index 1e3b3bf9f993..0842a2ef88b4 100644
> --- a/drivers/thermal/db8500_thermal.c
> +++ b/drivers/thermal/db8500_thermal.c
> @@ -67,7 +67,7 @@ static int db8500_cdev_bind(struct thermal_zone_device *thermal,
>   unsigned long max_state, upper, lower;
>   int i, ret = -EINVAL;
>
> - cdev->ops->get_max_state(cdev, &max_state);
> + cdev->ops->get_max(cdev, &max_state, THERMAL_UNIT_STATE);
>
>   for (i = 0; i < ptrips->num_trips; i++) {
>   if (db8500_thermal_match_cdev(cdev, &ptrips->trip_points[i]))
> diff --git a/drivers/thermal/fair_share.c b/drivers/thermal/fair_share.c
> index 944ba2f340c8..8e6eb4883bb6 100644
> --- a/drivers/thermal/fair_share.c
> +++ b/drivers/thermal/fair_share.c
> @@ -51,7 +51,7 @@ static long get_target_state(struct thermal_zone_device *tz,
>  {
>   unsigned long max_state;
>
> - cdev->ops->get_max_state(cdev, &max_state);
> + cdev->ops->get_max(cdev, &max_state, THERMAL_UNIT_STATE);
>
>   return (long)(weight * level * max_state) / (100 * tz->trips);
>  }
> diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
> index a084325f1386..c32bee16b17a 100644
> --- a/drivers/thermal/intel_powerclamp.c
> +++ b/drivers/thermal/intel_powerclamp.c
> @@ -616,16 +616,24 @@ static struct notifier_block powerclamp_cpu_notifier = {
>  };
>
>  static int powerclamp_get_max_state(struct thermal_cooling_device *cdev,
> - unsigned long *state)
> + unsigned long *state,
> + enum thermal_cooling_unit unit)
>  {
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   *state = MAX_TARGET_RATIO;
>
>   return 0;
>  }
>
>  static int powerclamp_get_cur_state(struct thermal_cooling_device *cdev,
> - unsigned long *state)
> + unsigned long *state,
> + enum thermal_cooling_unit unit)
>  {
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   if (true == clamping)
>   *state = pkg_cstate_ratio_cur;
>   else
> @@ -636,10 +644,14 @@ static int powerclamp_get_cur_state(struct thermal_cooling_device *cdev,
>  }
>
>  static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
> - unsigned long new_target_ratio)
> + unsigned long new_target_ratio,
> + enum thermal_cooling_unit unit)
>  {
>   int ret = 0;
>
> + if (unit != THERMAL_UNIT_STATE)
> + return -EINVAL;
> +
>   new_target_ratio = clamp(new_target_ratio, 0UL,
>   (unsigned long) (MAX_TARGET_RATIO-1));
>   if (set_target_ratio == 0 && new_target_ratio > 0) {
> @@ -663,9 +675,9 @@ exit_set:
>
>  /* bind to generic thermal layer as cooling device*/
>  static struct thermal_cooling_device_ops powerclamp_cooling_ops = {
> - .get_max_state = powerclamp_get_max_state,
> - .get_cur_state = powerclamp_get_cur_state,
> - .set_cur_state = powerclamp_set_cur_state,
> + .get_max = powerclamp_get_max_state,
> + .get_cur = powerclamp_get_cur_state,
> + .set_cur = powerclamp_set_cur_state,
>  };
>
>  /* runs on Nehalem and later */
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index f251521baaa2..2a2cd4eba3c3 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -58,7 +58,7 @@ static unsigned long get_target_state(struct thermal_instance *instance,
>   * Otherwise, we use the current state of the
>   * cdev in use to determine the next_target.
>   */
> - cdev->ops->get_cur_state(cdev, &cur_state);
> + cdev->ops->get_cur(cdev, &cur_state, THERMAL_UNIT_STATE);
>   next_target = instance->target;
>   dev_dbg(&cdev->device, "cur_state=%ld\n", cur_state);
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index ac8e5990a63e..5b46603cc7cd 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -871,7 +871,7 @@ thermal_cooling_device_max_state_show(struct device *dev,
>   unsigned long state;
>   int ret;
>
> - ret = cdev->ops->get_max_state(cdev, &state);
> + ret = cdev->ops->get_max(cdev, &state, THERMAL_UNIT_STATE);
>   if (ret)
>   return ret;
>   return sprintf(buf, "%ld\n", state);
> @@ -885,7 +885,7 @@ thermal_cooling_device_cur_state_show(struct device *dev,
>   unsigned long state;
>   int ret;
>
> - ret = cdev->ops->get_cur_state(cdev, &state);
> + ret = cdev->ops->get_cur(cdev, &state, THERMAL_UNIT_STATE);
>   if (ret)
>   return ret;
>   return sprintf(buf, "%ld\n", state);
> @@ -906,7 +906,7 @@ thermal_cooling_device_cur_state_store(struct device *dev,
>   if ((long)state < 0)
>   return -EINVAL;
>
> - result = cdev->ops->set_cur_state(cdev, state);
> + result = cdev->ops->set_cur(cdev, state, THERMAL_UNIT_STATE);
>   if (result)
>   return result;
>   return count;
> @@ -983,7 +983,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>   if (tz != pos1 || cdev != pos2)
>   return -EINVAL;
>
> - cdev->ops->get_max_state(cdev, &max_state);
> + cdev->ops->get_max(cdev, &max_state, THERMAL_UNIT_STATE);
>
>   /* lower default 0, upper default max_state */
>   lower = lower == THERMAL_NO_LIMIT ? 0 : lower;
> @@ -1143,8 +1143,7 @@ __thermal_cooling_device_register(struct device_node *np,
>   if (type && strlen(type) >= THERMAL_NAME_LENGTH)
>   return ERR_PTR(-EINVAL);
>
> - if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> -    !ops->set_cur_state)
> + if (!ops || !ops->get_max || !ops->get_cur || !ops->set_cur)
>   return ERR_PTR(-EINVAL);
>
>   cdev = kzalloc(sizeof(struct thermal_cooling_device), GFP_KERNEL);
> @@ -1329,7 +1328,7 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
>   target = instance->target;
>   }
>   mutex_unlock(&cdev->lock);
> - cdev->ops->set_cur_state(cdev, target);
> + cdev->ops->set_cur(cdev, target, THERMAL_UNIT_STATE);
>   cdev->updated = true;
>   dev_dbg(&cdev->device, "set to state %lu\n", target);
>  }


I believe the sysfs API needs to be refactored too. Here we would need
to have a new entry 'unit' to represent what unit the cooling device
supports.

> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index baac212f815e..8d183b8255eb 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -106,6 +106,10 @@ enum {
>  };
>  #define THERMAL_GENL_CMD_MAX (__THERMAL_GENL_CMD_MAX - 1)
>
> +enum thermal_cooling_unit {
> + THERMAL_UNIT_STATE,
> +};
> +
>  struct thermal_zone_device_ops {
>   int (*bind) (struct thermal_zone_device *,
>       struct thermal_cooling_device *);
> @@ -135,9 +139,12 @@ struct thermal_zone_device_ops {
>  };
>
>  struct thermal_cooling_device_ops {
> - int (*get_max_state) (struct thermal_cooling_device *, unsigned long *);
> - int (*get_cur_state) (struct thermal_cooling_device *, unsigned long *);
> - int (*set_cur_state) (struct thermal_cooling_device *, unsigned long);
> + int (*get_max)(struct thermal_cooling_device *, unsigned long *,
> + enum thermal_cooling_unit);
> + int (*get_cur)(struct thermal_cooling_device *, unsigned long *,
> + enum thermal_cooling_unit);
> + int (*set_cur)(struct thermal_cooling_device *, unsigned long,
> + enum thermal_cooling_unit);
>  };


Now, reading this patch again, I realize that this API may be improved.
How about doing a handshake between the cooling device and the governor
instead of sending the required unit on every message

That is, the thermal core would ask the cooling device its supported
unit and the governor supported unit, then the bind would be called
only if they match units. I am assuming we are limiting to one supported
unit per cooling device / governor, right?

>
>  struct thermal_cooling_device {
> --
> 1.7.9.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
