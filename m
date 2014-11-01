From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4] kernel: Add support for power-off handler call chain
Date: Sat, 01 Nov 2014 10:02:07 -0700
Message-ID: <5455120F.1030008@roeck-us.net>
References: <1414516266-4965-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36971 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758135AbaKARC4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Nov 2014 13:02:56 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xkc4l-000aN0-0v
	for linux-pm@vger.kernel.org; Sat, 01 Nov 2014 17:02:55 +0000
In-Reply-To: <1414516266-4965-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Romain Perier <romain.perier@gmail.com>

On 10/28/2014 10:11 AM, Guenter Roeck wrote:
> Various drivers implement architecture and/or device specific means t=
o
> power off the system.  For the most part, those drivers set the globa=
l
> variable pm_power_off to point to a function within the driver.
>
> This mechanism has a number of drawbacks.  Typically only one scheme
> to remove power is supported (at least if pm_power_off is used).
> At least in theory there can be multiple means remove power, some of
> which may be less desirable. For example, some mechanisms may only
> power off the CPU or the CPU card, while another may power off the
> entire system.  Others may really just execute a restart sequence
> or drop into the ROM monitor. Using pm_power_off can also be racy
> if the function pointer is set from a driver built as module, as the
> driver may be in the process of being unloaded when pm_power_off is
> called. If there are multiple power-off handlers in the system, remov=
ing
> a module with such a handler may inadvertently reset the pointer to
> pm_power_off to NULL, leaving the system with no means to remove powe=
r.
>
> Introduce a system power-off handler call chain to solve the describe=
d
> problems.  This call chain is expected to be executed from the archit=
ecture
> specific machine_power_off() function.  Drivers and architeceture cod=
e
> providing system power-off functionality are expected to register wit=
h
> this call chain.  When registering a power-off handler, callers can
> provide a priority to control power-off handler execution sequence
> and thus ensure that the power-off handler with the optimal capabilit=
ies
> to remove power for a given system is called first.
>
> Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Philippe R=C3=A9tornaz <philippe.retornaz@gmail.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Romain Perier <romain.perier@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Without agreement on this patch it does not make sense to keep going
> with the rest of the series, so I won't submit the rest of the series
> anymore until this patch has been accepted.
>

Rafael,

if/when you find the time, it would be great if you can send me
your feedback on this patch.

I still hope the series can make it into 3.19, but for that to happen
I would want it to mature in -next for a while.

My plan going forward is to have the entire series except for the
last patch added to -next and to send a pull request for it to Linus
early in the next commit window.

Thanks,
Guenter


