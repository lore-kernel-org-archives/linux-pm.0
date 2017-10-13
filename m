From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] tracing: Remove unused clock events
Date: Fri, 13 Oct 2017 10:25:53 -0400
Message-ID: <20171013102553.4e954f27@gandalf.local.home>
References: <20171012124446.4a4fb056@gandalf.local.home>
        <CAORVsuU+12OEH4LFePORWHh3Ryfj-2cc8Kb6U-dQo4HQUXSJAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753466AbdJMOZ5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 13 Oct 2017 10:25:57 -0400
In-Reply-To: <CAORVsuU+12OEH4LFePORWHh3Ryfj-2cc8Kb6U-dQo4HQUXSJAA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: LKML <linux-kernel@vger.kernel.org>, discuss@lesswatts.org, Linux PM list <linux-pm@vger.kernel.org>, Thomas Renninger <trenn@suse.de>, Arjan van de Ven <arjan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Ingo Molnar <mingo@kernel.org>

On Fri, 13 Oct 2017 09:20:44 +0200
Jean Pihet <jean.pihet@newoldbits.com> wrote:

> Hi Steven,
> 
> On Thu, Oct 12, 2017 at 6:44 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > [ Resending again, including linux-pm@vger.kernel.org this time ]
> >
> > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >
> > Commit 74704ac6 ("tracing, perf: Add more power related events") added
> > new events, among them were trace_clock_enable, trace_clock_disable and
> > trace_clock_set_rate. In the last 7 years, nothing has used them. As
> > they take up space, and nobody cares about these events, remove them.  
> 
> Ok if it is not used. Can others confirm?
> 
> AFAIK this has been used internally.

If it has been used internally, then the events should be defined
internally. The trace event hooks are not there, there's no reason to
define events were hooks are not present. There's no advantage for
keeping them in the kernel proper.

-- Steve
