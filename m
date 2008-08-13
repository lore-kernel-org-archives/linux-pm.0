From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Power management for SCSI
Date: Wed, 13 Aug 2008 15:37:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808131534440.13982-100000@iolanthe.rowland.org>
References: <200808131825.27303.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757956AbYHMThn@vger.kernel.org>
In-Reply-To: <200808131825.27303.oneukum@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, James.Bottomley@hansenpartnership.com, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Aug 2008, Oliver Neukum wrote:

> > In Alan's patch, SCSI calls scsi_host_template methods (if the LLD
> > provides ones) to suspend and resume a Scsi_Host.  The LLD can use them
> > to work with the underlying infrastructure to determine what can be done
> > at that time.  I.e. are there other protocols or other initiator-like
> > nodes sharing the link?  If yes or if "maybe yes", the infrastructure
> > keeps the link up.  If not, it can move it into a low-power state.
> 
> That is a parculiar way of viewing it. Alan's patch introduce runtime
> pm attributes to the devices. Quoting:
> 
> 
> +/**
> + * scsi_suspend_sdev - suspend a SCSI device
> + * @sdev: the scsi_device to suspend
> + * @msg: Power Management message describing this state transition
> + *
> + * SCSI devices can't actually be suspended in a literal sense,
> + * because SCSI doesn't have any notion of power management.  Instead
> + * this routine drains the request queue and calls the ULD's suspend
> + * method to flush caches, spin-down drives, and so on.
> + *
> + * If the suspend succeeds, we call scsi_autosuspend_host to decrement
> + * the host's count of unsuspended devices and invoke the LLD's suspend
> + * method.
> 
> So you cannot operate on the link independent from the devices.

With the original patch, you can't operate on the link independent from 
the devices.  But with the revised patch (whenever I manage to find 
time to write it!), you _will_ be able to.

Alan Stern
