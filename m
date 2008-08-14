From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Power management for SCSI
Date: Thu, 14 Aug 2008 11:47:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808141141570.2846-100000@iolanthe.rowland.org>
References: <200808141608.13431.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755856AbYHNPrT@vger.kernel.org>
In-Reply-To: <200808141608.13431.oneukum@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, James.Bottomley@hansenpartnership.com, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

On Thu, 14 Aug 2008, Oliver Neukum wrote:

> > > You could even argue that these storage devices violate the USB spec.
> > 
> > Hmm... but suspended devices have very little power budget, right?
> > 
> > So unless you have external power supply (2.5" frames generally
> > don't), you can't really suspend and stay spinned up...
> > 
> 
> True, but the spec says that no state shall be lost.

What can we do?...  Real world devices don't always obey the spec.

You could argue that the suspend current should be sufficient to 
maintain the contents of the cache, which would then be written out 
after resume.  But even if that is true, it's a very fragile guarantee 
to rely on.

> I don't really argue against flushing the caches. But I cannot that this would
> demand that we should implement autopsuspend for SCSI. It seems like
> overengineering to me.

Think of it in two parts: idle-timeout detection and autosuspend.  
Presumably you don't object to the idle-timeout detection (which is 
needed for powering down links in general), and you don't argue against 
the cache-flushing part of autosuspend.  Taken together, that's about 
90% of my proposal.  So what is the objectionable 10%?

Alan Stern
