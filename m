From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Restore lock-less behaviour for the genpd
 syscore APIs
Date: Wed, 8 Feb 2017 13:41:25 +0100
Message-ID: <CAPDyKFpvmp9TY6xyU_jS66zv-gSwuq3VBGkNFdQA9Obd4AWrCw@mail.gmail.com>
References: <1486482784-31734-1-git-send-email-ulf.hansson@linaro.org> <20170207215229.GA2564@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:36674 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932116AbdBHMl1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Feb 2017 07:41:27 -0500
Received: by mail-ua0-f180.google.com with SMTP id 96so108132966uaq.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Feb 2017 04:41:26 -0800 (PST)
In-Reply-To: <20170207215229.GA2564@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Brian Norris <briannorris@chromium.org>

Hi Lina,

--
>> drivers/base/power/domain.c | 48
>> +++++++++++++++++++++++++--------------------
>> 1 file changed, 27 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 271e208..3a75fb1 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -729,16 +729,17 @@ static bool genpd_dev_active_wakeup(struct
>> generic_pm_domain *genpd,
>> /**
>>  * genpd_sync_power_off - Synchronously power off a PM domain and its
>> masters.
>>  * @genpd: PM domain to power off, if possible.
>> + * @use_lock: use the lock.
>
>
> I am not too fond of this. It would rather be much cleaner if you could
> overload the genpd_lock/unlock() calls to make this genpd lockless. A
> flag for the genpd, perhaps that could turn the lock functions into a
> NOP?

That's not going to work, because this isn't about a lock-less genpd.

The problem occurs only during system suspend for a syscore device (in
this case the sh_cmt_clock_event device), calling pm_genpd_syscore*
APIs.

Kind regards
Uffe
