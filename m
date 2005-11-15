From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Tue, 15 Nov 2005 23:03:04 +0100
Message-ID: <20051115220304.GI1749@elf.ucw.cz>
References: <20051115212942.GA9828@elf.ucw.cz> <20051115213229.GB11776@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751164AbVKOWDP@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051115213229.GB11776@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > This is prototype of userland swsusp. I'd like kernel parts to go in,
> > probably for 2.6.16. Now, I'm not sure about the interface, ioctls are
> > slightly ugly, OTOH it would be probably overkill to introduce
> > syscalls just for this. (I'll need to add an ioctl for freeing memory
> > in future).
> 
> What's wrong with 4 new syscalls?  It seems the cleanest way.

I'd need about 7 of them, and that is on at least 3 architectures
(i386, x86-64, ppc, not sure about ppc64/arm). And it does not fix the
interface -- userland parts will still need to read/write /dev/kmem
:-(.

Yep, I can do it...
								Pavel
-- 
Thanks, Sharp!
