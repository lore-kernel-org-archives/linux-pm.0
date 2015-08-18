From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5] Report interrupt(s) that caused system wakeup
Date: Tue, 18 Aug 2015 17:53:54 +0200
Message-ID: <CAJZ5v0hAddOCHGR74kvj7XmcALwn275FQnAYMPt_0jgtvko+MQ@mail.gmail.com>
References: <1438919224-7003-2-git-send-email-alexandra.yates@linux.intel.com>
	<1996878.sZiHYD4sbd@vostro.rjw.lan>
	<alpine.DEB.2.11.1508172234040.3873@nanos>
	<2470788.QaFQb9rj3y@vostro.rjw.lan>
	<alpine.DEB.2.11.1508181454230.3873@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35998 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbbHRPxz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2015 11:53:55 -0400
In-Reply-To: <alpine.DEB.2.11.1508181454230.3873@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandra Yates <alexandra.yates@linux.intel.com>, Kristen C Accardi <kristen.c.accardi@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Aug 18, 2015 at 2:56 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 18 Aug 2015, Rafael J. Wysocki wrote:
>> The original point was that if two wakeup interrupts happened at the same time,
>> it would be kind of moot which one was the "real" wakeup, but now that I think
>> about it, reporting the first one should be enough to catch suprious wakeups
>> anyway.
>
> So we can simply do the following:
>
> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index d22786a6dbde..46068a1e0e07 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -21,7 +21,7 @@ bool irq_pm_check_wakeup(struct irq_desc *desc)
>                 desc->istate |= IRQS_SUSPENDED | IRQS_PENDING;
>                 desc->depth++;
>                 irq_disable(desc);
> -               pm_system_wakeup();
> +               pm_system_irq_wakeup(irq_desc_get_irq(desc));
>                 return true;
>         }
>         return false;
>
> and manage the storage in the PM code.

Right.

That's exactly the approach we're going to follow. :-)

Thanks,
Rafael
