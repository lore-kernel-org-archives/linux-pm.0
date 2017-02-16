From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: Regression in next with use printk_safe buffers in printk
Date: Thu, 16 Feb 2017 13:25:00 +0900
Message-ID: <20170216042500.GC772@jagdpanzerIV.localdomain>
References: <20170213185956.GM3897@atomide.com>
 <20170214160140.GA401@tigerII.localdomain>
 <20170215180158.GO21809@atomide.com>
 <20170216013109.GA772@jagdpanzerIV.localdomain>
 <20170216040335.GR21809@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35629 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751635AbdBPEYl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Feb 2017 23:24:41 -0500
Content-Disposition: inline
In-Reply-To: <20170216040335.GR21809@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Russell King <rmk@armlinux.org.uk>

On (02/15/17 20:03), Tony Lindgren wrote:
> * Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> [170215 17:32]:
> > On (02/15/17 10:01), Tony Lindgren wrote:
> > [..]
> > > Below is another issue I noticed caused by commit f975237b7682 that
> > > I noticed during booting.
> > 
> > do you mean that with f975237b7682 you _always_ see that illegal RCU
> > usage warning?
> 
> Yeah on every boot on devices using cpuidle_coupled.

does this mean that with the printk-safe patches reverted
(so, basically, the same conditions module 4 printk patches)
you don't see illegal RCU usage reports? at the moment I can't
see any connection between f975237b7682 and RCU usage from idle CPU.

[..]

> > ---
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 7180088cbb23..34da86e73d00 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -1563,7 +1563,7 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
> >  {
> >  	struct console *con;
> >  
> > -	trace_console(text, len);
> > +	trace_console_rcuidle(text, len);
> >  
> >  	if (!console_drivers)
> >  		return;
> > 
> > ---
> > 
> > 
> > I need to look more at this.
> 
> That fixes it for me thanks, so feel free to add:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>

thanks.

	-ss
