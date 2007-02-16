From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] Suspend to RAM, Sony Vaio PCG-SRX51P, lcd stays off
Date: Fri, 16 Feb 2007 11:59:31 +0100
Message-ID: <20070216105931.GE4176@elf.ucw.cz>
References: <45D43489.3060409@l4x.org> <20070215103639.GB27338@elf.ucw.cz> <37556.85.47.20.193.1171540572.squirrel@picard.linux.it> <45D558D6.3050303@l4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45D558D6.3050303@l4x.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Jan Dittmer <jdi@l4x.org>, seife@novell.com
Cc: Mattia Dongili <malattia@linux.it>, stelian@popies.net, linux-acpi@vger.kernel.org, linux-pm@osdl.org, adaplas@pol.net, dawes@xfree86.org, Linux kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > On Thu, February 15, 2007 11:36 am, Pavel Machek said:
> 
> >>>     sys_vendor   = "Sony Corporation    "
> >>>     sys_product  = "PCG-SRX51P(DE)      "
> >>>     sys_version  = "01                  "
> >>>     bios_version = "R0232U2"
> >>>
...
> >>> Latest kernel I tested is 2.6.20-git11 from today.
> > 
> > I read reports of successful suspends on that laptop, eg:
> > http://freenet-homepage.de/obauer/index.html
> 
> Ok, now I feel totally dumb. 's2ram -s -f' actually works iff you disable
> fb support completely in the kernel. It works even from X. Don't know how
> many combinations I tried but that one somehow slipped through. Anyway
> thanks for your help. So could this machine be added to the s2ram
> database?

Stefan, can we add this one?

Anyway, it would be nice to actually fix the fb support in kernel not
to hang the machine on your Sony...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
