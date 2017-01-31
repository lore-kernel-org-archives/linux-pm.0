From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Correct comment in irq_safe_dev_in_no_sleep_domain()
Date: Tue, 31 Jan 2017 17:41:40 +0100
Message-ID: <CAPDyKFrUqDdFrHCLnEEOq5N9QCnoG_9eP_BD4yb9ccweyBLMog@mail.gmail.com>
References: <1485878463-1672-1-git-send-email-ulf.hansson@linaro.org> <CAMuHMdXRvOTKCdvwy5JZM6RhSifse_goHubZq4FaMcOFE7x99g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35292 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbdAaQlm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2017 11:41:42 -0500
Received: by mail-wm0-f53.google.com with SMTP id b65so86823040wmf.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2017 08:41:41 -0800 (PST)
In-Reply-To: <CAMuHMdXRvOTKCdvwy5JZM6RhSifse_goHubZq4FaMcOFE7x99g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>

On 31 January 2017 at 17:17, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Tue, Jan 31, 2017 at 5:01 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> The earlier comment stated that the dev_warn_once() was going to be printed
>> once per device. Let's fix that, as dev_warn_once() is printed only once,
>> no matter of the device.
>
> While I agree this makes the comment match the code, I think we would serve
> the users better by printing the warning once per PM domain.
> Currently the user cannot know if two or more PM domains cannot be powered
> off due to IRQ safe devices.

Right.

>
> Perhaps a flag can be added to generic_pm_domain.flags to remember
> that the warning has been printed before?

That seems like a reasonable adjustment. Allow me to cook a patch on
top of this one.

Moreover, I was thinking of considering to check for always on domains
and perhaps skip printing this message in such cases. Would that make
sense as well?

Kind regards
Uffe

>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 6b23d82..271e208 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -130,7 +130,7 @@ static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
>>
>>         ret = pm_runtime_is_irq_safe(dev) && !genpd_is_irq_safe(genpd);
>>
>> -       /* Warn once for each IRQ safe dev in no sleep domain */
>> +       /* Warn once if IRQ safe dev in no sleep domain */
>>         if (ret)
>>                 dev_warn_once(dev, "PM domain %s will not be powered off\n",
>>                                 genpd->name);
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
