From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB D3 vs system S3
Date: Wed, 9 Jan 2008 11:07:04 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801091105220.4652-100000@iolanthe.rowland.org>
References: <200801091251.55883.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200801091251.55883.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Len Brown <lenb@kernel.org>, David Brownell <david-b@pacbell.net>, gregkh@suse.de, linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 9 Jan 2008, Carlos Corbacho wrote:

> I've had confirmation from another nForce 4 box that Vista also disables 
> autosuspend/ selective suspend on the root hubs there, so I'm pretty 
> confident in saying now that this will also be needed in Linux (definitely 
> for OHCI. I don't think we need to stop autosuspend on EHCI, even though 
> Windows does appear to disable it for that as well), to avoid inadvertently 
> triggering the suspend-to-RAM hang on these broken BIOSs.
> 
> (Testing also shows that putting the OHCI controller into D2 is no good 
> either - having it in any state other than D1 before we call the ACPI _PTS() 
> method will reliably hang the box on suspend).
> 
> What's the best way to go about doing this? I've been glancing over the OHCI 
> code and I can't see how to easily do this (unless 'broken_suspend' is the 
> correct option here?)

Currently there's no need to change anything.

The USB autosuspend code affects only the controller's USB interface -- 
it doesn't touch the PCI side.  An autosuspended controller will remain 
in D0.  Until somebody tries writing autosuspend code for PCI 
devices...

Alan Stern

