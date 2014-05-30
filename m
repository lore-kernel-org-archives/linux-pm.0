From: Todd E Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [PATCH] PM: trace events for suspend/resume
Date: Fri, 30 May 2014 07:49:25 -0700
Message-ID: <20140530144925.GA26573@linux.intel.com>
References: <20140519230226.GA14382@linux.intel.com>
 <20140522170734.GA11104@linux.intel.com>
 <1400798505.26671.9.camel@pippen.local.home>
 <1707167.dvsBe2mo72@vostro.rjw.lan>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30428 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755035AbaE3OtZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 30 May 2014 10:49:25 -0400
Content-Disposition: inline
In-Reply-To: <1707167.dvsBe2mo72@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com

Hi guys, I'm not hearing any objections to revamping the machine_suspend trace
event, so I'll resubmit a patch with it removed and supplanted with the
new suspend_resume event. I've also discovered that this first patch doesn't
completely cover freeze, so I'm moving a couple of the calls around.

On Fri, May 23, 2014 at 01:06:32AM +0200, Rafael J. Wysocki wrote:
> On Thursday, May 22, 2014 06:41:45 PM Steven Rostedt wrote:
> > On Thu, 2014-05-22 at 10:07 -0700, Todd E Brandt wrote:
> > >  
> > > > >  #include <asm/io.h>
> > > > >  #include <asm/uaccess.h>
> > > > > @@ -835,7 +836,9 @@ acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
> > > > >  
> > > > >  void acpi_os_sleep(u64 ms)
> > > > >  {
> > > > > +	trace_suspend_resume("acpi_os_sleep", true);
> > > > >  	msleep(ms);
> > > > > +	trace_suspend_resume("acpi_os_sleep", false);
> > > > >  }
> > > > 
> > > > This function doesn't have anything to do with system suspend/resume.
> > > > It is for waiting. :-)
> > > 
> > > Yea but it really helps you diagnose bad firmware during suspend/resume
> > > (for instance when there's just an arbitrary sleep 100ms in the ACPI code).
> > > But it doesn't matter for general performance testing, I'll remove it on v2
> > > submit.
> > > 
> > > > 
> > > > The rest of the patch looks OK to me.
> > > > 
> > > > Steven, what about the tracing angle?
> > 
> > It should be under an ACPI system (if there is one). Looks rather silly
> > to call it for suspend.
> 
> I meant the rest of the patch, not this particular hunk. :-)
> 
> Rafael
> 
