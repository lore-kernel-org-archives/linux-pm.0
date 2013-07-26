From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RESEND] cpuidle for ARM pull request
Date: Fri, 26 Jul 2013 02:07:06 +0200
Message-ID: <1598661.FpX5cmjM1U@vostro.rjw.lan>
References: <51E536C5.1020609@linaro.org> <1766778.ZYeDKBOsjV@vostro.rjw.lan> <2075555.RCmWLFAfjq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40615 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753586Ab3GYX5C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Jul 2013 19:57:02 -0400
In-Reply-To: <2075555.RCmWLFAfjq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, keun-o.park@windriver.com, "nsekhar@ti.com >> Sekhar Nori" <nsekhar@ti.com>

On Friday, July 26, 2013 12:41:09 AM Rafael J. Wysocki wrote:
> On Friday, July 26, 2013 12:29:08 AM Rafael J. Wysocki wrote:
> > On Friday, July 26, 2013 12:07:03 AM Daniel Lezcano wrote:
> > > On 07/16/2013 02:04 PM, Daniel Lezcano wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > The first PR was against the linux-pm-next tree including the patch:
> > > > 
> > > > "cpuidle: Add Kconfig.arm and move calxeda, kirkwood and zynq"
> > > > 
> > > > This patch has been dropped in the meantime.
> > > > 
> > > > Here is a new PR where my tree has been rebased against linux-pm-next
> > > > and adding the patch mentioned above.
> > > > 
> > > > As stated by Rafael, I will handle the ARM specific patches from now.
> > > > 
> > > > The following changes since commit 48f99d5a97d32d70c0738d6e314d9f4dbefd89bf:
> > > > 
> > > >   Merge branch 'pm-cpuidle-next' into linux-next (2013-07-16 02:41:06 +0200)
> > > > 
> > > > are available in the git repository at:
> > > > 
> > > > 
> > > >   git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next
> > > > 
> > > > for you to fetch changes up to 2b7e79f4a75e803184f483985a25cc751a990f06:
> > > > 
> > > >   ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle
> > > > (2013-07-16 13:57:24 +0200)
> > > 
> > > ping ?
> > 
> > Sorry, something distracted me.  I'll pull it later today unless there are any
> > problems (in which case I'll let you know).
> 
> Well, there are some.
> 
> It is based on my linux-next branch, but please rebase it on top of 3.11-rc2.
> 
> Generally, please send me pull requests based on -rc kernels only (or major
> releases).

Unless your material depends on new things in my linux-next branch, in which
case please let me know and I'll set up a stable branch for you to base things
on.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
