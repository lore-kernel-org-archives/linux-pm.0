From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFD] Devices that need full power for wakeup
Date: Thu, 11 Jan 2018 08:48:44 +0100
Message-ID: <CAMuHMdUUmBOnkvVo91+5ON=_jQ9D8ViFpcoq5ideY=_fhRGXSA@mail.gmail.com>
References: <CAJZ5v0jf_CVsZOQj4ZzgU59Z9ketb_aNu0UdgMmgXyJwRc37Yg@mail.gmail.com>
 <CAPDyKFqZ+ja5bu+G7ynTowq1CFQ2_k2zdA7qGbj3VagdB0yT4Q@mail.gmail.com>
 <CAJZ5v0hw_z5qGiGFGtJHLMfduEsH5c9y8q7ZFNCZdjwppP=GbA@mail.gmail.com>
 <CAPDyKFpwVevhg7F==GdxDwDhbuTy5hPn6zMbq4WpqkBiDKbM+g@mail.gmail.com> <CAJZ5v0hpOe6cQbuLEaYx8=JVrD79276J8VO0YNveWoNc5TU0tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:38289 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbeAKHsp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jan 2018 02:48:45 -0500
Received: by mail-qt0-f178.google.com with SMTP id d4so756848qtj.5
        for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2018 23:48:45 -0800 (PST)
In-Reply-To: <CAJZ5v0hpOe6cQbuLEaYx8=JVrD79276J8VO0YNveWoNc5TU0tg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>

Hi Rafael,

On Thu, Jan 11, 2018 at 1:08 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Jan 10, 2018 at 11:21 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 10 January 2018 at 02:22, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Mon, Jan 8, 2018 at 5:33 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> On 8 January 2018 at 12:51, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> [cut]
>
>>>
>>>> This is also what Geert convinced to be the best, from earlier discussions.
>>>
>>> I'm not sure about that.  Geert seems to need power to stay on,
>>> nothing more, and that regardless of genpd_is_active_wakeup() AFAICS.
>>
>> That was the initial problem, which is taken care of by using the
>> ->dev.power.wakeup_path flag and the new helper,
>> device_set_wakeup_path().
>>
>> This in combination of enabling genpd to deal with wakeups, as that is
>> currently not the default setting, which is done via setting the
>> GENPD_FLAG_ACTIVE_WAKEUP configuration flag.
>
> But that really isn't about wakeup, but rather about whether or not
> power can be cut off things, right?

The flag indicates that power cannot be cut if the device is used for wake-up.

>> The next part of the problems Geert pointed out was exactly those I am
>> describing here. Please have a look at his reply at:
>> https://www.mail-archive.com/linux-renesas-soc@vger.kernel.org/msg21157.html
>
> OK
>
>>>
>>>> However, there are a few related issues around system wakeups in
>>>> genpd, during system suspend.
>>>>
>>>> 1)
>>>> If the driver for the device, configures system wakeup as an
>>>> "out-band-wakeup", the device and its PM domain, don't need to stay
>>>> powered on during system suspend from the driver perspective.
>>>
>>> That depends.
>>>
>>> The wakeup signal has to be generated or asserted by something,
>>> presumably the device itself.
>>
>> The cases I looking at don't require the device to be powered - at
>> least from the driver's perspective.
>>
>> A classic example is a SD card detect pin, which is being routed to a
>> GPIO pin. In these case, that GPIO pin has no logic whatsoever,
>> coupled with the device for SD controller. Still, it needs to be
>> manged by the same device driver.
>
> So technically it is a different device, but since it is functionally
> related to the one originally handled by the driver in question, the
> driver is expected to handle this wakeup thing too.
>
> Fair enough, but certainly that is not a common setup for other subsystems.
>
> [BTW, since the wakeup thing is a separate device technically, I would
> try to model it as a separate device object in the kernel with its own
> wakeup settings.  That would save you some complications you're trying
> to deal with IMO.]

Makes sense to me.

> Also I'm sort of wondering why the problem is specific to system-wide
> suspend.  It looks like if the card slot was empty, it would make
> perfect sense to put the "master" device into runtime suspend with no
> remote wakeup and then only resume it if the GPIO thing signaled card
> insertion.  And this looks like the same problem in disguise.

For SD card slots, it's indeed not just about system suspend, but also
about runtime suspend when no card is present.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
