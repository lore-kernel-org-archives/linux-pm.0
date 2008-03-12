From: Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: +
	pm-gxfb-add-hook-to-pm-console-layer-that-allows-disabling-of-suspend-vt-switch.patch
	added to -mm tree
Date: Wed, 12 Mar 2008 08:45:06 -0600
Message-ID: <20080312144506.GE1018@cosmic.amd.com>
References: <200803120527.m2C5RmWl011967@imap1.linux-foundation.org> <20080312085149.GA3993@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753381AbYCLOpV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080312085149.GA3993@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, mm-commits@vger.kernel.org, dilinger@queued.net, adaplas@pol.net, dilinger@debian.org, rjw@sisk.pl
List-Id: linux-pm@vger.kernel.org

On 12/03/08 09:51 +0100, Pavel Machek wrote:
> Hi!
> 
> > Subject: PM/gxfb: add hook to PM console layer that allows disabling of suspend VT switch
> > From: Andres Salomon <dilinger@queued.net>
> > 
> > Prior to suspend, we allocate and switch to a new VT; after suspend, we switch
> > back to the original VT.  This can be slow, and is completely unnecessary if
> > the framebuffer we're using can restore video properly.
> > 
> > This adds a hook that allows drivers to select whether or not to do this vt
> > switch, and changes the gxfb driver to call this hook.  It also adds a module
> > param to gxfb to allow controlling of the vt switch (defaulting to no switch).
> > 
> > (Note: I'm not convinced that console_sem is the best way to protect this, but
> > we should probably have some form of locking..)
> 
> I guess this is okay for now, but we probably want to make it more
> elaborate in future.
> 
> Console switch is there to make sure kernel (not X) owns the graphical
> hardware.
> 
> That is unneccessary for gxfb since X never owns graphics hardware,
> good. (I do not see why it is optional, then. Do you really want to
> see tty1?)

Its the dream for the lxfb and gxfb to own the graphics hardware
completely (at least, thats what Jim Gettys keeps pounding in to my
brain), but we're not quite there yet.  What we have here are 
framebuffer drivers that are intelligent enough to save and restore the
state of the graphics engine, which is still a lot better then most other
drivers.

> Now, question is what happens with two graphics cards, one of them
> driven by X. Fortunately that is uncommon.

We would be screwed.  But since the Geode has built in graphics logic,
it doesn't make much sense to use an external card, so we'll mostly
avoid this problem.  But even if it happens, we'll have the VT switch
available in a pinch.

> Also, it would be nice to make the logic the other way around. Move vt
> switching to the drivers that need it because X can be expected to own
> the hardware.

Conservation of energy.  Its easier to make 3 or 4 drivers opt out of 
VT switching, rather then hacking 64 other drivers to opt in.  Hopefully
more people will fix their drivers and make this statement false.. :)

Jordan

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.
