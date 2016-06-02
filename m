From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH 5/5] intel_idle: Add S0ix validation
Date: Thu, 2 Jun 2016 13:35:45 -0700
Message-ID: <CAGAzgsrgH5-v2u8kfmxzGKzTqGV1nqp+Yo4E7y96yrretKTkXA@mail.gmail.com>
References: <1464842009-21789-1-git-send-email-dbasehore@chromium.org>
 <1464842009-21789-6-git-send-email-dbasehore@chromium.org>
 <20160602092505.GQ3206@twins.programming.kicks-ass.net> <20160602142318.2c9d2111@lxorguk.ukuu.org.uk>
 <CAGAzgspC49xNXPsV-WCT-xqVJGfNGeHkhYYLfZSTfBtjddVm8A@mail.gmail.com> <20160602205338.4a16760a@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:34581 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932565AbcFBUfr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 16:35:47 -0400
Received: by mail-vk0-f44.google.com with SMTP id c189so87716594vkb.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 13:35:47 -0700 (PDT)
In-Reply-To: <20160602205338.4a16760a@lxorguk.ukuu.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Jun 2, 2016 at 12:53 PM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
>> How would this spuriously trigger during boot? This code is only run
>> during freeze. If there's some issue with not entering S0ix before a
>> module or firmware is loaded, it's better to not use suspend to idle
>> until those are in place.
>
> Ok yes you are correct it's not likely to trigger during boot (although
> if you close the lid during boot...)
>
>> I'm not familiar with the ISH driver. How does it prevent entry into
>> S0ix? I would argue that you don't want to use suspend to idle on a
>> Skylake system that can't enter S0ix and instead use suspend to RAM.
>
> Several IP blocks on the systems do their own power management if present
> and enabled by the firmware. If they do not have drivers loaded then you
> will not be able to enter some power states. Thus you'll now get warnings
> if you try to freeze such a system and those warnings are not themselves
> terribly helpful to a user.

I would expect those IP blocks to do nothing and not block lower power
states if the firmware is not loaded. If that is not the case, I think
that should be fixed such that those lower power states are at least
available during suspend (if not during runtime). If your Skylake+
system is not entering S0ix during freeze, I consider that a bug that
needs to be addressed.

>
> It's a good debug feature, but it doesn't belong anywhere but debug menus
> and off by default. If you want to ship it enabled in ChromeOS for
> product fine, but I don't think it belongs on for everywhere and
> everything.

If other Linux distributions choose not to enable it in their kernel
configs, that's their decision. As I said, this does nothing in the
!CONFIG_INTEL_PMC_CORE case, but if a finer level config is warranted,
I can add that.

I would prefer if others used this more, since there would be better
debug coverage and I would have to fix fewer bugs.

>
> Alan
