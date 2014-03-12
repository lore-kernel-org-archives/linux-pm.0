From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] power: add an API to log wakeup reasons
Date: Tue, 11 Mar 2014 17:23:57 -0700
Message-ID: <1394583837.28839.19.camel@joe-AO722>
References: <1394503322-25210-1-git-send-email-kandoiruchi@google.com>
	 <3827847.Gih6ie3Ah6@vostro.rjw.lan>
	 <CAL8qYTNejOB8NJLsvV8nFisGyd9v8gR=nC9pKGDGc=nujo7SNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:59218 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755722AbaCLAYB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Mar 2014 20:24:01 -0400
In-Reply-To: <CAL8qYTNejOB8NJLsvV8nFisGyd9v8gR=nC9pKGDGc=nujo7SNw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ruchi Kandoi <kandoiruchi@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, ghackmann@google.com, john.stultz@linaro.org, Todd Poynor <toddpoynor@google.com>

On Tue, 2014-03-11 at 17:02 -0700, Ruchi Kandoi wrote:
> This API would be called from the platform specific code,
[]
> This is already in use on some Android devices. We are trying to make
> this a generic API which could be called by other platforms as well,
> standardizing the format in which the info is
> logged in dmesg and the format of the info exported to userspace for
> collecting power management statistics.


logging comments:

> >> diff --git a/kernel/power/wakeup_reason.c b/kernel/power/wakeup_reason.c
[]
> >> @@ -0,0 +1,140 @@

Please add the standard

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

before any #include

to prefix this with either "power: " or "wakeup_reason: "
(it depends on how the makefile was written, I don't see it)

> >> +#include <linux/wakeup_reason.h>
> >> +#include <linux/kernel.h>

[]

> >> +void log_wakeup_reason(int irq)
> >> +{
> >> +     struct irq_desc *desc;
> >> +     desc = irq_to_desc(irq);
> >> +     if (desc && desc->action && desc->action->name)
> >> +             printk(KERN_INFO "Resume caused by IRQ %d, %s\n", irq,
> >> +                             desc->action->name);
> >> +     else
> >> +             printk(KERN_INFO "Resume caused by IRQ %d\n", irq);

	if (desc && desc->action && desc->action->name)
		pr_info("Resume caused by IRQ %d, %s\n",
			irq, desc->action->name);
	else
		pr_info("Resume caused by IRQ %d\n", irq);

> >> +     if (irqcount == MAX_WAKEUP_REASON_IRQS) {
> >> +             spin_unlock(&resume_reason_lock);
> >> +             printk(KERN_WARNING "Resume caused by more than %d IRQs\n",
> >> +                             MAX_WAKEUP_REASON_IRQS);

		pr_warn("Resume caused by more than %d IRQs\n",
			MAX_WAKEUP_REASON_IRQS);

> >> +             return;
> >> +     }
> >> +
> >> +     irq_list[irqcount++] = irq;
> >> +     spin_unlock(&resume_reason_lock);
> >> +}

I'd probably write this with:

	if (irqcount >= MAX_REASON_IRQS) {

[]

> >> +int __init wakeup_reason_init(void)
> >> +{
> >> +     int retval;
> >> +     spin_lock_init(&resume_reason_lock);
> >> +     retval = register_pm_notifier(&wakeup_reason_pm_notifier_block);
> >> +     if (retval)
> >> +             printk(KERN_WARNING "[%s] failed to register PM notifier %d\n",
> >> +                             __func__, retval);

Kernel style generally uses function names emitted as "%s: ", __func__
not putting function name in brackets.  I suggest using that style:

		pr_warn("%s: failed to register PM notifier %d\n",
			__func__, retval);

> >> +
> >> +     wakeup_reason = kobject_create_and_add("wakeup_reasons", kernel_kobj);
> >> +     if (!wakeup_reason) {
> >> +             printk(KERN_WARNING "[%s] failed to create a sysfs kobject\n",
> >> +                             __func__);

		pr_warn("%s: failed to create a sysfs kobject\n", __func___);

> >> +             return 1;
> >> +     }
> >> +     retval = sysfs_create_group(wakeup_reason, &attr_group);
> >> +     if (retval) {
> >> +             kobject_put(wakeup_reason);
> >> +             printk(KERN_WARNING "[%s] failed to create a sysfs group %d\n",
> >> +                             __func__, retval);

		pr_warn("%s: failed to create a sysfs group %d\n",
			__func___, retval);


