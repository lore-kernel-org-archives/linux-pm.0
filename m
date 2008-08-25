From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [linux-pm] Power management for SCSI
Date: Mon, 25 Aug 2008 19:34:02 +0200
Message-ID: <200808251934.03569.oneukum@suse.de>
References: <Pine.LNX.4.44L0.0808251152030.6639-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755317AbYHYRdK@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0808251152030.6639-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, James.Bottomley@hansenpartnership.com, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

Am Montag 25 August 2008 18:18:19 schrieb Alan Stern:
> On Mon, 25 Aug 2008, Oliver Neukum wrote:

> > There's some truth to that. Unfortunately the transport does not know
> > whether a device or link may be suspended. Take the case of a CD playing
> > sound. The transport may know what the consequences of suspending
> > a link will be to the devices, but only the devices know whether the
> > consequences are acceptable.
> 
> Even the device (or more properly, the driver) might not know!  In your
> example the driver might realize that playing had been started, but it
> probably wouldn't know when the playing had ended.

There is that possibility.

> That's not true at all.  Maybe the name is specific to USB, but the
> concept isn't.  Notice how we have power/wakeup files in the sysfs
> directory for every device, even non-USB devices?  Requesting a
> low-power to high-power transition is a generic operation.

True. Let's say that we have to deal with busses incapable of supporting it.
 
> > If you are writing for
> > a generic system the question is indeed whether devices may want
> > to talk to the host and whether they can.
> > It seems to me that the ULD will know whether its devices will need
> > to talk to the CPU.
> 
> In general, the link or transport class will know whether it is 
> possible for a device to initiate communication with the CPU.  If it is

Yes.
 
> possible then the link would probably want to have remote wakeup 
> enabled before autosuspending, even if none of the devices currently 
> attached actually wants to use it.

That supposes it doesn't matter in terms of power use. Is that true?

> So sd.c might, in theory, want to respond in two different ways to an 
> autosuspend request:
> 
> 	(A) Drain the cache,
> 
> 	(B) Drain the cache and spin down the drive.

(C) Do nothing

(D) Refuse (i.e. the user has opened a block device and used a vendor
specific command)

> How does it know which to do?  Ask the transport class for help 
> choosing?

I see no other way.

> (A) would leave us in an awkward "half-suspended" state.  Is the device
> suspended or not?  It is, in the sense that now the link can safely be
> suspended.  But it isn't, in the sense that a system sleep would still
> require the drive to be spun down.
> 
> It's kind of like the state we have following a PMSG_FREEZE --
> quiescent but not suspended.  Somehow this extra state needs to be
> incorporated into the autosuspend framework.

Why? Unless the device can be skipped for purposes of autosuspend and
system sleep, isn't it active?

	Regards
		Oliver
