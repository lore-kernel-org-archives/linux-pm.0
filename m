From: Pavel Machek <pavel@suse.cz>
Subject: Re: Power management for SCSI
Date: Tue, 19 Aug 2008 09:38:39 +0200
Message-ID: <20080819073839.GA8726@atrey.karlin.mff.cuni.cz>
References: <20080813095055.GA475@elf.ucw.cz> <Pine.LNX.4.44L0.0808131026320.2455-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754170AbYHSHiv@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0808131026320.2455-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, James.Bottomley@HansenPartnership.com, teheo@novell.com, oneukum@suse.de
List-Id: linux-pm@vger.kernel.org

Hi!

> > Add support for autosuspend/autoresume. Lowlevel driver can use it to
> > spin the disk down and power down its SATA link, to turn off the USB
> > interface, etc.
> > 
> > Spinning down the disk is useful - saves ~0.5W here. Powering down
> > SATA controller is even better -- should save ~1W.
> > 
> > Now, I guess the patch will need to be split to small pieces for
> > merge... I tried to rearrange it so that the documentation and hooks
> > go before stuff that needs the hooks, and before Kconfig enabler. If
> > it looks reasonably good, I'll split it into smaller pieces.
> 
> James had a number of objections to my original patch; you can read 
> them here:
> 
> https://lists.linux-foundation.org/pipermail/linux-pm/2008-March/016849.html
> 
> I haven't had time yet to work on an improved version.

Would it make sense to split the patches into "autosuspend for SCSI
devices" and "autosuspend for SCSI controllers" for easier
review/merge? I guess I'll start with the devices, they seem easier...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
