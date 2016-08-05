From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / Domains: Replace -ENOSYS with -ENODEV
Date: Sat, 6 Aug 2016 00:17:58 +0200
Message-ID: <CAJZ5v0hXNDRCztvDDii+qKEDz26W16e=eq9yDB+59G-AVrKhMw@mail.gmail.com>
References: <1470416816-53336-1-git-send-email-lina.iyer@linaro.org> <20160805194329.GA5020@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35654 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbcHFUZd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 6 Aug 2016 16:25:33 -0400
Received: by mail-wm0-f52.google.com with SMTP id f65so67903225wmi.0
        for <linux-pm@vger.kernel.org>; Sat, 06 Aug 2016 13:25:33 -0700 (PDT)
In-Reply-To: <20160805194329.GA5020@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Fri, Aug 5, 2016 at 9:43 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Fri, Aug 05, 2016 at 11:06:56AM -0600, Lina Iyer wrote:
>> ENOSYS is for syscalls that are not supported. ENODEV is a better return
>> value when the PM Domains are not available.
>>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>
> I have no opinion on this, but would like to point out that other parts
> in the PM core use -ENOSYS as well (e.g. see drivers/base/power/core.c).
> For consistency, if pm_domain.h is changed, the rest should probably be
> changed as well.

I agree here.  Changing one piece only is likely to result in confusion.

Also I'm not sure if ENODEV is a good replacement at all.  ENOTSUPP
was suggested instead last time a similar patch was discussed.

> It should also be kept in mind that functions might
> check the return code and react specifically to the currently used -ENOSYS.
> (I've written code like that just yesterday, for the (unmerged) thunderbolt
> runtime pm.)

But I wouldn't write code doing something like this.

Thanks,
Rafael