> Tested with acpi power-off handler (patch 34/47 of original series)
> with adjustments made for the new version of this patch.
>
> v4:
> - Do not use notifiers but internal functions and data structures to =
manage
>    the list of power-off handlers. Drop unused parameters from callba=
cks, and
>    make the power-off function type void.
>    Code to manage and walk the list of callbacks is derived from noti=
fier.c.
> v3:
> - Rename new file to power_off_handler.c
> - Replace poweroff in all newly introduced variables and in text
>    with power_off or power-off as appropriate
> - Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
> - Execute power-off handlers without any locks held
> v2:
> - poweroff -> power_off
> - Add defines for default priorities
> - Use raw notifiers protected by spinlocks instead of atomic notifier=
s
> - Add register_poweroff_handler_simple
> - Add devm_register_power_off_handler
>
>   include/linux/pm.h               |  28 ++++
>   kernel/power/Makefile            |   1 +
>   kernel/power/power_off_handler.c | 293 ++++++++++++++++++++++++++++=
+++++++++++
>   3 files changed, 322 insertions(+)
>   create mode 100644 kernel/power/power_off_handler.c
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 383fd68..a4d6bf8 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -35,6 +35,34 @@ extern void (*pm_power_off)(void);
>   extern void (*pm_power_off_prepare)(void);
>
>   struct device; /* we have a circular dep with device.h */
> +
> +/*
> + * Data structures and callbacks to manage power-off handlers
> + */
> +
> +struct power_off_handler_block {
> +	void (*handler)(struct power_off_handler_block *);
> +	struct power_off_handler_block __rcu *next;
> +	int priority;
> +};
> +
> +int register_power_off_handler(struct power_off_handler_block *);
> +int devm_register_power_off_handler(struct device *,
> +				    struct power_off_handler_block *);
> +int register_power_off_handler_simple(void (*function)(void), int pr=
iority);
> +int unregister_power_off_handler(struct power_off_handler_block *);
> +void do_kernel_power_off(void);
> +bool have_kernel_power_off(void);
> +
> +/*
> + * Pre-defined power-off handler priorities
> + */
> +#define POWER_OFF_PRIORITY_FALLBACK	0
> +#define POWER_OFF_PRIORITY_LOW		64
> +#define POWER_OFF_PRIORITY_DEFAULT	128
> +#define POWER_OFF_PRIORITY_HIGH		192
> +#define POWER_OFF_PRIORITY_HIGHEST	255
> +
>   #ifdef CONFIG_VT_CONSOLE_SLEEP
>   extern void pm_vt_switch_required(struct device *dev, bool required=
);
>   extern void pm_vt_switch_unregister(struct device *dev);
> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
> index 29472bf..567eda5 100644
> --- a/kernel/power/Makefile
> +++ b/kernel/power/Makefile
> @@ -2,6 +2,7 @@
>   ccflags-$(CONFIG_PM_DEBUG)	:=3D -DDEBUG
>
>   obj-y				+=3D qos.o
> +obj-y				+=3D power_off_handler.o
>   obj-$(CONFIG_PM)		+=3D main.o
>   obj-$(CONFIG_VT_CONSOLE_SLEEP)	+=3D console.o
>   obj-$(CONFIG_FREEZER)		+=3D process.o
> diff --git a/kernel/power/power_off_handler.c b/kernel/power/power_of=
f_handler.c
> new file mode 100644
> index 0000000..e576534
> --- /dev/null
> +++ b/kernel/power/power_off_handler.c
> @@ -0,0 +1,293 @@
> +/*
> + * kernel/power/power_off_handler.c - Power-off handling functions
> + *
> + * Copyright (c) 2014 Guenter Roeck
> + *
> + * List management code derived from kernel/notifier.c.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public Licence
> + * as published by the Free Software Foundation; either version
> + * 2 of the Licence, or (at your option) any later version.
> + */
> +
> +#define pr_fmt(fmt)	"power-off: " fmt
> +
> +#include <linux/ctype.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/kallsyms.h>
> +#include <linux/pm.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +/*
> + * List of handlers for kernel code which wants to be called
> + * to power off the system.
> + */
> +static struct power_off_handler_block __rcu *power_off_handler_list;
> +static DEFINE_SPINLOCK(power_off_handler_lock);
> +
> +/*
> + * Internal function to register power-off handler.
> + * Must be called with power-off spinlock acquired.
> + */
> +static void _register_power_off_handler(struct power_off_handler_blo=
ck *p)
> +{
> +	struct power_off_handler_block **pl =3D &power_off_handler_list;
> +
> +	while ((*pl) !=3D NULL) {
> +		if (p->priority > (*pl)->priority)
> +			break;
> +		pl =3D &((*pl)->next);
> +	}
> +	p->next =3D *pl;
> +	rcu_assign_pointer(*pl, p);
> +}
> +
> +/*
> + * Internal function to unregister a power-off handler.
> + * Must be called with power-off spinlock acquired.
> + */
> +static int _unregister_power_off_handler(struct power_off_handler_bl=
ock *p)
> +{
> +	struct power_off_handler_block **pl =3D &power_off_handler_list;
> +
> +	while ((*pl) !=3D NULL) {
> +		if ((*pl) =3D=3D p) {
> +			rcu_assign_pointer(*pl, p->next);
> +			return 0;
> +		}
> +		pl =3D &((*pl)->next);
> +	}
> +	return -ENOENT;
> +}
> +
> +/**
> + *	register_power_off_handler - Register function to be called to po=
wer off
> + *				     the system
> + *	@nb: Info about handler function to be called
> + *	@nb->priority:	Handler priority. Handlers should follow the
> + *			following guidelines for setting priorities.
> + *			0:	Power-off handler of last resort,
> + *				with limited power-off capabilities,
> + *				such as power-off handlers which
> + *				do not really power off the system
> + *				but loop forever or stop the CPU.
> + *			128:	Default power-off handler; use if no other
> + *				power-off handler is expected to be available,
> + *				and/or if power-off functionality is
> + *				sufficient to power off the entire system
> + *			255:	Highest priority power-off handler, will
> + *				preempt all other power-off handlers
> + *
> + *	Registers a function with code to be called to power off the
> + *	system.
> + *
> + *	Registered functions will be called from machine_power_off as las=
t
> + *	step of the power-off sequence. Registered functions are expected
> + *	to power off the system immediately. If more than one function is
> + *	registered, the power-off handler priority selects which function
> + *	will be called first.
> + *
> + *	Power-off handlers may be registered from architecture code or fr=
om
> + *	drivers. A typical use case would be a system where power off
> + *	functionality is provided through a multi-function chip or throug=
h
> + *	a programmable power controller. Multiple power-off handlers may =
exist;
> + *	for example, one power-off handler might power off the entire sys=
tem,
> + *	while another only powers off the CPU card. In such cases, the
> + *	power-off handler which only powers off part of the hardware is
> + *	expected to register with low priority to ensure that it only
> + *	runs if no other means to power off the system are available.
> + *
> + *	Always returns zero.
> + */
> +int register_power_off_handler(struct power_off_handler_block *pb)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&power_off_handler_lock, flags);
> +	_register_power_off_handler(pb);
> +	spin_unlock_irqrestore(&power_off_handler_lock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(register_power_off_handler);
> +
> +/**
> + *	unregister_power_off_handler - Unregister previously registered
> + *				       power-off handler
> + *	@nb: Hook to be unregistered
> + *
> + *	Unregisters a previously registered power-off handler function.
> + *
> + *	Returns zero on success, or %-ENOENT on failure.
> + */
> +int unregister_power_off_handler(struct power_off_handler_block *pb)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&power_off_handler_lock, flags);
> +	ret =3D _unregister_power_off_handler(pb);
> +	spin_unlock_irqrestore(&power_off_handler_lock, flags);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(unregister_power_off_handler);
> +
> +struct _power_off_handler_data {
> +	void (*handler)(void);
> +	struct power_off_handler_block power_off_hb;
> +};
> +
> +static void _power_off_handler(struct power_off_handler_block *this)
> +{
> +	struct _power_off_handler_data *poh =3D
> +		container_of(this, struct _power_off_handler_data,
> +			     power_off_hb);
> +
> +	poh->handler();
> +}
> +
> +static struct _power_off_handler_data power_off_handler_data;
> +
> +/**
> + *	register_power_off_handler_simple - Register function to be calle=
d
> + *					    to power off the system
> + *	@handler:	Function to be called to power off the system
> + *	@priority:	Handler priority. For priority guidelines see
> + *			register_power_off_handler.
> + *
> + *	This is a simplified version of register_power_off_handler. It do=
es
> + *	not take a power-off handler as argument, but a function pointer.
> + *	The function registers a power-off handler with specified priorit=
y.
> + *	Power-off handlers registered with this function can not be
> + *	unregistered, and only a single power-off handler can be installe=
d
> + *	using it.
> + *
> + *	This function must not be called from modules and is therefore
> + *	not exported.
> + *
> + *	Returns %-EBUSY if a power-off handler has already been registere=
d
> + *	using register_power_off_handler_simple. Otherwise returns zero.
> + */
> +int register_power_off_handler_simple(void (*handler)(void), int pri=
ority)
> +{
> +	unsigned long flags;
> +	int ret =3D 0;
> +
> +	spin_lock_irqsave(&power_off_handler_lock, flags);
> +
> +	if (power_off_handler_data.handler) {
> +		pr_warn("Power-off function already registered (%ps), cannot regis=
ter %ps",
> +			power_off_handler_data.handler, handler);
> +		ret =3D -EBUSY;
> +		goto abort;
> +	}
> +
> +	power_off_handler_data.handler =3D handler;
> +	power_off_handler_data.power_off_hb.handler =3D _power_off_handler;
> +	power_off_handler_data.power_off_hb.priority =3D priority;
> +
> +	_register_power_off_handler(&power_off_handler_data.power_off_hb);
> +abort:
> +	spin_unlock_irqrestore(&power_off_handler_lock, flags);
> +	return ret;
> +}
> +
> +/* Device managed power-off handler registration */
> +
> +static void devm_power_off_release(struct device *dev, void *res)
> +{
> +	struct power_off_handler_block *hb;
> +
> +	hb =3D *(struct power_off_handler_block **)res;
> +	unregister_power_off_handler(hb);
> +}
> +
> +/**
> + *	devm_register_power_off_handler - Register function to be called
> + *					  to power off the system
> + *	@dev:		The device registering the power-off handler.
> + *	@handler:	Function to be called to power off the system
> + *	@priority:	Handler priority. For priority guidelines see
> + *			register_power_off_handler.
> + *
> + *	This is the device managed version of register_power_off_handler.
> + *
> + *	Returns %-EINVAL if dev is NULL. Returns %-ENOMEM if the system i=
s
> + *	out of memory. Otherwise returns zero.
> + */
> +int devm_register_power_off_handler(struct device *dev,
> +				    struct power_off_handler_block *hb)
> +{
> +	struct power_off_handler_block **ptr;
> +	unsigned long flags;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	ptr =3D devres_alloc(devm_power_off_release, sizeof(*ptr), GFP_KERN=
EL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	spin_lock_irqsave(&power_off_handler_lock, flags);
> +	_register_power_off_handler(hb);
> +	spin_unlock_irqrestore(&power_off_handler_lock, flags);
> +
> +	*ptr =3D hb;
> +	devres_add(dev, ptr);
> +	return 0;
> +}
> +EXPORT_SYMBOL(devm_register_power_off_handler);
> +
> +/**
> + *	do_kernel_power_off - Execute kernel power-off handler call chain
> + *
> + *	Calls functions registered with register_power_off_handler.
> + *
> + *	Expected to be called from machine_power_off as last step of
> + *	the power-off sequence.
> + *
> + *	Powers the system off immediately if a power-off handler function
> + *	has been registered. Otherwise does nothing.
> + */
> +void do_kernel_power_off(void)
> +{
> +	struct power_off_handler_block *p, *next_p;
> +
> +	/*
> +	 * No locking. This code can be called from both atomic and non-ato=
mic
> +	 * context, with interrupts enabled or disabled, depending on the
> +	 * architecture and platform.
> +	 *
> +	 * Power-off handler registration and de-registration are executed =
in
> +	 * atomic context with interrupts disabled, which guarantees that
> +	 * do_kernel_power_off() will not be called while a power-off handl=
er
> +	 * is installed or removed.
> +	 * There is a theoretic risc that a power-off handler is installed =
or
> +	 * removed while the call chain is traversed, but we'll have to acc=
ept
> +	 * that risk.
> +	 */
> +
> +	p =3D rcu_dereference_raw(power_off_handler_list);
> +	while (p) {
> +		next_p =3D rcu_dereference_raw(p->next);
> +		p->handler(p);
> +		p =3D next_p;
> +	}
> +}
> +
> +/**
> + * have_kernel_power_off() - Check if kernel power-off handler is av=
ailable
> + *
> + * Returns true if a kernel power-off handler is available, false ot=
herwise.
> + */
> +bool have_kernel_power_off(void)
> +{
> +	return pm_power_off !=3D NULL ||
> +			rcu_dereference_raw(power_off_handler_list) !=3D NULL;
> +}
> +EXPORT_SYMBOL(have_kernel_power_off);
>

