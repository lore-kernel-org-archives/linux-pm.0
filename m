From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] Power management for SCSI
Date: Fri, 22 Aug 2008 12:52:46 +0200
Message-ID: <20080822105246.GB3482@elf.ucw.cz>
References: <200808191533.15244.oneukum@suse.de> <Pine.LNX.4.44L0.0808191108440.2669-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757910AbYHVUZk@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0808191108440.2669-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.de>, linux-pm@lists.linux-foundation.org, James.Bottomley@hansenpartnership.com, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

Hi!

> > - suspending has side effects
> 
> I'm not sure what you mean by that.  Suspension always has side effects 
> of one kind or another.
> 
> > Suspension in USB has always side effects. That's not true for other
> > subsystems.
> 
> Name one.  At the very least, suspending a device means you can't use
> it again without first calling the driver's resume method.  That's a 
> side effect.

IDE, actually. I don't think it is relevant, but you can do hdparm -y,
and it will automatically spin up when you try to talk to it next
time.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
