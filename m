From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH 5/5] intel_idle: Add S0ix validation
Date: Thu, 2 Jun 2016 11:55:25 -0700
Message-ID: <CAGAzgspC49xNXPsV-WCT-xqVJGfNGeHkhYYLfZSTfBtjddVm8A@mail.gmail.com>
References: <1464842009-21789-1-git-send-email-dbasehore@chromium.org>
 <1464842009-21789-6-git-send-email-dbasehore@chromium.org>
 <20160602092505.GQ3206@twins.programming.kicks-ass.net> <20160602142318.2c9d2111@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34155 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933053AbcFBSz1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 14:55:27 -0400
Received: by mail-vk0-f53.google.com with SMTP id c189so84015833vkb.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 11:55:26 -0700 (PDT)
In-Reply-To: <20160602142318.2c9d2111@lxorguk.ukuu.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Jun 2, 2016 at 6:23 AM, One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:
>
> There are plenty of Skylake configurations where at the moment you won't
> get s0ix entry because the ISH driver is not yet merged. Spamming those
> users with useless messages is not helpful. Likewise on systems with
> modular kernels your warning may spuriously trigger during boot until the
> ISH, i915 and audio modules and firmware have loaded and are active. I
> know Chrome doesn't like modules but the rest of us do !

How would this spuriously trigger during boot? This code is only run
during freeze. If there's some issue with not entering S0ix before a
module or firmware is loaded, it's better to not use suspend to idle
until those are in place.

I'm not familiar with the ISH driver. How does it prevent entry into
S0ix? I would argue that you don't want to use suspend to idle on a
Skylake system that can't enter S0ix and instead use suspend to RAM.

>
> I'm also a bit at a loss to understand why anyone needs this except
> validation engineers for Chrome products and kernel hackers doing
> debug. It seems a bit odd to burden the entire world with a pile of
> checks they can't use that cost even 0.3% of power (that's 15 minutes on
> an 8 hour battery multiplied by every Skylake user!).
>
> Having to have debugfs present to turn it off, but not to use it is also
> a bit weird...
>
> IMHO this should be one of the hacking/kernel debug options and not even
> compiled into normal kernels.
>
> Alan
