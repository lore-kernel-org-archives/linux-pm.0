From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH] PM / sleep: Rename symbols, functions and variables related to sleep
Date: Tue, 12 Aug 2014 03:19:58 +0200
Message-ID: <2666088.461S5R02FO@vostro.rjw.lan>
References: <5215142.eaz1Ajyth6@vostro.rjw.lan> <CAOesGMiohfNDRo1P58NYdQA6tqSLfuPQV85BEDVVo8UvtW=Ctw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57754 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754074AbaHLBBK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Aug 2014 21:01:10 -0400
In-Reply-To: <CAOesGMiohfNDRo1P58NYdQA6tqSLfuPQV85BEDVVo8UvtW=Ctw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Zhang Rui <rui.zhang@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>

On Monday, August 11, 2014 08:15:22 AM Olof Johansson wrote:
> On Sun, Jul 27, 2014 at 4:13 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The names of several symbols, data types, functions and variables
> > related to system sleep states are confusing and don't reflect the
> > real behavior of those states correctly.
> >
> > First of all, there generally are two sleep states that require
> > platform support and one sleep state that is platform-independent.
> > The first two of them are currently known as MEM and STANDBY,
> > although these names really only match what the states do on full
> > hardware ACPI compliant systems.  MEM in particular is supposed
> > to mean "suspend-to-RAM", but in fact it means "the deepest sleep
> > state available with platform support".  The definition of STANDBY
> > is even more arbitrary.
> >
> > Moreover, the remaining sleep state that doesn't need platform support
> > is currently called FREEZE, which leads to double confusion with the
> > process freezer (used during transitions to all sleep states) and
> > with the freeze stage of processing devices during hibernation.
> >
> > For these reasons, rename the PM_SUSPEND_MEM, PM_SUSPEND_STANDBY
> > and PM_SUSPEND_FREEZE symbols to PM_SUSPEND_PLATFORM_DEEP,
> > PM_SUSPEND_PLATFORM_SHALLOW and PM_SUSPEND_IDLE_SLEEP, respectively,
> > everywhere and rename data types, functions and variables related to
> > those states to match the new names of the symbols.
> >
> > This is a semi-mechanical replacement of names and it should not lead
> > to any functional differences.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> This showed up in -next over this weekend and broke two ARM builds.

Sorry about that, I dropped this patch from my linux-next brach.

Rafael

