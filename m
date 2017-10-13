From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Understanding the use cases for calling pm_wakeup_event()
Date: Fri, 13 Oct 2017 02:28:38 +0200
Message-ID: <CAJZ5v0j73KkxXjpmqRfmZ-TST9rip8_-zq-XQftcmF90HGO46g@mail.gmail.com>
References: <CACK8Z6E2t-xF=jpyqAB5CJe2D_HUzSf2quBjxQy5_SVMgqnJNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:52685 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbdJMA2j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2017 20:28:39 -0400
Received: by mail-oi0-f43.google.com with SMTP id c202so11128259oih.9
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2017 17:28:39 -0700 (PDT)
In-Reply-To: <CACK8Z6E2t-xF=jpyqAB5CJe2D_HUzSf2quBjxQy5_SVMgqnJNg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajat Jain <rajatja@google.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Dmitry Torokhov <dtor@google.com>

On Fri, Oct 13, 2017 at 2:13 AM, Rajat Jain <rajatja@google.com> wrote:
> Hi,
>
> I'm trying to understand when a driver is supposed to call the
> pm_wakeup_event(). It appears that the purpose of this call is to
>
> (1) In the suspend path, halt the suspend if the driver believes it
> just got an appropriate wake event from the device while the system is
> trying to suspend.
>
> (2) If driver detects the event in the resume path, identify the
> device as (one of the) wake sources that fired.
>
> I understand good use cases of this call will be when a driver knows
> that its device has woken up the system, e.g:
>
> * When a driver handles dedicated "wakeup irq", and sees the interrupt fired.
> * If a driver detect operator events such as lid opened, power button
> pressed, switched to tablet mode etc etc.

The above is correct.

> But what should a driver do, when it handles an event (in the resume
> path) that potentially was a wake up source but the driver is not
> sure?

Examples?

> Is it appropriate to call
>
>        if (device_may_wakeup(dev))
>                 pm_wakeup_event(dev, 0);
>
> in that case, because I do see some drivers seem to call it when they
> think that their device *may* have been the reason the system woke up,
> but not necessarily *is* the reason for wake up. E.g.:
>
> drivers/input/mouse/cyapa.c:
> drivers/input/serio/hyperv-keyboard.c
> drivers/input/serio/olpc_apsp.c

Anyway, if that happens in the resume path there are no consequences
of that for the kernel.

However, if user space looks at wakeup sources in order to figure out
what event woke the system up from sleep, it may be confused by that.
Are you aware of any user space stacks doing this?

Thanks,
Rafael
