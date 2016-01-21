From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC V2 1/2] irq: Add a framework to measure interrupt timings
Date: Thu, 21 Jan 2016 21:27:11 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601212114480.3886@nanos>
References: <1453305636-22156-1-git-send-email-daniel.lezcano@linaro.org> <1453305636-22156-2-git-send-email-daniel.lezcano@linaro.org> <20160120190718.GS6357@twins.programming.kicks-ass.net> <alpine.DEB.2.11.1601202050050.3575@nanos> <56A0A9E3.2070306@linaro.org>
 <20160121100834.GM6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41032 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbcAUU2O (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2016 15:28:14 -0500
In-Reply-To: <20160121100834.GM6356@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org

On Thu, 21 Jan 2016, Peter Zijlstra wrote:
> On Thu, Jan 21, 2016 at 10:50:27AM +0100, Daniel Lezcano wrote:
> 
> > Actually, the handle passes dev_id in order to let the irqtimings to sort
> > out a shared interrupt and prevent double sampling. In other words, for
> > shared interrupts, statistics should be per t-uple(irq , dev_id) but that is
> > something I did not implemented ATM.
> > 
> > IMO, the handler is at the right place. The prediction code does not take
> > care of the shared interrupts yet.
> 
> That certainly added to the confusion. But if you want per dev_id stats,
> the whole alloc framework is 'broken' too, for it allocates the stuff
> per irq.
> 
> > I tried to find a platform with shared interrupts in the ones I have
> > available around me but I did not find any. Are the shared interrupts
> > something used nowadays or coming from legacy hardware ? What is the
> > priority to handle the shared interrupts in the prediction code ?
> 
> They're less common (thankfully) than they used to be, but I still have
> them:
> 
> root@ivb-ep:~# cat /proc/interrupts | grep ","
>   0   IO-APIC  5-fasteoi   i801_smbus, i801_smbus

Hardly something which is worth to add the extra complexity.
 
> root@wsm-ep:~# cat /proc/interrupts | grep ","
>  18:  0   0	 IO-APIC  18-fasteoi   ehci_hcd:usb1, uhci_hcd:usb6
>  23:  3   927  IO-APIC  23-fasteoi   ehci_hcd:usb2, uhci_hcd:usb4

Stick the USB thingy into the XHCI port :)

>  19:    9695230   19577242  .... IO-APIC  19-fasteoi   uhci_hcd:usb5, ata_piix
> root@snb:~# cat /proc/interrupts | grep ","
>  19:   11058485   IO-APIC  19-fasteoi   ata_piix, ata_piix

Go to the BIOS and enable AHCI mode. Both the snb and the wsm-ep chipsets can
be switched between legacy piix and ahci mode :)

You seem to have a faible for last century hardware.

> Also there's a whole host of SOCs that has them.

And one of the reasons is, that a lot of drivers do not support msi, while
these embedded beasts support MSI on almost every peripheral, at least the
newer ones.

Thanks,

	tglx



