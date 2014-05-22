From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] PM: trace events for suspend/resume
Date: Thu, 22 May 2014 18:44:29 -0400
Message-ID: <1400798669.26671.12.camel@pippen.local.home>
References: <20140519230226.GA14382@linux.intel.com>
	 <2794431.xZpr01emRq@vostro.rjw.lan> <537E7756.1000503@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:52413 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751145AbaEVWof (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 May 2014 18:44:35 -0400
In-Reply-To: <537E7756.1000503@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, todd.e.brandt@linux.intel.com, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com

On Fri, 2014-05-23 at 03:46 +0530, Srivatsa S. Bhat wrote:
> Hi Todd,
> 
> This might be a silly question, but the suspend_enter() function invokes
> ftrace_stop() before suspending the machine, and restarts ftrace after
> resume. And your patch seems to instrument code further down (deeper)
> in the suspend/resume path (such as disable_nonboot_cpus() for example).
> Doesn't the ftrace stop/start pose any problem for this patch?

ftrace_start/stop() only affects the function tracer and not the
tracepoints. Those will still be recorded.

Note, we have an invested interest in getting rid of
ftrace_stop/start(). I rather mark all the suspend code with notrace or
find another method to protect suspend from function tracing. The
ftrace_stop/start() was more of a big hammer approach and I had plans
for getting rid of it in the future. That future is approaching fast :-)

-- Steve


