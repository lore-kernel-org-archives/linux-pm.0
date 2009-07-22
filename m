From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] x86: Expected system state when resumed
Date: Wed, 22 Jul 2009 16:30:49 +0200
Message-ID: <200907221630.50154.rjw@sisk.pl>
References: <20090721164542.GA30390@plexity.net> <200907212248.18050.rjw@sisk.pl> <20090722141710.GA17721@plexity.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752025AbZGVOa2@vger.kernel.org>
In-Reply-To: <20090722141710.GA17721@plexity.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: dsaxena@plexity.net
Cc: linux-pm@lists.osdl.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 22 July 2009, Deepak Saxena wrote:
> On Jul 21 2009, at 22:48, Rafael J. Wysocki was caught saying:
> > On Tuesday 21 July 2009, Deepak Saxena wrote:
> > > 
> > > I am working on getting suspend/resume working on an x86 system
> > > (OLPC XO-1.5) where we are implementing ACPI based suspend/resume
> > > using Open Firmware and what I am seeing right now is that on 
> > > resume, we're not receiving interrupts so the system locks
> > > up in the suspend path when msleep() is called from the EHCI
> > > HCD resume code. lapic_resume() is being called so the APIC
> > > is being restored.  I'm looking for information on what else
> > > Linux's expectation from the firmware when control is handed back 
> > > before I start dumping every system register pre and post resume.
> > 
> > If that's 2.6.30 or later and your timer interrupt is MSI, for example, please
> > check if the timer interrupt is marked as IRQF_TIMER.  If it's not,
> > suspend_device_irqs() will mark it as disabled and it won't work during
> > early resume.
> 
> Thanks. I am using 2.6.30.1 and the standard x86 HPET driver which has 
> IRQF_TIMER set so this is not the issue. I've determined that if I boot 
> with "noapic", I can suspend/resume, but the system runs very slow as the
> PATA controller is now polled instead of irq driven.

So it looks like with IO-APIC enabled the timer interrupts don't reach the CPU
during resume, which indicates that the post-resume status of the IO-APIC is
somewhat not as expected.

Best,
Rafael
