From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: USB D3 vs system S3
Date: Wed, 9 Jan 2008 12:51:54 +0000
Message-ID: <200801091251.55883.carlos@strangeworlds.co.uk>
References: <200801081547.00473.lenb@kernel.org> <200801090009.22447.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200801090009.22447.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, gregkh@suse.de, linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday 09 January 2008 00:09:21 Carlos Corbacho wrote:
> 2) Based on poking around in Vista, it may also be required to disable
> autosuspend for OHCI on CK804 (nForce 4), since Vista here apparently does
> not enable USB autosuspend on the USB hubs on this board (yet enabling
> autosuspend is supposedly the default Vista behaviour, and I've certainly
> never touched the USB settings in Vista).
>
> Given we have two different BIOS's from different manufacturers for the
> same chipset, that both have a similar SMI trap, and are both breaking
> here, I wonder if this is a known problem with the reference nVidia BIOS;
> so Windows will not put USB devices into D3 early on this chipset, to
> ensure that USB0 is not in a low power state before _PTS() is called
> (unfortunately, on point 2, I don't have enough to back it up either way,
> besides my own observations here).

I've had confirmation from another nForce 4 box that Vista also disables 
autosuspend/ selective suspend on the root hubs there, so I'm pretty 
confident in saying now that this will also be needed in Linux (definitely 
for OHCI. I don't think we need to stop autosuspend on EHCI, even though 
Windows does appear to disable it for that as well), to avoid inadvertently 
triggering the suspend-to-RAM hang on these broken BIOSs.

(Testing also shows that putting the OHCI controller into D2 is no good 
either - having it in any state other than D1 before we call the ACPI _PTS() 
method will reliably hang the box on suspend).

What's the best way to go about doing this? I've been glancing over the OHCI 
code and I can't see how to easily do this (unless 'broken_suspend' is the 
correct option here?)

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
