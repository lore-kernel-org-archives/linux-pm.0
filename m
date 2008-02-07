From: Pavel Machek <pavel@ucw.cz>
Subject: Re: ACPI_WMI: worst config description of all times
Date: Thu, 7 Feb 2008 23:34:55 +0100
Message-ID: <20080207223455.GB6096@elf.ucw.cz>
References: <20080207214715.GA15211@elf.ucw.cz> <200802071727.38743.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200802071727.38743.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 2008-02-07 17:27:38, Len Brown wrote:
> On Thursday 07 February 2008 16:47, Pavel Machek wrote:
> > 
> > See? It even has completely useless help text.
> > 
> > Does WMI stand for Windows Management Instrumentation? It is some
> > server management feature? What is it good for?
> 
> Thank you for the feedback, Pavel.
> 
> There is an additional patch which creates
> Documentation/acpi/wmi.txt, but I witheld it from
> this batch because it needs to be revised.
> If you are not subscribed to the linux-acpi list
> you can find it here:
> 
> http://marc.info/?l=linux-acpi&m=120217838010224&w=2
> 
> Clearly we neeed to update the Kconfig doc as well when
> we revise and push that patch.

 +ACPI-WMI mapping driver
 +
 +Copyright (C) 2007-2008 Carlos Corbacho <carlos@strangeworlds.co.uk>
 +
 +Updated: 5th February 2008
 +
 +1) About this guide
 +
 +This guide is a basic introduction on how to interact with the ACPI-WMI mapper
 +driver in the kernel - it presumes you already have a basic knowledge of
 +ACPI-WMI, ACPI and the hardware you are writing the driver for.
 +
 +2) What is ACPI-WMI
 +
 +At its simplest, ACPI-WMI is a proprietary extension to the ACPI specification
 +from Microsoft to allow WMI (their implementation of WBEM) to access
 +instrumentation data and methods in ACPI from userspace, via the ACPI _HID
 +device PNP0C14.
 +
 +3) What is the ACPI-WMI mapper
 +
 +The Linux ACPI-WMI driver is the implementation of this mapper for Linux.

Yes, please. This needs translation into plain english.

What is WBEM, in plain terms? What is it good for?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
