From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] ACPI / PM: Make ACPI-based PCI wakeup work for the "freeze" sleep state
Date: Tue, 22 Jul 2014 14:23:03 +0200
Message-ID: <2866134.Da8PQoU0sW@vostro.rjw.lan>
References: <1907495.agrCMfRsQN@vostro.rjw.lan> <9631666.En3K0jlGsY@vostro.rjw.lan> <20140722085538.GA3935@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56755 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751290AbaGVMEn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jul 2014 08:04:43 -0400
In-Reply-To: <20140722085538.GA3935@laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>

On Tuesday, July 22, 2014 10:55:38 AM Peter Zijlstra wrote:
> On Tue, Jul 22, 2014 at 03:23:29AM +0200, Rafael J. Wysocki wrote:
> 
> > That turned out to be more challenging than I had thought initially.
> > 
> > The last version I sent was almost OK, but it had some issues (like it could
> > walk the PCI hierarchy before resuming any PCI devices during system resume),
> > so a new version follows.  I did my best to avoid introducing any new problems
> > with it, but I obviously might overlook something.
> > 
> > It works for me and doesn't seem to break anything as far as I can say.
> > 
> > [1/3] Make PM workqueue available for CONFIG_PM_RUNTIME unset.
> > [2/3] Rework the handling of ACPI device wakeup notifications.
> > [3/3] Enable wakeup GPEs while setting up devices for wakeup during system
> >       suspend too.
> 
> Doesn't break, doesn't 'work' either.

This probably means that WoL on that machine is not ACPI-based.

> Is there anything I can provide you with to make this easier? lspci output
> or anything like that?

Yes, /proc/interrupts from the machine in question would help to start with.

Also /sys/kernel/debug/wakeup_sources (if /sys/kernel/debug/ is where your debugfs
lives) before and after a "freeze" with an attempt to use WoL to wake it up.

Rafael

