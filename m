From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Power management for SCSI
Date: Fri, 22 Aug 2008 18:14:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808221810060.9561-100000@netrider.rowland.org>
References: <20080822105246.GB3482@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757218AbYHVWPF@vger.kernel.org>
In-Reply-To: <20080822105246.GB3482@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Oliver Neukum <oneukum@suse.de>, linux-pm@lists.linux-foundation.org, James.Bottomley@hansenpartnership.com, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

On Fri, 22 Aug 2008, Pavel Machek wrote:

> Hi!
> 
> > > - suspending has side effects
> > 
> > I'm not sure what you mean by that.  Suspension always has side effects 
> > of one kind or another.
> > 
> > > Suspension in USB has always side effects. That's not true for other
> > > subsystems.
> > 
> > Name one.  At the very least, suspending a device means you can't use
> > it again without first calling the driver's resume method.  That's a 
> > side effect.
> 
> IDE, actually. I don't think it is relevant, but you can do hdparm -y,
> and it will automatically spin up when you try to talk to it next
> time.

It's a matter of definitions...  "hdparm -y" doesn't call the driver's 
suspend method, so in some sense it isn't truly a suspend.

But it's true that some systems can power down more or less
transparently (with restart latency as the only visible side effect).

Alan Stern
