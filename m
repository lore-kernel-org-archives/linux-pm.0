From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Sun, 10 Oct 2010 08:41:21 +0200
Message-ID: <1286692881.1998.10.camel__39886.8870609023$1286692966$gmane$org@laptop>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
	<AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	<20101007155816.GA5351@nowhere> <4CAED2F0.9080801@kernel.org>
	<20101008083819.GA22385@elte.hu> <4CAF19E7.3070103@linux.intel.com>
	<20101008134156.GA28724@Krystal> <20101009062836.GB5517@elte.hu>
	<AANLkTik6nO4i6xTuVYA9kBGFNpxYb70qimNcHPQKqTJ8@mail.gmail.com>
	<AANLkTimT5Or7gLDMnmLqSzmUoPux0pXrPxUZQpFon+6_@mail.gmail.com>
	<1286658935.23994.3366.camel@gandalf.stny.rr.com>
	<AANLkTik8BocxyidcdmWMh2FV2LoEo_HGYGwaawasRH-O@mail.gmail.com>
	<1286674768.23994.3915.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1286674768.23994.3915.camel@gandalf.stny.rr.com>
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
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Pierre Tardy <tardyp@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jean Pihet <jean.pihet@newoldbits.com>, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org, Frank Eigler <fche@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Sat, 2010-10-09 at 21:39 -0400, Steven Rostedt wrote:
> I've been hesitant in the pass from doing the TRACE_EVENT_ABI()
> before, because Peter Zijlstra (who is currently MIA) has been strongly
> against it. 

I see no point in the TRACE_EVENT_ABI() because if I need to change such
a tracepoint to reflect changes in the kernel then I will freely do so.

Even seemingly stable points like sched_switch(), which we all agree
will stay around forever (gotta have context switches on a multi-tasking
OS) will not stay stable when we add/change scheduling policies.

Sure, the prev and next task thing will stay the same, but the meaning
and interpretation of things like the prio field will not, esp when we
go add something like a deadline scheduler that isn't priority based.

So one possibility is to simply remove all that information from the
tracepoints, remove the prio and state fields, but how useful is that?

I guess what I'm saying is that even if we were to provide _ABI I see us
getting into this very same argument over and over again, making me want
to remove all this trace event muck right now before it gets worse.
