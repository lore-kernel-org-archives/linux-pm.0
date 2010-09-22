From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Wed, 22 Sep 2010 20:26:40 +0200
Message-ID: <1285180000.2275.1036.camel__48899.4048363113$1285180180$gmane$org@laptop>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
	<201009171736.14170.trenn@suse.de>	<20100917162412.GB3341@elte.hu>
	<201009180026.59482.trenn@suse.de>
	<AANLkTimMAr9kEzybFGai3qGyXx36v055iPpXq_C1vW8C@mail.gmail.com>
	<4C9A21AD.1000800@linux.intel.com>
	<AANLkTim6B+Je=LykgJb9=0vK5Br1rkft619BRJkBcHdP@mail.gmail.com>
	<4C9A2FB3.105@linux.intel.com> <1285173835.2275.1026.camel@laptop>
	<4C9A37AE.2010509@linux.intel.com> <1285176629.2275.1033.camel@laptop>
	<1285179355.26872.27.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285179355.26872.27.camel@gandalf.stny.rr.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Len Brown <len.brown@intel.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2010-09-22 at 14:15 -0400, Steven Rostedt wrote:
> On Wed, 2010-09-22 at 19:30 +0200, Peter Zijlstra wrote:
> > On Wed, 2010-09-22 at 10:06 -0700, Arjan van de Ven wrote:
> > 
> 
> > That said, I really didn't read this discussion much, but your stance
> > seems to be that any tracepoint you use must stay valid, and I object to
> > that.
> 
> We could add a TRACE_EVENT_ABI() as Ingo has been suggesting. If
> anything, it could mean that the given tracepoint will always have the
> same name. And perhaps the data it holds will always be there, but may
> also be extended.

I still don't see why you need TRACE_EVENT_ABI for that, if its the same
name and the format can be extended you get the same results with what
we've got. Apps need to read/parse the format thing anyway.

> > 
> > What will do you do when we include a new scheduling policy and all the
> > scheduler tracepoints need to change? (yes that's really going to
> > happen)
> 
> The tracepoint sched_switch should stay the same. We may add more data,
> but the comm, pid, prio => comm, pid, prio, I don't see going away.

Right, it would need additional fields. Preferably not only at the end.

> > I'm not going to carry double tracepoints, and I'm not going to not
> > merge that policy. 
> 
> Not sure what you mean by "double tracepoints"

Two different tracepoints in the same location.
