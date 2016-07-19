From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [query] sleep introduced by invoking kernel API during runtime_resume
Date: Tue, 19 Jul 2016 15:03:58 +0200
Message-ID: <4430171.SeORUQ46bP@vostro.rjw.lan>
References: <CAN2waFsgenQK50_+akz25X0DgVdz6w-zok59hwmE3hLoODZw3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56093 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752995AbcGSM7G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jul 2016 08:59:06 -0400
In-Reply-To: <CAN2waFsgenQK50_+akz25X0DgVdz6w-zok59hwmE3hLoODZw3Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: linux-pm@vger.kernel.org

On Tuesday, July 19, 2016 03:03:03 PM Zhaoyang Huang wrote:
> Dear folks,
> We run across a warning as 'BUG: sleeping function called from invalid
> context at' during rpm resume one device[1]. However, the
> device(kbase_device_resume) is unaware of sleeping which introduced by
> invoking kernel function. I would like to ask that how to avoid such
> kind of warning? It seems that 'RPM_ASYNC' also can not handle, for
> there is spin_lock_irq at beginning of pm_runtime_work.
> 
> 
> [1]
> __pm_runtime_resume
> {
>       spin_lock_irqsave(&dev->power.lock, flags);      ---> irqs_disabled
> 
>       kbase_device_resume->
> --->rpm_resume function for device

No, we don't call resume callbacks under dev->power.lock unless the
power.irq_safe flage is set for the device.

>                  devfreq_resume_device->
>                       devfreq_simple_ondemand_handler->
>                              devfreq_monitor_resume----->
>                                     {
>                                        mutex_lock(&devfreq->lock)
>     ----> check might_sleep here
>                                         ......
>                                        mutex_unlock(&devfreq->lock)
>                                     }
> }

Thanks,
Rafael

