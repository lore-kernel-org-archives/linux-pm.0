From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Sun, 27 May 2012 00:06:01 +0200
Message-ID: <201205270006.01753.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1205252157430.24286-100000@saphir.localdomain> <201205262316.30096.rjw@sisk.pl> <20120526214702.GE5012@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20120526214702.GE5012@belkar.wrar.name>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, May 26, 2012, Andrey Rahmatullin wrote:
> On Sat, May 26, 2012 at 11:16:29PM +0200, Rafael J. Wysocki wrote:
> > Andrey, Stephen,
> > 
> > We still have problems with this patch in https://bugzilla.kernel.org/show_bug.cgi?id=43278
> > so some more testing will be necessary, I'm afraid.
> > 
> > I will send a series of ACPI and PCI patches I have collected so far,
> > that I'd like you to test on top of kernel 3.4.0 with commit
> > 151b61284776 reverted.
> > 
> > Please let me know if suspend/wakeup work for you with these patches applied.
> I get the usual freeze on suspending with these patches.

I see.

Please try to unapply [4/4] and see if that helps.  If it doesn't,
please try to enable the problematic USB controller to wake up
(e.g. by writing "enabled" to its /sys/power/.../wakeup file before the
suspend) and see if that helps.

Thanks,
Rafael
