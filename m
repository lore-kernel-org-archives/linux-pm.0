From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RESEND] cpuidle for ARM pull request
Date: Sat, 27 Jul 2013 14:37:59 +0200
Message-ID: <2224191.VjCA0rsPcU@vostro.rjw.lan>
References: <51E536C5.1020609@linaro.org> <1598661.FpX5cmjM1U@vostro.rjw.lan> <51F3650B.8080708@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43262 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab3G0M1y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 27 Jul 2013 08:27:54 -0400
In-Reply-To: <51F3650B.8080708@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, keun-o.park@windriver.com, "nsekhar@ti.com >> Sekhar Nori" <nsekhar@ti.com>

On Saturday, July 27, 2013 08:13:31 AM Daniel Lezcano wrote:
> On 07/26/2013 02:07 AM, Rafael J. Wysocki wrote:
> > On Friday, July 26, 2013 12:41:09 AM Rafael J. Wysocki wrote:
> >> On Friday, July 26, 2013 12:29:08 AM Rafael J. Wysocki wrote:
> >>> On Friday, July 26, 2013 12:07:03 AM Daniel Lezcano wrote:
> >>>> On 07/16/2013 02:04 PM, Daniel Lezcano wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> The first PR was against the linux-pm-next tree including the patch:
> >>>>>
> >>>>> "cpuidle: Add Kconfig.arm and move calxeda, kirkwood and zynq"
> >>>>>
> >>>>> This patch has been dropped in the meantime.
> >>>>>
> >>>>> Here is a new PR where my tree has been rebased against linux-pm-next
> >>>>> and adding the patch mentioned above.
> >>>>>
> >>>>> As stated by Rafael, I will handle the ARM specific patches from now.
> >>>>>
> >>>>> The following changes since commit 48f99d5a97d32d70c0738d6e314d9f4dbefd89bf:
> >>>>>
> >>>>>   Merge branch 'pm-cpuidle-next' into linux-next (2013-07-16 02:41:06 +0200)
> >>>>>
> >>>>> are available in the git repository at:
> >>>>>
> >>>>>
> >>>>>   git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next
> >>>>>
> >>>>> for you to fetch changes up to 2b7e79f4a75e803184f483985a25cc751a990f06:
> >>>>>
> >>>>>   ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle
> >>>>> (2013-07-16 13:57:24 +0200)
> >>>>
> >>>> ping ?
> >>>
> >>> Sorry, something distracted me.  I'll pull it later today unless there are any
> >>> problems (in which case I'll let you know).
> >>
> >> Well, there are some.
> >>
> >> It is based on my linux-next branch, but please rebase it on top of 3.11-rc2.
> >>
> >> Generally, please send me pull requests based on -rc kernels only (or major
> >> releases).
> > 
> > Unless your material depends on new things in my linux-next branch, in which
> > case please let me know and I'll set up a stable branch for you to base things
> > on.
> 
> Hi Rafael,
> 
> I rebased my branch on top of 3.11-rc2, you can try to pull it again.

Pulled, thanks!

Next time, can you please add a general description of what the patches do and
why they do that to the pull request?

> I thought it would have been easier for us if I could based my PRs on
> top of your linux-next branch, so acting as a proxy for ARM patches. I
> am maintaining the clocksource drivers and I am basing my tree on top of
> tip/core.
> 
> I guess you are rebasing your tree often and this is an issue for you,
> right ?

Yes, my linux-next branch may contain commits that will be modified later
(e.g. ACKs added, fixes folded in etc.).

Anyway, as I said, as long as the material you have for me doesn't depend on
anything new in my tree, it's better to base it on top of an -rc kernel.

In case it does depend on that, I've put the entire outstanding cpuidle
material into my pm-cpuidle branch (including your ARM commits just pulled).

Thanks,
Rafael

