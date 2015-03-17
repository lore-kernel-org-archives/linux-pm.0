From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [GIT PULL] cpuidle: 4.0-rc3 fixes
Date: Tue, 17 Mar 2015 07:53:50 +0100
Message-ID: <CAMuHMdUiwGqrFSPATcBHYji_AYhh84GZYKXPbZoQNw=Q2M4vYg@mail.gmail.com>
References: <55032186.3000306@linaro.org>
	<2429393.iDkfxR0R07@vostro.rjw.lan>
	<CAMuHMdWtu3f9S0aXGGdnoO4JSu+9FN1zvEO6goWGSo3wEbQXrQ@mail.gmail.com>
	<1477703.PhCcfT3r53@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36094 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbbCQGxv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2015 02:53:51 -0400
In-Reply-To: <1477703.PhCcfT3r53@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Sebastien Rannou <mxs@sbrk.org>, Gregory Clement <gregory.clement@free-electrons.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Rafael,

On Tue, Mar 17, 2015 at 3:37 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > Pulled, but this is a bit too late for 4.0-rc4, so I'll queue it up for -rc5.
>>
>> Please note commit 43b68879de27b199 ("cpuidle: mvebu: Fix the CPU PM
>> notifier usage") has a "Cc: stable@vger.kernel.org" tag.
>
> Yes, it does, and that's why I've queued it up for 4.0-rc5 and not for 4.1.
>
> Does it require any extra care or something?

Nevermind, I replied too soon after reading "too late for 4.0...".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
