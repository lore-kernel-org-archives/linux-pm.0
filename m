From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] PM: trace events for suspend/resume
Date: Fri, 30 May 2014 23:07:45 -0400
Message-ID: <20140530230745.7388be84@gandalf.local.home>
References: <20140531015247.GA27737@linux.intel.com>
	<20140530223349.5f33b0fd@gandalf.local.home>
	<20140531025852.GA24238@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:47429 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755729AbaEaDHr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 May 2014 23:07:47 -0400
In-Reply-To: <20140531025852.GA24238@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: todd.e.brandt@linux.intel.com
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net

On Fri, 30 May 2014 19:58:52 -0700
Todd E Brandt <todd.e.brandt@linux.intel.com> wrote:


> > This will export the strings into debugfs/tracing/printk_formats so
> > that the pointer can be mapped to a string.
> 
> ahh, ok, yea if there's some performance impact of using tracepoints this
> way then I'll definately change that, thanks for the example.

It speeds up the tracing and compacts it a bit. It has no affect when
tracing is disabled.

> 
> > 
> > This is assuming that all of these calls are in core kernel code and
> > not in modules. Are they?
> 
> No these are all core code. I double-checked all the Kconfigs to make
> sure none of those files are configured by tristate options, they're
> all bool. I also test ran a few compiles with CONFIG_PM disabled just
> to be sure that nothing broke in kernel/cpu.c and all was well.

After checking, it didn't really matter if they were used by modules or
not. Just that their strings were all constants.
 
> > Here you would have:
> > 
> > 	TP_printk("%s[%u] %s", entry->action,
> > 
> > You just need to add that TPS() around all strings where it is passed
> > to the tracepoint and it will still work with trace-cmd and perf.
> 
> Is is legal to pass a format string to a tracepoint which then gets fed
> into TP_printk? i.e.
> 
> TP_printk(__get_str(fmtstring), __entry->val)
> 
> I didn't do that since I couldn't find a single example of that in the other
> trace events, but theoretically it should be safe.

Hmm, was there an example where you wanted that? That's not what I was
suggesting. It may work for a tracepoint, but it will definitely screw
up trace-cmd and perf.

-- Steve

