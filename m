From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Date: Wed, 4 Jan 2006 23:16:56 +0100
Message-ID: <20060104221656.GE1860@elf.ucw.cz>
References: <20060104213405.GC1761@elf.ucw.cz> <Pine.LNX.4.44L0.0601041703350.26871-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965286AbWADWRL@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0601041703350.26871-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On St 04-01-06 17:06:09, Alan Stern wrote:
> On Wed, 4 Jan 2006, Pavel Machek wrote:
> 
> > > As I mentioned in the thread (currently happening, BTW) on the linux-pm
> > > list, what you want to do is accept a string that reflects an actual state
> > > that the device supports. For PCI devices that support low-power states,
> > > this would be "D1", "D2", "D3", etc. For USB devices, which only support
> > > an "on" and "suspended" state, the values that this patch parses would
> > > actually work.
> > 
> > We want _common_ values, anyway. So, we do not want "D0", "D1", "D2",
> > "D3hot" in PCI cases. We probably want "on", "D1", "D2", "suspend",
> > and I'm not sure about those "D1" and "D2" parts. Userspace should not
> > have to know about details, it will mostly use "on"/"suspend" anyway.
> 
> It would be good to make the details available so that they are there when
> needed.  For instance, we might export "D0", "on", "D1", "D2", "D3", and
> "suspend", treating "on" as a synonym for "D0" and "suspend" as a synonym
> for "D3".

Why to make it this complex?

I do not think there's any confusion possible. "on" always corresponds
to "D0", and "suspend" is "D3". Anyone who knows what "D2" means,
should know that, too...
							Pavel
-- 
Thanks, Sharp!
