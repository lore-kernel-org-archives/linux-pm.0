From: Rajat Jain <rajatja@google.com>
Subject: Understanding the use cases for calling pm_wakeup_event()
Date: Thu, 12 Oct 2017 17:13:58 -0700
Message-ID: <CACK8Z6E2t-xF=jpyqAB5CJe2D_HUzSf2quBjxQy5_SVMgqnJNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:47377 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753274AbdJMAOk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2017 20:14:40 -0400
Received: by mail-qt0-f177.google.com with SMTP id z50so16765929qtj.4
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2017 17:14:40 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Dmitry Torokhov <dtor@google.com>

Hi,

I'm trying to understand when a driver is supposed to call the
pm_wakeup_event(). It appears that the purpose of this call is to

(1) In the suspend patch, halt the suspend if the driver believes it
just got an appropriate wake event from the device while the system is
trying to suspend.

(2) If driver detects the event in the resume path, identify the
device as (one of the) wake sources that fired.

I understand good use cases of this call will be when a driver knows
that its device has woken up the system, e.g:

* When a driver handles dedicated "wakeup irq", and sees the interrupt fired.
* If a driver detect operator events such as lid opened, power button
pressed, switched to tablet mode etc etc.

But what should a driver do, when it handles an event (in the resume
path) that potentially was a wake up source but the driver is not
sure? Is it appropriate to call

       if (device_may_wakeup(dev))
                pm_wakeup_event(dev, 0);

in that case, because I do see some drivers seem to call it when they
think that their device *may* have been the reason the system woke up,
but not necessarily *is* the reason for wake up. E.g.:

drivers/input/mouse/cyapa.c:
drivers/input/serio/hyperv-keyboard.c
drivers/input/serio/olpc_apsp.c

Thanks,

Rajat
