From: AYAN KUMAR HALDER <ayankumarh@gmail.com>
Subject: Re: External devices
Date: Fri, 5 Sep 2014 16:33:59 +0530
Message-ID: <CAGAs2AkR5+Lgw75RzBR6u-LWHc0F3WGTaaxkhCLWyDBBoQrgJQ@mail.gmail.com>
References: <CAJ2oMhKRA+0Ge_m=-zFqgTxcZbuGMNAOvBQKP=_GyWRwvfsKFw@mail.gmail.com>
	<CAGAs2Amw1jvmDxL8+uXU4XW3u6Mxr7LKP4EiP8taTNQ2OpnWNw@mail.gmail.com>
	<CAJ2oMhL=wuWA3Ga4bdeqvW0QA-cccLA0BfVRDKyLuykyChqu7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35405 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344AbaIELEB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Sep 2014 07:04:01 -0400
Received: by mail-ig0-f173.google.com with SMTP id h18so861823igc.6
        for <linux-pm@vger.kernel.org>; Fri, 05 Sep 2014 04:04:00 -0700 (PDT)
In-Reply-To: <CAJ2oMhL=wuWA3Ga4bdeqvW0QA-cccLA0BfVRDKyLuykyChqu7w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-pm@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>

Hi Ran,

Please find my replies as follows:-

> How does the driver invokes moving to idle state ?

The driver uses numerous apis to send its device to idle state. Some
of them are as follows:-
1. pm_runtime_put/pm_runtime_put_sync - which decreases the usage
count and ultimately calls pm_runtime_idle.
2. pm_runtime_idle - which calls the corresponding
driver->runtime_idle after checking the usage count
3. pm_request_idle - calls pm_runtime_idle

Is it the same as
> invoking runtime suspend by the driver ?

In some cases, eg In platform subsystem drivers , runtime_suspend gets
called from runtime_idle. eg Refer drivers/base/platform.c, the
runtime operations assigned are :-
static const struct dev_pm_ops platform_dev_pm_ops = {
        .runtime_suspend = pm_generic_runtime_suspend,
        .runtime_resume = pm_generic_runtime_resume,
        .runtime_idle = pm_generic_runtime_idle,
        USE_PLATFORM_PM_SLEEP_OPS
};
Here pm_generic_runtime_idle() after calling the driver specific
runtime_idle api, calls pm_runtime_suspend -->
pm_generic_runtime_suspend  ---> driver specific runtime suspend call.

> What is the difference between idle state to runtime suspend ?

I don't clearly understand the difference between idle state and
runtime suspend as in case of most devices (eg platform devices, usb
devices)
, I see that runtime_idle eventually calls runtime_suspend. eg
drivers/usb/core/usb.c , usb_runtime_idle() -----> pm_runtime_autosuspend()

> Are you familiar with any character device example for using PM ?

Check drivers/usb/core/usb.c.

Regards,
Ayan Kumar Halder
