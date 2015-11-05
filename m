From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] PM / sleep: prohibit devices probing during
 suspend/hibernation
Date: Thu, 5 Nov 2015 23:19:03 +0100
Message-ID: <20151105221903.GA4919@amd>
References: <1445288064-25299-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445288064-25299-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, stern@rowland.harvard.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon 2015-10-19 23:54:24, Grygorii Strashko wrote:
> It is unsafe [1] if probing of devices will happen during suspend or
> hibernation and system behavior will be unpredictable in this case
> (for example: after successful probe the device potentially has a different
>  set of PM callbacks than before [2]).
> So, let's prohibit device's probing in dpm_prepare() and defer their
> probes instead. The normal behavior will be restored in dpm_complete().
> 
> This patch introduces new DD core APIs:
>  device_defer_all_probes_enable()
>    It will disable probing of devices and defer their probes.
>  device_defer_all_probes_disable()
>    It will restore normal behavior and trigger re-probing of deferred
>    devices.
> 
> [1] https://lkml.org/lkml/2015/9/11/554
> [2] https://lkml.org/lkml/2015/9/15/1039
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> Changes in v2:
> - DD core API device_defer_all_probes(bool enable) split on two
>   void device_defer_all_probes_enable(void);
>   void device_defer_all_probes_disable(void);
> - more comments added
> 
> Link on v1:
> - https://lkml.org/lkml/2015/10/8/681
> 
>  drivers/base/base.h       |  2 ++
>  drivers/base/dd.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/base/power/main.c | 17 +++++++++++++++++
>  3 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 1782f3a..c332b68 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -131,6 +131,8 @@ extern void device_remove_groups(struct device *dev,
>  extern char *make_class_name(const char *name, struct kobject *kobj);
>  
>  extern int devres_release_all(struct device *dev);
> +extern void device_defer_all_probes_enable(void);
> +extern void device_defer_all_probes_disable(void);
>  
>  /* /sys/devices directory */
>  extern struct kset *devices_kset;
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index be0eb46..b8d9e70 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -55,6 +55,13 @@ static struct workqueue_struct *deferred_wq;
>  static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
>  
>  /*
> + * In some cases, like suspend to RAM or hibernation, It might be reasonable
> + * to prohibit probing of devices as it could be unsafe.
> + * Once defer_all_probes is true all drivers probes will be forcibly deferred.
> + */
> +static bool defer_all_probes;
> +
> +/*
>   * deferred_probe_work_func() - Retry probing devices in the active list.
>   */
>  static void deferred_probe_work_func(struct work_struct *work)
> @@ -172,6 +179,30 @@ static void driver_deferred_probe_trigger(void)
>  }
>  
>  /**
> + * device_defer_all_probes_enable() - Enable deferring of device's probes
> + *
> + *	It will disable probing of devices and defer their probes.
> + */
> +void device_defer_all_probes_enable(void)
> +{
> +	defer_all_probes = true;
> +	/* sync with probes to avoid races. */
> +	wait_for_device_probe();
> +}

device_pause_probing()?

> +/**
> + * device_defer_all_probes_disable() - Disable deferring of device's probes
> + *
> + *	It will restore normal behavior and trigger re-probing of deferred
> + * devices.
> + */

Hmm. This is not quite a double negative... but it sounds like one.

device_restart_probing()?

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
