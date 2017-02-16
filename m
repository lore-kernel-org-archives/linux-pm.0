From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in next with use printk_safe buffers in printk
Date: Thu, 16 Feb 2017 07:10:09 -0800
Message-ID: <20170216151009.GS21809@atomide.com>
References: <20170213185956.GM3897@atomide.com>
 <20170214160140.GA401@tigerII.localdomain>
 <20170215180158.GO21809@atomide.com>
 <20170216013109.GA772@jagdpanzerIV.localdomain>
 <20170216040335.GR21809@atomide.com>
 <20170216042500.GC772@jagdpanzerIV.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170216042500.GC772@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Russell King <rmk@armlinux.org.uk>
List-Id: linux-pm@vger.kernel.org

* Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> [170215 20:26]:
> On (02/15/17 20:03), Tony Lindgren wrote:
> > * Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> [170215 17:32]:
> > > On (02/15/17 10:01), Tony Lindgren wrote:
> > > [..]
> > > > Below is another issue I noticed caused by commit f975237b7682 that
> > > > I noticed during booting.
> > > 
> > > do you mean that with f975237b7682 you _always_ see that illegal RCU
> > > usage warning?
> > 
> > Yeah on every boot on devices using cpuidle_coupled.
> 
> does this mean that with the printk-safe patches reverted
> (so, basically, the same conditions module 4 printk patches)
> you don't see illegal RCU usage reports? at the moment I can't
> see any connection between f975237b7682 and RCU usage from idle CPU.

Yes reverting those four patches I listed earlier also makes it go
away.

Regards,

Tony
