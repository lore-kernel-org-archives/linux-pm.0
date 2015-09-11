From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V8] Report interrupt that caused system wakeup
Date: Sat, 12 Sep 2015 01:36:15 +0200
Message-ID: <2235143.PitGJtzR6R@vostro.rjw.lan>
References: <1441929860-5488-1-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55572 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754720AbbIKXIW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2015 19:08:22 -0400
In-Reply-To: <1441929860-5488-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: tglx@linutronix.de, kristen.c.accardi@intel.com, linux-pm@vger.kernel.org

On Thursday, September 10, 2015 05:04:20 PM Alexandra Yates wrote:
> This feature reports the IRQ that was armed for system wakeup after
> the system was last time suspended. It adds a new sysfs attribute
> under /sys/power/ named: pm_last_wakeup_irq

What about changing it this way:

Add a sysfs attribute, /sys/power/pm_wakeup_irq, reporting the IRQ number of
the first wakeup interrupt (that is, the first interrupt from an IRQ line
armed for system wakeup) seen by the kernel during the most recent system
suspend/resume cycle.

> This feature will be useful for system wakeup diagnostics of
> spurious wakeup interrupts.
> 
> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> ---
>  Documentation/ABI/testing/sysfs-power | 11 +++++++++++
>  drivers/base/power/wakeup.c           | 12 ++++++++++++
>  include/linux/suspend.h               |  8 +++++++-
>  kernel/irq/pm.c                       |  4 ++--
>  kernel/power/main.c                   | 19 +++++++++++++++++++
>  5 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index f455181..75f27ed 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -256,3 +256,14 @@ Description:
>  		Writing a "1" enables this printing while writing a "0"
>  		disables it.  The default value is "0".  Reading from this file
>  		will display the current value.
> +
> +What:		/sys/power/pm_last_wakeup_irq

I'd change that to /sys/power/pm_wakeup_irq

> +Date:		April 2015
> +Contact:	Alexandra Yates <alexandra.yates@linux.intel.org>
> +Description:
> +		The /sys/power/pm_last_wakeup_irq file reports to user space
> +		the IRQ that was armed for system wakeup and occurred since
> +		suspend_device_irqs() was last called.

And here I'd say:

The /sys/power/pm_wakeup_irq file reports to user space the IRQ number of
the first wakeup interrupt (that is, the first interrupt from an IRQ line
armed for system wakeup) seen by the kernel during the most recent system
suspend/resume cycle.

> +
> +		This output is useful for system wakeup diagnostics of spurious
> +		wakeup interrupts.
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 51f15bc..f663fb1 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -870,6 +870,18 @@ void pm_wakeup_clear(void)
>  	pm_abort_suspend = false;
>  }
>  
> +void pm_system_irq_wakeup(unsigned int irq_number)
> +{
> +	if (wakeup_irq == 0)
> +		wakeup_irq = irq_number;
> +	pm_system_wakeup();

I'm wondering if we need to call pm_system_wakeup() in the wakeup_irq != 0 case?

If wakeup_irq != 0, pm_system_wakeup() has been called (at least) once already
and it is not necessary to call it more than once.  Or am I missing anything?

> +}
> +
> +void pm_last_wakeup_irq_reset(void)
> +{
> +	wakeup_irq = 0;
> +}

Why don't you clear wakeup_irq in pm_wakeup_clear()?  Can it actually change
between the time when pm_wakeup_clear() is called and when suspend_device_irqs()
runs?

> +
>  /**
>   * pm_get_wakeup_count - Read the number of registered wakeup events.
>   * @count: Address to store the value at.
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 5efe743..eb5ad3b 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -371,6 +371,9 @@ static inline bool hibernation_available(void) { return false; }
>  
>  extern struct mutex pm_mutex;
>  
> +/* IRQ number which causes system wakeup  */
> +extern unsigned int wakeup_irq;
> +
>  #ifdef CONFIG_PM_SLEEP
>  void save_processor_state(void);
>  void restore_processor_state(void);
> @@ -378,7 +381,7 @@ void restore_processor_state(void);
>  /* kernel/power/main.c */
>  extern int register_pm_notifier(struct notifier_block *nb);
>  extern int unregister_pm_notifier(struct notifier_block *nb);
> -
> +extern void pm_last_wakeup_irq_reset(void);
>  #define pm_notifier(fn, pri) {				\
>  	static struct notifier_block fn##_nb =			\
>  		{ .notifier_call = fn, .priority = pri };	\
> @@ -391,6 +394,7 @@ extern bool events_check_enabled;
>  extern bool pm_wakeup_pending(void);
>  extern void pm_system_wakeup(void);
>  extern void pm_wakeup_clear(void);
> +extern void pm_system_irq_wakeup(unsigned int);
>  extern bool pm_get_wakeup_count(unsigned int *count, bool block);
>  extern bool pm_save_wakeup_count(unsigned int count);
>  extern void pm_wakep_autosleep_enabled(bool set);
> @@ -440,6 +444,8 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
>  static inline bool pm_wakeup_pending(void) { return false; }
>  static inline void pm_system_wakeup(void) {}
>  static inline void pm_wakeup_clear(void) {}
> +static inline void pm_system_irq_wakeup(unsigned int) {}
> +static inline void pm_last_wakeup_irq_reset(void){};
>  
>  static inline void lock_system_sleep(void) {}
>  static inline void unlock_system_sleep(void) {}
> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index d22786a..18178d7 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -21,7 +21,7 @@ bool irq_pm_check_wakeup(struct irq_desc *desc)
>  		desc->istate |= IRQS_SUSPENDED | IRQS_PENDING;
>  		desc->depth++;
>  		irq_disable(desc);
> -		pm_system_wakeup();
> +		pm_system_irq_wakeup(irq_desc_get_irq(desc));
>  		return true;
>  	}
>  	return false;
> @@ -118,7 +118,7 @@ void suspend_device_irqs(void)
>  {
>  	struct irq_desc *desc;
>  	int irq;
> -
> +	pm_last_wakeup_irq_reset();
>  	for_each_irq_desc(irq, desc) {
>  		unsigned long flags;
>  		bool sync;
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 63d395b..d2bd164 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -272,6 +272,24 @@ static inline void pm_print_times_init(void)
>  {
>  	pm_print_times_enabled = !!initcall_debug;
>  }
> +
> +unsigned int wakeup_irq;
> +EXPORT_SYMBOL_GPL(wakeup_irq);

It doesn't have to be exported to modules.

> +static ssize_t pm_last_wakeup_irq_show(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					char *buf)
> +{
> +	return wakeup_irq ? sprintf(buf, "%u\n", wakeup_irq) : -EINVAL;

-EINVAL means "invalid argument", which is not the case here.

I'd use -ENODATA.

> +}
> +
> +static ssize_t pm_last_wakeup_irq_store(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					const char *buf, size_t n)
> +{
> +	return -EINVAL;
> +}
> +power_attr(pm_last_wakeup_irq);
> +
>  #else /* !CONFIG_PM_SLEEP_DEBUG */
>  static inline void pm_print_times_init(void) {}
>  #endif /* CONFIG_PM_SLEEP_DEBUG */
> @@ -604,6 +622,7 @@ static struct attribute * g[] = {
>  #endif
>  #ifdef CONFIG_PM_SLEEP_DEBUG
>  	&pm_print_times_attr.attr,
> +	&pm_last_wakeup_irq_attr.attr,
>  #endif
>  #endif
>  #ifdef CONFIG_FREEZER
> 

Thanks,
Rafael

