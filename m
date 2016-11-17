From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Thu, 17 Nov 2016 22:00:20 +0100
Message-ID: <CAJZ5v0iGWTk0bvg6OmQiMTi_EftqxU0q17ERj+GcaL_QQ-0Agg@mail.gmail.com>
References: <1476370734-23168-1-git-send-email-ulf.hansson@linaro.org> <CAPDyKFp5Ay1dN2UQauD7vHxPQP+kghviAAduhpHO7QAmH-1UiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33608 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbcKQVAW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Nov 2016 16:00:22 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so24956555wmu.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Nov 2016 13:00:21 -0800 (PST)
In-Reply-To: <CAPDyKFp5Ay1dN2UQauD7vHxPQP+kghviAAduhpHO7QAmH-1UiA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Walleij <linus.walleij@linaro.org>

On Thu, Nov 17, 2016 at 9:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 13 October 2016 at 16:58, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> When the pm_runtime_force_suspend|resume() helpers were invented, we still
>> had CONFIG_PM_RUNTIME and CONFIG_PM_SLEEP as separate Kconfig options.
>>
>> To make sure these helpers worked for all combinations and without
>> introducing too much of complexity, the device was always resumed in
>> pm_runtime_force_resume().
>>
>> More precisely, when CONFIG_PM_SLEEP was set and CONFIG_PM_RUNTIME was
>> unset, we needed to resume the device as the subsystem/driver couldn't
>> rely on using runtime PM to do it.
>>
>> As the CONFIG_PM_RUNTIME option was merged into CONFIG_PM a while ago, it
>> removed this combination, of using CONFIG_PM_SLEEP without the earlier
>> CONFIG_PM_RUNTIME.
>>
>> For this reason we can now rely on the subsystem/driver to use runtime PM
>> to resume the device, instead of forcing that to be done in all cases. In
>> other words, let's defer the runtime resume to a later point when it's
>> actually needed.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Rafael, this one is ready to be queued. Unless there are other objections.

Not an objection, but I'd like to revisit this when the device
dependencies work gets in, as something similar may need to be done
for suppliers, in principle.

Thanks,
Rafael
