From: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]
Date: Sun, 30 Jul 2006 01:22:16 +0200
Message-ID: <20060729232216.GB1983@elf.ucw.cz>
References: <20060727015639.9c89db57.akpm@osdl.org> <44CBA1AD.4060602@gmail.com> <200607292059.59106.rjw@sisk.pl> <44CBE9D5.9030707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750757AbWG2XW3@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <44CBE9D5.9030707@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-pm@osdl.org, linux-mm@kvack.org
List-Id: linux-pm@vger.kernel.org

Hi!

> >> I have problems with swsusp again. While suspending, the very last thing kernel
> >> writes is 'restoring higmem' and then hangs, hardly. No sysrq response at all.
> >> Here is a snapshot of the screen:
> >> http://www.fi.muni.cz/~xslaby/sklad/swsusp_higmem.gif
> >>
> >> It's SMP system (HT), higmem enabled (1 gig of ram).
> > 
> > Most probably it hangs in device_power_up(), so the problem seems to be
> > with one of the devices that are resumed with IRQs off.
> > 
> > Does vanila .18-rc2 work?
> 
> Yup, it does.

Can you try up kernel, no highmem? (mem=512M)?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
