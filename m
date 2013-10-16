From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RESEND] cpuidle for ARM pull request
Date: Wed, 16 Oct 2013 23:01:04 +0200
Message-ID: <4820597.aXYQsJePoA@vostro.rjw.lan>
References: <51E536C5.1020609@linaro.org> <2224191.VjCA0rsPcU@vostro.rjw.lan> <525EC04C.8020507@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:51412 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755718Ab3JPUtS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Oct 2013 16:49:18 -0400
In-Reply-To: <525EC04C.8020507@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, keun-o.park@windriver.com, "nsekhar@ti.com >> Sekhar Nori" <nsekhar@ti.com>

On Wednesday, October 16, 2013 06:35:24 PM Daniel Lezcano wrote:
> On 07/27/2013 02:37 PM, Rafael J. Wysocki wrote:
> > On Saturday, July 27, 2013 08:13:31 AM Daniel Lezcano wrote:
> >> On 07/26/2013 02:07 AM, Rafael J. Wysocki wrote:
> >>> On Friday, July 26, 2013 12:41:09 AM Rafael J. Wysocki wrote:
> >>>> On Friday, July 26, 2013 12:29:08 AM Rafael J. Wysocki wrote:
> >>>>> On Friday, July 26, 2013 12:07:03 AM Daniel Lezcano wrote:
> >>>>>> On 07/16/2013 02:04 PM, Daniel Lezcano wrote:
> >>>>>>>
> 
> [ ... ]
> 
> > Next time, can you please add a general description of what the patches do and
> > why they do that to the pull request?
> >
> >> I thought it would have been easier for us if I could based my PRs on
> >> top of your linux-next branch, so acting as a proxy for ARM patches. I
> >> am maintaining the clocksource drivers and I am basing my tree on top of
> >> tip/core.
> >>
> >> I guess you are rebasing your tree often and this is an issue for you,
> >> right ?
> >
> > Yes, my linux-next branch may contain commits that will be modified later
> > (e.g. ACKs added, fixes folded in etc.).
> >
> > Anyway, as I said, as long as the material you have for me doesn't depend on
> > anything new in my tree, it's better to base it on top of an -rc kernel.
> >
> > In case it does depend on that, I've put the entire outstanding cpuidle
> > material into my pm-cpuidle branch (including your ARM commits just pulled).
> 
> Hi Rafael,
> 
> is it possible to update the pm-cpuidle branch ? so I can base my pull 
> request on it. There will be a (trivial) conflict in the Makefile and 
> Kconfig.arm if I base my PR on v3.12-rc5.

Updated, but you can base it on 3.12-rc5 if you need to.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
