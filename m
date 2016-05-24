From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 4/4] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Tue, 24 May 2016 11:34:54 -0700
Message-ID: <m2twhngv8x.fsf@baylibre.com>
References: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org>
	<1463485296-22742-5-git-send-email-ulf.hansson@linaro.org>
	<m2iny4icxw.fsf@baylibre.com>
	<CAPDyKFpEe-muf9i+SZ0-yJADsXzRroyzducfMzDRb16_hJ1x6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36073 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957AbcEXSe6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2016 14:34:58 -0400
Received: by mail-pf0-f175.google.com with SMTP id c189so9462901pfb.3
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2016 11:34:58 -0700 (PDT)
In-Reply-To: <CAPDyKFpEe-muf9i+SZ0-yJADsXzRroyzducfMzDRb16_hJ1x6A@mail.gmail.com>
	(Ulf Hansson's message of "Tue, 24 May 2016 08:51:27 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 24 May 2016 at 01:15, Kevin Hilman <khilman@baylibre.com> wrote:
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>
>>> When the pm_runtime_force_suspend|resume() helpers were invented, we still
>>> had CONFIG_PM_RUNTIME and CONFIG_PM_SLEEP as separate Kconfig options.
>>>
>>> To make sure these helpers worked for all combinations and without
>>> introducing too much of complexity, the device was always resumed in
>>> pm_runtime_force_resume().
>>>
>>> More precisely, when CONFIG_PM_SLEEP was set and CONFIG_PM_RUNTIME was
>>> unset, we needed to resume the device as the subsystem/driver couldn't
>>> rely on using runtime PM to do it.
>>>
>>> As the CONFIG_PM_RUNTIME option was merged into CONFIG_PM a while ago, it
>>> removed this combination, of using CONFIG_PM_SLEEP without the earlier
>>> CONFIG_PM_RUNTIME.
>>>
>>> For this reason we can now rely on the subsystem/driver to use runtime PM
>>> to resume the device, instead of forcing that to be done in all cases. In
>>> other words, let's defer this to a later point when it's actually needed.
>>
>> s/this/the runtime resume/
>>
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/base/power/runtime.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>>> index 09e4eb1..1db7b46 100644
>>> --- a/drivers/base/power/runtime.c
>>> +++ b/drivers/base/power/runtime.c
>>> @@ -1509,6 +1509,17 @@ int pm_runtime_force_resume(struct device *dev)
>>>       if (!pm_runtime_status_suspended(dev))
>>>               goto out;
>>>
>>> +     /*
>>> +      * The PM core increases the runtime PM usage count in the system PM
>>> +      * prepare phase. If the count is greather than 1 at this point, someone
>>
>> s/greather/greater/
>>
>>> +      * else has also increased it. In that case, invoke the runtime resume
>>> +      * callback for the device as that is likely what is expected. In other
>>
>> Instead of "someone else..."
>>
>> ...a real user (such as a driver or subsystem) has also increased it,
>> indicating that the device was active (RPM_ACTIVE) when system suspend
>> was invoked.  Since the device was active on suspend, it's expected to
>> be used on resume as well, so invoke runtime resume for that device
>> ensuring that it is RPM_ACTIVE during system resume.
>
> "someone else" also takes user space, child devices, etc into account.
> There are just quite many cases when the usage count could be
> increased and I didn't want to be too specific about them.
>
> Although, if you insists that this improves the understanding, I will
> update the comment.

How about: a real user (such as a subsystem, driver, userspace, etc.)

Kevin
