From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/acpi: Fix improper handling of SCI INT for platforms
 supporting only IOAPIC mode
Date: Wed, 15 Nov 2017 19:30:14 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1711151929200.1805@nanos>
References: <1510306686-18230-1-git-send-email-vikas.cha.sajjan@hpe.com> <CAJZ5v0g8d=q1TZvacBZ_EDMjAnufQdHYkfbnkhv4kSH_FNOhDg@mail.gmail.com> <CS1PR8401MB05189C5186CD6E4B6509EAD5D9290@CS1PR8401MB0518.NAMPRD84.PROD.OUTLOOK.COM>
 <CAJZ5v0jQErbC729H0JCjO-RqJRYZ8P2zHdJm0HopXNB781G_aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42961 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932593AbdKOSaQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 13:30:16 -0500
In-Reply-To: <CAJZ5v0jQErbC729H0JCjO-RqJRYZ8P2zHdJm0HopXNB781G_aw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Sajjan, Vikas C" <vikas.cha.sajjan@hpe.com>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Seunghun Han <kkamagui@gmail.com>, Ingo Molnar <mingo@kernel.org>, "Lakshminarasimha, Sunil Vishwanathpur" <sunil.vl@hpe.com>, "Attar, Abdul Lateef" <abdul-lateef.attar@hpe.com>

On Wed, 15 Nov 2017, Rafael J. Wysocki wrote:
> On Wed, Nov 15, 2017 at 6:30 PM, Sajjan, Vikas C
> <vikas.cha.sajjan@hpe.com> wrote:
> > Hi Rafael,
> >
> > -----Original Message-----
> > From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of Rafael J. Wysocki
> > Sent: Wednesday, November 15, 2017 10:51 PM
> > To: Sajjan, Vikas C <vikas.cha.sajjan@hpe.com>
> > Cc: Linux PM <linux-pm@vger.kernel.org>; ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Rafael J. Wysocki <rjw@rjwysocki.net>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Seunghun Han <kkamagui@gmail.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@kernel.org>; Lakshminarasimha, Sunil Vishwanathpur <sunil.vl@hpe.com>; Attar, Abdul Lateef <abdul-lateef.attar@hpe.com>
> > Subject: Re: [PATCH] x86/acpi: Fix improper handling of SCI INT for platforms supporting only IOAPIC mode
> >
> > On Fri, Nov 10, 2017 at 10:38 AM, Vikas C Sajjan <vikas.cha.sajjan@hpe.com> wrote:
> >> The platforms which support only IOAPIC mode and whose SCI INT is
> >> greater than 16, passes SCI INT via FADT and not via MADT int src
> >> override structure. In such cases current logic fails to handle it and
> >> throws error "Invalid bus_irq %u for legacy override". This patch
> >> handles the above  mentioned case. While at it, also modify function
> >> mp_override_legacy_irq() to use the newly introduced function mp_register_ioapic_irq().
> >
> > Actually, is it necessary to make this extra change here?
> >
> > How complicated would it be to separate it out?
> >
> > I can move these extra changes into a separate patch and keep only the fix in this patch.
> 
> That would be useful I think in case someone wants to backport your
> fix, for example.

That would also simplify review a lot. I'll wait for that before I twist my
brain around distangling the changes.

Thanks,

	tglx
