From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Power management for SCSI
Date: Wed, 13 Aug 2008 12:23:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808131222570.2308-100000@iolanthe.rowland.org>
References: <48A30864.2030106@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755815AbYHMQX7@vger.kernel.org>
In-Reply-To: <48A30864.2030106@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Oliver Neukum <oneukum@suse.de>, Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, James.Bottomley@hansenpartnership.com, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Aug 2008, Stefan Richter wrote:

> > For transports which are like USB, we should do autosuspend at the
> > target (not device) level.  This means invoking the suspend/resume 
> > routines of the ULDs like sd and sr.  The transport gets notified when 
> > all of the targets are suspended.  (Or maybe the host driver gets 
> > notified instead; there probably isn't any advantage to using the 
> > transport class here.)
> > 
> > For other transports, we should only do idle-timeout detection.  The
> > transport gets notified when any target has been idle for sufficiently 
> > long, so that it can power down the link.  The ULDs are not involved.
> > 
> > Does that sound okay?
> 
> Minor correction:  The ULD suspend/resume methods necessarily work on
> logical units, not targets.

Yes; I should said that the suspend/resume methods of the ULD for each 
of the target's LUNs gets invoked.

Alan Stern
