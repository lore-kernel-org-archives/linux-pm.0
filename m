From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] Suspend to RAM, Sony Vaio PCG-SRX51P, lcd stays off
Date: Thu, 15 Feb 2007 11:45:02 +0100
Message-ID: <20070215104502.GO26240@elf.ucw.cz>
References: <45D43489.3060409@l4x.org> <20070215103639.GB27338@elf.ucw.cz> <45D438F2.2040607@l4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45D438F2.2040607@l4x.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Jan Dittmer <jdi@l4x.org>
Cc: stelian@popies.net, linux-acpi@vger.kernel.org, linux-pm@osdl.org, adaplas@pol.net, dawes@xfree86.org, Linux kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> >> I own an older Sony Vaio SRX51P, European Model, P3 based. s2ram
> >> identifies it with
> >>
> >>     sys_vendor   = "Sony Corporation    "
> >>     sys_product  = "PCG-SRX51P(DE)      "
> >>     sys_version  = "01                  "
> >>     bios_version = "R0232U2"
> >>
> >> Suspend to RAM by using "s2ram -v -m -f" actually works and the
> >> laptop comes back to life, is accessible by network, etc. kudos
> >> so far.
> >> The only but serious problem is, that the lcd stays off after
> >> resume. No matter what kind of options for s2ram I try, if I disable
> > 
> > Is the _lcd_ off or the _backlight_ off? Use bright flashlight to
> > tell.
> 
> The lcd. If you press the lid button you get the same effect (but you
> cannot use it to turn the lcd on again :-(( ). But I'll doublecheck with
> a flashlight nevertheless.

If lid button breaks the lcd, even in grub boot loader... then I'd
call your machine broken hardware, complain to the manufacturer. (Are
you at latest BIOS?)

> >> framebuffer or suspend from X, the lcd always stays off. Only
> >> a reboot fixes this. Note that the X driver also cannot dis-/enable
> >> the lcd (xset dpms force off). It always stays lit. I also tried
> >> with i810switch, but that also does not affect the lcd.
> >> spicctrl -b42 neither.
> >> Latest kernel I tested is 2.6.20-git11 from today.
> >>
> >> So has anyone of you suspend, acpi, sonypi, fb people an idea how to fix
> >> this? I suspect one has to call some magic ACPI method upon resume? What
> >> other kind of information would be needed to debug this? Anything more
> >> to try? Are there some sony people here listening who can fix this?
> > 
> > sonypi people actually might know how to help...
> > 
> >> 00:02.0 VGA compatible controller: Intel Corporation 82815 CGC
> > [Chipset Graphics Controller] (rev 11)
> > 
> > Wait a moment, did not Intel release nice, commented, GPLed sources
> > for their graphics cards somewhere? That might help.
> 
> URL? But I suspect the lcd on/off is controlled by some embedded controller
> or such (reachable via acpi, at least I've an EC0 in /proc/acpi/).

Google a bit, it was a _big_ announcement. Of course it is _possible_ EC
is responsible, but I don't quite think so.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
