From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB D3 vs system S3
Date: Wed, 9 Jan 2008 12:16:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801091213250.2880-100000@iolanthe.rowland.org>
References: <200801091638.46706.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200801091638.46706.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Len Brown <lenb@kernel.org>, David Brownell <david-b@pacbell.net>, gregkh@suse.de, linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 9 Jan 2008, Carlos Corbacho wrote:

> On Wednesday 09 January 2008 16:07:04 Alan Stern wrote:
> > Currently there's no need to change anything.
> 
> Ok.
> 
> > The USB autosuspend code affects only the controller's USB interface --
> > it doesn't touch the PCI side.  An autosuspended controller will remain
> > in D0.  Until somebody tries writing autosuspend code for PCI
> > devices...
> 
> Is this likely to happen?

I don't know of anybody working on it.  A minimal prerequisite is that 
PCI runtime wakeup processing needs to work right -- which it doesn't.  
See 

	http://bugzilla.kernel.org/show_bug.cgi?id=6892

Alan Stern

