From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: Re: [BUG] function_graph trace causes  hang when using sleepgraph
 (4.15.0-rc1 and newer)
Date: Mon, 08 Jan 2018 17:25:15 -0800
Message-ID: <1515461115.17761.12.camel@linux.intel.com>
References: <1515455714.17761.7.camel@linux.intel.com>
         <1515459749.17761.10.camel@linux.intel.com>
         <20180108200756.08712bb4@vmware.local.home>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:8719 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751761AbeAIBZR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jan 2018 20:25:17 -0500
In-Reply-To: <20180108200756.08712bb4@vmware.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, len.brown@intel.com, todd.e.brandt@intel.com

On Mon, 2018-01-08 at 20:07 -0500, Steven Rostedt wrote:
> On Mon, 08 Jan 2018 17:02:29 -0800
> Todd Brandt <todd.e.brandt@linux.intel.com> wrote:
> 
> > Stephen, the problem is reversed by removing the following two
> > commits,
> > the one the bisect showed and the very next. So the problem is
> > here:
> > 
> > commit 1a149d7d3f45d311da1f63473736c05f30ae8a75
> > Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Date:   Fri Sep 22 16:59:02 2017 -0400
> > 
> >     ring-buffer: Rewrite trace_recursive_(un)lock() to be simpler
> 
> This one still doesn't make sense, for why it would cause the hang.
> 
> 
> > commit 12ecef0cb12102d8c034770173d2d1363cb97d52
> > Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Date:   Thu Sep 21 16:22:49 2017 -0400
> > 
> >     tracing: Reverse the order of trace_types_lock and event_mutex
> 
> This one does.
> 
> Can you run lockdep when you do this and see if lockdep catches
> anything? If it does, it should point directly to where the inversed
> locking happened.

Can you reproduce the issue there? I just want to be sure it's not
something local to our machines here, as long as you have CONFIG_PM
enabled it should work the same hopefully. 

I'll give lockdep a try here.

> 
> -- Steve
