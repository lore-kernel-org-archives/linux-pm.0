From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re: [linux-pm] ehci_hcd
 related S3 lockup on ASUS laptops, again)
Date: Sun, 27 May 2012 12:41:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205271238040.14937-100000@netrider.rowland.org>
References: <20120526223611.GF5012@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20120526223611.GF5012@belkar.wrar.name>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 27 May 2012, Andrey Rahmatullin wrote:

> On Sun, May 27, 2012 at 12:06:01AM +0200, Rafael J. Wysocki wrote:
> > > > Andrey, Stephen,
> > > > 
> > > > We still have problems with this patch in https://bugzilla.kernel.org/show_bug.cgi?id=43278
> > > > so some more testing will be necessary, I'm afraid.
> > > > 
> > > > I will send a series of ACPI and PCI patches I have collected so far,
> > > > that I'd like you to test on top of kernel 3.4.0 with commit
> > > > 151b61284776 reverted.
> > > > 
> > > > Please let me know if suspend/wakeup work for you with these patches applied.
> > > I get the usual freeze on suspending with these patches.
> > 
> > I see.
> > 
> > Please try to unapply [4/4] and see if that helps.
> It helps.

Andrey, can you try out Rafael's patches 1-3 (with 151b... reverted)  
and see what happens if the EHCI controllers' power/wakeup sysfs
atributes are first set to "disabled"?

Alan Stern

