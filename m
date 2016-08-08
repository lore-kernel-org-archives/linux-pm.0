From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / Domains: Replace -ENOSYS with -ENODEV
Date: Mon, 8 Aug 2016 11:11:11 +0200
Message-ID: <CAMuHMdWKKEt2qq1pMt8YBtgq4DuSV6BJhAemVdNv34p8A44Z9Q@mail.gmail.com>
References: <1470416816-53336-1-git-send-email-lina.iyer@linaro.org>
 <20160805194329.GA5020@wunner.de> <CAJZ5v0hXNDRCztvDDii+qKEDz26W16e=eq9yDB+59G-AVrKhMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33019 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbcHHJLM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Aug 2016 05:11:12 -0400
Received: by mail-io0-f193.google.com with SMTP id y195so28346868iod.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Aug 2016 02:11:12 -0700 (PDT)
In-Reply-To: <CAJZ5v0hXNDRCztvDDii+qKEDz26W16e=eq9yDB+59G-AVrKhMw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

Hi Rafael,

On Sat, Aug 6, 2016 at 12:17 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Aug 5, 2016 at 9:43 PM, Lukas Wunner <lukas@wunner.de> wrote:
>> On Fri, Aug 05, 2016 at 11:06:56AM -0600, Lina Iyer wrote:
>>> ENOSYS is for syscalls that are not supported. ENODEV is a better return
>>> value when the PM Domains are not available.
>>>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>
>> I have no opinion on this, but would like to point out that other parts
>> in the PM core use -ENOSYS as well (e.g. see drivers/base/power/core.c).
>> For consistency, if pm_domain.h is changed, the rest should probably be
>> changed as well.

ENOSYS has been used to indicate "functionality not supported" all over the
place...

> I agree here.  Changing one piece only is likely to result in confusion.
>
> Also I'm not sure if ENODEV is a good replacement at all.  ENOTSUPP
> was suggested instead last time a similar patch was discussed.
>
>> It should also be kept in mind that functions might
>> check the return code and react specifically to the currently used -ENOSYS.
>> (I've written code like that just yesterday, for the (unmerged) thunderbolt
>> runtime pm.)
>
> But I wouldn't write code doing something like this.

(in the general case, not limited to PM) What to do instead, if you know a
dummy function returns -ENOSYS and you need to react on that?

In these cases the exact error code is a contract between caller and
callee.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
