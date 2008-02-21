From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: power_state: remove it from usb
Date: Thu, 21 Feb 2008 23:19:50 +0100
Message-ID: <20080221221950.GA25977@elf.ucw.cz>
References: <20080221130145.GA3789@elf.ucw.cz> <Pine.LNX.4.44L0.0802211648530.2114-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0802211648530.2114-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu 2008-02-21 16:50:36, Alan Stern wrote:
> On Thu, 21 Feb 2008, Pavel Machek wrote:
> 
> > power_state is scheduled for removal, and it is used only write-only
> > by USB. Remove it.
> 
> Unfortunately some of the things you changed turn out not to be 
> write-only.  (You also missed a usage of power.power_state in a 
> comment!)  

I might have missed comments, but where I missed read? It compiled
after I removed the field from the core...?

> I'll post a more complete patch soon.		

Thanks!
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
