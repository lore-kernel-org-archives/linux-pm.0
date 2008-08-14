From: Pavel Machek <pavel@suse.cz>
Subject: Re: Power management for SCSI
Date: Thu, 14 Aug 2008 15:08:12 +0200
Message-ID: <20080814130812.GC2262@elf.ucw.cz>
References: <20080813095055.GA475@elf.ucw.cz> <Pine.LNX.4.44L0.0808131026320.2455-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752931AbYHNOAE@vger.kernel.org>
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

Ok, I see, "its done at the wrong level" sounds pretty serious.

First the general comments/questions:

#
#1. It's done at the wrong level: suspend "device" is actually a target
#function.  There's no way on a multi-lun device we want to keep the
#flags and last_busy anywhere but in the target

So... if there's one device with Lun0==cdrom1 and Lun1==cdrom2, it is a
single target, and we want to keep flags/last busy common to all that?

What is good data structure to add? I see scsi_tgt*.h, but it is very
short, and there does not seem to be good structure to hook into.

#2. As you say in the comment, the thing we're trying to power down is
#the link.  In most SCSI implementations, the link has a rather complex
#relationship to the target, what we want to do in
#periodic_autosuspend_scan() is run over the devices on each link, and
#if
#they're not busy suspend the link?  What's probably needed is a set of
#adjunct helpers for the transport classes to do this.

So the host suspend/resume stuff should go into struct
scsi_transport_template?

#3. The link power down is much faster than device spin down ... in
#your
#patch these two things seem to be coupled ... we really need to keep
#them separate.
#

ACK.

#4. The entanglement with error handling is incredibly problematic
#(since
#eh is a nastily complex state machine in its own right).  What do
#transports that use eh_strategy_handler do about all of this?

/me scared...
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
