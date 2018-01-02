From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/4] PM / Domains: Take WAKEUP_PATH driver flag into
 account in genpd
Date: Tue, 2 Jan 2018 12:52:31 +0100
Message-ID: <CAJZ5v0jqOKKWzUAF36X5y+ncSYZcuy3ZO2Zj9ufU4votRpcS9Q@mail.gmail.com>
References: <1514547423-18965-1-git-send-email-ulf.hansson@linaro.org>
 <1514547423-18965-4-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0hoakc1_CwFXu5EE8SU8NstVv2aod+qpb4w4gjHE81X4A@mail.gmail.com> <CAPDyKFqJfWy3jaC6jY9bj3e261ONufe7EkSYFWChWVeXvKQjyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36732 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbeABLwc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 06:52:32 -0500
In-Reply-To: <CAPDyKFqJfWy3jaC6jY9bj3e261ONufe7EkSYFWChWVeXvKQjyg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Tue, Jan 2, 2018 at 12:46 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 30 December 2017 at 01:47, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Fri, Dec 29, 2017 at 12:37 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> In case the WAKEUP_PATH flag has been set in a later phase than from the
>>> ->suspend() callback, the PM core don't set the ->power.wakeup_path status
>>> flag for the device. Therefore, let's be safe and check it explicitly.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/base/power/domain.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>> index f9dcc98..32b4ba7 100644
>>> --- a/drivers/base/power/domain.c
>>> +++ b/drivers/base/power/domain.c
>>> @@ -1038,7 +1038,9 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
>>>         if (IS_ERR(genpd))
>>>                 return -EINVAL;
>>>
>>> -       if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
>>> +       if ((dev->power.wakeup_path ||
>>> +           dev_pm_test_driver_flags(dev, DPM_FLAG_WAKEUP_PATH)) &&
>>
>> Shouldn't dev->power.wakeup_path be always set if DPM_FLAG_WAKEUP_PATH
>> is set as per the second patch in the series?
>
> Not if DPM_FLAG_WAKEUP_PATH is set from a driver's ->suspend_late() callback.
>
> To do that, the PM core would need to be adopted to set/propagate the
> "wakeup_path" flag at __device_suspend_late(), similar to what is done
> at __device_suspend().

Why not?

The wakeup_path flag is only used during the "noirq" phase, so it can
be propagated to parent at the end of __device_suspend_late() instead
of doing that in __device_suspend() even.

Thanks,
Rafael
