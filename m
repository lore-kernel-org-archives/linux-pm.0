From: Oliver Neukum <oneukum@suse.de>
Subject: Re: Power management for SCSI
Date: Wed, 13 Aug 2008 17:21:41 +0200
Message-ID: <200808131721.42721.oneukum@suse.de>
References: <Pine.LNX.4.44L0.0808131051330.2455-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756034AbYHMPUv@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0808131051330.2455-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, James.Bottomley@hansenpartnership.com, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

Am Mittwoch 13 August 2008 16:59:23 schrieb Alan Stern:
> On Wed, 13 Aug 2008, Oliver Neukum wrote:
> 
> > Very well. I see a basic problem here. For USB it is necessary that child
> > devices be suspended before anything higher up in the tree is suspended.
> > SATA seems to be able to power down a link while the device is not suspended.
> 
> Is the USB transport unique in its requirement that all the child
> devices must be suspended before the link can be powered down?  Maybe

All children that are USB must be powered down. We know in fact that most
drives don't care that the device is suspended. The problem was drive
enclosures that cut power upon suspension losing cached data.

> that requirement should be made an explicit property of the transport 
> or the transport class.
> 
> > In fact in true SCSI busses can be shared. So are we using the correct
> > approach?
> 
> This is a good question.  Most USB mass-storage devices do not act as a
> true SCSI bus, but I believe there are a few non-standard ones that do
> -- the USB device really contains a SCSI host and arbitrary SCSI
> targets can be attached to it.  For the moment, we should be safe
> enough using a model in which there are no other initiators on a
> USB-type SCSI transport, but it's something to keep in mind.

So do we really want to do autosuspend on the device level? Or do we work
on hosts and just use the suspend()/resume() support of the sd, sr, ... etc?

	Regards
		Oliver
