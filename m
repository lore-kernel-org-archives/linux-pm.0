From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM: trace events for suspend/resume
Date: Fri, 23 May 2014 01:06:32 +0200
Message-ID: <1707167.dvsBe2mo72@vostro.rjw.lan>
References: <20140519230226.GA14382@linux.intel.com> <20140522170734.GA11104@linux.intel.com> <1400798505.26671.9.camel@pippen.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61834 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751145AbaEVWte (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 May 2014 18:49:34 -0400
In-Reply-To: <1400798505.26671.9.camel@pippen.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: todd.e.brandt@linux.intel.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com

On Thursday, May 22, 2014 06:41:45 PM Steven Rostedt wrote:
> On Thu, 2014-05-22 at 10:07 -0700, Todd E Brandt wrote:
> >  
> > > >  #include <asm/io.h>
> > > >  #include <asm/uaccess.h>
> > > > @@ -835,7 +836,9 @@ acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
> > > >  
> > > >  void acpi_os_sleep(u64 ms)
> > > >  {
> > > > +	trace_suspend_resume("acpi_os_sleep", true);
> > > >  	msleep(ms);
> > > > +	trace_suspend_resume("acpi_os_sleep", false);
> > > >  }
> > > 
> > > This function doesn't have anything to do with system suspend/resume.
> > > It is for waiting. :-)
> > 
> > Yea but it really helps you diagnose bad firmware during suspend/resume
> > (for instance when there's just an arbitrary sleep 100ms in the ACPI code).
> > But it doesn't matter for general performance testing, I'll remove it on v2
> > submit.
> > 
> > > 
> > > The rest of the patch looks OK to me.
> > > 
> > > Steven, what about the tracing angle?
> 
> It should be under an ACPI system (if there is one). Looks rather silly
> to call it for suspend.

I meant the rest of the patch, not this particular hunk. :-)

Rafael

