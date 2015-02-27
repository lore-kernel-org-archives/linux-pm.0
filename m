From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 5/7] thermal: add trace events to the power allocator
 governor
Date: Thu, 26 Feb 2015 19:09:05 -0500
Message-ID: <20150226190905.4482061f@gandalf.local.home>
References: <1424977233-15965-1-git-send-email-javi.merino@arm.com>
	<1424977233-15965-6-git-send-email-javi.merino@arm.com>
	<20150226143845.67e00224@gandalf.local.home>
	<20150226194633.GC4941@developer.amazonguestwifi.org>
	<20150226175259.57d65960@gandalf.local.home>
	<20150226211823.GA29288@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0059.hostedemail.com ([216.40.44.59]:41021 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753643AbbB0AJI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 19:09:08 -0500
In-Reply-To: <20150226211823.GA29288@developer.amazonguestwifi.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Javi Merino <javi.merino@arm.com>, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, broonie@kernel.org, tixy@linaro.org, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>

On Thu, 26 Feb 2015 17:18:25 -0400
Eduardo Valentin <edubezval@gmail.com> wrote:

> Steve,
> 
> On Thu, Feb 26, 2015 at 05:52:59PM -0500, Steven Rostedt wrote:
> > On Thu, 26 Feb 2015 15:46:34 -0400
> > Eduardo Valentin <edubezval@gmail.com> wrote:
> > 
> >  
> > > I am planing to apply this series to my thermal soc tree. Do you have
> > > any concerns if I send this patch, which touches the tracing files, via
> > > my tree?
> > > 
> > 
> > Which tracing files?
> 
> I am referring to:
> include/trace/events/thermal.h                 | 58 +++++++++++++++++
> include/trace/events/thermal_power_allocator.h | 87
> ++++++++++++++++++++++++++
> 
> I know they are new files anyway, but just checking if those can go
> altogether via the thermal tree.

The individual files in include/trace/events belong more to the
maintainers of where the tracepoints are located. I just monitor them
to make sure they are not too whacky ;-)

Feel free to incorporate them in your tree.

If you want...

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
