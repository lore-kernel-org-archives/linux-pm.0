From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Tue, 29 May 2012 19:30:03 +0200
Message-ID: <201205291930.03413.rjw@sisk.pl>
References: <20120526223611.GF5012@belkar.wrar.name> <201205282213.01560.rjw@sisk.pl> <20120529074852.GF5028@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20120529074852.GF5028@belkar.wrar.name>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 29, 2012, Andrey Rahmatullin wrote:
> On Mon, May 28, 2012 at 10:13:01PM +0200, Rafael J. Wysocki wrote:
> > > > > > > > Andrey, Stephen,
> > > > > > > > 
> > > > > > > > We still have problems with this patch in https://bugzilla.kernel.org/show_bug.cgi?id=43278
> > > > > > > > so some more testing will be necessary, I'm afraid.
> > > > > > > > 
> > > > > > > > I will send a series of ACPI and PCI patches I have collected so far,
> > > > > > > > that I'd like you to test on top of kernel 3.4.0 with commit
> > > > > > > > 151b61284776 reverted.
> > > > > > > > 
> > > > > > > > Please let me know if suspend/wakeup work for you with these patches applied.
> > > > > > > I get the usual freeze on suspending with these patches.
> > > > > > 
> > > > > > I see.
> > > > > > 
> > > > > > Please try to unapply [4/4] and see if that helps.
> > > > > It helps.
> > > > 
> > > > Andrey, can you try out Rafael's patches 1-3 (with 151b... reverted)  
> > > > and see what happens if the EHCI controllers' power/wakeup sysfs
> > > > atributes are first set to "disabled"?
> > > It freezes.
> > 
> > Well, that means trying to work around this through changing the algorithm
> > of selecting the target state of a device wasn't a good idea after all.
> > 
> > Still, we've found some bugs in the process, so it was worth the effort.
> > 
> > Please attach the output of dmidecode from your machine.
> Attached.

Cool, thanks!
