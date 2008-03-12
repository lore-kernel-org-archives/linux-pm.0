From: Pavel Machek <pavel@ucw.cz>
Subject: Re: + pm-gxfb-add-hook-to-pm-console-layer-that-allows-disabling-of-suspend-vt-switch.patch added to -mm tree
Date: Wed, 12 Mar 2008 09:51:49 +0100
Message-ID: <20080312085149.GA3993@ucw.cz>
References: <200803120527.m2C5RmWl011967@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751543AbYCLIwV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200803120527.m2C5RmWl011967@imap1.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
Cc: mm-commits@vger.kernel.org, dilinger@queued.net, adaplas@pol.net, dilinger@debian.org, jordan.crouse@amd.com, rjw@sisk.pl
List-Id: linux-pm@vger.kernel.org

Hi!

> Subject: PM/gxfb: add hook to PM console layer that allows disabling of suspend VT switch
> From: Andres Salomon <dilinger@queued.net>
> 
> Prior to suspend, we allocate and switch to a new VT; after suspend, we switch
> back to the original VT.  This can be slow, and is completely unnecessary if
> the framebuffer we're using can restore video properly.
> 
> This adds a hook that allows drivers to select whether or not to do this vt
> switch, and changes the gxfb driver to call this hook.  It also adds a module
> param to gxfb to allow controlling of the vt switch (defaulting to no switch).
> 
> (Note: I'm not convinced that console_sem is the best way to protect this, but
> we should probably have some form of locking..)

I guess this is okay for now, but we probably want to make it more
elaborate in future.

Console switch is there to make sure kernel (not X) owns the graphical
hardware.

That is unneccessary for gxfb since X never owns graphics hardware,
good. (I do not see why it is optional, then. Do you really want to
see tty1?)

Now, question is what happens with two graphics cards, one of them
driven by X. Fortunately that is uncommon.

Also, it would be nice to make the logic the other way around. Move vt
switching to the drivers that need it because X can be expected to own
the hardware.

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
