From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Changes in sleep mode, on x86 PC
Date: Tue, 29 Mar 2016 16:15:39 +0200
Message-ID: <20160329141539.GA23974@amd>
References: <20160328212010.GA22713@amd>
 <4224351.Xlkh4fNNHG@vostro.rjw.lan>
 <1459260009.5124.5.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41504 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932203AbcC2OPn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 10:15:43 -0400
Content-Disposition: inline
In-Reply-To: <1459260009.5124.5.camel@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel list <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>

Hi!

On Tue 2016-03-29 16:00:09, Oliver Neukum wrote:
> On Tue, 2016-03-29 at 15:06 +0200, Rafael J. Wysocki wrote:
> > On Monday, March 28, 2016 11:20:12 PM Pavel Machek wrote:
> > > Hi!
> > > 
> > > Few releases ago, I could wake up PC from S3 sleep by hitting any
> > > key. That ceased to work some time before, keyboard would just light a
> > > NUM lock LED when I hit a key (4.5). Now PC seems to be sleeping (in
> > > S3) with NUM lock LED on (4.6-rc0).

Ok, that "sleeping with numlock LED on" is not reproducible.

> > > Any idea what is going on there? Does it happen for you, too? What is
> > > the expected behaviour?
> > >
> > > Debian 8.3, with MATE desktop, I just hit the "moon" key to make it
> > > sleep. Keyboard is on USB.
> > 
> > That's rather important.
> > 
> > Clearly, something in the USB HID land has changed lately.
> 
> Not necessarily. ACPI may also be the root cause.

Ok, that breakage may be year-or-so old.

> > The expected behavior depends on whether or not the keyboard itself and the
> > USB controller are both enabled to wake up.  If they are, I'd expect any
> > key press to generate a wakeup event.
> 
> What does /proc/acpi/wakeup say?

Device	S-state	  Status   Sysfs node
P0P1	  S3	*disabled  pci:0000:00:01.0
P0P2	  S4	*disabled  pci:0000:00:1e.0
PS2K	  S3	*disabled
PS2M	  S3	*disabled
UAR1	  S3	*disabled  pnp:00:03
USB0	  S3	*enabled   pci:0000:00:1d.0
USB1	  S3	*enabled   pci:0000:00:1d.1
USB2	  S3	*enabled   pci:0000:00:1d.2
USB3	  S3	*enabled   pci:0000:00:1d.3
EUSB	  S4	*enabled   pci:0000:00:1d.7
P0P9	  S4	*disabled  pci:0000:00:1c.0
P0PA	  S4	*disabled  pci:0000:00:1c.1
P0PB	  S4	*disabled
P0PC	  S4	*disabled
P0PD	  S4	*disabled
P0PE	  S4	*disabled
PWRB	  S3	*enabled   platform:PNP0C0C:00

Directly-connected USB keyboard. Numlock goes on when I hit a key, but
it stays sleeping.

Thanks,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
