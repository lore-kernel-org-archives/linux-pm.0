From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspended DRAM bridge
Date: Mon, 01 Apr 2013 23:41:22 +0200
Message-ID: <1461283.gKidiaRK7T@vostro.rjw.lan>
References: <5159BAC9.80700@fold.natur.cuni.cz> <35938665.ZFvDxnCU3l@vostro.rjw.lan> <5159F775.30805@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:49629 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758009Ab3DAVds (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 1 Apr 2013 17:33:48 -0400
In-Reply-To: <5159F775.30805@fold.natur.cuni.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

On Monday, April 01, 2013 11:09:09 PM Martin Mokrejs wrote:
> Hi Rafael,
> 
> Rafael J. Wysocki wrote:
> > On Monday, April 01, 2013 06:50:17 PM Martin Mokrejs wrote:
> >> Hi Rafael,
> >>   I have a simple question. Why seems my DRAM controller suspended?
> > 
> > I suppose that runtime PM is disabled for that device and therefore
> > runtime_status is meaningless.
> 
> But I really mean this pair of values:
> 
> /sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended
> 
> /sys/bus/pci/devices/0000:00:00.0/power/control:auto
> 
> 
> > 
> > And really, that attribute is for *debugging* things by developers who know
> > what they are looking for and not for random poking.
> 
> Well, if me or you are to figure out why laptop-mode-tools make my life
> even more miserable with hotplug issues the requests to provide
> 
> grep . /sys/bus/pci/devices/*/power/runtime_status
> grep . /sys/bus/pci/devices/*/power/control
> 
> provide crap. How can I infer something if I cannot trust the values?

The phrase "trust the values" above doesn't make sense.  You need to know what
the values are supposed to *mean* in the first place, which you evidently
don't.

And what they mean is:

/sys/devices/.../power/runtime_status - the current value of the device's
runtime_status attribute at the moment.  [Notice that you need to know the code
in question to know the meaning of that attribute.]  That field always has
certain value, even though it may not make sense *to* *you*.

/sys/devices/.../power/control - "on" means that user space doesn't allow the
device to be runtime-suspended, while "auto" meanse that it *does* allow that
to happen.  Nothing more or less than that.

In particular, "auto" doesn't need to mean that the device will be
runtime-suspended at all and the value of runtime_status requires
interpretation.

That's how it goes.

Now, if you want me (or anyone else on this list) to help you, why don't you
test 3.9-rc5 with the patch at https://patchwork.kernel.org/patch/2368081/
applied and send *one* message describing *briefly* what *does* *not* *work*
for you, without attaching any logs, lspci outputs and so on just yet?

Then, we can try to address the problems you have in 3.9-rc5 and go back to the
(still supported) 'stable' kernels from there.

Does that sound like a workable plan?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
