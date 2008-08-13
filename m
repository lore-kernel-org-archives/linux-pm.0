From: Oliver Neukum <oneukum@suse.de>
Subject: Re: Power management for SCSI
Date: Wed, 13 Aug 2008 16:47:42 +0200
Message-ID: <200808131647.43989.oneukum@suse.de>
References: <Pine.LNX.4.44L0.0808131026320.2455-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755614AbYHMOqx@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0808131026320.2455-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, James.Bottomley@hansenpartnership.com, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

Am Mittwoch 13 August 2008 16:31:03 schrieb Alan Stern:
> On Wed, 13 Aug 2008, Pavel Machek wrote:
> 
> > From: Alan Stern <stern@rowland.harvard.edu>
> > 
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

Very well. I see a basic problem here. For USB it is necessary that child
devices be suspended before anything higher up in the tree is suspended.
SATA seems to be able to power down a link while the device is not suspended.

In fact in true SCSI busses can be shared. So are we using the correct
approach?

	Regards
		Oliver
