From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Immediate wakeup after suspend
Date: Tue, 07 May 2013 02:45:31 +0200
Message-ID: <2183106.5nsY0q0PTD@vostro.rjw.lan>
References: <CAOULuObQq+WPf97LdsD5kN6cq=E9TvaHzqGzdKSWRme-Nk+WQQ@mail.gmail.com> <1612326.XDA8n1le4S@vostro.rjw.lan> <CAOULuObvuy_iTWp3sgqcvk39eF3KN2X77St=2A6w-BaeokFr2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:35221 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758792Ab3EGAhL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 6 May 2013 20:37:11 -0400
In-Reply-To: <CAOULuObvuy_iTWp3sgqcvk39eF3KN2X77St=2A6w-BaeokFr2Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Parag Warudkar <parag.lkml@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Monday, May 06, 2013 08:24:46 PM Parag Warudkar wrote:
> On Mon, May 6, 2013 at 7:56 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Monday, May 06, 2013 06:22:47 PM Parag Warudkar wrote:
> >> Sometime after 3.9 my iMac has started to resume almost immediately
> >> after suspend.  Even with 3.9 it was all working as expected.
> >
> > It'd be good to know something more precise, like for example which merge
> > introduced the problem.  I'm not aware of anything that might result is this
> > kind of breakage.
> 
> Ok, I will try bisecting - should not be that hard given the window
> isn't that big.
> 
> >
> >> Relevant dmesg output below. Any way to find out the source of the wakeup?
> >
> > Not really.
> >
> > You can play with the wakeup settings of various devices.
> >
> > Can you send the contents of /proc/acpi/wakeup from the machine?
> >
> 
> cat /proc/acpi/wakeup
> 
> Device  S-state   Status   Sysfs node
> P0P2      S4    *disabled  pci:0000:00:01.0
> GFX0      S4    *disabled  pci:0000:01:00.0
> EC        S4    *disabled
> HDEF      S4    *disabled  pci:0000:00:1b.0
> RP01      S4    *disabled  pci:0000:00:1c.0
> GIGE      S4    *disabled  pci:0000:02:00.0
> RP02      S4    *disabled  pci:0000:00:1c.1
> ARPT      S4    *disabled  pci:0000:03:00.0
> RP03      S4    *disabled  pci:0000:00:1c.2
> RP05      S4    *disabled  pci:0000:00:1c.4
> EHC1      S3    *enabled   pci:0000:00:1d.7
> EHC2      S3    *enabled   pci:0000:00:1a.7
> 
> I have tried disabling EHC1 and EHC2 without any difference.

That may mean one of two things: (1) After you'd tried that they appeared as
disabled, but the immediate wakeup still happened or (2) you'd tried to
disable them, but they still appeared as enabled.

Which one of them is it?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
