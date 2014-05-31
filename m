From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] PM: trace events for suspend/resume
Date: Fri, 30 May 2014 22:36:50 -0400
Message-ID: <20140530223650.62ca8471@gandalf.local.home>
References: <20140531015247.GA27737@linux.intel.com>
	<20140530223349.5f33b0fd@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:38762 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755639AbaEaCgw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 May 2014 22:36:52 -0400
In-Reply-To: <20140530223349.5f33b0fd@gandalf.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: todd.e.brandt@linux.intel.com
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net

On Fri, 30 May 2014 22:33:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> This is assuming that all of these calls are in core kernel code and
> not in modules. Are they?
> 

Reading my comment I wrote about tracepoint_string(), it's OK to be
used even with modules. As long as the strings don't change while the
module is loaded (seems to be the case for all strings here).

-- Steve

