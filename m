From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] PM: trace events for suspend/resume
Date: Thu, 22 May 2014 18:41:45 -0400
Message-ID: <1400798505.26671.9.camel@pippen.local.home>
References: <20140519230226.GA14382@linux.intel.com>
	 <2794431.xZpr01emRq@vostro.rjw.lan>
	 <20140522170734.GA11104@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:44610 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750923AbaEVWlw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 May 2014 18:41:52 -0400
In-Reply-To: <20140522170734.GA11104@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: todd.e.brandt@linux.intel.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com

On Thu, 2014-05-22 at 10:07 -0700, Todd E Brandt wrote:
>  
> > >  #include <asm/io.h>
> > >  #include <asm/uaccess.h>
> > > @@ -835,7 +836,9 @@ acpi_status acpi_os_remove_interrupt_handler(u32 irq, acpi_osd_handler handler)
> > >  
> > >  void acpi_os_sleep(u64 ms)
> > >  {
> > > +	trace_suspend_resume("acpi_os_sleep", true);
> > >  	msleep(ms);
> > > +	trace_suspend_resume("acpi_os_sleep", false);
> > >  }
> > 
> > This function doesn't have anything to do with system suspend/resume.
> > It is for waiting. :-)
> 
> Yea but it really helps you diagnose bad firmware during suspend/resume
> (for instance when there's just an arbitrary sleep 100ms in the ACPI code).
> But it doesn't matter for general performance testing, I'll remove it on v2
> submit.
> 
> > 
> > The rest of the patch looks OK to me.
> > 
> > Steven, what about the tracing angle?

It should be under an ACPI system (if there is one). Looks rather silly
to call it for suspend.

-- Steve

