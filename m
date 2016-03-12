From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [BUG] Device unbound in a resumed state
Date: Sat, 12 Mar 2016 14:25:04 +0900
Message-ID: <CAJKOXPcZNVds3Y12RLK-cQP77vqfsRV5pkTrq4A2cfHUuAH78g@mail.gmail.com>
References: <56E26EE9.8040400@samsung.com>
	<Pine.LNX.4.44L0.1603111336100.1840-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:33173 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbcCLFZF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 12 Mar 2016 00:25:05 -0500
In-Reply-To: <Pine.LNX.4.44L0.1603111336100.1840-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

2016-03-12 3:46 GMT+09:00 Alan Stern <stern@rowland.harvard.edu>:
> On Fri, 11 Mar 2016, Krzysztof Kozlowski wrote:
>
>> Hi,
>>
>>
>> Could be related (the same?) with [0].
>>
>> I have a driver (hwrng/exynos-rng) which in probe does:
>> pm_runtime_set_autosuspend_delay(&pdev->dev, EXYNOS_AUTOSUSPEND_DELAY);
>> pm_runtime_use_autosuspend(&pdev->dev);
>> pm_runtime_enable(&pdev->dev);
>>
>> and in remove:
>> pm_runtime_disable(&pdev->dev)
>
> But not pm_runtime_dont_use_autosuspend()?

Ahh, that one is missing. Thanks!

>
> Why disable runtime PM if you want the runtime-PM methods to put the
> device into a low-power state?

I don't want to play with runtime PM anymore at this time. I am
removing the device so I am cleaning what was done in probe. Without
the pm_runtime_disable() the next probe of device will trigger error
of unbalanced enable:
https://lkml.org/lkml/2016/3/11/59

>
>> Just before unbinding in __device_release_driver() the device is resumed
>> but unfortunately not suspended later. I mean the
>> __device_release_driver()->pm_runtime_put_sync() does not trigger
>> runtime suspend.
>
> Because autosuspend is still in use at this point.
>
>> This leads to leaving the device in active state (e.g. clocks enabled).
>>
>> It does not happen after removal of autosuspend. Also runtime suspend
>> happens after very fast unbind-bind.
>
> Overall it sounds like the system is behaving the way it is supposed
> to.
>
> But maybe we should make pm_runtime_use_autosuspend() call
> pm_runtime_mark_last_busy(), to avoid the unbind - bind - immediate
> autosuspend behavior.

The need of disabling autosuspend was not quite obvious to me and I
did not find information about it in documentation. However now it
makes sense... I'll send a patch updating the docs.

Thank you for feedback!

Best regards,
Krzysztof
