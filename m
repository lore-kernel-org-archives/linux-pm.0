From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: power_state: remove it from usb
Date: Thu, 21 Feb 2008 16:50:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0802211648530.2114-100000@iolanthe.rowland.org>
References: <20080221130145.GA3789@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080221130145.GA3789-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, 21 Feb 2008, Pavel Machek wrote:

> power_state is scheduled for removal, and it is used only write-only
> by USB. Remove it.

Unfortunately some of the things you changed turn out not to be 
write-only.  (You also missed a usage of power.power_state in a 
comment!)  I'll post a more complete patch soon.

Alan Stern
