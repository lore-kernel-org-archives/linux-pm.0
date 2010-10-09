From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Sat, 09 Oct 2010 17:34:58 -0400
Message-ID: <1286660098.23994.3413.camel__47152.8898030103$1286660247$gmane$org@gandalf.stny.rr.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
	<AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	<20101007155816.GA5351@nowhere> <4CAED2F0.9080801@kernel.org>
	<20101008083819.GA22385@elte.hu> <4CAF19E7.3070103@linux.intel.com>
	<20101008134156.GA28724@Krystal> <20101009062836.GB5517@elte.hu>
	<4CB095FA.8060803@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4CB095FA.8060803@linux.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Weisbecker <fweisbec@gmail.com>, Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frederic@smtp1.linux-foundation.org, Masami@smtp1.linux-foundation.org, Peter Zijlstra <peterz@infradead.org>, Frank Eigler <fche@redhat.com>, linux-pm@lists.linux-foundation.org, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas@smtp1.linux-foundation.org, Pierre Tardy <tardyp@gmail.com>, Torvalds <torvalds@linux-foundation.org>, linux-perf-users@vger.kernel.org, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2010-10-09 at 09:19 -0700, Arjan van de Ven wrote:

> > I.e. it's not an ABI in the classic sense - we do not (because we
> > cannot) guarantee the infinite availability of these events. But we can
> > guarantee that the fields do not change in some stupid, avoidable way.
> 
> also I have to say that some events are more likely to change than others
> 
> "function foo in the kernel called" is more likely to change than "the 
> processor went to THIS frequency".
> The concept of CPU frequencies has been with us fora long time and is 
> going to be there for a long time as well ......

Perhaps for basic concepts, we need a standard trace-event. Are people
willing to have a TRACE_EVENT_ABI() (it's trivial to write), and we can
mark those events with that macro that we know tools depend on.

These events can be exposed in a /sys/kernel/events/... directory, to
let tools know what what events they can rely on.

We've talked about doing this before, I've just been waiting to hear a
consensus on if we should. I know Peter Zijlstra was against the idea,
and too bad he's off gallivanting to share his input now.

-- Steve
 
